package servlet;

import db.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/teacherLogin")
public class TeacherLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Connection con = DBConnection.getConnection();

        if (con == null) {
            res.getWriter().println("Database connection failed!");
            return;
        }

        try {
            PreparedStatement ps = con.prepareStatement(
            		"SELECT id, name FROM teachers WHERE email=? AND password=?"

            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("teacherId", rs.getInt("id"));
                session.setAttribute("teacherName", rs.getString("name"));

                res.sendRedirect("dashboard");
            } else {
                res.sendRedirect("login.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }
}
