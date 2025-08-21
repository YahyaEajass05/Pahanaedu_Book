package com.pahanaedu.dao;

import com.pahanaedu.model.User;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class LoginDAOTest {

    @Test
    void testValidateLogin_withValidCredentials() {
        LoginDAO dao = new LoginDAO();
        // ⚠️ These credentials must exist in your "admin" table in DB
        User user = dao.validateLogin("admin", "admin123");
        assertNotNull(user, "User should not be null with valid credentials");
        assertEquals("admin", user.getUsername());
    }

    @Test
    void testValidateLogin_withInvalidCredentials() {
        LoginDAO dao = new LoginDAO();
        User user = dao.validateLogin("wrongUser", "wrongPass");
        assertNull(user, "User should be null with invalid credentials");
    }

    @Test
    void testGetUserByUsername_found() {
        LoginDAO dao = new LoginDAO();
        // ⚠️ Make sure "admin" exists in your DB
        User user = dao.getUserByUsername("admin");
        assertNotNull(user, "User should be found by username");
        assertEquals("admin", user.getUsername());
    }

    @Test
    void testGetUserByUsername_notFound() {
        LoginDAO dao = new LoginDAO();
        User user = dao.getUserByUsername("ghost");
        assertNull(user, "User should be null if username does not exist");
    }
}
