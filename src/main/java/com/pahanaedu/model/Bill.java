package com.pahanaedu.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Bill {
    private int billId;
    private String accountNumber;
    private int totalUnits;
    private BigDecimal totalAmount;
    private Date billDate;
    private Timestamp createdAt;

    // Default constructor
    public Bill() {}

    // Constructor without billId and timestamps
    public Bill(String accountNumber, int totalUnits, BigDecimal totalAmount, Date billDate) {
        this.accountNumber = accountNumber;
        this.totalUnits = totalUnits;
        this.totalAmount = totalAmount;
        this.billDate = billDate;
    }

    // Constructor with all fields
    public Bill(int billId, String accountNumber, int totalUnits, BigDecimal totalAmount,
                Date billDate, Timestamp createdAt) {
        this.billId = billId;
        this.accountNumber = accountNumber;
        this.totalUnits = totalUnits;
        this.totalAmount = totalAmount;
        this.billDate = billDate;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public int getTotalUnits() {
        return totalUnits;
    }

    public void setTotalUnits(int totalUnits) {
        this.totalUnits = totalUnits;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Date getBillDate() {
        return billDate;
    }

    public void setBillDate(Date billDate) {
        this.billDate = billDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Bill{" +
                "billId=" + billId +
                ", accountNumber='" + accountNumber + '\'' +
                ", totalUnits=" + totalUnits +
                ", totalAmount=" + totalAmount +
                ", billDate=" + billDate +
                '}';
    }
}