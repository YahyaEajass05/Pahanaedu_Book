package com.pahanaedu.service;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;

import java.sql.SQLException;
import java.util.List;
import java.util.regex.Pattern;

public class CustomerService {

    private CustomerDAO customerDAO;

    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    /**
     * Register a new customer with validation
     * @param customer - Customer object to add
     * @return true if customer added successfully, false otherwise
     */
    public boolean registerCustomer(Customer customer) {
        // Validate customer data
        if (!isValidCustomer(customer)) {
            return false;
        }

        // Check if email already exists
        if (customerDAO.customerExists(customer.getEmail())) {
            return false;
        }

        // Clean customer data
        cleanCustomerData(customer);

        return customerDAO.addCustomer(customer);
    }

    /**
     * Get customer by ID
     * @param customerId - customer ID
     * @return Customer object if found, null otherwise
     */
    public Customer getCustomerById(int customerId) {
        if (customerId <= 0) {
            return null;
        }
        return customerDAO.getCustomerById(customerId);
    }

    /**
     * Get customer by email
     * @param email - customer email
     * @return Customer object if found, null otherwise
     */
    public Customer getCustomerByEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }
        return customerDAO.getCustomerByEmail(email.trim().toLowerCase());
    }

    /**
     * Get all customers
     * @return List of all customers
     */
    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }

    /**
     * Update customer information with validation
     * @param customer - Customer object with updated information
     * @return true if update successful, false otherwise
     */
    public boolean updateCustomer(Customer customer) {
        // Validate customer data
        if (!isValidCustomer(customer)) {
            return false;
        }

        // Check if customer exists
        Customer existingCustomer = customerDAO.getCustomerById(customer.getCustomerId());
        if (existingCustomer == null) {
            return false;
        }

        // Check if email is being changed and if new email already exists
        if (!existingCustomer.getEmail().equalsIgnoreCase(customer.getEmail())) {
            if (customerDAO.customerExists(customer.getEmail())) {
                return false;
            }
        }

        // Clean customer data
        cleanCustomerData(customer);

        return customerDAO.updateCustomer(customer);
    }

    /**
     * Delete customer by ID
     * @param customerId - customer ID to delete
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteCustomer(int customerId) {
        if (customerId <= 0) {
            return false;
        }

        // Check if customer exists before deletion
        if (customerDAO.getCustomerById(customerId) == null) {
            return false;
        }

        return customerDAO.deleteCustomer(customerId);
    }

    /**
     * Search customers by name, email, or phone
     * @param searchTerm - search term
     * @return List of matching customers
     */
    public List<Customer> searchCustomers(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return getAllCustomers();
        }
        return customerDAO.searchCustomers(searchTerm.trim());
    }

    /**
     * Get customers by membership type
     * @param membershipType - membership type (REGULAR, PREMIUM, VIP)
     * @return List of customers with specified membership type
     */
    public List<Customer> getCustomersByMembershipType(String membershipType) {
        if (membershipType == null || membershipType.trim().isEmpty()) {
            return getAllCustomers();
        }
        return customerDAO.getCustomersByMembershipType(membershipType.trim().toUpperCase());
    }

    /**
     * Process a customer purchase
     * @param customerId - customer ID
     * @param purchaseAmount - purchase amount
     * @return true if purchase processed successfully
     */
    public boolean processPurchase(int customerId, double purchaseAmount) {
        if (customerId <= 0 || purchaseAmount <= 0) {
            return false;
        }

        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer == null) {
            return false;
        }

        return customerDAO.updateCustomerPurchase(customerId, purchaseAmount);
    }

    /**
     * Add loyalty points to customer
     * @param customerId - customer ID
     * @param points - points to add
     * @return true if points added successfully
     */
    public boolean addLoyaltyPoints(int customerId, int points) {
        if (customerId <= 0 || points <= 0) {
            return false;
        }

        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer != null) {
            customer.setLoyaltyPoints(customer.getLoyaltyPoints() + points);
            return customerDAO.updateCustomer(customer);
        }
        return false;
    }

    /**
     * Redeem loyalty points
     * @param customerId - customer ID
     * @param points - points to redeem
     * @return true if points redeemed successfully
     */
    public boolean redeemLoyaltyPoints(int customerId, int points) {
        if (customerId <= 0 || points <= 0) {
            return false;
        }

        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer != null && customer.getLoyaltyPoints() >= points) {
            return customerDAO.redeemLoyaltyPoints(customerId, points);
        }
        return false;
    }

    /**
     * Get top customers by purchase amount
     * @param limit - number of customers to return
     * @return List of top customers
     */
    public List<Customer> getTopCustomers(int limit) {
        if (limit <= 0) {
            limit = 10; // Default to top 10
        }
        return customerDAO.getTopCustomers(limit);
    }

    /**
     * Calculate discount for customer based on membership
     * @param customerId - customer ID
     * @param originalPrice - original price
     * @return discounted price
     */
    public double calculateDiscount(int customerId, double originalPrice) {
        Customer customer = customerDAO.getCustomerById(customerId);
        if (customer == null) {
            return originalPrice;
        }

        double discountPercentage = customer.getDiscountPercentage();
        return originalPrice * (1 - discountPercentage / 100);
    }

    /**
     * Validate customer data
     * @param customer - Customer object to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidCustomer(Customer customer) {
        if (customer == null) {
            return false;
        }

        // Validate name
        if (!isValidName(customer.getName())) {
            return false;
        }

        // Validate email
        if (!isValidEmail(customer.getEmail())) {
            return false;
        }

        // Validate phone
        if (!isValidPhone(customer.getPhone())) {
            return false;
        }

        // Validate address
        if (!isValidAddress(customer.getAddress())) {
            return false;
        }

        // Validate membership type
        if (!isValidMembershipType(customer.getMembershipType())) {
            return false;
        }

        // Validate numeric fields
        if (customer.getTotalPurchases() < 0 || customer.getLoyaltyPoints() < 0) {
            return false;
        }

        return true;
    }

    /**
     * Validate customer name
     * @param name - name to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }

        name = name.trim();
        // Name should be 2-100 characters, letters, spaces, dots, and apostrophes
        return name.length() >= 2 && name.length() <= 100
                && name.matches("^[a-zA-Z\\s.']+$");
    }

    /**
     * Validate email format
     * @param email - email to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        email = email.trim();
        return email.length() <= 100 && EMAIL_PATTERN.matcher(email).matches();
    }

    /**
     * Validate phone number
     * @param phone - phone to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }

        phone = phone.trim();
        // Phone should be 7-15 characters, numbers, spaces, hyphens, plus, and parentheses
        return phone.length() >= 7 && phone.length() <= 15
                && phone.matches("^[0-9\\s\\-\\+\\(\\)]+$");
    }

    /**
     * Validate customer address
     * @param address - address to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidAddress(String address) {
        if (address == null || address.trim().isEmpty()) {
            return false;
        }

        address = address.trim();
        // Address should be 5-500 characters
        return address.length() >= 5 && address.length() <= 500;
    }

    /**
     * Validate membership type
     * @param membershipType - membership type to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidMembershipType(String membershipType) {
        if (membershipType == null || membershipType.trim().isEmpty()) {
            return false;
        }

        String type = membershipType.trim().toUpperCase();
        return type.equals("REGULAR") || type.equals("PREMIUM") || type.equals("VIP");
    }

    /**
     * Clean and format customer data
     * @param customer - Customer object to clean
     */
    private void cleanCustomerData(Customer customer) {
        if (customer != null) {
            if (customer.getName() != null) {
                customer.setName(formatName(customer.getName().trim()));
            }
            if (customer.getEmail() != null) {
                customer.setEmail(customer.getEmail().trim().toLowerCase());
            }
            if (customer.getPhone() != null) {
                customer.setPhone(customer.getPhone().trim());
            }
            if (customer.getAddress() != null) {
                customer.setAddress(customer.getAddress().trim());
            }
            if (customer.getMembershipType() != null) {
                customer.setMembershipType(customer.getMembershipType().trim().toUpperCase());
            }
        }
    }

    /**
     * Format name to proper case (first letter of each word capitalized)
     * @param name - name to format
     * @return formatted name
     */
    private String formatName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return name;
        }

        String[] words = name.trim().split("\\s+");
        StringBuilder formattedName = new StringBuilder();

        for (int i = 0; i < words.length; i++) {
            if (i > 0) {
                formattedName.append(" ");
            }

            String word = words[i].toLowerCase();
            if (word.length() > 0) {
                formattedName.append(Character.toUpperCase(word.charAt(0)));
                if (word.length() > 1) {
                    formattedName.append(word.substring(1));
                }
            }
        }

        return formattedName.toString();
    }

    /**
     * Get customer count
     * @return total number of customers
     */
    public int getCustomerCount() {
        return getAllCustomers().size();
    }

    /**
     * Get customer count by membership type
     * @param membershipType - membership type
     * @return count of customers with specified membership type
     */
    public int getCustomerCountByMembershipType(String membershipType) {
        return getCustomersByMembershipType(membershipType).size();
    }

    /**
     * Check if email exists
     * @param email - email to check
     * @return true if email exists, false otherwise
     */
    public boolean emailExists(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return customerDAO.customerExists(email.trim().toLowerCase());
    }


    // Add these methods to your existing CustomerService class

    public int getTotalCustomerCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM customers";
        // Execute query and return result
        return 0; // Placeholder
    }

    public int getActiveCustomerCount() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT customer_id) FROM bills " +
                "WHERE bill_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)";
        // Execute query and return result
        return 0; // Placeholder
    }

    public int getNewCustomersThisMonth() throws SQLException {
        String sql = "SELECT COUNT(*) FROM customers " +
                "WHERE MONTH(created_at) = MONTH(CURRENT_DATE) " +
                "AND YEAR(created_at) = YEAR(CURRENT_DATE)";
        // Execute query and return result
        return 0; // Placeholder
    }

}


