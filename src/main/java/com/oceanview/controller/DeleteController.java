package com.oceanview.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.oceanview.dao.GuestDAO;

/**
 * Servlet implementation for deleting guest reservations.
 * Restricted to users with the 'ADMIN' role for system security.
 */
@WebServlet("/DeleteController")
public class DeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles the deletion request.
     * Verifies user session and role before interacting with the database.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Retrieve the current session and user role
        HttpSession session = request.getSession(false); // Do not create a new session if one doesn't exist
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // 2. Security Check: Only allow 'ADMIN' to delete records
        if (role == null || !"ADMIN".equals(role)) {
            // Redirect unauthorized users back to the view page with an error message
            response.sendRedirect("viewReservations.jsp?error=unauthorized");
            return; // Stop further execution for security
        }

        // 3. Retrieve the ID parameter of the reservation to be deleted
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                
                // 4. Initialize DAO and perform database deletion
                GuestDAO dao = new GuestDAO();
                dao.deleteGuest(id);
                
            } catch (NumberFormatException e) {
                // Log formatting errors if the ID is invalid
                e.printStackTrace();
            }
        }

        // 5. Redirect back to the reservation list after successful deletion
        response.sendRedirect("viewReservations.jsp?success=deleted");
    }
}