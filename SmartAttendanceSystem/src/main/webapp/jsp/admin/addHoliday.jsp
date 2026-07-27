<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Holiday</title>

<style>
/* SAME THEME */
body {
    font-family: 'DM Sans', sans-serif;
    background: #0d0c0b;
    color: #f0e8dc;
    margin: 0;
    padding: 30px;
}

/* PAGE WRAPPER */
.page-wrapper {
    background: #161513;
    padding: 40px;
    border-radius: 16px;
    border: 1px solid #ffffff14;
    max-width: 700px;
    margin: auto;
    box-shadow: 0 10px 30px rgba(0,0,0,0.4);
}

/* TITLE */
h2 {
    text-align: center;
    margin-bottom: 30px;
    font-weight: 400;
}

/* FORM GROUP */
.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 6px;
    font-size: 12px;
    color: #a09080;
}

/* INPUTS */
input[type="date"],
input[type="text"] {
    width: 100%;
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #ffffff14;
    background: #0d0c0b;
    color: #f0e8dc;
}

input:focus {
    outline: none;
    border-color: #c8a97e;
}

/* BUTTON */
input[type="submit"] {
    width: 100%;
    padding: 12px;
    background: #c8a97e;
    color: #0d0c0b;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    font-weight: 600;
    margin-top: 10px;
}

input[type="submit"]:hover {
    opacity: 0.85;
}

/* BACK BUTTON */
.back-link {
    text-align: center;
    margin-top: 20px;
}

.back-link a {
    color: #c8a97e;
    text-decoration: none;
}

.back-link a:hover {
    text-decoration: underline;
}
</style>

</head>

<body>

<div class="page-wrapper">

    <h2>🎉 Add Holiday</h2>

    <form action="${pageContext.request.contextPath}/holiday" method="post">

        <div class="form-group">
            <label>Date:</label>
            <input type="date" name="date" required>
        </div>

        <div class="form-group">
            <label>Description:</label>
            <input type="text" name="desc" placeholder="e.g., New Year's Day" required>
        </div>

        <input type="submit" value="Add Holiday">

    </form>

    <!-- BACK BUTTON -->
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp" target="_top">
    ← Back to Dashboard
</a>
    </div>

</div>

</body>
</html>