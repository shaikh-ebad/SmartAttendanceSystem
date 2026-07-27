package dao;

import model.Timetable;
import java.sql.*;
import java.util.*;

public class TimetableDAO {

    public static List<Timetable> getTodaySessions(int teacherId) {
        List<Timetable> list = new ArrayList<>();
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            String sql = "SELECT t.timetable_id, t.class_id, c.class_name, "
                       + "t.subject_id, s.subject_name, t.teacher_id, "
                       + "t.day_of_week, t.start_time, t.end_time, t.session_type "
                       + "FROM timetable t "
                       + "JOIN class c ON t.class_id = c.class_id "
                       + "JOIN subject s ON t.subject_id = s.subject_id "
                       + "WHERE t.teacher_id=? AND t.day_of_week=DAYNAME(CURDATE())";

            ps = con.prepareStatement(sql);
            ps.setInt(1, teacherId);

            rs = ps.executeQuery();

            while (rs.next()) {
                Timetable t = new Timetable();
                t.setId(rs.getInt("timetable_id"));
                t.setClassId(rs.getInt("class_id"));
                t.setClassName(rs.getString("class_name"));
                t.setSubjectId(rs.getInt("subject_id"));
                t.setSubjectName(rs.getString("subject_name"));
                t.setTeacherId(rs.getInt("teacher_id"));
                t.setDayOfWeek(rs.getString("day_of_week"));
                
                // Use getTime() instead of getString() for Time columns
                t.setStartTime(rs.getTime("start_time"));
                t.setEndTime(rs.getTime("end_time"));
                
                t.setSessionType(rs.getString("session_type"));

                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Clean up resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return list;
    }
}