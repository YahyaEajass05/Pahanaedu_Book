<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.pahanaedu.model.Bill" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Bills - Pahana Edu </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        :root {
            /* Modern Purple & Blue Theme for Bookshop */
            --primary-color: #6366F1;
            --primary-dark: #4F46E5;
            --primary-light: #818CF8;
            --secondary-color: #EC4899;
            --secondary-dark: #DB2777;
            --accent-color: #14B8A6;
            --success-color: #10B981;
            --warning-color: #F59E0B;
            --danger-color: #EF4444;
            --info-color: #3B82F6;

            /* Gradients */
            --primary-gradient: linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%);
            --secondary-gradient: linear-gradient(135deg, #EC4899 0%, #F472B6 100%);
            --success-gradient: linear-gradient(135deg, #10B981 0%, #14B8A6 100%);
            --danger-gradient: linear-gradient(135deg, #EF4444 0%, #F87171 100%);
            --warning-gradient: linear-gradient(135deg, #F59E0B 0%, #FCD34D 100%);
            --dark-gradient: linear-gradient(135deg, #1F2937 0%, #374151 100%);

            /* Background Colors */
            --bg-primary: #F9FAFB;
            --bg-secondary: #FFFFFF;
            --bg-dark: #111827;
            --border-color: #E5E7EB;
            --text-primary: #1F2937;
            --text-secondary: #6B7280;
            --text-light: #9CA3AF;

            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* Animated Background */
        .bg-animation {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            opacity: 0.05;
            background-image:
                    radial-gradient(circle at 20% 80%, var(--primary-color) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, var(--secondary-color) 0%, transparent 50%),
                    radial-gradient(circle at 40% 40%, var(--accent-color) 0%, transparent 50%);
            animation: bgMove 20s ease-in-out infinite;
        }

        @keyframes bgMove {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(-20px, -20px) scale(1.1); }
            66% { transform: translate(20px, -20px) scale(0.9); }
        }

        /* Navigation Bar */
        .navbar {
            background: var(--bg-secondary);
            box-shadow: var(--shadow-md);
            position: sticky;
            top: 0;
            z-index: 1000;
            animation: slideDown 0.5s ease-out;
        }

        @keyframes slideDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .navbar-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            transition: transform 0.3s ease;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .navbar-brand i {
            font-size: 2rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .navbar-nav {
            display: flex;
            list-style: none;
            gap: 0.5rem;
            align-items: center;
        }

        .nav-link {
            padding: 0.75rem 1.25rem;
            text-decoration: none;
            color: var(--text-secondary);
            font-weight: 500;
            border-radius: 0.75rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--primary-gradient);
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .nav-link:hover {
            color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
        }

        .nav-link:hover::before {
            transform: translateX(0);
        }

        .nav-link.active {
            color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
        }

        .nav-link.logout {
            color: var(--danger-color);
        }

        .nav-link.logout:hover {
            background: rgba(239, 68, 68, 0.1);
        }

        /* Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
            animation: fadeIn 0.8s ease-out;
        }

        /* Page Header */
        .page-header {
            background: var(--bg-secondary);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: slideInDown 0.6s ease-out;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .page-title h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        .page-title i {
            font-size: 2.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Quick Stats */
        .bill-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--bg-secondary);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0.75rem;
            font-size: 1.5rem;
            color: white;
        }

        .stat-icon.primary { background: var(--primary-gradient); }
        .stat-icon.success { background: var(--success-gradient); }
        .stat-icon.warning { background: var(--warning-gradient); }
        .stat-icon.info { background: var(--info-gradient); }

        .stat-info h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .stat-info p {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        /* Filter Section */
        .filter-section {
            background: var(--bg-secondary);
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: var(--shadow-sm);
            margin-bottom: 2rem;
            animation: slideInUp 0.6s ease-out;
        }

        .filter-form {
            display: flex;
            gap: 1rem;
            align-items: flex-end;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
        }

        .form-group label {
            display: block;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid var(--border-color);
            border-radius: 0.75rem;
            font-family: 'Poppins', sans-serif;
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 0.75rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }

        .btn-secondary {
            background: var(--secondary-gradient);
            color: white;
        }

        .btn-success {
            background: var(--success-gradient);
            color: white;
        }

        .btn-export {
            background: var(--info-gradient);
            color: white;
        }

        /* Search Bar */
        .search-bar {
            display: flex;
            gap: 0.5rem;
            flex: 1;
            max-width: 400px;
        }

        .search-bar input {
            flex: 1;
        }

        /* Bills Table */
        .bills-table-wrapper {
            background: var(--bg-secondary);
            border-radius: 1rem;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
        }

        .table-header {
            background: var(--primary-gradient);
            color: white;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-header h2 {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .bills-table {
            width: 100%;
            border-collapse: collapse;
        }

        .bills-table th {
            background: var(--bg-primary);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid var(--border-color);
        }

        .bills-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.875rem;
        }

        .bills-table tr {
            transition: all 0.3s ease;
        }

        .bills-table tr:hover {
            background: var(--bg-primary);
        }

        .bill-number {
            font-weight: 600;
            color: var(--primary-color);
        }

        .customer-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .customer-name {
            font-weight: 600;
            color: var(--text-primary);
        }

        .customer-phone {
            font-size: 0.75rem;
            color: var(--text-secondary);
        }

        .amount {
            font-weight: 700;
            color: var(--text-primary);
        }

        .payment-method {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.25rem 0.75rem;
            border-radius: 0.5rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .payment-cash {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .payment-card {
            background: rgba(59, 130, 246, 0.1);
            color: var(--info-color);
        }

        .payment-online {
            background: rgba(139, 92, 246, 0.1);
            color: #8B5CF6;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.25rem 0.75rem;
            border-radius: 0.5rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-paid {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .status-cancelled {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn-action {
            padding: 0.5rem;
            border: none;
            background: none;
            cursor: pointer;
            color: var(--text-secondary);
            font-size: 1rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            background: var(--bg-primary);
            color: var(--primary-color);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            animation: fadeIn 0.8s ease-out;
        }

        .empty-icon {
            font-size: 5rem;
            color: var(--text-light);
            margin-bottom: 1rem;
        }

        .empty-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .empty-text {
            color: var(--text-secondary);
            margin-bottom: 2rem;
        }

        /* Notification */
        .notification {
            padding: 1.25rem 2rem;
            border-radius: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: slideInRight 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
        }

        .notification-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .notification-error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        /* Loading */
        .loading {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid var(--border-color);
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }

            .page-header {
                flex-direction: column;
                gap: 1rem;
            }

            .filter-form {
                flex-direction: column;
            }

            .bills-table-wrapper {
                overflow-x: auto;
            }

            .bills-table {
                min-width: 700px;
            }
        }
    </style>
</head>
<body>
<div class="bg-animation"></div>

<%
    // Check if user is logged in
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    // Get data from request
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    BigDecimal todaysSales = (BigDecimal) request.getAttribute("todaysSales");
    Map<String, Object> billStats = (Map<String, Object>) request.getAttribute("billStats");
    BigDecimal totalAmount = (BigDecimal) request.getAttribute("totalAmount");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String searchTerm = (String) request.getAttribute("searchTerm");
    Boolean isToday = (Boolean) request.getAttribute("isToday");

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            <i class="fas fa-book-open"></i>
            Pahana Edu
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                <i class="fas fa-chart-line"></i> Dashboard
            </a></li>
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link">
                <i class="fas fa-users"></i> Customers
            </a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link">
                <i class="fas fa-books"></i> Books
            </a></li>
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link active">
                <i class="fas fa-cash-register"></i> Billing
            </a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link">
                <i class="fas fa-question-circle"></i> Help
            </a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- Notifications -->
    <% if (successMessage != null && !successMessage.isEmpty()) { %>
    <div class="notification notification-success">
        <i class="fas fa-check-circle"></i>
        <span><%= successMessage %></span>
    </div>
    <% } %>

    <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
    <div class="notification notification-error">
        <i class="fas fa-exclamation-circle"></i>
        <span><%= errorMessage %></span>
    </div>
    <% } %>

    <!-- Page Header -->
    <div class="page-header">
        <div class="page-title">
            <i class="fas fa-file-invoice-dollar"></i>
            <h1><%= isToday != null && isToday ? "Today's Sales" : (searchTerm != null ? "Search Results" : "Sales Bills") %></h1>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/generateBill" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i> New Bill
            </a>
            <button onclick="exportBills()" class="btn btn-export">
                <i class="fas fa-download"></i> Export
            </button>
        </div>
    </div>

    <!-- Quick Stats -->
    <% if (isToday == null || !isToday) { %>
    <div class="bill-stats">
        <div class="stat-card">
            <div class="stat-icon primary">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <div class="stat-info">
                <h3><%= todaysSales != null ? String.format("%.2f", todaysSales) : "0.00" %></h3>
                <p>Today's Sales</p>
            </div>
        </div>

        <% if (billStats != null) { %>
        <div class="stat-card">
            <div class="stat-icon success">
                <i class="fas fa-chart-line"></i>
            </div>
            <div class="stat-info">
                <h3><%= billStats.get("monthSales") != null ? String.format("%.2f", billStats.get("monthSales")) : "0.00" %></h3>
                <p>Monthly Sales</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon warning">
                <i class="fas fa-receipt"></i>
            </div>
            <div class="stat-info">
                <h3><%= billStats.get("todayBills") != null ? billStats.get("todayBills") : "0" %></h3>
                <p>Bills Today</p>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon info">
                <i class="fas fa-percentage"></i>
            </div>
            <div class="stat-info">
                <h3><%= billStats.get("averageBillToday") != null ? String.format("%.2f", billStats.get("averageBillToday")) : "0.00" %></h3>
                <p>Average Bill</p>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>

    <!-- Filter Section -->
    <div class="filter-section">
        <form action="${pageContext.request.contextPath}/bill" method="get" class="filter-form">
            <div class="form-group">
                <label>Start Date</label>
                <input type="date" name="startDate" class="form-control"
                       value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>">
            </div>
            <div class="form-group">
                <label>End Date</label>
                <input type="date" name="endDate" class="form-control"
                       value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>">
            </div>
            <div class="form-group">
                <label>Status</label>
                <select name="status" class="form-control">
                    <option value="ALL">All Status</option>
                    <option value="PAID" <%= "PAID".equals(request.getParameter("status")) ? "selected" : "" %>>Paid</option>
                    <option value="PENDING" <%= "PENDING".equals(request.getParameter("status")) ? "selected" : "" %>>Pending</option>
                    <option value="CANCELLED" <%= "CANCELLED".equals(request.getParameter("status")) ? "selected" : "" %>>Cancelled</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-filter"></i> Filter
            </button>
            <a href="${pageContext.request.contextPath}/bill?action=today" class="btn btn-success">
                <i class="fas fa-calendar-day"></i> Today
            </a>
        </form>

        <!-- Search Bar -->
        <form action="${pageContext.request.contextPath}/bill" method="get" class="search-bar" style="margin-top: 1rem;">
            <input type="hidden" name="action" value="search">
            <input type="text" name="q" placeholder="Search by bill number, customer name or phone..."
                   class="form-control" value="<%= searchTerm != null ? searchTerm : "" %>">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>

    <!-- Bills Table -->
    <div class="bills-table-wrapper">
        <div class="table-header">
            <h2>
                <i class="fas fa-list"></i>
                <%= searchTerm != null ? "Search Results" : "Bill List" %>
                <% if (bills != null && !bills.isEmpty()) { %>
                (<%= bills.size() %> records)
                <% } %>
            </h2>
            <% if (totalAmount != null && totalAmount.compareTo(BigDecimal.ZERO) > 0) { %>
            <span>Total: Rs. <%= String.format("%.2f", totalAmount) %></span>
            <% } %>
        </div>

        <% if (bills != null && !bills.isEmpty()) { %>
        <table class="bills-table">
            <thead>
            <tr>
                <th>Bill #</th>
                <th>Date & Time</th>
                <th>Customer</th>
                <th>Items</th>
                <th>Amount</th>
                <th>Payment</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Bill bill : bills) { %>
            <tr>
                <td>
                    <span class="bill-number"><%= bill.getBillNumber() %></span>
                </td>
                <td>
                    <div>
                        <div><%= dateFormat.format(bill.getBillDate()) %></div>
                        <small class="text-secondary"><%= timeFormat.format(bill.getBillDate()) %></small>
                    </div>
                </td>
                <td>
                    <div class="customer-info">
                        <span class="customer-name"><%= bill.getCustomerName() != null ? bill.getCustomerName() : "N/A" %></span>
                        <span class="customer-phone"><%= bill.getCustomerPhone() != null ? bill.getCustomerPhone() : "" %></span>
                    </div>
                </td>
                <td>
                    <span><%= bill.getTotalItems() %> items</span>
                </td>
                <td>
                    <span class="amount">Rs. <%= String.format("%.2f", bill.getTotalAmount()) %></span>
                </td>
                <td>
                        <span class="payment-method payment-<%= bill.getPaymentMethod().toLowerCase() %>">
                            <i class="fas fa-<%= bill.getPaymentMethod().equals("CASH") ? "money-bill" :
                                               bill.getPaymentMethod().equals("CARD") ? "credit-card" : "globe" %>"></i>
                            <%= bill.getPaymentMethodDisplay() %>
                        </span>
                </td>
                <td>
                        <span class="status-badge status-<%= bill.getPaymentStatus().toLowerCase() %>">
                            <i class="fas fa-<%= bill.getPaymentStatus().equals("PAID") ? "check-circle" :
                                               bill.getPaymentStatus().equals("PENDING") ? "clock" : "times-circle" %>"></i>
                            <%= bill.getPaymentStatus() %>
                        </span>
                </td>
                <td>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/bill?action=view&billId=<%= bill.getBillId() %>"
                           class="btn-action" title="View Details">
                            <i class="fas fa-eye"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/bill?action=print&billId=<%= bill.getBillId() %>"
                           class="btn-action" title="Print Bill" target="_blank">
                            <i class="fas fa-print"></i>
                        </a>
                        <% if ("PAID".equals(bill.getPaymentStatus())) { %>
                        <a href="${pageContext.request.contextPath}/bill?action=return&billId=<%= bill.getBillId() %>"
                           class="btn-action" title="Return Items">
                            <i class="fas fa-undo"></i>
                        </a>
                        <% } %>
                        <% if (!"CANCELLED".equals(bill.getPaymentStatus())) { %>
                        <button onclick="cancelBill(<%= bill.getBillId() %>)"
                                class="btn-action" title="Cancel Bill">
                            <i class="fas fa-times"></i>
                        </button>
                        <% } %>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <div class="empty-state">
            <i class="fas fa-file-invoice empty-icon"></i>
            <h2 class="empty-title">No Bills Found</h2>
            <p class="empty-text">
                <%= searchTerm != null ? "No bills match your search criteria." :
                        "No bills have been generated yet. Create your first bill!" %>
            </p>
            <a href="${pageContext.request.contextPath}/generateBill" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i> Generate New Bill
            </a>
        </div>
        <% } %>
    </div>
</div>

<script>
    // Auto-hide notifications after 5 seconds
    setTimeout(function() {
        const notifications = document.querySelectorAll('.notification');
        notifications.forEach(function(notif) {
            notif.style.opacity = '0';
            setTimeout(function() {
                notif.remove();
            }, 300);
        });
    }, 5000);

    // Cancel bill function
    function cancelBill(billId) {
        if (confirm('Are you sure you want to cancel this bill? This action cannot be undone.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/bill';

            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'cancel';

            const billIdInput = document.createElement('input');
            billIdInput.type = 'hidden';
            billIdInput.name = 'billId';
            billIdInput.value = billId;

            form.appendChild(actionInput);
            form.appendChild(billIdInput);
            document.body.appendChild(form);
            form.submit();
        }
    }

    // Export bills function
    function exportBills() {
        const startDate = document.querySelector('input[name="startDate"]').value;
        const endDate = document.querySelector('input[name="endDate"]').value;

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/bill';

        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'export';

        if (startDate) {
            const startInput = document.createElement('input');
            startInput.type = 'hidden';
            startInput.name = 'startDate';
            startInput.value = startDate;
            form.appendChild(startInput);
        }

        if (endDate) {
            const endInput = document.createElement('input');
            endInput.type = 'hidden';
            endInput.name = 'endDate';
            endInput.value = endDate;
            form.appendChild(endInput);
        }

        form.appendChild(actionInput);
        document.body.appendChild(form);
        form.submit();

        setTimeout(function() {
            form.remove();
        }, 1000);
    }

    // Add keyboard shortcut for new bill (Ctrl + N)
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            window.location.href = '${pageContext.request.contextPath}/generateBill';
        }
    });

    // Add table row click handler
    document.querySelectorAll('.bills-table tbody tr').forEach(function(row) {
        row.style.cursor = 'pointer';
        row.addEventListener('click', function(e) {
            // Don't navigate if clicking on action buttons
            if (!e.target.closest('.action-buttons')) {
                const billId = this.querySelector('.bill-number').textContent;
                // You can navigate to bill details or do something else
                console.log('Clicked on bill:', billId);
            }
        });
    });
</script>

</body>
</html>
