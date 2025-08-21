package com.pahanaedu.model;

import java.sql.Timestamp;

public class Customer {
    private String accountNumber;
    private String name;
    private String address;
    private String telephone;
    private int unitsConsumed;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Customer() {}

    // Constructor without timestamps
    public Customer(String accountNumber, String name, String address, String telephone, int unitsConsumed) {
        this.accountNumber = accountNumber;
        this.name = name;
        this.address = address;
        this.telephone = telephone;
        this.unitsConsumed = unitsConsumed;
    }

    // Constructor with all fields
    public Customer(String accountNumber, String name, String address, String telephone,
                    int unitsConsumed, Timestamp createdAt, Timestamp updatedAt) {
        this.accountNumber = accountNumber;
        this.name = name;
        this.address = address;
        this.telephone = telephone;
        this.unitsConsumed = unitsConsumed;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public int getUnitsConsumed() {
        return unitsConsumed;
    }

    public void setUnitsConsumed(int unitsConsumed) {
        this.unitsConsumed = unitsConsumed;
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

    @Override
    public String toString() {
        return "Customer{" +
                "accountNumber='" + accountNumber + '\'' +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                ", telephone='" + telephone + '\'' +
                ", unitsConsumed=" + unitsConsumed +
                '}';
    }
}