package com.oceanview.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation for User Authentication (Login)
 * Handles both GET (Redirects) and POST (Authentication logic).
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Prevents "405 Method Not Allowed" errors.
     * If a user tries to access this servlet via a direct URL, they are sent back to the login page.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Automatically redirect GET requests back to the login page
        response.sendRedirect("login.jsp");
    }

    /**
     * Handles the login form submission via POST.
     * Validates Username, Password, and Role against the MySQL Database.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve data from the login.jsp form
        String uname = request.getParameter("username");
        String pass = request.getParameter("password");
        String selectedRole = request.getParameter("role"); // Values from dropdown: 'ADMIN' or 'STAFF'

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // 2. Connect to the MySQL Database (oceanview_db)
            conn = DBConnection.getConnection();
            
            // 3. SQL query to verify all credentials and the specific role
            String sql = "SELECT role FROM users WHERE username = ? AND password = ? AND role = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, uname);
            ps.setString(2, pass);
            ps.setString(3, selectedRole);

            rs = ps.executeQuery();

            // 4. Check if a matching record exists in the 'users' table
            if (rs.next()) {
                String dbRole = rs.getString("role");

                // 5. Success: Create a Session and store user information
                HttpSession session = request.getSession();
                session.setAttribute("user", uname);
                session.setAttribute("role", dbRole); // Required for Access Control logic

                // Redirect to the landing page
                response.sendRedirect("home.jsp");

            } else {
                // 6. Failure: Incorrect credentials or role mismatch
                request.setAttribute("errorMessage", "Invalid Username, Password, or Role selection!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Handle unexpected server or SQL errors
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=server_error");
        } finally {
            // 7. Close all database resources to prevent leaks
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}