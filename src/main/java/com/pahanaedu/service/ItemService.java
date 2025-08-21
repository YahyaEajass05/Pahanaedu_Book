package com.pahanaedu.service;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;
import java.math.BigDecimal;
import java.util.List;

public class ItemService {

    private ItemDAO itemDAO;

    public ItemService() {
        this.itemDAO = new ItemDAO();
    }

    /**
     * Add a new item with validation
     * @param item - Item object to add
     * @return true if item added successfully, false otherwise
     */
    public boolean addItem(Item item) {
        // Validate item data
        if (!isValidItem(item)) {
            return false;
        }

        // Check if item already exists
        if (itemDAO.itemExists(item.getItemId())) {
            return false;
        }

        // Clean item data
        cleanItemData(item);

        return itemDAO.addItem(item);
    }

    /**
     * Get item by item ID
     * @param itemId - item ID
     * @return Item object if found, null otherwise
     */
    public Item getItemById(String itemId) {
        if (itemId == null || itemId.trim().isEmpty()) {
            return null;
        }

        return itemDAO.getItemById(itemId.trim());
    }

    /**
     * Get all items
     * @return List of all items
     */
    public List<Item> getAllItems() {
        return itemDAO.getAllItems();
    }

    /**
     * Update item information with validation
     * @param item - Item object with updated information
     * @return true if update successful, false otherwise
     */
    public boolean updateItem(Item item) {
        // Validate item data
        if (!isValidItem(item)) {
            return false;
        }

        // Check if item exists
        if (!itemDAO.itemExists(item.getItemId())) {
            return false;
        }

        // Clean item data
        cleanItemData(item);

        return itemDAO.updateItem(item);
    }

    /**
     * Delete item by item ID
     * @param itemId - item ID to delete
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteItem(String itemId) {
        if (itemId == null || itemId.trim().isEmpty()) {
            return false;
        }

        // Check if item exists before deletion
        if (!itemDAO.itemExists(itemId.trim())) {
            return false;
        }

        return itemDAO.deleteItem(itemId.trim());
    }

    /**
     * Check if item exists
     * @param itemId - item ID
     * @return true if item exists, false otherwise
     */
    public boolean itemExists(String itemId) {
        if (itemId == null || itemId.trim().isEmpty()) {
            return false;
        }

        return itemDAO.itemExists(itemId.trim());
    }

    /**
     * Update item stock after sale
     * @param itemId - item ID
     * @param quantitySold - quantity sold
     * @return true if stock updated successfully, false if insufficient stock
     */
    public boolean sellItem(String itemId, int quantitySold) {
        if (itemId == null || itemId.trim().isEmpty() || quantitySold <= 0) {
            return false;
        }

        return itemDAO.updateStock(itemId.trim(), quantitySold);
    }

    /**
     * Get items with low stock
     * @param threshold - stock threshold (default: 10)
     * @return List of items with stock below threshold
     */
    public List<Item> getLowStockItems(int threshold) {
        if (threshold < 0) {
            threshold = 10; // Default threshold
        }

        return itemDAO.getLowStockItems(threshold);
    }

    /**
     * Get items with low stock (default threshold of 10)
     * @return List of items with stock below 10
     */
    public List<Item> getLowStockItems() {
        return getLowStockItems(10);
    }

    /**
     * Check if item has sufficient stock
     * @param itemId - item ID
     * @param requiredQuantity - required quantity
     * @return true if sufficient stock available, false otherwise
     */
    public boolean hasSufficientStock(String itemId, int requiredQuantity) {
        if (itemId == null || itemId.trim().isEmpty() || requiredQuantity <= 0) {
            return false;
        }

        Item item = itemDAO.getItemById(itemId.trim());
        return item != null && item.getStock() >= requiredQuantity;
    }

    /**
     * Validate item data
     * @param item - Item object to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidItem(Item item) {
        if (item == null) {
            return false;
        }

        // Validate item ID
        if (!isValidItemId(item.getItemId())) {
            return false;
        }

        // Validate item name
        if (!isValidItemName(item.getItemName())) {
            return false;
        }

        // Validate price
        if (!isValidPrice(item.getPrice())) {
            return false;
        }

        // Validate stock
        if (item.getStock() < 0) {
            return false;
        }

        return true;
    }

    /**
     * Validate item ID format
     * @param itemId - item ID to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidItemId(String itemId) {
        if (itemId == null || itemId.trim().isEmpty()) {
            return false;
        }

        itemId = itemId.trim();

        // Item ID should be 3-20 characters, alphanumeric with underscores and hyphens
        return itemId.length() >= 3 && itemId.length() <= 20
                && itemId.matches("^[a-zA-Z0-9_-]+$");
    }

    /**
     * Validate item name
     * @param itemName - item name to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidItemName(String itemName) {
        if (itemName == null || itemName.trim().isEmpty()) {
            return false;
        }

        itemName = itemName.trim();

        // Item name should be 2-100 characters
        return itemName.length() >= 2 && itemName.length() <= 100;
    }

    /**
     * Validate item price
     * @param price - price to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidPrice(BigDecimal price) {
        if (price == null) {
            return false;
        }

        // Price should be positive and not exceed 999999.99
        return price.compareTo(BigDecimal.ZERO) > 0 &&
                price.compareTo(new BigDecimal("999999.99")) <= 0;
    }

    /**
     * Clean and format item data
     * @param item - Item object to clean
     */
    private void cleanItemData(Item item) {
        if (item != null) {
            if (item.getItemId() != null) {
                item.setItemId(item.getItemId().trim().toUpperCase());
            }
            if (item.getItemName() != null) {
                item.setItemName(formatItemName(item.getItemName().trim()));
            }
            if (item.getPrice() != null) {
                // Round price to 2 decimal places
                item.setPrice(item.getPrice().setScale(2, BigDecimal.ROUND_HALF_UP));
            }
        }
    }

    /**
     * Format item name to proper case
     * @param itemName - item name to format
     * @return formatted item name
     */
    private String formatItemName(String itemName) {
        if (itemName == null || itemName.trim().isEmpty()) {
            return itemName;
        }

        String[] words = itemName.trim().split("\\s+");
        StringBuilder formattedName = new StringBuilder();

        for (int i = 0; i < words.length; i++) {
            if (i > 0) {
                formattedName.append(" ");
            }

            String word = words[i].toLowerCase();
            if (word.length() > 0) {
                formattedName.append(Character.toUpperCase(word.charAt(0)));
                if (word.length() > 1) {
                    formattedName.append(word.substring(1));
                }
            }
        }

        return formattedName.toString();
    }

    /**
     * Calculate total inventory value
     * @return total value of all items in inventory
     */
    public BigDecimal getTotalInventoryValue() {
        List<Item> items = getAllItems();
        BigDecimal totalValue = BigDecimal.ZERO;

        for (Item item : items) {
            BigDecimal itemValue = item.getPrice().multiply(new BigDecimal(item.getStock()));
            totalValue = totalValue.add(itemValue);
        }

        return totalValue;
    }

    /**
     * Get total number of items
     * @return total number of different items
     */
    public int getItemCount() {
        return getAllItems().size();
    }

    /**
     * Get total stock quantity across all items
     * @return total stock quantity
     */
    public int getTotalStockQuantity() {
        List<Item> items = getAllItems();
        int totalStock = 0;

        for (Item item : items) {
            totalStock += item.getStock();
        }

        return totalStock;
    }
}