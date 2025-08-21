package com.pahanaedu.service;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;
import java.util.List;

public class CustomerService {

    private CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    /**
     * Add a new customer with validation
     * @param customer - Customer object to add
     * @return true if customer added successfully, false otherwise
     */
    public boolean addCustomer(Customer customer) {
        // Validate customer data
        if (!isValidCustomer(customer)) {
            return false;
        }

        // Check if customer already exists
        if (customerDAO.customerExists(customer.getAccountNumber())) {
            return false;
        }

        // Clean customer data
        cleanCustomerData(customer);

        return customerDAO.addCustomer(customer);
    }

    /**
     * Get customer by account number
     * @param accountNumber - customer account number
     * @return Customer object if found, null otherwise
     */
    public Customer getCustomerByAccountNumber(String accountNumber) {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            return null;
        }

        return customerDAO.getCustomerByAccountNumber(accountNumber.trim());
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
        if (!customerDAO.customerExists(customer.getAccountNumber())) {
            return false;
        }

        // Clean customer data
        cleanCustomerData(customer);

        return customerDAO.updateCustomer(customer);
    }

    /**
     * Delete customer by account number
     * @param accountNumber - customer account number to delete
     * @return true if deletion successful, false otherwise
     */
    public boolean deleteCustomer(String accountNumber) {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            return false;
        }

        // Check if customer exists before deletion
        if (!customerDAO.customerExists(accountNumber.trim())) {
            return false;
        }

        return customerDAO.deleteCustomer(accountNumber.trim());
    }

    /**
     * Check if customer exists
     * @param accountNumber - customer account number
     * @return true if customer exists, false otherwise
     */
    public boolean customerExists(String accountNumber) {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            return false;
        }

        return customerDAO.customerExists(accountNumber.trim());
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

        // Validate account number
        if (!isValidAccountNumber(customer.getAccountNumber())) {
            return false;
        }

        // Validate name
        if (!isValidName(customer.getName())) {
            return false;
        }

        // Validate address
        if (!isValidAddress(customer.getAddress())) {
            return false;
        }

        // Validate telephone
        if (!isValidTelephone(customer.getTelephone())) {
            return false;
        }

        // Validate units consumed
        if (customer.getUnitsConsumed() < 0) {
            return false;
        }

        return true;
    }

    /**
     * Validate account number format
     * @param accountNumber - account number to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidAccountNumber(String accountNumber) {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            return false;
        }

        accountNumber = accountNumber.trim();

        // Account number should be 4-20 characters, alphanumeric with underscores and hyphens
        return accountNumber.length() >= 4 && accountNumber.length() <= 20
                && accountNumber.matches("^[a-zA-Z0-9_-]+$");
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
     * Validate telephone number
     * @param telephone - telephone to validate
     * @return true if valid, false otherwise
     */
    public boolean isValidTelephone(String telephone) {
        if (telephone == null || telephone.trim().isEmpty()) {
            return false;
        }

        telephone = telephone.trim();

        // Telephone should be 7-15 characters, numbers, spaces, hyphens, plus, and parentheses
        return telephone.length() >= 7 && telephone.length() <= 15
                && telephone.matches("^[0-9\\s\\-\\+\\(\\)]+$");
    }

    /**
     * Clean and format customer data
     * @param customer - Customer object to clean
     */
    private void cleanCustomerData(Customer customer) {
        if (customer != null) {
            if (customer.getAccountNumber() != null) {
                customer.setAccountNumber(customer.getAccountNumber().trim().toUpperCase());
            }
            if (customer.getName() != null) {
                customer.setName(formatName(customer.getName().trim()));
            }
            if (customer.getAddress() != null) {
                customer.setAddress(customer.getAddress().trim());
            }
            if (customer.getTelephone() != null) {
                customer.setTelephone(customer.getTelephone().trim());
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
}