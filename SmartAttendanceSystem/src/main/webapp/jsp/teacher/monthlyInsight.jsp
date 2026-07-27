<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Monthly Attendance Insight</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --gold: #c8a97e;
    --bg-dark: #0d0c0b;
    --bg-card: #161513;
    --text: #f0e8dc;
    --muted: #6b6259;
    --border: #ffffff14;
}

/* BACKGROUND */
body {
    font-family: 'Segoe UI', sans-serif;
    background: var(--bg-dark);
    color: var(--text);
    padding: 20px;
}

/* CONTAINER */
.container {
    max-width: 900px;
    margin: auto;
    background: var(--bg-card);
    padding: 30px;
    border-radius: 16px;
    border: 1px solid var(--border);
}

/* TITLE */
h3 {
    text-align: center;
    margin-bottom: 25px;
    font-weight: 300;
}

/* TABLE */
table {
    width: 100%;
    border-collapse: collapse;
    overflow: hidden;
    border-radius: 12px;
}

/* HEADER */
th {
    background: rgba(200,169,126,0.1);
    color: var(--gold);
    padding: 14px;
    text-align: left;
    font-weight: 500;
}

/* CELLS */
td {
    padding: 14px;
    border-bottom: 1px solid var(--border);
    color: var(--text);
}

/* ROW HOVER */
tr:hover {
    background: rgba(255,255,255,0.03);
}

/* NO DATA */
.no-data {
    text-align: center;
    color: var(--muted);
    padding: 20px;
}

/* PERCENT COLORS */
.percentage-high {
    color: #4caf50;
}

.percentage-medium {
    color: #ffa726;
}

.percentage-low {
    color: #ff5252;
}
</style>

</head>

<body>

<div class="container">

    <h3>Monthly Attendance Insight</h3>

    <table>
        <tr>
            <th>Month</th>
            <th>Total</th>
            <th>Present</th>
            <th>%</th>
        </tr>

        <%
        int studentId = 1;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean hasData = false;

        try {
            con = DBConnection.getConnection();

            ps = con.prepareStatement(
                "SELECT MONTH(date) m, COUNT(*) total, SUM(status='P') present " +
                "FROM attendance WHERE student_id=? GROUP BY MONTH(date)"
            );

            ps.setInt(1, studentId);
            rs = ps.executeQuery();

            while(rs.next()){
                hasData = true;
                int total = rs.getInt("total");
                int present = rs.getInt("present");
                double p = present * 100.0 / total;
                
                String percentageClass = "";
                if (p >= 75) {
                    percentageClass = "percentage-high";
                } else if (p >= 50) {
                    percentageClass = "percentage-medium";
                } else {
                    percentageClass = "percentage-low";
                }
        %>
        <tr>
            <td><%=rs.getInt("m")%></td>
            <td><%=total%></td>
            <td><%=present%></td>
            <td class="<%=percentageClass%>"><%=String.format("%.2f",p)%>%</td>
        </tr>
        <%
            }
            
            if (!hasData) {
        %>
        <tr>
            <td colspan="4" class="no-data">No attendance data available</td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (ps != null) try { ps.close(); } catch (SQLException e) {}
            if (con != null) try { con.close(); } catch (SQLException e) {}
        }
        %>

    </table>

</div>

</body>
</html>