package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.*;
import javax.servlet.http.*;

public class SubjectCreateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String subjectName = request.getParameter("subjectName");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO subject(subject_name) VALUES(?)"
            );
            ps.setString(1, subjectName);
            ps.executeUpdate();

            // Redirect back to JSP with success message
            response.sendRedirect(request.getContextPath() + "/jsp/admin/createSubject.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

