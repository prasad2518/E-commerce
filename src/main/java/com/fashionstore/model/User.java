package com.fashionstore.model;

public class User {

    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String password;
    private String description;

    // Default Constructor
    public User() {

    }

    // Parameterized Constructor
    public User(int userId, String fullName, String email, String phone,
                String address, String password, String description) {

        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.password = password;
        this.description = description;
    }

    // Getters and Setters

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "User [userId=" + userId +
                ", fullName=" + fullName +
                ", email=" + email +
                ", phone=" + phone +
                ", address=" + address +
                ", description=" + description + "]";
    }
}