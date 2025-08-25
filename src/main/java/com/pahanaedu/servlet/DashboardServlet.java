package com.pahanaedu.servlet;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import com.pahanaedu.model.User;
import com.pahanaedu.service.CustomerService;
import com.pahanaedu.service.ItemService;
import com.pahanaedu.service.BillService;
import com.pahanaedu.service.BillItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private CustomerService customerService;
    private ItemService itemService;
    private BillService billService;
    private BillItemService billItemService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
        itemService = new ItemService();
        billService = new BillService();
        billItemService = new BillItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            loadDashboardStatistics(request);
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            setDefaultValues(request);
            request.setAttribute("errorMessage", "Error loading dashboard data: " + e.getMessage());
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("refresh".equals(action)) {
            // Refresh dashboard data
            doGet(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    private void loadDashboardStatistics(HttpServletRequest request) throws SQLException {
        try {
            // Get session and user info - FIXED: Handle User object properly
            HttpSession session = request.getSession();
            Object userObj = session.getAttribute("adminUser");
            String adminUsername = null;

            if (userObj instanceof User) {
                User user = (User) userObj;
                adminUsername = user.getUsername();
            } else if (userObj instanceof String) {
                adminUsername = (String) userObj;
            } else {
                // Check if username is stored separately
                adminUsername = (String) session.getAttribute("username");
            }

            request.setAttribute("adminUsername", adminUsername != null ? adminUsername : "Admin");
            request.setAttribute("currentDate", new java.util.Date());

            // Customer statistics
            loadCustomerStatistics(request);

            // Item/Book statistics
            loadItemStatistics(request);

            // Sales/Bill statistics
            loadSalesStatistics(request);

            // Best selling and category sales
            loadSalesAnalytics(request);

            // Recent activities
            loadRecentActivities(request);

            // Calculate performance metrics
            calculatePerformanceMetrics(request);

            // Prepare chart data
            prepareChartData(request);

            // Set alert flags
            setAlertFlags(request);

        } catch (Exception e) {
            e.printStackTrace();
            setDefaultValues(request);
            throw new SQLException("Failed to load dashboard statistics: " + e.getMessage());
        }
    }

    private void loadCustomerStatistics(HttpServletRequest request) throws SQLException {
        try {
            // Get customer counts
            int totalCustomers = customerService.getCustomerCount();

            // Get customers by membership type
            List<Customer> allCustomers = customerService.getAllCustomers();
            int regularCustomers = 0;
            int premiumCustomers = 0;
            int vipCustomers = 0;

            for (Customer customer : allCustomers) {
                String membershipType = customer.getMembershipType();
                if ("REGULAR".equals(membershipType)) {
                    regularCustomers++;
                } else if ("PREMIUM".equals(membershipType)) {
                    premiumCustomers++;
                } else if ("VIP".equals(membershipType)) {
                    vipCustomers++;
                }
            }

            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("regularCustomers", regularCustomers);
            request.setAttribute("premiumCustomers", premiumCustomers);
            request.setAttribute("vipCustomers", vipCustomers);

            // Calculate new customers this month
            int newCustomersThisMonth = 0;
            LocalDate monthStart = LocalDate.now().withDayOfMonth(1);

            for (Customer customer : allCustomers) {
                if (customer.getCreatedAt() != null) {
                    LocalDate createdDate = customer.getCreatedAt().toLocalDateTime().toLocalDate();
                    if (!createdDate.isBefore(monthStart)) {
                        newCustomersThisMonth++;
                    }
                }
            }

            request.setAttribute("newCustomersThisMonth", newCustomersThisMonth);

        } catch (Exception e) {
            request.setAttribute("totalCustomers", 0);
            request.setAttribute("regularCustomers", 0);
            request.setAttribute("premiumCustomers", 0);
            request.setAttribute("vipCustomers", 0);
            request.setAttribute("newCustomersThisMonth", 0);
        }
    }

    private void loadItemStatistics(HttpServletRequest request) throws SQLException {
        try {
            // Get item statistics
            Map<String, Object> itemStats = itemService.getItemStatistics();
            List<Item> lowStockItems = itemService.getLowStockItems(10);
            List<Item> outOfStockItems = itemService.getOutOfStockItems();
            List<String> categories = itemService.getAllCategories();

            request.setAttribute("totalItems", itemStats.getOrDefault("totalItems", 0));
            request.setAttribute("totalStock", itemStats.getOrDefault("totalStock", 0));
            request.setAttribute("lowStockCount", lowStockItems.size());
            request.setAttribute("outOfStockCount", outOfStockItems.size());
            request.setAttribute("averagePrice", itemStats.getOrDefault("averagePrice", BigDecimal.ZERO));
            request.setAttribute("lowStockItems", lowStockItems.size() > 5 ? lowStockItems.subList(0, 5) : lowStockItems);
            request.setAttribute("categoriesCount", categories.size());

            // Calculate inventory values
            BigDecimal inventoryValue = itemService.getTotalInventoryValue();
            BigDecimal discountedInventoryValue = itemService.getTotalDiscountedInventoryValue();

            request.setAttribute("inventoryValue", inventoryValue);
            request.setAttribute("discountedInventoryValue", discountedInventoryValue);
            request.setAttribute("inventorySavings", inventoryValue.subtract(discountedInventoryValue));

        } catch (Exception e) {
            request.setAttribute("totalItems", 0);
            request.setAttribute("totalStock", 0);
            request.setAttribute("lowStockCount", 0);
            request.setAttribute("outOfStockCount", 0);
            request.setAttribute("inventoryValue", BigDecimal.ZERO);
        }
    }

    private void loadSalesStatistics(HttpServletRequest request) throws SQLException {
        try {
            // Today's sales
            BigDecimal todaysSales = billService.getTodaysSales();

            // Get bill statistics
            Map<String, Object> billStats = billService.getBillStatisticsSummary();

            request.setAttribute("todaysSales", todaysSales);
            request.setAttribute("todaysBills", billStats.getOrDefault("todayBills", 0));
            request.setAttribute("monthSales", billStats.getOrDefault("monthSales", BigDecimal.ZERO));
            request.setAttribute("monthBills", billStats.getOrDefault("monthBills", 0));

            BigDecimal avgBillToday = (BigDecimal) billStats.get("averageBillToday");
            BigDecimal avgBillMonth = (BigDecimal) billStats.get("averageBillMonth");

            request.setAttribute("averageBillToday", avgBillToday != null ? avgBillToday : BigDecimal.ZERO);
            request.setAttribute("averageBillMonth", avgBillMonth != null ? avgBillMonth : BigDecimal.ZERO);

            // Calculate revenue metrics
            BigDecimal yesterdaySales = getYesterdaySales();
            BigDecimal dailyGrowth = calculateDailyGrowth(todaysSales, yesterdaySales);

            request.setAttribute("yesterdaySales", yesterdaySales);
            request.setAttribute("dailyGrowth", dailyGrowth);

        } catch (Exception e) {
            request.setAttribute("todaysSales", BigDecimal.ZERO);
            request.setAttribute("todaysBills", 0);
            request.setAttribute("monthSales", BigDecimal.ZERO);
            request.setAttribute("monthBills", 0);
        }
    }

    private void loadSalesAnalytics(HttpServletRequest request) throws SQLException {
        try {
            // Best selling items
            List<Map<String, Object>> bestSellers = billItemService.getBestSellingItems(5);
            request.setAttribute("bestSellers", bestSellers);

            // Sales by category
            List<Map<String, Object>> categorySales = billItemService.getSalesByCategory();
            request.setAttribute("categorySales", categorySales);

            // Top spending customers
            List<Map<String, Object>> topCustomers = getTopSpendingCustomers(5);
            request.setAttribute("topCustomers", topCustomers);

        } catch (Exception e) {
            request.setAttribute("bestSellers", new ArrayList<>());
            request.setAttribute("categorySales", new ArrayList<>());
            request.setAttribute("topCustomers", new ArrayList<>());
        }
    }

    private void loadRecentActivities(HttpServletRequest request) throws SQLException {
        try {
            // Recent bills
            Date today = Date.valueOf(LocalDate.now());
            List<Bill> recentBills = billService.getBillsByDateRange(today, today);
            request.setAttribute("recentBills", recentBills.size() > 5 ?
                    recentBills.subList(0, 5) : recentBills);

            // Recent customers
            List<Customer> recentCustomers = customerService.getAllCustomers();
            recentCustomers.sort((c1, c2) -> {
                if (c2.getCreatedAt() == null) return -1;
                if (c1.getCreatedAt() == null) return 1;
                return c2.getCreatedAt().compareTo(c1.getCreatedAt());
            });
            request.setAttribute("recentCustomers", recentCustomers.size() > 5 ?
                    recentCustomers.subList(0, 5) : recentCustomers);

        } catch (Exception e) {
            request.setAttribute("recentBills", new ArrayList<>());
            request.setAttribute("recentCustomers", new ArrayList<>());
        }
    }

    private void calculatePerformanceMetrics(HttpServletRequest request) throws SQLException {
        try {
            // Sales growth
            BigDecimal salesGrowth = calculateSalesGrowth();
            request.setAttribute("salesGrowth", salesGrowth);

            // Active customers
            int activeCustomers = calculateActiveCustomers();
            request.setAttribute("activeCustomers", activeCustomers);

            // Conversion rate (bills per customer)
            int totalCustomers = (int) request.getAttribute("totalCustomers");
            int monthBills = (int) request.getAttribute("monthBills");

            BigDecimal conversionRate = BigDecimal.ZERO;
            if (totalCustomers > 0) {
                conversionRate = new BigDecimal(monthBills)
                        .divide(new BigDecimal(totalCustomers), 2, RoundingMode.HALF_UP)
                        .multiply(new BigDecimal(100));
            }
            request.setAttribute("conversionRate", conversionRate);

        } catch (Exception e) {
            request.setAttribute("salesGrowth", BigDecimal.ZERO);
            request.setAttribute("activeCustomers", 0);
            request.setAttribute("conversionRate", BigDecimal.ZERO);
        }
    }

    private void setAlertFlags(HttpServletRequest request) {
        try {
            List<Item> lowStockItems = (List<Item>) request.getAttribute("lowStockItems");
            int outOfStockCount = (int) request.getAttribute("outOfStockCount");
            boolean hasNewCustomers = checkNewCustomersToday();

            request.setAttribute("hasLowStock", lowStockItems != null && !lowStockItems.isEmpty());
            request.setAttribute("hasOutOfStock", outOfStockCount > 0);
            request.setAttribute("hasNewCustomers", hasNewCustomers);
            request.setAttribute("hasItems", (int) request.getAttribute("totalItems") > 0);
            request.setAttribute("hasCustomers", (int) request.getAttribute("totalCustomers") > 0);

        } catch (Exception e) {
            request.setAttribute("hasLowStock", false);
            request.setAttribute("hasOutOfStock", false);
            request.setAttribute("hasNewCustomers", false);
        }
    }

    private BigDecimal getYesterdaySales() throws SQLException {
        Date yesterday = Date.valueOf(LocalDate.now().minusDays(1));
        Map<String, BigDecimal> stats = billService.getSalesStatistics(yesterday, yesterday);
        return stats.getOrDefault("totalRevenue", BigDecimal.ZERO);
    }

    private BigDecimal calculateDailyGrowth(BigDecimal today, BigDecimal yesterday) {
        if (yesterday.compareTo(BigDecimal.ZERO) == 0) {
            return today.compareTo(BigDecimal.ZERO) > 0 ? new BigDecimal(100) : BigDecimal.ZERO;
        }
        return today.subtract(yesterday)
                .divide(yesterday, 2, RoundingMode.HALF_UP)
                .multiply(new BigDecimal(100));
    }

    private BigDecimal calculateSalesGrowth() throws SQLException {
        try {
            LocalDate now = LocalDate.now();
            Date thisMonthStart = Date.valueOf(now.withDayOfMonth(1));
            Date thisMonthEnd = Date.valueOf(now.withDayOfMonth(now.lengthOfMonth()));

            LocalDate lastMonth = now.minusMonths(1);
            Date lastMonthStart = Date.valueOf(lastMonth.withDayOfMonth(1));
            Date lastMonthEnd = Date.valueOf(lastMonth.withDayOfMonth(lastMonth.lengthOfMonth()));

            Map<String, BigDecimal> thisMonthStats = billService.getSalesStatistics(thisMonthStart, thisMonthEnd);
            Map<String, BigDecimal> lastMonthStats = billService.getSalesStatistics(lastMonthStart, lastMonthEnd);

            BigDecimal thisMonthSales = thisMonthStats.getOrDefault("totalRevenue", BigDecimal.ZERO);
            BigDecimal lastMonthSales = lastMonthStats.getOrDefault("totalRevenue", BigDecimal.ZERO);

            if (lastMonthSales.compareTo(BigDecimal.ZERO) > 0) {
                return thisMonthSales.subtract(lastMonthSales)
                        .divide(lastMonthSales, 2, RoundingMode.HALF_UP)
                        .multiply(new BigDecimal(100));
            }
            return BigDecimal.ZERO;
        } catch (Exception e) {
            return BigDecimal.ZERO;
        }
    }

    private int calculateActiveCustomers() throws SQLException {
        try {
            Date thirtyDaysAgo = Date.valueOf(LocalDate.now().minusDays(30));
            Date today = Date.valueOf(LocalDate.now());

            List<Bill> recentBills = billService.getBillsByDateRange(thirtyDaysAgo, today);
            return (int) recentBills.stream()
                    .map(Bill::getCustomerId)
                    .distinct()
                    .count();
        } catch (Exception e) {
            return 0;
        }
    }

    private boolean checkNewCustomersToday() throws SQLException {
        try {
            List<Customer> customers = customerService.getAllCustomers();
            LocalDate today = LocalDate.now();

            return customers.stream()
                    .anyMatch(c -> c.getCreatedAt() != null &&
                            c.getCreatedAt().toLocalDateTime().toLocalDate().equals(today));
        } catch (Exception e) {
            return false;
        }
    }

    private List<Map<String, Object>> getTopSpendingCustomers(int limit) throws SQLException {
        List<Map<String, Object>> topCustomers = new ArrayList<>();

        try {
            List<Customer> customers = customerService.getAllCustomers();
            Map<Integer, BigDecimal> customerSpending = new HashMap<>();

            // Calculate total spending per customer
            for (Customer customer : customers) {
                List<Bill> customerBills = billService.getBillsByCustomer(customer.getCustomerId());
                BigDecimal totalSpent = customerBills.stream()
                        .filter(b -> "PAID".equals(b.getPaymentStatus()))
                        .map(Bill::getTotalAmount)
                        .reduce(BigDecimal.ZERO, BigDecimal::add);

                if (totalSpent.compareTo(BigDecimal.ZERO) > 0) {
                    customerSpending.put(customer.getCustomerId(), totalSpent);
                }
            }

            // Sort and get top customers
            customerSpending.entrySet().stream()
                    .sorted(Map.Entry.<Integer, BigDecimal>comparingByValue().reversed())
                    .limit(limit)
                    .forEach(entry -> {
                        try {
                            Customer customer = customerService.getCustomerById(entry.getKey());
                            Map<String, Object> customerData = new HashMap<>();
                            customerData.put("customerId", customer.getCustomerId());
                            customerData.put("customerName", customer.getName());
                            customerData.put("totalSpent", entry.getValue());
                            customerData.put("membershipType", customer.getMembershipType());
                            topCustomers.add(customerData);
                        } catch (Exception e) {
                            // Skip if customer not found
                        }
                    });

        } catch (Exception e) {
            e.printStackTrace();
        }

        return topCustomers;
    }

    private void prepareChartData(HttpServletRequest request) throws SQLException {
        try {
            // Last 7 days sales data
            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd");
            StringBuilder dates = new StringBuilder("[");
            StringBuilder sales = new StringBuilder("[");
            StringBuilder bills = new StringBuilder("[");

            for (int i = 6; i >= 0; i--) {
                LocalDate date = today.minusDays(i);
                Date sqlDate = Date.valueOf(date);

                Map<String, BigDecimal> dayStats = billService.getSalesStatistics(sqlDate, sqlDate);
                BigDecimal daySales = dayStats.getOrDefault("totalRevenue", BigDecimal.ZERO);
                BigDecimal dayBills = dayStats.getOrDefault("totalBills", BigDecimal.ZERO);

                if (i < 6) {
                    dates.append(",");
                    sales.append(",");
                    bills.append(",");
                }
                dates.append("'").append(date.format(formatter)).append("'");
                sales.append(daySales);
                bills.append(dayBills);
            }

            dates.append("]");
            sales.append("]");
            bills.append("]");

            request.setAttribute("chartDates", dates.toString());
            request.setAttribute("chartSales", sales.toString());
            request.setAttribute("chartBills", bills.toString());

        } catch (Exception e) {
            request.setAttribute("chartDates", "[]");
            request.setAttribute("chartSales", "[]");
            request.setAttribute("chartBills", "[]");
        }
    }

    private void setDefaultValues(HttpServletRequest request) {
        request.setAttribute("totalCustomers", 0);
        request.setAttribute("regularCustomers", 0);
        request.setAttribute("premiumCustomers", 0);
        request.setAttribute("vipCustomers", 0);
        request.setAttribute("newCustomersThisMonth", 0);
        request.setAttribute("totalItems", 0);
        request.setAttribute("totalStock", 0);
        request.setAttribute("lowStockCount", 0);
        request.setAttribute("outOfStockCount", 0);
        request.setAttribute("categoriesCount", 0);
        request.setAttribute("inventoryValue", BigDecimal.ZERO);
        request.setAttribute("discountedInventoryValue", BigDecimal.ZERO);
        request.setAttribute("inventorySavings", BigDecimal.ZERO);
        request.setAttribute("todaysSales", BigDecimal.ZERO);
        request.setAttribute("yesterdaySales", BigDecimal.ZERO);
        request.setAttribute("monthSales", BigDecimal.ZERO);
        request.setAttribute("todaysBills", 0);
        request.setAttribute("monthBills", 0);
        request.setAttribute("averageBillToday", BigDecimal.ZERO);
        request.setAttribute("averageBillMonth", BigDecimal.ZERO);
        request.setAttribute("salesGrowth", BigDecimal.ZERO);
        request.setAttribute("dailyGrowth", BigDecimal.ZERO);
        request.setAttribute("activeCustomers", 0);
        request.setAttribute("conversionRate", BigDecimal.ZERO);
        request.setAttribute("hasLowStock", false);
        request.setAttribute("hasOutOfStock", false);
        request.setAttribute("hasNewCustomers", false);
        request.setAttribute("hasItems", false);
        request.setAttribute("hasCustomers", false);
        request.setAttribute("bestSellers", new ArrayList<>());
        request.setAttribute("categorySales", new ArrayList<>());
        request.setAttribute("topCustomers", new ArrayList<>());
        request.setAttribute("recentBills", new ArrayList<>());
        request.setAttribute("recentCustomers", new ArrayList<>());
        request.setAttribute("lowStockItems", new ArrayList<>());
        request.setAttribute("chartDates", "[]");
        request.setAttribute("chartSales", "[]");
        request.setAttribute("chartBills", "[]");
    }

    @Override
    public String getServletInfo() {
        return "Dashboard Servlet for Book Shop Management System";
    }
}
