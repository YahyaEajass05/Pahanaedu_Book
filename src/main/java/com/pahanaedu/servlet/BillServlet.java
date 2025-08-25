package com.pahanaedu.servlet;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import com.pahanaedu.service.BillService;
import com.pahanaedu.service.CustomerService;
import com.pahanaedu.service.ItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "BillServlet", urlPatterns = {"/bill"})
public class BillServlet extends HttpServlet {

    private BillService billService;
    private CustomerService customerService;
    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        billService = new BillService();
        customerService = new CustomerService();
        itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if (action == null || "list".equals(action)) {
                listBills(request, response);
            } else if ("view".equals(action)) {
                viewBill(request, response);
            } else if ("new".equals(action)) {
                showNewBillForm(request, response);
            } else if ("print".equals(action)) {
                printBill(request, response);
            } else if ("customer".equals(action)) {
                showCustomerBills(request, response);
            } else if ("search".equals(action)) {
                searchBills(request, response);
            } else if ("today".equals(action)) {
                showTodaysBills(request, response);
            } else if ("analytics".equals(action)) {
                showBillAnalytics(request, response);
            } else if ("return".equals(action)) {
                showReturnForm(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("cancel".equals(action)) {
                cancelBill(request, response);
            } else if ("updateStatus".equals(action)) {
            } else if ("processReturn".equals(action)) {
                processReturn(request, response);
            } else if ("export".equals(action)) {
                exportBills(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    private void listBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String status = request.getParameter("status");

        List<Bill> bills;

        if (startDateStr != null && endDateStr != null && !startDateStr.isEmpty() && !endDateStr.isEmpty()) {
            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);
            bills = billService.getBillsByDateRange(startDate, endDate);
        } else {
            bills = billService.getAllBills();
        }

        // Filter by status if specified
        if (status != null && !status.isEmpty() && !"ALL".equals(status)) {
            bills = bills.stream()
                    .filter(bill -> status.equals(bill.getPaymentStatus()))
                    .collect(Collectors.toList());
        }

        // Get statistics
        BigDecimal todaysSales = billService.getTodaysSales();
        Map<String, Object> billStats = billService.getBillStatisticsSummary();

        // Calculate totals
        BigDecimal totalAmount = bills.stream()
                .filter(bill -> "PAID".equals(bill.getPaymentStatus()))
                .map(Bill::getTotalAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        request.setAttribute("bills", bills);
        request.setAttribute("todaysSales", todaysSales);
        request.setAttribute("billStats", billStats);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("pageTitle", "Sales Bills");

        // Handle success/error messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");
        if (success != null) {
            request.setAttribute("successMessage", success);
        }
        if (error != null) {
            request.setAttribute("errorMessage", error);
        }

        request.getRequestDispatcher("/jsp/bill-list.jsp").forward(request, response);
    }

    private void viewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String billIdStr = request.getParameter("billId");

        if (billIdStr == null || billIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Bill ID is required");
            return;
        }

        try {
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billService.getBillById(billId);

            if (bill == null) {
                response.sendRedirect(request.getContextPath() + "/bill?error=Bill not found");
                return;
            }

            // Calculate savings
            BigDecimal totalSavings = bill.getDiscountAmount()
                    .add(new BigDecimal(bill.getLoyaltyPointsRedeemed())
                            .multiply(new BigDecimal("0.10")));

            request.setAttribute("bill", bill);
            request.setAttribute("totalSavings", totalSavings);
            request.setAttribute("pageTitle", "Bill Details - " + bill.getBillNumber());

            // Check for success message
            String success = request.getParameter("success");
            if (success != null) {
                request.setAttribute("successMessage", success);
            }

            request.getRequestDispatcher("/jsp/viewBill.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Invalid bill ID");
        }
    }

    private void showNewBillForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<Customer> customers = customerService.getAllCustomers();
        List<Item> items = itemService.getAllItems();

        request.setAttribute("customers", customers);
        request.setAttribute("items", items);
        request.setAttribute("pageTitle", "New Bill");
        request.getRequestDispatcher("/jsp/bill-new.jsp").forward(request, response);
    }

    private void printBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String billIdStr = request.getParameter("billId");

        if (billIdStr == null || billIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Bill ID is required");
            return;
        }

        try {
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billService.getBillById(billId);

            if (bill == null) {
                response.sendRedirect(request.getContextPath() + "/bill?error=Bill not found");
                return;
            }

            request.setAttribute("bill", bill);
            request.setAttribute("companyName", "Book Paradise");
            request.setAttribute("companyAddress", "123 Book Street, Reading City");
            request.setAttribute("companyPhone", "+94 11 2345678");
            request.setAttribute("companyEmail", "info@bookparadise.lk");
            request.setAttribute("isPrintView", true);

            request.getRequestDispatcher("/jsp/bill-print.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Invalid bill ID");
        }
    }

    private void showCustomerBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String customerIdStr = request.getParameter("customerId");

        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Customer ID is required");
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr);
            Customer customer = customerService.getCustomerById(customerId);

            if (customer == null) {
                response.sendRedirect(request.getContextPath() + "/bill?error=Customer not found");
                return;
            }

            List<Bill> bills = billService.getBillsByCustomer(customerId);

            // Calculate customer statistics
            BigDecimal totalPurchases = BigDecimal.ZERO;
            BigDecimal totalSavings = BigDecimal.ZERO;
            int totalLoyaltyEarned = 0;
            int totalLoyaltyRedeemed = 0;

            for (Bill bill : bills) {
                if ("PAID".equals(bill.getPaymentStatus())) {
                    totalPurchases = totalPurchases.add(bill.getTotalAmount());
                    totalSavings = totalSavings.add(bill.getDiscountAmount());
                    totalLoyaltyEarned += bill.getLoyaltyPointsEarned();
                    totalLoyaltyRedeemed += bill.getLoyaltyPointsRedeemed();
                }
            }

            request.setAttribute("bills", bills);
            request.setAttribute("customer", customer);
            request.setAttribute("totalPurchases", totalPurchases);
            request.setAttribute("totalSavings", totalSavings);
            request.setAttribute("totalLoyaltyEarned", totalLoyaltyEarned);
            request.setAttribute("totalLoyaltyRedeemed", totalLoyaltyRedeemed);
            request.setAttribute("pageTitle", "Purchase History - " + customer.getName());
            request.getRequestDispatcher("/jsp/customer-bills.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Invalid customer ID");
        }
    }

    private void searchBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String searchTerm = request.getParameter("q");

        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/bill");
            return;
        }

        List<Bill> allBills = billService.getAllBills();

        // Search by bill number, customer name, or customer phone
        List<Bill> filteredBills = allBills.stream()
                .filter(bill ->
                        bill.getBillNumber().toLowerCase().contains(searchTerm.toLowerCase()) ||
                                (bill.getCustomerName() != null &&
                                        bill.getCustomerName().toLowerCase().contains(searchTerm.toLowerCase())) ||
                                (bill.getCustomerPhone() != null &&
                                        bill.getCustomerPhone().contains(searchTerm))
                )
                .collect(Collectors.toList());

        request.setAttribute("bills", filteredBills);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("pageTitle", "Search Results: " + searchTerm);
        request.getRequestDispatcher("/jsp/bill-list.jsp").forward(request, response);
    }

    private void showTodaysBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Date today = Date.valueOf(LocalDate.now());
        List<Bill> bills = billService.getBillsByDateRange(today, today);

        // Calculate today's statistics
        BigDecimal totalSales = BigDecimal.ZERO;
        BigDecimal totalDiscount = BigDecimal.ZERO;
        int totalItems = 0;

        for (Bill bill : bills) {
            if ("PAID".equals(bill.getPaymentStatus())) {
                totalSales = totalSales.add(bill.getTotalAmount());
                totalDiscount = totalDiscount.add(bill.getDiscountAmount());
                totalItems += bill.getTotalItems();
            }
        }

        request.setAttribute("bills", bills);
        request.setAttribute("totalSales", totalSales);
        request.setAttribute("totalDiscount", totalDiscount);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("pageTitle", "Today's Sales");
        request.setAttribute("isToday", true);
        request.getRequestDispatcher("/jsp/bill-list.jsp").forward(request, response);
    }

    private void showBillAnalytics(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // Get date range
        String period = request.getParameter("period");
        Date startDate, endDate;

        if ("week".equals(period)) {
            endDate = Date.valueOf(LocalDate.now());
            startDate = Date.valueOf(LocalDate.now().minusDays(7));
        } else if ("month".equals(period)) {
            endDate = Date.valueOf(LocalDate.now());
            startDate = Date.valueOf(LocalDate.now().minusMonths(1));
        } else {
            // Default to current month
            LocalDate now = LocalDate.now();
            startDate = Date.valueOf(now.withDayOfMonth(1));
            endDate = Date.valueOf(now.withDayOfMonth(now.lengthOfMonth()));
        }

        Map<String, BigDecimal> salesStats = billService.getSalesStatistics(startDate, endDate);
        List<Map<String, Object>> bestSellers = billService.getBestSellingItems(10);
        List<Map<String, Object>> categorySales = billService.getSalesByCategory();

        request.setAttribute("salesStats", salesStats);
        request.setAttribute("bestSellers", bestSellers);
        request.setAttribute("categorySales", categorySales);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("pageTitle", "Sales Analytics");
        request.getRequestDispatcher("/jsp/bill-analytics.jsp").forward(request, response);
    }

    private void showReturnForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String billIdStr = request.getParameter("billId");

        if (billIdStr == null || billIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Bill ID is required");
            return;
        }

        try {
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billService.getBillById(billId);

            if (bill == null) {
                response.sendRedirect(request.getContextPath() + "/bill?error=Bill not found");
                return;
            }

            if (!"PAID".equals(bill.getPaymentStatus())) {
                response.sendRedirect(request.getContextPath() +
                        "/bill?action=view&billId=" + billId + "&error=Only paid bills can be returned");
                return;
            }

            request.setAttribute("bill", bill);
            request.setAttribute("pageTitle", "Return Items - " + bill.getBillNumber());
            request.getRequestDispatcher("/jsp/bill-return.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Invalid bill ID");
        }
    }

    private void cancelBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String billIdStr = request.getParameter("billId");

        try {
            int billId = Integer.parseInt(billIdStr);

            if (billService.cancelBill(billId)) {
                response.sendRedirect(request.getContextPath() +
                        "/bill?action=view&billId=" + billId + "&success=Bill cancelled successfully");
            } else {
                response.sendRedirect(request.getContextPath() +
                        "/bill?error=Failed to cancel bill");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bill?error=Invalid bill ID");
        }
    }


    private void processReturn(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // Implementation for processing returns
        // This would handle the return logic for bill items
        response.sendRedirect(request.getContextPath() + "/bill?success=Return processed successfully");
    }

    private void exportBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        List<Bill> bills;
        if (startDateStr != null && endDateStr != null) {
            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);
            bills = billService.getBillsByDateRange(startDate, endDate);
        } else {
            bills = billService.getAllBills();
        }

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"sales_report.csv\"");

        PrintWriter writer = response.getWriter();

        // Write CSV header
        writer.println("Bill Number,Date,Customer Name,Items,Subtotal,Discount,Tax,Total,Payment Method,Status");

        // Write bill data
        for (Bill bill : bills) {
            writer.println(String.format("%s,%s,%s,%d,%.2f,%.2f,%.2f,%.2f,%s,%s",
                    bill.getBillNumber(),
                    bill.getBillDate(),
                    bill.getCustomerName() != null ? bill.getCustomerName().replace(",", " ") : "",
                    bill.getTotalItems(),
                    bill.getSubtotal(),
                    bill.getDiscountAmount(),
                    bill.getTaxAmount(),
                    bill.getTotalAmount(),
                    bill.getPaymentMethod(),
                    bill.getPaymentStatus()
            ));
        }

        writer.flush();
    }

    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("adminUser") != null;
    }

    @Override
    public String getServletInfo() {
        return "Bill Management Servlet for Book Shop";
    }
}
