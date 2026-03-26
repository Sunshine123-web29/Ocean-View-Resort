<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security Check: Only allow logged-in Admins to access this page
    String userRole = (String) session.getAttribute("role");
    if (session.getAttribute("user") == null || !"ADMIN".equals(userRole)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Staff - OceanView Resort</title>
    <style>
        body { 
            font-family: 'Segoe UI', Arial, sans-serif; 
            background-image: url('images/istockphoto-929948438-612x612.jpg'); 
            background-size: cover; 
            background-attachment: fixed;
            color: #333;
        }
        .container { 
            background: rgba(255, 255, 255, 0.95); 
            padding: 30px; 
            border-radius: 12px; 
            width: 400px; 
            margin: 80px auto; 
            box-shadow: 0px 8px 20px rgba(0,0,0,0.5); 
            text-align: center;
        }
        h2 { color: #00bcd4; margin-bottom: 20px; }
        input, select { 
            width: 100%; 
            padding: 12px; 
            margin: 10px 0; 
            border-radius: 6px; 
            border: 1px solid #ccc; 
            box-sizing: border-box; 
        }
        .btn { 
            background-color: #00bcd4; 
            color: white; 
            border: none; 
            cursor: pointer; 
            font-weight: bold; 
            font-size: 16px;
            transition: 0.3s;
            width: 100%;
            padding: 12px;
        }
        .btn:hover { background-color: #0097a7; }
        .alert { padding: 10px; margin-bottom: 15px; border-radius: 5px; font-weight: bold; }
        .error { background-color: #ffcdd2; color: #c62828; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h2>Register New Staff</h2>

        <%-- Display Error Message if Registration Fails --%>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert error">
                Registration Failed! Please try again.
            </div>
        <% } %>

        <form action="StaffController" method="post">
            <label style="display: block; text-align: left; font-weight: bold;">Username</label>
            <input type="text" name="newUsername" placeholder="Enter unique username" required>
            
            <label style="display: block; text-align: left; font-weight: bold;">Password</label>
            <input type="password" name="newPassword" placeholder="Enter password" required>
            
            <label style="display: block; text-align: left; font-weight: bold;">Assign Role</label>
            <select name="newRole">
                <option value="STAFF">Staff (Reception)</option>
                <option value="ADMIN">Administrator</option>
            </select>
            
            <input type="submit" value="Add Member" class="btn">
        </form>
        
        <div style="margin-top: 20px;">
            <a href="home.jsp" style="text-decoration: none; color: #555; font-size: 14px;">← Back to Home</a>
        </div>
    </div>
</body>
</html>