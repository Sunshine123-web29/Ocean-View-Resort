package com.oceanview.model;

public class User {
    private String username;
    private String role;

    // Constructor name must match the Class name exactly
    public User(String username, String role) {
        this.username = username;
        this.role = role;
    }

    public String getUsername() { 
        return username; 
    }
    
    public String getRole() { 
        return role; 
    }
}