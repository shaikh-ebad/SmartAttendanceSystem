package dao;
import java.sql.*;
import java.time.LocalDate;

public class HolidayDAO {

    public static boolean isHoliday() {
        boolean result = false;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps =
                con.prepareStatement("SELECT * FROM holiday WHERE holiday_date=?");
            ps.setDate(1, Date.valueOf(LocalDate.now()));
            ResultSet rs = ps.executeQuery();
            result = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
