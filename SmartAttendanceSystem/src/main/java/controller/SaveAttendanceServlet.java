package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import dao.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/saveAttendance")
public class SaveAttendanceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int timetableId = Integer.parseInt(request.getParameter("timetableId"));
        LocalDate today = LocalDate.now();

        String[] studentIds = request.getParameterValues("studentId");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO attendance (timetable_id, student_id, date, status) "
                    + "VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            for (String sid : studentIds) {

                int studentId = Integer.parseInt(sid);

                String status = request.getParameter("status_" + sid);

                ps.setInt(1, timetableId);
                ps.setInt(2, studentId);
                ps.setDate(3, java.sql.Date.valueOf(today));
                ps.setString(4, status); // Must be 'P' or 'A'

                ps.addBatch();
            }

            ps.executeBatch();

            response.sendRedirect("jsp/teacher/todaySessions.jsp?success=Attendance saved");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}