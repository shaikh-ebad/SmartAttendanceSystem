package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class StudentCreateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentIdStr = request.getParameter("studentId");
        String name = request.getParameter("name");
        String classIdStr = request.getParameter("classId");

        if (name == null || name.trim().isEmpty() || classIdStr == null) {
            response.sendRedirect("jsp/admin/dashboard.jsp?error=missingData");
            return;
        }

        try {
            int classId = Integer.parseInt(classIdStr);
            int studentId;

            if (studentIdStr == null || studentIdStr.trim().isEmpty()) {
                // Auto-generate student ID if not provided
                studentId = generateStudentId();
            } else {
                studentId = Integer.parseInt(studentIdStr);
            }

            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO student(student_id, name, class_id) VALUES(?,?,?)"
            );
            ps.setInt(1, studentId);
            ps.setString(2, name);
            ps.setInt(3, classId);

            ps.executeUpdate();
            response.sendRedirect("jsp/admin/dashboard.jsp?studentAdded=1");

        } catch (NumberFormatException e) {
            // Invalid number format
            response.sendRedirect("jsp/admin/dashboard.jsp?error=invalidNumber");
        } catch (SQLIntegrityConstraintViolationException e) {
            // Duplicate student_id
            response.sendRedirect("jsp/admin/dashboard.jsp?error=duplicateId");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("jsp/admin/dashboard.jsp?error=1");
        }
    }

    // Example auto-generate student ID (you can improve logic)
    private int generateStudentId() {
        return (int) (Math.random() * 100000); // random ID
    }
}
