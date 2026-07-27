package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class TeacherCreateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO teacher(name, username, password) VALUES(?,?,?)"
            );
            ps.setString(1, name);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.executeUpdate();

            response.sendRedirect("jsp/admin/dashboard.jsp?teacherAdded=1");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
