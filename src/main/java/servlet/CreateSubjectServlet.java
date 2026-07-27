package servlet; 
 
import db.DBConnection; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import javax.servlet.ServletException; 
import java.io.IOException; 
import java.sql.*; 
 
@WebServlet("/createSubject") 
public class CreateSubjectServlet extends HttpServlet { 
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException { 
        HttpSession session = req.getSession(false); 
        if (session == null || session.getAttribute("teacherId") == null) { 
            res.sendRedirect("login.jsp"); 
            return; 
        } 
        int teacherId = (int) session.getAttribute("teacherId"); 
        String name = req.getParameter("name"); 
        String classIdStr = req.getParameter("classId"); 
        Integer classId = (classIdStr == null || classIdStr.isEmpty()) ? null : Integer.parseInt(classIdStr); 
 
        try (Connection con = DBConnection.getConnection()) { 
            PreparedStatement ps = con.prepareStatement( 
                "INSERT INTO subjects(name, teacher_id, class_id) VALUES(?, ?, ?)" 
            ); 
            ps.setString(1, name); 
            ps.setInt(2, teacherId); 
            if (classId != null) ps.setInt(3, classId); else ps.setNull(3, java.sql.Types.INTEGER); 
            ps.executeUpdate(); 
            res.sendRedirect("dashboard"); 
        } catch (Exception e) { 
            throw new ServletException(e); 
        } 
    } 
} 