package servlet; 
 
import db.DBConnection; 
import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import java.io.IOException; 
import java.sql.*; 
 
@WebServlet("/dashboard") 
public class DashboardServlet extends HttpServlet { 
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException { 
        HttpSession session = req.getSession(false); 
        if (session == null || session.getAttribute("teacherId") == null) { 
            res.sendRedirect("login.jsp"); 
            return; 
        } 
        int teacherId = (int) session.getAttribute("teacherId"); 
        try (Connection con = DBConnection.getConnection()) { 
            PreparedStatement ps1 = con.prepareStatement( 
                "SELECT * FROM classes WHERE teacher_id=?" 
            ); 
            ps1.setInt(1, teacherId); 
            ResultSet classesRs = ps1.executeQuery(); 
            req.setAttribute("classesRs", classesRs); 
 
            PreparedStatement ps2 = con.prepareStatement( 
                "SELECT * FROM subjects WHERE teacher_id=?" 
            ); 
            ps2.setInt(1, teacherId); 
            ResultSet subjectsRs = ps2.executeQuery(); 
            req.setAttribute("subjectsRs", subjectsRs); 
 
            req.getRequestDispatcher("dashboard.jsp").forward(req, res); 
        } catch (Exception e) { 
            throw new ServletException(e); 
        } 
    } 
} 