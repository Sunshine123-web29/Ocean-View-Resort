<%@ page import="java.util.*, com.oceanview.dao.GuestDAO, com.oceanview.model.Guest" %>

<%
    // Session Security Check: Ensure user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Retrieve the user's role from the session
    String role = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html>
<head>
    <title>View All Reservations - OceanView Resort</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.23/jspdf.plugin.autotable.min.js"></script>

    <script>
    // Calculate and Download Bill as PDF
    function generateBill(name, roomType, checkIn, checkOut) {
        let rate = 0;
        // Room Rates logic
        if (roomType === "Single") rate = 5000;
        else if (roomType === "Double") rate = 8000;
        else if (roomType === "Luxury" || roomType === "Suite") rate = 15000;
        else rate = 5000;

        let d1 = new Date(checkIn);
        let d2 = new Date(checkOut);
        let diff = Math.abs(d2 - d1);
        let days = Math.ceil(diff / (1000 * 60 * 60 * 24));
        if(days == 0) days = 1;

        let total = days * rate;

        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        // Bill Header Design
        doc.setFontSize(22);
        doc.setTextColor(0, 188, 212); 
        doc.text("OCEANVIEW RESORT", 105, 20, { align: "center" });
        
        doc.setFontSize(10);
        doc.setTextColor(100);
        doc.text("Galle, Sri Lanka | Email: info@oceanview.com", 105, 27, { align: "center" });
        
        doc.setLineWidth(0.5);
        doc.line(20, 32, 190, 32);

        doc.setFontSize(16);
        doc.setTextColor(0);
        doc.text("GUEST INVOICE", 105, 45, { align: "center" });

        // Bill Content
        doc.setFontSize(12);
        doc.text("Guest Name:", 25, 60); doc.text(name, 70, 60);
        doc.text("Room Type:", 25, 70); doc.text(roomType, 70, 70);
        doc.text("Check-In:", 25, 80); doc.text(checkIn, 70, 80);
        doc.text("Check-Out:", 25, 90); doc.text(checkOut, 70, 90);
        doc.text("Stay Duration:", 25, 100); doc.text(days + " Night(s)", 70, 100);
        doc.text("Rate per Night:", 25, 110); doc.text("Rs. " + rate + ".00", 70, 110);

        doc.setLineWidth(0.2);
        doc.line(20, 120, 190, 120);
        
        doc.setFontSize(14);
        doc.setFont("helvetica", "bold");
        doc.text("Total Amount Payable:", 25, 130);
        doc.text("Rs. " + total + ".00", 140, 130);

        doc.setFontSize(10);
        doc.setFont("helvetica", "normal");
        doc.text("--- Thank you for choosing OceanView Resort ---", 105, 155, { align: "center" });
        doc.text("Generated on: " + new Date().toLocaleString(), 105, 162, { align: "center" });

        doc.save("Bill_" + name.replace(/\s+/g, '_') + ".pdf");
    }
    </script>

    <style>
        body { background-image: url('images/istockphoto-929948438-612x612.jpg'); background-size: cover; background-attachment: fixed; color: white; font-family: 'Segoe UI', Arial, sans-serif; }
        table { width: 95%; margin: 20px auto; background: rgba(0, 0, 0, 0.8); border-collapse: collapse; border-radius: 10px; overflow: hidden; }
        th, td { padding: 12px; border: 1px solid rgba(255,255,255,0.2); text-align: left; }
        th { background: #333; color: #00bcd4; }
        tr:hover { background: rgba(255, 255, 255, 0.1); }
        .controls { margin: 20px auto; width: 95%; display: flex; justify-content: space-between; align-items: center; background: rgba(0,0,0,0.6); padding: 15px; border-radius: 8px; }
        #searchInput { padding: 10px; width: 300px; border-radius: 5px; border: 1px solid #00bcd4; background: white; color: black; }
        .btn { padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; font-size: 13px; }
        .btn-print { background-color: #4CAF50; color: white; }
        .btn-pdf { background-color: #e91e63; color: white; margin-left: 10px; }
        .btn-bill { background-color: #00bcd4; color: black; margin-right: 5px; }
        .btn-edit { background-color: #2196F3; color: white; margin-right: 5px; }
        .btn-delete { background-color: #ff4d4d; color: white; }

        @media print {
            nav, .no-print, #searchInput { display: none !important; }
            body { background: white; color: black; }
            table { width: 100%; background: white; color: black; border: 1px solid black; }
            th, td { border: 1px solid black; color: black; }
            th { background: #eee; }
        }
    </style>
</head>

<body>

    <%@ include file="header.jsp" %>

    <div style="text-align:right; margin:15px 50px; font-weight:bold;">
        Welcome, <%= session.getAttribute("user") %> (<%= role %>) |
        <a href="LogoutController" style="color: #ff4d4d; text-decoration:none;">Logout</a>
    </div>

    <h2 style="text-align:center; text-shadow: 2px 2px 4px #000;">
        OceanView Resort - All Reservations
    </h2>

    <div class="controls no-print">
        <div>
            <button class="btn btn-print" onclick="window.print()">Print List</button>
            <button class="btn btn-pdf" onclick="downloadPDF()">Export PDF</button>
        </div>
        <input type="text" id="searchInput" onkeyup="searchFunction()" placeholder="Search by Guest Name...">
    </div>

    <table id="reservationTable">
        <thead>
            <tr>
                <th>No</th>
                <th>Name</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Room</th>
                <th>Check-In</th>
                <th>Check-Out</th>
                <th class="no-print">Actions</th>
            </tr>
        </thead>

        <tbody>
            <%
                GuestDAO dao = new GuestDAO();
                List<Guest> list = dao.getAllGuests();
                int count = 1;

                for(Guest g : list) {
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= g.getGuestName() %></td>
                <td><%= g.getAddress() %></td>
                <td><%= g.getContactNumber() %></td>
                <td><%= g.getRoomType() %></td>
                <td><%= g.getCheckInDate() %></td>
                <td><%= g.getCheckOutDate() %></td>
                <td class="no-print" style="white-space: nowrap;">
                    <button class="btn btn-bill" onclick="generateBill('<%= g.getGuestName() %>', '<%= g.getRoomType() %>', '<%= g.getCheckInDate() %>', '<%= g.getCheckOutDate() %>')">
                        Bill
                    </button>

                    <a href="editReservation.jsp?id=<%= g.getReservationNo() %>" class="btn btn-edit">Edit</a>

                    <% if ("ADMIN".equals(role)) { %>
                        <a href="DeleteController?id=<%= g.getReservationNo() %>" 
                           onclick="return confirm('Confirm deletion of this record?')" class="btn btn-delete">Delete</a>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <script>
        function searchFunction() {
            let input = document.getElementById("searchInput");
            let filter = input.value.toUpperCase();
            let table = document.getElementById("reservationTable");
            let tr = table.getElementsByTagName("tr");

            for (let i = 1; i < tr.length; i++) {
                let td = tr[i].getElementsByTagName("td")[1];
                if (td) {
                    let txtValue = td.textContent || td.innerText;
                    tr[i].style.display = txtValue.toUpperCase().indexOf(filter) > -1 ? "" : "none";
                }
            }
        }

        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            doc.setFontSize(18);
            doc.text("OceanView Resort - Full Reservation Report", 14, 20);
            doc.setFontSize(11);
            doc.text("Generated on: " + new Date().toLocaleString(), 14, 28);

            doc.autoTable({
                html: '#reservationTable',
                startY: 35,
                theme: 'grid',
                headStyles: { fillColor: [51, 51, 51] },
                columns: [
                    { header: 'No', dataKey: 0 },
                    { header: 'Name', dataKey: 1 },
                    { header: 'Address', dataKey: 2 },
                    { header: 'Contact', dataKey: 3 },
                    { header: 'Room', dataKey: 4 },
                    { header: 'Check-In', dataKey: 5 },
                    { header: 'Check-Out', dataKey: 6 }
                ]
            });
            doc.save("OceanView_Full_Report.pdf");
        }
    </script>
</body>
</html>