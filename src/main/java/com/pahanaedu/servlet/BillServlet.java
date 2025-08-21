package com.pahanaedu.servlet;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.service.BillService;
import com.pahanaedu.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "BillServlet", urlPatterns = {"/bill"})
public class BillServlet extends HttpServlet {

    private BillService billService;
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        billService = new BillService();
        customerService = new CustomerService();
    }

    /**
     * Handle GET requests - display bill pages
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
            if (action == null || "create".equals(action)) {
                showCreateBillForm(request, response);
            } else if ("generate".equals(action)) {
                generateBill(request, response);
            } else if ("view".equals(action)) {
                viewBill(request, response);
            } else if ("print".equals(action)) {
                printBill(request, response);
            } else if ("list".equals(action)) {
                listBills(request, response);
            } else if ("customer".equals(action)) {
                showCustomerBills(request, response);
            } else if ("calculate".equals(action)) {
                calculateBillAmount(request, response);
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
     * Handle POST requests - process bill operations
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
            if ("generate".equals(action)) {
                processBillGeneration(request, response);
            } else if ("calculate".equals(action)) {
                calculateBillAmount(request, response);
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
     * Show create bill form
     */
    private void showCreateBillForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Customer> customers = customerService.getAllCustomers();
        BigDecimal ratePerUnit = billService.getRatePerUnit();

        request.setAttribute("customers", customers);
        request.setAttribute("ratePerUnit", ratePerUnit);
        request.setAttribute("pageTitle", "Generate Bill");
        request.getRequestDispatcher("/jsp/bill-create.jsp").forward(request, response);
    }

    /**
     * Generate bill (GET request - show form with customer details)
     */
    private void generateBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");

        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please select a customer");
            showCreateBillForm(request, response);
            return;
        }

        Customer customer = customerService.getCustomerByAccountNumber(accountNumber);

        if (customer == null) {
            request.setAttribute("errorMessage", "Customer not found");
            showCreateBillForm(request, response);
            return;
        }

        // Calculate bill amount based on customer's units consumed
        BigDecimal billAmount = billService.calculateBillAmount(customer.getUnitsConsumed());
        String billNumber = billService.generateBillNumber();
        BigDecimal ratePerUnit = billService.getRatePerUnit();

        request.setAttribute("customer", customer);
        request.setAttribute("billAmount", billAmount);
        request.setAttribute("billNumber", billNumber);
        request.setAttribute("ratePerUnit", ratePerUnit);
        request.setAttribute("currentDate", Date.valueOf(LocalDate.now()));
        request.setAttribute("pageTitle", "Generate Bill for " + customer.getName());
        request.getRequestDispatcher("/jsp/bill-generate.jsp").forward(request, response);
    }

    /**
     * Process bill generation (POST request - save bill)
     */
    private void processBillGeneration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String unitsConsumedStr = request.getParameter("unitsConsumed");

        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Account number is required");
            showCreateBillForm(request, response);
            return;
        }

        if (unitsConsumedStr == null || unitsConsumedStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Units consumed is required");
            showCreateBillForm(request, response);
            return;
        }

        try {
            int unitsConsumed = Integer.parseInt(unitsConsumedStr.trim());

            if (unitsConsumed < 0) {
                request.setAttribute("errorMessage", "Units consumed cannot be negative");
                showCreateBillForm(request, response);
                return;
            }

            // Generate bill with custom units
            Bill bill = billService.generateBillWithCustomUnits(accountNumber, unitsConsumed);

            if (bill != null) {
                response.sendRedirect(request.getContextPath() + "/bill?action=view&billId=" +
                        bill.getBillId() + "&success=Bill generated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to generate bill");
                showCreateBillForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid units consumed format");
            showCreateBillForm(request, response);
        }
    }

    /**
     * View bill details
     */
    private void viewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billIdStr = request.getParameter("billId");

        if (billIdStr == null || billIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Bill ID is required");
            listBills(request, response);
            return;
        }

        try {
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billService.getBillById(billId);

            if (bill == null) {
                request.setAttribute("errorMessage", "Bill not found with ID: " + billId);
                listBills(request, response);
                return;
            }

            // Get customer details
            Customer customer = customerService.getCustomerByAccountNumber(bill.getAccountNumber());
            BigDecimal ratePerUnit = billService.getRatePerUnit();

            request.setAttribute("bill", bill);
            request.setAttribute("customer", customer);
            request.setAttribute("ratePerUnit", ratePerUnit);
            request.setAttribute("pageTitle", "Bill Details - #" + billId);
            request.getRequestDispatcher("/jsp/bill-view.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid bill ID format");
            listBills(request, response);
        }
    }

    /**
     * Print bill
     */
    private void printBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billIdStr = request.getParameter("billId");

        if (billIdStr == null || billIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Bill ID is required");
            listBills(request, response);
            return;
        }

        try {
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billService.getBillById(billId);

            if (bill == null) {
                request.setAttribute("errorMessage", "Bill not found with ID: " + billId);
                listBills(request, response);
                return;
            }

            // Get customer details
            Customer customer = customerService.getCustomerByAccountNumber(bill.getAccountNumber());
            BigDecimal ratePerUnit = billService.getRatePerUnit();

            request.setAttribute("bill", bill);
            request.setAttribute("customer", customer);
            request.setAttribute("ratePerUnit", ratePerUnit);
            request.setAttribute("pageTitle", "Print Bill - #" + billId);
            request.getRequestDispatcher("/jsp/bill-print.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid bill ID format");
            listBills(request, response);
        }
    }

    /**
     * List all bills
     */
    private void listBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Bill> bills = billService.getAllBills();
        BigDecimal todaysRevenue = billService.getTodaysRevenue();
        BigDecimal monthlyRevenue = billService.getMonthlyRevenue();
        String billStats = billService.getBillStatistics();

        request.setAttribute("bills", bills);
        request.setAttribute("todaysRevenue", todaysRevenue);
        request.setAttribute("monthlyRevenue", monthlyRevenue);
        request.setAttribute("billStats", billStats);
        request.setAttribute("pageTitle", "All Bills");
        request.getRequestDispatcher("/jsp/bill-list.jsp").forward(request, response);
    }

    /**
     * Show bills for a specific customer
     */
    private void showCustomerBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");

        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Account number is required");
            listBills(request, response);
            return;
        }

        Customer customer = customerService.getCustomerByAccountNumber(accountNumber);

        if (customer == null) {
            request.setAttribute("errorMessage", "Customer not found");
            listBills(request, response);
            return;
        }

        List<Bill> bills = billService.getBillsByCustomer(accountNumber);

        request.setAttribute("bills", bills);
        request.setAttribute("customer", customer);
        request.setAttribute("pageTitle", "Bills for " + customer.getName());
        request.getRequestDispatcher("/jsp/bill-list.jsp").forward(request, response);
    }

    /**
     * Calculate bill amount (AJAX request)
     */
    private void calculateBillAmount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String unitsConsumedStr = request.getParameter("unitsConsumed");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            if (unitsConsumedStr == null || unitsConsumedStr.trim().isEmpty()) {
                response.getWriter().write("{\"error\": \"Units consumed is required\"}");
                return;
            }

            int unitsConsumed = Integer.parseInt(unitsConsumedStr.trim());

            if (unitsConsumed < 0) {
                response.getWriter().write("{\"error\": \"Units consumed cannot be negative\"}");
                return;
            }

            BigDecimal billAmount = billService.calculateBillAmount(unitsConsumed);
            BigDecimal ratePerUnit = billService.getRatePerUnit();

            String jsonResponse = String.format(
                    "{\"billAmount\": %.2f, \"ratePerUnit\": %.2f, \"unitsConsumed\": %d}",
                    billAmount, ratePerUnit, unitsConsumed
            );

            response.getWriter().write(jsonResponse);

        } catch (NumberFormatException e) {
            response.getWriter().write("{\"error\": \"Invalid units consumed format\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"error\": \"Calculation failed\"}");
        }
    }

    /**
     * Check if user is logged in
     */
    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("adminUser") != null;
    }

    @Override
    public String getServletInfo() {
        return "Bill Management Servlet for Pahana Edu";
    }
}