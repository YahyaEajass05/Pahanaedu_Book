<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate New Bill - Pahana Edu </title>
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

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Page Header */
        .page-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem;
            border-radius: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            animation: slideInDown 0.6s ease-out;
        }

        @keyframes slideInDown {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .page-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        /* Billing Container */
        .billing-container {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 2rem;
        }

        .billing-form {
            background: var(--bg-secondary);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: var(--shadow-md);
            animation: slideInLeft 0.6s ease-out;
        }

        @keyframes slideInLeft {
            from {
                transform: translateX(-20px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .bill-summary {
            position: sticky;
            top: 100px;
            background: var(--bg-secondary);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: var(--shadow-md);
            height: fit-content;
            animation: slideInRight 0.6s ease-out;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(20px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        /* Form Sections */
        .form-section {
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid var(--border-color);
        }

        .form-section:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: var(--primary-color);
        }

        /* Form Controls */
        .form-group {
            margin-bottom: 1.5rem;
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

        select.form-control {
            cursor: pointer;
        }

        /* Customer Info Card */
        .customer-info-card {
            background: var(--bg-primary);
            padding: 1rem;
            border-radius: 0.75rem;
            margin-top: 1rem;
            display: none;
            animation: fadeIn 0.5s ease-out;
        }

        .customer-info-card.show {
            display: block;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            font-size: 0.875rem;
        }

        .info-label {
            color: var(--text-secondary);
        }

        .info-value {
            font-weight: 600;
            color: var(--text-primary);
        }

        .membership-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.25rem 0.75rem;
            border-radius: 0.5rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .membership-regular {
            background: rgba(107, 114, 128, 0.1);
            color: var(--text-secondary);
        }

        .membership-premium {
            background: rgba(139, 92, 246, 0.1);
            color: #8B5CF6;
        }

        .membership-vip {
            background: rgba(236, 72, 153, 0.1);
            color: var(--secondary-color);
        }

        /* Items Section */
        .items-container {
            margin-top: 1rem;
        }

        .item-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr auto;
            gap: 1rem;
            margin-bottom: 1rem;
            padding: 1rem;
            background: var(--bg-primary);
            border-radius: 0.75rem;
            align-items: center;
            animation: fadeInUp 0.5s ease-out;
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(10px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .item-total {
            font-weight: 600;
            color: var(--text-primary);
        }

        .btn-remove-item {
            padding: 0.5rem 0.75rem;
            background: var(--danger-gradient);
            color: white;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-remove-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
        }

        .btn-add-item {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: var(--success-gradient);
            color: white;
            border: none;
            border-radius: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }

        .btn-add-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3);
        }

        /* Bill Summary */
        .summary-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .summary-header h2 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        .summary-header i {
            font-size: 1.75rem;
            color: var(--primary-color);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            font-size: 0.875rem;
        }

        .summary-row.total {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-top: 1rem;
            padding-top: 1.5rem;
            border-top: 2px solid var(--border-color);
        }

        .discount-text {
            color: var(--success-color);
        }

        .tax-text {
            color: var(--warning-color);
        }

        /* Payment Section */
        .payment-methods {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            margin-top: 1rem;
        }

        .payment-method {
            position: relative;
            cursor: pointer;
        }

        .payment-method input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .payment-method label {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem;
            border: 2px solid var(--border-color);
            border-radius: 0.75rem;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .payment-method input[type="radio"]:checked + label {
            border-color: var(--primary-color);
            background: rgba(99, 102, 241, 0.05);
        }

        .payment-method label:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .payment-method i {
            font-size: 1.5rem;
            color: var(--primary-color);
        }

        /* Loyalty Points */
        .loyalty-input-group {
            display: flex;
            gap: 1rem;
            align-items: flex-end;
        }

        .loyalty-input-group .form-group {
            flex: 1;
            margin-bottom: 0;
        }

        .loyalty-value {
            padding: 0.75rem 1rem;
            background: var(--bg-primary);
            border-radius: 0.75rem;
            font-weight: 600;
            color: var(--success-color);
        }

        /* Action Buttons */
        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

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
            flex: 1;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }

        .btn-secondary {
            background: var(--secondary-gradient);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(236, 72, 153, 0.3);
        }

        /* Notifications */
        .notification {
            padding: 1.25rem 2rem;
            border-radius: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: slideInRight 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .notification-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .notification-error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        /* Loading State */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .loading-overlay.show {
            display: flex;
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 5px solid rgba(255, 255, 255, 0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .billing-container {
                grid-template-columns: 1fr;
            }

            .bill-summary {
                position: static;
            }
        }

        @media (max-width: 768px) {
            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }

            .navbar-nav {
                flex-wrap: wrap;
                justify-content: center;
            }

            .item-row {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }

            .payment-methods {
                grid-template-columns: 1fr;
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
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    List<Item> items = (List<Item>) request.getAttribute("items");
    List<String> categories = (List<String>) request.getAttribute("categories");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String discountPolicy = (String) request.getAttribute("discountPolicy");
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
        <h1><i class="fas fa-file-invoice"></i> Generate New Bill</h1>
        <p>Create a new sales bill for customers</p>
    </div>

    <div class="billing-container">
        <!-- Billing Form -->
        <form id="billingForm" action="${pageContext.request.contextPath}/generateBill" method="POST" class="billing-form">
            <input type="hidden" name="action" value="generate">

            <!-- Customer Section -->
            <div class="form-section">
                <h2 class="section-title">
                    <i class="fas fa-user"></i> Customer Information
                </h2>

                <div class="form-group">
                    <label for="customerId">Select Customer *</label>
                    <select id="customerId" name="customerId" class="form-control" required>
                        <option value="">-- Select Customer --</option>
                        <% if (customers != null) {
                            for (Customer customer : customers) { %>
                        <option value="<%= customer.getCustomerId() %>">
                            <%= customer.getName() %> - <%= customer.getPhone() %>
                        </option>
                        <% }
                        } %>
                    </select>
                </div>

                <div id="customerInfoCard" class="customer-info-card">
                    <div class="info-row">
                        <span class="info-label">Email:</span>
                        <span class="info-value" id="customerEmail">-</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Membership:</span>
                        <span class="info-value" id="customerMembership">-</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Loyalty Points:</span>
                        <span class="info-value" id="customerPoints">-</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Total Purchases:</span>
                        <span class="info-value" id="customerPurchases">-</span>
                    </div>
                </div>
            </div>

            <!-- Items Section -->
            <div class="form-section">
                <h2 class="section-title">
                    <i class="fas fa-shopping-cart"></i> Bill Items
                </h2>

                <div id="itemsContainer" class="items-container">
                    <!-- Initial item row will be added by JavaScript -->
                </div>

                <button type="button" class="btn-add-item" id="addItemBtn">
                    <i class="fas fa-plus"></i> Add Another Item
                </button>
            </div>

            <!-- Payment Section -->
            <div class="form-section">
                <h2 class="section-title">
                    <i class="fas fa-credit-card"></i> Payment Information
                </h2>

                <div class="form-group">
                    <label>Payment Method</label>
                    <div class="payment-methods">
                        <div class="payment-method">
                            <input type="radio" id="cash" name="paymentMethod" value="CASH" checked>
                            <label for="cash">
                                <i class="fas fa-money-bill"></i>
                                <span>Cash</span>
                            </label>
                        </div>
                        <div class="payment-method">
                            <input type="radio" id="card" name="paymentMethod" value="CARD">
                            <label for="card">
                                <i class="fas fa-credit-card"></i>
                                <span>Card</span>
                            </label>
                        </div>
                        <div class="payment-method">
                            <input type="radio" id="online" name="paymentMethod" value="ONLINE">
                            <label for="online">
                                <i class="fas fa-globe"></i>
                                <span>Online</span>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Redeem Loyalty Points</label>
                    <div class="loyalty-input-group">
                        <div class="form-group">
                            <input type="number" id="loyaltyPointsToRedeem" name="loyaltyPointsToRedeem"
                                   class="form-control" min="0" value="0">
                        </div>
                        <div class="loyalty-value">
                            Value: Rs. <span id="loyaltyValue">0.00</span>
                        </div>
                    </div>
                    <small style="color: var(--text-secondary);">1 point = Rs. 0.10</small>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="button" class="btn btn-secondary" onclick="previewBill()">
                    <i class="fas fa-eye"></i> Preview
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i> Generate Bill
                </button>
            </div>
        </form>

        <!-- Bill Summary -->
        <div class="bill-summary">
            <div class="summary-header">
                <i class="fas fa-calculator"></i>
                <h2>Bill Summary</h2>
            </div>

            <div id="summaryContent">
                <div class="summary-row">
                    <span>Subtotal:</span>
                    <span>Rs. <span id="subtotal">0.00</span></span>
                </div>
                <div class="summary-row">
                    <span class="discount-text">Item Discount:</span>
                    <span class="discount-text">- Rs. <span id="itemDiscount">0.00</span></span>
                </div>
                <div class="summary-row">
                    <span class="discount-text">Membership Discount:</span>
                    <span class="discount-text">- Rs. <span id="memberDiscount">0.00</span></span>
                </div>
                <div class="summary-row">
                    <span class="discount-text">Loyalty Discount:</span>
                    <span class="discount-text">- Rs. <span id="loyaltyDiscount">0.00</span></span>
                </div>
                <div class="summary-row">
                    <span class="tax-text">Tax (8%):</span>
                    <span class="tax-text">+ Rs. <span id="tax">0.00</span></span>
                </div>
                <div class="summary-row total">
                    <span>Total Amount:</span>
                    <span>Rs. <span id="totalAmount">0.00</span></span>
                </div>
            </div>

            <% if (discountPolicy != null && !discountPolicy.isEmpty()) { %>
            <div style="margin-top: 2rem; padding-top: 2rem; border-top: 2px solid var(--border-color);">
                <h3 style="font-size: 1rem; margin-bottom: 1rem; color: var(--text-secondary);">
                    <i class="fas fa-info-circle"></i> Discount Policy
                </h3>
                <pre style="font-size: 0.75rem; color: var(--text-secondary); white-space: pre-wrap;"><%= discountPolicy %></pre>
            </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div id="loadingOverlay" class="loading-overlay">
    <div class="loading-spinner"></div>
</div>

<script>
    // Global variables
    let itemCounter = 0;
    let customerData = {};
    const contextPath = '<%= request.getContextPath() %>';

    // Available items data
    const availableItems = [
        <% if (items != null) {
            for (int i = 0; i < items.size(); i++) {
                Item item = items.get(i);
        %>
        {
            itemId: '<%= item.getItemId() %>',
            itemName: '<%= item.getItemName().replace("'", "\\'") %>',
            price: <%= item.getPrice() %>,
            stock: <%= item.getStock() %>,
            discount: <%= item.getDiscountPercentage() %>
        }<%= i < items.size() - 1 ? "," : "" %>
        <% }
        } %>
    ];

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        // Add first item row
        addItemRow();

        // Set up event listeners
        document.getElementById('customerId').addEventListener('change', loadCustomerDetails);
        document.getElementById('loyaltyPointsToRedeem').addEventListener('input', updateLoyaltyValue);
        document.getElementById('addItemBtn').addEventListener('click', addItemRow);

        // Form submission
        document.getElementById('billingForm').addEventListener('submit', handleFormSubmit);
    });

    // Add new item row
    function addItemRow() {
        const itemsContainer = document.getElementById('itemsContainer');
        const newRow = document.createElement('div');
        newRow.className = 'item-row';
        newRow.setAttribute('data-row', itemCounter);

        let optionsHTML = '<option value="">-- Select Item --</option>';
        availableItems.forEach(item => {
            optionsHTML += '<option value="' + item.itemId + '" ' +
                'data-price="' + item.price + '" ' +
                'data-stock="' + item.stock + '" ' +
                'data-discount="' + item.discount + '">' +
                item.itemName + ' - Rs. ' + item.price.toFixed(2) +
                '</option>';
        });

        newRow.innerHTML =
            '<div>' +
            '<select name="itemId[]" class="form-control item-select" onchange="handleItemChange(this)" required>' +
            optionsHTML +
            '</select>' +
            '</div>' +
            '<div>' +
            '<input type="number" name="quantity[]" class="form-control quantity-input" ' +
            'placeholder="Qty" min="1" oninput="handleQuantityChange(this)" required>' +
            '</div>' +
            '<div>' +
            '<input type="number" name="discount[]" class="form-control discount-input" ' +
            'placeholder="Extra %" min="0" max="100" step="0.01" oninput="handleDiscountChange(this)">' +
            '</div>' +
            '<div class="item-total">Rs. <span class="total-amount">0.00</span></div>' +
            '<button type="button" class="btn-remove-item" onclick="removeItem(' + itemCounter + ')">' +
            '<i class="fas fa-trash"></i>' +
            '</button>';

        itemsContainer.appendChild(newRow);
        itemCounter++;
    }

    // Remove item row
    function removeItem(rowId) {
        const row = document.querySelector('[data-row="' + rowId + '"]');
        const allRows = document.querySelectorAll('.item-row');

        if (allRows.length > 1) {
            row.remove();
            calculateBillSummary();
        } else {
            alert('At least one item is required!');
        }
    }

    // Handle item selection change
    function handleItemChange(selectElement) {
        const row = selectElement.closest('.item-row');
        const quantityInput = row.querySelector('.quantity-input');
        const discountInput = row.querySelector('.discount-input');

        if (selectElement.value) {
            const selectedOption = selectElement.options[selectElement.selectedIndex];
            const stock = parseInt(selectedOption.getAttribute('data-stock'));
            const discount = parseFloat(selectedOption.getAttribute('data-discount'));

            quantityInput.max = stock;
            quantityInput.value = 1;

            if (!discountInput.value) {
                discountInput.value = discount || 0;
            }
        }

        calculateItemTotal(row);
        calculateBillSummary();
    }

    // Handle quantity change
    function handleQuantityChange(input) {
        const row = input.closest('.item-row');
        const itemSelect = row.querySelector('.item-select');

        if (itemSelect.value) {
            const selectedOption = itemSelect.options[itemSelect.selectedIndex];
            const stock = parseInt(selectedOption.getAttribute('data-stock'));

            if (parseInt(input.value) > stock) {
                input.value = stock;
                alert('Only ' + stock + ' items available in stock!');
            }
        }

        calculateItemTotal(row);
        calculateBillSummary();
    }

    // Handle discount change
    function handleDiscountChange(input) {
        if (parseFloat(input.value) > 100) {
            input.value = 100;
        }
        if (parseFloat(input.value) < 0) {
            input.value = 0;
        }

        const row = input.closest('.item-row');
        calculateItemTotal(row);
        calculateBillSummary();
    }

    // Calculate item total
    function calculateItemTotal(row) {
        const itemSelect = row.querySelector('.item-select');
        const quantityInput = row.querySelector('.quantity-input');
        const discountInput = row.querySelector('.discount-input');
        const totalSpan = row.querySelector('.total-amount');

        if (itemSelect.value && quantityInput.value) {
            const selectedOption = itemSelect.options[itemSelect.selectedIndex];
            const price = parseFloat(selectedOption.getAttribute('data-price'));
            const quantity = parseInt(quantityInput.value) || 0;
            const discount = parseFloat(discountInput.value) || 0;

            const subtotal = price * quantity;
            const discountAmount = subtotal * (discount / 100);
            const total = subtotal - discountAmount;

            totalSpan.textContent = total.toFixed(2);
        } else {
            totalSpan.textContent = '0.00';
        }
    }

    // Calculate bill summary
    function calculateBillSummary() {
        let subtotal = 0;
        let itemDiscountTotal = 0;

        // Calculate items total
        document.querySelectorAll('.item-row').forEach(function(row) {
            const itemSelect = row.querySelector('.item-select');
            const quantityInput = row.querySelector('.quantity-input');
            const discountInput = row.querySelector('.discount-input');

            if (itemSelect.value && quantityInput.value) {
                const selectedOption = itemSelect.options[itemSelect.selectedIndex];
                const price = parseFloat(selectedOption.getAttribute('data-price'));
                const quantity = parseInt(quantityInput.value) || 0;
                const discount = parseFloat(discountInput.value) || 0;

                const itemSubtotal = price * quantity;
                subtotal += itemSubtotal;
                itemDiscountTotal += itemSubtotal * (discount / 100);
            }
        });

        // Get membership discount
        let membershipDiscount = 0;
        if (customerData && customerData.membershipType) {
            const membershipDiscountPercent = getMembershipDiscountPercent(customerData.membershipType);
            membershipDiscount = (subtotal - itemDiscountTotal) * (membershipDiscountPercent / 100);
        }

        // Get loyalty discount
        const loyaltyPoints = parseInt(document.getElementById('loyaltyPointsToRedeem').value) || 0;
        const loyaltyDiscount = loyaltyPoints * 0.10;

        // Calculate totals
        const totalDiscount = itemDiscountTotal + membershipDiscount + loyaltyDiscount;
        const discountedAmount = Math.max(0, subtotal - totalDiscount);
        const tax = discountedAmount * 0.08; // 8% tax
        const totalAmount = discountedAmount + tax;

        // Update summary display
        document.getElementById('subtotal').textContent = subtotal.toFixed(2);
        document.getElementById('itemDiscount').textContent = itemDiscountTotal.toFixed(2);
        document.getElementById('memberDiscount').textContent = membershipDiscount.toFixed(2);
        document.getElementById('loyaltyDiscount').textContent = loyaltyDiscount.toFixed(2);
        document.getElementById('tax').textContent = tax.toFixed(2);
        document.getElementById('totalAmount').textContent = totalAmount.toFixed(2);
    }

    // Get membership discount percentage
    function getMembershipDiscountPercent(type) {
        const discounts = {
            'REGULAR': 0,
            'PREMIUM': 5,
            'VIP': 10
        };
        return discounts[type] || 0;
    }

    // Load customer details
    function loadCustomerDetails() {
        const customerId = document.getElementById('customerId').value;
        const customerInfoCard = document.getElementById('customerInfoCard');

        if (!customerId) {
            customerInfoCard.classList.remove('show');
            customerData = {};
            calculateBillSummary();
            return;
        }

        showLoading();

        // Make AJAX request
        fetch(contextPath + '/billAjax?action=getCustomerDetails&customerId=' + customerId)
            .then(response => response.json())
            .then(data => {
                hideLoading();
                if (data.success) {
                    customerData = data;

                    // Update customer info display
                    document.getElementById('customerEmail').textContent = data.email || '-';
                    document.getElementById('customerMembership').innerHTML = getMembershipBadge(data.membershipType);
                    document.getElementById('customerPoints').textContent = data.loyaltyPoints || 0;
                    document.getElementById('customerPurchases').textContent = 'Rs. ' + (parseFloat(data.totalPurchases) || 0).toFixed(2);

                    // Update loyalty points max
                    document.getElementById('loyaltyPointsToRedeem').max = data.loyaltyPoints || 0;

                    // Show customer info card
                    customerInfoCard.classList.add('show');

                    // Recalculate bill
                    calculateBillSummary();
                } else {
                    alert('Failed to load customer details');
                    customerData = {};
                }
            })
            .catch(error => {
                hideLoading();
                console.error('Error loading customer details:', error);
                alert('Error loading customer details');
            });
    }

    // Get membership badge HTML
    function getMembershipBadge(type) {
        const badges = {
            'REGULAR': '<span class="membership-badge membership-regular"><i class="fas fa-user"></i> Regular</span>',
            'PREMIUM': '<span class="membership-badge membership-premium"><i class="fas fa-star"></i> Premium</span>',
            'VIP': '<span class="membership-badge membership-vip"><i class="fas fa-crown"></i> VIP</span>'
        };
        return badges[type] || badges['REGULAR'];
    }

    // Update loyalty value
    function updateLoyaltyValue() {
        const points = parseInt(document.getElementById('loyaltyPointsToRedeem').value) || 0;
        const value = points * 0.10;

        document.getElementById('loyaltyValue').textContent = value.toFixed(2);

        // Check if points are valid
        if (customerData && customerData.loyaltyPoints && points > customerData.loyaltyPoints) {
            document.getElementById('loyaltyPointsToRedeem').value = customerData.loyaltyPoints;
            alert('Cannot redeem more points than available!');
        }

        calculateBillSummary();
    }

    // Preview bill
    function previewBill() {
        if (!validateForm()) {
            return;
        }

        // Change action to preview
        const form = document.getElementById('billingForm');
        const actionInput = form.querySelector('input[name="action"]');
        actionInput.value = 'preview';
        form.submit();
    }

    // Validate form
    function validateForm() {
        const customerId = document.getElementById('customerId').value;
        if (!customerId) {
            alert('Please select a customer!');
            return false;
        }

        let hasValidItem = false;
        let allItemsValid = true;

        document.querySelectorAll('.item-row').forEach(function(row) {
            const itemSelect = row.querySelector('.item-select');
            const quantityInput = row.querySelector('.quantity-input');

            if (itemSelect.value && quantityInput.value) {
                hasValidItem = true;

                // Check stock
                const selectedOption = itemSelect.options[itemSelect.selectedIndex];
                const stock = parseInt(selectedOption.getAttribute('data-stock'));
                const quantity = parseInt(quantityInput.value);

                if (quantity > stock) {
                    allItemsValid = false;
                    itemSelect.style.borderColor = 'var(--danger-color)';
                    quantityInput.style.borderColor = 'var(--danger-color)';
                } else {
                    itemSelect.style.borderColor = '';
                    quantityInput.style.borderColor = '';
                }
            }
        });

        if (!hasValidItem) {
            alert('Please add at least one item to the bill!');
            return false;
        }

        if (!allItemsValid) {
            alert('Some items exceed available stock. Please check highlighted items.');
            return false;
        }

        // Check if total amount is positive
        const totalAmount = parseFloat(document.getElementById('totalAmount').textContent);
        if (totalAmount <= 0) {
            alert('Bill total must be greater than zero!');
            return false;
        }

        return true;
    }

    // Handle form submission
    function handleFormSubmit(e) {
        if (!validateForm()) {
            e.preventDefault();
            return false;
        }

        // Show loading
        showLoading();

        // Clear any saved draft
        clearDraft();

        return true;
    }

    // Show loading overlay
    function showLoading() {
        document.getElementById('loadingOverlay').classList.add('show');
    }

    // Hide loading overlay
    function hideLoading() {
        document.getElementById('loadingOverlay').classList.remove('show');
    }

    // Auto-save draft functionality
    let autoSaveTimer;

    function autoSaveDraft() {
        clearTimeout(autoSaveTimer);
        autoSaveTimer = setTimeout(function() {
            const formData = {
                customerId: document.getElementById('customerId').value,
                loyaltyPointsToRedeem: document.getElementById('loyaltyPointsToRedeem').value,
                paymentMethod: document.querySelector('input[name="paymentMethod"]:checked').value,
                items: []
            };

            document.querySelectorAll('.item-row').forEach(function(row) {
                const itemSelect = row.querySelector('.item-select');
                const quantityInput = row.querySelector('.quantity-input');
                const discountInput = row.querySelector('.discount-input');

                if (itemSelect.value) {
                    formData.items.push({
                        itemId: itemSelect.value,
                        quantity: quantityInput.value,
                        discount: discountInput.value
                    });
                }
            });

            localStorage.setItem('billDraft', JSON.stringify(formData));
            console.log('Draft saved');
        }, 2000);
    }

    // Load draft if exists
    function loadDraft() {
        const draft = localStorage.getItem('billDraft');
        if (draft) {
            try {
                const data = JSON.parse(draft);

                if (confirm('A draft bill was found. Do you want to load it?')) {
                    // Set customer
                    if (data.customerId) {
                        document.getElementById('customerId').value = data.customerId;
                        loadCustomerDetails();
                    }

                    // Set loyalty points
                    if (data.loyaltyPointsToRedeem) {
                        document.getElementById('loyaltyPointsToRedeem').value = data.loyaltyPointsToRedeem;
                        updateLoyaltyValue();
                    }

                    // Set payment method
                    if (data.paymentMethod) {
                        document.querySelector('input[name="paymentMethod"][value="' + data.paymentMethod + '"]').checked = true;
                    }

                    // Clear existing items and add draft items
                    document.getElementById('itemsContainer').innerHTML = '';
                    itemCounter = 0;

                    if (data.items && data.items.length > 0) {
                        data.items.forEach(function(item) {
                            addItemRow();
                            const lastRow = document.querySelector('[data-row="' + (itemCounter - 1) + '"]');
                            lastRow.querySelector('.item-select').value = item.itemId;
                            handleItemChange(lastRow.querySelector('.item-select'));
                            lastRow.querySelector('.quantity-input').value = item.quantity;
                            lastRow.querySelector('.discount-input').value = item.discount;
                            calculateItemTotal(lastRow);
                        });
                    } else {
                        addItemRow();
                    }

                    calculateBillSummary();
                } else {
                    clearDraft();
                }
            } catch (e) {
                console.error('Error loading draft:', e);
                clearDraft();
            }
        }
    }

    // Clear draft
    function clearDraft() {
        localStorage.removeItem('billDraft');
    }

    // Set up auto-save listeners
    document.addEventListener('DOMContentLoaded', function() {
        // Load draft on page load
        loadDraft();

        // Add auto-save listeners
        document.getElementById('customerId').addEventListener('change', autoSaveDraft);
        document.getElementById('loyaltyPointsToRedeem').addEventListener('input', autoSaveDraft);

        document.querySelectorAll('input[name="paymentMethod"]').forEach(function(radio) {
            radio.addEventListener('change', autoSaveDraft);
        });

        // Use MutationObserver to watch for new item rows
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.type === 'childList') {
                    mutation.addedNodes.forEach(function(node) {
                        if (node.classList && node.classList.contains('item-row')) {
                            const selects = node.querySelectorAll('select, input');
                            selects.forEach(function(element) {
                                element.addEventListener('change', autoSaveDraft);
                                element.addEventListener('input', autoSaveDraft);
                            });
                        }
                    });
                }
            });
        });

        observer.observe(document.getElementById('itemsContainer'), {
            childList: true
        });
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl + S to save/generate
        if (e.ctrlKey && e.key === 's') {
            e.preventDefault();
            document.getElementById('billingForm').submit();
        }

        // Ctrl + P to preview
        if (e.ctrlKey && e.key === 'p') {
            e.preventDefault();
            previewBill();
        }

        // Ctrl + N to add new item
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            addItemRow();
        }

        // Escape to clear form
        if (e.key === 'Escape') {
            if (confirm('Clear the form and start over?')) {
                document.getElementById('billingForm').reset();
                document.getElementById('itemsContainer').innerHTML = '';
                itemCounter = 0;
                addItemRow();
                document.getElementById('customerInfoCard').classList.remove('show');
                customerData = {};
                calculateBillSummary();
                clearDraft();
            }
        }
    });

    // Handle success message
    if (window.location.search.includes('success=true')) {
        clearDraft();
    }

    // Auto-hide notifications
    setTimeout(function() {
        const notifications = document.querySelectorAll('.notification');
        notifications.forEach(function(notif) {
            notif.style.opacity = '0';
            notif.style.transition = 'opacity 0.3s ease';
            setTimeout(function() {
                notif.style.display = 'none';
            }, 300);
        });
    }, 5000);
</script>

</body>
</html>
