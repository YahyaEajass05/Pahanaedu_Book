package com.pahanaedu.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;

public class BillItem {
    private int billItemId;
    private int billId;
    private String itemId;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal discountPercentage;
    private BigDecimal totalPrice;
    private Timestamp createdAt;

    // Related entity
    private Item item;

    // Additional calculated fields
    private BigDecimal discountAmount;
    private BigDecimal originalPrice;
    private BigDecimal finalPrice;

    // Item details for display (populated from join queries)
    private String itemName;
    private String itemCategory;
    private BigDecimal itemMRP;
    private int availableStock;

    // Default constructor
    public BillItem() {
        this.quantity = 1;
        this.discountPercentage = BigDecimal.ZERO;
        this.unitPrice = BigDecimal.ZERO;
        this.totalPrice = BigDecimal.ZERO;
    }

    // Constructor for creating new bill item
    public BillItem(int billId, String itemId, int quantity, BigDecimal unitPrice) {
        this();
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        calculateTotalPrice();
    }

    // Constructor with discount
    public BillItem(int billId, String itemId, int quantity, BigDecimal unitPrice,
                    BigDecimal discountPercentage) {
        this(billId, itemId, quantity, unitPrice);
        this.discountPercentage = discountPercentage;
        calculateTotalPrice();
    }

    // Full constructor
    public BillItem(int billItemId, int billId, String itemId, int quantity,
                    BigDecimal unitPrice, BigDecimal discountPercentage,
                    BigDecimal totalPrice, Timestamp createdAt) {
        this.billItemId = billItemId;
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.discountPercentage = discountPercentage;
        this.totalPrice = totalPrice;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getBillItemId() {
        return billItemId;
    }

    public void setBillItemId(int billItemId) {
        this.billItemId = billItemId;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        calculateTotalPrice();
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
        calculateTotalPrice();
    }

    public BigDecimal getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(BigDecimal discountPercentage) {
        this.discountPercentage = discountPercentage;
        calculateTotalPrice();
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
        // Auto-populate item details when item object is set
        if (item != null) {
            this.itemName = item.getItemName();
            this.itemCategory = item.getCategory();
            this.itemMRP = item.getPrice();
            this.availableStock = item.getStock();

            // If unit price is not set, use item's price
            if (this.unitPrice == null || this.unitPrice.compareTo(BigDecimal.ZERO) == 0) {
                this.unitPrice = item.getPrice();
                calculateTotalPrice();
            }
        }
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public BigDecimal getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemCategory() {
        return itemCategory;
    }

    public void setItemCategory(String itemCategory) {
        this.itemCategory = itemCategory;
    }

    public BigDecimal getItemMRP() {
        return itemMRP;
    }

    public void setItemMRP(BigDecimal itemMRP) {
        this.itemMRP = itemMRP;
    }

    public int getAvailableStock() {
        return availableStock;
    }

    public void setAvailableStock(int availableStock) {
        this.availableStock = availableStock;
    }

    // Utility methods
    public void calculateTotalPrice() {
        if (unitPrice != null && quantity > 0) {
            // Calculate original price
            this.originalPrice = unitPrice.multiply(new BigDecimal(quantity));

            // Calculate discount amount
            if (discountPercentage != null && discountPercentage.compareTo(BigDecimal.ZERO) > 0) {
                this.discountAmount = originalPrice.multiply(discountPercentage)
                        .divide(new BigDecimal(100), 2, RoundingMode.HALF_UP);
            } else {
                this.discountAmount = BigDecimal.ZERO;
            }

            // Calculate final price
            this.totalPrice = originalPrice.subtract(discountAmount);
            this.finalPrice = this.totalPrice;
        }
    }

    public BigDecimal getEffectiveUnitPrice() {
        if (quantity > 0 && totalPrice != null) {
            return totalPrice.divide(new BigDecimal(quantity), 2, RoundingMode.HALF_UP);
        }
        return unitPrice;
    }

    public boolean hasDiscount() {
        return discountPercentage != null && discountPercentage.compareTo(BigDecimal.ZERO) > 0;
    }

    public boolean isStockAvailable() {
        return availableStock >= quantity;
    }

    public BigDecimal getSavingsAmount() {
        if (discountAmount != null) {
            return discountAmount;
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getLineTotal() {
        return totalPrice != null ? totalPrice : BigDecimal.ZERO;
    }

    // Validation method
    public boolean isValid() {
        return itemId != null && !itemId.isEmpty() &&
                quantity > 0 &&
                unitPrice != null && unitPrice.compareTo(BigDecimal.ZERO) > 0 &&
                totalPrice != null && totalPrice.compareTo(BigDecimal.ZERO) >= 0;
    }

    // Check if this item can be returned
    public boolean isReturnable() {
        // Business rule: Items can be returned within 7 days
        if (createdAt != null) {
            long daysSincePurchase = (System.currentTimeMillis() - createdAt.getTime())
                    / (1000 * 60 * 60 * 24);
            return daysSincePurchase <= 7;
        }
        return false;
    }

    // Create a copy of this bill item (useful for returns/exchanges)
    public BillItem copy() {
        BillItem copy = new BillItem();
        copy.setItemId(this.itemId);
        copy.setQuantity(this.quantity);
        copy.setUnitPrice(this.unitPrice);
        copy.setDiscountPercentage(this.discountPercentage);
        copy.setTotalPrice(this.totalPrice);
        copy.setItem(this.item);
        copy.setItemName(this.itemName);
        copy.setItemCategory(this.itemCategory);
        copy.setItemMRP(this.itemMRP);
        return copy;
    }

    @Override
    public String toString() {
        return "BillItem{" +
                "billItemId=" + billItemId +
                ", billId=" + billId +
                ", itemId='" + itemId + '\'' +
                ", itemName='" + itemName + '\'' +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", discountPercentage=" + discountPercentage +
                ", totalPrice=" + totalPrice +
                ", hasDiscount=" + hasDiscount() +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BillItem billItem = (BillItem) o;

        if (billItemId > 0 && billItem.billItemId > 0) {
            return billItemId == billItem.billItemId;
        }

        return itemId != null && itemId.equals(billItem.itemId) &&
                billId == billItem.billId;
    }

    @Override
    public int hashCode() {
        int result = billItemId;
        result = 31 * result + billId;
        result = 31 * result + (itemId != null ? itemId.hashCode() : 0);
        return result;
    }
}
