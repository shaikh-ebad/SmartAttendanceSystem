<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, model.Timetable" %>

<%
String jspDay =
    new java.text.SimpleDateFormat("EEEE", Locale.ENGLISH)
        .format(new java.util.Date())
        .trim();
%>

<div class="page-wrapper">

    <h2>📅 Today's Sessions</h2>

    <%
    Boolean holiday = (Boolean) request.getAttribute("holiday");

    if (holiday != null && holiday) {
    %>
        <div class="holiday-message">🎉 Today is a Holiday</div>
    <%
    } else {
        List<Timetable> list = (List<Timetable>) request.getAttribute("todaySessions");

        if (list == null || list.isEmpty()) {
    %>
        <div class="no-sessions">No sessions scheduled for today.</div>
    <%
        } else {
            for (Timetable t : list) {
    %>

        <div class="session-card">

            <div class="session-info">
                <div><b>🏫 Class:</b> <%= t.getClassName() %></div>
                <div><b>📚 Subject:</b> <%= t.getSubjectName() %></div>
                <div><b>🕐 Time:</b> <%= t.getStartTime() %> - <%= t.getEndTime() %></div>
                <div><b>📝 Type:</b> <%= t.getSessionType() %></div>
            </div>

            <form action="<%=request.getContextPath()%>/markAttendance" method="post">
                <input type="hidden" name="timetableId" value="<%=t.getId()%>">
                <input type="submit" value="Mark Attendance">
            </form>

        </div>

    <%
            }
        }
    }
    %>

</div>

<style>

/* MAIN CARD */
.page-wrapper {
    background: #161513;
    padding: 25px;
    border-radius: 12px;
    color: #ffffff;
}

/* TITLE */
h2 {
    text-align: center;
    margin-bottom: 25px;
    font-weight: 400;
}

/* HOLIDAY */
.holiday-message {
    background: #c8a97e;
    color: #0d0c0b;
    padding: 15px;
    text-align: center;
    border-radius: 8px;
    font-weight: bold;
}

/* NO SESSION */
.no-sessions {
    text-align: center;
    padding: 30px;
    color: #aaa;
}

/* SESSION CARD */
.session-card {
    background: #1e1c19;
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 15px;
    transition: 0.3s;
    border: 1px solid #222;
}

.session-card:hover {
    background: rgba(200,169,126,0.08);
}

/* SESSION INFO */
.session-info {
    margin-bottom: 15px;
    line-height: 1.8;
    font-size: 14px;
}

/* BUTTON */
input[type="submit"] {
    width: 100%;
    padding: 10px;
    background: #c8a97e;
    color: #0d0c0b;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

input[type="submit"]:hover {
    opacity: 0.85;
}

</style>