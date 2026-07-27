package controller;

import dao.DBConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.Enumeration;

@WebServlet("/submitAttendance")
public class SubmitAttendanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int timetableId = Integer.parseInt(request.getParameter("timetableId"));
        LocalDate today = LocalDate.now();

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO attendance (student_id, timetable_id, date, status) " +
                         "VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            Enumeration<String> params = request.getParameterNames();

            while (params.hasMoreElements()) {
                String param = params.nextElement();

                if (param.startsWith("status_")) {
                    int studentId = Integer.parseInt(param.split("_")[1]);
                    String status = request.getParameter(param);

                    ps.setInt(1, studentId);
                    ps.setInt(2, timetableId);
                    ps.setDate(3, Date.valueOf(today));
                    ps.setString(4, status);
                    ps.addBatch();
                }
            }

            ps.executeBatch();
            ps.close();

            response.sendRedirect(
                request.getContextPath() +
                "/jsp/teacher/welcome.jsp?attendance=success"
            );

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to save attendance");
            request.getRequestDispatcher("/jsp/teacher/markAttendance.jsp")
                   .forward(request, response);
        }
    }
}
