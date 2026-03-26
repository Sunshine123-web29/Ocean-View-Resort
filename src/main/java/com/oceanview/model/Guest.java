package com.oceanview.model;

/**
 * Model class for Guest
 * This demonstrates Encapsulation for the Online Room Reservation System.
 */
public class Guest {
    // 1. Private Attributes (Encapsulation)
    private int reservationNo;
    private String guestName;
    private String address;
    private String contactNumber;
    private String roomType;
    private String checkInDate;
    private String checkOutDate;

    // 2. Default Constructor
    public Guest() {
    }

    // 3. Parameterized Constructor
    public Guest(int reservationNo, String guestName, String address, String contactNumber, 
                 String roomType, String checkInDate, String checkOutDate) {
        this.reservationNo = reservationNo;
        this.guestName = guestName;
        this.address = address;
        this.contactNumber = contactNumber;
        this.roomType = roomType;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    // 4. Getters and Setters
    public int getReservationNo() {
        return reservationNo;
    }

    public void setReservationNo(int reservationNo) {
        this.reservationNo = reservationNo;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }

    public String getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        this.checkOutDate = checkOutDate;
    }
}