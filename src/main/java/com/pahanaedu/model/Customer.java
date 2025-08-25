package com.pahanaedu.model;

import java.sql.Timestamp;

public class Customer {
    private int customerId;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String membershipType;
    private double totalPurchases;
    private int loyaltyPoints;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Customer() {
        this.membershipType = "REGULAR";
        this.totalPurchases = 0.0;
        this.loyaltyPoints = 0;
    }

    // Constructor without timestamps and ID (for new customers)
    public Customer(String name, String email, String phone, String address) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.membershipType = "REGULAR";
        this.totalPurchases = 0.0;
        this.loyaltyPoints = 0;
    }

    // Constructor with essential fields
    public Customer(int customerId, String name, String email, String phone, String address,
                    String membershipType, double totalPurchases, int loyaltyPoints) {
        this.customerId = customerId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.membershipType = membershipType;
        this.totalPurchases = totalPurchases;
        this.loyaltyPoints = loyaltyPoints;
    }

    // Constructor with all fields
    public Customer(int customerId, String name, String email, String phone, String address,
                    String membershipType, double totalPurchases, int loyaltyPoints,
                    Timestamp createdAt, Timestamp updatedAt) {
        this.customerId = customerId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.membershipType = membershipType;
        this.totalPurchases = totalPurchases;
        this.loyaltyPoints = loyaltyPoints;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getMembershipType() {
        return membershipType;
    }

    public void setMembershipType(String membershipType) {
        this.membershipType = membershipType;
    }

    public double getTotalPurchases() {
        return totalPurchases;
    }

    public void setTotalPurchases(double totalPurchases) {
        this.totalPurchases = totalPurchases;
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void setLoyaltyPoints(int loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Utility methods
    public void addPurchase(double amount) {
        this.totalPurchases += amount;
        // Add loyalty points (1 point per $10 spent)
        this.loyaltyPoints += (int) (amount / 10);
        updateMembershipType();
    }

    public void addLoyaltyPoints(int points) {
        this.loyaltyPoints += points;
    }

    public void redeemLoyaltyPoints(int points) {
        if (this.loyaltyPoints >= points) {
            this.loyaltyPoints -= points;
        }
    }

    private void updateMembershipType() {
        if (this.totalPurchases >= 5000) {
            this.membershipType = "VIP";
        } else if (this.totalPurchases >= 2000) {
            this.membershipType = "PREMIUM";
        } else {
            this.membershipType = "REGULAR";
        }
    }

    public double getDiscountPercentage() {
        switch (this.membershipType) {
            case "VIP":
                return 15.0;
            case "PREMIUM":
                return 10.0;
            case "REGULAR":
            default:
                return 5.0;
        }
    }

    @Override
    public String toString() {
        return "Customer{" +
                "customerId=" + customerId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", membershipType='" + membershipType + '\'' +
                ", totalPurchases=" + totalPurchases +
                ", loyaltyPoints=" + loyaltyPoints +
                '}';
    }
}
