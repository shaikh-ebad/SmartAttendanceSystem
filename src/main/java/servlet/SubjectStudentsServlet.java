package servlet; 
 
import db.DBConnection; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import javax.servlet.ServletException; 
import java.io.IOException; 
import java.sql.*; 
 
@WebServlet("/subjectStudents") 
public class SubjectStudentsServlet extends HttpServlet { 
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException { 
        HttpSession session = req.getSession(false); 
        if (session == null || session.getAttribute("teacherId") == null) { 
            res.sendRedirect("login.jsp"); 
            return; 
        } 
        String subjectIdStr = req.getParameter("subjectId"); 
        int subjectId = Integer.parseInt(subjectIdStr); 
        try (Connection con = DBConnection.getConnection()) { 
            PreparedStatement ps = con.prepareStatement( 
                "SELECT s.* FROM students s WHERE s.class_id = (SELECT class_id FROM subjects WHERE id = ?)" 
            ); 
            ps.setInt(1, subjectId); 
            ResultSet rs = ps.executeQuery(); 
            req.setAttribute("studentsRs", rs); 
            req.setAttribute("subjectId", subjectId); 
            req.getRequestDispatcher("mark.jsp").forward(req, res); 
        } catch (Exception e) { 
            throw new ServletException(e); 
        } 
    } 
} 