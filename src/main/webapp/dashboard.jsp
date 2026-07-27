<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Dashboard | Smart Attendance</title>
    <style>
        :root { --primary: #1a73e8; --bg: #f8f9fa; --text: #3c4043; --white: #ffffff; --border: #dadce0; }
        body { font-family: 'Segoe UI', Arial; background-color: var(--bg); color: var(--text); margin: 0; display: flex; }
        .sidebar { width: 240px; background: var(--white); height: 100vh; border-right: 1px solid var(--border); padding: 20px; position: fixed; }
        .main-content { margin-left: 280px; padding: 40px; width: calc(100% - 320px); }
        table { width: 100%; border-collapse: collapse; background: var(--white); margin-bottom: 25px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        th, td { text-align: left; padding: 12px; border-bottom: 1px solid var(--border); }
        th { background-color: #f1f3f4; }
        .card { background: var(--white); padding: 20px; border-radius: 8px; border: 1px solid var(--border); margin-bottom: 25px; }
        .btn { background-color: var(--primary); color: white; border: none; padding: 10px 15px; border-radius: 4px; cursor: pointer; text-decoration: none; }
        input, select { padding: 8px; border: 1px solid var(--border); border-radius: 4px; margin-right: 5px; }
        .action-link { color: var(--primary); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>🏫 Smart Attendance</h2>
    <p>Welcome, <br><strong>${sessionScope.teacherName}</strong></p>
    <hr>
    <a href="logout" class="btn" style="background:#d93025; display:block; text-align:center;">Logout</a>
</div>

<div class="main-content">
    <h1>Teacher Dashboard</h1>

    <div class="card">
        <h3>📂 Your Classes</h3>
        <table>
            <tr><th>ID</th><th>Class Name</th></tr>
            <% 
                ResultSet classes = (ResultSet) request.getAttribute("classesRs");
                if (classes != null) {
                    while (classes.next()) {
            %>
            <tr>
                <td><%= classes.getInt("id") %></td>
                <td><%= classes.getString("name") %></td>
            </tr>
            <% } } %>
        </table>
        <form action="createClass" method="post">
            <input type="text" name="className" placeholder="New Class Name" required>
            <button type="submit" class="btn">Create Class</button>
        </form>
    </div>

    <div class="card">
        <h3>📚 Your Subjects</h3>
        <table>
            <tr><th>ID</th><th>Subject</th><th>Class ID</th><th>Actions</th></tr>
            <% 
                ResultSet subjects = (ResultSet) request.getAttribute("subjectsRs");
                if (subjects != null) {
                    while (subjects.next()) {
            %>
            <tr>
                <td><%= subjects.getInt("id") %></td>
                <td><%= subjects.getString("name") %></td>
                <td><%= subjects.getInt("class_id") %></td>
                <td>
                    <a class="action-link" href="subjectStudents?subjectId=<%= subjects.getInt("id") %>">Mark</a> |
                    <a class="action-link" href="viewAttendance?subjectId=<%= subjects.getInt("id") %>">View</a>
                </td>
            </tr>
            <% } } %>
        </table>
        
        <form action="createSubject" method="post">
            <input type="text" name="name" placeholder="Subject Name" required>
            <select name="classId" required>
                <option value="">Select Class</option>
                <% 
                   if (classes != null) { 
                       classes.beforeFirst(); // Reset resultset to beginning
                       while (classes.next()) { 
                %>
                    <option value="<%= classes.getInt("id") %>"><%= classes.getString("name") %></option>
                <% } } %>
            </select>
            <button type="submit" class="btn">Create Subject</button>
        </form>
    </div>

    <div class="card">
        <h3>👤 Register Student</h3>
        <form action="createStudent" method="post">
            <input type="text" name="name" placeholder="Student Name" required>
            <input type="text" name="roll" placeholder="Roll Number" required>
            <button type="submit" class="btn">Add Student</button>
        </form>
    </div>
</div>

</body>
</html>