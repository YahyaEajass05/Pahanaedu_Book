package com.pahanaedu.service;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

public class BillService {

    private BillDAO billDAO;
    private CustomerDAO customerDAO;
    private static final BigDecimal RATE_PER_UNIT = new BigDecimal("50.00"); // LKR 50 per unit

    public BillService() {
        this.billDAO = new BillDAO();
        this.customerDAO = new CustomerDAO();
    }

    /**
     * Generate a new bill for a customer
     * @param accountNumber - customer account number
     * @return Bill object if successful, null otherwise
     */
    public Bill generateBill(String accountNumber) {
        // Validate input
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            return null;
        }

        // Get customer details
        Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber.trim());
        if (customer == null) {
            return null;
        }

        // Calculate bill amount
        int unitsConsumed = customer.getUnitsConsumed();
        BigDecimal totalAmount = calculateBillAmount(unitsConsumed);

        // Create bill object
        Bill bill = new Bill();
        bill.setAccountNumber(customer.getAccountNumber());
        bill.setTotalUnits(unitsConsumed);
        bill.setTotalAmount(totalAmount);
        bill.setBillDate(Date.valueOf(LocalDate.now()));

        // Save bill to database
        if (billDAO.addBill(bill)) {
            return bill;
        }

        return null;
    }

    /**
     * Generate bill with custom units (override customer's current units)
     * @param accountNumber - customer account number
     * @param customUnits - custom units consumed
     * @return Bill object if successful, null otherwise
     */
    public Bill generateBillWithCustomUnits(String accountNumber, int customUnits) {
        // Validate input
        if (accountNumber == null || accountNumber.trim().isEmpty() || customUnits < 0) {
            return null;
        }

        // Check if customer exists
        Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber.trim());
        if (customer == null) {
            return null;
        }

        // Calculate bill amount
        BigDecimal totalAmount = calculateBillAmount(customUnits);

        // Create bill object
        Bill bill = new Bill();
        bill.setAccountNumber(customer.getAccountNumber());
        bill.setTotalUnits(customUnits);
        bill.setTotalAmount(totalAmount);
        bill.setBillDate(Date.valueOf(LocalDate.now()));

        // Save bill to database
        if (billDAO.addBill(bill)) {
            // Update customer's units consumed
            customer.setUnitsConsumed(customUnits);
            customerDAO.updateCustomer(customer);
            return bill;
        }

        return null;
    }

    /**
     * Calculate bill amount based on units consumed
     * @param unitsConsumed - number of units consumed
     * @return calculated bill amount
     */
    public BigDecimal calculateBillAmount(int unitsConsumed) {
        if (unitsConsumed < 0) {
            return BigDecimal.ZERO;
        }

        BigDecimal baseAmount = RATE_PER_UNIT.multiply(new BigDecimal(unitsConsumed));

        // Apply discount for high consumption
        BigDecimal finalAmount = applyDiscounts(baseAmount, unitsConsumed);

        // Apply taxes
        finalAmount = applyTaxes(finalAmount);

        // Round to 2 decimal places
        return finalAmount.setScale(2, BigDecimal.ROUND_HALF_UP);
    }

    /**
     * Apply discounts based on consumption level
     * @param baseAmount - base amount before discount
     * @param unitsConsumed - units consumed
     * @return amount after discount
     */
    private BigDecimal applyDiscounts(BigDecimal baseAmount, int unitsConsumed) {
        BigDecimal discountRate = BigDecimal.ZERO;

        if (unitsConsumed >= 100) {
            discountRate = new BigDecimal("0.15"); // 15% discount for 100+ units
        } else if (unitsConsumed >= 50) {
            discountRate = new BigDecimal("0.10"); // 10% discount for 50-99 units
        } else if (unitsConsumed >= 20) {
            discountRate = new BigDecimal("0.05"); // 5% discount for 20-49 units
        }

        BigDecimal discount = baseAmount.multiply(discountRate);
        return baseAmount.subtract(discount);
    }

    /**
     * Apply taxes to the bill amount
     * @param amount - amount before tax
     * @return amount after tax
     */
    private BigDecimal applyTaxes(BigDecimal amount) {
        BigDecimal taxRate = new BigDecimal("0.08"); // 8% tax
        BigDecimal tax = amount.multiply(taxRate);
        return amount.add(tax);
    }

    /**
     * Get bill by bill ID
     * @param billId - bill ID
     * @return Bill object if found, null otherwise
     */
    public Bill getBillById(int billId) {
        if (billId <= 0) {
            return null;
        }

        return billDAO.getBillById(billId);
    }

    /**
     * Get all bills for a specific customer
     * @param accountNumber - customer account number
     * @return List of bills for the customer
     */
    public List<Bill> getBillsByCustomer(String accountNumber) {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            return null;
        }

        return billDAO.getBillsByCustomer(accountNumber.trim());
    }

    /**
     * Get all bills
     * @return List of all bills
     */
    public List<Bill> getAllBills() {
        return billDAO.getAllBills();
    }

    /**
     * Get bills within a date range
     * @param startDate - start date
     * @param endDate - end date
     * @return List of bills within the date range
     */
    public List<Bill> getBillsByDateRange(Date startDate, Date endDate) {
        if (startDate == null || endDate == null || startDate.after(endDate)) {
            return null;
        }

        return billDAO.getBillsByDateRange(startDate, endDate);
    }

    /**
     * Delete bill by bill ID
     * @param billId - bill ID to delete
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteBill(int billId) {
        if (billId <= 0) {
            return false;
        }

        return billDAO.deleteBill(billId);
    }

    /**
     * Get total revenue for a specific date
     * @param date - date to calculate revenue for
     * @return total revenue for the date
     */
    public BigDecimal getTotalRevenueByDate(Date date) {
        if (date == null) {
            return BigDecimal.ZERO;
        }

        return billDAO.getTotalRevenueByDate(date);
    }

    /**
     * Get today's total revenue
     * @return today's total revenue
     */
    public BigDecimal getTodaysRevenue() {
        Date today = Date.valueOf(LocalDate.now());
        return getTotalRevenueByDate(today);
    }

    /**
     * Get monthly revenue for current month
     * @return current month's total revenue
     */
    public BigDecimal getMonthlyRevenue() {
        LocalDate now = LocalDate.now();
        Date startOfMonth = Date.valueOf(now.withDayOfMonth(1));
        Date endOfMonth = Date.valueOf(now.withDayOfMonth(now.lengthOfMonth()));

        List<Bill> monthlyBills = getBillsByDateRange(startOfMonth, endOfMonth);
        if (monthlyBills == null) {
            return BigDecimal.ZERO;
        }

        BigDecimal totalRevenue = BigDecimal.ZERO;
        for (Bill bill : monthlyBills) {
            totalRevenue = totalRevenue.add(bill.getTotalAmount());
        }

        return totalRevenue;
    }

    /**
     * Generate next bill number
     * @return formatted bill number string
     */
    public String generateBillNumber() {
        int latestBillId = billDAO.getLatestBillId();
        int nextBillNumber = latestBillId + 1;

        // Format: BILL-2024-001
        LocalDate now = LocalDate.now();
        return String.format("BILL-%d-%03d", now.getYear(), nextBillNumber);
    }

    /**
     * Get bill statistics
     * @return String with bill statistics
     */
    public String getBillStatistics() {
        List<Bill> allBills = getAllBills();
        if (allBills == null || allBills.isEmpty()) {
            return "No bills found.";
        }

        int totalBills = allBills.size();
        BigDecimal totalRevenue = BigDecimal.ZERO;
        int totalUnits = 0;

        for (Bill bill : allBills) {
            totalRevenue = totalRevenue.add(bill.getTotalAmount());
            totalUnits += bill.getTotalUnits();
        }

        BigDecimal averageBillAmount = totalRevenue.divide(new BigDecimal(totalBills), 2, BigDecimal.ROUND_HALF_UP);

        return String.format(
                "Total Bills: %d | Total Revenue: LKR %.2f | Total Units: %d | Average Bill: LKR %.2f",
                totalBills, totalRevenue, totalUnits, averageBillAmount
        );
    }

    /**
     * Validate bill data
     * @param bill - Bill object to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidBill(Bill bill) {
        if (bill == null) {
            return false;
        }

        // Validate account number
        if (bill.getAccountNumber() == null || bill.getAccountNumber().trim().isEmpty()) {
            return false;
        }

        // Validate units
        if (bill.getTotalUnits() < 0) {
            return false;
        }

        // Validate amount
        if (bill.getTotalAmount() == null || bill.getTotalAmount().compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }

        // Validate date
        if (bill.getBillDate() == null) {
            return false;
        }

        return true;
    }

    /**
     * Get current rate per unit
     * @return rate per unit
     */
    public BigDecimal getRatePerUnit() {
        return RATE_PER_UNIT;
    }
}