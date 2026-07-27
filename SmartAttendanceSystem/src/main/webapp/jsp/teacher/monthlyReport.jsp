<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, dao.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Monthly Attendance</title>
<style>
:root {
    --gold: #c8a97e;
    --bg-dark: #0d0c0b;
    --bg-card: #161513;
    --text: #f0e8dc;
    --muted: #6b6259;
    --border: #ffffff14;
}

body { font-family: 'Segoe UI', sans-serif; background: var(--bg-dark); color: var(--text); padding: 30px; }

.container { max-width: 600px; margin: auto; background: var(--bg-card); padding: 30px; border-radius: 15px; border: 1px solid var(--border); }

h3 { text-align: center; margin-bottom: 25px; font-weight: 300; }

.stats-container { display: flex; flex-direction: column; gap: 15px; }

.stat-card { background: #111009; padding: 18px; border-radius: 10px; display: flex; justify-content: space-between; align-items: center; }

.stat-label { color: var(--muted); font-size: 14px; }
.stat-value { font-size: 22px; font-weight: 600; color: var(--gold); }

.percentage-card { background: var(--gold); color: #000; padding: 25px; border-radius: 12px; text-align: center; }
.percentage-label { font-size: 14px; margin-bottom: 8px; }
.percentage-value { font-size: 32px; font-weight: bold; }

select { padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc; margin-bottom: 20px; }
button { padding: 6px 12px; border-radius: 6px; background: var(--gold); border: none; cursor: pointer; }
button:hover { opacity: 0.9; }
</style>
</head>
<body>
<div class="container">
<h3>Monthly Attendance Report</h3>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

// Get current month dynamically
Calendar cal = Calendar.getInstance();
int currentMonth = cal.get(Calendar.MONTH) + 1;

// For dynamic student selection
int studentId = -1;
if(request.getParameter("studentId") != null){
    studentId = Integer.parseInt(request.getParameter("studentId"));
}

try {
    con = DBConnection.getConnection();
%>

<!-- Student selection form -->
<form method="get">
    <label for="student">Select Student:</label>
    <select name="studentId" id="student">
        <option value="">--Choose--</option>
<%
    ps = con.prepareStatement("SELECT student_id, name FROM student");
    rs = ps.executeQuery();
    while(rs.next()){
        int id = rs.getInt("student_id");
        String name = rs.getString("name");
        String selected = (id == studentId) ? "selected" : "";
%>
        <option value="<%=id%>" <%=selected%>><%=name%></option>
<%
    }
    rs.close();
    ps.close();
%>
    </select>
    <button type="submit">Show</button>
</form>

<%
    if(studentId != -1){
        ps = con.prepareStatement(
            "SELECT COUNT(a.attendance_id) AS total_sessions, " +
            "COALESCE(SUM(CASE WHEN a.status='P' THEN 1 ELSE 0 END), 0) AS present_sessions, " +
            "ROUND(CASE WHEN COUNT(a.attendance_id)=0 THEN 0 " +
            "ELSE (SUM(CASE WHEN a.status='P' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)) END, 2) AS attendance_percentage " +
            "FROM attendance a " +
            "JOIN timetable t ON a.timetable_id = t.timetable_id " +
            "WHERE a.student_id = ? AND MONTH(a.date) = ?"
        );
        ps.setInt(1, studentId);
        ps.setInt(2, currentMonth);
        rs = ps.executeQuery();

        int total = 0, present = 0;
        double percent = 0;
        if(rs.next()){
            total = rs.getInt("total_sessions");
            present = rs.getInt("present_sessions");
            percent = rs.getDouble("attendance_percentage");
        }
%>

<div class="stats-container">
    <div class="stat-card">
        <span class="stat-label">Total Sessions</span>
        <span class="stat-value"><%=total%></span>
    </div>
    <div class="stat-card">
        <span class="stat-label">Present</span>
        <span class="stat-value"><%=present%></span>
    </div>
    <div class="percentage-card">
        <div class="percentage-label">Attendance Percentage</div>
        <div class="percentage-value"><%=String.format("%.2f", percent)%>%</div>
    </div>
</div>

<%
        rs.close();
        ps.close();
    }
} catch(Exception e){
    out.println("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
    e.printStackTrace();
} finally{
    if(rs != null) try{rs.close();}catch(Exception e){}
    if(ps != null) try{ps.close();}catch(Exception e){}
    if(con != null) try{con.close();}catch(Exception e){}
}
%>

</div>
</body>
</html>