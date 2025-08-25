package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;
import com.pahanaedu.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    /**
     * Add a new customer to the database
     */
    public boolean addCustomer(Customer customer) {
        String sql = "INSERT INTO customers (name, email, phone, address, membership_type, total_purchases, loyalty_points) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getPhone());
            statement.setString(4, customer.getAddress());
            statement.setString(5, customer.getMembershipType());
            statement.setDouble(6, customer.getTotalPurchases());
            statement.setInt(7, customer.getLoyaltyPoints());

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
     * Get customer by ID
     */
    public Customer getCustomerById(int customerId) {
        String sql = "SELECT * FROM customers WHERE customer_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, customerId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToCustomer(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return null;
    }

    /**
     * Get customer by email
     */
    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT * FROM customers WHERE email = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToCustomer(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return null;
    }

    /**
     * Get all customers
     */
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY created_at DESC";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                customers.add(mapResultSetToCustomer(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return customers;
    }

    /**
     * Update customer information
     */
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customers SET name = ?, email = ?, phone = ?, address = ?, " +
                "membership_type = ?, total_purchases = ?, loyalty_points = ? WHERE customer_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getPhone());
            statement.setString(4, customer.getAddress());
            statement.setString(5, customer.getMembershipType());
            statement.setDouble(6, customer.getTotalPurchases());
            statement.setInt(7, customer.getLoyaltyPoints());
            statement.setInt(8, customer.getCustomerId());

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
     * Delete customer by ID
     */
    public boolean deleteCustomer(int customerId) {
        String sql = "DELETE FROM customers WHERE customer_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, customerId);

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
     * Search customers by name, email, or phone
     */
    public List<Customer> searchCustomers(String searchTerm) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE name LIKE ? OR email LIKE ? OR phone LIKE ? ORDER BY name";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            String searchPattern = "%" + searchTerm + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            statement.setString(3, searchPattern);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                customers.add(mapResultSetToCustomer(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return customers;
    }

    /**
     * Get customers by membership type
     */
    public List<Customer> getCustomersByMembershipType(String membershipType) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE membership_type = ? ORDER BY total_purchases DESC";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, membershipType);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                customers.add(mapResultSetToCustomer(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return customers;
    }

    /**
     * Check if customer exists by email
     */
    public boolean customerExists(String email) {
        String sql = "SELECT COUNT(*) FROM customers WHERE email = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return false;
    }

    /**
     * Update customer purchase amount and loyalty points
     */
    public boolean updateCustomerPurchase(int customerId, double purchaseAmount) {
        String sql = "UPDATE customers SET total_purchases = total_purchases + ?, " +
                "loyalty_points = loyalty_points + ? WHERE customer_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setDouble(1, purchaseAmount);
            statement.setInt(2, (int)(purchaseAmount / 10)); // 1 point per $10
            statement.setInt(3, customerId);

            int rowsAffected = statement.executeUpdate();

            // Update membership type based on new total
            if (rowsAffected > 0) {
                updateMembershipType(customerId);
            }

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, statement, connection);
        }
    }

    /**
     * Update membership type based on total purchases
     */
    private void updateMembershipType(int customerId) {
        String selectSql = "SELECT total_purchases FROM customers WHERE customer_id = ?";
        String updateSql = "UPDATE customers SET membership_type = ? WHERE customer_id = ?";
        Connection connection = null;
        PreparedStatement selectStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();

            // Get current total purchases
            selectStmt = connection.prepareStatement(selectSql);
            selectStmt.setInt(1, customerId);
            resultSet = selectStmt.executeQuery();

            if (resultSet.next()) {
                double totalPurchases = resultSet.getDouble("total_purchases");
                String newMembershipType;

                if (totalPurchases >= 5000) {
                    newMembershipType = "VIP";
                } else if (totalPurchases >= 2000) {
                    newMembershipType = "PREMIUM";
                } else {
                    newMembershipType = "REGULAR";
                }

                // Update membership type
                updateStmt = connection.prepareStatement(updateSql);
                updateStmt.setString(1, newMembershipType);
                updateStmt.setInt(2, customerId);
                updateStmt.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, selectStmt, null);
            closeResources(null, updateStmt, connection);
        }
    }

    /**
     * Redeem loyalty points
     */
    public boolean redeemLoyaltyPoints(int customerId, int points) {
        String sql = "UPDATE customers SET loyalty_points = loyalty_points - ? WHERE customer_id = ? AND loyalty_points >= ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, points);
            statement.setInt(2, customerId);
            statement.setInt(3, points);

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
     * Get top customers by purchase amount
     */
    public List<Customer> getTopCustomers(int limit) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY total_purchases DESC LIMIT ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, limit);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                customers.add(mapResultSetToCustomer(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return customers;
    }

    /**
     * Helper method to map ResultSet to Customer object
     */
    private Customer mapResultSetToCustomer(ResultSet resultSet) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(resultSet.getInt("customer_id"));
        customer.setName(resultSet.getString("name"));
        customer.setEmail(resultSet.getString("email"));
        customer.setPhone(resultSet.getString("phone"));
        customer.setAddress(resultSet.getString("address"));
        customer.setMembershipType(resultSet.getString("membership_type"));
        customer.setTotalPurchases(resultSet.getDouble("total_purchases"));
        customer.setLoyaltyPoints(resultSet.getInt("loyalty_points"));
        customer.setCreatedAt(resultSet.getTimestamp("created_at"));
        customer.setUpdatedAt(resultSet.getTimestamp("updated_at"));
        return customer;
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
