package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("timetable".equals(action)) {
            response.sendRedirect("jsp/admin/createTimetable.jsp");
        }
        else if ("holiday".equals(action)) {
            response.sendRedirect("jsp/admin/addHoliday.jsp");
        }
        else {
            response.sendRedirect("jsp/admin/dashboard.jsp");
        }
    }
}
