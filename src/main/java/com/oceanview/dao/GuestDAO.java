package com.oceanview.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.oceanview.model.Guest;
import com.oceanview.util.DBConnection;
import java.util.List;

import java.util.ArrayList;

import java.sql.*;

/**
 * Data Access Object (DAO) for Guest operations.
 */
public class GuestDAO {

    // SQL query to insert guest data into the 'guests' table
    private static final String INSERT_GUEST_SQL = "INSERT INTO guests (guestName, address, contactNumber, roomType, checkInDate, checkOutDate) VALUES (?, ?, ?, ?, ?, ?);";

    public int registerGuest(Guest guest) {
        int result = 0;

        // Using try-with-resources to automatically close the connection
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_GUEST_SQL)) {

            preparedStatement.setString(1, guest.getGuestName());
            preparedStatement.setString(2, guest.getAddress());
            preparedStatement.setString(3, guest.getContactNumber());
            preparedStatement.setString(4, guest.getRoomType());
            preparedStatement.setString(5, guest.getCheckInDate());
            preparedStatement.setString(6, guest.getCheckOutDate());

            // Execute the query
            result = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            // Print error details if any database issue occurs
            e.printStackTrace();
        }
        return result;
    }
    public List<Guest> getAllGuests() {
        List<Guest> guestList = new ArrayList<>();
        String sql = "SELECT * FROM guests";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Guest guest = new Guest();
                guest.setReservationNo(rs.getInt("reservationNo"));
                guest.setGuestName(rs.getString("guestName"));
                guest.setAddress(rs.getString("address"));
                guest.setContactNumber(rs.getString("contactNumber"));
                guest.setRoomType(rs.getString("roomType"));
                guest.setCheckInDate(rs.getString("checkInDate"));
                guest.setCheckOutDate(rs.getString("checkOutDate"));
                guestList.add(guest);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return guestList;
    }public boolean deleteGuest(int reservationNo) {
        boolean rowDeleted = false;
        String sql = "DELETE FROM guests WHERE reservationNo = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reservationNo);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }public boolean updateGuest(Guest guest) {
        boolean rowUpdated = false;
        String sql = "UPDATE guests SET guestName=?, address=?, contactNumber=?, roomType=?, checkInDate=?, checkOutDate=? WHERE reservationNo=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, guest.getGuestName());
            ps.setString(2, guest.getAddress());
            ps.setString(3, guest.getContactNumber());
            ps.setString(4, guest.getRoomType());
            ps.setString(5, guest.getCheckInDate());
            ps.setString(6, guest.getCheckOutDate());
            ps.setInt(7, guest.getReservationNo());
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }}