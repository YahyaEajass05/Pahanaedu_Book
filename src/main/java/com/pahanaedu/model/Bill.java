package com.pahanaedu.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private int customerId;
    private String billNumber;
    private BigDecimal subtotal;
    private BigDecimal discountAmount;
    private BigDecimal taxAmount;
    private BigDecimal totalAmount;
    private String paymentMethod;
    private String paymentStatus;
    private int loyaltyPointsEarned;
    private int loyaltyPointsRedeemed;
    private Date billDate;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Customer details from joined query
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String customerAddress;
    private String membershipType;
    private int customerLoyaltyPoints;

    // Related entities
    private Customer customer;
    private List<BillItem> billItems;

    // Calculated/Display fields
    private int totalItems;
    private int totalQuantity;
    private BigDecimal totalSavings;
    private BigDecimal membershipDiscount;

    // Default constructor
    public Bill() {
        this.paymentStatus = "PAID";
        this.paymentMethod = "CASH";
        this.discountAmount = BigDecimal.ZERO;
        this.taxAmount = BigDecimal.ZERO;
        this.subtotal = BigDecimal.ZERO;
        this.totalAmount = BigDecimal.ZERO;
        this.loyaltyPointsEarned = 0;
        this.loyaltyPointsRedeemed = 0;
        this.billDate = new Date();
    }

    // Constructor for creating new bill
    public Bill(int customerId, String paymentMethod) {
        this();
        this.customerId = customerId;
        this.paymentMethod = paymentMethod;
    }

    // Constructor with essential fields
    public Bill(int customerId, BigDecimal subtotal, BigDecimal totalAmount,
                String paymentMethod, Date billDate) {
        this();
        this.customerId = customerId;
        this.subtotal = subtotal;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.billDate = billDate;
    }

    // Full constructor
    public Bill(int billId, int customerId, String billNumber, BigDecimal subtotal,
                BigDecimal discountAmount, BigDecimal taxAmount, BigDecimal totalAmount,
                String paymentMethod, String paymentStatus, int loyaltyPointsEarned,
                int loyaltyPointsRedeemed, Date billDate, Timestamp createdAt,
                Timestamp updatedAt) {
        this.billId = billId;
        this.customerId = customerId;
        this.billNumber = billNumber;
        this.subtotal = subtotal;
        this.discountAmount = discountAmount;
        this.taxAmount = taxAmount;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.loyaltyPointsEarned = loyaltyPointsEarned;
        this.loyaltyPointsRedeemed = loyaltyPointsRedeemed;
        this.billDate = billDate;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getBillNumber() {
        return billNumber;
    }

    public void setBillNumber(String billNumber) {
        this.billNumber = billNumber;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(BigDecimal taxAmount) {
        this.taxAmount = taxAmount;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public int getLoyaltyPointsEarned() {
        return loyaltyPointsEarned;
    }

    public void setLoyaltyPointsEarned(int loyaltyPointsEarned) {
        this.loyaltyPointsEarned = loyaltyPointsEarned;
    }

    public int getLoyaltyPointsRedeemed() {
        return loyaltyPointsRedeemed;
    }

    public void setLoyaltyPointsRedeemed(int loyaltyPointsRedeemed) {
        this.loyaltyPointsRedeemed = loyaltyPointsRedeemed;
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

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getMembershipType() {
        return membershipType;
    }

    public void setMembershipType(String membershipType) {
        this.membershipType = membershipType;
    }

    public int getCustomerLoyaltyPoints() {
        return customerLoyaltyPoints;
    }

    public void setCustomerLoyaltyPoints(int customerLoyaltyPoints) {
        this.customerLoyaltyPoints = customerLoyaltyPoints;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
        // Auto-populate customer details when customer object is set
        if (customer != null) {
            this.customerName = customer.getName();
            this.customerEmail = customer.getEmail();
            this.customerPhone = customer.getPhone();
            this.customerAddress = customer.getAddress();
            this.membershipType = customer.getMembershipType();
            this.customerLoyaltyPoints = customer.getLoyaltyPoints();
        }
    }

    public List<BillItem> getBillItems() {
        return billItems;
    }

    public void setBillItems(List<BillItem> billItems) {
        this.billItems = billItems;
        // Calculate totals when bill items are set
        if (billItems != null && !billItems.isEmpty()) {
            this.totalItems = billItems.size();
            this.totalQuantity = billItems.stream()
                    .mapToInt(BillItem::getQuantity)
                    .sum();
        }
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public BigDecimal getTotalSavings() {
        return totalSavings;
    }

    public void setTotalSavings(BigDecimal totalSavings) {
        this.totalSavings = totalSavings;
    }

    public BigDecimal getMembershipDiscount() {
        return membershipDiscount;
    }

    public void setMembershipDiscount(BigDecimal membershipDiscount) {
        this.membershipDiscount = membershipDiscount;
    }

    // Utility methods for bill calculation
    public void calculateTotalAmount() {
        if (subtotal != null && discountAmount != null && taxAmount != null) {
            this.totalAmount = subtotal.subtract(discountAmount).add(taxAmount);
        }
    }

    public void calculateTotalSavings() {
        BigDecimal savings = BigDecimal.ZERO;

        // Add discount amount
        if (discountAmount != null) {
            savings = savings.add(discountAmount);
        }

        // Add loyalty points redemption value (1 point = 0.10 currency)
        if (loyaltyPointsRedeemed > 0) {
            BigDecimal loyaltyDiscount = new BigDecimal(loyaltyPointsRedeemed)
                    .multiply(new BigDecimal("0.10"));
            savings = savings.add(loyaltyDiscount);
        }

        this.totalSavings = savings;
    }

    public void calculateMembershipDiscount() {
        if (subtotal == null || membershipType == null) {
            this.membershipDiscount = BigDecimal.ZERO;
            return;
        }

        BigDecimal discountPercentage = BigDecimal.ZERO;
        switch (membershipType) {
            case "PREMIUM":
                discountPercentage = new BigDecimal("5.00");
                break;
            case "VIP":
                discountPercentage = new BigDecimal("10.00");
                break;
            default:
                discountPercentage = BigDecimal.ZERO;
        }

        this.membershipDiscount = subtotal.multiply(discountPercentage)
                .divide(new BigDecimal("100"), 2, BigDecimal.ROUND_HALF_UP);
    }

    public void calculateLoyaltyPointsEarned() {
        // Earn 1 point for every 10 currency units spent
        if (totalAmount != null) {
            this.loyaltyPointsEarned = totalAmount.divide(new BigDecimal("10"),
                    0, BigDecimal.ROUND_DOWN).intValue();
        }
    }

    // Status checking methods
    public boolean isPaid() {
        return "PAID".equals(paymentStatus);
    }

    public boolean isPending() {
        return "PENDING".equals(paymentStatus);
    }

    public boolean isCancelled() {
        return "CANCELLED".equals(paymentStatus);
    }

    public boolean hasLoyaltyPointsRedemption() {
        return loyaltyPointsRedeemed > 0;
    }

    public boolean hasMembershipDiscount() {
        return membershipDiscount != null && membershipDiscount.compareTo(BigDecimal.ZERO) > 0;
    }

    // Format bill number for display
    public String getFormattedBillNumber() {
        return billNumber != null ? billNumber : "N/A";
    }

    // Get payment method display name
    public String getPaymentMethodDisplay() {
        if (paymentMethod == null) return "Cash";

        switch (paymentMethod) {
            case "CARD":
                return "Credit/Debit Card";
            case "ONLINE":
                return "Online Payment";
            default:
                return "Cash";
        }
    }

    @Override
    public String toString() {
        return "Bill{" +
                "billId=" + billId +
                ", billNumber='" + billNumber + '\'' +
                ", customerId=" + customerId +
                ", customerName='" + customerName + '\'' +
                ", totalAmount=" + totalAmount +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", paymentStatus='" + paymentStatus + '\'' +
                ", billDate=" + billDate +
                ", totalItems=" + totalItems +
                ", loyaltyPointsEarned=" + loyaltyPointsEarned +
                '}';
    }
}
