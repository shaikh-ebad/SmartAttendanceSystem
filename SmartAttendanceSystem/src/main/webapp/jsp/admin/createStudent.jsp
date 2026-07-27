<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="page-wrapper">

    <h2>👨‍🎓 Create Student</h2>

    <!-- SAME LOGIC (UNCHANGED) -->
    <form action="../../studentCreate" method="post">

        <div class="form-group">
            <label>Name:</label>
            <input type="text" name="name" required>
        </div>

        <div class="form-group">
            <label>Class ID:</label>
            <input type="number" name="classId" required>
        </div>

        <input type="submit" value="Create Student">

    </form>

    <!-- BACK BUTTON -->
    <div class="back-link">
       <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp" target="_top">
    ← Back to Dashboard
</a>
    </div>

</div>

<style>
/* DARK THEME MATCHING DASHBOARD */
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
input[type="number"] {
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