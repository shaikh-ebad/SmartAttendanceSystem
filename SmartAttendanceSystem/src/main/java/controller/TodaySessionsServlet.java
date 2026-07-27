package controller;

import dao.DBConnection;
import model.Timetable;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/todaySessions")
public class TodaySessionsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer teacherId = (session != null) ? (Integer) session.getAttribute("teacherId") : null;

        // 🔒 Login check
        if (teacherId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 📅 Get today's day name
        LocalDate today = LocalDate.now();
        String dayOfWeek = today.getDayOfWeek()
                                .getDisplayName(TextStyle.FULL, Locale.ENGLISH)
                                .trim();

        // 🔍 DEBUG LOGS
        System.out.println("\n=== TODAY SESSIONS DEBUG ===");
        System.out.println("Teacher ID  : " + teacherId);
        System.out.println("Today Date  : " + today);
        System.out.println("Day of Week : " + dayOfWeek);

        List<Timetable> todaySessions = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            // 🛑 Holiday check
            try (PreparedStatement psHoliday = con.prepareStatement(
                    "SELECT 1 FROM holiday WHERE holiday_date = ?")) {

                psHoliday.setDate(1, Date.valueOf(today));
                ResultSet rsHoliday = psHoliday.executeQuery();

                if (rsHoliday.next()) {
                    request.setAttribute("holiday", true);
                    System.out.println("⚠️ Today is a holiday");
                    request.getRequestDispatcher("/jsp/teacher/todaySessions.jsp")
                           .forward(request, response);
                    return;
                }
            }

            request.setAttribute("holiday", false);

            // 📘 Fetch sessions
            String sql =
            		"SELECT t.timetable_id, t.class_id, t.subject_id, " +
                     "t.start_time, t.end_time, t.session_type, " +
                     "c.class_name, s.subject_name " +
                     "FROM timetable t " +
                     "JOIN class c ON t.class_id = c.class_id " +
                     "JOIN subject s ON t.subject_id = s.subject_id " +
                     "WHERE t.teacher_id = ? " +
                     "AND TRIM(LOWER(t.day_of_week)) = TRIM(LOWER(?)) " +
                     "ORDER BY t.start_time";

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, teacherId);          // ✅ FIXED
                ps.setString(2, dayOfWeek);

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    Timetable t = new Timetable();
                    t.setId(rs.getInt("timetable_id"));
                    t.setClassId(rs.getInt("class_id"));
                    t.setSubjectId(rs.getInt("subject_id"));
                    t.setStartTime(rs.getTime("start_time"));
                    t.setEndTime(rs.getTime("end_time"));
                    t.setSessionType(rs.getString("session_type"));
                    t.setClassName(rs.getString("class_name"));
                    t.setSubjectName(rs.getString("subject_name"));
                    todaySessions.add(t);

                    System.out.println("✔ Session: " +
                            t.getClassName() + " | " +
                            t.getSubjectName() + " | " +
                            t.getStartTime() + " - " + t.getEndTime());
                }
                System.out.println("Sessions fetched = " + todaySessions.size());

            }

            System.out.println("Total sessions found: " + todaySessions.size());

            request.setAttribute("todaySessions", todaySessions);
            request.getRequestDispatcher("/jsp/teacher/todaySessions.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load today's sessions.");
            request.getRequestDispatcher("/jsp/teacher/todaySessions.jsp")
                   .forward(request, response);
        }
    }
}
