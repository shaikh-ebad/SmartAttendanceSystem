<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Subject</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<h2>Create Subject</h2>

<form action="createSubject" method="post">
    <label>Subject Name:</label><br>
    <input type="text" name="subject_name" required><br><br>

    <label>Class ID:</label><br>
    <input type="number" name="class_id" required><br><br>

    <button type="submit">Create Subject</button>
</form>

<br>
<a href="dashboard.jsp">⬅ Back to Dashboard</a>

</body>
</html>
