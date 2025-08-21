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
        request.setAttribute("pageTitle", "Customer Management");
        request.getRequestDispatcher("/jsp/customer-list.jsp").forward(request, response);
    }

    /**
     * Display customer details
     */
    private void viewCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");

        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Account number is required");
            listCustomers(request, response);
            return;
        }

        Customer customer = customerService.getCustomerByAccountNumber(accountNumber);

        if (customer == null) {
            request.setAttribute("errorMessage", "Customer not found with account number: " + accountNumber);
            listCustomers(request, response);
            return;
        }

        request.setAttribute("customer", customer);
        request.setAttribute("pageTitle", "Customer Details - " + customer.getName());
        request.getRequestDispatcher("/jsp/customer-view.jsp").forward(request, response);
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

        String accountNumber = request.getParameter("accountNumber");

        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Account number is required");
            listCustomers(request, response);
            return;
        }

        Customer customer = customerService.getCustomerByAccountNumber(accountNumber);

        if (customer == null) {
            request.setAttribute("errorMessage", "Customer not found with account number: " + accountNumber);
            listCustomers(request, response);
            return;
        }

        request.setAttribute("customer", customer);
        request.setAttribute("pageTitle", "Edit Customer - " + customer.getName());
        request.getRequestDispatcher("/jsp/customer-edit.jsp").forward(request, response);
    }

    /**
     * Show delete customer confirmation
     */
    private void showDeleteCustomerForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");

        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Account number is required");
            listCustomers(request, response);
            return;
        }

        Customer customer = customerService.getCustomerByAccountNumber(accountNumber);

        if (customer == null) {
            request.setAttribute("errorMessage", "Customer not found with account number: " + accountNumber);
            listCustomers(request, response);
            return;
        }

        request.setAttribute("customer", customer);
        request.setAttribute("pageTitle", "Delete Customer - " + customer.getName());
        request.getRequestDispatcher("/jsp/customer-delete.jsp").forward(request, response);
    }

    /**
     * Add new customer
     */
    private void addCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String unitsConsumedStr = request.getParameter("unitsConsumed");

        // Validate input
        if (accountNumber == null || name == null || address == null ||
                telephone == null || unitsConsumedStr == null ||
                accountNumber.trim().isEmpty() || name.trim().isEmpty() ||
                address.trim().isEmpty() || telephone.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required");
            preserveFormData(request, accountNumber, name, address, telephone, unitsConsumedStr);
            showAddCustomerForm(request, response);
            return;
        }

        try {
            int unitsConsumed = Integer.parseInt(unitsConsumedStr.trim());

            if (unitsConsumed < 0) {
                request.setAttribute("errorMessage", "Units consumed cannot be negative");
                preserveFormData(request, accountNumber, name, address, telephone, unitsConsumedStr);
                showAddCustomerForm(request, response);
                return;
            }

            Customer customer = new Customer(accountNumber.trim(), name.trim(),
                    address.trim(), telephone.trim(), unitsConsumed);

            if (customerService.addCustomer(customer)) {
                response.sendRedirect(request.getContextPath() + "/customer?action=list&success=Customer added successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to add customer. Account number may already exist.");
                preserveFormData(request, accountNumber, name, address, telephone, unitsConsumedStr);
                showAddCustomerForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid units consumed. Please enter a valid number.");
            preserveFormData(request, accountNumber, name, address, telephone, unitsConsumedStr);
            showAddCustomerForm(request, response);
        }
    }

    /**
     * Update existing customer
     */
    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String unitsConsumedStr = request.getParameter("unitsConsumed");

        // Validate input
        if (accountNumber == null || name == null || address == null ||
                telephone == null || unitsConsumedStr == null ||
                accountNumber.trim().isEmpty() || name.trim().isEmpty() ||
                address.trim().isEmpty() || telephone.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required");
            request.getParameter("accountNumber");
            showEditCustomerForm(request, response);
            return;
        }

        try {
            int unitsConsumed = Integer.parseInt(unitsConsumedStr.trim());

            if (unitsConsumed < 0) {
                request.setAttribute("errorMessage", "Units consumed cannot be negative");
                showEditCustomerForm(request, response);
                return;
            }

            Customer customer = new Customer(accountNumber.trim(), name.trim(),
                    address.trim(), telephone.trim(), unitsConsumed);

            if (customerService.updateCustomer(customer)) {
                response.sendRedirect(request.getContextPath() + "/customer?action=view&accountNumber=" +
                        accountNumber + "&success=Customer updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update customer");
                showEditCustomerForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid units consumed. Please enter a valid number.");
            showEditCustomerForm(request, response);
        }
    }

    /**
     * Delete customer
     */
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");

        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Account number is required");
            listCustomers(request, response);
            return;
        }

        if (customerService.deleteCustomer(accountNumber)) {
            response.sendRedirect(request.getContextPath() + "/customer?action=list&success=Customer deleted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete customer");
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
    private void preserveFormData(HttpServletRequest request, String accountNumber,
                                  String name, String address, String telephone, String unitsConsumed) {
        request.setAttribute("accountNumber", accountNumber);
        request.setAttribute("name", name);
        request.setAttribute("address", address);
        request.setAttribute("telephone", telephone);
        request.setAttribute("unitsConsumed", unitsConsumed);
    }

    @Override
    public String getServletInfo() {
        return "Customer Management Servlet for Pahana Edu";
    }
}