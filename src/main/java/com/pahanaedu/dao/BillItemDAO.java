package com.pahanaedu.dao;

import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Item;
import com.pahanaedu.util.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BillItemDAO {

    /**
     * Add a single bill item
     */
    public boolean addBillItem(BillItem billItem) throws SQLException {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billItem.getBillId());
            ps.setString(2, billItem.getItemId());
            ps.setInt(3, billItem.getQuantity());
            ps.setBigDecimal(4, billItem.getUnitPrice());
            ps.setBigDecimal(5, billItem.getDiscountPercentage());
            ps.setBigDecimal(6, billItem.getTotalPrice());

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Add multiple bill items in batch (more efficient for multiple items)
     */
    public void addBillItemsBatch(List<BillItem> billItems) throws SQLException {
        String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql);

            for (BillItem billItem : billItems) {
                ps.setInt(1, billItem.getBillId());
                ps.setString(2, billItem.getItemId());
                ps.setInt(3, billItem.getQuantity());
                ps.setBigDecimal(4, billItem.getUnitPrice());
                ps.setBigDecimal(5, billItem.getDiscountPercentage());
                ps.setBigDecimal(6, billItem.getTotalPrice());
                ps.addBatch();
            }

            ps.executeBatch();
            conn.commit();

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
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Get all items for a specific bill
     */
    public List<BillItem> getBillItemsByBillId(int billId) throws SQLException {
        String sql = "SELECT bi.*, i.item_name, i.price as item_price, i.category, " +
                "i.stock, i.discount_percentage as item_discount " +
                "FROM bill_items bi " +
                "JOIN items i ON bi.item_id = i.item_id " +
                "WHERE bi.bill_id = ? " +
                "ORDER BY bi.bill_item_id";

        List<BillItem> billItems = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BillItem billItem = mapResultSetToBillItem(rs);
                billItems.add(billItem);
            }
        }

        return billItems;
    }

    /**
     * Get a specific bill item by ID
     */
    public BillItem getBillItemById(int billItemId) throws SQLException {
        String sql = "SELECT bi.*, i.item_name, i.price as item_price, i.category, " +
                "i.stock, i.discount_percentage as item_discount " +
                "FROM bill_items bi " +
                "JOIN items i ON bi.item_id = i.item_id " +
                "WHERE bi.bill_item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billItemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToBillItem(rs);
            }
        }

        return null;
    }

    /**
     * Update a bill item (for returns or corrections)
     */
    public boolean updateBillItem(BillItem billItem) throws SQLException {
        String sql = "UPDATE bill_items SET quantity = ?, unit_price = ?, total_price = ? " +
                "WHERE bill_item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billItem.getQuantity());
            ps.setBigDecimal(2, billItem.getUnitPrice());
            ps.setBigDecimal(3, billItem.getDiscountPercentage());
            ps.setBigDecimal(4, billItem.getTotalPrice());
            ps.setInt(5, billItem.getBillItemId());

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Delete a bill item (for cancellations)
     */
    public boolean deleteBillItem(int billItemId) throws SQLException {
        String sql = "DELETE FROM bill_items WHERE bill_item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billItemId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Delete all bill items for a specific bill
     */
    public boolean deleteBillItemsByBillId(int billId) throws SQLException {
        String sql = "DELETE FROM bill_items WHERE bill_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Get total quantity sold for a specific item
     */
    public int getTotalQuantitySold(String itemId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(quantity), 0) as total_sold " +
                "FROM bill_items bi " +
                "JOIN bills b ON bi.bill_id = b.bill_id " +
                "WHERE bi.item_id = ? AND b.payment_status = 'PAID'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total_sold");
            }
        }

        return 0;
    }

    /**
     * Get total revenue for a specific item
     */
    public BigDecimal getTotalRevenueByItem(String itemId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(total_price), 0) as total_revenue " +
                "FROM bill_items bi " +
                "JOIN bills b ON bi.bill_id = b.bill_id " +
                "WHERE bi.item_id = ? AND b.payment_status = 'PAID'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getBigDecimal("total_revenue");
            }
        }

        return BigDecimal.ZERO;
    }

    /**
     * Get best selling items
     */
    public List<Map<String, Object>> getBestSellingItems(int limit) throws SQLException {
        String sql = "SELECT bi.item_id, i.item_name, i.category, " +
                "SUM(bi.quantity) as total_quantity, " +
                "SUM(bi.total_price) as total_revenue, " +
                "COUNT(DISTINCT bi.bill_id) as times_sold " +
                "FROM bill_items bi " +
                "JOIN items i ON bi.item_id = i.item_id " +
                "JOIN bills b ON bi.bill_id = b.bill_id " +
                "WHERE b.payment_status = 'PAID' " +
                "GROUP BY bi.item_id, i.item_name, i.category " +
                "ORDER BY total_quantity DESC " +
                "LIMIT ?";

        List<Map<String, Object>> bestSellers = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("itemId", rs.getString("item_id"));
                item.put("itemName", rs.getString("item_name"));
                item.put("category", rs.getString("category"));
                item.put("totalQuantity", rs.getInt("total_quantity"));
                item.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                item.put("timesSold", rs.getInt("times_sold"));
                bestSellers.add(item);
            }
        }

        return bestSellers;
    }

    /**
     * Get items by category sales
     */
    public List<Map<String, Object>> getSalesByCategory() throws SQLException {
        String sql = "SELECT i.category, " +
                "SUM(bi.quantity) as total_quantity, " +
                "SUM(bi.total_price) as total_revenue, " +
                "COUNT(DISTINCT bi.item_id) as unique_items " +
                "FROM bill_items bi " +
                "JOIN items i ON bi.item_id = i.item_id " +
                "JOIN bills b ON bi.bill_id = b.bill_id " +
                "WHERE b.payment_status = 'PAID' " +
                "GROUP BY i.category " +
                "ORDER BY total_revenue DESC";

        List<Map<String, Object>> categorySales = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Map<String, Object> category = new HashMap<>();
                category.put("category", rs.getString("category"));
                category.put("totalQuantity", rs.getInt("total_quantity"));
                category.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                category.put("uniqueItems", rs.getInt("unique_items"));
                categorySales.add(category);
            }
        }

        return categorySales;
    }

    /**
     * Get items sold in a date range
     */
    public List<BillItem> getItemsSoldByDateRange(Date startDate, Date endDate) throws SQLException {
        String sql = "SELECT bi.*, i.item_name, i.category " +
                "FROM bill_items bi " +
                "JOIN items i ON bi.item_id = i.item_id " +
                "JOIN bills b ON bi.bill_id = b.bill_id " +
                "WHERE DATE(b.bill_date) BETWEEN ? AND ? " +
                "AND b.payment_status = 'PAID' " +
                "ORDER BY b.bill_date DESC";

        List<BillItem> items = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BillItem item = new BillItem();
                item.setBillItemId(rs.getInt("bill_item_id"));
                item.setBillId(rs.getInt("bill_id"));
                item.setItemId(rs.getString("item_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getBigDecimal("unit_price"));
                item.setDiscountPercentage(rs.getBigDecimal("discount_percentage"));
                item.setTotalPrice(rs.getBigDecimal("total_price"));
                item.setItemName(rs.getString("item_name"));
                item.setItemCategory(rs.getString("category"));
                items.add(item);
            }
        }

        return items;
    }

    /**
     * Check if an item exists in any bill
     */
    public boolean isItemInUse(String itemId) throws SQLException {
        String sql = "SELECT COUNT(*) > 0 as in_use FROM bill_items WHERE item_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, itemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getBoolean("in_use");
            }
        }

        return false;
    }


    /**
     * Process item return (reduce quantity or delete item)
     */
    public boolean processItemReturn(int billItemId, int returnQuantity) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            // Get current bill item
            BillItem billItem = getBillItemById(billItemId);
            if (billItem == null) {
                throw new SQLException("Bill item not found");
            }

            if (returnQuantity > billItem.getQuantity()) {
                throw new SQLException("Return quantity exceeds purchased quantity");
            }

            if (returnQuantity == billItem.getQuantity()) {
                // Delete the entire item
                String deleteSql = "DELETE FROM bill_items WHERE bill_item_id = ?";
                ps = conn.prepareStatement(deleteSql);
                ps.setInt(1, billItemId);
                ps.executeUpdate();
            } else {
                // Update quantity and recalculate
                int newQuantity = billItem.getQuantity() - returnQuantity;
                BigDecimal newTotal = billItem.getUnitPrice()
                        .multiply(new BigDecimal(newQuantity))
                        .multiply(BigDecimal.ONE.subtract(billItem.getDiscountPercentage().divide(new BigDecimal(100))));

                String updateSql = "UPDATE bill_items SET quantity = ?, total_price = ? WHERE bill_item_id = ?";
                ps = conn.prepareStatement(updateSql);
                ps.setInt(1, newQuantity);
                ps.setBigDecimal(2, newTotal);
                ps.setInt(3, billItemId);
                ps.executeUpdate();
            }

            // Update item stock
            String updateStockSql = "UPDATE items SET stock = stock + ? WHERE item_id = ?";
            ps = conn.prepareStatement(updateStockSql);
            ps.setInt(1, returnQuantity);
            ps.setString(2, billItem.getItemId());
            ps.executeUpdate();

            conn.commit();
            return true;

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
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Helper method to map ResultSet to BillItem
     */
    private BillItem mapResultSetToBillItem(ResultSet rs) throws SQLException {
        BillItem billItem = new BillItem();
        billItem.setBillItemId(rs.getInt("bill_item_id"));
        billItem.setBillId(rs.getInt("bill_id"));
        billItem.setItemId(rs.getString("item_id"));
        billItem.setQuantity(rs.getInt("quantity"));
        billItem.setUnitPrice(rs.getBigDecimal("unit_price"));
        billItem.setDiscountPercentage(rs.getBigDecimal("discount_percentage"));
        billItem.setTotalPrice(rs.getBigDecimal("total_price"));
        billItem.setCreatedAt(rs.getTimestamp("created_at"));

        // Map item details if available
        try {
            billItem.setItemName(rs.getString("item_name"));
            billItem.setItemCategory(rs.getString("category"));
            billItem.setAvailableStock(rs.getInt("stock"));

            // Create and set Item object
            Item item = new Item();
            item.setItemId(rs.getString("item_id"));
            item.setItemName(rs.getString("item_name"));
            item.setPrice(rs.getBigDecimal("item_price"));
            item.setCategory(rs.getString("category"));
            item.setStock(rs.getInt("stock"));
            billItem.setItem(item);
        } catch (SQLException e) {
            // Item details might not be available in all queries
        }

        return billItem;
    }
}
