<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Session Security Check
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Help & User Guide - OceanView Resort</title>
    <style>
        body { 
            background-image: url('images/istockphoto-929948438-612x612.jpg'); 
            background-size: cover; 
            background-attachment: fixed;
            color: white; 
            font-family: 'Segoe UI', Arial, sans-serif; 
            margin: 0;
        }
        .help-container {
            width: 70%;
            margin: 100px auto 50px auto;
            background: rgba(0, 0, 0, 0.85);
            padding: 40px;
            border-radius: 15px;
            border: 1px solid #00bcd4;
            box-shadow: 0 0 20px rgba(0, 188, 212, 0.3);
        }
        h1, h2 { color: #00bcd4; border-bottom: 1px solid rgba(0, 188, 212, 0.3); padding-bottom: 10px; }
        .step { margin-bottom: 25px; }
        .step h3 { color: #fff; margin-bottom: 5px; }
        .step p { color: #ccc; line-height: 1.6; }
        .badge {
            background: #00bcd4;
            color: black;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            margin-right: 10px;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            color: #00bcd4;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="help-container">
        <h1>User Guide & Guidelines</h1>
        <p>Welcome to the OceanView Resort Reservation System. This guide helps new staff members to navigate through the system efficiently.</p>

        <div class="step">
            <h3><span class="badge">STEP 1</span> Dashboard & Overview</h3>
            <p>After logging in, you will see the Dashboard. It displays real-time statistics like Total Reservations and Available Rooms. Use the Chart to analyze booking trends.</p>
        </div>

        <div class="step">
            <h3><span class="badge">STEP 2</span> Making a New Reservation</h3>
            <p>Go to the <strong>'Add Reservation'</strong> section. Enter the guest's name, address, contact number, and select the room type. Ensure the Check-in and Check-out dates are accurate before saving.</p>
        </div>

        <div class="step">
            <h3><span class="badge">STEP 3</span> Managing Records (Edit/Delete)</h3>
            <p>In the <strong>'View All Reservations'</strong> page, you can search for a specific guest. Use the 'Edit' button to update details or 'Delete' to remove a record permanently.</p>
        </div>

        <div class="step">
            <h3><span class="badge">STEP 4</span> Generating Bills & Reports</h3>
            <p>Click the <strong>'Bill'</strong> button next to any guest record to instantly calculate their total cost and download a PDF receipt. Use the 'Export PDF' button to get a full list of all guests.</p>
        </div>

        <div class="step">
            <h3><span class="badge">STEP 5</span> Secure Logout</h3>
            <p>Always ensure you <strong>Logout</strong> after your shift to protect guest data and system security.</p>
        </div>

        <a href="home.jsp" class="back-btn">← Back to Dashboard</a>
    </div>

</body>
</html>