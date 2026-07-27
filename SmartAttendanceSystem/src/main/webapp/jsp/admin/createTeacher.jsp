<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="page-wrapper">

    <h2>👨‍🏫 Create Teacher</h2>

    <!-- SAME LOGIC (UNCHANGED) -->
    <form action="../../teacherCreate" method="post">

        <div class="form-group">
            <label>Name</label>
            <input type="text" name="name" required>
        </div>

        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <input type="submit" value="Create Teacher">

    </form>

    <% if (request.getParameter("success") != null) { %>
        <p class="success">Teacher created successfully!</p>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
        <p class="error">Error creating teacher!</p>
    <% } %>

    <!-- BACK BUTTON -->
    <div class="back-link">
     <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp" target="_top">
    ← Back to Dashboard
</a>
    </div>

</div>

<style>
/* DARK THEME */
.page-wrapper {
    background: #161513;
    padding: 40px;
    border-radius: 16px;
    border: 1px solid #ffffff14;
    max-width: 700px;
    margin: auto;
    box-shadow: 0 10px 30px rgba(0,0,0,0.4);
    color: #f0e8dc;
}

/* TITLE */
h2 {
    text-align: center;
    margin-bottom: 30px;
    font-weight: 400;
}

/* FORM */
.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 6px;
    font-size: 12px;
    color: #a09080;
}

/* INPUT */
input[type="text"],
input[type="password"] {
    width: 100%;
    padding: 12px;
    border: 1px solid rgba(255,255,255,0.15); /* soft border */
    border-radius: 8px;
    background: #0d0c0b; /* dark background */
    color: #f0e8dc;
    font-size: 14px;
}

/* REMOVE WHITE OUTLINE */
input:focus {
    outline: none;
    border: 1px solid #c8a97e; /* gold highlight */
    box-shadow: 0 0 5px rgba(200,169,126,0.3);
}

input::placeholder {
    color: #6b6259;
}

/* FIX AUTOFILL (IMPORTANT) */
input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px #0d0c0b inset !important;
    -webkit-text-fill-color: #f0e8dc !important;
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

/* SUCCESS MESSAGE */
.success {
    margin-top: 15px;
    color: #4ade80;
    text-align: center;
    font-weight: 500;
}

/* ERROR MESSAGE */
.error {
    margin-top: 15px;
    color: #f87171;
    text-align: center;
    font-weight: 500;
}

/* BACK LINK */
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