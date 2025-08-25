package com.pahanaedu.servlet;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import com.pahanaedu.service.BillService;
import com.pahanaedu.service.BillItemService;
import com.pahanaedu.service.CustomerService;
import com.pahanaedu.service.ItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/generateBill")
public class GenerateBillServlet extends HttpServlet {

    private BillService billService;
    private BillItemService billItemService;
    private CustomerService customerService;
    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        super.init();
        billService = new BillService();
        billItemService = new BillItemService();
        customerService = new CustomerService();
        itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("preview".equals(action)) {
                handlePreviewBill(request, response);
            } else if ("view".equals(action)) {
                handleViewBill(request, response);
            } else if ("loadItems".equals(action)) {
                handleLoadItems(request, response);
            } else {
                handleShowGenerateForm(request, response);
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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("generate".equals(action)) {
                handleGenerateBill(request, response);
            } else if ("confirm".equals(action)) {
                handleConfirmBill(request, response);
            } else if ("calculatePreview".equals(action)) {
                handleCalculatePreview(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/generateBill");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    /**
     * Show the generate bill form
     */
    private void handleShowGenerateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // Get all customers and items for the form
        List<Customer> customers = customerService.getAllCustomers();
        List<Item> availableItems = itemService.getAllItems().stream()
                .filter(Item::isInStock)
                .collect(java.util.stream.Collectors.toList());
        List<String> categories = itemService.getAllCategories();

        request.setAttribute("customers", customers);
        request.setAttribute("items", availableItems);
        request.setAttribute("categories", categories);
        request.setAttribute("discountPolicy", billService.getDiscountPolicy());

        // Check for success or error messages
        String success = request.getParameter("success");
        String error = request.getParameter("error");

        if ("true".equals(success)) {
            request.setAttribute("successMessage", "Bill generated successfully!");
        } else if (error != null) {
            request.setAttribute("errorMessage", getErrorMessage(error));
        }

        request.getRequestDispatcher("/jsp/generateBill.jsp").forward(request, response);
    }

    /**
     * Handle bill generation preview
     */
    private void handlePreviewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // Get customer
        String customerIdStr = request.getParameter("customerId");
        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/generateBill?error=invalid_customer");
            return;
        }

        int customerId = Integer.parseInt(customerIdStr);
        Customer customer = customerService.getCustomerById(customerId);
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/generateBill?error=customer_not_found");
            return;
        }

        // Parse bill items
        List<BillItem> billItems = parseBillItems(request);
        if (billItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/generateBill?error=no_items");
            return;
        }

        // Get loyalty points to redeem
        int loyaltyPointsToRedeem = 0;
        String loyaltyPointsStr = request.getParameter("loyaltyPointsToRedeem");
        if (loyaltyPointsStr != null && !loyaltyPointsStr.trim().isEmpty()) {
            loyaltyPointsToRedeem = Integer.parseInt(loyaltyPointsStr);
        }

        // Calculate bill totals
        BillService.BillCalculation calc = billService.calculateBillTotals(
                billItems, customer, loyaltyPointsToRedeem
        );

        // Set attributes for preview
        request.setAttribute("customer", customer);
        request.setAttribute("billItems", billItems);
        request.setAttribute("calculation", calc);
        request.setAttribute("loyaltyPointsToRedeem", loyaltyPointsToRedeem);
        request.setAttribute("paymentMethod", request.getParameter("paymentMethod"));

        request.getRequestDispatcher("/jsp/previewBill.jsp").forward(request, response);
    }

    /**
     * Handle actual bill generation
     */
    private void handleGenerateBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // Get customer
        String customerIdStr = request.getParameter("customerId");
        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/generateBill?error=invalid_customer");
            return;
        }

        int customerId = Integer.parseInt(customerIdStr);

        // Parse bill items
        List<BillItem> billItems = parseBillItems(request);
        if (billItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/generateBill?error=no_items");
            return;
        }

        // Get payment details
        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = "CASH";
        }

        int loyaltyPointsToRedeem = 0;
        String loyaltyPointsStr = request.getParameter("loyaltyPointsToRedeem");
        if (loyaltyPointsStr != null && !loyaltyPointsStr.trim().isEmpty()) {
            loyaltyPointsToRedeem = Integer.parseInt(loyaltyPointsStr);
        }

        try {
            // Create the bill
            Bill generatedBill = billService.createBill(
                    customerId, billItems, paymentMethod, loyaltyPointsToRedeem
            );

            if (generatedBill != null) {
                // Redirect to view the generated bill
                response.sendRedirect(request.getContextPath() +
                        "/generateBill?action=view&billId=" + generatedBill.getBillId() + "&success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/generateBill?error=generation_failed");
            }
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/generateBill?error=" +
                    (e.getMessage().contains("stock") ? "insufficient_stock" : "invalid_data"));
        }
    }

    /**
     * Handle bill confirmation (from preview)
     */
    private void handleConfirmBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // Forward to generate the actual bill
        handleGenerateBill(request, response);
    }

    /**
     * Handle viewing a generated bill
     */
    private void handleViewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String billIdStr = request.getParameter("billId");
        int billId = Integer.parseInt(billIdStr);

        Bill bill = billService.getBillById(billId);
        if (bill == null) {
            response.sendRedirect(request.getContextPath() + "/generateBill?error=bill_not_found");
            return;
        }

        request.setAttribute("bill", bill);

        // Check for success message
        String success = request.getParameter("success");
        if ("true".equals(success)) {
            request.setAttribute("successMessage", "Bill generated successfully!");
        }

        request.getRequestDispatcher("/jsp/viewBill.jsp").forward(request, response);
    }

    /**
     * Handle loading items for a category (AJAX)
     */
    private void handleLoadItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String category = request.getParameter("category");
        List<Item> items;

        if (category != null && !category.trim().isEmpty() && !"ALL".equals(category)) {
            items = itemService.getItemsByCategory(category);
        } else {
            items = itemService.getAllItems();
        }

        // Filter only in-stock items
        items = items.stream()
                .filter(Item::isInStock)
                .collect(java.util.stream.Collectors.toList());

        request.setAttribute("items", items);
        request.getRequestDispatcher("/jsp/item-select-partial.jsp").forward(request, response);
    }

    /**
     * Handle calculate preview (AJAX)
     */
    private void handleCalculatePreview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        response.setContentType("application/json");

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int loyaltyPointsToRedeem = Integer.parseInt(request.getParameter("loyaltyPointsToRedeem"));

            List<BillItem> billItems = parseBillItems(request);

            Map<String, Object> preview = billService.calculateBillPreview(
                    convertBillItemsToMap(billItems), customerId, loyaltyPointsToRedeem
            );

            response.getWriter().write(new com.google.gson.Gson().toJson(preview));

        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("error", true);
            error.put("message", e.getMessage());
            response.getWriter().write(new com.google.gson.Gson().toJson(error));
        }
    }

    /**
     * Parse bill items from request
     */
    private List<BillItem> parseBillItems(HttpServletRequest request) throws SQLException {
        List<BillItem> billItems = new ArrayList<>();

        String[] itemIds = request.getParameterValues("itemId[]");
        String[] quantities = request.getParameterValues("quantity[]");
        String[] discounts = request.getParameterValues("discount[]");

        if (itemIds != null && quantities != null) {
            for (int i = 0; i < itemIds.length; i++) {
                if (itemIds[i] != null && !itemIds[i].trim().isEmpty() &&
                        quantities[i] != null && !quantities[i].trim().isEmpty()) {

                    String itemId = itemIds[i].trim();
                    int quantity = Integer.parseInt(quantities[i].trim());

                    if (quantity > 0) {
                        BigDecimal additionalDiscount = BigDecimal.ZERO;
                        if (discounts != null && i < discounts.length &&
                                discounts[i] != null && !discounts[i].trim().isEmpty()) {
                            additionalDiscount = new BigDecimal(discounts[i].trim());
                        }

                        BillItem billItem = billItemService.prepareBillItem(
                                0, itemId, quantity, additionalDiscount
                        );
                        billItems.add(billItem);
                    }
                }
            }
        }

        return billItems;
    }

    /**
     * Convert bill items to map for preview calculation
     */
    private List<Map<String, Object>> convertBillItemsToMap(List<BillItem> billItems) {
        List<Map<String, Object>> itemMaps = new ArrayList<>();

        for (BillItem item : billItems) {
            Map<String, Object> itemMap = new HashMap<>();
            itemMap.put("itemId", item.getItemId());
            itemMap.put("quantity", item.getQuantity());
            itemMap.put("discount", item.getDiscountPercentage());
            itemMaps.add(itemMap);
        }

        return itemMaps;
    }

    /**
     * Get user-friendly error message
     */
    private String getErrorMessage(String errorCode) {
        switch (errorCode) {
            case "invalid_customer":
                return "Please select a valid customer.";
            case "customer_not_found":
                return "Customer not found in the system.";
            case "no_items":
                return "Please add at least one item to the bill.";
            case "invalid_data":
                return "Invalid input data. Please check and try again.";
            case "insufficient_stock":
                return "Insufficient stock for one or more items.";
            case "generation_failed":
                return "Failed to generate bill. Please try again.";
            case "bill_not_found":
                return "Bill not found in the system.";
            case "system":
                return "System error occurred. Please contact administrator.";
            default:
                return "An error occurred. Please try again.";
        }
    }
}
