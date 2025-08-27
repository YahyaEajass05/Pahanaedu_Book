<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Customer - Book Haven</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(135deg, #FFE5E5 0%, #FFF5E1 50%, #E8F5E5 100%);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated Book Background */
        .book-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            opacity: 0.1;
            pointer-events: none;
        }

        .floating-book {
            position: absolute;
            font-size: 3rem;
            animation: floatBooks 20s infinite linear;
        }

        @keyframes floatBooks {
            0% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 0.3;
            }
            90% {
                opacity: 0.3;
            }
            100% {
                transform: translateY(-100vh) rotate(360deg);
                opacity: 0;
            }
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
        }

        /* Navigation Bar */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.15);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-radius: 20px;
            margin-bottom: 2rem;
            animation: slideDown 0.5s ease-out;
        }

        .navbar-content {
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
            background: linear-gradient(135deg, #FF6B6B 0%, #FFE66D 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .navbar-nav {
            display: flex;
            list-style: none;
            gap: 0.5rem;
            align-items: center;
        }

        .nav-link {
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            color: #2C3E50;
            font-weight: 500;
            border-radius: 50px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(255, 107, 107, 0.1);
            color: #FF6B6B;
        }

        .nav-link.active {
            background: linear-gradient(135deg, #FF6B6B 0%, #FFE66D 100%);
            color: white;
        }

        .nav-link.logout {
            background: linear-gradient(135deg, #FF6B6B 0%, #EE5A24 100%);
            color: white;
        }

        /* Header Section */
        .add-customer-header {
            background: linear-gradient(135deg, #4ECDC4 0%, #44A08D 100%);
            color: white;
            padding: 4rem 3rem;
            border-radius: 30px;
            margin-bottom: 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(78, 205, 196, 0.3);
            animation: fadeInScale 0.8s ease-out;
        }

        .add-customer-header::before {
            content: '📚';
            position: absolute;
            top: -50px;
            right: -50px;
            font-size: 200px;
            opacity: 0.1;
            transform: rotate(-15deg);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: rotate(-15deg) translateY(0); }
            50% { transform: rotate(-15deg) translateY(-20px); }
        }

        .add-customer-header h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            animation: slideInLeft 0.8s ease-out;
        }

        .add-customer-header p {
            font-size: 1.3rem;
            opacity: 0.95;
            animation: slideInLeft 0.8s ease-out 0.2s both;
        }

        /* Form Container */
        .form-container {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            padding: 3rem;
            border-radius: 30px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.1);
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            animation: slideUp 0.8s ease-out;
        }

        /* Form Sections */
        .form-section {
            margin-bottom: 2.5rem;
            padding: 2.5rem;
            background: linear-gradient(135deg, #F8F9FA 0%, #E9ECEF 100%);
            border-radius: 20px;
            position: relative;
            transition: all 0.3s ease;
            border-left: 5px solid transparent;
            animation: fadeInUp 0.6s ease-out forwards;
            opacity: 0;
        }

        .form-section:nth-child(1) {
            border-left-color: #FF6B6B;
            animation-delay: 0.1s;
        }
        .form-section:nth-child(2) {
            border-left-color: #4ECDC4;
            animation-delay: 0.2s;
        }
        .form-section:nth-child(3) {
            border-left-color: #FFE66D;
            animation-delay: 0.3s;
        }

        .form-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .section-title {
            color: #2C3E50;
            font-size: 1.6rem;
            margin-bottom: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .section-title i {
            font-size: 1.8rem;
            color: #FF6B6B;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 600;
            color: #2C3E50;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .required::after {
            content: ' *';
            color: #E74C3C;
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 1.25rem 1.25rem 1.25rem 3.5rem;
            border: 2px solid #E9ECEF;
            border-radius: 15px;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            background: white;
            font-family: 'Quicksand', sans-serif;
        }

        .form-control:focus {
            outline: none;
            border-color: #4ECDC4;
            box-shadow: 0 0 0 4px rgba(78, 205, 196, 0.1);
            transform: translateY(-2px);
        }

        .form-control.success {
            border-color: #27AE60;
            background: #E8F8F5;
        }

        .form-control.error {
            border-color: #E74C3C;
            background: #FADBD8;
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
            color: #7F8C8D;
            transition: all 0.3s ease;
        }

        .input-group:focus-within .input-icon {
            color: #4ECDC4;
            transform: translateY(-50%) scale(1.1);
        }

        /* Help Text */
        .help-text {
            font-size: 0.9rem;
            color: #7F8C8D;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem;
            background: rgba(52, 152, 219, 0.1);
            border-radius: 10px;
            border-left: 3px solid #3498DB;
        }

        /* Error Messages with Animation */
        .error-message {
            color: #E74C3C;
            font-size: 0.9rem;
            margin-top: 0.75rem;
            padding: 0.75rem;
            background: rgba(231, 76, 60, 0.1);
            border-radius: 10px;
            border-left: 3px solid #E74C3C;
            display: none;
            align-items: center;
            gap: 0.5rem;
            animation: errorSlide 0.3s ease-out;
        }

        .error-message.show {
            display: flex;
            animation: errorBounce 0.5s ease-out;
        }

        @keyframes errorBounce {
            0% {
                opacity: 0;
                transform: translateY(-10px) scale(0.9);
            }
            50% {
                transform: translateY(5px) scale(1.05);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Success Notification */
        .success-notification {
            position: fixed;
            top: 2rem;
            right: -400px;
            background: linear-gradient(135deg, #27AE60 0%, #2ECC71 100%);
            color: white;
            padding: 1.5rem 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(46, 204, 113, 0.3);
            display: flex;
            align-items: center;
            gap: 1rem;
            z-index: 9999;
            transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .success-notification.show {
            right: 2rem;
            animation: successPulse 0.8s ease-out;
        }

        @keyframes successPulse {
            0% { transform: scale(0.8); opacity: 0; }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); opacity: 1; }
        }

        /* Validation Summary */
        .validation-summary {
            background: linear-gradient(135deg, #E74C3C 0%, #C0392B 100%);
            color: white;
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            display: none;
            box-shadow: 0 10px 25px rgba(231, 76, 60, 0.3);
            animation: validationSlide 0.5s ease-out;
        }

        .validation-summary.show {
            display: block;
            animation: validationShake 0.8s ease-out;
        }

        @keyframes validationShake {
            0% { transform: translateX(-50px); opacity: 0; }
            20% { transform: translateX(10px); }
            40% { transform: translateX(-10px); }
            60% { transform: translateX(10px); }
            80% { transform: translateX(-5px); }
            100% { transform: translateX(0); opacity: 1; }
        }

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            margin-top: 3rem;
            padding-top: 2rem;
        }

        .btn-submit {
            background: linear-gradient(135deg, #27AE60 0%, #2ECC71 100%);
            color: white;
            padding: 1.25rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            min-width: 200px;
            box-shadow: 0 8px 25px rgba(46, 204, 113, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 35px rgba(46, 204, 113, 0.4);
        }

        .btn-submit:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #95A5A6 0%, #7F8C8D 100%);
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
            box-shadow: 0 8px 25px rgba(149, 165, 166, 0.3);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 30px rgba(149, 165, 166, 0.4);
        }

        /* Loading Spinner */
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

        /* Progress Bar */
        .form-progress {
            position: fixed;
            top: 0;
            left: 0;
            width: 0%;
            height: 4px;
            background: linear-gradient(90deg, #4ECDC4 0%, #44A08D 100%);
            transition: width 0.3s ease;
            z-index: 9999;
            box-shadow: 0 0 10px rgba(78, 205, 196, 0.5);
        }

        /* Animations */
        @keyframes slideDown {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes slideUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .form-container {
                padding: 2rem;
                margin: 1rem;
            }

            .form-section {
                padding: 1.5rem;
            }

            .add-customer-header h1 {
                font-size: 2rem;
            }

            .form-actions {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
<!-- Animated Book Pattern Background -->
<div class="book-pattern">
    <div class="floating-book" style="left: 10%; animation-delay: 0s;">📚</div>
    <div class="floating-book" style="left: 30%; animation-delay: 4s;">📖</div>
    <div class="floating-book" style="left: 50%; animation-delay: 8s;">📕</div>
    <div class="floating-book" style="left: 70%; animation-delay: 12s;">📗</div>
    <div class="floating-book" style="left: 90%; animation-delay: 16s;">📘</div>
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
            <i class="fas fa-book-open"></i>
            Book Haven
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a></li>
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link active">
                <i class="fas fa-users"></i> Customers
            </a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link">
                <i class="fas fa-book"></i> Books
            </a></li>
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link">
                <i class="fas fa-receipt"></i> Sales
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
    <!-- Page Header -->
    <div class="add-customer-header">
        <h1><i class="fas fa-user-plus"></i> Add New Customer</h1>
        <p>Register a new book lover to your community</p>
    </div>

    <!-- Display Error Messages -->
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="validation-summary show">
        <h4><i class="fas fa-exclamation-triangle"></i> Error</h4>
        <p><%= request.getAttribute("errorMessage") %></p>
    </div>
    <% } %>

    <!-- Validation Summary -->
    <div id="validationSummary" class="validation-summary">
        <h4><i class="fas fa-exclamation-circle"></i> Please correct the following errors:</h4>
        <ul id="validationList"></ul>
    </div>

    <!-- Success Notification -->
    <div id="successNotification" class="success-notification">
        <i class="fas fa-check-circle" style="font-size: 1.5rem;"></i>
        <div>
            <strong>Success!</strong><br>
            Customer added successfully!
        </div>
    </div>

    <!-- Progress Bar -->
    <div class="form-progress" id="formProgress"></div>

    <!-- Add Customer Form -->
    <div class="form-container">
        <form id="addCustomerForm" action="${pageContext.request.contextPath}/customer" method="post" novalidate>
            <input type="hidden" name="action" value="add">

            <!-- Personal Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-user-circle"></i>
                    Personal Information
                </h3>

                <div class="form-group">
                    <label for="name" class="required">Full Name</label>
                    <div class="input-group">
                        <span class="input-icon"><i class="fas fa-user"></i></span>
                        <input type="text"
                               id="name"
                               name="name"
                               class="form-control"
                               value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                               placeholder="Enter customer's full name"
                               required
                               maxlength="100">
                    </div>
                    <div class="help-text">
                        <i class="fas fa-info-circle"></i>
                        Enter the customer's complete name
                    </div>
                    <div id="nameError" class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span></span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email" class="required">Email Address</label>
                    <div class="input-group">
                        <span class="input-icon"><i class="fas fa-envelope"></i></span>
                        <input type="email"
                               id="email"
                               name="email"
                               class="form-control"
                               value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                               placeholder="customer@example.com"
                               required
                               maxlength="100">
                    </div>
                    <div class="help-text">
                        <i class="fas fa-info-circle"></i>
                        We'll use this for order confirmations and promotions
                    </div>
                    <div id="emailError" class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span></span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="phone" class="required">Phone Number</label>
                    <div class="input-group">
                        <span class="input-icon"><i class="fas fa-phone"></i></span>
                        <input type="tel"
                               id="phone"
                               name="phone"
                               class="form-control"
                               value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                               placeholder="Enter contact number"
                               required
                               maxlength="15">
                    </div>
                    <div class="help-text">
                        <i class="fas fa-info-circle"></i>
                        Include country code for international numbers
                    </div>
                    <div id="phoneError" class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span></span>
                    </div>
                </div>
            </div>

            <!-- Contact Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-map-marked-alt"></i>
                    Contact Information
                </h3>

                <div class="form-group">
                    <label for="address" class="required">Delivery Address</label>
                    <div class="input-group">
                        <span class="input-icon"><i class="fas fa-home"></i></span>
                        <textarea id="address"
                                  name="address"
                                  class="form-control"
                                  placeholder="Enter complete delivery address"
                                  required
                                  maxlength="500"
                                  rows="3"><%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %></textarea>
                    </div>
                    <div class="help-text">
                        <i class="fas fa-info-circle"></i>
                        Include street, city, and postal code for accurate delivery
                    </div>
                    <div id="addressError" class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <span></span>
                    </div>
                </div>
            </div>

            <!-- Membership Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-crown"></i>
                    Membership Information
                </h3>

                <div class="form-group">
                    <label for="membershipType">Initial Membership Type</label>
                    <div class="input-group">
                        <span class="input-icon"><i class="fas fa-award"></i></span>
                        <select id="membershipType"
                                name="membershipType"
                                class="form-control">
                            <option value="REGULAR" selected>Regular Member</option>
                            <option value="PREMIUM">Premium Member</option>
                            <option value="VIP">VIP Member</option>
                        </select>
                    </div>
                    <div class="help-text">
                        <i class="fas fa-info-circle"></i>
                        Membership will auto-upgrade based on purchase history
                    </div>
                </div>

                <div class="membership-benefits">
                    <h4 style="margin-bottom: 1rem; color: #2C3E50;">
                        <i class="fas fa-gift"></i> Membership Benefits
                    </h4>
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                        <div style="background: rgba(149, 165, 166, 0.1); padding: 1rem; border-radius: 10px;">
                            <strong style="color: #95A5A6;">Regular</strong>
                            <ul style="margin: 0.5rem 0 0 1rem; padding: 0;">
                                <li>5% discount</li>
                                <li>1 point per Rs10</li>
                            </ul>
                        </div>
                        <div style="background: rgba(243, 156, 18, 0.1); padding: 1rem; border-radius: 10px;">
                            <strong style="color: #F39C12;">Premium</strong>
                            <ul style="margin: 0.5rem 0 0 1rem; padding: 0;">
                                <li>10% discount</li>
                                <li>2 points per Rs10</li>
                            </ul>
                        </div>
                        <div style="background: rgba(231, 76, 60, 0.1); padding: 1rem; border-radius: 10px;">
                            <strong style="color: #E74C3C;">VIP</strong>
                            <ul style="margin: 0.5rem 0 0 1rem; padding: 0;">
                                <li>15% discount</li>
                                <li>3 points per Rs10</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="submit" id="submitBtn" class="btn-submit">
                    <span class="btn-text"><i class="fas fa-user-plus"></i> Add Customer</span>
                    <span class="btn-loading">
                            <span class="spinner"></span>
                            Adding Customer...
                        </span>
                </button>
                <a href="${pageContext.request.contextPath}/customer" class="btn-secondary">
                    <i class="fas fa-times"></i> Cancel
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
    const formProgress = document.getElementById('formProgress');

    // Field references
    const fields = {
        name: document.getElementById('name'),
        email: document.getElementById('email'),
        phone: document.getElementById('phone'),
        address: document.getElementById('address')
    };

    // Validation rules
    const validationRules = {
        name: {
            required: true,
            minLength: 2,
            maxLength: 100,
            pattern: /^[A-Za-z\s.']+$/,
            message: 'Name must contain only letters, spaces, dots, and apostrophes'
        },
        email: {
            required: true,
            pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
            message: 'Please enter a valid email address'
        },
        phone: {
            required: true,
            minLength: 7,
            maxLength: 15,
            pattern: /^[0-9\s\-\+\(\)]+$/,
            message: 'Phone must contain only numbers and formatting characters'
        },
        address: {
            required: true,
            minLength: 10,
            maxLength: 500,
            message: 'Address must be between 10 and 500 characters'
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
            errorMessage = `${fieldName.charAt(0).toUpperCase() + fieldName.slice(1)} is required`;
        }
        // Length checks
        else if (rule.minLength && value.length < rule.minLength) {
            isValid = false;
            errorMessage = `${fieldName.charAt(0).toUpperCase() + fieldName.slice(1)} must be at least ${rule.minLength} characters`;
        }
        else if (rule.maxLength && value.length > rule.maxLength) {
            isValid = false;
            errorMessage = `${fieldName.charAt(0).toUpperCase() + fieldName.slice(1)} must not exceed ${rule.maxLength} characters`;
        }
        // Pattern check
        else if (rule.pattern && !rule.pattern.test(value)) {
            isValid = false;
            errorMessage = rule.message;
        }

        // Update UI
        if (isValid) {
            field.classList.remove('error');
            field.classList.add('success');
            errorElement.classList.remove('show');
        } else {
            field.classList.add('error');
            field.classList.remove('success');
            errorElement.querySelector('span').textContent = errorMessage;
            errorElement.classList.add('show');
        }

        updateProgress();
        return isValid;
    }

    // Validate entire form
    function validateForm() {
        let isValid = true;
        const errors = [];

        for (const fieldName in fields) {
            if (!validateField(fieldName)) {
                isValid = false;
                errors.push(validationRules[fieldName].message || `Invalid ${fieldName}`);
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

    // Update progress bar
    function updateProgress() {
        const totalFields = Object.keys(fields).length;
        let filledFields = 0;

        for (const fieldName in fields) {
            if (fields[fieldName].value.trim() && !fields[fieldName].classList.contains('error')) {
                filledFields++;
            }
        }

        const progress = (filledFields / totalFields) * 100;
        formProgress.style.width = progress + '%';

        // Change color based on progress
        if (progress < 30) {
            formProgress.style.background = 'linear-gradient(90deg, #E74C3C 0%, #C0392B 100%)';
        } else if (progress < 70) {
            formProgress.style.background = 'linear-gradient(90deg, #F39C12 0%, #F1C40F 100%)';
        } else {
            formProgress.style.background = 'linear-gradient(90deg, #27AE60 0%, #2ECC71 100%)';
        }
    }

    // Add event listeners
    for (const fieldName in fields) {
        const field = fields[fieldName];

        field.addEventListener('blur', () => validateField(fieldName));
        field.addEventListener('input', () => {
            if (field.classList.contains('error')) {
                validateField(fieldName);
            }
            updateProgress();
        });

        // Add animation on focus
        field.addEventListener('focus', function() {
            this.parentElement.querySelector('.input-icon').style.color = '#4ECDC4';
        });

        field.addEventListener('blur', function() {
            this.parentElement.querySelector('.input-icon').style.color = '#7F8C8D';
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

            // Simulate form submission
            setTimeout(() => {
                form.submit();
            }, 1000);
        }
    });

    // Phone number formatting
    fields.phone.addEventListener('input', function() {
        let value = this.value.replace(/[^\d\s\-\+\(\)]/g, '');
        this.value = value;
    });

    // Email validation on blur
    fields.email.addEventListener('blur', function() {
        const emailValue = this.value.toLowerCase();
        this.value = emailValue;
    });

    // Auto-focus first field
    document.addEventListener('DOMContentLoaded', function() {
        fields.name.focus();
        updateProgress();
    });

    // Membership type change animation
    document.getElementById('membershipType').addEventListener('change', function() {
        const benefits = document.querySelector('.membership-benefits');
        benefits.style.animation = 'pulse 0.5s ease-out';
        setTimeout(() => {
            benefits.style.animation = '';
        }, 500);
    });

    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl + Enter to submit
        if (e.ctrlKey && e.key === 'Enter') {
            e.preventDefault();
            submitBtn.click();
        }

        // Escape to clear current field
        if (e.key === 'Escape') {
            const activeElement = document.activeElement;
            if (activeElement && (activeElement.tagName === 'INPUT' || activeElement.tagName === 'TEXTAREA')) {
                activeElement.value = '';
                activeElement.dispatchEvent(new Event('input'));
                validateField(activeElement.name);
            }
        }
    });

    // Save draft functionality
    function saveDraft() {
        const draft = {};
        for (const fieldName in fields) {
            draft[fieldName] = fields[fieldName].value;
        }
        localStorage.setItem('customerDraft', JSON.stringify(draft));
        showDraftSaved();
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
            updateProgress();
            showDraftLoaded();
        }
    }

    function clearDraft() {
        localStorage.removeItem('customerDraft');
    }

    // Show draft saved notification
    function showDraftSaved() {
        const notification = document.createElement('div');
        notification.style.cssText = `
                position: fixed;
                bottom: 2rem;
                right: 2rem;
                background: linear-gradient(135deg, #3498DB 0%, #2980B9 100%);
                color: white;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
                display: flex;
                align-items: center;
                gap: 0.5rem;
                z-index: 9999;
                animation: slideInRight 0.3s ease-out;
            `;
        notification.innerHTML = '<i class="fas fa-save"></i> Draft saved automatically';

        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease-out';
            setTimeout(() => notification.remove(), 300);
        }, 2000);
    }

    // Show draft loaded notification
    function showDraftLoaded() {
        const notification = document.createElement('div');
        notification.style.cssText = `
                position: fixed;
                bottom: 2rem;
                right: 2rem;
                background: linear-gradient(135deg, #9B59B6 0%, #8E44AD 100%);
                color: white;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(155, 89, 182, 0.3);
                display: flex;
                align-items: center;
                gap: 0.5rem;
                z-index: 9999;
                animation: slideInRight 0.3s ease-out;
            `;
        notification.innerHTML = '<i class="fas fa-history"></i> Previous draft restored';

        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease-out';
            setTimeout(() => notification.remove(), 300);
        }, 2000);
    }

    // Auto-save draft on input
    let saveTimeout;
    for (const fieldName in fields) {
        fields[fieldName].addEventListener('input', function() {
            clearTimeout(saveTimeout);
            saveTimeout = setTimeout(saveDraft, 1000);
        });
    }

    // Load draft on page load
    loadDraft();

    // Clear draft on successful submission
    form.addEventListener('submit', function() {
        if (validateForm()) {
            clearDraft();
        }
    });

    // Enhanced field interactions
    function addFieldEnhancements() {
        // Name field - capitalize first letters
        fields.name.addEventListener('blur', function() {
            const words = this.value.split(' ');
            const capitalized = words.map(word =>
                word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()
            ).join(' ');
            this.value = capitalized;
            validateField('name');
        });

        // Email field - check uniqueness (simulated)
        fields.email.addEventListener('blur', function() {
            const email = this.value;
            if (email && validateField('email')) {
                checkEmailUniqueness(email);
            }
        });

        // Phone field - format and detect country
        fields.phone.addEventListener('input', function() {
            const countryFlag = detectPhoneCountry(this.value);
            updatePhoneFlag(countryFlag);
        });

        // Address field - suggestions
        setupAddressSuggestions();
    }

    // Check email uniqueness (simulated)
    function checkEmailUniqueness(email) {
        const emailField = fields.email;
        const emailError = document.getElementById('emailError');

        // Simulate checking
        emailField.style.borderColor = '#F39C12';
        emailError.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Checking availability...';
        emailError.classList.add('show');
        emailError.style.color = '#F39C12';

        setTimeout(() => {
            // Simulate random result
            const isUnique = Math.random() > 0.3;

            if (isUnique) {
                emailField.classList.remove('error');
                emailField.classList.add('success');
                emailError.innerHTML = '<i class="fas fa-check-circle"></i> Email is available';
                emailError.style.color = '#27AE60';

                setTimeout(() => {
                    emailError.classList.remove('show');
                }, 2000);
            } else {
                emailField.classList.add('error');
                emailField.classList.remove('success');
                emailError.innerHTML = '<i class="fas fa-times-circle"></i> Email already exists';
                emailError.style.color = '#E74C3C';
            }
        }, 1000);
    }

    // Detect phone country
    function detectPhoneCountry(phone) {
        if (phone.startsWith('+94') || phone.startsWith('0')) return '🇱🇰';
        if (phone.startsWith('+1')) return '🇺🇸';
        if (phone.startsWith('+91')) return '🇮🇳';
        if (phone.startsWith('+44')) return '🇬🇧';
        if (phone.startsWith('+61')) return '🇦🇺';
        if (phone.startsWith('+81')) return '🇯🇵';
        if (phone.startsWith('+86')) return '🇨🇳';
        return '🌍';
    }

    // Update phone flag
    function updatePhoneFlag(flag) {
        let flagElement = document.getElementById('phoneFlag');
        if (!flagElement) {
            flagElement = document.createElement('span');
            flagElement.id = 'phoneFlag';
            flagElement.style.cssText = `
                    position: absolute;
                    right: 15px;
                    top: 50%;
                    transform: translateY(-50%);
                    font-size: 1.2rem;
                    transition: all 0.3s ease;
                `;
            fields.phone.parentElement.appendChild(flagElement);
        }
        flagElement.textContent = flag;
    }

    // Setup address suggestions
    function setupAddressSuggestions() {
        const suggestions = [
            'Colombo, Sri Lanka',
            'Kandy, Sri Lanka',
            'Galle, Sri Lanka',
            'Jaffna, Sri Lanka',
            'Negombo, Sri Lanka',
            'Anuradhapura, Sri Lanka',
            'Batticaloa, Sri Lanka',
            'Matara, Sri Lanka'
        ];

        const suggestionBox = document.createElement('div');
        suggestionBox.id = 'addressSuggestions';
        suggestionBox.style.cssText = `
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background: white;
                border: 2px solid #E9ECEF;
                border-top: none;
                border-radius: 0 0 15px 15px;
                max-height: 200px;
                overflow-y: auto;
                display: none;
                z-index: 1000;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            `;

        fields.address.parentElement.style.position = 'relative';
        fields.address.parentElement.appendChild(suggestionBox);

        fields.address.addEventListener('input', function() {
            const value = this.value.toLowerCase();
            if (value.length < 2) {
                suggestionBox.style.display = 'none';
                return;
            }

            const matches = suggestions.filter(s => s.toLowerCase().includes(value));

            if (matches.length > 0) {
                suggestionBox.innerHTML = matches.map(match => `
                        <div class="suggestion-item" style="
                            padding: 12px 15px;
                            cursor: pointer;
                            transition: background 0.2s;
                            border-bottom: 1px solid #F8F9FA;
                        " onmouseover="this.style.background='#F8F9FA'"
                           onmouseout="this.style.background='white'">
                            <i class="fas fa-map-marker-alt" style="color: #E74C3C; margin-right: 8px;"></i>
                            ${match}
                        </div>
                    `).join('');

                suggestionBox.style.display = 'block';

                // Add click handlers
                suggestionBox.querySelectorAll('.suggestion-item').forEach(item => {
                    item.addEventListener('click', function() {
                        fields.address.value = this.textContent.trim();
                        suggestionBox.style.display = 'none';
                        validateField('address');
                    });
                });
            } else {
                suggestionBox.style.display = 'none';
            }
        });

        // Hide on click outside
        document.addEventListener('click', function(e) {
            if (!fields.address.contains(e.target) && !suggestionBox.contains(e.target)) {
                suggestionBox.style.display = 'none';
            }
        });
    }

    // Initialize field enhancements
    addFieldEnhancements();

    // Add floating label effect
    function addFloatingLabels() {
        for (const fieldName in fields) {
            const field = fields[fieldName];
            const label = field.parentElement.parentElement.querySelector('label');

            if (field.value) {
                label.style.color = '#4ECDC4';
            }

            field.addEventListener('focus', function() {
                label.style.color = '#4ECDC4';
                label.style.transform = 'translateY(-2px)';
            });

            field.addEventListener('blur', function() {
                if (!this.value) {
                    label.style.color = '#2C3E50';
                    label.style.transform = 'translateY(0)';
                }
            });
        }
    }

    addFloatingLabels();

    // Add tooltip helper
    function addTooltips() {
        const tooltips = {
            name: 'Full name as it appears on official documents',
            email: 'We\'ll send order confirmations and special offers here',
            phone: 'For delivery updates and customer service',
            address: 'Complete address for accurate book delivery'
        };

        for (const fieldName in tooltips) {
            const field = fields[fieldName];
            const tooltip = document.createElement('span');
            tooltip.style.cssText = `
                    position: absolute;
                    right: 10px;
                    top: 50%;
                    transform: translateY(-50%);
                    font-size: 1rem;
                    color: #3498DB;
                    cursor: help;
                    transition: all 0.3s ease;
                `;
            tooltip.innerHTML = '<i class="fas fa-question-circle"></i>';
            tooltip.title = tooltips[fieldName];

            field.parentElement.appendChild(tooltip);

            // Enhanced tooltip on hover
            tooltip.addEventListener('mouseenter', function(e) {
                const customTooltip = document.createElement('div');
                customTooltip.className = 'custom-tooltip';
                customTooltip.style.cssText = `
                        position: absolute;
                        bottom: 100%;
                        right: 0;
                        background: rgba(0,0,0,0.8);
                        color: white;
                        padding: 0.5rem 1rem;
                        border-radius: 8px;
                        font-size: 0.85rem;
                        white-space: nowrap;
                        margin-bottom: 5px;
                        z-index: 1000;
                        animation: fadeIn 0.3s ease;
                    `;
                customTooltip.textContent = this.title;
                this.appendChild(customTooltip);
            });

            tooltip.addEventListener('mouseleave', function() {
                const customTooltip = this.querySelector('.custom-tooltip');
                if (customTooltip) {
                    customTooltip.remove();
                }
            });
        }
    }

    addTooltips();

    // Success animation after form submission
    function showSuccessAndRedirect() {
        const successOverlay = document.createElement('div');
        successOverlay.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(39, 174, 96, 0.95);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 10000;
                animation: fadeIn 0.5s ease-out;
            `;

        successOverlay.innerHTML = `
                <div style="text-align: center; color: white; animation: bounceIn 0.8s ease-out;">
                    <div style="font-size: 5rem; margin-bottom: 1rem;">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h2 style="font-size: 2.5rem; margin-bottom: 1rem;">Success!</h2>
                    <p style="font-size: 1.3rem; margin-bottom: 2rem;">Customer has been added successfully</p>
                    <div style="display: flex; align-items: center; justify-content: center; gap: 1rem;">
                        <div class="spinner" style="
                            width: 30px;
                            height: 30px;
                            border: 3px solid rgba(255,255,255,0.3);
                            border-top-color: white;
                        "></div>
                        <p style="margin: 0;">Redirecting to customer list...</p>
                    </div>
                </div>
            `;

        document.body.appendChild(successOverlay);

        setTimeout(() => {
            window.location.href = '${pageContext.request.contextPath}/customer?success=Customer added successfully';
        }, 2000);
    }

    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
            @keyframes slideInRight {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

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

            @keyframes bounceIn {
                0% {
                    transform: scale(0.3);
                    opacity: 0;
                }
                50% {
                    transform: scale(1.05);
                }
                70% {
                    transform: scale(0.9);
                }
                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
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

            .form-section {
                transform: translateY(20px);
            }

            .input-icon {
                transition: all 0.3s ease;
            }

            .input-group:focus-within .input-icon {
                animation: pulse 0.5s ease;
            }
        `;
    document.head.appendChild(style);

    // Final initialization
    console.log('📚 Book Haven Customer Form initialized successfully!');
    console.log('💡 Tips: Use Ctrl+Enter to submit, Escape to clear field');

    // Show keyboard shortcuts on first visit
    if (!localStorage.getItem('customerFormVisited')) {
        localStorage.setItem('customerFormVisited', 'true');

        setTimeout(() => {
            const shortcutHint = document.createElement('div');
            shortcutHint.style.cssText = `
                    position: fixed;
                    bottom: 2rem;
                    left: 2rem;
                    background: linear-gradient(135deg, #3498DB 0%, #2980B9 100%);
                    color: white;
                    padding: 1.5rem;
                    border-radius: 15px;
                    box-shadow: 0 10px 30px rgba(52, 152, 219, 0.3);
                    max-width: 300px;
                    animation: slideInLeft 0.5s ease-out;
                    z-index: 1000;
                `;

            shortcutHint.innerHTML = `
                    <h4 style="margin: 0 0 0.5rem 0; display: flex; align-items: center; gap: 0.5rem;">
                        <i class="fas fa-keyboard"></i> Quick Tips
                    </h4>
                    <ul style="margin: 0; padding-left: 1.5rem; font-size: 0.9rem;">
                        <li>Press <kbd style="background: rgba(255,255,255,0.2); padding: 2px 6px; border-radius: 3px;">Ctrl + Enter</kbd> to submit</li>
                        <li>Press <kbd style="background: rgba(255,255,255,0.2); padding: 2px 6px; border-radius: 3px;">Escape</kbd> to clear field</li>
                        <li>Your progress is auto-saved</li>
                    </ul>
                    <button onclick="this.parentElement.remove()" style="
                        position: absolute;
                        top: 10px;
                        right: 10px;
                        background: none;
                        border: none;
                        color: white;
                        font-size: 1.2rem;
                        cursor: pointer;
                    ">
                        <i class="fas fa-times"></i>
                    </button>
                `;

            document.body.appendChild(shortcutHint);

            setTimeout(() => {
                if (document.body.contains(shortcutHint)) {
                    shortcutHint.style.animation = 'slideOutLeft 0.5s ease-out';
                    setTimeout(() => shortcutHint.remove(), 500);
                }
            }, 10000);
        }, 2000);
    }

    // Add animation keyframes for slideInLeft and slideOutLeft
    const additionalStyles = document.createElement('style');
    additionalStyles.textContent = `
            @keyframes slideInLeft {
                from {
                    transform: translateX(-100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            @keyframes slideOutLeft {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(-100%);
                    opacity: 0;
                }
            }
        `;
    document.head.appendChild(additionalStyles);

    // Performance optimization
    let resizeTimeout;
    window.addEventListener('resize', function() {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(function() {
            // Adjust form elements if needed
            updateProgress();
        }, 250);
    });

    // Prevent form resubmission on page refresh
    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
    }
</script>
</body>
</html>
