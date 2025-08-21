<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Customer - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.05"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.05"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.03"/><circle cx="10" cy="50" r="0.5" fill="white" opacity="0.03"/><circle cx="90" cy="30" r="0.5" fill="white" opacity="0.03"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            z-index: -1;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
        }

        /* Animated Background Elements */
        .floating-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 20s infinite linear;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 70%;
            left: 80%;
            animation-delay: -5s;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            top: 40%;
            left: 90%;
            animation-delay: -10s;
        }

        .shape:nth-child(4) {
            width: 100px;
            height: 100px;
            top: 80%;
            left: 5%;
            animation-delay: -15s;
        }

        @keyframes float {
            0% {
                transform: translate(0, 0) rotate(0deg);
                opacity: 0.7;
            }
            33% {
                transform: translate(30px, -30px) rotate(120deg);
                opacity: 0.4;
            }
            66% {
                transform: translate(-20px, 20px) rotate(240deg);
                opacity: 0.7;
            }
            100% {
                transform: translate(0, 0) rotate(360deg);
                opacity: 0.7;
            }
        }

        .add-customer-header {
            background: linear-gradient(135deg, #ff6b6b 0%, #feca57 100%);
            color: white;
            padding: 3rem 2rem;
            border-radius: 25px;
            margin-bottom: 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(255, 107, 107, 0.3);
            animation: slideDown 0.8s ease-out;
        }

        .add-customer-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        @keyframes slideDown {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .add-customer-header h1 {
            margin: 0 0 1rem 0;
            font-size: 3rem;
            font-weight: 700;
            position: relative;
            z-index: 2;
            text-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .add-customer-header p {
            margin: 0;
            font-size: 1.3rem;
            opacity: 0.95;
            position: relative;
            z-index: 2;
            font-weight: 400;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 3rem;
            border-radius: 30px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
            max-width: 800px;
            margin: 0 auto;
            border: 1px solid rgba(255,255,255,0.2);
            position: relative;
            animation: slideUp 1s ease-out;
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .form-section {
            margin-bottom: 2.5rem;
            padding: 2rem;
            background: linear-gradient(135deg, #f8f9ff 0%, #fef7ff 100%);
            border-radius: 20px;
            border-left: 5px solid #6c5ce7;
            position: relative;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        .form-section:nth-child(1) { animation-delay: 0.1s; }
        .form-section:nth-child(2) { animation-delay: 0.2s; }
        .form-section:nth-child(3) { animation-delay: 0.3s; }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(108, 92, 231, 0.15);
        }

        .form-section:last-child {
            margin-bottom: 0;
        }

        .section-title {
            color: #2d3436;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-weight: 600;
            position: relative;
        }

        .section-title::after {
            content: '';
            flex: 1;
            height: 2px;
            background: linear-gradient(90deg, #6c5ce7, transparent);
            border-radius: 1px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .form-row.single {
            grid-template-columns: 1fr;
        }

        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 600;
            color: #2d3436;
            font-size: 1.1rem;
            position: relative;
            transition: all 0.3s ease;
        }

        .required::after {
            content: ' ✦';
            color: #fd79a8;
            font-weight: bold;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.7; transform: scale(1.1); }
        }

        .form-control {
            width: 100%;
            padding: 1.25rem 1rem 1.25rem 3.5rem;
            border: 3px solid #e9ecef;
            border-radius: 15px;
            font-size: 1.1rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            font-family: 'Poppins', sans-serif;
            position: relative;
        }

        .form-control:focus {
            outline: none;
            border-color: #6c5ce7;
            background: #ffffff;
            box-shadow: 0 0 0 0.25rem rgba(108, 92, 231, 0.15),
            0 8px 25px rgba(108, 92, 231, 0.1);
            transform: translateY(-2px);
        }

        .form-control:valid:not(:focus) {
            border-color: #00b894;
            background: linear-gradient(145deg, #f0fff4 0%, #e8f5e8 100%);
        }

        .form-control.error {
            border-color: #fd79a8;
            background: linear-gradient(145deg, #fdf2f2 0%, #ffeaa7 100%);
            box-shadow: 0 0 0 0.25rem rgba(253, 121, 168, 0.25);
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1.25rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.3rem;
            z-index: 2;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #a29bfe 0%, #6c5ce7 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .input-group:focus-within .input-icon {
            transform: translateY(-50%) scale(1.1);
            filter: drop-shadow(0 0 8px rgba(108, 92, 231, 0.5));
        }

        .help-text {
            font-size: 0.95rem;
            color: #636e72;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 10px;
            border-left: 3px solid #74b9ff;
        }

        .error-message {
            color: #d63031;
            font-size: 0.95rem;
            margin-top: 0.75rem;
            display: none;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem;
            background: linear-gradient(135deg, #ffeaa7 0%, #fab1a0 100%);
            border-radius: 10px;
            border-left: 3px solid #d63031;
            animation: errorSlide 0.3s ease-out;
        }

        @keyframes errorSlide {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-message.show {
            display: flex;
        }

        .form-actions {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            margin-top: 3rem;
            padding-top: 2rem;
        }

        .btn-submit {
            background: linear-gradient(135deg, #00b894 0%, #00cec9 100%);
            color: white;
            padding: 1.25rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            min-width: 200px;
            box-shadow: 0 8px 25px rgba(0, 184, 148, 0.3);
            font-family: 'Poppins', sans-serif;
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .btn-submit:hover:not(:disabled) {
            background: linear-gradient(135deg, #00a085 0%, #00b8b3 100%);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 35px rgba(0, 184, 148, 0.4);
        }

        .btn-submit:active {
            transform: translateY(-1px) scale(1.02);
        }

        .btn-submit:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .btn-loading {
            display: none;
            align-items: center;
            gap: 0.75rem;
        }

        .spinner {
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s cubic-bezier(0.68, -0.55, 0.265, 1.55) infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .validation-summary {
            background: linear-gradient(135deg, #fdcb6e 0%, #fd79a8 100%);
            color: white;
            border: none;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            display: none;
            box-shadow: 0 10px 25px rgba(253, 203, 110, 0.3);
            animation: bounceIn 0.6s ease-out;
        }

        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: scale(0.3) translateY(-50px);
            }
            50% {
                opacity: 1;
                transform: scale(1.05) translateY(0);
            }
            70% {
                transform: scale(0.9);
            }
            100% {
                transform: scale(1);
            }
        }

        .validation-summary.show {
            display: block;
        }

        .validation-summary h4 {
            color: white;
            margin: 0 0 1rem 0;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .validation-summary ul {
            margin: 0;
            padding-left: 1.5rem;
            color: white;
        }

        .validation-summary li {
            margin-bottom: 0.5rem;
        }

        .example-box {
            background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
            color: white;
            border: none;
            padding: 1.25rem;
            margin-top: 0.75rem;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
        }

        .example-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: exampleShimmer 3s infinite;
        }

        @keyframes exampleShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .example-box h5 {
            margin: 0 0 0.75rem 0;
            color: white;
            font-size: 1rem;
            font-weight: 600;
        }

        .example-box p {
            margin: 0;
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.9);
            font-family: 'Courier New', monospace;
            background: rgba(255, 255, 255, 0.1);
            padding: 0.5rem;
            border-radius: 8px;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
            color: white;
            padding: 1.25rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(99, 110, 114, 0.3);
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #2d3436 0%, #636e72 100%);
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(99, 110, 114, 0.4);
        }

        /* Alert Styles */
        .alert {
            padding: 1.25rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: alertSlide 0.5s ease-out;
        }

        @keyframes alertSlide {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-error {
            background: linear-gradient(135deg, #ff7675 0%, #d63031 100%);
            color: white;
            box-shadow: 0 8px 25px rgba(255, 118, 117, 0.3);
        }

        .icon-error {
            font-size: 1.5rem;
            animation: bounce 1s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .form-container {
                padding: 2rem;
                margin: 1rem;
                border-radius: 20px;
            }

            .form-section {
                padding: 1.5rem;
                margin-bottom: 2rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .form-actions {
                flex-direction: column;
                align-items: center;
            }

            .add-customer-header {
                margin: 1rem;
                padding: 2rem 1.5rem;
                border-radius: 20px;
            }

            .add-customer-header h1 {
                font-size: 2.2rem;
            }

            .add-customer-header p {
                font-size: 1.1rem;
            }

            .btn-submit,
            .btn-secondary {
                width: 100%;
                max-width: 300px;
            }
        }

        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #6c5ce7 0%, #a29bfe 100%);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #5f4fcf 0%, #9085e8 100%);
        }

        /* Focus Ring */
        *:focus {
            outline: none;
        }

        .form-control:focus {
            outline: 2px solid transparent;
            outline-offset: 2px;
        }
    </style>
</head>
<body>
<!-- Floating Shapes Animation -->
<div class="floating-shapes">
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
</div>

<!-- Check if user is logged in -->
    <%
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
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
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link active">Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link">Items</a></li>
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link">Billing</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link">Help</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- Page Header -->
    <div class="add-customer-header">
        <h1>🌟 Add New Customer</h1>
        <p>Create a new customer profile with elegant style</p>
    </div>

    <!-- Display Error Messages -->
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <i class="icon-error">⚠️</i>
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <!-- Validation Summary -->
    <div id="validationSummary" class="validation-summary">
        <h4>🚨 Please fix the following errors:</h4>
        <ul id="validationList"></ul>
    </div>

    <!-- Add Customer Form -->
    <div class="form-container">
        <form id="addCustomerForm" action="${pageContext.request.contextPath}/customer" method="post" novalidate>
            <input type="hidden" name="action" value="add">

            <!-- Account Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    🏆 Account Information
                </h3>

                <div class="form-group">
                    <label for="accountNumber" class="required">Account Number</label>
                    <div class="input-group">
                        <span class="input-icon">🎯</span>
                        <input type="text"
                               id="accountNumber"
                               name="accountNumber"
                               class="form-control"
                               value="<%= request.getAttribute("accountNumber") != null ? request.getAttribute("accountNumber") : "" %>"
                               placeholder="Enter unique account number"
                               required
                               maxlength="20"
                               pattern="[A-Za-z0-9_-]+">
                    </div>
                    <div class="help-text">
                        💡 Use only letters, numbers, hyphens, and underscores (4-20 characters)
                    </div>
                    <div id="accountNumberError" class="error-message">
                        🔥 <span></span>
                    </div>
                    <div class="example-box">
                        <h5>Examples:</h5>
                        <p>CUST001, CUSTOMER_123, ACC-2024-001</p>
                    </div>
                </div>
            </div>

            <!-- Personal Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    👑 Personal Information
                </h3>

                <div class="form-group">
                    <label for="name" class="required">Full Name</label>
                    <div class="input-group">
                        <span class="input-icon">🎭</span>
                        <input type="text"
                               id="name"
                               name="name"
                               class="form-control"
                               value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                               placeholder="Enter customer's full name"
                               required
                               maxlength="100"
                               pattern="[A-Za-z\s.']+">
                    </div>
                    <div class="help-text">
                        🌟 Enter the customer's complete name
                    </div>
                    <div id="nameError" class="error-message">
                        🔥 <span></span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="address" class="required">Address</label>
                    <div class="input-group">
                        <span class="input-icon">🏰</span>
                        <textarea id="address"
                                  name="address"
                                  class="form-control"
                                  placeholder="Enter complete address"
                                  required
                                  maxlength="500"
                                  rows="3"><%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %></textarea>
                    </div>
                    <div class="help-text">
                        🗺️ Include street address, city, and postal code
                    </div>
                    <div id="addressError" class="error-message">
                        🔥 <span></span>
                    </div>
                    <div class="example-box">
                        <h5>Example:</h5>
                        <p>123 Galle Road, Colombo 03, Sri Lanka</p>
                    </div>
                </div>

                <div class="form-group">
                    <label for="telephone" class="required">Telephone Number</label>
                    <div class="input-group">
                        <span class="input-icon">📱</span>
                        <input type="tel"
                               id="telephone"
                               name="telephone"
                               class="form-control"
                               value="<%= request.getAttribute("telephone") != null ? request.getAttribute("telephone") : "" %>"
                               placeholder="Enter contact number"
                               required
                               maxlength="15"
                               pattern="[0-9\s\-\+\(\)]+">
                    </div>
                    <div class="help-text">
                        📞 Enter a valid contact number with country code if international
                    </div>
                    <div id="telephoneError" class="error-message">
                        🔥 <span></span>
                    </div>
                    <div class="example-box">
                        <h5>Examples:</h5>
                        <p>0112345678, +94112345678, (011) 234-5678</p>
                    </div>
                </div>
            </div>

            <!-- Usage Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    📈 Usage Information
                </h3>

                <div class="form-group">
                    <label for="unitsConsumed" class="required">Initial Units Consumed</label>
                    <div class="input-group">
                        <span class="input-icon">⚡</span>
                        <input type="number"
                               id="unitsConsumed"
                               name="unitsConsumed"
                               class="form-control"
                               value="<%= request.getAttribute("unitsConsumed") != null ? request.getAttribute("unitsConsumed") : "0" %>"
                               placeholder="Enter initial reading"
                               required
                               min="0"
                               max="9999">
                    </div>
                    <div class="help-text">
                        🔋 Usually 0 for new customers, or current reading for existing customers
                    </div>
                    <div id="unitsConsumedError" class="error-message">
                        🔥 <span></span>
                    </div>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="submit" id="submitBtn" class="btn-submit">
                    <span class="btn-text">🚀 Add Customer</span>
                    <span class="btn-loading">
                            <span class="spinner"></span>
                            Adding Customer...
                        </span>
                </button>
                <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary btn-lg">
                    🔙 Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    // Form validation
    const form = document.getElementById('addCustomerForm');
    const submitBtn = document.getElementById('submitBtn');
    const validationSummary = document.getElementById('validationSummary');
    const validationList = document.getElementById('validationList');

    // Field references
    const fields = {
        accountNumber: document.getElementById('accountNumber'),
        name: document.getElementById('name'),
        address: document.getElementById('address'),
        telephone: document.getElementById('telephone'),
        unitsConsumed: document.getElementById('unitsConsumed')
    };

    // Validation rules
    const validationRules = {
        accountNumber: {
            required: true,
            minLength: 4,
            maxLength: 20,
            pattern: /^[A-Za-z0-9_-]+$/,
            message: 'Account number must be 4-20 characters long and contain only letters, numbers, hyphens, and underscores'
        },
        name: {
            required: true,
            minLength: 2,
            maxLength: 100,
            pattern: /^[A-Za-z\s.']+$/,
            message: 'Name must be 2-100 characters long and contain only letters, spaces, dots, and apostrophes'
        },
        address: {
            required: true,
            minLength: 5,
            maxLength: 500,
            message: 'Address must be 5-500 characters long'
        },
        telephone: {
            required: true,
            minLength: 7,
            maxLength: 15,
            pattern: /^[0-9\s\-\+\(\)]+$/,
            message: 'Telephone must be 7-15 characters long and contain only numbers, spaces, hyphens, plus signs, and parentheses'
        },
        unitsConsumed: {
            required: true,
            min: 0,
            max: 9999,
            message: 'Units consumed must be between 0 and 9999'
        }
    };

    // Validate individual field
    function validateField(fieldName) {
        const field = fields[fieldName];
        const rule = validationRules[fieldName];
        const value = field.value.trim();
        const errorElement = document.getElementById(fieldName + 'Error');

        let isValid = true;
        let errorMessage = '';

        // Required check
        if (rule.required && !value) {
            isValid = false;
            errorMessage = `${fieldName} is required`;
        }
        // Length checks
        else if (rule.minLength && value.length < rule.minLength) {
            isValid = false;
            errorMessage = `${fieldName} must be at least ${rule.minLength} characters`;
        }
        else if (rule.maxLength && value.length > rule.maxLength) {
            isValid = false;
            errorMessage = `${fieldName} must not exceed ${rule.maxLength} characters`;
        }
        // Number checks
        else if (rule.min !== undefined && parseInt(value) < rule.min) {
            isValid = false;
            errorMessage = `${fieldName} must be at least ${rule.min}`;
        }
        else if (rule.max !== undefined && parseInt(value) > rule.max) {
            isValid = false;
            errorMessage = `${fieldName} must not exceed ${rule.max}`;
        }
        // Pattern check
        else if (rule.pattern && !rule.pattern.test(value)) {
            isValid = false;
            errorMessage = rule.message;
        }

        // Update UI
        if (isValid) {
            field.classList.remove('error');
            field.classList.add('valid');
            errorElement.classList.remove('show');
        } else {
            field.classList.add('error');
            field.classList.remove('valid');
            errorElement.querySelector('span').textContent = errorMessage;
            errorElement.classList.add('show');
        }

        return isValid;
    }

    // Validate entire form
    function validateForm() {
        let isValid = true;
        const errors = [];

        for (const fieldName in fields) {
            if (!validateField(fieldName)) {
                isValid = false;
                const rule = validationRules[fieldName];
                errors.push(rule.message || `Invalid ${fieldName}`);
            }
        }

        // Update validation summary
        if (errors.length > 0) {
            validationList.innerHTML = errors.map(error => `<li>${error}</li>`).join('');
            validationSummary.classList.add('show');
            validationSummary.scrollIntoView({ behavior: 'smooth', block: 'center' });
        } else {
            validationSummary.classList.remove('show');
        }

        return isValid;
    }

    // Add event listeners
    for (const fieldName in fields) {
        const field = fields[fieldName];

        field.addEventListener('blur', () => validateField(fieldName));
        field.addEventListener('input', () => {
            // Clear error on input
            if (field.classList.contains('error')) {
                validateField(fieldName);
            }
        });
    }

    // Form submission
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        if (validateForm()) {
            // Show loading state
            const btnText = submitBtn.querySelector('.btn-text');
            const btnLoading = submitBtn.querySelector('.btn-loading');

            btnText.style.display = 'none';
            btnLoading.style.display = 'inline-flex';
            submitBtn.disabled = true;

            // Submit form
            setTimeout(() => {
                form.submit();
            }, 500);
        }
    });

    // Auto-generate account number suggestion
    fields.name.addEventListener('input', function() {
        const name = this.value.trim();
        if (name && !fields.accountNumber.value) {
            const suggestion = 'CUST' + Math.floor(Math.random() * 1000).toString().padStart(3, '0');
            fields.accountNumber.placeholder = `Suggestion: ${suggestion}`;
        }
    });

    // Format telephone number
    fields.telephone.addEventListener('input', function() {
        let value = this.value.replace(/[^\d\s\-\+\(\)]/g, '');
        this.value = value;
    });

    // Auto-focus first field
    document.addEventListener('DOMContentLoaded', function() {
        fields.accountNumber.focus();
    });

    // Save draft functionality
    function saveDraft() {
        const draft = {};
        for (const fieldName in fields) {
            draft[fieldName] = fields[fieldName].value;
        }
        localStorage.setItem('customerDraft', JSON.stringify(draft));
    }

    function loadDraft() {
        const draft = localStorage.getItem('customerDraft');
        if (draft) {
            const data = JSON.parse(draft);
            for (const fieldName in data) {
                if (fields[fieldName] && !fields[fieldName].value) {
                    fields[fieldName].value = data[fieldName];
                }
            }
        }
    }

    // Load draft on page load
    loadDraft();

    // Save draft on input
    for (const fieldName in fields) {
        fields[fieldName].addEventListener('input', saveDraft);
    }

    // Clear draft on successful submission
    form.addEventListener('submit', function() {
        if (validateForm()) {
            localStorage.removeItem('customerDraft');
        }
    });

    // Advanced field interactions and animations
    function addFieldAnimations() {
        for (const fieldName in fields) {
            const field = fields[fieldName];
            const inputGroup = field.closest('.input-group');
            const icon = inputGroup ? inputGroup.querySelector('.input-icon') : null;

            // Focus animations
            field.addEventListener('focus', function() {
                if (icon) {
                    icon.style.transform = 'translateY(-50%) scale(1.2) rotate(5deg)';
                    icon.style.filter = 'drop-shadow(0 0 10px rgba(108, 92, 231, 0.6))';
                }

                // Add glow effect to the form group
                this.closest('.form-group').style.transform = 'translateY(-2px)';
                this.closest('.form-group').style.filter = 'drop-shadow(0 8px 16px rgba(108, 92, 231, 0.1))';
            });

            // Blur animations
            field.addEventListener('blur', function() {
                if (icon) {
                    icon.style.transform = 'translateY(-50%) scale(1) rotate(0deg)';
                    icon.style.filter = 'none';
                }

                // Remove glow effect
                this.closest('.form-group').style.transform = 'translateY(0)';
                this.closest('.form-group').style.filter = 'none';
            });

            // Input animations for real-time feedback
            field.addEventListener('input', function() {
                const value = this.value;

                // Add typing animation
                if (icon) {
                    icon.style.animation = 'pulse 0.3s ease-in-out';
                    setTimeout(() => {
                        icon.style.animation = '';
                    }, 300);
                }

                // Character count animation for text fields
                if (this.type === 'text' || this.type === 'textarea') {
                    const maxLength = this.maxLength;
                    if (maxLength && value.length > maxLength * 0.8) {
                        this.style.borderColor = '#fdcb6e';
                        this.style.boxShadow = '0 0 0 0.25rem rgba(253, 203, 110, 0.25)';
                    }
                }
            });
        }
    }

    // Call the animation function
    addFieldAnimations();

    // Enhanced form submission with progress animation
    function enhancedFormSubmission() {
        const progressSteps = [
            'Validating information...',
            'Checking account uniqueness...',
            'Creating customer profile...',
            'Finalizing registration...',
            'Success! Redirecting...'
        ];

        form.addEventListener('submit', function(e) {
            e.preventDefault();

            if (validateForm()) {
                const btnText = submitBtn.querySelector('.btn-text');
                const btnLoading = submitBtn.querySelector('.btn-loading');
                const loadingText = btnLoading.querySelector('span:last-child');

                btnText.style.display = 'none';
                btnLoading.style.display = 'inline-flex';
                submitBtn.disabled = true;

                let currentStep = 0;

                // Animate through progress steps
                const progressInterval = setInterval(() => {
                    if (currentStep < progressSteps.length) {
                        loadingText.textContent = progressSteps[currentStep];
                        currentStep++;
                    } else {
                        clearInterval(progressInterval);
                        form.submit();
                    }
                }, 800);
            }
        });
    }

    // Initialize enhanced submission
    enhancedFormSubmission();

    // Account number generator with animation
    function enhanceAccountNumberGeneration() {
        const generateBtn = document.createElement('button');
        generateBtn.type = 'button';
        generateBtn.className = 'btn-generate';
        generateBtn.innerHTML = '✨ Generate';
        generateBtn.style.cssText = `
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background: linear-gradient(135deg, #a29bfe 0%, #6c5ce7 100%);
        color: white;
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 25px;
        font-size: 0.9rem;
        cursor: pointer;
        transition: all 0.3s ease;
        z-index: 3;
    `;

        // Add hover effects
        generateBtn.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-50%) scale(1.05)';
            this.style.boxShadow = '0 5px 15px rgba(108, 92, 231, 0.4)';
        });

        generateBtn.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(-50%) scale(1)';
            this.style.boxShadow = 'none';
        });

        // Generate account number with animation
        generateBtn.addEventListener('click', function() {
            const prefixes = ['CUST', 'ACC', 'CLIENT', 'USER'];
            const randomPrefix = prefixes[Math.floor(Math.random() * prefixes.length)];
            const randomNumber = Math.floor(Math.random() * 10000).toString().padStart(4, '0');
            const generatedNumber = `${randomPrefix}${randomNumber}`;

            // Animate the generation
            this.innerHTML = '🎲 Generating...';
            this.style.background = 'linear-gradient(135deg, #fdcb6e 0%, #fd79a8 100%)';

            setTimeout(() => {
                fields.accountNumber.value = '';
                let index = 0;

                // Type animation
                const typeInterval = setInterval(() => {
                    if (index <= generatedNumber.length) {
                        fields.accountNumber.value = generatedNumber.substring(0, index);
                        index++;
                    } else {
                        clearInterval(typeInterval);
                        fields.accountNumber.dispatchEvent(new Event('input'));
                        validateField('accountNumber');
                    }
                }, 100);

                this.innerHTML = '✨ Generate';
                this.style.background = 'linear-gradient(135deg, #a29bfe 0%, #6c5ce7 100%)';
            }, 1000);
        });

        // Add to account number input group
        const accountInputGroup = fields.accountNumber.closest('.input-group');
        accountInputGroup.style.position = 'relative';
        accountInputGroup.appendChild(generateBtn);

        // Adjust input padding to make room for button
        fields.accountNumber.style.paddingRight = '120px';
    }

    // Initialize account number generator
    enhanceAccountNumberGeneration();

    // Phone number formatting with country detection
    function enhancePhoneFormatting() {
        const phoneField = fields.telephone;
        const countryFlag = document.createElement('span');
        countryFlag.style.cssText = `
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 1.2rem;
        transition: all 0.3s ease;
    `;

        phoneField.closest('.input-group').appendChild(countryFlag);

        phoneField.addEventListener('input', function() {
            let value = this.value.replace(/[^\d\s\-\+\(\)]/g, '');

            // Country detection and flag display
            if (value.startsWith('+94') || value.startsWith('0')) {
                countryFlag.textContent = '🇱🇰';
                countryFlag.title = 'Sri Lanka';
            } else if (value.startsWith('+1')) {
                countryFlag.textContent = '🇺🇸';
                countryFlag.title = 'USA';
            } else if (value.startsWith('+91')) {
                countryFlag.textContent = '🇮🇳';
                countryFlag.title = 'India';
            } else if (value.startsWith('+44')) {
                countryFlag.textContent = '🇬🇧';
                countryFlag.title = 'UK';
            } else if (value.length > 0) {
                countryFlag.textContent = '🌍';
                countryFlag.title = 'International';
            } else {
                countryFlag.textContent = '';
            }

            // Auto-format Sri Lankan numbers
            if (value.startsWith('0') && value.length === 10) {
                value = value.replace(/(\d{3})(\d{3})(\d{4})/, '$1 $2 $3');
            }

            this.value = value;
        });
    }

    // Initialize phone formatting
    enhancePhoneFormatting();

    // Address autocomplete enhancement
    function enhanceAddressInput() {
        const addressField = fields.address;
        const suggestions = [
            'Colombo 01, Sri Lanka',
            'Colombo 02, Sri Lanka',
            'Colombo 03, Sri Lanka',
            'Kandy, Sri Lanka',
            'Galle, Sri Lanka',
            'Negombo, Sri Lanka',
            'Jaffna, Sri Lanka',
            'Anuradhapura, Sri Lanka'
        ];

        const suggestionsList = document.createElement('div');
        suggestionsList.className = 'address-suggestions';
        suggestionsList.style.cssText = `
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        background: white;
        border: 2px solid #e9ecef;
        border-top: none;
        border-radius: 0 0 15px 15px;
        max-height: 200px;
        overflow-y: auto;
        z-index: 1000;
        display: none;
        box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    `;

        addressField.closest('.input-group').style.position = 'relative';
        addressField.closest('.input-group').appendChild(suggestionsList);

        addressField.addEventListener('input', function() {
            const query = this.value.toLowerCase();
            if (query.length < 2) {
                suggestionsList.style.display = 'none';
                return;
            }

            const matches = suggestions.filter(suggestion =>
                suggestion.toLowerCase().includes(query)
            );

            if (matches.length > 0) {
                suggestionsList.innerHTML = matches.map(match => `
                <div class="suggestion-item" style="
                    padding: 12px 15px;
                    cursor: pointer;
                    transition: background-color 0.2s ease;
                    border-bottom: 1px solid #f8f9fa;
                " onmouseover="this.style.backgroundColor='#f8f9fa'"
                  onmouseout="this.style.backgroundColor='white'"
                  onclick="selectAddress('${match}')">
                    📍 ${match}
                </div>
            `).join('');
                suggestionsList.style.display = 'block';
            } else {
                suggestionsList.style.display = 'none';
            }
        });

        // Hide suggestions when clicking outside
        document.addEventListener('click', function(e) {
            if (!addressField.contains(e.target) && !suggestionsList.contains(e.target)) {
                suggestionsList.style.display = 'none';
            }
        });
    }

    // Global function for address selection
    window.selectAddress = function(address) {
        fields.address.value = address;
        document.querySelector('.address-suggestions').style.display = 'none';
        fields.address.dispatchEvent(new Event('input'));
        validateField('address');
    };

    // Initialize address enhancement
    enhanceAddressInput();

    // Units consumed calculator
    function enhanceUnitsInput() {
        const unitsField = fields.unitsConsumed;
        const calculator = document.createElement('div');
        calculator.className = 'units-calculator';
        calculator.style.cssText = `
        margin-top: 10px;
        padding: 15px;
        background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
        border-radius: 15px;
        color: white;
        font-size: 0.9rem;
        transition: all 0.3s ease;
    `;

        unitsField.closest('.form-group').appendChild(calculator);

        function updateCalculator() {
            const units = parseInt(unitsField.value) || 0;
            const estimatedCost = units * 25; // Assuming 25 LKR per unit
            const category = units < 100 ? 'Low Usage' : units < 500 ? 'Medium Usage' : 'High Usage';

            calculator.innerHTML = `
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <div>
                    <div>⚡ ${units} units</div>
                    <div>💰 Est. Cost: LKR ${estimatedCost.toLocaleString()}</div>
                </div>
                <div style="text-align: right;">
                    <div style="font-weight: 600;">${category}</div>
                    <div style="font-size: 0.8rem; opacity: 0.9;">
                        ${units == 0 ? 'New Customer' : 'Existing Customer'}
                    </div>
                </div>
            </div>
        `;

            // Color coding based on usage
            if (units < 100) {
                calculator.style.background = 'linear-gradient(135deg, #00b894 0%, #00cec9 100%)';
            } else if (units < 500) {
                calculator.style.background = 'linear-gradient(135deg, #fdcb6e 0%, #e17055 100%)';
            } else {
                calculator.style.background = 'linear-gradient(135deg, #fd79a8 0%, #d63031 100%)';
            }
        }

        unitsField.addEventListener('input', updateCalculator);
        updateCalculator(); // Initial call
    }

    // Initialize units calculator
    enhanceUnitsInput();

    // Form progress indicator
    function addProgressIndicator() {
        const progressBar = document.createElement('div');
        progressBar.className = 'form-progress';
        progressBar.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 0%;
        height: 4px;
        background: linear-gradient(90deg, #6c5ce7 0%, #a29bfe 100%);
        transition: width 0.3s ease;
        z-index: 9999;
        box-shadow: 0 0 10px rgba(108, 92, 231, 0.5);
    `;

        document.body.appendChild(progressBar);

        function updateProgress() {
            const totalFields = Object.keys(fields).length;
            let filledFields = 0;

            for (const fieldName in fields) {
                if (fields[fieldName].value.trim() && !fields[fieldName].classList.contains('error')) {
                    filledFields++;
                }
            }

            const progress = (filledFields / totalFields) * 100;
            progressBar.style.width = progress + '%';

            // Color changes based on progress
            if (progress < 30) {
                progressBar.style.background = 'linear-gradient(90deg, #fd79a8 0%, #fdcb6e 100%)';
            } else if (progress < 70) {
                progressBar.style.background = 'linear-gradient(90deg, #fdcb6e 0%, #00b894 100%)';
            } else {
                progressBar.style.background = 'linear-gradient(90deg, #00b894 0%, #6c5ce7 100%)';
            }
        }

        // Update progress on any field change
        for (const fieldName in fields) {
            fields[fieldName].addEventListener('input', updateProgress);
            fields[fieldName].addEventListener('blur', updateProgress);
        }

        updateProgress(); // Initial call
    }

    // Initialize progress indicator
    addProgressIndicator();

    // Keyboard shortcuts
    function addKeyboardShortcuts() {
        document.addEventListener('keydown', function(e) {
            // Ctrl + Enter to submit form
            if (e.ctrlKey && e.key === 'Enter') {
                e.preventDefault();
                submitBtn.click();
            }

            // Ctrl + G to generate account number
            if (e.ctrlKey && e.key === 'g') {
                e.preventDefault();
                const generateBtn = document.querySelector('.btn-generate');
                if (generateBtn) {
                    generateBtn.click();
                }
            }

            // Escape to clear current field
            if (e.key === 'Escape') {
                const activeElement = document.activeElement;
                if (activeElement && activeElement.tagName === 'INPUT' || activeElement.tagName === 'TEXTAREA') {
                    activeElement.value = '';
                    activeElement.dispatchEvent(new Event('input'));
                }
            }

            // Tab navigation enhancement
            if (e.key === 'Tab') {
                const currentField = document.activeElement;
                if (currentField && fields[currentField.name]) {
                    validateField(currentField.name);
                }
            }
        });

        // Add keyboard shortcuts hint
        const shortcutsHint = document.createElement('div');
        shortcutsHint.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: rgba(45, 52, 54, 0.9);
        color: white;
        padding: 10px 15px;
        border-radius: 10px;
        font-size: 0.8rem;
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: 1000;
        pointer-events: none;
    `;

        shortcutsHint.innerHTML = `
        <div style="font-weight: 600; margin-bottom: 5px;">💡 Shortcuts:</div>
        <div>Ctrl + Enter: Submit</div>
        <div>Ctrl + G: Generate Account</div>
        <div>Esc: Clear Field</div>
    `;

        document.body.appendChild(shortcutsHint);

        // Show/hide shortcuts on Alt key
        document.addEventListener('keydown', function(e) {
            if (e.altKey) {
                shortcutsHint.style.opacity = '1';
            }
        });

        document.addEventListener('keyup', function(e) {
            if (!e.altKey) {
                shortcutsHint.style.opacity = '0';
            }
        });
    }

    // Initialize keyboard shortcuts
    addKeyboardShortcuts();

    // Final form enhancement - success animation
    function addSuccessAnimation() {
        // This would typically be triggered after successful form submission
        // For now, we'll create the function that can be called when needed
        window.showSuccessAnimation = function() {
            const successOverlay = document.createElement('div');
            successOverlay.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 184, 148, 0.95);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            animation: fadeIn 0.5s ease-out;
        `;

            successOverlay.innerHTML = `
            <div style="text-align: center; color: white; animation: bounceIn 0.8s ease-out;">
                <div style="font-size: 4rem; margin-bottom: 1rem;">🎉</div>
                <h2 style="font-size: 2rem; margin-bottom: 0.5rem;">Success!</h2>
                <p style="font-size: 1.2rem;">Customer has been added successfully</p>
                <div style="margin-top: 2rem;">
                    <div class="spinner" style="
                        width: 30px;
                        height: 30px;
                        border: 3px solid rgba(255,255,255,0.3);
                        border-top-color: white;
                        margin: 0 auto;
                    "></div>
                    <p style="margin-top: 1rem;">Redirecting...</p>
                </div>
            </div>
        `;

            document.body.appendChild(successOverlay);

            setTimeout(() => {
                successOverlay.remove();
            }, 3000);
        };
    }

    // Initialize success animation
    addSuccessAnimation();

    // Initialize all enhancements
    console.log('🚀 Customer form enhanced with advanced features!');
    console.log('💡 Press Alt to see keyboard shortcuts');

</script>
</body>
</html>
