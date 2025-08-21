package com.pahanaedu.servlet;

import com.pahanaedu.service.CustomerService;
import com.pahanaedu.service.ItemService;
import com.pahanaedu.service.BillService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private CustomerService customerService;
    private ItemService itemService;
    private BillService billService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
        itemService = new ItemService();
        billService = new BillService();
    }

    /**
     * Handle GET requests - show dashboard
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Load dashboard statistics
            loadDashboardStatistics(request);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading dashboard data");
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
        }
    }

    /**
     * Handle POST requests - not typically used for dashboard
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Redirect POST requests to GET
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }

    /**
     * Load dashboard statistics and set as request attributes
     */
    private void loadDashboardStatistics(HttpServletRequest request) {
        try {
            // Customer statistics
            int totalCustomers = customerService.getCustomerCount();
            request.setAttribute("totalCustomers", totalCustomers);

            // Item statistics
            int totalItems = itemService.getItemCount();
            int totalStock = itemService.getTotalStockQuantity();
            BigDecimal inventoryValue = itemService.getTotalInventoryValue();
            int lowStockCount = itemService.getLowStockItems().size();

            request.setAttribute("totalItems", totalItems);
            request.setAttribute("totalStock", totalStock);
            request.setAttribute("inventoryValue", inventoryValue);
            request.setAttribute("lowStockCount", lowStockCount);

            // Bill statistics
            BigDecimal todaysRevenue = billService.getTodaysRevenue();
            BigDecimal monthlyRevenue = billService.getMonthlyRevenue();
            String billStats = billService.getBillStatistics();

            request.setAttribute("todaysRevenue", todaysRevenue);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("billStats", billStats);

            // System information
            String adminUsername = (String) request.getSession().getAttribute("username");
            request.setAttribute("adminUsername", adminUsername != null ? adminUsername : "Admin");

            // Current date/time for display
            request.setAttribute("currentDate", new java.util.Date());

            // Quick access flags
            boolean hasLowStock = lowStockCount > 0;
            boolean hasCustomers = totalCustomers > 0;
            boolean hasItems = totalItems > 0;

            request.setAttribute("hasLowStock", hasLowStock);
            request.setAttribute("hasCustomers", hasCustomers);
            request.setAttribute("hasItems", hasItems);

        } catch (Exception e) {
            e.printStackTrace();
            // Set default values in case of error
            request.setAttribute("totalCustomers", 0);
            request.setAttribute("totalItems", 0);
            request.setAttribute("totalStock", 0);
            request.setAttribute("inventoryValue", BigDecimal.ZERO);
            request.setAttribute("lowStockCount", 0);
            request.setAttribute("todaysRevenue", BigDecimal.ZERO);
            request.setAttribute("monthlyRevenue", BigDecimal.ZERO);
            request.setAttribute("billStats", "Unable to load statistics");
            request.setAttribute("hasLowStock", false);
            request.setAttribute("hasCustomers", false);
            request.setAttribute("hasItems", false);

            request.setAttribute("errorMessage", "Some dashboard statistics could not be loaded");
        }
    }

    @Override
    public String getServletInfo() {
        return "Dashboard Servlet for Pahana Edu Admin Panel";
    }
}