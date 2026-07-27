package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String timetableIdParam = request.getParameter("timetableId");
        
        if (timetableIdParam == null || timetableIdParam.isEmpty() || timetableIdParam.equals("null")) {
            response.sendRedirect(request.getContextPath() + "/jsp/teacher/todaySessions.jsp");
            return;
        }

        int timetableId;
        try {
            timetableId = Integer.parseInt(timetableIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/jsp/teacher/todaySessions.jsp");
            return;
        }

        LocalDate today = LocalDate.now();
        Connection con = null;
        PreparedStatement psHoliday = null;
        PreparedStatement psCheck = null;
        ResultSet rsHoliday = null;
        ResultSet rsCheck = null;

        try {
            con = DBConnection.getConnection();

            // Check if holiday
            psHoliday = con.prepareStatement("SELECT * FROM holiday WHERE holiday_date=?");
            psHoliday.setDate(1, Date.valueOf(today));
            rsHoliday = psHoliday.executeQuery();
            
            if (rsHoliday.next()) {
                request.setAttribute("error", "Cannot mark attendance. Today is a holiday: " 
                    + rsHoliday.getString("description"));
                request.getRequestDispatcher("/jsp/teacher/todaySessions.jsp").forward(request, response);
                return;
            }

            // Check if attendance already marked
            psCheck = con.prepareStatement("SELECT * FROM attendance WHERE timetable_id=? AND date=?");
            psCheck.setInt(1, timetableId);
            psCheck.setDate(2, Date.valueOf(today));
            rsCheck = psCheck.executeQuery();
            
            if (rsCheck.next()) {
                request.setAttribute("error", "Attendance already marked for this session.");
                request.getRequestDispatcher("/jsp/teacher/todaySessions.jsp").forward(request, response);
                return;
            }

            // Forward to mark attendance page
            response.sendRedirect(request.getContextPath() + 
                "/jsp/teacher/markAttendance.jsp?timetableId=" + timetableId);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rsHoliday != null) rsHoliday.close();
                if (rsCheck != null) rsCheck.close();
                if (psHoliday != null) psHoliday.close();
                if (psCheck != null) psCheck.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}