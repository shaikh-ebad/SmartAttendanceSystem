package servlet; 
 
import db.DBConnection; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import javax.servlet.ServletException; 
import java.io.IOException; 
import java.sql.*; 
 
@WebServlet("/createStudent") 
public class CreateStudentServlet extends HttpServlet { 
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException { 
        String name = req.getParameter("name"); 
        String roll = req.getParameter("roll"); 
        String classIdStr = req.getParameter("classId"); 
        Integer classId = (classIdStr == null || classIdStr.isEmpty()) ? null : Integer.parseInt(classIdStr); 
        try (Connection con = DBConnection.getConnection()) { 
            PreparedStatement ps = con.prepareStatement( 
                "INSERT INTO students(name, roll_no, class_id) VALUES(?, ?, ?)" 
            ); 
            ps.setString(1, name); 
            ps.setString(2, roll); 
            if (classId != null) ps.setInt(3, classId); else ps.setNull(3, java.sql.Types.INTEGER); 
            ps.executeUpdate(); 
            res.sendRedirect("dashboard"); 
        } catch (Exception e) { 
            throw new ServletException(e); 
        } 
    } 
} 