package com.oceanview.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.oceanview.model.Guest; 
import com.oceanview.dao.GuestDAO;


@WebServlet("/ReservationController")
public class ReservationController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Creating an object of GuestDAO to handle database operations
    private GuestDAO guestDAO = new GuestDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Get data from JSP
        String name = request.getParameter("guestName");
        String address = request.getParameter("address");
        String contact = request.getParameter("contactNumber");
        String roomType = request.getParameter("roomType");
        String checkIn = request.getParameter("checkInDate");
        String checkOut = request.getParameter("checkOutDate");

        // 2. Wrap data in Guest Model object
        Guest newGuest = new Guest(0, name, address, contact, roomType, checkIn, checkOut);

        // 3. Call DAO to save data into Database
        int result = guestDAO.registerGuest(newGuest);

        // 4. Redirect based on the result
        if (result > 0) {
            // Success: Redirect back with success message
            response.sendRedirect("register.jsp?status=success");
        } else {
            // Failure: Redirect back with error message
            response.sendRedirect("register.jsp?status=fail");
        }
    }
}