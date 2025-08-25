package com.pahanaedu.service;

import com.pahanaedu.dao.BillItemDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Item;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BillItemService {

    private BillItemDAO billItemDAO;
    private ItemDAO itemDAO;

    public BillItemService() {
        this.billItemDAO = new BillItemDAO();
        this.itemDAO = new ItemDAO();
    }

    /**
     * Add a single bill item
     */
    public boolean addBillItem(BillItem billItem) throws SQLException {
        // Validate bill item
        if (!validateBillItem(billItem)) {
            throw new IllegalArgumentException("Invalid bill item data");
        }

        // Check stock availability
        if (!checkStockAvailability(billItem.getItemId(), billItem.getQuantity())) {
            throw new IllegalArgumentException("Insufficient stock for item: " + billItem.getItemId());
        }

        return billItemDAO.addBillItem(billItem);
    }

    /**
     * Add multiple bill items for a bill
     */
    public void addBillItems(List<BillItem> billItems) throws SQLException {
        // Validate all items first
        for (BillItem item : billItems) {
            if (!validateBillItem(item)) {
                throw new IllegalArgumentException("Invalid bill item data for item: " + item.getItemId());
            }

            if (!checkStockAvailability(item.getItemId(), item.getQuantity())) {
                Item itemDetails = itemDAO.getItemById(item.getItemId());
                throw new IllegalArgumentException("Insufficient stock for " + itemDetails.getItemName() +
                        ". Available: " + itemDetails.getStock() + ", Requested: " + item.getQuantity());
            }
        }

        // Add items in batch
        billItemDAO.addBillItemsBatch(billItems);
    }

    /**
     * Prepare bill item with calculations
     */
    public BillItem prepareBillItem(int billId, String itemId, int quantity,
                                    BigDecimal additionalDiscount) throws SQLException {
        // Get item details
        Item item = itemDAO.getItemById(itemId);
        if (item == null) {
            throw new IllegalArgumentException("Item not found: " + itemId);
        }

        // Check stock
        if (!item.isAvailable(quantity)) {
            throw new IllegalArgumentException("Insufficient stock. Available: " +
                    item.getStock() + ", Requested: " + quantity);
        }

        // Create bill item
        BillItem billItem = new BillItem();
        billItem.setBillId(billId);
        billItem.setItemId(itemId);
        billItem.setQuantity(quantity);
        billItem.setUnitPrice(item.getPrice());

        // Apply discount (item discount + additional discount)
        BigDecimal totalDiscount = item.getDiscountPercentage();
        if (additionalDiscount != null && additionalDiscount.compareTo(BigDecimal.ZERO) > 0) {
            totalDiscount = totalDiscount.add(additionalDiscount);
            // Ensure discount doesn't exceed 100%
            if (totalDiscount.compareTo(new BigDecimal(100)) > 0) {
                totalDiscount = new BigDecimal(100);
            }
        }
        billItem.setDiscountPercentage(totalDiscount);

        // Calculate total price
        billItem.calculateTotalPrice();

        // Set item details for display
        billItem.setItem(item);
        billItem.setItemName(item.getItemName());
        billItem.setItemCategory(item.getCategory());
        billItem.setAvailableStock(item.getStock());

        return billItem;
    }

    /**
     * Get bill items for a specific bill
     */
    public List<BillItem> getBillItems(int billId) throws SQLException {
        if (billId <= 0) {
            return new ArrayList<>();
        }

        return billItemDAO.getBillItemsByBillId(billId);
    }

    /**
     * Get a specific bill item
     */
    public BillItem getBillItemById(int billItemId) throws SQLException {
        if (billItemId <= 0) {
            return null;
        }

        return billItemDAO.getBillItemById(billItemId);
    }

    /**
     * Calculate bill items total
     */
    public BigDecimal calculateBillItemsTotal(List<BillItem> billItems) {
        if (billItems == null || billItems.isEmpty()) {
            return BigDecimal.ZERO;
        }

        return billItems.stream()
                .map(BillItem::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    /**
     * Calculate bill items subtotal (before discount)
     */
    public BigDecimal calculateBillItemsSubtotal(List<BillItem> billItems) {
        if (billItems == null || billItems.isEmpty()) {
            return BigDecimal.ZERO;
        }

        return billItems.stream()
                .map(item -> item.getUnitPrice().multiply(new BigDecimal(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    /**
     * Calculate total discount amount
     */
    public BigDecimal calculateTotalDiscount(List<BillItem> billItems) {
        if (billItems == null || billItems.isEmpty()) {
            return BigDecimal.ZERO;
        }

        BigDecimal subtotal = calculateBillItemsSubtotal(billItems);
        BigDecimal total = calculateBillItemsTotal(billItems);

        return subtotal.subtract(total);
    }

    /**
     * Calculate total quantity
     */
    public int calculateTotalQuantity(List<BillItem> billItems) {
        if (billItems == null || billItems.isEmpty()) {
            return 0;
        }

        return billItems.stream()
                .mapToInt(BillItem::getQuantity)
                .sum();
    }

    /**
     * Process item return
     */
    public boolean processItemReturn(int billItemId, int returnQuantity) throws SQLException {
        if (billItemId <= 0 || returnQuantity <= 0) {
            throw new IllegalArgumentException("Invalid return data");
        }

        BillItem billItem = getBillItemById(billItemId);
        if (billItem == null) {
            throw new IllegalArgumentException("Bill item not found");
        }

        if (returnQuantity > billItem.getQuantity()) {
            throw new IllegalArgumentException("Return quantity exceeds purchased quantity");
        }

        // Check if item is returnable (e.g., within return period)
        if (!billItem.isReturnable()) {
            throw new IllegalArgumentException("Item is not eligible for return");
        }

        return billItemDAO.processItemReturn(billItemId, returnQuantity);
    }

    /**
     * Process multiple returns
     */
    public Map<Integer, Boolean> processMultipleReturns(Map<Integer, Integer> returns) throws SQLException {
        Map<Integer, Boolean> results = new HashMap<>();

        for (Map.Entry<Integer, Integer> entry : returns.entrySet()) {
            try {
                boolean success = processItemReturn(entry.getKey(), entry.getValue());
                results.put(entry.getKey(), success);
            } catch (Exception e) {
                results.put(entry.getKey(), false);
            }
        }

        return results;
    }

    /**
     * Get best selling items
     */
    public List<Map<String, Object>> getBestSellingItems(int limit) throws SQLException {
        if (limit <= 0) {
            limit = 10; // Default
        }

        return billItemDAO.getBestSellingItems(limit);
    }

    /**
     * Get sales by category
     */
    public List<Map<String, Object>> getSalesByCategory() throws SQLException {
        return billItemDAO.getSalesByCategory();
    }

    /**
     * Get item sales history
     */
    public List<BillItem> getItemSalesHistory(String itemId, java.sql.Date startDate,
                                              java.sql.Date endDate) throws SQLException {
        if (itemId == null || itemId.trim().isEmpty()) {
            return new ArrayList<>();
        }

        return billItemDAO.getItemsSoldByDateRange(startDate, endDate).stream()
                .filter(item -> itemId.equals(item.getItemId()))
                .collect(java.util.stream.Collectors.toList());
    }

    /**
     * Get item sales statistics
     */
    public Map<String, Object> getItemSalesStatistics(String itemId) throws SQLException {
        Map<String, Object> stats = new HashMap<>();

        if (itemId == null || itemId.trim().isEmpty()) {
            return stats;
        }

        int totalQuantitySold = billItemDAO.getTotalQuantitySold(itemId);
        BigDecimal totalRevenue = billItemDAO.getTotalRevenueByItem(itemId);


        stats.put("totalQuantitySold", totalQuantitySold);
        stats.put("totalRevenue", totalRevenue);


        // Calculate average selling price
        if (totalQuantitySold > 0) {
            BigDecimal avgSellingPrice = totalRevenue.divide(
                    new BigDecimal(totalQuantitySold), 2, RoundingMode.HALF_UP
            );
            stats.put("averageSellingPrice", avgSellingPrice);
        } else {
            stats.put("averageSellingPrice", BigDecimal.ZERO);
        }

        return stats;
    }

    /**
     * Check if item can be deleted (not used in any bills)
     */
    public boolean canDeleteItem(String itemId) throws SQLException {
        if (itemId == null || itemId.trim().isEmpty()) {
            return false;
        }

        return !billItemDAO.isItemInUse(itemId);
    }

    /**
     * Validate bill item data
     */
    private boolean validateBillItem(BillItem billItem) {
        if (billItem == null) {
            return false;
        }

        if (billItem.getBillId() <= 0) {
            return false;
        }

        if (billItem.getItemId() == null || billItem.getItemId().trim().isEmpty()) {
            return false;
        }

        if (billItem.getQuantity() <= 0) {
            return false;
        }

        if (billItem.getUnitPrice() == null ||
                billItem.getUnitPrice().compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }

        if (billItem.getDiscountPercentage() != null) {
            if (billItem.getDiscountPercentage().compareTo(BigDecimal.ZERO) < 0 ||
                    billItem.getDiscountPercentage().compareTo(new BigDecimal(100)) > 0) {
                return false;
            }
        }

        return true;
    }

    /**
     * Check stock availability
     */
    private boolean checkStockAvailability(String itemId, int requestedQuantity) throws SQLException {
        Item item = itemDAO.getItemById(itemId);
        return item != null && item.getStock() >= requestedQuantity;
    }

    /**
     * Update stock after sale
     */
    public void updateStockAfterSale(Map<String, Integer> itemQuantities) throws SQLException {
        for (Map.Entry<String, Integer> entry : itemQuantities.entrySet()) {
            itemDAO.updateItemStock(entry.getKey(), -entry.getValue()); // Negative for reduction
        }
    }

    /**
     * Update stock after return
     */
    public void updateStockAfterReturn(String itemId, int returnQuantity) throws SQLException {
        itemDAO.updateItemStock(itemId, returnQuantity); // Positive for addition
    }

    /**
     * Get frequently bought together items
     */
    public List<String> getFrequentlyBoughtTogether(String itemId, int limit) throws SQLException {
        // This would analyze bill items to find items frequently purchased together
        // Implementation would depend on specific business requirements
        List<String> relatedItems = new ArrayList<>();

        // Placeholder implementation
        // In real implementation, this would query bills containing the item
        // and find other items in those bills

        return relatedItems;
    }

    /**
     * Calculate recommended discount for slow-moving items
     */
    public Map<String, BigDecimal> getRecommendedDiscounts(int daysThreshold) throws SQLException {
        Map<String, BigDecimal> recommendations = new HashMap<>();

        // This would analyze sales velocity and recommend discounts
        // for items not selling well

        return recommendations;
    }

    /**
     * Get bill item summary for reporting
     */
    public Map<String, Object> getBillItemSummary(int billId) throws SQLException {
        Map<String, Object> summary = new HashMap<>();

        List<BillItem> items = getBillItems(billId);

        summary.put("totalItems", items.size());
        summary.put("totalQuantity", calculateTotalQuantity(items));
        summary.put("subtotal", calculateBillItemsSubtotal(items));
        summary.put("totalDiscount", calculateTotalDiscount(items));
        summary.put("total", calculateBillItemsTotal(items));
        summary.put("items", items);

        return summary;
    }
}
