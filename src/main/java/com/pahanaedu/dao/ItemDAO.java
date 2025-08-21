package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import com.pahanaedu.util.DatabaseConnection;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    /**
     * Add a new item to the database
     */
    public boolean addItem(Item item) {
        String sql = "INSERT INTO items (item_id, item_name, price, stock) VALUES (?, ?, ?, ?)";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, item.getItemId());
            statement.setString(2, item.getItemName());
            statement.setBigDecimal(3, item.getPrice());
            statement.setInt(4, item.getStock());

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
     * Get item by item ID
     */
    public Item getItemById(String itemId) {
        String sql = "SELECT * FROM items WHERE item_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, itemId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToItem(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return null;
    }

    /**
     * Get all items
     */
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items ORDER BY item_name";
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                items.add(mapResultSetToItem(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return items;
    }

    /**
     * Update item information
     */
    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET item_name = ?, price = ?, stock = ? WHERE item_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, item.getItemName());
            statement.setBigDecimal(2, item.getPrice());
            statement.setInt(3, item.getStock());
            statement.setString(4, item.getItemId());

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
     * Delete item by item ID
     */
    public boolean deleteItem(String itemId) {
        String sql = "DELETE FROM items WHERE item_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, itemId);

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
     * Check if item exists
     */
    public boolean itemExists(String itemId) {
        String sql = "SELECT COUNT(*) FROM items WHERE item_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setString(1, itemId);
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
     * Update item stock (reduce stock when sold)
     */
    public boolean updateStock(String itemId, int quantitySold) {
        String sql = "UPDATE items SET stock = stock - ? WHERE item_id = ? AND stock >= ?";
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, quantitySold);
            statement.setString(2, itemId);
            statement.setInt(3, quantitySold);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0; // Returns false if insufficient stock

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, statement, connection);
        }
    }

    /**
     * Get items with low stock (less than specified threshold)
     */
    public List<Item> getLowStockItems(int threshold) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE stock < ? ORDER BY stock ASC";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            statement = connection.prepareStatement(sql);
            statement.setInt(1, threshold);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                items.add(mapResultSetToItem(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return items;
    }

    /**
     * Helper method to map ResultSet to Item object
     */
    private Item mapResultSetToItem(ResultSet resultSet) throws SQLException {
        Item item = new Item();
        item.setItemId(resultSet.getString("item_id"));
        item.setItemName(resultSet.getString("item_name"));
        item.setPrice(resultSet.getBigDecimal("price"));
        item.setStock(resultSet.getInt("stock"));
        item.setCreatedAt(resultSet.getTimestamp("created_at"));
        item.setUpdatedAt(resultSet.getTimestamp("updated_at"));
        return item;
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