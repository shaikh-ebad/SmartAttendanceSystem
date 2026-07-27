package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

public class AttendanceDAO {

    // ============================
    // 1️⃣ Get Monthly Attendance %
    // ============================
    public static double getMonthlyAttendance(int studentId, int month, int year) {

        double percentage = 0.0;

        String sql = "SELECT COUNT(*) AS total_sessions, "
                + "SUM(a.status='P') AS present_sessions "
                + "FROM attendance a "
                + "LEFT JOIN holiday h ON a.date = h.holiday_date "
                + "WHERE a.student_id = ? "
                + "AND MONTH(a.date)=? "
                + "AND YEAR(a.date)=? "
                + "AND h.holiday_date IS NULL";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, month);
            ps.setInt(3, year);

            ResultSet rs = ps.executeQuery();

            int total = 0;
            int present = 0;

            if (rs.next()) {
                total = rs.getInt("total_sessions");
                present = rs.getInt("present_sessions");
            }

            if (total > 0) {
                percentage = ((double) present / total) * 100;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return percentage;
    }


    // ============================
    // 2️⃣ Get Behavioral Insights
    // ============================
    public static Map<String, Object> getBehavioralInsights(int studentId, int month, int year) {

        Map<String, Object> insights = new HashMap<>();

        LocalDate start = LocalDate.of(year, month, 1);
        LocalDate end = start.withDayOfMonth(start.lengthOfMonth());

        try (Connection con = DBConnection.getConnection()) {

            // -----------------------------------------
            // 1️⃣ Monthly Attendance %
            // -----------------------------------------
            double attendancePercent = getMonthlyAttendance(studentId, month, year);
            insights.put("attendancePercent", attendancePercent);


            // -----------------------------------------
            // 2️⃣ Absence Trend by Weekday
            // -----------------------------------------
            String sqlTrend = "SELECT t.day_of_week, COUNT(*) AS absences "
                    + "FROM attendance a "
                    + "JOIN timetable t ON a.timetable_id = t.timetable_id "
                    + "WHERE a.student_id = ? "
                    + "AND a.status = 'A' "
                    + "AND a.date BETWEEN ? AND ? "
                    + "GROUP BY t.day_of_week";

            PreparedStatement psTrend = con.prepareStatement(sqlTrend);
            psTrend.setInt(1, studentId);
            psTrend.setDate(2, java.sql.Date.valueOf(start));
            psTrend.setDate(3, java.sql.Date.valueOf(end));

            ResultSet rsTrend = psTrend.executeQuery();

            Map<String, Integer> weekdayAbsences = new HashMap<>();

            while (rsTrend.next()) {
                weekdayAbsences.put(
                        rsTrend.getString("day_of_week"),
                        rsTrend.getInt("absences")
                );
            }

            insights.put("weekdayAbsences", weekdayAbsences);


            // -----------------------------------------
            // 3️⃣ Lecture vs Lab Attendance (Present Only)
            // -----------------------------------------
            String sqlType = "SELECT t.session_type, COUNT(*) AS attended "
                    + "FROM attendance a "
                    + "JOIN timetable t ON a.timetable_id = t.timetable_id "
                    + "WHERE a.student_id = ? "
                    + "AND a.status = 'P' "
                    + "AND a.date BETWEEN ? AND ? "
                    + "GROUP BY t.session_type";

            PreparedStatement psType = con.prepareStatement(sqlType);
            psType.setInt(1, studentId);
            psType.setDate(2, java.sql.Date.valueOf(start));
            psType.setDate(3, java.sql.Date.valueOf(end));

            ResultSet rsType = psType.executeQuery();

            Map<String, Integer> sessionTypeAttendance = new HashMap<>();

            while (rsType.next()) {
                sessionTypeAttendance.put(
                        rsType.getString("session_type"),
                        rsType.getInt("attended")
                );
            }

            insights.put("sessionTypeAttendance", sessionTypeAttendance);


            // -----------------------------------------
            // 4️⃣ Morning Attendance (<10AM)
            // -----------------------------------------
            String sqlMorning = "SELECT COUNT(*) AS total, "
                    + "SUM(a.status='P') AS present "
                    + "FROM attendance a "
                    + "JOIN timetable t ON a.timetable_id = t.timetable_id "
                    + "WHERE a.student_id = ? "
                    + "AND a.date BETWEEN ? AND ? "
                    + "AND t.start_time < '10:00:00'";

            PreparedStatement psMorning = con.prepareStatement(sqlMorning);
            psMorning.setInt(1, studentId);
            psMorning.setDate(2, java.sql.Date.valueOf(start));
            psMorning.setDate(3, java.sql.Date.valueOf(end));

            ResultSet rsMorning = psMorning.executeQuery();

            if (rsMorning.next()) {
                Map<String, Integer> morningStats = new HashMap<>();
                morningStats.put("total", rsMorning.getInt("total"));
                morningStats.put("present", rsMorning.getInt("present"));
                insights.put("morningAttendance", morningStats);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return insights;
    }
}