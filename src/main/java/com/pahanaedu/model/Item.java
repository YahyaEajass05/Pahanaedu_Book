package com.pahanaedu.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;

public class Item {
    private String itemId;
    private String itemName;
    private BigDecimal price;
    private int stock;
    private String category;
    private BigDecimal discountPercentage;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Additional calculated fields
    private BigDecimal discountedPrice;
    private BigDecimal discountAmount;
    private boolean inStock;
    private String stockStatus;

    // Book-specific fields (not in DB, but useful for display)
    private String description;
    private String author;
    private String isbn;
    private String publisher;

    // Default constructor
    public Item() {
        this.stock = 0;
        this.discountPercentage = BigDecimal.ZERO;
        this.price = BigDecimal.ZERO;
    }

    // Constructor without timestamps
    public Item(String itemId, String itemName, BigDecimal price, int stock,
                String category, BigDecimal discountPercentage) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.price = price;
        this.stock = stock;
        this.category = category;
        this.discountPercentage = discountPercentage != null ? discountPercentage : BigDecimal.ZERO;
        calculateDiscountedPrice();
        updateStockStatus();
    }

    // Constructor with essential fields
    public Item(String itemId, String itemName, BigDecimal price, int stock) {
        this(itemId, itemName, price, stock, null, BigDecimal.ZERO);
    }

    // Full constructor
    public Item(String itemId, String itemName, BigDecimal price, int stock,
                String category, BigDecimal discountPercentage,
                Timestamp createdAt, Timestamp updatedAt) {
        this.itemId = itemId;
        this.itemName = itemName;
        this.price = price;
        this.stock = stock;
        this.category = category;
        this.discountPercentage = discountPercentage != null ? discountPercentage : BigDecimal.ZERO;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        calculateDiscountedPrice();
        updateStockStatus();
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
        calculateDiscountedPrice();
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
        updateStockStatus();
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(BigDecimal discountPercentage) {
        this.discountPercentage = discountPercentage != null ? discountPercentage : BigDecimal.ZERO;
        calculateDiscountedPrice();
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

    public BigDecimal getDiscountedPrice() {
        return discountedPrice;
    }

    public void setDiscountedPrice(BigDecimal discountedPrice) {
        this.discountedPrice = discountedPrice;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public boolean isInStock() {
        return inStock;
    }

    public void setInStock(boolean inStock) {
        this.inStock = inStock;
    }

    public String getStockStatus() {
        return stockStatus;
    }

    public void setStockStatus(String stockStatus) {
        this.stockStatus = stockStatus;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    // Utility methods
    public void calculateDiscountedPrice() {
        if (price != null && discountPercentage != null && discountPercentage.compareTo(BigDecimal.ZERO) > 0) {
            this.discountAmount = price.multiply(discountPercentage)
                    .divide(new BigDecimal(100), 2, RoundingMode.HALF_UP);
            this.discountedPrice = price.subtract(discountAmount);
        } else {
            this.discountAmount = BigDecimal.ZERO;
            this.discountedPrice = price;
        }
    }

    public void updateStockStatus() {
        this.inStock = stock > 0;

        if (stock == 0) {
            this.stockStatus = "Out of Stock";
        } else if (stock <= 5) {
            this.stockStatus = "Low Stock";
        } else if (stock <= 20) {
            this.stockStatus = "Limited Stock";
        } else {
            this.stockStatus = "In Stock";
        }
    }

    // Business logic methods
    public BigDecimal getEffectivePrice() {
        return discountedPrice != null ? discountedPrice : price;
    }

    public boolean hasDiscount() {
        return discountPercentage != null && discountPercentage.compareTo(BigDecimal.ZERO) > 0;
    }

    public boolean isAvailable(int requestedQuantity) {
        return stock >= requestedQuantity;
    }

    public void reduceStock(int quantity) {
        if (quantity > 0 && stock >= quantity) {
            this.stock -= quantity;
            updateStockStatus();
        }
    }

    public void addStock(int quantity) {
        if (quantity > 0) {
            this.stock += quantity;
            updateStockStatus();
        }
    }

    public BigDecimal calculateTotalPrice(int quantity) {
        return getEffectivePrice().multiply(new BigDecimal(quantity));
    }

    public BigDecimal calculateSavings(int quantity) {
        if (hasDiscount()) {
            return discountAmount.multiply(new BigDecimal(quantity));
        }
        return BigDecimal.ZERO;
    }

    // Validation method
    public boolean isValid() {
        return itemId != null && !itemId.trim().isEmpty() &&
                itemName != null && !itemName.trim().isEmpty() &&
                price != null && price.compareTo(BigDecimal.ZERO) > 0 &&
                stock >= 0 &&
                (discountPercentage == null ||
                        (discountPercentage.compareTo(BigDecimal.ZERO) >= 0 &&
                                discountPercentage.compareTo(new BigDecimal(100)) <= 0));
    }

    // Format price for display
    public String getFormattedPrice() {
        if (price != null) {
            return "$" + price.setScale(2, RoundingMode.HALF_UP).toString();
        }
        return "$0.00";
    }

    public String getFormattedDiscountedPrice() {
        if (discountedPrice != null && hasDiscount()) {
            return "$" + discountedPrice.setScale(2, RoundingMode.HALF_UP).toString();
        }
        return getFormattedPrice();
    }

    // Generate display name with category
    public String getDisplayName() {
        if (category != null && !category.isEmpty()) {
            return itemName + " (" + category + ")";
        }
        return itemName;
    }

    @Override
    public String toString() {
        return "Item{" +
                "itemId='" + itemId + '\'' +
                ", itemName='" + itemName + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", category='" + category + '\'' +
                ", discountPercentage=" + discountPercentage +
                ", discountedPrice=" + discountedPrice +
                ", stockStatus='" + stockStatus + '\'' +
                ", hasDiscount=" + hasDiscount() +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Item item = (Item) o;
        return itemId != null && itemId.equals(item.itemId);
    }

    @Override
    public int hashCode() {
        return itemId != null ? itemId.hashCode() : 0;
    }
}
