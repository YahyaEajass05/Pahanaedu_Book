package com.pahanaedu.service;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillItemDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BillService {

    private BillDAO billDAO;
    private BillItemDAO billItemDAO;
    private CustomerDAO customerDAO;
    private ItemDAO itemDAO;

    // Business constants
    private static final BigDecimal TAX_RATE = new BigDecimal("0.08"); // 8% tax
    private static final BigDecimal LOYALTY_POINT_VALUE = new BigDecimal("0.10"); // 1 point = 0.10 currency
    private static final int LOYALTY_POINTS_PER_AMOUNT = 10; // 1 point per 10 currency units

    // Membership discounts
    private static final BigDecimal REGULAR_DISCOUNT = BigDecimal.ZERO;
    private static final BigDecimal PREMIUM_DISCOUNT = new BigDecimal("5.00"); // 5%
    private static final BigDecimal VIP_DISCOUNT = new BigDecimal("10.00"); // 10%

    public BillService() {
        this.billDAO = new BillDAO();
        this.billItemDAO = new BillItemDAO();
        this.customerDAO = new CustomerDAO();
        this.itemDAO = new ItemDAO();
    }

    /**
     * Bill calculation result class
     */
    public static class BillCalculation {
        public BigDecimal subtotal = BigDecimal.ZERO;
        public BigDecimal itemDiscountAmount = BigDecimal.ZERO;
        public BigDecimal membershipDiscountAmount = BigDecimal.ZERO;
        public BigDecimal loyaltyDiscountAmount = BigDecimal.ZERO;
        public BigDecimal totalDiscountAmount = BigDecimal.ZERO;
        public BigDecimal taxableAmount = BigDecimal.ZERO;
        public BigDecimal taxAmount = BigDecimal.ZERO;
        public BigDecimal totalAmount = BigDecimal.ZERO;
        public int loyaltyPointsEarned = 0;
        public BigDecimal totalSavings = BigDecimal.ZERO;
    }

    /**
     * Create a new bill with items
     */
    public Bill createBill(int customerId, List<BillItem> billItems, String paymentMethod,
                           int loyaltyPointsToRedeem) throws SQLException {

        // Validate inputs
        if (customerId <= 0 || billItems == null || billItems.isEmpty()) {
            throw new IllegalArgumentException("Invalid bill data");
        }

        // Get customer details
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer == null) {
            throw new IllegalArgumentException("Customer not found");
        }

        // Validate loyalty points
        if (loyaltyPointsToRedeem > customer.getLoyaltyPoints()) {
            throw new IllegalArgumentException("Insufficient loyalty points");
        }

        // Validate and prepare bill items
        List<BillItem> validatedItems = validateAndPrepareBillItems(billItems);

        // Calculate bill totals
        BillCalculation calc = calculateBillTotals(validatedItems, customer, loyaltyPointsToRedeem);

        // Create bill object
        Bill bill = new Bill();
        bill.setCustomerId(customerId);
        bill.setSubtotal(calc.subtotal);
        bill.setDiscountAmount(calc.totalDiscountAmount);
        bill.setTaxAmount(calc.taxAmount);
        bill.setTotalAmount(calc.totalAmount);
        bill.setPaymentMethod(paymentMethod != null ? paymentMethod : "CASH");
        bill.setPaymentStatus("PAID");
        bill.setLoyaltyPointsEarned(calc.loyaltyPointsEarned);
        bill.setLoyaltyPointsRedeemed(loyaltyPointsToRedeem);
        bill.setBillDate(new java.util.Date());
        bill.setCustomer(customer);

        // Save bill with items
        int billId = billDAO.createBillWithItems(bill, validatedItems);
        bill.setBillId(billId);

        return bill;
    }

    /**
     * Validate and prepare bill items
     */
    private List<BillItem> validateAndPrepareBillItems(List<BillItem> billItems) throws SQLException {
        List<BillItem> preparedItems = new ArrayList<>();

        for (BillItem billItem : billItems) {
            // Get item details
            Item item = itemDAO.getItemById(billItem.getItemId());
            if (item == null) {
                throw new IllegalArgumentException("Item not found: " + billItem.getItemId());
            }

            // Check stock availability
            if (!item.isAvailable(billItem.getQuantity())) {
                throw new IllegalArgumentException("Insufficient stock for item: " + item.getItemName() +
                        ". Available: " + item.getStock() + ", Requested: " + billItem.getQuantity());
            }

            // Set item details
            billItem.setItem(item);
            billItem.setUnitPrice(item.getPrice());

            // Apply item discount if not already set
            if (billItem.getDiscountPercentage() == null ||
                    billItem.getDiscountPercentage().compareTo(BigDecimal.ZERO) == 0) {
                billItem.setDiscountPercentage(item.getDiscountPercentage());
            }

            // Calculate item total
            billItem.calculateTotalPrice();

            preparedItems.add(billItem);
        }

        return preparedItems;
    }

    /**
     * Calculate bill totals with all discounts and taxes
     */
    public BillCalculation calculateBillTotals(List<BillItem> billItems, Customer customer,
                                               int loyaltyPointsToRedeem) {
        BillCalculation calc = new BillCalculation();

        // Calculate subtotal and item discounts
        for (BillItem item : billItems) {
            BigDecimal itemOriginalPrice = item.getUnitPrice()
                    .multiply(new BigDecimal(item.getQuantity()));
            BigDecimal itemDiscount = itemOriginalPrice
                    .multiply(item.getDiscountPercentage())
                    .divide(new BigDecimal(100), 2, RoundingMode.HALF_UP);

            calc.subtotal = calc.subtotal.add(itemOriginalPrice);
            calc.itemDiscountAmount = calc.itemDiscountAmount.add(itemDiscount);
        }

        // Calculate membership discount
        BigDecimal membershipDiscountPercentage = getMembershipDiscountPercentage(customer.getMembershipType());
        calc.membershipDiscountAmount = calc.subtotal
                .subtract(calc.itemDiscountAmount)
                .multiply(membershipDiscountPercentage)
                .divide(new BigDecimal(100), 2, RoundingMode.HALF_UP);

        // Calculate loyalty points discount
        calc.loyaltyDiscountAmount = new BigDecimal(loyaltyPointsToRedeem)
                .multiply(LOYALTY_POINT_VALUE);

        // Calculate total discount
        calc.totalDiscountAmount = calc.itemDiscountAmount
                .add(calc.membershipDiscountAmount)
                .add(calc.loyaltyDiscountAmount);

        // Ensure discount doesn't exceed subtotal
        if (calc.totalDiscountAmount.compareTo(calc.subtotal) > 0) {
            calc.totalDiscountAmount = calc.subtotal;
        }

        // Calculate taxable amount
        calc.taxableAmount = calc.subtotal.subtract(calc.totalDiscountAmount);

        // Calculate tax
        calc.taxAmount = calc.taxableAmount.multiply(TAX_RATE)
                .setScale(2, RoundingMode.HALF_UP);

        // Calculate total
        calc.totalAmount = calc.taxableAmount.add(calc.taxAmount);

        // Calculate loyalty points earned
        calc.loyaltyPointsEarned = calc.totalAmount
                .divide(new BigDecimal(LOYALTY_POINTS_PER_AMOUNT), 0, RoundingMode.DOWN)
                .intValue();

        // Calculate total savings
        calc.totalSavings = calc.totalDiscountAmount;

        return calc;
    }

    /**
     * Get membership discount percentage
     */
    private BigDecimal getMembershipDiscountPercentage(String membershipType) {
        if (membershipType == null) {
            return REGULAR_DISCOUNT;
        }

        switch (membershipType.toUpperCase()) {
            case "PREMIUM":
                return PREMIUM_DISCOUNT;
            case "VIP":
                return VIP_DISCOUNT;
            default:
                return REGULAR_DISCOUNT;
        }
    }

    /**
     * Get bill by ID with all details
     */
    public Bill getBillById(int billId) throws SQLException {
        if (billId <= 0) {
            return null;
        }

        return billDAO.getBillById(billId);
    }

    /**
     * Get bills by customer
     */
    public List<Bill> getBillsByCustomer(int customerId) throws SQLException {
        if (customerId <= 0) {
            return new ArrayList<>();
        }

        return billDAO.getBillsByCustomer(customerId);
    }

    /**
     * Get all bills
     */
    public List<Bill> getAllBills() throws SQLException {
        return billDAO.getAllBills();
    }

    /**
     * Get bills by date range
     */
    public List<Bill> getBillsByDateRange(Date startDate, Date endDate) throws SQLException {
        if (startDate == null || endDate == null || startDate.after(endDate)) {
            return new ArrayList<>();
        }

        return billDAO.getBillsByDateRange(startDate, endDate);
    }

    /**
     * Search bills by bill number
     */
    public Bill searchBillByNumber(String billNumber) throws SQLException {
        if (billNumber == null || billNumber.trim().isEmpty()) {
            return null;
        }

        return billDAO.getBillByNumber(billNumber.trim());
    }

    /**
     * Cancel a bill
     */
    public boolean cancelBill(int billId) throws SQLException {
        if (billId <= 0) {
            return false;
        }

        return billDAO.cancelBill(billId);
    }



    /**
     * Get today's sales
     */
    public BigDecimal getTodaysSales() throws SQLException {
        return billDAO.getTodaysSales();
    }

    /**
     * Get sales statistics for date range
     */
    public Map<String, BigDecimal> getSalesStatistics(Date startDate, Date endDate) throws SQLException {
        return billDAO.getSalesStatistics(startDate, endDate);
    }

    /**
     * Get best selling items
     */
    public List<Map<String, Object>> getBestSellingItems(int limit) throws SQLException {
        return billItemDAO.getBestSellingItems(limit);
    }

    /**
     * Get sales by category
     */
    public List<Map<String, Object>> getSalesByCategory() throws SQLException {
        return billItemDAO.getSalesByCategory();
    }

    /**
     * Calculate quick bill preview
     */
    public Map<String, Object> calculateBillPreview(List<Map<String, Object>> items,
                                                    int customerId, int loyaltyPointsToRedeem)
            throws SQLException {

        Map<String, Object> preview = new HashMap<>();

        // Get customer
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer == null) {
            throw new IllegalArgumentException("Customer not found");
        }

        // Create temporary bill items
        List<BillItem> billItems = new ArrayList<>();
        for (Map<String, Object> itemData : items) {
            BillItem billItem = new BillItem();
            billItem.setItemId((String) itemData.get("itemId"));
            billItem.setQuantity((Integer) itemData.get("quantity"));
            billItem.setDiscountPercentage((BigDecimal) itemData.getOrDefault("discount", BigDecimal.ZERO));
            billItems.add(billItem);
        }

        // Validate and prepare items
        List<BillItem> preparedItems = validateAndPrepareBillItems(billItems);

        // Calculate totals
        BillCalculation calc = calculateBillTotals(preparedItems, customer, loyaltyPointsToRedeem);

        // Prepare preview
        preview.put("items", preparedItems);
        preview.put("subtotal", calc.subtotal);
        preview.put("itemDiscount", calc.itemDiscountAmount);
        preview.put("membershipDiscount", calc.membershipDiscountAmount);
        preview.put("loyaltyDiscount", calc.loyaltyDiscountAmount);
        preview.put("totalDiscount", calc.totalDiscountAmount);
        preview.put("taxAmount", calc.taxAmount);
        preview.put("totalAmount", calc.totalAmount);
        preview.put("loyaltyPointsEarned", calc.loyaltyPointsEarned);
        preview.put("totalSavings", calc.totalSavings);
        preview.put("customerName", customer.getName());
        preview.put("membershipType", customer.getMembershipType());
        preview.put("availableLoyaltyPoints", customer.getLoyaltyPoints());

        return preview;
    }

    /**
     * Process return for bill items
     */
    public boolean processReturn(int billId, Map<Integer, Integer> itemReturns) throws SQLException {
        if (billId <= 0 || itemReturns == null || itemReturns.isEmpty()) {
            return false;
        }

        // Get bill
        Bill bill = getBillById(billId);
        if (bill == null || "CANCELLED".equals(bill.getPaymentStatus())) {
            return false;
        }

        // Process each return
        for (Map.Entry<Integer, Integer> entry : itemReturns.entrySet()) {
            billItemDAO.processItemReturn(entry.getKey(), entry.getValue());
        }

        // TODO: Update bill totals and customer loyalty points

        return true;
    }

    /**
     * Get bill statistics summary
     */
    public Map<String, Object> getBillStatisticsSummary() throws SQLException {
        Map<String, Object> summary = new HashMap<>();

        // Get today's stats
        Date today = Date.valueOf(LocalDate.now());
        Date startOfMonth = Date.valueOf(LocalDate.now().withDayOfMonth(1));
        Date endOfMonth = Date.valueOf(LocalDate.now().withDayOfMonth(LocalDate.now().lengthOfMonth()));

        Map<String, BigDecimal> todayStats = getSalesStatistics(today, today);
        Map<String, BigDecimal> monthStats = getSalesStatistics(startOfMonth, endOfMonth);

        summary.put("todaySales", todayStats.get("totalRevenue"));
        summary.put("todayBills", todayStats.get("totalBills"));
        summary.put("monthSales", monthStats.get("totalRevenue"));
        summary.put("monthBills", monthStats.get("totalBills"));
        summary.put("averageBillToday", todayStats.get("averageBill"));
        summary.put("averageBillMonth", monthStats.get("averageBill"));

        return summary;
    }

    /**
     * Validate bill data
     */
    public boolean isValidBill(Bill bill) {
        if (bill == null) {
            return false;
        }

        // Validate customer
        if (bill.getCustomerId() <= 0) {
            return false;
        }

        // Validate amounts
        if (bill.getSubtotal() == null || bill.getSubtotal().compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }

        if (bill.getTotalAmount() == null || bill.getTotalAmount().compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }

        // Validate bill items
        if (bill.getBillItems() == null || bill.getBillItems().isEmpty()) {
            return false;
        }

        return true;
    }

    /**
     * Get discount policy information
     */
    public String getDiscountPolicy() {
        return String.format(
                "Bookshop Discount Policy:\n" +
                        "========================\n" +
                        "Membership Discounts:\n" +
                        "- Regular: 0%%\n" +
                        "- Premium: %.0f%%\n" +
                        "- VIP: %.0f%%\n\n" +
                        "Loyalty Points:\n" +
                        "- Earn: 1 point per %d currency units spent\n" +
                        "- Redeem: 1 point = %.2f currency units\n\n" +
                        "Tax Rate: %.0f%%",
                PREMIUM_DISCOUNT, VIP_DISCOUNT,
                LOYALTY_POINTS_PER_AMOUNT, LOYALTY_POINT_VALUE,
                TAX_RATE.multiply(new BigDecimal(100))
        );
    }
}
