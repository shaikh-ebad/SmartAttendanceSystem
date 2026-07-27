package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            String table = role.equals("admin") ? "admin" : "teacher";

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM " + table + " WHERE username=? AND password=?"
            );

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("role", role);
                session.setAttribute("username", username);

                // ✅ VERY IMPORTANT
                if (role.equals("teacher")) {
                    int teacherId = rs.getInt("teacher_id"); // MUST exist in teacher table
                    session.setAttribute("teacherId", teacherId);
                }

                if (role.equals("admin")) {
                    response.sendRedirect("jsp/admin/dashboard.jsp");
                } else {
                    response.sendRedirect("jsp/teacher/dashboard.jsp");
                }

            } else {
                response.sendRedirect("login.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
