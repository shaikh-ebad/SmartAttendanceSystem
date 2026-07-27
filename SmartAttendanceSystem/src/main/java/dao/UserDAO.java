package dao;

import java.sql.*;

public class UserDAO {

    public static boolean validate(String role, String username, String password) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();
            String table = role.equals("admin") ? "admin" : "teacher";

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM " + table + " WHERE username=? AND password=?"
            );

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            status = rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
}
