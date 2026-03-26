<%
    // Retrieve the user's role and username from the session for the navigation bar
    String sessionUser = (String) session.getAttribute("user");
    String sessionRole = (String) session.getAttribute("role");
%>

<nav style="
    background-color: rgba(0, 0, 0, 0.8);  /* Semi-transparent dark background */
    padding: 15px;
    text-align: center;
    margin-bottom: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.5);
    font-family: 'Segoe UI', Arial, sans-serif;
">
    <a href="home.jsp" class="nav-link">Home</a>
    <a href="register.jsp" class="nav-link">Add Reservation</a>
    <a href="viewReservations.jsp" class="nav-link">View All Records</a>

    <%-- 
        ADMIN ONLY OPTION: 
        Only show the 'Manage Staff' link if the logged-in user is an ADMIN 
    --%>
    <% if ("ADMIN".equals(sessionRole)) { %>
        <a href="manageStaff.jsp" class="nav-link" style="color: #00bcd4;">Manage Staff</a>
    <% } %>

    <a href="help.jsp" class="nav-link" style="color: #ffeb3b;">Help?</a>
    
    <a href="LogoutController" class="nav-link" style="color: #ff4d4d; margin-left: 30px;">Logout</a>
</nav>

<style>
    /* Navigation Links Styling */
    .nav-link {
        color: #ffffff;
        margin: 0 15px;
        text-decoration: none;
        font-weight: bold;
        font-size: 15px;
        transition: all 0.3s ease;
        padding: 5px 10px;
        border-radius: 4px;
    }

    /* Hover effect for better Interactivity */
    .nav-link:hover {
        color: #00bcd4;
        background-color: rgba(255, 255, 255, 0.1);
    }
</style>