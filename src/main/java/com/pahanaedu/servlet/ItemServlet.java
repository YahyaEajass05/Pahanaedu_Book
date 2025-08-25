package com.pahanaedu.servlet;

import com.pahanaedu.model.Item;
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
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "ItemServlet", urlPatterns = {"/item"})
public class ItemServlet extends HttpServlet {

    private ItemService itemService;

    @Override
    public void init() throws ServletException {
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
        String ajax = request.getParameter("ajax");

        // Handle AJAX requests
        if ("true".equals(ajax)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            try {
                if ("search".equals(action)) {
                    handleAjaxSearch(request, response);
                } else if ("discounted".equals(action)) {
                    handleAjaxDiscountedItems(request, response);
                } else if ("getCategoryCounts".equals(action)) {
                    handleAjaxCategoryCounts(request, response);
                } else {
                    response.getWriter().write("{\"error\": \"Invalid AJAX action\"}");
                }
                return;
            } catch (Exception e) {
                response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
                return;
            }
        }

        // Handle regular requests
        try {
            if (action == null || "list".equals(action)) {
                listItems(request, response);
            } else if ("view".equals(action)) {
                viewItem(request, response);
            } else if ("add".equals(action)) {
                showAddItemForm(request, response);
            } else if ("edit".equals(action)) {
                showEditItemForm(request, response);
            } else if ("delete".equals(action)) {
                showDeleteItemForm(request, response);
            } else if ("lowStock".equals(action)) {
                showLowStockItems(request, response);
            } else if ("outOfStock".equals(action)) {
                showOutOfStockItems(request, response);
            } else if ("discounted".equals(action)) {
                showDiscountedItems(request, response);
            } else if ("byCategory".equals(action)) {
                showItemsByCategory(request, response);
            } else if ("search".equals(action)) {
                searchItems(request, response);
            } else if ("manageDiscount".equals(action)) {
                showManageDiscountForm(request, response);
            } else if ("inventory".equals(action)) {
                showInventoryReport(request, response);
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
            if ("add".equals(action)) {
                addItem(request, response);
            } else if ("update".equals(action)) {
                updateItem(request, response);
            } else if ("confirmDelete".equals(action)) {
                deleteItem(request, response);
            } else if ("updateDiscount".equals(action)) {
                updateItemDiscount(request, response);
            } else if ("applyBulkDiscount".equals(action)) {
                applyBulkDiscount(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    // AJAX Handlers
    private void handleAjaxSearch(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        String query = request.getParameter("q");
        List<Item> items = itemService.searchItems(query);

        PrintWriter out = response.getWriter();
        StringBuilder json = new StringBuilder("{\"items\":[");

        for (int i = 0; i < items.size(); i++) {
            Item item = items.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                    .append("\"itemId\":\"").append(escapeJson(item.getItemId())).append("\",")
                    .append("\"itemName\":\"").append(escapeJson(item.getItemName())).append("\",")
                    .append("\"price\":").append(item.getPrice()).append(",")
                    .append("\"category\":\"").append(escapeJson(item.getCategory() != null ? item.getCategory() : "")).append("\",")
                    .append("\"stock\":").append(item.getStock()).append(",")
                    .append("\"discountPercentage\":").append(item.getDiscountPercentage())
                    .append("}");
        }
        json.append("]}");

        out.print(json.toString());
        out.flush();
    }

    private void handleAjaxDiscountedItems(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        List<Item> items = itemService.getDiscountedItems();

        PrintWriter out = response.getWriter();
        StringBuilder json = new StringBuilder("{\"items\":[");

        for (int i = 0; i < items.size(); i++) {
            Item item = items.get(i);
            if (i > 0) json.append(",");
            json.append("{")
                    .append("\"itemId\":\"").append(escapeJson(item.getItemId())).append("\",")
                    .append("\"itemName\":\"").append(escapeJson(item.getItemName())).append("\",")
                    .append("\"price\":").append(item.getPrice()).append(",")
                    .append("\"category\":\"").append(escapeJson(item.getCategory() != null ? item.getCategory() : "")).append("\",")
                    .append("\"discountPercentage\":").append(item.getDiscountPercentage())
                    .append("}");
        }
        json.append("]}");

        out.print(json.toString());
        out.flush();
    }

    private void handleAjaxCategoryCounts(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        Map<String, Integer> categoryCounts = itemService.getItemCountByCategory();

        PrintWriter out = response.getWriter();
        StringBuilder json = new StringBuilder("{\"categoryCounts\":{");

        boolean first = true;
        for (Map.Entry<String, Integer> entry : categoryCounts.entrySet()) {
            if (!first) json.append(",");
            json.append("\"").append(escapeJson(entry.getKey())).append("\":").append(entry.getValue());
            first = false;
        }
        json.append("}}");

        out.print(json.toString());
        out.flush();
    }

    // Utility method to escape JSON strings
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<Item> items = itemService.getAllItems();
        List<Item> lowStockItems = itemService.getLowStockItems();
        List<Item> outOfStockItems = itemService.getOutOfStockItems();
        List<String> categories = itemService.getAllCategories();
        Map<String, Object> stats = itemService.getItemStatistics();

        request.setAttribute("items", items);
        request.setAttribute("lowStockItems", lowStockItems);
        request.setAttribute("outOfStockItems", outOfStockItems);
        request.setAttribute("categories", categories);
        request.setAttribute("stats", stats);
        request.setAttribute("pageTitle", "Book Inventory Management");

        // Handle success message
        String success = request.getParameter("success");
        if (success != null) {
            request.setAttribute("successMessage", success);
        }

        request.getRequestDispatcher("/jsp/item-list.jsp").forward(request, response);
    }

    private void viewItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String itemId = request.getParameter("itemId");

        if (itemId == null || itemId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID is required");
            listItems(request, response);
            return;
        }

        Item item = itemService.getItemById(itemId);

        if (item == null) {
            request.setAttribute("errorMessage", "Book not found with ID: " + itemId);
            listItems(request, response);
            return;
        }

        request.setAttribute("item", item);
        request.setAttribute("pageTitle", "Book Details - " + item.getItemName());

        // Handle success message
        String success = request.getParameter("success");
        if (success != null) {
            request.setAttribute("successMessage", success);
        }

        request.getRequestDispatcher("/jsp/item-view.jsp").forward(request, response);
    }

    private void showAddItemForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<String> categories = itemService.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("pageTitle", "Add New Book");
        request.getRequestDispatcher("/jsp/item-add.jsp").forward(request, response);
    }

    private void showEditItemForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String itemId = request.getParameter("itemId");

        if (itemId == null || itemId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID is required");
            listItems(request, response);
            return;
        }

        Item item = itemService.getItemById(itemId);

        if (item == null) {
            request.setAttribute("errorMessage", "Book not found with ID: " + itemId);
            listItems(request, response);
            return;
        }

        List<String> categories = itemService.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("item", item);
        request.setAttribute("pageTitle", "Edit Book - " + item.getItemName());
        request.getRequestDispatcher("/jsp/item-edit.jsp").forward(request, response);
    }

    private void showDeleteItemForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String itemId = request.getParameter("itemId");

        if (itemId == null || itemId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID is required");
            listItems(request, response);
            return;
        }

        Item item = itemService.getItemById(itemId);

        if (item == null) {
            request.setAttribute("errorMessage", "Book not found with ID: " + itemId);
            listItems(request, response);
            return;
        }

        request.setAttribute("item", item);
        request.setAttribute("pageTitle", "Delete Book - " + item.getItemName());
        request.getRequestDispatcher("/jsp/item-delete.jsp").forward(request, response);
    }

    private void showLowStockItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int threshold = 10; // Default threshold
        String thresholdParam = request.getParameter("threshold");
        if (thresholdParam != null) {
            try {
                threshold = Integer.parseInt(thresholdParam);
            } catch (NumberFormatException e) {
                // Use default
            }
        }

        List<Item> lowStockItems = itemService.getLowStockItems(threshold);
        request.setAttribute("items", lowStockItems);
        request.setAttribute("threshold", threshold);
        request.setAttribute("pageTitle", "Low Stock Books");
        request.setAttribute("isLowStockView", true);
        request.getRequestDispatcher("/jsp/item-list.jsp").forward(request, response);
    }

    private void showOutOfStockItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<Item> outOfStockItems = itemService.getOutOfStockItems();
        request.setAttribute("items", outOfStockItems);
        request.setAttribute("pageTitle", "Out of Stock Books");
        request.setAttribute("isOutOfStockView", true);
        request.getRequestDispatcher("/jsp/item-list.jsp").forward(request, response);
    }

    private void showDiscountedItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<Item> discountedItems = itemService.getDiscountedItems();
        request.setAttribute("items", discountedItems);
        request.setAttribute("pageTitle", "Books on Discount");
        request.setAttribute("isDiscountedView", true);
        request.getRequestDispatcher("/jsp/item-list.jsp").forward(request, response);
    }

    private void showItemsByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String category = request.getParameter("category");
        if (category == null || category.trim().isEmpty()) {
            listItems(request, response);
            return;
        }

        List<Item> items = itemService.getItemsByCategory(category);
        List<String> categories = itemService.getAllCategories();

        request.setAttribute("items", items);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("pageTitle", "Books - " + category);
        request.getRequestDispatcher("/jsp/item-list.jsp").forward(request, response);
    }

    private void searchItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String searchTerm = request.getParameter("q");
        List<Item> items;

        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            items = itemService.getAllItems();
        } else {
            items = itemService.searchItems(searchTerm);
            request.setAttribute("searchTerm", searchTerm);
        }

        request.setAttribute("items", items);
        request.setAttribute("pageTitle", "Search Results");
        request.getRequestDispatcher("/jsp/item-list.jsp").forward(request, response);
    }

    private void showManageDiscountForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String itemId = request.getParameter("itemId");

        // Load all items for the discount page
        List<Item> allItems = itemService.getAllItems();
        request.setAttribute("allItems", allItems);

        if (itemId != null && !itemId.trim().isEmpty()) {
            Item item = itemService.getItemById(itemId);
            if (item != null) {
                request.setAttribute("item", item);
            }
        }

        // Load discounted items
        List<Item> discountedItems = itemService.getDiscountedItems();
        request.setAttribute("discountedItems", discountedItems);

        // Load categories with counts
        List<String> categories = itemService.getAllCategories();
        Map<String, Integer> categoryCounts = itemService.getItemCountByCategory();

        request.setAttribute("categories", categories);
        request.setAttribute("categoryCounts", categoryCounts);
        request.setAttribute("pageTitle", "Manage Discounts");

        request.getRequestDispatcher("/jsp/item-discount.jsp").forward(request, response);
    }

    private void showInventoryReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Map<String, Object> inventorySummary = itemService.getInventorySummary();
        List<Map<String, Object>> categoryValues = itemService.getInventoryValueByCategory();

        request.setAttribute("summary", inventorySummary);
        request.setAttribute("categoryValues", categoryValues);
        request.setAttribute("pageTitle", "Inventory Report");
        request.getRequestDispatcher("/jsp/inventory-report.jsp").forward(request, response);
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String itemId = request.getParameter("itemId");
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String discountStr = request.getParameter("discountPercentage");

        // Validation
        if (itemId == null || itemName == null || priceStr == null || stockStr == null ||
                itemId.trim().isEmpty() || itemName.trim().isEmpty() ||
                priceStr.trim().isEmpty() || stockStr.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Required fields are missing");
            preserveFormData(request, itemId, itemName, category, priceStr, stockStr, discountStr);
            showAddItemForm(request, response);
            return;
        }

        try {
            BigDecimal price = new BigDecimal(priceStr.trim());
            int stock = Integer.parseInt(stockStr.trim());
            BigDecimal discount = discountStr != null && !discountStr.trim().isEmpty()
                    ? new BigDecimal(discountStr.trim()) : BigDecimal.ZERO;

            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                request.setAttribute("errorMessage", "Price must be greater than 0");
                preserveFormData(request, itemId, itemName, category, priceStr, stockStr, discountStr);
                showAddItemForm(request, response);
                return;
            }

            if (stock < 0) {
                request.setAttribute("errorMessage", "Stock cannot be negative");
                preserveFormData(request, itemId, itemName, category, priceStr, stockStr, discountStr);
                showAddItemForm(request, response);
                return;
            }

            if (discount.compareTo(BigDecimal.ZERO) < 0 || discount.compareTo(new BigDecimal(100)) > 0) {
                request.setAttribute("errorMessage", "Discount must be between 0 and 100");
                preserveFormData(request, itemId, itemName, category, priceStr, stockStr, discountStr);
                showAddItemForm(request, response);
                return;
            }

            Item item = new Item(itemId.trim(), itemName.trim(), price, stock,
                    category != null ? category.trim() : null, discount);

            if (itemService.addItem(item)) {
                response.sendRedirect(request.getContextPath() +
                        "/item?action=list&success=Book added successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to add book. Book ID may already exist.");
                preserveFormData(request, itemId, itemName, category, priceStr, stockStr, discountStr);
                showAddItemForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format. Please check price and stock.");
            preserveFormData(request, itemId, itemName, category, priceStr, stockStr, discountStr);
            showAddItemForm(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            preserveFormData(request, itemId, itemName, category, priceStr, stockStr, discountStr);
            showAddItemForm(request, response);
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String itemId = request.getParameter("itemId");
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String discountStr = request.getParameter("discountPercentage");

        if (itemId == null || itemName == null || priceStr == null || stockStr == null ||
                itemId.trim().isEmpty() || itemName.trim().isEmpty() ||
                priceStr.trim().isEmpty() || stockStr.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Required fields are missing");
            showEditItemForm(request, response);
            return;
        }

        try {
            BigDecimal price = new BigDecimal(priceStr.trim());
            int stock = Integer.parseInt(stockStr.trim());
            BigDecimal discount = discountStr != null && !discountStr.trim().isEmpty()
                    ? new BigDecimal(discountStr.trim()) : BigDecimal.ZERO;

            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                request.setAttribute("errorMessage", "Price must be greater than 0");
                showEditItemForm(request, response);
                return;
            }

            if (stock < 0) {
                request.setAttribute("errorMessage", "Stock cannot be negative");
                showEditItemForm(request, response);
                return;
            }

            if (discount.compareTo(BigDecimal.ZERO) < 0 || discount.compareTo(new BigDecimal(100)) > 0) {
                request.setAttribute("errorMessage", "Discount must be between 0 and 100");
                showEditItemForm(request, response);
                return;
            }

            Item item = new Item(itemId.trim(), itemName.trim(), price, stock,
                    category != null ? category.trim() : null, discount);

            if (itemService.updateItem(item)) {
                response.sendRedirect(request.getContextPath() +
                        "/item?action=view&itemId=" + itemId + "&success=Book updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update book");
                showEditItemForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format. Please check price and stock.");
            showEditItemForm(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            showEditItemForm(request, response);
        }
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String itemId = request.getParameter("itemId");

        if (itemId == null || itemId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID is required");
            listItems(request, response);
            return;
        }

        try {
            if (itemService.deleteItem(itemId)) {
                response.sendRedirect(request.getContextPath() +
                        "/item?action=list&success=Book deleted successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to delete book");
                listItems(request, response);
            }
        } catch (SQLException e) {
            if (e.getMessage().contains("referenced in existing bills")) {
                request.setAttribute("errorMessage",
                        "Cannot delete this book. It has been used in bills.");
            } else {
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            }
            listItems(request, response);
        }
    }

    private void updateItemDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String itemId = request.getParameter("itemId");
        String discountStr = request.getParameter("discountPercentage");

        if (itemId == null || discountStr == null ||
                itemId.trim().isEmpty() || discountStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID and discount are required");
            showManageDiscountForm(request, response);
            return;
        }

        try {
            BigDecimal discount = new BigDecimal(discountStr.trim());

            // Validate discount range
            if (discount.compareTo(BigDecimal.ZERO) < 0 || discount.compareTo(new BigDecimal(100)) > 0) {
                request.setAttribute("errorMessage", "Discount must be between 0 and 100");
                showManageDiscountForm(request, response);
                return;
            }

            if (itemService.updateItemDiscount(itemId, discount)) {
                response.sendRedirect(request.getContextPath() +
                        "/item?action=manageDiscount&success=Discount updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update discount");
                showManageDiscountForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid discount format");
            showManageDiscountForm(request, response);
        }
    }

    private void applyBulkDiscount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String category = request.getParameter("category");
        String discountStr = request.getParameter("discountPercentage");

        if (category == null || discountStr == null ||
                category.trim().isEmpty() || discountStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Category and discount are required");
            showManageDiscountForm(request, response);
            return;
        }

        try {
            BigDecimal discount = new BigDecimal(discountStr.trim());

            // Validate discount range (bulk discounts are limited to 50%)
            if (discount.compareTo(BigDecimal.ZERO) < 0 || discount.compareTo(new BigDecimal(50)) > 0) {
                request.setAttribute("errorMessage", "Bulk discount must be between 0 and 50%");
                showManageDiscountForm(request, response);
                return;
            }

            itemService.applyCategoryDiscount(category, discount);

            response.sendRedirect(request.getContextPath() +
                    "/item?action=manageDiscount&success=Discount applied to all books in " + category);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid discount format");
            showManageDiscountForm(request, response);
        }
    }

    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("adminUser") != null;
    }

    private void preserveFormData(HttpServletRequest request, String itemId,
                                  String itemName, String category, String price,
                                  String stock, String discount) {
        request.setAttribute("itemId", itemId);
        request.setAttribute("itemName", itemName);
        request.setAttribute("category", category);
        request.setAttribute("price", price);
        request.setAttribute("stock", stock);
        request.setAttribute("discountPercentage", discount);
    }

    @Override
    public String getServletInfo() {
        return "Book Inventory Management Servlet for Book Shop";
    }
}
