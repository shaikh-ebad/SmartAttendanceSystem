<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Class</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<h2>Create New Class</h2>

<form action="createClass" method="post">
    <label>Class Name:</label><br>
    <input type="text" name="class_name" required><br><br>

    <label>Section:</label><br>
    <input type="text" name="section" required><br><br>

    <button type="submit">Create Class</button>
</form>

<br>
<a href="dashboard.jsp">⬅ Back to Dashboard</a>

</body>
</html>
