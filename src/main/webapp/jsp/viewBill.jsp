<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.model.Bill" %>
<%@ page import="com.pahanaedu.model.BillItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bill - Pahana Edu </title>
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

        /* Bill Card */
        .bill-card {
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

        /* Bill Header */
        .bill-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .bill-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 30s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .bill-header-content {
            position: relative;
            z-index: 1;
        }

        .bill-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .bill-date {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .bill-status {
            position: absolute;
            top: 2rem;
            right: 2rem;
            padding: 0.5rem 1.5rem;
            border-radius: 2rem;
            font-weight: 600;
            font-size: 0.875rem;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }

        /* Store Info */
        .store-info {
            text-align: center;
            padding: 2rem;
            border-bottom: 2px solid var(--border-color);
            background: var(--bg-primary);
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

        /* Bill Content */
        .bill-content {
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

        /* Customer Details */
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

        /* Loyalty Points Info */
        .loyalty-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-top: 1rem;
        }

        .loyalty-card {
            padding: 1rem;
            background: var(--bg-primary);
            border-radius: 0.75rem;
            text-align: center;
        }

        .loyalty-card i {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .loyalty-earned {
            color: var(--success-color);
        }

        .loyalty-redeemed {
            color: var(--warning-color);
        }

        .loyalty-value {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .loyalty-label {
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
            flex-wrap: wrap;
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
            min-width: 150px;
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

        .btn-success {
            background: var(--success-gradient);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3);
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

        /* Status Badge */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
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

        /* Print Styles */
        @media print {
            .navbar, .action-buttons, .btn {
                display: none !important;
            }

            body {
                background: white;
            }

            .bill-card {
                box-shadow: none;
                border: 1px solid #ddd;
            }

            .bill-header {
                background: #f0f0f0 !important;
                color: #333 !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
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

            .loyalty-info {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
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

    // Get bill data
    Bill bill = (Bill) request.getAttribute("bill");
    String successMessage = (String) request.getAttribute("successMessage");

    if (bill == null) {
        response.sendRedirect(request.getContextPath() + "/bill?error=Bill not found");
        return;
    }

    // Format dates
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
    SimpleDateFormat fullDateFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
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
    <% if (successMessage != null && !successMessage.isEmpty()) { %>
    <div class="notification notification-success">
        <i class="fas fa-check-circle"></i>
        <span><%= successMessage %></span>
    </div>
    <% } %>

    <div class="bill-card">
        <!-- Bill Header -->
        <div class="bill-header">
            <div class="bill-header-content">
                <h1 class="bill-number">Bill #<%= bill.getBillNumber() %></h1>
                <p class="bill-date">
                    <i class="fas fa-calendar"></i> <%= fullDateFormat.format(bill.getBillDate()) %>
                </p>
                <% String status = bill.getPaymentStatus(); %>
                <span class="bill-status">
                    <% if ("PAID".equals(status)) { %>
                        <i class="fas fa-check-circle"></i> PAID
                    <% } else if ("PENDING".equals(status)) { %>
                        <i class="fas fa-clock"></i> PENDING
                    <% } else { %>
                        <i class="fas fa-times-circle"></i> CANCELLED
                    <% } %>
                </span>
            </div>
        </div>

        <!-- Store Info -->
        <div class="store-info">
            <div class="store-logo">
                <i class="fas fa-book-open"></i>
            </div>
            <div class="store-name">Book Paradise</div>
            <div class="store-details">
                103 Galle Road , Dehiwala<br>
                Phone: +94 11 2345678 | Email: info@pahanaedu.lk<br>
                <small>web: ww.pahanaedu.lk | Reg No: Reg19875</small>
            </div>
        </div>

        <!-- Bill Content -->
        <div class="bill-content">
            <!-- Customer Information -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-user"></i> Customer Information
                </h3>

                <div class="customer-details">
                    <div>
                        <div class="detail-row">
                            <span class="detail-label">Name:</span>
                            <span class="detail-value"><%= bill.getCustomerName() %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Phone:</span>
                            <span class="detail-value"><%= bill.getCustomerPhone() %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Email:</span>
                            <span class="detail-value"><%= bill.getCustomerEmail() %></span>
                        </div>
                    </div>
                    <div>
                        <div class="detail-row">
                            <span class="detail-label">Address:</span>
                            <span class="detail-value"><%= bill.getCustomerAddress() %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label">Membership:</span>
                            <span class="detail-value">
                                <% String membershipType = bill.getMembershipType(); %>
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
                            <span class="detail-label">Available Points:</span>
                            <span class="detail-value"><%= bill.getCustomerLoyaltyPoints() %> points</span>
                        </div>
                    </div>
                </div>
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
                    <% if (bill.getBillItems() != null && !bill.getBillItems().isEmpty()) {
                        for (BillItem item : bill.getBillItems()) { %>
                    <tr>
                        <td class="item-name"><%= item.getItemName() %></td>
                        <td>Rs. <%= String.format("%.2f", item.getUnitPrice()) %></td>
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

            <!-- Bill Summary -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-calculator"></i> Bill Summary
                </h3>

                <div class="summary-section">
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span>Rs. <%= String.format("%.2f", bill.getSubtotal()) %></span>
                    </div>

                    <% if (bill.getDiscountAmount() != null && bill.getDiscountAmount().compareTo(BigDecimal.ZERO) > 0) { %>
                    <div class="summary-row">
                        <span class="discount-text">Total Discount:</span>
                        <span class="discount-text">- Rs. <%= String.format("%.2f", bill.getDiscountAmount()) %></span>
                    </div>
                    <% } %>

                    <% if (bill.getTaxAmount() != null && bill.getTaxAmount().compareTo(BigDecimal.ZERO) > 0) { %>
                    <div class="summary-row">
                        <span class="tax-text">Tax (8%):</span>
                        <span class="tax-text">+ Rs. <%= String.format("%.2f", bill.getTaxAmount()) %></span>
                    </div>
                    <% } %>

                    <div class="summary-row total">
                        <span>Total Amount:</span>
                        <span>Rs. <%= String.format("%.2f", bill.getTotalAmount()) %></span>
                    </div>
                </div>

                <!-- Payment Info -->
                <div class="payment-info">
                    <div class="payment-icon">
                        <% if ("CASH".equals(bill.getPaymentMethod())) { %>
                        <i class="fas fa-money-bill"></i>
                        <% } else if ("CARD".equals(bill.getPaymentMethod())) { %>
                        <i class="fas fa-credit-card"></i>
                        <% } else { %>
                        <i class="fas fa-globe"></i>
                        <% } %>
                    </div>
                    <div class="payment-details">
                        <div class="payment-method">
                            Payment Method: <%= bill.getPaymentMethodDisplay() %>
                        </div>
                        <div class="payment-status">
                            Status:
                            <% if ("PAID".equals(bill.getPaymentStatus())) { %>
                            <span class="status-badge status-paid">
                                    <i class="fas fa-check-circle"></i> Paid
                                </span>
                            <% } else if ("PENDING".equals(bill.getPaymentStatus())) { %>
                            <span class="status-badge status-pending">
                                    <i class="fas fa-clock"></i> Pending
                                </span>
                            <% } else { %>
                            <span class="status-badge status-cancelled">
                                    <i class="fas fa-times-circle"></i> Cancelled
                                </span>
                            <% } %>
                        </div>
                    </div>
                </div>

                <!-- Loyalty Points Info -->
                <% if (bill.getLoyaltyPointsEarned() > 0 || bill.getLoyaltyPointsRedeemed() > 0) { %>
                <div class="loyalty-info">
                    <% if (bill.getLoyaltyPointsEarned() > 0) { %>
                    <div class="loyalty-card loyalty-earned">
                        <i class="fas fa-plus-circle"></i>
                        <div class="loyalty-value"><%= bill.getLoyaltyPointsEarned() %></div>
                        <div class="loyalty-label">Points Earned</div>
                    </div>
                    <% } %>

                    <% if (bill.getLoyaltyPointsRedeemed() > 0) { %>
                    <div class="loyalty-card loyalty-redeemed">
                        <i class="fas fa-minus-circle"></i>
                        <div class="loyalty-value"><%= bill.getLoyaltyPointsRedeemed() %></div>
                        <div class="loyalty-label">Points Redeemed</div>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>

            <!-- Savings Information -->
            <%
                BigDecimal totalSavings = bill.getDiscountAmount();
                if (bill.getLoyaltyPointsRedeemed() > 0) {
                    totalSavings = totalSavings.add(new BigDecimal(bill.getLoyaltyPointsRedeemed() * 0.10));
                }
                if (totalSavings.compareTo(BigDecimal.ZERO) > 0) {
            %>
            <div class="detail-section">
                <h3 class="section-title" style="color: var(--success-color);">
                    <i class="fas fa-piggy-bank"></i> Your Savings
                </h3>
                <div style="text-align: center; font-size: 1.5rem; font-weight: 700; color: var(--success-color);">
                    You saved Rs. <%= String.format("%.2f", totalSavings) %> on this purchase!
                </div>
            </div>
            <% } %>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <button onclick="printBill()" class="btn btn-primary">
                <i class="fas fa-print"></i> Print Bill
            </button>

            <a href="${pageContext.request.contextPath}/generateBill" class="btn btn-success">
                <i class="fas fa-plus"></i> New Bill
            </a>

            <% if ("PAID".equals(bill.getPaymentStatus())) { %>
            <a href="${pageContext.request.contextPath}/bill?action=return&billId=<%= bill.getBillId() %>" class="btn btn-secondary">
                <i class="fas fa-undo"></i> Return Items
            </a>
            <% } %>

            <% if (!"CANCELLED".equals(bill.getPaymentStatus())) { %>
            <button onclick="cancelBill(<%= bill.getBillId() %>)" class="btn btn-danger">
                <i class="fas fa-times"></i> Cancel Bill
            </button>
            <% } %>

            <a href="${pageContext.request.contextPath}/bill" class="btn btn-secondary">
                <i class="fas fa-list"></i> All Bills
            </a>
        </div>
    </div>
</div>

<script>
    // Print bill
    function printBill() {
        window.print();
    }

    // Cancel bill
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

    // Auto-hide notification
    setTimeout(function() {
        const notification = document.querySelector('.notification');
        if (notification) {
            notification.style.opacity = '0';
            notification.style.transition = 'opacity 0.3s ease';
            setTimeout(function() {
                notification.style.display = 'none';
            }, 300);
        }
    }, 5000);

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl + P to print
        if (e.ctrlKey && e.key === 'p') {
            e.preventDefault();
            printBill();
        }

        // Ctrl + N for new bill
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            window.location.href = '${pageContext.request.contextPath}/generateBill';
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

        // Animate loyalty cards
        const loyaltyCards = document.querySelectorAll('.loyalty-card');
        loyaltyCards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'scale(0.8)';

            setTimeout(() => {
                card.style.transition = 'all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                card.style.opacity = '1';
                card.style.transform = 'scale(1)';
            }, 800 + (index * 200));
        });

        // Animate total amount
        animateValue('totalAmount', 0, <%= bill.getTotalAmount() %>, 1500);
    });

    // Animate numeric values
    function animateValue(elementId, start, end, duration) {
        const element = document.querySelector('.summary-row.total span:last-child');
        if (!element) return;

        let startTimestamp = null;
        const startValue = start;
        const endValue = end;

        const step = (timestamp) => {
            if (!startTimestamp) startTimestamp = timestamp;
            const progress = Math.min((timestamp - startTimestamp) / duration, 1);
            const currentValue = progress * (endValue - startValue) + startValue;
            element.textContent = 'Rs. ' + currentValue.toFixed(2);

            if (progress < 1) {
                window.requestAnimationFrame(step);
            }
        };

        window.requestAnimationFrame(step);
    }

    // Share bill via email
    function shareBillEmail() {
        const billNumber = '<%= bill.getBillNumber() %>';
        const customerEmail = '<%= bill.getCustomerEmail() %>';
        const subject = encodeURIComponent('Your Bill from Book Paradise - ' + billNumber);
        const body = encodeURIComponent('Dear Customer,\n\nThank you for your purchase at Book Paradise. Your bill number is ' + billNumber + '.\n\nPlease visit our store for any queries.\n\nBest regards,\nBook Paradise Team');

        window.location.href = 'mailto:' + customerEmail + '?subject=' + subject + '&body=' + body;
    }

    // Download bill as PDF (placeholder - would need server-side implementation)
    function downloadPDF() {
        alert('PDF download feature coming soon! Use Print option for now.');
        // In real implementation, this would call a server endpoint to generate PDF
        // window.location.href = '${pageContext.request.contextPath}/bill/download?billId=<%= bill.getBillId() %>';
    }

    // Copy bill number to clipboard
    function copyBillNumber() {
        const billNumber = '<%= bill.getBillNumber() %>';

        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(billNumber).then(() => {
                showToast('Bill number copied to clipboard!');
            }).catch(err => {
                console.error('Failed to copy:', err);
                fallbackCopyTextToClipboard(billNumber);
            });
        } else {
            fallbackCopyTextToClipboard(billNumber);
        }
    }

    // Fallback copy method for older browsers
    function fallbackCopyTextToClipboard(text) {
        const textArea = document.createElement('textarea');
        textArea.value = text;
        textArea.style.position = 'fixed';
        textArea.style.left = '-999999px';
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();

        try {
            document.execCommand('copy');
            showToast('Bill number copied to clipboard!');
        } catch (err) {
            console.error('Fallback: Unable to copy', err);
            showToast('Unable to copy bill number', 'error');
        }

        document.body.removeChild(textArea);
    }

    // Show toast notification
    function showToast(message, type = 'success') {
        const toast = document.createElement('div');
        toast.className = 'toast toast-' + type;
        toast.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + '"></i> ' + message;

        // Add toast styles
        toast.style.cssText = `
            position: fixed;
            bottom: 20px;
            right: 20px;
            padding: 1rem 1.5rem;
            background: ${type == 'success' ? 'var(--success-gradient)' : 'var(--danger-gradient)'};
            color: white;
            border-radius: 0.75rem;
            box-shadow: var(--shadow-lg);
            z-index: 1000;
            animation: slideInRight 0.5s ease-out;
        `;

        document.body.appendChild(toast);

        setTimeout(() => {
            toast.style.animation = 'slideOutRight 0.5s ease-out';
            setTimeout(() => {
                document.body.removeChild(toast);
            }, 500);
        }, 3000);
    }

    // Add slideOutRight animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);

    // Quick actions menu
    function showQuickActions() {
        const menu = document.createElement('div');
        menu.className = 'quick-actions-menu';
        menu.innerHTML = `
            <div class="quick-action-item" onclick="copyBillNumber()">
                <i class="fas fa-copy"></i> Copy Bill Number
            </div>
            <div class="quick-action-item" onclick="shareBillEmail()">
                <i class="fas fa-envelope"></i> Email Bill
            </div>
            <div class="quick-action-item" onclick="downloadPDF()">
                <i class="fas fa-file-pdf"></i> Download PDF
            </div>
        `;

        menu.style.cssText = `
            position: fixed;
            bottom: 80px;
            right: 20px;
            background: var(--bg-secondary);
            border-radius: 1rem;
            box-shadow: var(--shadow-xl);
            padding: 1rem;
            z-index: 999;
            animation: fadeInUp 0.3s ease-out;
        `;

        // Add menu item styles
        const menuItemStyle = document.createElement('style');
        menuItemStyle.textContent = `
            .quick-action-item {
                padding: 0.75rem 1rem;
                cursor: pointer;
                border-radius: 0.5rem;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                color: var(--text-primary);
                font-size: 0.875rem;
            }
            .quick-action-item:hover {
                background: var(--bg-primary);
                color: var(--primary-color);
                transform: translateX(5px);
            }
            .quick-action-item i {
                font-size: 1rem;
            }
        `;
        document.head.appendChild(menuItemStyle);

        document.body.appendChild(menu);

        // Remove menu when clicking outside
        setTimeout(() => {
            document.addEventListener('click', function removeMenu(e) {
                if (!menu.contains(e.target)) {
                    menu.style.animation = 'fadeOutDown 0.3s ease-out';
                    setTimeout(() => {
                        document.body.removeChild(menu);
                    }, 300);
                    document.removeEventListener('click', removeMenu);
                }
            });
        }, 100);
    }

    // Add floating action button for quick actions
    const fab = document.createElement('button');
    fab.className = 'fab';
    fab.innerHTML = '<i class="fas fa-ellipsis-v"></i>';
    fab.onclick = showQuickActions;
    fab.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 56px;
        height: 56px;
        border-radius: 50%;
        background: var(--primary-gradient);
        color: white;
        border: none;
        box-shadow: var(--shadow-lg);
        cursor: pointer;
        z-index: 998;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
    `;
    fab.onmouseover = function() {
        this.style.transform = 'scale(1.1)';
        this.style.boxShadow = '0 10px 20px rgba(99, 102, 241, 0.3)';
    };
    fab.onmouseout = function() {
        this.style.transform = 'scale(1)';
        this.style.boxShadow = 'var(--shadow-lg)';
    };
    document.body.appendChild(fab);

    // Add fadeOutDown animation
    const fadeOutStyle = document.createElement('style');
    fadeOutStyle.textContent = `
        @keyframes fadeOutDown {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(20px);
            }
        }
    `;
    document.head.appendChild(fadeOutStyle);

    // Calculate and show bill age
    function showBillAge() {
        const billDate = new Date('<%= bill.getBillDate() %>');
        const now = new Date();
        const diffTime = Math.abs(now - billDate);
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

        if (diffDays > 7) {
            const ageInfo = document.createElement('div');
            ageInfo.style.cssText = `
                background: rgba(245, 158, 11, 0.1);
                color: var(--warning-color);
                padding: 0.5rem 1rem;
                border-radius: 0.5rem;
                font-size: 0.875rem;
                margin-top: 1rem;
                text-align: center;
            `;
            ageInfo.innerHTML = '<i class="fas fa-info-circle"></i> This bill is ' + diffDays + ' days old';

            const storeInfo = document.querySelector('.store-info');
            if (storeInfo) {
                storeInfo.appendChild(ageInfo);
            }
        }
    }

    // Initialize bill age display
    showBillAge();

    // Enhanced print functionality
    window.addEventListener('beforeprint', function() {
        // Hide non-printable elements
        document.querySelectorAll('.fab, .quick-actions-menu').forEach(el => {
            el.style.display = 'none';
        });
    });

    window.addEventListener('afterprint', function() {
        // Restore hidden elements
        document.querySelectorAll('.fab, .quick-actions-menu').forEach(el => {
            el.style.display = '';
        });
    });
</script>

</body>
</html>
