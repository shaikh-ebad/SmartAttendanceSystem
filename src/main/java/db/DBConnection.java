package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/smart_attendance"
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            String user = "root";
            String password = "student@123";

            Connection con = DriverManager.getConnection(url, user, password);

            System.out.println("✅ DB CONNECTED SUCCESSFULLY");
            return con;

        } catch (Exception e) {
            System.out.println("❌ DB CONNECTION FAILED");
            e.printStackTrace();   // THIS WILL SHOW THE REAL ERROR
            return null;
        }
    }
}

