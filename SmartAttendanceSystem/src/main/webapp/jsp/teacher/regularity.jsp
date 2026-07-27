<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance Regularity</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: #ffffff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .back-link {
            margin-bottom: 20px;
        }

        .back-link a {
            text-decoration: none;
            color: #667eea;
            font-weight: 600;
            font-size: 14px;
            transition: color 0.3s;
        }

        .back-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        h3 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
        }

        h3::before {
            content: "📈 ";
            margin-right: 8px;
        }

        .stats-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .stat-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-label {
            font-size: 16px;
            font-weight: 600;
            color: #555;
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: #667eea;
        }

        .regularity-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 25px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(102, 126, 234, 0.3);
        }

        .regularity-label {
            font-size: 18px;
            font-weight: 700;
            color: white;
            margin-bottom: 10px;
        }

        .regularity-value {
            font-size: 42px;
            font-weight: 700;
            color: white;
        }

        .stat-card.total::before {
            content: "📅";
            font-size: 28px;
            margin-right: 15px;
        }

        .stat-card.present::before {
            content: "✓";
            font-size: 28px;
            margin-right: 15px;
            color: #28a745;
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }

            h3 {
                font-size: 24px;
            }

            .stat-label {
                font-size: 14px;
            }

            .stat-value {
                font-size: 20px;
            }

            .regularity-value {
                font-size: 36px;
            }

            .regularity-label {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="back-link">
        <a href="dashboard.jsp">← Back to Dashboard</a>
    </div>

    <h3>Attendance Regularity</h3>

    <%
    Integer studentId = (Integer) session.getAttribute("student_Id");

    if (studentId == null) {
        out.println("<p style='color:red'>Student not logged in</p>");
        return;
    }


    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    int total = 0;
    int present = 0;
    double percent = 0;

    try {
        con = DBConnection.getConnection();
        
        ps = con.prepareStatement(
        	    "SELECT COUNT(*) AS total, " +
        	    "SUM(CASE WHEN status='P' THEN 1 ELSE 0 END) AS present " +
        	    "FROM attendance WHERE student_id=?"
        	);

        ps.setInt(1, studentId);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            total = rs.getInt("total");
            present = rs.getInt("present");
            percent = total == 0 ? 0 : (present * 100.0 / total);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (ps != null) try { ps.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
    }
    %>

    <div class="stats-container">
        <div class="stat-card total">
            <span class="stat-label">Total Sessions</span>
            <span class="stat-value"><%=total%></span>
        </div>

        <div class="stat-card present">
            <span class="stat-label">Present</span>
            <span class="stat-value"><%=present%></span>
        </div>

        <div class="regularity-card">
            <div class="regularity-label">Regularity</div>
            <div class="regularity-value"><%=String.format("%.2f",percent)%>%</div>
        </div>
    </div>
</div>

</body>
</html>