package servlet; 
 
import db.DBConnection; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import javax.servlet.ServletException; 
import java.io.IOException; 
import java.sql.*; 
 
@WebServlet("/insights") 
public class InsightServlet extends HttpServlet { 
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException { 
        int studentId = Integer.parseInt(req.getParameter("studentId")); 
        int subjectId = Integer.parseInt(req.getParameter("subjectId")); 
        try (Connection con = DBConnection.getConnection()) { 
            // regularity 
            PreparedStatement ps = con.prepareStatement( 
                "SELECT " + 
                "(SELECT COUNT(*) FROM attendance WHERE student_id=? AND subject_id=? AND status='Present') AS p, " + 
                "(SELECT COUNT(*) FROM attendance WHERE student_id=? AND subject_id=?) AS total" 
            ); 
            ps.setInt(1, studentId); 
            ps.setInt(2, subjectId); 
            ps.setInt(3, studentId); 
            ps.setInt(4, subjectId); 
 
            ResultSet rs = ps.executeQuery(); 
            double regularity = 0.0; 
            if (rs.next()) { 
                int p = rs.getInt("p"); 
                int total = rs.getInt("total"); 
                regularity = (total == 0) ? 0.0 : (p * 100.0 / total); 
            } 
            req.setAttribute("regularity", regularity); 
 
            // late count 
            PreparedStatement ps2 = con.prepareStatement( 
                "SELECT COUNT(*) AS lateCount FROM attendance WHERE student_id=? AND subject_id=? AND status='Late'" 
            ); 
            ps2.setInt(1, studentId); 
            ps2.setInt(2, subjectId); 
            ResultSet rs2 = ps2.executeQuery(); 
            if (rs2.next()) req.setAttribute("lateCount", rs2.getInt("lateCount")); 
 
            // recent 7 days attendance average 
            PreparedStatement ps3 = con.prepareStatement( 
                "SELECT COUNT(*) AS present7 FROM attendance WHERE student_id=? AND subject_id=? AND date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND status='Present'" 
            ); 
            ps3.setInt(1, studentId); 
            ps3.setInt(2, subjectId); 
            ResultSet rs3 = ps3.executeQuery(); 
            int present7 = 0; 
            if (rs3.next()) present7 = rs3.getInt("present7"); 
            req.setAttribute("present7", present7); 
 
            // monthly summary 
            PreparedStatement ps4 = con.prepareStatement( 
                "SELECT MONTH(date) AS m, SUM(status='Present') AS present, SUM(status='Absent') AS absent, SUM(status='Late') AS late " + 
                "FROM attendance WHERE student_id=? AND subject_id=? GROUP BY MONTH(date)" 
            ); 
            ps4.setInt(1, studentId); 
            ps4.setInt(2, subjectId); 
            ResultSet monthlyRs = ps4.executeQuery(); 
            req.setAttribute("monthlyRs", monthlyRs); 
 
            req.setAttribute("studentId", studentId); 
            req.setAttribute("subjectId", subjectId); 
            req.getRequestDispatcher("insights.jsp").forward(req, res); 
 
        } catch (Exception e) { 
            throw new ServletException(e); 
        } 
    } 
}