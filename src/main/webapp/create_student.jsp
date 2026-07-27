<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Student</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<h2>Add Student</h2>

<form action="createStudent" method="post">
    <label>Student Name:</label><br>
    <input type="text" name="student_name" required><br><br>

    <label>Roll Number:</label><br>
    <input type="text" name="roll_no" required><br><br>

    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Class ID:</label><br>
    <input type="number" name="class_id" required><br><br>

    <button type="submit">Add Student</button>
</form>

<br>
<a href="dashboard.jsp">⬅ Back to Dashboard</a>

</body>
</html>
