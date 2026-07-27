package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/timetableCreate")
public class TimetableCreateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int classId = Integer.parseInt(request.getParameter("classId"));

        String[] times = {"9-10","10-11","11-12","12-1","2-3","3-4"};
        String[] days = {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO timetable(class_id, subject_id, teacher_id, day_of_week, start_time, end_time, session_type) VALUES(?,?,?,?,?,?,?)"
            );

            for(String day : days){
                for(String time : times){

                    String key = day + "_" + time;

                    String subject = request.getParameter("subject_" + key);
                    String teacher = request.getParameter("teacher_" + key);
                    String type = request.getParameter("type_" + key);

                    // skip empty cells
                    if(subject == null || subject.isEmpty()) continue;

                    String[] t = time.split("-");
                    String start = t[0] + ":00";
                    String end = t[1] + ":00";

                    ps.setInt(1, classId);
                    ps.setInt(2, Integer.parseInt(subject));
                    ps.setInt(3, Integer.parseInt(teacher));
                    ps.setString(4, day);
                    ps.setString(5, start);
                    ps.setString(6, end);
                    ps.setString(7, type);

                    ps.addBatch();
                }
            }

            ps.executeBatch();

            response.sendRedirect("jsp/admin/dashboard.jsp?success=1");

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}