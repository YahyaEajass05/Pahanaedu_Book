package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    /**
     * Handle GET requests - process logout
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        handleLogout(request, response);
    }

    /**
     * Handle POST requests - process logout
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        handleLogout(request, response);
    }

    /**
     * Handle logout process
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get current session
            HttpSession session = request.getSession(false);

            if (session != null) {
                // Get username before invalidating session (for logging purposes)
                String username = (String) session.getAttribute("username");

                // Invalidate the session
                session.invalidate();

                // Optional: Log the logout action
                System.out.println("User logged out: " + (username != null ? username : "Unknown"));
            }

            // Set cache headers to prevent back button access to protected pages
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

            // Add success message
            request.setAttribute("successMessage", "You have been successfully logged out.");

            // Redirect to login page
            response.sendRedirect(request.getContextPath() + "/login?logout=success");

        } catch (Exception e) {
            // Handle any unexpected errors
            e.printStackTrace();

            // Even if there's an error, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login?error=logout_failed");
        }
    }

    @Override
    public String getServletInfo() {
        return "Logout Servlet for Pahana Edu Admin Session Management";
    }
}