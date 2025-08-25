package com.pahanaedu.servlet;

import com.pahanaedu.model.Customer;
import com.pahanaedu.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerServlet", urlPatterns = {"/customer"})
public class CustomerServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    /**
     * Handle GET requests - display customer pages
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if (action == null || "list".equals(action)) {
                listCustomers(request, response);
            } else if ("view".equals(action)) {
                viewCustomer(request, response);
            } else if ("add".equals(action)) {
                showAddCustomerForm(request, response);
            } else if ("edit".equals(action)) {
                showEditCustomerForm(request, response);
            } else if ("delete".equals(action)) {
                showDeleteCustomerForm(request, response);
            } else if ("search".equals(action)) {
                searchCustomers(request, response);
            } else if ("topCustomers".equals(action)) {
                showTopCustomers(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your request");
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    /**
     * Handle POST requests - process customer operations
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addCustomer(request, response);
            } else if ("update".equals(action)) {
                updateCustomer(request, response);
            } else if ("confirmDelete".equals(action)) {
                deleteCustomer(request, response);
            } else if ("addPoints".equals(action)) {
                addLoyaltyPoints(request, response);
            } else if ("redeemPoints".equals(action)) {
                redeemLoyaltyPoints(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your request");
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    /**
     * Display list of all customers
     */
    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Customer> customers = customerService.getAllCustomers();
        request.setAttribute("customers", customers);
        request.setAttribute("totalCustomers", customerService.getCustomerCount());
        request.setAttribute("regularCount", customerService.getCustomerCountByMembershipType("REGULAR"));
        request.setAttribute("premiumCount", customerService.getCustomerCountByMembershipType("PREMIUM"));
        request.setAttribute("vipCount", customerService.getCustomerCountByMembershipType("VIP"));
        request.setAttribute("pageTitle", "Customer Management");
        request.getRequestDispatcher("/jsp/customer-list.jsp").forward(request, response);
    }

    /**
     * Display customer details
     */
    private void viewCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");

        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Customer ID is required");
            listCustomers(request, response);
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr);
            Customer customer = customerService.getCustomerById(customerId);

            if (customer == null) {
                request.setAttribute("errorMessage", "Customer not found with ID: " + customerId);
                listCustomers(request, response);
                return;
            }

            request.setAttribute("customer", customer);
            request.setAttribute("pageTitle", "Customer Details - " + customer.getName());
            request.getRequestDispatcher("/jsp/customer-view.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid customer ID");
            listCustomers(request, response);
        }
    }

    /**
     * Show add customer form
     */
    private void showAddCustomerForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "Add New Customer");
        request.getRequestDispatcher("/jsp/customer-add.jsp").forward(request, response);
    }

    /**
     * Show edit customer form
     */
    private void showEditCustomerForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");

        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Customer ID is required");
            listCustomers(request, response);
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr);
            Customer customer = customerService.getCustomerById(customerId);

            if (customer == null) {
                request.setAttribute("errorMessage", "Customer not found with ID: " + customerId);
                listCustomers(request, response);
                return;
            }

            request.setAttribute("customer", customer);
            request.setAttribute("pageTitle", "Edit Customer - " + customer.getName());
            request.getRequestDispatcher("/jsp/customer-edit.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid customer ID");
            listCustomers(request, response);
        }
    }

    /**
     * Show delete customer confirmation
     */
    private void showDeleteCustomerForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");

        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Customer ID is required");
            listCustomers(request, response);
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr);
            Customer customer = customerService.getCustomerById(customerId);

            if (customer == null) {
                request.setAttribute("errorMessage", "Customer not found with ID: " + customerId);
                listCustomers(request, response);
                return;
            }

            request.setAttribute("customer", customer);
            request.setAttribute("pageTitle", "Delete Customer - " + customer.getName());
            request.getRequestDispatcher("/jsp/customer-delete.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid customer ID");
            listCustomers(request, response);
        }
    }

    /**
     * Add new customer
     */
    private void addCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Validate input
        if (name == null || email == null || phone == null || address == null ||
                name.trim().isEmpty() || email.trim().isEmpty() ||
                phone.trim().isEmpty() || address.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required");
            preserveFormData(request, name, email, phone, address);
            showAddCustomerForm(request, response);
            return;
        }

        // Check if email already exists
        if (customerService.emailExists(email)) {
            request.setAttribute("errorMessage", "A customer with this email already exists");
            preserveFormData(request, name, email, phone, address);
            showAddCustomerForm(request, response);
            return;
        }

        Customer customer = new Customer(name.trim(), email.trim(), phone.trim(), address.trim());

        if (customerService.registerCustomer(customer)) {
            response.sendRedirect(request.getContextPath() +
                    "/customer?action=list&success=Customer added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add customer. Please check your input.");
            preserveFormData(request, name, email, phone, address);
            showAddCustomerForm(request, response);
        }
    }

    /**
     * Update existing customer
     */
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String membershipType = request.getParameter("membershipType");
        String totalPurchasesStr = request.getParameter("totalPurchases");
        String loyaltyPointsStr = request.getParameter("loyaltyPoints");

        // Validate input
        if (customerIdStr == null || name == null || email == null || phone == null ||
                address == null || membershipType == null || totalPurchasesStr == null ||
                loyaltyPointsStr == null || name.trim().isEmpty() || email.trim().isEmpty() ||
                phone.trim().isEmpty() || address.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required");
            showEditCustomerForm(request, response);
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr);
            double totalPurchases = Double.parseDouble(totalPurchasesStr);
            int loyaltyPoints = Integer.parseInt(loyaltyPointsStr);

            if (totalPurchases < 0 || loyaltyPoints < 0) {
                request.setAttribute("errorMessage", "Total purchases and loyalty points cannot be negative");
                showEditCustomerForm(request, response);
                return;
            }

            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            customer.setName(name.trim());
            customer.setEmail(email.trim());
            customer.setPhone(phone.trim());
            customer.setAddress(address.trim());
            customer.setMembershipType(membershipType);
            customer.setTotalPurchases(totalPurchases);
            customer.setLoyaltyPoints(loyaltyPoints);

            if (customerService.updateCustomer(customer)) {
                response.sendRedirect(request.getContextPath() +
                        "/customer?action=view&customerId=" + customerId +
                        "&success=Customer updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update customer. Email may already exist.");
                showEditCustomerForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric values entered");
            showEditCustomerForm(request, response);
        }
    }

    /**
     * Delete customer
     */
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");

        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Customer ID is required");
            listCustomers(request, response);
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr);

            if (customerService.deleteCustomer(customerId)) {
                response.sendRedirect(request.getContextPath() +
                        "/customer?action=list&success=Customer deleted successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to delete customer");
                listCustomers(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid customer ID");
            listCustomers(request, response);
        }
    }

    /**
     * Search customers
     */
    private void searchCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("searchTerm");
        String membershipFilter = request.getParameter("membershipFilter");

        List<Customer> customers;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            customers = customerService.searchCustomers(searchTerm);
        } else if (membershipFilter != null && !membershipFilter.trim().isEmpty() &&
                !"ALL".equals(membershipFilter)) {
            customers = customerService.getCustomersByMembershipType(membershipFilter);
        } else {
            customers = customerService.getAllCustomers();
        }

        request.setAttribute("customers", customers);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("membershipFilter", membershipFilter);
        request.setAttribute("pageTitle", "Customer Search Results");
        request.getRequestDispatcher("/jsp/customer-list.jsp").forward(request, response);
    }

    /**
     * Show top customers
     */
    private void showTopCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Customer> topCustomers = customerService.getTopCustomers(10);
        request.setAttribute("customers", topCustomers);
        request.setAttribute("pageTitle", "Top 10 Customers");
        request.setAttribute("isTopCustomers", true);
        request.getRequestDispatcher("/jsp/customer-list.jsp").forward(request, response);
    }

    /**
     * Add loyalty points
     */
    private void addLoyaltyPoints(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");
        String pointsStr = request.getParameter("points");

        try {
            int customerId = Integer.parseInt(customerIdStr);
            int points = Integer.parseInt(pointsStr);

            if (customerService.addLoyaltyPoints(customerId, points)) {
                response.sendRedirect(request.getContextPath() +
                        "/customer?action=view&customerId=" + customerId +
                        "&success=Loyalty points added successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to add loyalty points");
                viewCustomer(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric values");
            listCustomers(request, response);
        }
    }

    /**
     * Redeem loyalty points
     */
    private void redeemLoyaltyPoints(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdStr = request.getParameter("customerId");
        String pointsStr = request.getParameter("points");

        try {
            int customerId = Integer.parseInt(customerIdStr);
            int points = Integer.parseInt(pointsStr);

            if (customerService.redeemLoyaltyPoints(customerId, points)) {
                response.sendRedirect(request.getContextPath() +
                        "/customer?action=view&customerId=" + customerId +
                        "&success=Loyalty points redeemed successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to redeem loyalty points. Insufficient balance.");
                viewCustomer(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid numeric values");
            listCustomers(request, response);
        }
    }

    /**
     * Check if user is logged in
     */
    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("adminUser") != null;
    }

    /**
     * Preserve form data for redisplay
     */
    private void preserveFormData(HttpServletRequest request, String name,
                                  String email, String phone, String address) {
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
    }

    @Override
    public String getServletInfo() {
        return "Customer Management Servlet for Book Shop Management System";
    }
}
