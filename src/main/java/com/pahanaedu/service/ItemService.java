package com.pahanaedu.service;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ItemService {

    private ItemDAO itemDAO;

    public ItemService() {
        this.itemDAO = new ItemDAO();
    }

    /**
     * Add a new item with validation
     */
    public boolean addItem(Item item) throws SQLException {
        // Validate item data
        if (!isValidItem(item)) {
            throw new IllegalArgumentException("Invalid item data");
        }

        // Check if item already exists
        if (itemDAO.itemExists(item.getItemId())) {
            throw new IllegalArgumentException("Item with ID " + item.getItemId() + " already exists");
        }

        // Clean and format item data
        cleanItemData(item);

        // Calculate discounted price
        item.calculateDiscountedPrice();
        item.updateStockStatus();

        return itemDAO.addItem(item);
    }

    /**
     * Get item by item ID
     */
    public Item getItemById(String itemId) throws SQLException {
        if (itemId == null || itemId.trim().isEmpty()) {
            return null;
        }

        return itemDAO.getItemById(itemId.trim());
    }

    /**
     * Get all items
     */
    public List<Item> getAllItems() throws SQLException {
        return itemDAO.getAllItems();
    }

    /**
     * Get items by category
     */
    public List<Item> getItemsByCategory(String category) throws SQLException {
        if (category == null || category.trim().isEmpty()) {
            return new ArrayList<>();
        }

        return itemDAO.getItemsByCategory(category.trim());
    }

    /**
     * Search items by name or category
     */
    public List<Item> searchItems(String searchTerm) throws SQLException {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return getAllItems();
        }

        return itemDAO.searchItems(searchTerm.trim());
    }

    /**
     * Update item information with validation
     */
    public boolean updateItem(Item item) throws SQLException {
        // Validate item data
        if (!isValidItem(item)) {
            throw new IllegalArgumentException("Invalid item data");
        }

        // Check if item exists
        if (!itemDAO.itemExists(item.getItemId())) {
            throw new IllegalArgumentException("Item with ID " + item.getItemId() + " does not exist");
        }

        // Clean item data
        cleanItemData(item);

        // Calculate discounted price
        item.calculateDiscountedPrice();
        item.updateStockStatus();

        return itemDAO.updateItem(item);
    }

    /**
     * Delete item by item ID
     */
    public boolean deleteItem(String itemId) throws SQLException {
        if (itemId == null || itemId.trim().isEmpty()) {
            throw new IllegalArgumentException("Item ID cannot be empty");
        }

        // Check if item exists before deletion
        if (!itemDAO.itemExists(itemId.trim())) {
            throw new IllegalArgumentException("Item with ID " + itemId + " does not exist");
        }

        // This will throw exception if item is used in bills
        return itemDAO.deleteItem(itemId.trim());
    }

    /**
     * Check if item exists
     */
    public boolean itemExists(String itemId) throws SQLException {
        if (itemId == null || itemId.trim().isEmpty()) {
            return false;
        }

        return itemDAO.itemExists(itemId.trim());
    }

    /**
     * Check stock availability for billing
     */
    public boolean checkStockAvailability(String itemId, int requiredQuantity) throws SQLException {
        if (itemId == null || itemId.trim().isEmpty() || requiredQuantity <= 0) {
            return false;
        }

        return itemDAO.checkStockAvailability(itemId.trim(), requiredQuantity);
    }

    /**
     * Update item stock (for sales and returns)
     */
    public boolean updateItemStock(String itemId, int quantityChange) throws SQLException {
        if (itemId == null || itemId.trim().isEmpty()) {
            throw new IllegalArgumentException("Item ID cannot be empty");
        }

        // For sales, quantityChange should be negative
        // For returns or restocking, quantityChange should be positive
        return itemDAO.updateItemStock(itemId.trim(), quantityChange);
    }

    /**
     * Batch update stock for multiple items (used in billing)
     */
    public void batchUpdateStock(Map<String, Integer> stockUpdates) throws SQLException {
        if (stockUpdates == null || stockUpdates.isEmpty()) {
            return;
        }

        itemDAO.batchUpdateStock(stockUpdates);
    }

    /**
     * Get items with low stock
     */
    public List<Item> getLowStockItems(int threshold) throws SQLException {
        if (threshold < 0) {
            threshold = 10; // Default threshold
        }

        return itemDAO.getLowStockItems(threshold);
    }

    /**
     * Get items with low stock (default threshold of 10)
     */
    public List<Item> getLowStockItems() throws SQLException {
        return getLowStockItems(10);
    }

    /**
     * Get out of stock items
     */
    public List<Item> getOutOfStockItems() throws SQLException {
        return itemDAO.getOutOfStockItems();
    }

    /**
     * Get discounted items
     */
    public List<Item> getDiscountedItems() throws SQLException {
        return itemDAO.getDiscountedItems();
    }

    /**
     * Update item discount
     */
    public boolean updateItemDiscount(String itemId, BigDecimal discountPercentage) throws SQLException {
        if (itemId == null || itemId.trim().isEmpty()) {
            throw new IllegalArgumentException("Item ID cannot be empty");
        }

        if (discountPercentage == null || discountPercentage.compareTo(BigDecimal.ZERO) < 0
                || discountPercentage.compareTo(new BigDecimal(100)) > 0) {
            throw new IllegalArgumentException("Discount percentage must be between 0 and 100");
        }

        return itemDAO.updateItemDiscount(itemId.trim(), discountPercentage);
    }

    /**
     * Apply bulk discount to category
     */
    public void applyCategoryDiscount(String category, BigDecimal discountPercentage) throws SQLException {
        if (category == null || category.trim().isEmpty()) {
            throw new IllegalArgumentException("Category cannot be empty");
        }

        if (discountPercentage == null || discountPercentage.compareTo(BigDecimal.ZERO) < 0
                || discountPercentage.compareTo(new BigDecimal(50)) > 0) {
            throw new IllegalArgumentException("Bulk discount percentage must be between 0 and 50");
        }

        List<Item> categoryItems = getItemsByCategory(category);

        if (categoryItems.isEmpty()) {
            throw new IllegalArgumentException("No items found in category: " + category);
        }

        // Batch update discounts for better performance
        Map<String, BigDecimal> discountUpdates = new HashMap<>();
        for (Item item : categoryItems) {
            discountUpdates.put(item.getItemId(), discountPercentage);
        }

        // Apply discounts in batch
        itemDAO.batchUpdateDiscounts(discountUpdates);
    }

    /**
     * Remove all discounts from a category
     */
    public void removeCategoryDiscount(String category) throws SQLException {
        applyCategoryDiscount(category, BigDecimal.ZERO);
    }

    /**
     * Get all categories
     */
    public List<String> getAllCategories() throws SQLException {
        return itemDAO.getAllCategories();
    }

    /**
     * Get item count by category
     */
    public Map<String, Integer> getItemCountByCategory() throws SQLException {
        Map<String, Integer> counts = new HashMap<>();
        List<String> categories = getAllCategories();

        for (String category : categories) {
            List<Item> categoryItems = getItemsByCategory(category);
            counts.put(category, categoryItems.size());
        }

        return counts;
    }

    /**
     * Get item statistics
     */
    public Map<String, Object> getItemStatistics() throws SQLException {
        return itemDAO.getItemStatistics();
    }

    /**
     * Get inventory value by category
     */
    public List<Map<String, Object>> getInventoryValueByCategory() throws SQLException {
        return itemDAO.getInventoryValueByCategory();
    }

    /**
     * Get discount statistics
     */
    public Map<String, Object> getDiscountStatistics() throws SQLException {
        Map<String, Object> stats = new HashMap<>();

        List<Item> allItems = getAllItems();
        List<Item> discountedItems = getDiscountedItems();

        int totalItems = allItems.size();
        int discountedCount = discountedItems.size();
        BigDecimal totalDiscountValue = BigDecimal.ZERO;
        BigDecimal avgDiscountPercentage = BigDecimal.ZERO;

        if (!discountedItems.isEmpty()) {
            BigDecimal sumDiscountPercentage = BigDecimal.ZERO;

            for (Item item : discountedItems) {
                sumDiscountPercentage = sumDiscountPercentage.add(item.getDiscountPercentage());
                BigDecimal discountAmount = item.getPrice()
                        .multiply(item.getDiscountPercentage())
                        .divide(new BigDecimal(100), 2, RoundingMode.HALF_UP)
                        .multiply(new BigDecimal(item.getStock()));
                totalDiscountValue = totalDiscountValue.add(discountAmount);
            }

            avgDiscountPercentage = sumDiscountPercentage
                    .divide(new BigDecimal(discountedCount), 2, RoundingMode.HALF_UP);
        }

        stats.put("totalItems", totalItems);
        stats.put("discountedItems", discountedCount);
        stats.put("nonDiscountedItems", totalItems - discountedCount);
        stats.put("discountPercentage", discountedCount > 0 ?
                (discountedCount * 100.0 / totalItems) : 0.0);
        stats.put("totalDiscountValue", totalDiscountValue);
        stats.put("averageDiscountPercentage", avgDiscountPercentage);

        return stats;
    }

    /**
     * Calculate effective price after discount
     */
    public BigDecimal calculateEffectivePrice(String itemId) throws SQLException {
        Item item = getItemById(itemId);
        if (item == null) {
            throw new IllegalArgumentException("Item not found");
        }

        return item.getEffectivePrice();
    }

    /**
     * Calculate total price for quantity with discount
     */
    public BigDecimal calculateTotalPrice(String itemId, int quantity) throws SQLException {
        Item item = getItemById(itemId);
        if (item == null) {
            throw new IllegalArgumentException("Item not found");
        }

        return item.calculateTotalPrice(quantity);
    }

    /**
     * Validate item data
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

        // Validate discount percentage
        if (item.getDiscountPercentage() != null) {
            if (item.getDiscountPercentage().compareTo(BigDecimal.ZERO) < 0 ||
                    item.getDiscountPercentage().compareTo(new BigDecimal(100)) > 0) {
                return false;
            }
        }

        return true;
    }

    /**
     * Validate item ID format
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
     * Validate category
     */
    public boolean isValidCategory(String category) {
        if (category == null || category.trim().isEmpty()) {
            return true; // Category is optional
        }

        return category.trim().length() <= 50;
    }

    /**
     * Clean and format item data
     */
    private void cleanItemData(Item item) {
        if (item != null) {
            if (item.getItemId() != null) {
                item.setItemId(item.getItemId().trim().toUpperCase());
            }
            if (item.getItemName() != null) {
                item.setItemName(formatItemName(item.getItemName().trim()));
            }
            if (item.getCategory() != null) {
                item.setCategory(formatCategoryName(item.getCategory().trim()));
            }
            if (item.getPrice() != null) {
                // Round price to 2 decimal places
                item.setPrice(item.getPrice().setScale(2, RoundingMode.HALF_UP));
            }
            if (item.getDiscountPercentage() == null) {
                item.setDiscountPercentage(BigDecimal.ZERO);
            } else {
                // Round discount to 2 decimal places
                item.setDiscountPercentage(item.getDiscountPercentage().setScale(2, RoundingMode.HALF_UP));
            }
        }
    }

    /**
     * Format item name to title case
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
                // Don't capitalize certain words unless they're the first word
                if (i == 0 || !isMinorWord(word)) {
                    formattedName.append(Character.toUpperCase(word.charAt(0)));
                    if (word.length() > 1) {
                        formattedName.append(word.substring(1));
                    }
                } else {
                    formattedName.append(word);
                }
            }
        }

        return formattedName.toString();
    }

    /**
     * Check if word is a minor word (articles, prepositions, etc.)
     */
    private boolean isMinorWord(String word) {
        String[] minorWords = {"and", "or", "the", "a", "an", "of", "in", "on", "at", "to", "for", "with", "by"};
        for (String minor : minorWords) {
            if (minor.equalsIgnoreCase(word)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Format category name
     */
    private String formatCategoryName(String category) {
        if (category == null || category.trim().isEmpty()) {
            return category;
        }

        // Convert to title case
        return formatItemName(category);
    }

    /**
     * Calculate total inventory value
     */
    public BigDecimal getTotalInventoryValue() throws SQLException {
        List<Item> items = getAllItems();
        BigDecimal totalValue = BigDecimal.ZERO;

        for (Item item : items) {
            BigDecimal itemValue = item.getPrice().multiply(new BigDecimal(item.getStock()));
            totalValue = totalValue.add(itemValue);
        }

        return totalValue.setScale(2, RoundingMode.HALF_UP);
    }

    /**
     * Calculate total inventory value after discounts
     */
    public BigDecimal getTotalDiscountedInventoryValue() throws SQLException {
        List<Item> items = getAllItems();
        BigDecimal totalValue = BigDecimal.ZERO;

        for (Item item : items) {
            BigDecimal effectivePrice = item.getEffectivePrice();
            BigDecimal itemValue = effectivePrice.multiply(new BigDecimal(item.getStock()));
            totalValue = totalValue.add(itemValue);
        }

        return totalValue.setScale(2, RoundingMode.HALF_UP);
    }

    /**
     * Get inventory summary
     */
    public Map<String, Object> getInventorySummary() throws SQLException {
        Map<String, Object> summary = new HashMap<>();

        Map<String, Object> stats = getItemStatistics();
        summary.putAll(stats);

        summary.put("totalInventoryValue", getTotalInventoryValue());
        summary.put("totalDiscountedValue", getTotalDiscountedInventoryValue());
        summary.put("categories", getAllCategories().size());

        // Add discount statistics
        Map<String, Object> discountStats = getDiscountStatistics();
        summary.put("discountStats", discountStats);

        return summary;
    }

    /**
     * Check if reorder is needed for an item
     */
    public boolean needsReorder(String itemId, int reorderPoint) throws SQLException {
        Item item = getItemById(itemId);
        return item != null && item.getStock() <= reorderPoint;
    }

    /**
     * Get items that need reordering
     */
    public List<Item> getItemsNeedingReorder(int reorderPoint) throws SQLException {
        List<Item> allItems = getAllItems();
        List<Item> reorderItems = new ArrayList<>();

        for (Item item : allItems) {
            if (item.getStock() <= reorderPoint) {
                reorderItems.add(item);
            }
        }

        return reorderItems;
    }

    /**
     * Get top selling items (placeholder - would need sales data)
     */
    public List<Item> getTopSellingItems(int limit) throws SQLException {
        // This would need integration with sales data
        // For now, return items with low stock as they might be selling well
        return getLowStockItems(20);
    }

    /**
     * Get recently added items
     */
    public List<Item> getRecentlyAddedItems(int limit) throws SQLException {
        // This would need a created_date field in the database
        // For now, return the first few items
        List<Item> allItems = getAllItems();
        return allItems.subList(0, Math.min(limit, allItems.size()));
    }
}
