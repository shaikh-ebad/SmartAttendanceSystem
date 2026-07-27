package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ClassCreateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String className = request.getParameter("className");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO class(class_name) VALUES(?)"
            );
            ps.setString(1, className);
            ps.executeUpdate();

            response.sendRedirect("jsp/admin/dashboard.jsp?classAdded=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
