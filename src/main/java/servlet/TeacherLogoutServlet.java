package servlet; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.*; 
import java.io.IOException; 
import javax.servlet.ServletException; 
 
@WebServlet("/logout") 
public class TeacherLogoutServlet extends HttpServlet { 
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException { 
        HttpSession session = req.getSession(false); 
        if (session != null) session.invalidate(); 
        resp.sendRedirect("login.jsp"); 
    } 
}