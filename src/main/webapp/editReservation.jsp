<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.dao.GuestDAO, com.oceanview.model.Guest" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Reservation - OceanView Resort</title>
    <script>
        // JavaScript to ensure Check-out is after Check-in
        function validateDates() {
            var checkIn = new Date(document.getElementsByName("checkInDate")[0].value);
            var checkOut = new Date(document.getElementsByName("checkOutDate")[0].value);

            if (checkOut <= checkIn) {
                alert("Error: Check-out date must be after the Check-in date!");
                return false; 
            }
            return true; 
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: -1;">
        <img src="images/istockphoto-929948438-612x612.jpg" alt="Background" 
             style="width: 100vw; height: 100vh; object-fit: cover;">
    </div>

    <%
        // Get ID from URL and fetch existing data
        String idParam = request.getParameter("id");
        Guest existingGuest = null;
        
        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            GuestDAO dao = new GuestDAO();
            for(Guest g : dao.getAllGuests()) {
                if(g.getReservationNo() == id) {
                    existingGuest = g;
                    break;
                }
            }
        }

        // Redirect if guest is not found
        if (existingGuest == null) {
            response.sendRedirect("viewReservations.jsp");
            return;
        }
    %>

    <div style="background: rgba(255, 255, 255, 0.85); width: 450px; margin: 50px auto; padding: 25px; border-radius: 15px; box-shadow: 0px 4px 10px rgba(0,0,0,0.3);">
        <h2 style="text-align: center; color: #333;">Edit Your Reservation</h2>
        
        <form action="UpdateController" method="post" onsubmit="return validateDates()">
            <input type="hidden" name="reservationNo" value="<%= existingGuest.getReservationNo() %>">
            
            <table cellpadding="10" style="width: 100%;">
                <tr>
                    <td>Guest Name:</td>
                    <td><input type="text" name="guestName" value="<%= existingGuest.getGuestName() %>" required style="width: 100%;"></td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td><input type="text" name="address" value="<%= existingGuest.getAddress() %>" required style="width: 100%;"></td>
                </tr>
                <tr>
                    <td>Contact No:</td>
                    <td>
                        <input type="text" name="contactNumber" value="<%= existingGuest.getContactNumber() %>"
                               pattern="[0-9]{10}" title="Please enter a 10-digit phone number" required style="width: 100%;">
                    </td>
                </tr>
                <tr>
                    <td>Room Type:</td>
                    <td>
                        <select name="roomType" style="width: 100%; padding: 5px;">
                            <option value="Single" <%= existingGuest.getRoomType().equals("Single") ? "selected" : "" %>>Single</option>
                            <option value="Double" <%= existingGuest.getRoomType().equals("Double") ? "selected" : "" %>>Double</option>
                            <option value="Luxury" <%= existingGuest.getRoomType().equals("Luxury") ? "selected" : "" %>>Luxury</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Check-in:</td>
                    <td><input type="date" name="checkInDate" value="<%= existingGuest.getCheckInDate() %>" required style="width: 100%;"></td>
                </tr>
                <tr>
                    <td>Check-out:</td>
                    <td><input type="date" name="checkOutDate" value="<%= existingGuest.getCheckOutDate() %>" required style="width: 100%;"></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" value="Update Reservation" 
                               style="width: 100%; padding: 10px; background-color: #00bcd4; color: white; border: none; cursor: pointer; font-weight: bold; border-radius: 5px;">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>