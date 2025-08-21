package com.pahanaedu.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Item {
    private String itemId;
    private String itemName;
    private String description;   // ✅ added description field
    private BigDecimal price;
    private int stock;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Default constructor
    public Item() {}

    // Constructor without timestamps
    public Item(String itemId, String itemName, String description, BigDecimal price, int stock) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.stock = stock;
    }

    // Constructor with all fields
    public Item(String itemId, String itemName, String description, BigDecimal price, int stock,
                Timestamp createdAt, Timestamp updatedAt) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getDescription() {
        return description;   // ✅ implemented properly
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
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
        return "Item{" +
                "itemId='" + itemId + '\'' +
                ", itemName='" + itemName + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }
}
