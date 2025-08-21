package com.pahanaedu.servlet;

import com.pahanaedu.model.User;
import com.pahanaedu.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {
        authService = new AuthService();
    }

    /**
     * Handle GET requests - show login page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminUser") != null) {
            // User already logged in, redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Forward to login page
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }

    /**
     * Handle POST requests - process login
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("login".equals(action)) {
            handleLogin(request, response);
        } else {
            // Invalid action
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    /**
     * Handle login authentication
     */

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input parameters
        if (username == null || password == null ||
                username.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Username and password are required");
            request.setAttribute("username", username); // Preserve username
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            return;
        }

        // Validate credentials format
        if (!authService.validateCredentialsFormat(username, password)) {
            request.setAttribute("errorMessage", "Invalid username or password format");
            request.setAttribute("username", username); // Preserve username
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            return;
        }

        try {
            // Authenticate user
            User authenticatedUser = authService.authenticateUser(username, password);

            if (authenticatedUser != null) {
                // Login successful
                HttpSession session = request.getSession(true);
                session.setAttribute("adminUser", authenticatedUser);
                session.setAttribute("username", authenticatedUser.getUsername());
                session.setMaxInactiveInterval(30 * 60); // 30 minutes session timeout

                // Redirect to dashboard
                response.sendRedirect(request.getContextPath() + "/dashboard");

            } else {
                // Login failed
                request.setAttribute("errorMessage", "Invalid username or password");
                request.setAttribute("username", username); // Preserve username
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Handle any unexpected errors
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred during login. Please try again.");
            request.setAttribute("username", username); // Preserve username
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Login Servlet for Pahana Edu Admin Authentication";
    }
}