package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import com.pahanaedu.util.DatabaseConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ItemDAO {

    /**
     * Add a new item to the database
     */
    public boolean addItem(Item item) throws SQLException {
        String sql = "INSERT INTO items (item_id, item_name, price, stock, category, discount_percentage) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, item.getItemId());
            ps.setString(2, item.getItemName());
            ps.setBigDecimal(3, item.getPrice());
            ps.setInt(4, item.getStock());
            ps.setString(5, item.getCategory());
            ps.setBigDecimal(6, item.getDiscountPercentage() != null ? item.getDiscountPercentage() : BigDecimal.ZERO);

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Get item by item ID
     */
    public Item getItemById(String itemId) throws SQLException {
        String sql = "SELECT * FROM items WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToItem(rs);
            }
        }

        return null;
    }

    /**
     * Get all items
     */
    public List<Item> getAllItems() throws SQLException {
        String sql = "SELECT * FROM items ORDER BY category, item_name";
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }

        return items;
    }

    /**
     * Get items by category
     */
    public List<Item> getItemsByCategory(String category) throws SQLException {
        String sql = "SELECT * FROM items WHERE category = ? ORDER BY item_name";
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }

        return items;
    }

    /**
     * Search items by name, category, or item ID
     */
    public List<Item> searchItems(String searchTerm) throws SQLException {
        String sql = "SELECT * FROM items WHERE item_id LIKE ? OR item_name LIKE ? OR category LIKE ? " +
                "ORDER BY item_name";
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }

        return items;
    }

    /**
     * Update item information
     */
    public boolean updateItem(Item item) throws SQLException {
        String sql = "UPDATE items SET item_name = ?, price = ?, stock = ?, " +
                "category = ?, discount_percentage = ?, updated_at = CURRENT_TIMESTAMP WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, item.getItemName());
            ps.setBigDecimal(2, item.getPrice());
            ps.setInt(3, item.getStock());
            ps.setString(4, item.getCategory());
            ps.setBigDecimal(5, item.getDiscountPercentage());
            ps.setString(6, item.getItemId());

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Delete item by item ID
     */
    public boolean deleteItem(String itemId) throws SQLException {
        // First check if item is used in any bills
        if (isItemInBills(itemId)) {
            throw new SQLException("Cannot delete item. It is referenced in existing bills.");
        }

        String sql = "DELETE FROM items WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Check if item exists
     */
    public boolean itemExists(String itemId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM items WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }

        return false;
    }

    /**
     * Update item stock (reduce stock when sold)
     */
    public boolean updateItemStock(String itemId, int quantityChange) throws SQLException {
        String sql = "UPDATE items SET stock = stock + ?, updated_at = CURRENT_TIMESTAMP WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantityChange); // Negative for reduction, positive for addition
            ps.setString(2, itemId);

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Check stock availability
     */
    public boolean checkStockAvailability(String itemId, int requiredQuantity) throws SQLException {
        String sql = "SELECT stock FROM items WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("stock") >= requiredQuantity;
            }
        }

        return false;
    }

    /**
     * Get items with low stock (less than specified threshold)
     */
    public List<Item> getLowStockItems(int threshold) throws SQLException {
        String sql = "SELECT * FROM items WHERE stock > 0 AND stock < ? ORDER BY stock ASC, item_name";
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, threshold);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }

        return items;
    }

    /**
     * Get out of stock items
     */
    public List<Item> getOutOfStockItems() throws SQLException {
        String sql = "SELECT * FROM items WHERE stock = 0 ORDER BY item_name";
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }

        return items;
    }

    /**
     * Get items with discount
     */
    public List<Item> getDiscountedItems() throws SQLException {
        String sql = "SELECT * FROM items WHERE discount_percentage > 0 " +
                "ORDER BY discount_percentage DESC, item_name";
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }

        return items;
    }

    /**
     * Update item discount
     */
    public boolean updateItemDiscount(String itemId, BigDecimal discountPercentage) throws SQLException {
        String sql = "UPDATE items SET discount_percentage = ?, updated_at = CURRENT_TIMESTAMP WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBigDecimal(1, discountPercentage);
            ps.setString(2, itemId);

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Batch update discounts for multiple items
     */
    public void batchUpdateDiscounts(Map<String, BigDecimal> discountUpdates) throws SQLException {
        String sql = "UPDATE items SET discount_percentage = ?, updated_at = CURRENT_TIMESTAMP WHERE item_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql);

            for (Map.Entry<String, BigDecimal> entry : discountUpdates.entrySet()) {
                ps.setBigDecimal(1, entry.getValue());
                ps.setString(2, entry.getKey());
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            conn.commit();

            // Check if all updates were successful
            for (int result : results) {
                if (result == Statement.EXECUTE_FAILED) {
                    throw new SQLException("Batch discount update failed for some items");
                }
            }

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Get all categories
     */
    public List<String> getAllCategories() throws SQLException {
        String sql = "SELECT DISTINCT category FROM items WHERE category IS NOT NULL " +
                "AND category != '' ORDER BY category";
        List<String> categories = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        }

        return categories;
    }

    /**
     * Get item count by category
     */
    public Map<String, Integer> getItemCountByCategory() throws SQLException {
        String sql = "SELECT category, COUNT(*) as item_count FROM items " +
                "WHERE category IS NOT NULL AND category != '' " +
                "GROUP BY category ORDER BY category";
        Map<String, Integer> categoryCounts = new HashMap<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                categoryCounts.put(rs.getString("category"), rs.getInt("item_count"));
            }
        }

        return categoryCounts;
    }

    /**
     * Get item statistics
     */
    public Map<String, Object> getItemStatistics() throws SQLException {
        String sql = "SELECT COUNT(*) as total_items, " +
                "SUM(stock) as total_stock, " +
                "COUNT(CASE WHEN stock = 0 THEN 1 END) as out_of_stock, " +
                "COUNT(CASE WHEN stock > 0 AND stock < 10 THEN 1 END) as low_stock, " +
                "AVG(price) as average_price, " +
                "MAX(price) as max_price, " +
                "MIN(price) as min_price, " +
                "COUNT(CASE WHEN discount_percentage > 0 THEN 1 END) as discounted_items, " +
                "AVG(CASE WHEN discount_percentage > 0 THEN discount_percentage END) as avg_discount " +
                "FROM items";

        Map<String, Object> stats = new HashMap<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                stats.put("totalItems", rs.getInt("total_items"));
                stats.put("totalStock", rs.getInt("total_stock"));
                stats.put("outOfStock", rs.getInt("out_of_stock"));
                stats.put("lowStock", rs.getInt("low_stock"));
                stats.put("averagePrice", rs.getBigDecimal("average_price"));
                stats.put("maxPrice", rs.getBigDecimal("max_price"));
                stats.put("minPrice", rs.getBigDecimal("min_price"));
                stats.put("discountedItems", rs.getInt("discounted_items"));
                stats.put("avgDiscount", rs.getBigDecimal("avg_discount"));
            }
        }

        return stats;
    }

    /**
     * Get inventory value by category
     */
    public List<Map<String, Object>> getInventoryValueByCategory() throws SQLException {
        String sql = "SELECT category, " +
                "COUNT(*) as item_count, " +
                "SUM(stock) as total_stock, " +
                "SUM(price * stock) as inventory_value, " +
                "SUM(price * stock * (1 - discount_percentage/100)) as discounted_value " +
                "FROM items " +
                "WHERE category IS NOT NULL AND category != '' " +
                "GROUP BY category " +
                "ORDER BY inventory_value DESC";

        List<Map<String, Object>> categoryValues = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Map<String, Object> category = new HashMap<>();
                category.put("category", rs.getString("category"));
                category.put("itemCount", rs.getInt("item_count"));
                category.put("totalStock", rs.getInt("total_stock"));
                category.put("inventoryValue", rs.getBigDecimal("inventory_value"));
                category.put("discountedValue", rs.getBigDecimal("discounted_value"));
                categoryValues.add(category);
            }
        }

        return categoryValues;
    }

    /**
     * Get discount statistics by category
     */
    public Map<String, Map<String, Object>> getDiscountStatsByCategory() throws SQLException {
        String sql = "SELECT category, " +
                "COUNT(CASE WHEN discount_percentage > 0 THEN 1 END) as discounted_count, " +
                "COUNT(*) as total_count, " +
                "AVG(CASE WHEN discount_percentage > 0 THEN discount_percentage END) as avg_discount, " +
                "MAX(discount_percentage) as max_discount " +
                "FROM items " +
                "WHERE category IS NOT NULL AND category != '' " +
                "GROUP BY category";

        Map<String, Map<String, Object>> discountStats = new HashMap<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Map<String, Object> stats = new HashMap<>();
                stats.put("discountedCount", rs.getInt("discounted_count"));
                stats.put("totalCount", rs.getInt("total_count"));
                stats.put("avgDiscount", rs.getBigDecimal("avg_discount"));
                stats.put("maxDiscount", rs.getBigDecimal("max_discount"));

                discountStats.put(rs.getString("category"), stats);
            }
        }

        return discountStats;
    }

    /**
     * Check if item is used in any bills
     */
    private boolean isItemInBills(String itemId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM bill_items WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }

        return false;
    }

    /**
     * Batch update stock for multiple items (used in billing)
     */
    public void batchUpdateStock(Map<String, Integer> stockUpdates) throws SQLException {
        String sql = "UPDATE items SET stock = stock + ?, updated_at = CURRENT_TIMESTAMP WHERE item_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql);

            for (Map.Entry<String, Integer> entry : stockUpdates.entrySet()) {
                ps.setInt(1, entry.getValue());
                ps.setString(2, entry.getKey());
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            conn.commit();

            // Check if all updates were successful
            for (int result : results) {
                if (result == Statement.EXECUTE_FAILED) {
                    throw new SQLException("Batch stock update failed for some items");
                }
            }

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Get items by price range
     */
    public List<Item> getItemsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) throws SQLException {
        String sql = "SELECT * FROM items WHERE price BETWEEN ? AND ? ORDER BY price";
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBigDecimal(1, minPrice);
            ps.setBigDecimal(2, maxPrice);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }

        return items;
    }

    /**
     * Get recently updated items
     */
    public List<Item> getRecentlyUpdatedItems(int limit) throws SQLException {
        String sql = "SELECT * FROM items ORDER BY updated_at DESC LIMIT ?";
        List<Item> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        }

        return items;
    }

    /**
     * Helper method to map ResultSet to Item object
     */
    private Item mapResultSetToItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setItemId(rs.getString("item_id"));
        item.setItemName(rs.getString("item_name"));
        item.setPrice(rs.getBigDecimal("price"));
        item.setStock(rs.getInt("stock"));
        item.setCategory(rs.getString("category"));
        item.setDiscountPercentage(rs.getBigDecimal("discount_percentage"));

        // Handle timestamp columns safely
        try {
            item.setCreatedAt(rs.getTimestamp("created_at"));
            item.setUpdatedAt(rs.getTimestamp("updated_at"));
        } catch (SQLException e) {
            // If timestamp columns don't exist, continue without them
        }

        // Calculate discounted price
        item.calculateDiscountedPrice();
        item.updateStockStatus();

        return item;
    }
}
