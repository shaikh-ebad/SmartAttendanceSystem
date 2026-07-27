<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.HolidayDAO" %>
<%@ page import="java.sql.*, dao.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= HolidayDAO.isHoliday() ? "Holiday" : "Mark Attendance" %></title>

<style>
:root {
    --gold: #c8a97e;
    --bg-dark: #0d0c0b;
    --bg-card: #161513;
    --bg-field: #0d0c0b;
    --text: #f0e8dc;
    --muted: #6b6259;
    --border: #ffffff14;
}

body {
    font-family: 'Segoe UI', sans-serif;
    background: var(--bg-dark);
    color: var(--text);
    padding: 30px;
}

/* CARD */
.container, .message-box {
    max-width: 700px;
    margin: auto;
    background: var(--bg-card);
    padding: 30px;
    border-radius: 15px;
    border: 1px solid var(--border);
}

/* BACK LINK */
.back-link {
    margin-bottom: 20px;
}

.back-link a {
    color: var(--gold);
    text-decoration: none;
    font-size: 14px;
}

/* TITLE */
h2 {
    text-align: center;
    margin-bottom: 25px;
    font-weight: 300;
}

/* HOLIDAY BOX */
.message-box h3 {
    text-align: center;
    color: #ff6b6b;
}

/* STUDENT ROW */
.student-row {
    background: #111009;
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* NAME */
.student-name {
    font-weight: 500;
}

/* RADIO */
.radio-group {
    display: flex;
    gap: 15px;
}

input[type="radio"] {
    accent-color: var(--gold);
}

/* BUTTON */
.submit-btn {
    width: 100%;
    padding: 12px;
    background: var(--gold);
    border: none;
    border-radius: 8px;
    color: #000;
    font-weight: bold;
    cursor: pointer;
}

/* EMPTY */
.no-students {
    text-align: center;
    color: var(--muted);
}
</style>

</head>

<body>

<% if (HolidayDAO.isHoliday()) { %>

    <div class="message-box">
        <h3>🎉 Today is a Holiday<br>Attendance not allowed</h3>

       <%--  <div class="back-link">
            <a href="${pageContext.request.contextPath}/jsp/teacher/dashboard.jsp">
                ← Back to Dashboard
            </a>
        </div> --%>
    </div>

<% } else { 

    String timetableIdParam = request.getParameter("timetableId");

    if (timetableIdParam == null || timetableIdParam.isEmpty()) {
        response.sendRedirect("todaySessions.jsp");
        return;
    }

    int timetableId = Integer.parseInt(timetableIdParam);
%>

<div class="container">

<%--     <div class="back-link">
        <a href="${pageContext.request.contextPath}/jsp/teacher/dashboard.jsp">
            ← Back to Dashboard
        </a>
    </div> --%>

    <h2>Mark Attendance</h2>

    <form action="../../submitAttendance" method="post">
        <input type="hidden" name="timetableId" value="<%= timetableId %>">

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
boolean hasStudents = false;

try {
    con = DBConnection.getConnection();

    ps = con.prepareStatement(
        "SELECT s.student_id, s.name FROM student s " +
        "INNER JOIN timetable t ON s.class_id = t.class_id " +
        "WHERE t.timetable_id = ? ORDER BY s.name"
    );

    ps.setInt(1, timetableId);
    rs = ps.executeQuery();

    while (rs.next()) {
        hasStudents = true;
        int studentId = rs.getInt("student_id");
        String studentName = rs.getString("name");
%>

        <div class="student-row">
            <span class="student-name"><%= studentName %></span>

            <div class="radio-group">
                <label>
                    <input type="radio" name="status_<%= studentId %>" value="P" required> Present
                </label>
                <label>
                    <input type="radio" name="status_<%= studentId %>" value="A"> Absent
                </label>
            </div>
        </div>

<%
    }

    if (!hasStudents) {
%>
        <div class="no-students">No students found</div>
<%
    }

} catch (Exception e) {
%>
    <div class="no-students">Error: <%= e.getMessage() %></div>
<%
} finally {
    if (rs != null) try { rs.close(); } catch (Exception e) {}
    if (ps != null) try { ps.close(); } catch (Exception e) {}
    if (con != null) try { con.close(); } catch (Exception e) {}
}

if (hasStudents) {
%>

        <input type="submit" value="Submit Attendance" class="submit-btn">

<%
}
%>

    </form>
</div>

<% } %>

</body>
</html>