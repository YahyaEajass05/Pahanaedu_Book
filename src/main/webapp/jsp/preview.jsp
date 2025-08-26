<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.BillItem" %>
<%@ page import="com.pahanaedu.service.BillService.BillCalculation" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Preview - BookStore Pro</title>
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem;
            animation: fadeIn 0.8s ease-out;
        }

        /* Preview Card */
        .preview-card {
            background: var(--bg-secondary);
            border-radius: 1.5rem;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            animation: slideInUp 0.6s ease-out;
        }

        @keyframes slideInUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* Preview Header */
        .preview-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .preview-header h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .preview-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        /* Store Info */
        .store-info {
            text-align: center;
            padding: 2rem;
            border-bottom: 2px solid var(--border-color);
        }

        .store-logo {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .store-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .store-details {
            color: var(--text-secondary);
            font-size: 0.875rem;
            line-height: 1.6;
        }

        /* Bill Details */
        .bill-details {
            padding: 2rem;
        }

        .detail-section {
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
        }

        .detail-section:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-title i {
            color: var(--primary-color);
        }

        /* Customer Info */
        .customer-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            font-size: 0.875rem;
        }

        .detail-label {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .detail-value {
            color: var(--text-primary);
            font-weight: 600;
        }

        /* Items Table */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .items-table thead {
            background: var(--bg-primary);
        }

        .items-table th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .items-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.875rem;
        }

        .items-table tbody tr:last-child td {
            border-bottom: none;
        }

        .item-name {
            font-weight: 600;
            color: var(--text-primary);
        }

        .item-price {
            color: var(--text-secondary);
        }

        .item-discount {
            color: var(--success-color);
            font-weight: 600;
        }

        .item-total {
            font-weight: 700;
            color: var(--text-primary);
        }

        /* Summary Section */
        .summary-section {
            background: var(--bg-primary);
            padding: 1.5rem;
            border-radius: 1rem;
            margin-top: 1.5rem;
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
            padding-top: 1rem;
            border-top: 2px solid var(--border-color);
        }

        .discount-text {
            color: var(--success-color);
        }

        .tax-text {
            color: var(--warning-color);
        }

        /* Payment Info */
        .payment-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: var(--bg-primary);
            border-radius: 0.75rem;
            margin-top: 1rem;
        }

        .payment-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--primary-gradient);
            color: white;
            border-radius: 0.75rem;
            font-size: 1.5rem;
        }

        .payment-details {
            flex: 1;
        }

        .payment-method {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .payment-status {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            padding: 2rem;
            background: var(--bg-primary);
            border-top: 2px solid var(--border-color);
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
            flex: 1;
            justify-content: center;
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

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(236, 72, 153, 0.3);
        }

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(239, 68, 68, 0.3);
        }

        /* Membership Badge */
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

        /* Loading */
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

        /* Print Styles */
        @media print {
            .navbar, .action-buttons, .btn {
                display: none !important;
            }

            body {
                background: white;
            }

            .preview-card {
                box-shadow: none;
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }

            .customer-details {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .items-table {
                font-size: 0.75rem;
            }

            .items-table th,
            .items-table td {
                padding: 0.5rem;
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
    Customer customer = (Customer) request.getAttribute("customer");
    List<BillItem> billItems = (List<BillItem>) request.getAttribute("billItems");
    BillCalculation calculation = (BillCalculation) request.getAttribute("calculation");
    Integer loyaltyPointsToRedeem = (Integer) request.getAttribute("loyaltyPointsToRedeem");
    String paymentMethod = (String) request.getAttribute("paymentMethod");

    // Format date
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
    Date currentDate = new Date();
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            <i class="fas fa-book-open"></i>
            BookStore Pro
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
    <div class="preview-card">
        <!-- Preview Header -->
        <div class="preview-header">
            <h1><i class="fas fa-file-invoice"></i> Bill Preview</h1>
            <p>Review the bill details before confirming</p>
        </div>

        <!-- Store Info -->
        <div class="store-info">
            <div class="store-logo">
                <i class="fas fa-book-open"></i>
            </div>
            <div class="store-name">Book Paradise</div>
            <div class="store-details">
                123 Book Street, Reading City<br>
                Phone: +94 11 2345678 | Email: info@bookparadise.lk<br>
                <small>Date: <%= dateFormat.format(currentDate) %> | Time: <%= timeFormat.format(currentDate) %></small>
            </div>
        </div>

        <!-- Bill Details -->
        <div class="bill-details">
            <!-- Customer Information -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-user"></i> Customer Information
                </h3>

                <% if (customer != null) { %>
                <div class="customer-details">
                    <div>
                        <div class="detail-row">
                            <span class="detail-label">Name:</span>
                            <span class="detail-value"><%= customer.getName() %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Phone:</span>
                            <span class="detail-value"><%= customer.getPhone() %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Email:</span>
                            <span class="detail-value"><%= customer.getEmail() %></span>
                        </div>
                    </div>
                    <div>
                        <div class="detail-row">
                            <span class="detail-label">Address:</span>
                            <span class="detail-value"><%= customer.getAddress() %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Membership:</span>
                            <span class="detail-value">
                                <% String membershipType = customer.getMembershipType(); %>
                                <% if ("PREMIUM".equals(membershipType)) { %>
                                    <span class="membership-badge membership-premium">
                                        <i class="fas fa-star"></i> Premium
                                    </span>
                                <% } else if ("VIP".equals(membershipType)) { %>
                                    <span class="membership-badge membership-vip">
                                        <i class="fas fa-crown"></i> VIP
                                    </span>
                                <% } else { %>
                                    <span class="membership-badge membership-regular">
                                        <i class="fas fa-user"></i> Regular
                                    </span>
                                <% } %>
                            </span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Loyalty Points:</span>
                            <span class="detail-value"><%= customer.getLoyaltyPoints() %> points</span>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Items -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-shopping-cart"></i> Items
                </h3>

                <table class="items-table">
                    <thead>
                    <tr>
                        <th>Item</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Discount</th>
                        <th>Total</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% if (billItems != null && !billItems.isEmpty()) {
                        for (BillItem item : billItems) { %>
                    <tr>
                        <td class="item-name"><%= item.getItemName() %></td>
                        <td class="item-price">Rs. <%= String.format("%.2f", item.getUnitPrice()) %></td>
                        <td><%= item.getQuantity() %></td>
                        <td class="item-discount">
                            <% if (item.getDiscountPercentage() != null && item.getDiscountPercentage().compareTo(BigDecimal.ZERO) > 0) { %>
                            <%= item.getDiscountPercentage() %>%
                            <% } else { %>
                            -
                            <% } %>
                        </td>
                        <td class="item-total">Rs. <%= String.format("%.2f", item.getTotalPrice()) %></td>
                    </tr>
                    <% }
                    } %>
                    </tbody>
                </table>
            </div>

            <!-- Summary -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-calculator"></i> Bill Summary
                </h3>

                <% if (calculation != null) { %>
                <div class="summary-section">
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span>Rs. <%= String.format("%.2f", calculation.subtotal) %></span>
                    </div>

                    <% if (calculation.itemDiscountAmount.compareTo(BigDecimal.ZERO) > 0) { %>
                    <div class="summary-row">
                        <span class="discount-text">Item Discount:</span>
                        <span class="discount-text">- Rs. <%= String.format("%.2f", calculation.itemDiscountAmount) %></span>
                    </div>
                    <% } %>

                    <% if (calculation.membershipDiscountAmount.compareTo(BigDecimal.ZERO) > 0) { %>
                    <div class="summary-row">
                        <span class="discount-text">Membership Discount:</span>
                        <span class="discount-text">- Rs. <%= String.format("%.2f", calculation.membershipDiscountAmount) %></span>
                    </div>
                    <% } %>

                    <% if (loyaltyPointsToRedeem != null && loyaltyPointsToRedeem > 0) { %>
                    <div class="summary-row">
                        <span class="discount-text">Loyalty Points (<%= loyaltyPointsToRedeem %> points):</span>
                        <span class="discount-text">- Rs. <%= String.format("%.2f", calculation.loyaltyDiscountAmount) %></span>
                    </div>
                    <% } %>

                    <div class="summary-row">
                        <span class="tax-text">Tax (8%):</span>
                        <span class="tax-text">+ Rs. <%= String.format("%.2f", calculation.taxAmount) %></span>
                    </div>

                    <div class="summary-row total">
                        <span>Total Amount:</span>
                        <span>Rs. <%= String.format("%.2f", calculation.totalAmount) %></span>
                    </div>

                    <% if (calculation.loyaltyPointsEarned > 0) { %>
                    <div class="summary-row" style="color: var(--success-color); margin-top: 1rem;">
                        <span>Loyalty Points to Earn:</span>
                        <span><%= calculation.loyaltyPointsEarned %> points</span>
                    </div>
                    <% } %>
                </div>
                <% } %>

                <!-- Payment Info -->
                <div class="payment-info">
                    <div class="payment-icon">
                        <% if ("CASH".equals(paymentMethod)) { %>
                        <i class="fas fa-money-bill"></i>
                        <% } else if ("CARD".equals(paymentMethod)) { %>
                        <i class="fas fa-credit-card"></i>
                        <% } else { %>
                        <i class="fas fa-globe"></i>
                        <% } %>
                    </div>
                    <div class="payment-details">
                        <div class="payment-method">
                            Payment Method:
                            <%= "CASH".equals(paymentMethod) ? "Cash" :
                                    "CARD".equals(paymentMethod) ? "Credit/Debit Card" : "Online Payment" %>
                        </div>
                        <div class="payment-status">Status: Pending</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <form action="${pageContext.request.contextPath}/generateBill" method="POST" style="flex: 1;">
                <input type="hidden" name="action" value="confirm">
                <input type="hidden" name="customerId" value="<%= customer != null ? customer.getCustomerId() : "" %>">
                <input type="hidden" name="loyaltyPointsToRedeem" value="<%= loyaltyPointsToRedeem != null ? loyaltyPointsToRedeem : 0 %>">
                <input type="hidden" name="paymentMethod" value="<%= paymentMethod %>">

                <% if (billItems != null) {
                    for (BillItem item : billItems) { %>
                <input type="hidden" name="itemId[]" value="<%= item.getItemId() %>">
                <input type="hidden" name="quantity[]" value="<%= item.getQuantity() %>">
                <input type="hidden" name="discount[]" value="<%= item.getDiscountPercentage() %>">
                <% }
                } %>

                <button type="submit" class="btn btn-primary" onclick="showLoading()">
                    <i class="fas fa-check"></i> Confirm & Generate Bill
                </button>
            </form>

            <button type="button" class="btn btn-secondary" onclick="window.history.back()">
                <i class="fas fa-edit"></i> Edit Bill
            </button>

            <button type="button" class="btn btn-danger" onclick="cancelBill()">
                <i class="fas fa-times"></i> Cancel
            </button>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div id="loadingOverlay" class="loading-overlay">
    <div class="loading-spinner"></div>
</div>

<script>
    // Show loading overlay
    function showLoading() {
        document.getElementById('loadingOverlay').classList.add('show');
    }

    // Hide loading overlay
    function hideLoading() {
        document.getElementById('loadingOverlay').classList.remove('show');
    }

    // Cancel bill
    function cancelBill() {
        if (confirm('Are you sure you want to cancel this bill? All data will be lost.')) {
            window.location.href = '${pageContext.request.contextPath}/generateBill';
        }
    }

    // Print preview
    function printPreview() {
        window.print();
    }

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl + P to print
        if (e.ctrlKey && e.key === 'p') {
            e.preventDefault();
            printPreview();
        }

        // Enter to confirm
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            document.querySelector('.btn-primary').click();
        }

        // Escape to go back
        if (e.key === 'Escape') {
            e.preventDefault();
            window.history.back();
        }
    });

    // Add animation on load
    document.addEventListener('DOMContentLoaded', function() {
        const sections = document.querySelectorAll('.detail-section');
        sections.forEach((section, index) => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(20px)';

            setTimeout(() => {
                section.style.transition = 'all 0.5s ease';
                section.style.opacity = '1';
                section.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });

    // Auto-calculate remaining balance if needed
    function calculateBalance() {
        const totalAmount = <%= calculation != null ? calculation.totalAmount : 0 %>;
        // This can be extended to show cash tendered and balance
    }
</script>

</body>
</html>
