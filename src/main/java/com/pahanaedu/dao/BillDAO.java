package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.util.DatabaseConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    /**
     * Add a new bill to the database
     */
    public boolean addBill(Bill bill) {
        String sql = "INSERT INTO bills (account_number, total_units, total_amount, bill_date) VALUES (?, ?, ?, ?)";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, bill.getAccountNumber());
            statement.setInt(2, bill.getTotalUnits());
            statement.setBigDecimal(3, bill.getTotalAmount());
            statement.setDate(4, bill.getBillDate());

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                // Get the generated bill ID
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    bill.setBillId(generatedKeys.getInt(1));
                }
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, statement, connection);
        }

        return false;
    }

    /**
     * Get bill by bill ID
     */
    public Bill getBillById(int billId) {
        String sql = "SELECT * FROM bills WHERE bill_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, billId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToBill(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return null;
    }

    /**
     * Get all bills for a specific customer
     */
    public List<Bill> getBillsByCustomer(String accountNumber) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE account_number = ? ORDER BY bill_date DESC";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, accountNumber);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                bills.add(mapResultSetToBill(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return bills;
    }

    /**
     * Get all bills
     */
    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills ORDER BY bill_date DESC";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                bills.add(mapResultSetToBill(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return bills;
    }

    /**
     * Get bills within a date range
     */
    public List<Bill> getBillsByDateRange(Date startDate, Date endDate) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE bill_date BETWEEN ? AND ? ORDER BY bill_date DESC";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setDate(1, startDate);
            statement.setDate(2, endDate);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                bills.add(mapResultSetToBill(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return bills;
    }

    /**
     * Update bill information
     */
    public boolean updateBill(Bill bill) {
        String sql = "UPDATE bills SET account_number = ?, total_units = ?, total_amount = ?, bill_date = ? WHERE bill_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, bill.getAccountNumber());
            statement.setInt(2, bill.getTotalUnits());
            statement.setBigDecimal(3, bill.getTotalAmount());
            statement.setDate(4, bill.getBillDate());
            statement.setInt(5, bill.getBillId());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, statement, connection);
        }
    }

    /**
     * Delete bill by bill ID
     */
    public boolean deleteBill(int billId) {
        String sql = "DELETE FROM bills WHERE bill_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, billId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, statement, connection);
        }
    }

    /**
     * Get total revenue for a specific date
     */
    public BigDecimal getTotalRevenueByDate(Date date) {
        String sql = "SELECT SUM(total_amount) FROM bills WHERE bill_date = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setDate(1, date);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                BigDecimal total = resultSet.getBigDecimal(1);
                return total != null ? total : BigDecimal.ZERO;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return BigDecimal.ZERO;
    }

    /**
     * Get latest bill ID for generating new bill numbers
     */
    public int getLatestBillId() {
        String sql = "SELECT MAX(bill_id) FROM bills";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return 0;
    }

    /**
     * Helper method to map ResultSet to Bill object
     */
    private Bill mapResultSetToBill(ResultSet resultSet) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(resultSet.getInt("bill_id"));
        bill.setAccountNumber(resultSet.getString("account_number"));
        bill.setTotalUnits(resultSet.getInt("total_units"));
        bill.setTotalAmount(resultSet.getBigDecimal("total_amount"));
        bill.setBillDate(resultSet.getDate("bill_date"));
        bill.setCreatedAt(resultSet.getTimestamp("created_at"));
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