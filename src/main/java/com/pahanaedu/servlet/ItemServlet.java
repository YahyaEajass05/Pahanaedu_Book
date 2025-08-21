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
import java.math.BigDecimal;
import java.util.List;

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
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your request");
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
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your request");
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> items = itemService.getAllItems();
        List<Item> lowStockItems = itemService.getLowStockItems();

        request.setAttribute("items", items);
        request.setAttribute("lowStockItems", lowStockItems);
        request.setAttribute("totalItems", items.size());
        request.setAttribute("lowStockCount", lowStockItems.size());
        request.setAttribute("pageTitle", "Item Management");
        request.getRequestDispatcher("/jsp/item-list.jsp").forward(request, response);
    }

    private void viewItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("itemId");

        if (itemId == null || itemId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID is required");
            listItems(request, response);
            return;
        }

        Item item = itemService.getItemById(itemId);

        if (item == null) {
            request.setAttribute("errorMessage", "Item not found with ID: " + itemId);
            listItems(request, response);
            return;
        }

        request.setAttribute("item", item);
        request.setAttribute("pageTitle", "Item Details - " + item.getItemName());
        request.getRequestDispatcher("/jsp/item-view.jsp").forward(request, response);
    }

    private void showAddItemForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Add New Item");
        request.getRequestDispatcher("/jsp/item-add.jsp").forward(request, response);
    }

    private void showEditItemForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("itemId");

        if (itemId == null || itemId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID is required");
            listItems(request, response);
            return;
        }

        Item item = itemService.getItemById(itemId);

        if (item == null) {
            request.setAttribute("errorMessage", "Item not found with ID: " + itemId);
            listItems(request, response);
            return;
        }

        request.setAttribute("item", item);
        request.setAttribute("pageTitle", "Edit Item - " + item.getItemName());
        request.getRequestDispatcher("/jsp/item-edit.jsp").forward(request, response);
    }

    private void showDeleteItemForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("itemId");

        if (itemId == null || itemId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID is required");
            listItems(request, response);
            return;
        }

        Item item = itemService.getItemById(itemId);

        if (item == null) {
            request.setAttribute("errorMessage", "Item not found with ID: " + itemId);
            listItems(request, response);
            return;
        }

        request.setAttribute("item", item);
        request.setAttribute("pageTitle", "Delete Item - " + item.getItemName());
        request.getRequestDispatcher("/jsp/item-delete.jsp").forward(request, response);
    }

    private void showLowStockItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> lowStockItems = itemService.getLowStockItems();
        request.setAttribute("items", lowStockItems);
        request.setAttribute("pageTitle", "Low Stock Items");
        request.setAttribute("isLowStockView", true);
        request.getRequestDispatcher("/jsp/item-list.jsp").forward(request, response);
    }

    /**
     * Add new item
     */
    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String itemId = request.getParameter("itemId");
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description"); // ✅ new field
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");

        if (itemId == null || itemName == null || description == null ||
                priceStr == null || stockStr == null ||
                itemId.trim().isEmpty() || itemName.trim().isEmpty() ||
                description.trim().isEmpty() ||
                priceStr.trim().isEmpty() || stockStr.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required");
            preserveFormData(request, itemId, itemName, description, priceStr, stockStr);
            showAddItemForm(request, response);
            return;
        }

        try {
            BigDecimal price = new BigDecimal(priceStr.trim());
            int stock = Integer.parseInt(stockStr.trim());

            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                request.setAttribute("errorMessage", "Price must be greater than 0");
                preserveFormData(request, itemId, itemName, description, priceStr, stockStr);
                showAddItemForm(request, response);
                return;
            }

            if (stock < 0) {
                request.setAttribute("errorMessage", "Stock cannot be negative");
                preserveFormData(request, itemId, itemName, description, priceStr, stockStr);
                showAddItemForm(request, response);
                return;
            }

            Item item = new Item(itemId.trim(), itemName.trim(), description.trim(), price, stock);

            if (itemService.addItem(item)) {
                response.sendRedirect(request.getContextPath() + "/item?action=list&success=Item added successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to add item. Item ID may already exist.");
                preserveFormData(request, itemId, itemName, description, priceStr, stockStr);
                showAddItemForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid price or stock format. Please enter valid numbers.");
            preserveFormData(request, itemId, itemName, description, priceStr, stockStr);
            showAddItemForm(request, response);
        }
    }

    /**
     * Update existing item
     */
    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String itemId = request.getParameter("itemId");
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description"); // ✅ new field
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");

        if (itemId == null || itemName == null || description == null ||
                priceStr == null || stockStr == null ||
                itemId.trim().isEmpty() || itemName.trim().isEmpty() ||
                description.trim().isEmpty() ||
                priceStr.trim().isEmpty() || stockStr.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required");
            showEditItemForm(request, response);
            return;
        }

        try {
            BigDecimal price = new BigDecimal(priceStr.trim());
            int stock = Integer.parseInt(stockStr.trim());

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

            Item item = new Item(itemId.trim(), itemName.trim(), description.trim(), price, stock);

            if (itemService.updateItem(item)) {
                response.sendRedirect(request.getContextPath() + "/item?action=view&itemId=" +
                        itemId + "&success=Item updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update item");
                showEditItemForm(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid price or stock format. Please enter valid numbers.");
            showEditItemForm(request, response);
        }
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("itemId");

        if (itemId == null || itemId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Item ID is required");
            listItems(request, response);
            return;
        }

        if (itemService.deleteItem(itemId)) {
            response.sendRedirect(request.getContextPath() + "/item?action=list&success=Item deleted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete item");
            listItems(request, response);
        }
    }

    private boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("adminUser") != null;
    }

    private void preserveFormData(HttpServletRequest request, String itemId,
                                  String itemName, String description, String price, String stock) {
        request.setAttribute("itemId", itemId);
        request.setAttribute("itemName", itemName);
        request.setAttribute("description", description);
        request.setAttribute("price", price);
        request.setAttribute("stock", stock);
    }

    @Override
    public String getServletInfo() {
        return "Item Management Servlet for Pahana Edu";
    }
}
