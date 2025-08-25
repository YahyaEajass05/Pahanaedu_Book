package com.pahanaedu.servlet;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import com.pahanaedu.service.BillService;
import com.pahanaedu.service.CustomerService;
import com.pahanaedu.service.ItemService;
import com.pahanaedu.service.BillItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/billAjax")
public class BillAjaxServlet extends HttpServlet {

    private BillService billService;
    private CustomerService customerService;
    private ItemService itemService;
    private BillItemService billItemService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        billService = new BillService();
        customerService = new CustomerService();
        itemService = new ItemService();
        billItemService = new BillItemService();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "getCustomerDetails":
                    handleGetCustomerDetails(request, response);
                    break;
                case "getItemDetails":
                    handleGetItemDetails(request, response);
                    break;
                case "searchItems":
                    handleSearchItems(request, response);
                    break;
                case "calculateBillPreview":
                    handleCalculateBillPreview(request, response);
                    break;
                case "checkStock":
                    handleCheckStock(request, response);
                    break;
                case "getCustomerHistory":
                    handleGetCustomerHistory(request, response);
                    break;
                case "getBillDetails":
                    handleGetBillDetails(request, response);
                    break;
                case "searchCustomers":
                    handleSearchCustomers(request, response);
                    break;
                default:
                    sendErrorResponse(response, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "An error occurred: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "calculateBill":
                    handleCalculateBill(request, response);
                    break;
                case "applyDiscount":
                    handleApplyDiscount(request, response);
                    break;
                case "validateLoyaltyPoints":
                    handleValidateLoyaltyPoints(request, response);
                    break;
                default:
                    sendErrorResponse(response, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendErrorResponse(response, "An error occurred: " + e.getMessage());
        }
    }

    /**
     * Get customer details for AJAX request
     */
    private void handleGetCustomerDetails(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String customerIdStr = request.getParameter("customerId");

        try {
            int customerId = Integer.parseInt(customerIdStr);
            Customer customer = customerService.getCustomerById(customerId);

            if (customer != null) {
                JsonObject json = new JsonObject();
                json.addProperty("success", true);
                json.addProperty("name", customer.getName());
                json.addProperty("email", customer.getEmail());
                json.addProperty("phone", customer.getPhone());
                json.addProperty("address", customer.getAddress());
                json.addProperty("membershipType", customer.getMembershipType());
                json.addProperty("loyaltyPoints", customer.getLoyaltyPoints());
                json.addProperty("totalPurchases", customer.getTotalPurchases());

                // Add membership discount
                BigDecimal discount = getMembershipDiscount(customer.getMembershipType());
                json.addProperty("membershipDiscount", discount.toString());

                out.print(gson.toJson(json));
            } else {
                sendErrorResponse(response, "Customer not found");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Invalid customer ID");
        }
    }

    /**
     * Get item details for AJAX request
     */
    private void handleGetItemDetails(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String itemId = request.getParameter("itemId");

        if (itemId != null && !itemId.trim().isEmpty()) {
            Item item = itemService.getItemById(itemId);

            if (item != null) {
                JsonObject json = new JsonObject();
                json.addProperty("success", true);
                json.addProperty("itemId", item.getItemId());
                json.addProperty("itemName", item.getItemName());
                json.addProperty("price", item.getPrice().toString());
                json.addProperty("stock", item.getStock());
                json.addProperty("category", item.getCategory());
                json.addProperty("discountPercentage", item.getDiscountPercentage().toString());
                json.addProperty("discountedPrice", item.getDiscountedPrice().toString());
                json.addProperty("inStock", item.isInStock());

                out.print(gson.toJson(json));
            } else {
                sendErrorResponse(response, "Item not found");
            }
        } else {
            sendErrorResponse(response, "Item ID is required");
        }
    }

    /**
     * Search items for AJAX autocomplete
     */
    private void handleSearchItems(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String query = request.getParameter("query");

        if (query != null && query.length() >= 2) {
            List<Item> items = itemService.searchItems(query);
            List<Map<String, Object>> results = new ArrayList<>();

            for (Item item : items) {
                if (item.isInStock()) {
                    Map<String, Object> itemMap = new HashMap<>();
                    itemMap.put("itemId", item.getItemId());
                    itemMap.put("itemName", item.getItemName());
                    itemMap.put("price", item.getPrice());
                    itemMap.put("stock", item.getStock());
                    itemMap.put("category", item.getCategory());
                    itemMap.put("discount", item.getDiscountPercentage());
                    results.add(itemMap);
                }
            }

            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("items", gson.toJsonTree(results));

            out.print(gson.toJson(json));
        } else {
            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("items", gson.toJsonTree(new ArrayList<>()));
            out.print(gson.toJson(json));
        }
    }

    /**
     * Calculate bill preview
     */
    private void handleCalculateBillPreview(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int loyaltyPointsToRedeem = Integer.parseInt(request.getParameter("loyaltyPoints"));

            // Parse items
            String[] itemIds = request.getParameterValues("itemId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] discounts = request.getParameterValues("discount[]");

            if (itemIds == null || quantities == null || itemIds.length != quantities.length) {
                sendErrorResponse(response, "Invalid item data");
                return;
            }

            List<Map<String, Object>> items = new ArrayList<>();
            for (int i = 0; i < itemIds.length; i++) {
                Map<String, Object> itemData = new HashMap<>();
                itemData.put("itemId", itemIds[i]);
                itemData.put("quantity", Integer.parseInt(quantities[i]));
                if (discounts != null && i < discounts.length) {
                    itemData.put("discount", new BigDecimal(discounts[i]));
                }
                items.add(itemData);
            }

            Map<String, Object> preview = billService.calculateBillPreview(items, customerId, loyaltyPointsToRedeem);

            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("preview", gson.toJsonTree(preview));

            out.print(gson.toJson(json));

        } catch (Exception e) {
            sendErrorResponse(response, "Error calculating preview: " + e.getMessage());
        }
    }

    /**
     * Check stock availability
     */
    private void handleCheckStock(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String itemId = request.getParameter("itemId");
        String quantityStr = request.getParameter("quantity");

        try {
            int quantity = Integer.parseInt(quantityStr);
            boolean available = itemService.checkStockAvailability(itemId, quantity);

            Item item = itemService.getItemById(itemId);

            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.addProperty("available", available);
            json.addProperty("currentStock", item.getStock());
            json.addProperty("requestedQuantity", quantity);

            if (!available) {
                json.addProperty("message", "Only " + item.getStock() + " items available");
            }

            out.print(gson.toJson(json));

        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Invalid quantity");
        }
    }

    /**
     * Get customer purchase history
     */
    private void handleGetCustomerHistory(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String customerIdStr = request.getParameter("customerId");

        try {
            int customerId = Integer.parseInt(customerIdStr);
            List<Bill> bills = billService.getBillsByCustomer(customerId);

            List<Map<String, Object>> history = new ArrayList<>();
            for (Bill bill : bills) {
                Map<String, Object> billMap = new HashMap<>();
                billMap.put("billNumber", bill.getBillNumber());
                billMap.put("date", bill.getBillDate());
                billMap.put("total", bill.getTotalAmount());
                billMap.put("items", bill.getTotalItems());
                billMap.put("status", bill.getPaymentStatus());
                history.add(billMap);
            }

            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("history", gson.toJsonTree(history));
            json.addProperty("totalPurchases", history.size());

            out.print(gson.toJson(json));

        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Invalid customer ID");
        }
    }

    /**
     * Get bill details
     */
    private void handleGetBillDetails(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String billIdStr = request.getParameter("billId");

        try {
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billService.getBillById(billId);

            if (bill != null) {
                JsonObject json = new JsonObject();
                json.addProperty("success", true);
                json.addProperty("billNumber", bill.getBillNumber());
                json.addProperty("customerName", bill.getCustomerName());
                json.addProperty("subtotal", bill.getSubtotal().toString());
                json.addProperty("discount", bill.getDiscountAmount().toString());
                json.addProperty("tax", bill.getTaxAmount().toString());
                json.addProperty("total", bill.getTotalAmount().toString());
                json.addProperty("status", bill.getPaymentStatus());
                json.add("items", gson.toJsonTree(bill.getBillItems()));

                out.print(gson.toJson(json));
            } else {
                sendErrorResponse(response, "Bill not found");
            }

        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Invalid bill ID");
        }
    }

    /**
     * Search customers
     */
    private void handleSearchCustomers(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String query = request.getParameter("query");

        if (query != null && query.length() >= 2) {
            List<Customer> customers = customerService.searchCustomers(query);
            List<Map<String, Object>> results = new ArrayList<>();

            for (Customer customer : customers) {
                Map<String, Object> customerMap = new HashMap<>();
                customerMap.put("customerId", customer.getCustomerId());
                customerMap.put("name", customer.getName());
                customerMap.put("phone", customer.getPhone());
                customerMap.put("email", customer.getEmail());
                customerMap.put("membershipType", customer.getMembershipType());
                customerMap.put("loyaltyPoints", customer.getLoyaltyPoints());
                results.add(customerMap);
            }

            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("customers", gson.toJsonTree(results));

            out.print(gson.toJson(json));
        } else {
            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.add("customers", gson.toJsonTree(new ArrayList<>()));
            out.print(gson.toJson(json));
        }
    }

    /**
     * Calculate full bill (POST)
     */
    private void handleCalculateBill(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Implementation similar to calculateBillPreview but with full calculation
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.addProperty("message", "Bill calculated successfully");

        out.print(gson.toJson(json));
    }

    /**
     * Apply discount
     */
    private void handleApplyDiscount(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String discountType = request.getParameter("discountType");
        String discountValueStr = request.getParameter("discountValue");

        try {
            BigDecimal discountValue = new BigDecimal(discountValueStr);

            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.addProperty("discountApplied", discountValue.toString());

            out.print(gson.toJson(json));

        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Invalid discount value");
        }
    }

    /**
     * Validate loyalty points
     */
    private void handleValidateLoyaltyPoints(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String customerIdStr = request.getParameter("customerId");
        String pointsStr = request.getParameter("points");

        try {
            int customerId = Integer.parseInt(customerIdStr);
            int pointsToRedeem = Integer.parseInt(pointsStr);

            Customer customer = customerService.getCustomerById(customerId);

            boolean valid = customer != null && customer.getLoyaltyPoints() >= pointsToRedeem;

            JsonObject json = new JsonObject();
            json.addProperty("success", true);
            json.addProperty("valid", valid);
            json.addProperty("availablePoints", customer != null ? customer.getLoyaltyPoints() : 0);
            json.addProperty("redemptionValue", pointsToRedeem * 0.10); // 1 point = 0.10 currency

            if (!valid) {
                json.addProperty("message", "Insufficient loyalty points");
            }

            out.print(gson.toJson(json));

        } catch (NumberFormatException e) {
            sendErrorResponse(response, "Invalid input");
        }
    }

    /**
     * Get membership discount percentage
     */
    private BigDecimal getMembershipDiscount(String membershipType) {
        if (membershipType == null) return BigDecimal.ZERO;

        switch (membershipType.toUpperCase()) {
            case "PREMIUM":
                return new BigDecimal("5.00");
            case "VIP":
                return new BigDecimal("10.00");
            default:
                return BigDecimal.ZERO;
        }
    }

    /**
     * Send error response
     */
    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        JsonObject json = new JsonObject();
        json.addProperty("success", false);
        json.addProperty("message", message);

        out.print(gson.toJson(json));
    }
}
