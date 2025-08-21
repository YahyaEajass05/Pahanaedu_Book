<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Bill - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --dark-gradient: linear-gradient(135deg, #434343 0%, #000000 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
            --card-shadow: 0 15px 35px rgba(0,0,0,0.1);
            --hover-shadow: 0 25px 50px rgba(0,0,0,0.25);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Hero Header */
        .bill-hero {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            color: white;
            padding: 4rem 2rem;
            border-radius: 30px;
            margin-bottom: 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: slideInDown 0.8s ease-out;
        }

        .bill-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg, transparent, rgba(67, 233, 123, 0.3), transparent);
            animation: rotate 20s linear infinite;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-icon {
            font-size: 5rem;
            margin-bottom: 2rem;
            animation: bounce 2s infinite;
            color: rgba(255,255,255,0.9);
        }

        .bill-hero h1 {
            margin: 0 0 1rem 0;
            font-size: 3rem;
            font-weight: 800;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            animation: fadeInUp 0.8s ease-out 0.2s both;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .bill-hero p {
            margin: 0;
            font-size: 1.3rem;
            opacity: 0.9;
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        /* Main Billing Container */
        .billing-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            margin-bottom: 3rem;
        }

        .customer-selection, .billing-calculation {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: all 0.3s ease;
            animation: slideInLeft 0.8s ease-out;
        }

        .billing-calculation {
            animation: slideInRight 0.8s ease-out;
        }

        .customer-selection:hover, .billing-calculation:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .section-header {
            background: var(--secondary-gradient);
            color: white;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .section-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 15s linear infinite;
        }

        .section-header h3 {
            margin: 0;
            color: white;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.5rem;
            font-weight: 700;
            position: relative;
            z-index: 2;
        }

        .section-content, .calculation-content {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 700;
            color: #2c3e50;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .required::after {
            content: ' *';
            color: #fa709a;
            font-weight: 900;
            font-size: 1.2rem;
            animation: pulse 2s infinite;
        }

        .form-control {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid #e9ecef;
            border-radius: 15px;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            position: relative;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.3);
            transform: translateY(-2px) scale(1.02);
        }

        /* Customer Display */
        .customer-display {
            background: var(--warning-gradient);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem 0;
            display: none;
            animation: slideInUp 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .customer-display.show {
            display: block;
        }

        .customer-display::before {
            content: '';
            position: absolute;
            bottom: -30%;
            right: -20%;
            width: 100px;
            height: 100px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
        }

        .customer-info {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            position: relative;
            z-index: 2;
        }

        .customer-avatar {
            width: 70px;
            height: 70px;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(20px);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 900;
            font-size: 1.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            position: relative;
            animation: pulse 2s infinite;
        }

        .customer-avatar::after {
            content: '';
            position: absolute;
            inset: -3px;
            background: rgba(255,255,255,0.3);
            border-radius: inherit;
            z-index: -1;
            filter: blur(10px);
            opacity: 0.7;
            animation: glow 2s ease-in-out infinite alternate;
        }

        .customer-details h4 {
            margin: 0 0 0.5rem 0;
            color: white;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .customer-details p {
            margin: 0.25rem 0;
            color: rgba(255,255,255,0.9);
            font-size: 0.95rem;
        }

        /* Input Groups */
        .input-group {
            position: relative;
            margin-bottom: 2rem;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 1.2rem;
            pointer-events: none;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .form-control:focus ~ .input-icon {
            color: #fa709a;
            transform: translateY(-50%) scale(1.2);
        }

        .units-input {
            font-size: 1.3rem;
            font-weight: 700;
            text-align: center;
        }

        /* Rate Information */
        .rate-info {
            background: var(--success-gradient);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: scaleIn 0.6s ease-out;
        }

        .rate-info::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -30%;
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite reverse;
        }

        .rate-info-content {
            position: relative;
            z-index: 2;
        }

        .rate-info h4 {
            margin: 0 0 1rem 0;
            color: white;
            font-size: 1.1rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .rate-display {
            font-size: 2rem;
            font-weight: 900;
            color: white;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
        }

        /* Discount Information */
        .discount-info {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem 0;
            color: white;
            animation: slideInLeft 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .discount-info::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 7s ease-in-out infinite;
        }

        .discount-info-content {
            position: relative;
            z-index: 2;
        }

        .discount-info h5 {
            margin: 0 0 1rem 0;
            color: white;
            font-size: 1.1rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .discount-info ul {
            margin: 0;
            padding-left: 1.5rem;
            color: rgba(255,255,255,0.9);
        }

        .discount-info li {
            margin-bottom: 0.5rem;
            line-height: 1.6;
        }

        /* Calculation Breakdown */
        .calculation-breakdown {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            border-radius: 15px;
            padding: 2rem;
            margin-top: 2rem;
            display: none;
            animation: slideInUp 0.6s ease-out;
            border-left: 4px solid #667eea;
        }

        .calculation-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.75rem 0;
            transition: all 0.3s ease;
        }

        .calculation-row:hover {
            background: rgba(102, 126, 234, 0.1);
            border-radius: 8px;
            padding: 0.75rem 1rem;
        }

        .calculation-row:last-child {
            margin-bottom: 0;
        }

        .calculation-row.total {
            border-top: 2px solid #667eea;
            padding-top: 1.5rem;
            margin-top: 1.5rem;
            font-weight: 900;
            font-size: 1.3rem;
            background: var(--warning-gradient);
            color: white;
            border-radius: 10px;
            padding: 1.5rem;
            animation: pulse 2s infinite;
        }

        .calculation-row.subtotal {
            border-top: 1px solid #dee2e6;
            padding-top: 1rem;
            margin-top: 1rem;
            font-weight: 700;
        }

        .calculation-label {
            color: #6c757d;
            font-weight: 600;
        }

        .calculation-value {
            font-weight: 700;
            color: #2c3e50;
            font-size: 1.1rem;
        }

        /* Generate Actions */
        .generate-actions {
            display: flex;
            gap: 2rem;
            justify-content: center;
            margin-top: 3rem;
            padding-top: 3rem;
            border-top: 2px solid rgba(102, 126, 234, 0.2);
            animation: fadeInUp 0.6s ease-out 0.8s both;
        }

        .btn-generate {
            background: var(--warning-gradient);
            color: white;
            padding: 1.2rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            min-width: 250px;
            opacity: 0.5;
            cursor: not-allowed;
            box-shadow: var(--card-shadow);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            position: relative;
            overflow: hidden;
        }

        .btn-generate::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            transition: all 0.5s ease;
            transform: translate(-50%, -50%);
        }

        .btn-generate.enabled::before {
            width: 300px;
            height: 300px;
        }

        .btn-generate.enabled {
            opacity: 1;
            cursor: pointer;
        }

        .btn-generate.enabled:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        .btn-secondary, .btn-info {
            padding: 1.2rem 3rem;
            border-radius: 50px;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            min-width: 200px;
            box-shadow: var(--card-shadow);
        }

        .btn-secondary {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: white;
            border: 1px solid var(--glass-border);
        }

        .btn-info {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-secondary:hover, .btn-info:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        /* Bill Preview */
        .bill-preview {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: var(--card-shadow);
            padding: 3rem;
            margin-top: 3rem;
            display: none;
            animation: slideInUp 0.8s ease-out;
            transition: all 0.3s ease;
        }

        .bill-preview.show {
            display: block;
        }

        .bill-preview:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .bill-preview-header {
            text-align: center;
            margin-bottom: 3rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid #667eea;
            position: relative;
        }

        .bill-preview-header h3 {
            margin: 0;
            color: #2c3e50;
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .preview-row {
            display: flex;
            justify-content: space-between;
            padding: 1rem 0;
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
            transition: all 0.3s ease;
        }

        .preview-row:hover {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            border-radius: 8px;
            padding: 1rem;
        }

        .preview-row:last-child {
            border-bottom: none;
        }

        .preview-row.highlight {
            background: var(--success-gradient);
            color: white;
            padding: 1.5rem;
            border-radius: 15px;
            font-weight: 900;
            font-size: 1.2rem;
            margin-top: 1rem;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.3);
            position: relative;
            overflow: hidden;
        }

        .preview-row.highlight::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 5s ease-in-out infinite;
        }

        /* Loading Spinner */
        .spinner {
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        /* Animations */
        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-15px);
            }
            60% {
                transform: translateY(-7px);
            }
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }

        @keyframes glow {
            from {
                opacity: 0.7;
                filter: blur(10px);
            }
            to {
                opacity: 1;
                filter: blur(15px);
            }
        }

        @keyframes rotate {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .billing-container {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .customer-selection {
                animation: slideInUp 0.8s ease-out;
            }

            .billing-calculation {
                animation: slideInUp 0.8s ease-out 0.2s both;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .bill-hero {
                padding: 3rem 1.5rem;
            }

            .bill-hero h1 {
                font-size: 2.5rem;
                flex-direction: column;
                gap: 0.5rem;
            }

            .generate-actions {
                flex-direction: column;
                align-items: center;
                gap: 1rem;
            }

            .btn-generate, .btn-secondary, .btn-info {
                width: 100%;
                max-width: 300px;
            }

            .calculation-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .customer-info {
                flex-direction: column;
                text-align: center;
            }

            .section-content, .calculation-content {
                padding: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .hero-icon {
                font-size: 3.5rem;
            }

            .customer-avatar {
                width: 60px;
                height: 60px;
                font-size: 1.2rem;
            }

            .rate-display {
                font-size: 1.5rem;
            }
        }

        /* Focus states for accessibility */
        .form-control:focus,
        .btn-generate:focus,
        .btn-secondary:focus,
        .btn-info:focus {
            outline: 3px solid rgba(102, 126, 234, 0.5);
            outline-offset: 2px;
        }

        /* Reduced motion support */
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
    </style>
</head>
<body>
<!-- Check if user is logged in -->
    <%
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    @SuppressWarnings("unchecked")
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    if (customers == null) {
        customers = new ArrayList<>();
    }

    BigDecimal ratePerUnit = (BigDecimal) request.getAttribute("ratePerUnit");
    if (ratePerUnit == null) {
        ratePerUnit = new BigDecimal("50.00");
    }
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            Pahana Edu Management
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link">Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link">Items</a></li>
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link active">Billing</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link">Help</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- Hero Header -->
    <div class="bill-hero">
        <div class="hero-content">
            <div class="hero-icon">
                <i class="fas fa-file-invoice-dollar"></i>
            </div>
            <h1>
                <i class="fas fa-magic"></i>
                Generate Bill
            </h1>
            <p>Create a new bill for customer charges</p>
        </div>
    </div>

    <!-- Display Messages -->
        <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <i class="icon-error">✗</i>
        <%= request.getAttribute("errorMessage") %>
    </div>
        <% } %>

    <!-- Billing Form -->
    <form id="billForm" action="${pageContext.request.contextPath}/bill" method="post">
        <input type="hidden" name="action" value="generate">

        <div class="billing-container">
            <!-- Customer Selection -->
            <div class="customer-selection">
                <div class="section-header">
                    <h3>
                        <i class="fas fa-user-circle"></i>
                        Select Customer
                    </h3>
                </div>
                <div class="section-content">
                    <div class="form-group">
                        <label for="customerSelect" class="required">
                            <i class="fas fa-users"></i>
                            Customer
                        </label>
                        <div class="input-group">
                            <select id="customerSelect" name="accountNumber" class="form-control" required onchange="selectCustomer()">
                                <option value="">-- Select a customer --</option>
                                <% for (Customer customer : customers) { %>
                                <option value="<%= customer.getAccountNumber() %>"
                                        data-name="<%= customer.getName() %>"
                                        data-address="<%= customer.getAddress() %>"
                                        data-telephone="<%= customer.getTelephone() %>"
                                        data-units="<%= customer.getUnitsConsumed() %>">
                                    <%= customer.getName() %> (<%= customer.getAccountNumber() %>)
                                </option>
                                <% } %>
                            </select>
                            <span class="input-icon">
                                <i class="fas fa-user-check"></i>
                            </span>
                        </div>
                    </div>

                    <% if (customers.isEmpty()) { %>
                    <div class="alert alert-warning">
                        <i class="icon-warning">⚠️</i>
                        No customers found. <a href="${pageContext.request.contextPath}/customer?action=add">Add a customer</a> first.
                    </div>
                    <% } %>

                    <!-- Selected Customer Display -->
                    <div id="customerDisplay" class="customer-display">
                        <div class="customer-info">
                            <div class="customer-avatar" id="customerAvatar">?</div>
                            <div class="customer-details">
                                <h4 id="customerName">Customer Name</h4>
                                <p id="customerAccount"><i class="fas fa-id-card"></i> Account: </p>
                                <p id="customerAddress"><i class="fas fa-map-marker-alt"></i> Address: </p>
                                <p id="customerPhone"><i class="fas fa-phone"></i> Phone: </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Billing Calculation -->
            <div class="billing-calculation">
                <div class="section-header">
                    <h3>
                        <i class="fas fa-calculator"></i>
                        Billing Calculation
                    </h3>
                </div>
                <div class="calculation-content">
                    <!-- Rate Information -->
                    <div class="rate-info">
                        <div class="rate-info-content">
                            <h4>
                                <i class="fas fa-tag"></i>
                                Current Rate
                            </h4>
                            <div class="rate-display">LKR <%= String.format("%.2f", ratePerUnit) %> per unit</div>
                        </div>
                    </div>

                    <!-- Units Input -->
                    <div class="form-group">
                        <label for="unitsConsumed" class="required">
                            <i class="fas fa-tachometer-alt"></i>
                            Units Consumed
                        </label>
                        <div class="input-group">
                            <input type="number"
                                   id="unitsConsumed"
                                   name="unitsConsumed"
                                   class="form-control units-input"
                                   placeholder="Enter units consumed"
                                   required
                                   min="0"
                                   max="9999"
                                   onchange="calculateBill()"
                                   oninput="calculateBill()">
                            <span class="input-icon">
                                <i class="fas fa-chart-bar"></i>
                            </span>
                        </div>
                    </div>

                    <!-- Discount Information -->
                    <div class="discount-info">
                        <div class="discount-info-content">
                            <h5>
                                <i class="fas fa-percentage"></i>
                                Discount Structure
                            </h5>
                            <ul>
                                <li><i class="fas fa-gift"></i> 5% discount for 20-49 units</li>
                                <li><i class="fas fa-gift"></i> 10% discount for 50-99 units</li>
                                <li><i class="fas fa-gift"></i> 15% discount for 100+ units</li>
                            </ul>
                        </div>
                    </div>

                    <!-- Calculation Breakdown -->
                    <div id="calculationBreakdown" class="calculation-breakdown" style="display: none;">
                        <div class="calculation-row">
                            <span class="calculation-label">
                                <i class="fas fa-chart-pie"></i>
                                Units Consumed:
                            </span>
                            <span class="calculation-value" id="displayUnits">0</span>
                        </div>
                        <div class="calculation-row">
                            <span class="calculation-label">
                                <i class="fas fa-coins"></i>
                                Rate per Unit:
                            </span>
                            <span class="calculation-value">LKR <%= String.format("%.2f", ratePerUnit) %></span>
                        </div>
                        <div class="calculation-row">
                            <span class="calculation-label">
                                <i class="fas fa-calculator"></i>
                                Base Amount:
                            </span>
                            <span class="calculation-value" id="baseAmount">LKR 0.00</span>
                        </div>
                        <div class="calculation-row" id="discountRow" style="display: none;">
                            <span class="calculation-label">
                                <i class="fas fa-percent"></i>
                                Discount (<span id="discountPercent">0</span>%):
                            </span>
                            <span class="calculation-value" id="discountAmount">- LKR 0.00</span>
                        </div>
                        <div class="calculation-row subtotal">
                            <span class="calculation-label">
                                <i class="fas fa-receipt"></i>
                                Subtotal:
                            </span>
                            <span class="calculation-value" id="subtotalAmount">LKR 0.00</span>
                        </div>
                        <div class="calculation-row">
                            <span class="calculation-label">
                                <i class="fas fa-file-invoice"></i>
                                Tax (8%):
                            </span>
                            <span class="calculation-value" id="taxAmount">LKR 0.00</span>
                        </div>
                        <div class="calculation-row total">
                            <span class="calculation-label">
                                <i class="fas fa-dollar-sign"></i>
                                Total Amount:
                            </span>
                            <span class="calculation-value" id="totalAmount">LKR 0.00</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Generate Actions -->
        <div class="generate-actions">
            <button type="submit" id="generateBtn" class="btn-generate">
                <i class="fas fa-magic"></i>
                Generate Bill
            </button>
            <a href="${pageContext.request.contextPath}/bill?action=list" class="btn-secondary">
                <i class="fas fa-list-alt"></i>
                View All Bills
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-info">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>
    </form>

    <!-- Bill Preview -->
    <div id="billPreview" class="bill-preview">
        <div class="bill-preview-header">
            <h3>
                <i class="fas fa-file-contract"></i>
                Bill Preview
            </h3>
        </div>
        <div class="preview-row">
            <span><i class="fas fa-user"></i> Customer:</span>
            <span id="previewCustomer">-</span>
        </div>
        <div class="preview-row">
            <span><i class="fas fa-id-card"></i> Account Number:</span>
            <span id="previewAccount">-</span>
        </div>
        <div class="preview-row">
            <span><i class="fas fa-tachometer-alt"></i> Units Consumed:</span>
            <span id="previewUnits">-</span>
        </div>
        <div class="preview-row">
            <span><i class="fas fa-tag"></i> Rate per Unit:</span>
            <span>LKR <%= String.format("%.2f", ratePerUnit) %></span>
        </div>
        <div class="preview-row highlight">
            <span>
                <i class="fas fa-dollar-sign"></i>
                Total Amount:
            </span>
            <span id="previewTotal">LKR 0.00</span>
        </div>
    </div>
</div>

<script>
    // Initialize animations and interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Add focus animations to form controls
        const formControls = document.querySelectorAll('.form-control');
        formControls.forEach(control => {
            control.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
                this.parentElement.style.zIndex = '10';
            });

            control.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
                this.parentElement.style.zIndex = '1';
            });
        });

        // Add hover effects to calculation rows
        const calculationRows = document.querySelectorAll('.calculation-row');
        calculationRows.forEach((row, index) => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(5px) scale(1.02)';
                this.style.boxShadow = '0 5px 15px rgba(102, 126, 234, 0.2)';
            });

            row.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0) scale(1)';
                this.style.boxShadow = '';
            });
        });

        // Add ripple effect to buttons
        const buttons = document.querySelectorAll('.btn-generate, .btn-secondary, .btn-info');
        buttons.forEach(button => {
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;

                ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: radial-gradient(circle, rgba(255,255,255,0.3) 0%, transparent 70%);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s linear;
                    pointer-events: none;
                    z-index: 1;
                `;

                this.style.position = 'relative';
                this.style.overflow = 'hidden';
                this.appendChild(ripple);

                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // Animate sections on scroll
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        });

        const sections = document.querySelectorAll('.customer-selection, .billing-calculation');
        sections.forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(30px)';
            section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(section);
        });

        console.log('✨ Bill generation page animations initialized');
    });

    const ratePerUnit = <%= ratePerUnit %>;
    let selectedCustomer = null;

    function selectCustomer() {
        const select = document.getElementById('customerSelect');
        const option = select.options[select.selectedIndex];
        const display = document.getElementById('customerDisplay');
        const unitsInput = document.getElementById('unitsConsumed');

        if (option.value) {
            selectedCustomer = {
                accountNumber: option.value,
                name: option.getAttribute('data-name'),
                address: option.getAttribute('data-address'),
                telephone: option.getAttribute('data-telephone'),
                units: parseInt(option.getAttribute('data-units'))
            };

            // Update display with animations
            document.getElementById('customerAvatar').textContent = selectedCustomer.name.charAt(0);
            document.getElementById('customerName').textContent = selectedCustomer.name;
            document.getElementById('customerAccount').innerHTML = '<i class="fas fa-id-card"></i> Account: ' + selectedCustomer.accountNumber;
            document.getElementById('customerAddress').innerHTML = '<i class="fas fa-map-marker-alt"></i> Address: ' + selectedCustomer.address;
            document.getElementById('customerPhone').innerHTML = '<i class="fas fa-phone"></i> Phone: ' + selectedCustomer.telephone;

            display.classList.add('show');
            display.style.animation = 'slideInUp 0.6s ease-out';

            // Pre-fill units consumed with animation
            unitsInput.value = selectedCustomer.units;
            unitsInput.style.animation = 'pulse 0.5s ease-in-out';
            setTimeout(() => {
                unitsInput.style.animation = '';
            }, 500);

            calculateBill();
            showNotification('Customer selected successfully!', 'success');
        } else {
            selectedCustomer = null;
            display.classList.remove('show');
            unitsInput.value = '';
            hideCalculation();
        }

        updateGenerateButton();
    }

    function calculateBill() {
        const unitsInput = document.getElementById('unitsConsumed');
        const units = parseInt(unitsInput.value) || 0;

        if (units <= 0) {
            hideCalculation();
            return;
        }

        // Base calculation
        const baseAmount = units * ratePerUnit;

        // Discount calculation with animation
        let discountPercent = 0;
        if (units >= 100) {
            discountPercent = 15;
        } else if (units >= 50) {
            discountPercent = 10;
        } else if (units >= 20) {
            discountPercent = 5;
        }

        const discountAmount = baseAmount * (discountPercent / 100);
        const subtotal = baseAmount - discountAmount;
        const taxAmount = subtotal * 0.08; // 8% tax
        const totalAmount = subtotal + taxAmount;

        // Update display with animations
        document.getElementById('displayUnits').textContent = units + ' units';
        document.getElementById('baseAmount').textContent = 'LKR ' + baseAmount.toFixed(2);

        const discountRow = document.getElementById('discountRow');
        if (discountPercent > 0) {
            document.getElementById('discountPercent').textContent = discountPercent;
            document.getElementById('discountAmount').textContent = '- LKR ' + discountAmount.toFixed(2);
            discountRow.style.display = 'flex';
            discountRow.style.animation = 'slideInLeft 0.3s ease-out';

            if (discountPercent >= 10) {
                showNotification(`Great! ${discountPercent}% discount applied!`, 'success');
            }
        } else {
            discountRow.style.display = 'none';
        }

        document.getElementById('subtotalAmount').textContent = 'LKR ' + subtotal.toFixed(2);
        document.getElementById('taxAmount').textContent = 'LKR ' + taxAmount.toFixed(2);
        document.getElementById('totalAmount').textContent = 'LKR ' + totalAmount.toFixed(2);

        // Show calculation with animation
        const calculationBreakdown = document.getElementById('calculationBreakdown');
        calculationBreakdown.style.display = 'block';
        calculationBreakdown.style.animation = 'slideInUp 0.6s ease-out';

        // Update preview
        updatePreview(units, totalAmount);
        updateGenerateButton();

        // Add sparkle effect for high amounts
        if (totalAmount > 5000) {
            addSparkleEffect();
        }
    }

    function hideCalculation() {
        const calculationBreakdown = document.getElementById('calculationBreakdown');
        const billPreview = document.getElementById('billPreview');

        calculationBreakdown.style.animation = 'slideOutDown 0.3s ease-out';
        billPreview.style.animation = 'slideOutDown 0.3s ease-out';

        setTimeout(() => {
            calculationBreakdown.style.display = 'none';
            billPreview.classList.remove('show');
        }, 300);

        updateGenerateButton();
    }

    function updatePreview(units, totalAmount) {
        if (selectedCustomer && units > 0) {
            document.getElementById('previewCustomer').textContent = selectedCustomer.name;
            document.getElementById('previewAccount').textContent = selectedCustomer.accountNumber;
            document.getElementById('previewUnits').textContent = units + ' units';
            document.getElementById('previewTotal').textContent = 'LKR ' + totalAmount.toFixed(2);

            const billPreview = document.getElementById('billPreview');
            billPreview.classList.add('show');
            billPreview.style.animation = 'slideInUp 0.8s ease-out';
        } else {
            const billPreview = document.getElementById('billPreview');
            billPreview.style.animation = 'slideOutDown 0.3s ease-out';
            setTimeout(() => {
                billPreview.classList.remove('show');
            }, 300);
        }
    }

    function updateGenerateButton() {
        const generateBtn = document.getElementById('generateBtn');
        const unitsInput = document.getElementById('unitsConsumed');
        const units = parseInt(unitsInput.value) || 0;

        if (selectedCustomer && units > 0) {
            generateBtn.classList.add('enabled');
            generateBtn.disabled = false;
            generateBtn.style.animation = 'pulse 2s infinite';
        } else {
            generateBtn.classList.remove('enabled');
            generateBtn.disabled = true;
            generateBtn.style.animation = '';
        }
    }

    // Enhanced notification system
    function showNotification(message, type = 'info') {
        const notification = document.createElement('div');

        let backgroundGradient;
        let icon;
        switch(type) {
            case 'error':
                backgroundGradient = 'var(--danger-gradient)';
                icon = '❌';
                break;
            case 'success':
                backgroundGradient = 'var(--success-gradient)';
                icon = '✅';
                break;
            case 'warning':
                backgroundGradient = 'var(--warning-gradient)';
                icon = '⚠️';
                break;
            default:
                backgroundGradient = 'var(--primary-gradient)';
                icon = 'ℹ️';
        }

        notification.style.cssText = `
            position: fixed;
            top: 2rem;
            right: 2rem;
            background: ${backgroundGradient};
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 15px;
            font-weight: 600;
            box-shadow: var(--card-shadow);
            z-index: 10000;
            animation: slideInRight 0.3s ease-out;
            max-width: 350px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            backdrop-filter: blur(20px);
        `;

        notification.innerHTML = `
            <span style="font-size: 1.2rem;">${icon}</span>
            <span>${message}</span>
        `;

        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease-out';
            setTimeout(() => {
                if (document.body.contains(notification)) {
                    document.body.removeChild(notification);
                }
            }, 300);
        }, 4000);
    }

    // Sparkle effect for high amounts
    function addSparkleEffect() {
        const sparkles = ['✨', '💫', '⭐', '🌟'];
        const totalElement = document.getElementById('totalAmount');

        for (let i = 0; i < 5; i++) {
            setTimeout(() => {
                const sparkle = document.createElement('span');
                sparkle.textContent = sparkles[Math.floor(Math.random() * sparkles.length)];
                sparkle.style.cssText = `
                    position: absolute;
                    font-size: 1.5rem;
                    pointer-events: none;
                    animation: sparkle 2s ease-out forwards;
                    z-index: 1000;
                `;

                const rect = totalElement.getBoundingClientRect();
                sparkle.style.left = (rect.left + Math.random() * rect.width) + 'px';
                sparkle.style.top = (rect.top + Math.random() * rect.height) + 'px';

                document.body.appendChild(sparkle);

                setTimeout(() => {
                    sparkle.remove();
                }, 2000);
            }, i * 200);
        }
    }

    // Enhanced form submission
    document.getElementById('billForm').addEventListener('submit', function(e) {
        if (!selectedCustomer) {
            e.preventDefault();
            showNotification('Please select a customer', 'error');
            document.getElementById('customerSelect').focus();
            document.getElementById('customerSelect').style.animation = 'shake 0.5s ease-in-out';
            setTimeout(() => {
                document.getElementById('customerSelect').style.animation = '';
            }, 500);
            return false;
        }

        const units = parseInt(document.getElementById('unitsConsumed').value) || 0;
        if (units <= 0) {
            e.preventDefault();
            showNotification('Please enter a valid number of units consumed', 'error');
            document.getElementById('unitsConsumed').focus();
            document.getElementById('unitsConsumed').style.animation = 'shake 0.5s ease-in-out';
            setTimeout(() => {
                document.getElementById('unitsConsumed').style.animation = '';
            }, 500);
            return false;
        }

        // Show enhanced loading state
        const generateBtn = document.getElementById('generateBtn');
        generateBtn.innerHTML = '<span class="spinner"></span> <i class="fas fa-magic"></i> Generating Bill...';
        generateBtn.disabled = true;
        generateBtn.style.animation = 'pulse 0.5s infinite';

        // Disable all form elements
        const formElements = this.querySelectorAll('input, select, button');
        formElements.forEach(element => {
            element.disabled = true;
            element.style.opacity = '0.7';
        });

        showNotification('Generating your bill...', 'info');
    });

    // Auto-calculate on page load if customer is pre-selected
    document.addEventListener('DOMContentLoaded', function() {
        const customerSelect = document.getElementById('customerSelect');
        if (customerSelect.value) {
            selectCustomer();
        }

        // Add welcome animation
        setTimeout(() => {
            showNotification('Ready to generate bills!', 'success');
        }, 1000);
    });

    // Enhanced keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey) {
            switch(e.key) {
                case 'g':
                    e.preventDefault();
                    if (!document.getElementById('generateBtn').disabled) {
                        document.getElementById('billForm').submit();
                    }
                    break;
                case 'c':
                    e.preventDefault();
                    document.getElementById('customerSelect').focus();
                    break;
                case 'u':
                    e.preventDefault();
                    document.getElementById('unitsConsumed').focus();
                    break;
            }
        }

        // ESC to clear form
        if (e.key === 'Escape') {
            document.getElementById('customerSelect').value = '';
            document.getElementById('unitsConsumed').value = '';
            selectCustomer();
        }
    });

    // Add CSS for additional animations
    const additionalStyles = document.createElement('style');
    additionalStyles.textContent = `
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideOutRight {
            from {
                opacity: 1;
                transform: translateX(0);
            }
            to {
                opacity: 0;
                transform: translateX(50px);
            }
        }

        @keyframes slideOutDown {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(30px);
            }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
            20%, 40%, 60%, 80% { transform: translateX(10px); }
        }

        @keyframes sparkle {
            0% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
            100% {
                opacity: 0;
                transform: translateY(-50px) scale(0.5) rotate(180deg);
            }
        }

        .form-control, .btn-generate, .btn-secondary, .btn-info {
            position: relative;
            overflow: hidden;
        }

        .calculation-row {
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        /* Enhanced focus effects */
        .form-control:focus {
            animation: focusGlow 0.5s ease-in-out !important;
        }

        @keyframes focusGlow {
            0% { box-shadow: 0 0 5px rgba(102, 126, 234, 0.3); }
            50% { box-shadow: 0 0 25px rgba(102, 126, 234, 0.6); }
            100% { box-shadow: 0 0 20px rgba(102, 126, 234, 0.3); }
        }

        /* Improved accessibility */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
    `;
    document.head.appendChild(additionalStyles);

    // Performance monitoring
    const performanceObserver = new PerformanceObserver((list) => {
        list.getEntries().forEach((entry) => {
            if (entry.duration > 100) {
                console.warn('🐌 Slow operation:', entry.name, entry.duration.toFixed(2) + 'ms');
            }
        });
    });

    if ('PerformanceObserver' in window) {
        performanceObserver.observe({ entryTypes: ['navigation', 'resource'] });
    }

    // Error handling
    window.addEventListener('error', function(e) {
        console.error('❌ Bill generation page error:', e.error);
        showNotification('An error occurred. Please refresh and try again.', 'error');
    });

    console.log('🎨 Advanced bill generation interface loaded successfully');
</script>
</body>
</html>
