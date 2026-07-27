package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class HolidayServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String date = request.getParameter("date");
        String desc = request.getParameter("desc");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO holiday(holiday_date, description) VALUES(?, ?)"
            );
            ps.setString(1, date);
            ps.setString(2, desc);
            ps.executeUpdate();

            response.sendRedirect("jsp/admin/dashboard.jsp?holidayAdded=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
