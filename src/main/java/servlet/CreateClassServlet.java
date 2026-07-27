package servlet; 
 
import db.DBConnection; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import javax.servlet.ServletException; 
import java.io.IOException; 
import java.sql.*; 
 
@WebServlet("/createClass") 
public class CreateClassServlet extends HttpServlet { 
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException { 
        HttpSession session = req.getSession(false); 
        if (session == null || session.getAttribute("teacherId") == null) { 
            res.sendRedirect("login.jsp"); 
            return; 
        } 
        int teacherId = (int) session.getAttribute("teacherId"); 
        String className = req.getParameter("className"); 
        try (Connection con = DBConnection.getConnection()) { 
            PreparedStatement ps = con.prepareStatement( 
                "INSERT INTO classes(name, teacher_id) VALUES(?, ?)" 
            ); 
            ps.setString(1, className); 
            ps.setInt(2, teacherId); 
            ps.executeUpdate(); 
            res.sendRedirect("dashboard"); 
        } catch (Exception e) { 
            throw new ServletException(e); 
        } 
    } 
} 