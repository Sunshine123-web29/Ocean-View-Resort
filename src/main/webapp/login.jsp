<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - OceanView Resort</title>
    <style>
        body {
            background-image: url('images/istockphoto-929948438-612x612.jpg');
            background-size: cover;
            background-attachment: fixed;
            font-family: 'Segoe UI', Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: rgba(0, 0, 0, 0.85);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.5);
            width: 380px;
            text-align: center;
            color: white;
            border: 1px solid #00bcd4;
        }
        input[type="text"], input[type="password"], select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 5px;
            border: none;
            outline: none;
            box-sizing: border-box; /* Prevents padding from affecting total width */
        }
        select {
            background-color: white;
            cursor: pointer;
            font-weight: bold;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #00bcd4;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            transition: 0.3s;
            margin-top: 10px;
        }
        input[type="submit"]:hover {
            background-color: #008c9e;
        }
        .error-msg {
            background-color: rgba(255, 77, 77, 0.2);
            color: #ff4d4d;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 14px;
            border: 1px solid #ff4d4d;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2 style="color: #00bcd4; margin-bottom: 5px;">OceanView Resort</h2>
        <p style="margin-bottom: 25px; font-size: 14px; color: #ccc;">Please enter your credentials</p>

        <%-- Check for error messages sent from the LoginController --%>
        <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="error-msg"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <form action="LoginController" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            
            <%-- Role Selection: Required for Role-Based Access Control (RBAC) --%>
            <select name="role" required>
                <option value="" disabled selected>Select Your Role</option>
                <option value="ADMIN">Administrator</option>
                <option value="STAFF">Receptionist / Staff</option>
            </select>

            <input type="submit" value="Login">
        </form>
        
        <p style="margin-top: 20px; font-size: 12px; color: #888;">&copy; 2026 OceanView Resort Management System</p>
    </div>

</body>
</html>