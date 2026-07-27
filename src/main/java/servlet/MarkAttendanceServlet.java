package servlet; 
 
import db.DBConnection; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import javax.servlet.ServletException; 
import java.io.IOException; 
import java.sql.*; 
 
@WebServlet("/markAttendance") 
public class MarkAttendanceServlet extends HttpServlet { 
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException { 
        String subjectIdStr = req.getParameter("subjectId"); 
        int subjectId = Integer.parseInt(subjectIdStr); 
        String[] studentIds = req.getParameterValues("studentId"); 
        String[] statuses = req.getParameterValues("status"); 
 
        try (Connection con = DBConnection.getConnection()) { 
            String sql = "INSERT INTO attendance(student_id, subject_id, date, status) VALUES (?, ?, CURDATE(), ?)" 
                       + " ON DUPLICATE KEY UPDATE status = VALUES(status)"; // allow update if already marked 
            PreparedStatement ps = con.prepareStatement(sql); 
            for (int i = 0; i < studentIds.length; i++) { 
                ps.setInt(1, Integer.parseInt(studentIds[i])); 
                ps.setInt(2, subjectId); 
                ps.setString(3, statuses[i]); 
                ps.addBatch(); 
            } 
            ps.executeBatch(); 
            res.sendRedirect("viewAttendance?subjectId=" + subjectId); 
        } catch (Exception e) { 
            throw new ServletException(e); 
        } 
    } 
} 