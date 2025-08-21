package com.pahanaedu.service;

import com.pahanaedu.dao.LoginDAO;
import com.pahanaedu.model.User;

public class AuthService {

    private LoginDAO loginDAO;

    public AuthService() {
        this.loginDAO = new LoginDAO();
    }

    /**
     * Authenticate admin user with username and password
     * @param username - admin username
     * @param password - admin password
     * @return User object if authentication successful, null otherwise
     */
    public User authenticateUser(String username, String password) {
        // Validate input parameters
        if (username == null || username.trim().isEmpty()) {
            return null;
        }

        if (password == null || password.trim().isEmpty()) {
            return null;
        }

        // Trim whitespace from inputs
        username = username.trim();
        password = password.trim();

        // Call DAO to validate credentials
        return loginDAO.validateLogin(username, password);
    }

    /**
     * Get user information by username
     * @param username - admin username
     * @return User object if found, null otherwise
     */
    public User getUserByUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }

        return loginDAO.getUserByUsername(username.trim());
    }

    /**
     * Validate username format
     * @param username - username to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }

        username = username.trim();

        // Username should be at least 3 characters and contain only alphanumeric characters
        return username.length() >= 3 && username.matches("^[a-zA-Z0-9_]+$");
    }

    /**
     * Validate password format
     * @param password - password to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return false;
        }

        // Password should be at least 4 characters long
        return password.trim().length() >= 4;
    }

    /**
     * Validate login credentials format before authentication
     * @param username - username to validate
     * @param password - password to validate
     * @return true if both username and password formats are valid
     */
    public boolean validateCredentialsFormat(String username, String password) {
        return isValidUsername(username) && isValidPassword(password);
    }

    /**
     * Check if user exists in the system
     * @param username - username to check
     * @return true if user exists, false otherwise
     */
    public boolean userExists(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }

        User user = loginDAO.getUserByUsername(username.trim());
        return user != null;
    }
}