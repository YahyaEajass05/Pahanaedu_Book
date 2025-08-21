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
        String sql = "INSERT INTO customers (account_number, name, address, telephone, units_consumed) VALUES (?, ?, ?, ?, ?)";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, customer.getAccountNumber());
            statement.setString(2, customer.getName());
            statement.setString(3, customer.getAddress());
            statement.setString(4, customer.getTelephone());
            statement.setInt(5, customer.getUnitsConsumed());

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
     * Get customer by account number
     */
    public Customer getCustomerByAccountNumber(String accountNumber) {
        String sql = "SELECT * FROM customers WHERE account_number = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, accountNumber);
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
        String sql = "SELECT * FROM customers ORDER BY name";
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
        String sql = "UPDATE customers SET name = ?, address = ?, telephone = ?, units_consumed = ? WHERE account_number = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, customer.getName());
            statement.setString(2, customer.getAddress());
            statement.setString(3, customer.getTelephone());
            statement.setInt(4, customer.getUnitsConsumed());
            statement.setString(5, customer.getAccountNumber());

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
     * Delete customer by account number
     */
    public boolean deleteCustomer(String accountNumber) {
        String sql = "DELETE FROM customers WHERE account_number = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, accountNumber);

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
     * Check if customer exists
     */
    public boolean customerExists(String accountNumber) {
        String sql = "SELECT COUNT(*) FROM customers WHERE account_number = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, accountNumber);
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
     * Helper method to map ResultSet to Customer object
     */
    private Customer mapResultSetToCustomer(ResultSet resultSet) throws SQLException {
        Customer customer = new Customer();
        customer.setAccountNumber(resultSet.getString("account_number"));
        customer.setName(resultSet.getString("name"));
        customer.setAddress(resultSet.getString("address"));
        customer.setTelephone(resultSet.getString("telephone"));
        customer.setUnitsConsumed(resultSet.getInt("units_consumed"));
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