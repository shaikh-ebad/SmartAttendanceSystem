<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Login | Smart Attendance</title>
    <style>
        body { font-family: 'Segoe UI', Arial; background-color: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 100%; max-width: 380px; }
        h2 { color: #1a73e8; text-align: center; }
        .input-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; color: #666; }
        input[type="email"], input[type="password"] { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        input[type="submit"] { width: 100%; background: #1a73e8; color: white; border: none; padding: 12px; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px; }
        .error-msg { background: #fde8e8; color: #c81e1e; padding: 10px; border-radius: 5px; text-align: center; margin-bottom: 20px; border: 1px solid #f8b4b4; }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Teacher Login</h2>

        <%-- Check for error parameter without JSTL --%>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="error-msg">Invalid email or password.</div>
        <% } %>

        <form action="teacherLogin" method="post">
            <div class="input-group">
                <label>Email Address</label>
                <input type="email" name="email" required>
            </div>
            <div class="input-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            <input type="submit" value="Sign In">
        </form>
    </div>
</body>
</html>