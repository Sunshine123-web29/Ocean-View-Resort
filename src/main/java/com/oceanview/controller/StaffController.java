package com.oceanview.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation for Admin to register new staff members.
 * This class handles the backend logic for adding users to the database.
 */
@WebServlet("/StaffController")
public class StaffController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles the POST request from the manageStaff.jsp form.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Retrieve data sent from the manageStaff.jsp form
        String user = request.getParameter("newUsername");
        String pass = request.getParameter("newPassword");
        String role = request.getParameter("newRole");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // 2. Establish connection to the MySQL database via DBConnection class
            conn = DBConnection.getConnection();
            
            // 3. SQL Query to insert a new user record into the 'users' table
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, role);
            
            // 4. Execute the update to save data to the database
            int result = ps.executeUpdate();

            if (result > 0) {
                // If successful, redirect back to the home/dashboard with a success status
                response.sendRedirect("home.jsp?status=staff_added");
            } else {
                // If the update failed, return to the management page with an error
                response.sendRedirect("manageStaff.jsp?error=failed");
            }

        } catch (Exception e) {
            // Log the error and notify the user of a server-side problem
            e.printStackTrace();
            response.sendRedirect("manageStaff.jsp?error=server");
        } finally {
            // 5. Resource Management: Ensure database connections are closed to prevent leaks
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}