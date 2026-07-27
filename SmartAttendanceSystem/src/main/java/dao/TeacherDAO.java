package dao;

import model.Teacher;
import java.sql.*;

public class TeacherDAO {

    public static Teacher login(String username, String password) {
        Teacher t = null;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM teacher WHERE username=? AND password=?"
            );
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                t = new Teacher(
                    rs.getInt("teacher_id"),
                    rs.getString("name"),
                    rs.getString("username")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }
}
