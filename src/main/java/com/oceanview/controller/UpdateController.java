package com.oceanview.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.oceanview.dao.GuestDAO;
import com.oceanview.model.Guest;

@WebServlet("/UpdateController")
public class UpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
       
        int id = Integer.parseInt(request.getParameter("reservationNo"));
        String name = request.getParameter("guestName");
        String address = request.getParameter("address");
        String contact = request.getParameter("contactNumber");
        String room = request.getParameter("roomType");
        String checkIn = request.getParameter("checkInDate");
        String checkOut = request.getParameter("checkOutDate");

        
        Guest guest = new Guest();
        guest.setReservationNo(id);
        guest.setGuestName(name);
        guest.setAddress(address);
        guest.setContactNumber(contact);
        guest.setRoomType(room);
        guest.setCheckInDate(checkIn);
        guest.setCheckOutDate(checkOut);

        
        GuestDAO dao = new GuestDAO();
        dao.updateGuest(guest);

        
        response.sendRedirect("viewReservations.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}