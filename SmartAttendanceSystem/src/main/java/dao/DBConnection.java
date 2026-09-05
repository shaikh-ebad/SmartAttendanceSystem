package dao;
import java.sql.*;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/smart_attendance",
                "root",
                "/*Your Database Password*/"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
