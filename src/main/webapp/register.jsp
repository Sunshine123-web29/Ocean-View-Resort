<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Guest Registration - OceanView Resort</title>
    <script>
        // Function to ensure Check-out is after Check-in
        function validateDates() {
            var checkIn = new Date(document.getElementsByName("checkInDate")[0].value);
            var checkOut = new Date(document.getElementsByName("checkOutDate")[0].value);

            if (checkOut <= checkIn) {
                alert("Error: Check-out date must be after the Check-in date!");
                return false; // Stops the form from submitting
            }
            return true; // Allows the form to submit
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: -1;">
        <img src="images/istockphoto-929948438-612x612.jpg" alt="OceanView Resort" 
             style="width: 100vw; height: 100vh; object-fit: cover;">
    </div>

    <div style="background: rgba(255, 255, 255, 0.8); width: 400px; margin: 50px auto; padding: 20px; border-radius: 10px;">
        <h2>OceanView Resort - Room Reservation</h2>
        
        <form action="ReservationController" method="post" onsubmit="return validateDates()">
            <table>
                <tr>
                    <td>Guest Name:</td>
                    <td><input type="text" name="guestName" required></td>
                </tr>
                <tr>
                    <td>Address:</td>
                    <td><input type="text" name="address" required></td>
                </tr>
                <tr>
                    <td>Contact No:</td>
                    <td>
                        <input type="text" name="contactNumber" 
                               pattern="[0-9]{10}" 
                               title="Please enter a 10-digit phone number (e.g., 0771234567)" 
                               required>
                    </td>
                </tr>
                <tr>
                    <td>Room Type:</td>
                    <td>
                        <select name="roomType">
                            <option value="Single">Single</option>
                            <option value="Double">Double</option>
                            <option value="Luxury">Luxury</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Check-in Date:</td>
                    <td><input type="date" name="checkInDate" required></td>
                </tr>
                <tr>
                    <td>Check-out Date:</td>
                    <td><input type="date" name="checkOutDate" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Reserve Now" style="cursor: pointer;"></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>