<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.time.*, com.oceanview.dao.GuestDAO, com.oceanview.model.Guest" %>

<%
if (session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}

GuestDAO dao = new GuestDAO();
List<Guest> guestList = dao.getAllGuests();

int totalReservations = guestList.size();

// Today's Count + Monthly Count
int todayCount = 0;
LocalDate today = LocalDate.now();
int[] monthlyCount = new int[12];

for(Guest g : guestList){
    if(g.getCheckInDate() != null){
        LocalDate checkIn = LocalDate.parse(g.getCheckInDate());

        if(checkIn.equals(today)){
            todayCount++;
        }

        if(checkIn.getYear() == today.getYear()){
            int monthIndex = checkIn.getMonthValue() - 1;
            monthlyCount[monthIndex]++;
        }
    }
}

// Room Availability
int totalRooms = 25;
int availableRooms = totalRooms - totalReservations;

// Recent 5
List<Guest> recentList = guestList.size() > 5 ?
guestList.subList(guestList.size()-5, guestList.size()) : guestList;
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard - OceanView Resort</title>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    background-image:url('images/istockphoto-929948438-612x612.jpg');
    background-size:cover;
    background-attachment:fixed;
    font-family:'Segoe UI', Arial;
    margin:0;
    color:white;
}

.dashboard{
    width:90%;
    margin:120px auto 50px auto;
}

.card-container{
    display:flex;
    gap:30px;
    justify-content:center;
    flex-wrap:wrap;
}

.card{
    background:rgba(0,0,0,0.75);
    padding:30px;
    border-radius:15px;
    width:250px;
    text-align:center;
    border:2px solid #00bcd4;
    box-shadow:0 0 15px rgba(0,188,212,0.4);
}

.card h2{
    font-size:2.8rem;
    color:#00bcd4;
}

.btn-area{
    text-align:center;
    margin:40px 0;
}

.btn{
    display:inline-block;
    padding:15px 40px;
    margin:10px;
    background:#00bcd4;
    border-radius:40px;
    text-decoration:none;
    color:white;
    font-weight:bold;
    transition:0.4s;
}

.btn:hover{
    background:white;
    color:#333;
    transform:scale(1.1);
}

.table-box{
    background:rgba(0,0,0,0.85);
    padding:25px;
    border-radius:15px;
    margin-top:30px;
}

table{
    width:100%;
    border-collapse:collapse;
}

th, td{
    padding:12px;
    border:1px solid rgba(255,255,255,0.2);
}

th{
    background:#333;
    color:#00bcd4;
}
</style>
</head>

<body>

<%@ include file="header.jsp" %>

<div class="dashboard">

<h1 style="text-align:center; color:#00bcd4;">
Welcome, <%= session.getAttribute("user") %>
</h1>

<!-- Cards -->
<div class="card-container">
<div class="card">
    <span>Total Reservations</span>
    <h2 id="totalCounter">0</h2>
</div>

<div class="card">
    <span>Today's Reservations</span>
    <h2 id="todayCounter">0</h2>
</div>

<div class="card">
    <span>Available Rooms</span>
    <h2 id="availableCounter">0</h2>
</div>
</div>

<!-- Buttons -->
<div class="btn-area">
    <a href="register.jsp" class="btn">Add New Reservation</a>
    <a href="viewReservations.jsp" class="btn">View All Reservations</a>
</div>

<!-- Monthly Chart -->
<div class="table-box">
<h2 style="color:#00bcd4; text-align:center;">
Monthly Booking Chart (<%= today.getYear() %>)
</h2>
<canvas id="monthlyChart"></canvas>
</div>

<!-- Recent 5 -->
<div class="table-box">
<h2 style="color:#00bcd4;">Recent 5 Reservations</h2>
<table>
<tr>
    <th>Name</th>
    <th>Room</th>
    <th>Check-In</th>
</tr>

<%
for(Guest g : recentList){
%>
<tr>
    <td><%= g.getGuestName() %></td>
    <td><%= g.getRoomType() %></td>
    <td><%= g.getCheckInDate() %></td>
</tr>
<% } %>
</table>
</div>

</div>

<!-- Animated Counters -->
<script>
function animateValue(id, start, end, duration) {
    if(end == 0){
        document.getElementById(id).textContent = 0;
        return;
    }
    let range = end - start;
    let current = start;
    let increment = end > start ? 1 : -1;
    let stepTime = Math.abs(Math.floor(duration / end));
    let obj = document.getElementById(id);

    let timer = setInterval(function() {
        current += increment;
        obj.textContent = current;
        if (current == end) {
            clearInterval(timer);
        }
    }, stepTime);
}

window.onload = function(){
    animateValue("totalCounter", 0, <%= totalReservations %>, 1000);
    animateValue("todayCounter", 0, <%= todayCount %>, 1000);
    animateValue("availableCounter", 0, <%= availableRooms %>, 1000);

    // Chart
    const ctx = document.getElementById('monthlyChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
            datasets: [{
                label: 'Reservations',
                data: [
                    <%= monthlyCount[0] %>, <%= monthlyCount[1] %>,
                    <%= monthlyCount[2] %>, <%= monthlyCount[3] %>,
                    <%= monthlyCount[4] %>, <%= monthlyCount[5] %>,
                    <%= monthlyCount[6] %>, <%= monthlyCount[7] %>,
                    <%= monthlyCount[8] %>, <%= monthlyCount[9] %>,
                    <%= monthlyCount[10] %>, <%= monthlyCount[11] %>
                ],
                backgroundColor: 'rgba(0,188,212,0.6)',
                borderColor: '#00bcd4',
                borderWidth: 2
            }]
        },
        options: {
            scales: {
                x: { ticks: { color: 'white' } },
                y: { ticks: { color: 'white' } }
            },
            plugins: {
                legend: {
                    labels: { color: 'white' }
                }
            }
        }
    });
};
</script>

</body>
</html>