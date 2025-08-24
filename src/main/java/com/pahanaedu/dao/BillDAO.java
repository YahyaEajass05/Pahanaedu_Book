package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Customer;
import com.pahanaedu.util.DatabaseConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BillDAO {

    /**
     * Generate a unique bill number
     */
    public String generateBillNumber() throws SQLException {
        String prefix = "BILL";
        int year = new Date(System.currentTimeMillis()).toLocalDate().getYear();

        String sql = "SELECT COUNT(*) + 1 AS next_number FROM bills WHERE YEAR(bill_date) = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int nextNumber = rs.getInt("next_number");
                return String.format("%s%d%04d", prefix, year, nextNumber);
            }
        }

        return prefix + year + "0001";
    }

    /**
     * Create a new bill with items (transaction)
     */
    public int createBillWithItems(Bill bill, List<BillItem> billItems) throws SQLException {
        Connection connection = null;
        PreparedStatement billStatement = null;
        PreparedStatement itemStatement = null;
        PreparedStatement stockStatement = null;
        PreparedStatement customerStatement = null;

        String billSql = "INSERT INTO bills (customer_id, bill_number, subtotal, discount_amount, " +
                "tax_amount, total_amount, payment_method, payment_status, " +
                "loyalty_points_earned, loyalty_points_redeemed, bill_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String itemSql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?, ?)";

        String stockSql = "UPDATE items SET stock = stock - ? WHERE item_id = ?";

        String customerSql = "UPDATE customers SET " +
                "loyalty_points = loyalty_points + ? - ?, " +
                "total_purchases = total_purchases + ? " +
                "WHERE customer_id = ?";

        try {
            connection = DatabaseConnection.getConnection();
            connection.setAutoCommit(false);

            // Generate bill number
            if (bill.getBillNumber() == null || bill.getBillNumber().isEmpty()) {
                bill.setBillNumber(generateBillNumber());
            }

            // 1. Insert bill
            billStatement = connection.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS);
            billStatement.setInt(1, bill.getCustomerId());
            billStatement.setString(2, bill.getBillNumber());
            billStatement.setBigDecimal(3, bill.getSubtotal());
            billStatement.setBigDecimal(4, bill.getDiscountAmount());
            billStatement.setBigDecimal(5, bill.getTaxAmount());
            billStatement.setBigDecimal(6, bill.getTotalAmount());
            billStatement.setString(7, bill.getPaymentMethod());
            billStatement.setString(8, bill.getPaymentStatus());
            billStatement.setInt(9, bill.getLoyaltyPointsEarned());
            billStatement.setInt(10, bill.getLoyaltyPointsRedeemed());
            billStatement.setTimestamp(11, new Timestamp(bill.getBillDate().getTime()));

            billStatement.executeUpdate();

            // Get generated bill ID
            ResultSet generatedKeys = billStatement.getGeneratedKeys();
            int billId = -1;
            if (generatedKeys.next()) {
                billId = generatedKeys.getInt(1);
                bill.setBillId(billId);
            }

            // 2. Insert bill items
            itemStatement = connection.prepareStatement(itemSql);
            stockStatement = connection.prepareStatement(stockSql);

            for (BillItem item : billItems) {
                // Insert bill item
                itemStatement.setInt(1, billId);
                itemStatement.setString(2, item.getItemId());
                itemStatement.setInt(3, item.getQuantity());
                itemStatement.setBigDecimal(4, item.getUnitPrice());
                itemStatement.setBigDecimal(5, item.getDiscountPercentage());
                itemStatement.setBigDecimal(6, item.getTotalPrice());
                itemStatement.addBatch();

                // Update stock
                stockStatement.setInt(1, item.getQuantity());
                stockStatement.setString(2, item.getItemId());
                stockStatement.addBatch();
            }

            itemStatement.executeBatch();
            stockStatement.executeBatch();

            // 3. Update customer loyalty points and purchase amount
            customerStatement = connection.prepareStatement(customerSql);
            customerStatement.setInt(1, bill.getLoyaltyPointsEarned());
            customerStatement.setInt(2, bill.getLoyaltyPointsRedeemed());
            customerStatement.setBigDecimal(3, bill.getTotalAmount());
            customerStatement.setInt(4, bill.getCustomerId());
            customerStatement.executeUpdate();

            connection.commit();
            return billId;

        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            closeResources(null, billStatement, null);
            closeResources(null, itemStatement, null);
            closeResources(null, stockStatement, null);
            closeResources(null, customerStatement, connection);
        }
    }

    /**
     * Get bill by ID with all details
     */
    public Bill getBillById(int billId) throws SQLException {
        String sql = "SELECT b.*, c.name as customer_name, c.email as customer_email, " +
                "c.phone as customer_phone, c.address as customer_address, " +
                "c.membership_type, c.loyalty_points as customer_loyalty_points " +
                "FROM bills b " +
                "JOIN customers c ON b.customer_id = c.customer_id " +
                "WHERE b.bill_id = ?";

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, billId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Bill bill = mapResultSetToBillWithCustomer(resultSet);
                // Load bill items
                bill.setBillItems(getBillItems(billId));
                return bill;
            }
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return null;
    }

    /**
     * Get bill items for a specific bill
     */
    public List<BillItem> getBillItems(int billId) throws SQLException {
        String sql = "SELECT bi.*, i.item_name, i.price, i.category, i.stock " +
                "FROM bill_items bi " +
                "JOIN items i ON bi.item_id = i.item_id " +
                "WHERE bi.bill_id = ?";

        List<BillItem> billItems = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BillItem billItem = new BillItem();
                billItem.setBillItemId(rs.getInt("bill_item_id"));
                billItem.setBillId(rs.getInt("bill_id"));
                billItem.setItemId(rs.getString("item_id"));
                billItem.setQuantity(rs.getInt("quantity"));
                billItem.setUnitPrice(rs.getBigDecimal("unit_price"));
                billItem.setDiscountPercentage(rs.getBigDecimal("discount_percentage"));
                billItem.setTotalPrice(rs.getBigDecimal("total_price"));
                billItem.setCreatedAt(rs.getTimestamp("created_at"));

                // Set item details
                billItem.setItemName(rs.getString("item_name"));
                billItem.setItemCategory(rs.getString("category"));

                billItems.add(billItem);
            }
        }

        return billItems;
    }

    /**
     * Get all bills with customer details
     */
    public List<Bill> getAllBills() throws SQLException {
        String sql = "SELECT b.*, c.name as customer_name, c.email as customer_email, " +
                "c.phone as customer_phone, c.address as customer_address, " +
                "c.membership_type, c.loyalty_points as customer_loyalty_points " +
                "FROM bills b " +
                "JOIN customers c ON b.customer_id = c.customer_id " +
                "ORDER BY b.bill_date DESC";

        List<Bill> bills = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                bills.add(mapResultSetToBillWithCustomer(rs));
            }
        }

        return bills;
    }

    /**
     * Get bills by customer
     */
    public List<Bill> getBillsByCustomer(int customerId) throws SQLException {
        String sql = "SELECT b.*, c.name as customer_name, c.email as customer_email, " +
                "c.phone as customer_phone, c.address as customer_address, " +
                "c.membership_type, c.loyalty_points as customer_loyalty_points " +
                "FROM bills b " +
                "JOIN customers c ON b.customer_id = c.customer_id " +
                "WHERE b.customer_id = ? " +
                "ORDER BY b.bill_date DESC";

        List<Bill> bills = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bills.add(mapResultSetToBillWithCustomer(rs));
            }
        }

        return bills;
    }

    /**
     * Get bills by date range
     */
    public List<Bill> getBillsByDateRange(Date startDate, Date endDate) throws SQLException {
        String sql = "SELECT b.*, c.name as customer_name, c.email as customer_email, " +
                "c.phone as customer_phone, c.address as customer_address, " +
                "c.membership_type, c.loyalty_points as customer_loyalty_points " +
                "FROM bills b " +
                "JOIN customers c ON b.customer_id = c.customer_id " +
                "WHERE DATE(b.bill_date) BETWEEN ? AND ? " +
                "ORDER BY b.bill_date DESC";

        List<Bill> bills = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bills.add(mapResultSetToBillWithCustomer(rs));
            }
        }

        return bills;
    }

    /**
     * Search bills by bill number
     */
    public Bill getBillByNumber(String billNumber) throws SQLException {
        String sql = "SELECT b.*, c.name as customer_name, c.email as customer_email, " +
                "c.phone as customer_phone, c.address as customer_address, " +
                "c.membership_type, c.loyalty_points as customer_loyalty_points " +
                "FROM bills b " +
                "JOIN customers c ON b.customer_id = c.customer_id " +
                "WHERE b.bill_number = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, billNumber);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bill bill = mapResultSetToBillWithCustomer(rs);
                bill.setBillItems(getBillItems(bill.getBillId()));
                return bill;
            }
        }

        return null;
    }



    /**
     * Cancel bill and restore stock
     */
    public boolean cancelBill(int billId) throws SQLException {
        Connection connection = null;
        PreparedStatement updateBillStmt = null;
        PreparedStatement restoreStockStmt = null;
        PreparedStatement updateCustomerStmt = null;

        try {
            connection = DatabaseConnection.getConnection();
            connection.setAutoCommit(false);

            // Get bill details first
            Bill bill = getBillById(billId);
            if (bill == null || "CANCELLED".equals(bill.getPaymentStatus())) {
                return false;
            }



            // Restore stock for each item
            String restoreStockSql = "UPDATE items SET stock = stock + ? WHERE item_id = ?";
            restoreStockStmt = connection.prepareStatement(restoreStockSql);

            for (BillItem item : bill.getBillItems()) {
                restoreStockStmt.setInt(1, item.getQuantity());
                restoreStockStmt.setString(2, item.getItemId());
                restoreStockStmt.addBatch();
            }
            restoreStockStmt.executeBatch();

            // Restore customer loyalty points and reduce purchase amount
            String updateCustomerSql = "UPDATE customers SET " +
                    "loyalty_points = loyalty_points - ? + ?, " +
                    "total_purchases = total_purchases - ? " +
                    "WHERE customer_id = ?";
            updateCustomerStmt = connection.prepareStatement(updateCustomerSql);
            updateCustomerStmt.setInt(1, bill.getLoyaltyPointsEarned());
            updateCustomerStmt.setInt(2, bill.getLoyaltyPointsRedeemed());
            updateCustomerStmt.setBigDecimal(3, bill.getTotalAmount());
            updateCustomerStmt.setInt(4, bill.getCustomerId());
            updateCustomerStmt.executeUpdate();

            connection.commit();
            return true;

        } catch (SQLException e) {
            if (connection != null) {
                connection.rollback();
            }
            throw e;
        } finally {
            if (connection != null) {
                connection.setAutoCommit(true);
            }
            closeResources(null, updateBillStmt, null);
            closeResources(null, restoreStockStmt, null);
            closeResources(null, updateCustomerStmt, connection);
        }
    }

    /**
     * Get sales statistics for date range
     */
    public Map<String, BigDecimal> getSalesStatistics(Date startDate, Date endDate) throws SQLException {
        String sql = "SELECT " +
                "COUNT(*) as total_bills, " +
                "SUM(total_amount) as total_revenue, " +
                "AVG(total_amount) as average_bill, " +
                "SUM(discount_amount) as total_discount, " +
                "SUM(tax_amount) as total_tax " +
                "FROM bills " +
                "WHERE DATE(bill_date) BETWEEN ? AND ? " +
                "AND payment_status = 'PAID'";

        Map<String, BigDecimal> stats = new HashMap<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, startDate);
            ps.setDate(2, endDate);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                stats.put("totalBills", new BigDecimal(rs.getInt("total_bills")));
                stats.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                stats.put("averageBill", rs.getBigDecimal("average_bill"));
                stats.put("totalDiscount", rs.getBigDecimal("total_discount"));
                stats.put("totalTax", rs.getBigDecimal("total_tax"));
            }
        }

        return stats;
    }

    /**
     * Get today's sales
     */
    public BigDecimal getTodaysSales() throws SQLException {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) as total " +
                "FROM bills " +
                "WHERE DATE(bill_date) = CURDATE() " +
                "AND payment_status = 'PAID'";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getBigDecimal("total");
            }
        }

        return BigDecimal.ZERO;
    }

    /**
     * Helper method to map ResultSet to Bill with Customer
     */
    private Bill mapResultSetToBillWithCustomer(ResultSet rs) throws SQLException {
        Bill bill = new Bill();

        // Bill fields
        bill.setBillId(rs.getInt("bill_id"));
        bill.setCustomerId(rs.getInt("customer_id"));
        bill.setBillNumber(rs.getString("bill_number"));
        bill.setSubtotal(rs.getBigDecimal("subtotal"));
        bill.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        bill.setTaxAmount(rs.getBigDecimal("tax_amount"));
        bill.setTotalAmount(rs.getBigDecimal("total_amount"));
        bill.setPaymentMethod(rs.getString("payment_method"));
        bill.setPaymentStatus(rs.getString("payment_status"));
        bill.setLoyaltyPointsEarned(rs.getInt("loyalty_points_earned"));
        bill.setLoyaltyPointsRedeemed(rs.getInt("loyalty_points_redeemed"));
        bill.setBillDate(rs.getTimestamp("bill_date"));
        bill.setCreatedAt(rs.getTimestamp("created_at"));
        bill.setUpdatedAt(rs.getTimestamp("updated_at"));

        // Customer fields
        bill.setCustomerName(rs.getString("customer_name"));
        bill.setCustomerEmail(rs.getString("customer_email"));
        bill.setCustomerPhone(rs.getString("customer_phone"));
        bill.setCustomerAddress(rs.getString("customer_address"));
        bill.setMembershipType(rs.getString("membership_type"));
        bill.setCustomerLoyaltyPoints(rs.getInt("customer_loyalty_points"));

        return bill;
    }

    /**
     * Helper method to close database resources
     */
    private void closeResources(ResultSet resultSet, Statement statement, Connection connection) {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
