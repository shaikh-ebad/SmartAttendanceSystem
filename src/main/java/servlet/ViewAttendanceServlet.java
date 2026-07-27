package servlet; 
 
import db.DBConnection; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import javax.servlet.ServletException; 
import java.io.IOException; 
import java.sql.*; 
 
@WebServlet("/viewAttendance") 
public class ViewAttendanceServlet extends HttpServlet { 
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException { 
        String subjectIdStr = req.getParameter("subjectId"); 
        int subjectId = Integer.parseInt(subjectIdStr); 
        try (Connection con = DBConnection.getConnection()) { 
            PreparedStatement ps = con.prepareStatement( 
                "SELECT a.date, s.name, s.roll_no, a.status " + 
                "FROM attendance a JOIN students s ON a.student_id = s.id " + 
                "WHERE a.subject_id = ? ORDER BY a.date DESC" 
            ); 
            ps.setInt(1, subjectId); 
            ResultSet rs = ps.executeQuery(); 
            req.setAttribute("attendanceRs", rs); 
            req.setAttribute("subjectId", subjectId); 
            req.getRequestDispatcher("view.jsp").forward(req, res); 
        } catch (Exception e) { 
            throw new ServletException(e); 
        } 
    } 
} 