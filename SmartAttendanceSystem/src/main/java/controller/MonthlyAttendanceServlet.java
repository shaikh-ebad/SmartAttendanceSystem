package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/monthlyAttendance")
public class MonthlyAttendanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String,String>> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            int month = Integer.parseInt(request.getParameter("month"));

            String sql =
            "SELECT s.student_id, s.name, a.date, a.status " +
            "FROM attendance a " +
            "JOIN student s ON a.student_id = s.student_id " +
            "WHERE MONTH(a.date)=? " +
            "ORDER BY s.student_id, a.date";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, month);

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Map<String,String> row = new HashMap<>();

                row.put("id", rs.getString("student_id"));
                row.put("name", rs.getString("name"));
                row.put("date", rs.getString("date"));
                row.put("status", rs.getString("status"));

                list.add(row);
            }

            request.setAttribute("data", list);

            RequestDispatcher rd =
            		request.getRequestDispatcher("/jsp/teacher/monthlyAttendance.jsp");

            		rd.forward(request, response);

        } catch(Exception e) {
            e.printStackTrace();
        }
        
    }
}