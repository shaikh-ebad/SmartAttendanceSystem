<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    if (session == null || session.getAttribute("role") == null ||
        !session.getAttribute("role").equals("admin")) {
        response.sendRedirect("../../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

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
}

body {
    height: 100vh;
    display: flex;
    background: var(--bg-dark);
    font-family: 'Segoe UI', sans-serif;
}

/* SIDEBAR */
.sidebar {
    width: 260px;
    background: #111009;
    border-right: 1px solid #222;
    padding: 30px 20px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.brand {
    color: var(--text);
    font-size: 20px;
    letter-spacing: 2px;
    margin-bottom: 40px;
}

/* MENU */
.menu a {
    display: block;
    padding: 12px;
    margin-bottom: 10px;
    text-decoration: none;
    color: var(--text);
    border-radius: 8px;
    transition: 0.3s;
}

.menu a:hover {
    background: rgba(200,169,126,0.1);
    color: var(--gold);
}

/* MAIN */
.main {
    flex: 1;
    display: flex;
    flex-direction: column;
}

/* TOPBAR */
.topbar {
    padding: 20px 30px;
    border-bottom: 1px solid #222;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.topbar h1 {
    color: var(--text);
    font-weight: 300;
}

.logout {
    background: #ff4b5c;
    color: white;
    padding: 8px 16px;
    border-radius: 8px;
    text-decoration: none;
}

/* CONTENT AREA */
.content {
    flex: 1;
    padding: 20px;
}

/* IFRAME */
iframe {
    width: 100%;
    height: 100%;
    border: none;
    border-radius: 12px;
    background: #0d0c0b;
}
</style>

</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">

    <div>
        <div class="brand">Attend</div>

        <div class="menu">
        	<a href="welcome.jsp" target="frame">Dashboard</a>
            <a href="createClass.jsp" target="frame">🏫 Create Class</a>
            <a href="createSubject.jsp" target="frame">📚 Create Subject</a>
            <a href="createTeacher.jsp" target="frame">👨‍🏫 Create Teacher</a>
            <a href="createStudent.jsp" target="frame">👨‍🎓 Create Student</a>
            <a href="createTimetable.jsp" target="frame">📅 Timetable</a>
            <a href="addHoliday.jsp" target="frame">🎉 Holiday</a>
        </div>
    </div>

    <div style="color:#555; font-size:12px;">
        © 2026 Smart Attendance
    </div>

</div>

<!-- MAIN -->
<div class="main">

    <!-- TOP BAR -->
    <div class="topbar">
        <h1>Admin Dashboard</h1>
        <a href="../../logout" class="logout">Logout</a>
    </div>

    <!-- CONTENT -->
    <div class="content">
        <iframe name="frame" src="welcome.jsp"></iframe>
    </div>

</div>

</body>
</html>