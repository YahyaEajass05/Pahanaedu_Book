<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        * {
            font-family: 'Poppins', sans-serif;
        }

        /* Animation Keyframes */
        @keyframes slideInDown {
            0% { transform: translateY(-100px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        @keyframes slideInUp {
            0% { transform: translateY(50px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        @keyframes slideInLeft {
            0% { transform: translateX(-50px); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideInRight {
            0% { transform: translateX(50px); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }

        @keyframes fadeInScale {
            0% { transform: scale(0.8); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        @keyframes wiggle {
            0%, 7%, 14%, 21%, 28%, 35%, 42%, 49%, 56%, 63%, 70%, 77%, 84%, 91%, 98%, 100% { transform: rotate(0deg); }
            3.5%, 10.5%, 17.5%, 24.5%, 31.5%, 38.5%, 45.5%, 52.5%, 59.5%, 66.5%, 73.5%, 80.5%, 87.5%, 94.5% { transform: rotate(3deg); }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes glow {
            0%, 100% { box-shadow: 0 0 15px rgba(138, 43, 226, 0.3); }
            50% { box-shadow: 0 0 30px rgba(138, 43, 226, 0.7); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        /* Main Styles */
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #8A2BE2 100%);
            min-height: 100vh;
            padding: 0;
            margin: 0;
        }

        .add-item-header {
            background: linear-gradient(145deg, #FF1744 0%, #E91E63 50%, #9C27B0 100%);
            color: white;
            padding: 3rem 2rem;
            margin: 2rem auto 3rem;
            max-width: 900px;
            border-radius: 25px;
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: slideInDown 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 20px 40px rgba(255, 23, 68, 0.3);
        }

        .add-item-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            transform: rotate(45deg);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .add-item-header h1 {
            margin: 0 0 1rem 0;
            font-size: 3.2rem;
            font-weight: 800;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            position: relative;
            z-index: 2;
        }

        .add-item-header h1 i {
            animation: wiggle 2s infinite, float 3s infinite;
            margin-right: 15px;
        }

        .add-item-header p {
            margin: 0;
            font-size: 1.4rem;
            opacity: 0.95;
            position: relative;
            z-index: 2;
            font-weight: 300;
        }

        .form-container {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9ff 100%);
            padding: 3rem;
            border-radius: 30px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
            max-width: 900px;
            margin: 0 auto 3rem;
            position: relative;
            overflow: hidden;
            animation: fadeInScale 0.8s ease-out 0.3s both;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #FF1744, #E91E63, #9C27B0, #667eea, #764ba2);
            border-radius: 30px 30px 0 0;
        }

        .form-section {
            margin-bottom: 3rem;
            padding: 2rem;
            background: rgba(255,255,255,0.7);
            border-radius: 20px;
            border: 1px solid rgba(138, 43, 226, 0.1);
            transition: all 0.3s ease;
            animation: slideInUp 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .form-section:nth-child(odd) {
            animation: slideInLeft 0.6s ease-out;
        }

        .form-section:nth-child(even) {
            animation: slideInRight 0.6s ease-out;
        }

        .form-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(138, 43, 226, 0.2);
            border-color: rgba(138, 43, 226, 0.3);
        }

        .form-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(138, 43, 226, 0.1), transparent);
            transition: left 0.5s;
        }

        .form-section:hover::before {
            left: 100%;
        }

        .form-section:last-child {
            margin-bottom: 0;
        }

        .section-title {
            color: #4A148C;
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .section-title i {
            font-size: 2rem;
            color: #E91E63;
            animation: pulse 2s infinite;
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
            animation: fadeInScale 0.5s ease-out;
        }

        .form-group:nth-child(odd) {
            animation-delay: 0.1s;
        }

        .form-group:nth-child(even) {
            animation-delay: 0.2s;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #4A148C;
            position: relative;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .required::after {
            content: ' ⚡';
            color: #FF1744;
            font-weight: bold;
            font-size: 1.2rem;
            animation: pulse 1s infinite;
        }

        .form-control {
            width: 100%;
            padding: 1rem 1.2rem;
            border: 3px solid #E1BEE7;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: 500;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            background: linear-gradient(145deg, #fafafa 0%, #ffffff 100%);
            position: relative;
        }

        .form-control:focus {
            outline: none;
            border-color: #9C27B0;
            background: linear-gradient(145deg, #ffffff 0%, #f3e5f5 100%);
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(156, 39, 176, 0.3);
            animation: glow 0.5s ease-out;
        }

        .form-control:valid:not(:placeholder-shown) {
            border-color: #4CAF50;
            background: linear-gradient(145deg, #ffffff 0%, #e8f5e8 100%);
        }

        .form-control.error {
            border-color: #FF1744;
            background: linear-gradient(145deg, #ffffff 0%, #ffebee 100%);
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .input-group {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #9C27B0;
            font-size: 1.3rem;
            pointer-events: none;
            z-index: 2;
            transition: all 0.3s ease;
        }

        .input-group .form-control:focus + .input-icon,
        .input-group:focus-within .input-icon {
            color: #FF1744;
            transform: translateY(-50%) scale(1.2);
            animation: wiggle 0.5s ease-out;
        }

        .input-group .form-control {
            padding-left: 3rem;
        }

        .currency-input {
            position: relative;
        }

        .currency-symbol {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #4CAF50;
            font-weight: 800;
            font-size: 1.2rem;
            pointer-events: none;
            z-index: 2;
            background: linear-gradient(45deg, #4CAF50, #8BC34A);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .currency-input .form-control {
            padding-left: 3.5rem;
        }

        .help-text {
            font-size: 0.9rem;
            color: #7B1FA2;
            margin-top: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 500;
        }

        .help-text i {
            animation: float 3s infinite;
        }

        .error-message {
            color: #FF1744;
            font-size: 0.95rem;
            font-weight: 600;
            margin-top: 8px;
            display: none;
            align-items: center;
            gap: 8px;
            animation: slideInUp 0.3s ease-out;
        }

        .error-message.show {
            display: flex;
        }

        .error-message i {
            animation: wiggle 1s infinite;
        }

        .form-actions {
            display: flex;
            gap: 2rem;
            justify-content: center;
            margin-top: 3rem;
            padding-top: 3rem;
            border-top: 3px dashed #E1BEE7;
            animation: slideInUp 0.8s ease-out 0.5s both;
        }

        .btn-submit {
            background: linear-gradient(145deg, #FF1744 0%, #E91E63 50%, #9C27B0 100%);
            color: white;
            padding: 1.2rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            position: relative;
            overflow: hidden;
            min-width: 200px;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 10px 25px rgba(255, 23, 68, 0.4);
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .btn-submit:hover:not(:disabled) {
            background: linear-gradient(145deg, #D50000 0%, #C2185B 50%, #7B1FA2 100%);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(255, 23, 68, 0.6);
            animation: pulse 0.5s ease-out;
        }

        .btn-submit:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .btn-loading {
            display: none;
            align-items: center;
            gap: 10px;
        }

        .spinner {
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .validation-summary {
            background: linear-gradient(145deg, #FFF3E0 0%, #FFE0B2 100%);
            border: 2px solid #FF9800;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            display: none;
            animation: slideInDown 0.5s ease-out;
            box-shadow: 0 10px 20px rgba(255, 152, 0, 0.2);
        }

        .validation-summary.show {
            display: block;
        }

        .validation-summary h4 {
            color: #E65100;
            margin: 0 0 1rem 0;
            font-size: 1.1rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .validation-summary h4 i {
            animation: wiggle 1s infinite;
        }

        .validation-summary ul {
            margin: 0;
            padding-left: 2rem;
            color: #E65100;
        }

        .validation-summary li {
            margin-bottom: 5px;
            font-weight: 500;
        }

        .example-box {
            background: linear-gradient(145deg, #E3F2FD 0%, #BBDEFB 100%);
            border: 2px solid #2196F3;
            border-left: 5px solid #1976D2;
            padding: 1.2rem;
            margin-top: 10px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .example-box:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(33, 150, 243, 0.3);
        }

        .example-box h5 {
            margin: 0 0 8px 0;
            color: #0D47A1;
            font-size: 1rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .example-box h5 i {
            animation: float 3s infinite;
        }

        .example-box p {
            margin: 0;
            font-size: 0.95rem;
            color: #1565C0;
            font-family: 'Courier New', monospace;
            font-weight: 600;
            background: rgba(255,255,255,0.7);
            padding: 8px 12px;
            border-radius: 8px;
        }

        .price-calculator {
            background: linear-gradient(145deg, #F1F8E9 0%, #DCEDC8 100%);
            border: 2px solid #8BC34A;
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 1.5rem;
            transition: all 0.3s ease;
            animation: fadeInScale 0.5s ease-out;
        }

        .price-calculator:hover {
            transform: scale(1.02);
            box-shadow: 0 10px 25px rgba(139, 195, 74, 0.3);
        }

        .price-calculator h5 {
            margin: 0 0 1rem 0;
            color: #33691E;
            font-size: 1.2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .price-calculator h5 i {
            animation: float 3s infinite;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin: 8px 0;
            font-size: 1rem;
            font-weight: 500;
            padding: 8px 12px;
            background: rgba(255,255,255,0.5);
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .price-row:hover {
            background: rgba(255,255,255,0.8);
            transform: translateX(5px);
        }

        .price-row.total {
            border-top: 2px solid #689F38;
            margin-top: 1rem;
            padding-top: 1rem;
            font-weight: 800;
            color: #33691E;
            font-size: 1.1rem;
            background: linear-gradient(145deg, rgba(255,255,255,0.8), rgba(139, 195, 74, 0.1));
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-container {
                padding: 2rem 1.5rem;
                margin: 1rem;
                border-radius: 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .form-actions {
                flex-direction: column;
                align-items: center;
            }

            .add-item-header {
                margin: 1rem;
                padding: 2rem 1.5rem;
                border-radius: 20px;
            }

            .add-item-header h1 {
                font-size: 2.5rem;
            }

            .form-section {
                padding: 1.5rem;
            }

            .section-title {
                font-size: 1.4rem;
            }
        }

        /* Additional Enhancements */
        .form-group::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, #FF1744, #E91E63, #9C27B0);
            transition: width 0.3s ease;
            border-radius: 1px;
        }

        .form-group:focus-within::before {
            width: 100%;
        }

        .btn-secondary {
            background: linear-gradient(145deg, #607D8B 0%, #455A64 100%);
            color: white;
            padding: 1.2rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 700;
            text-decoration: none;
            display: inline-block;
            transition: all 0.4s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 10px 25px rgba(96, 125, 139, 0.4);
        }

        .btn-secondary:hover {
            background: linear-gradient(145deg, #455A64 0%, #263238 100%);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(96, 125, 139, 0.6);
            color: white;
            text-decoration: none;
        }

        /* Loading animation for form sections */
        .form-section {
            opacity: 0;
            animation: fadeInScale 0.6s ease-out forwards;
        }

        .form-section:nth-child(1) { animation-delay: 0.1s; }
        .form-section:nth-child(2) { animation-delay: 0.2s; }
        .form-section:nth-child(3) { animation-delay: 0.3s; }
        .form-section:nth-child(4) { animation-delay: 0.4s; }
    </style>
</head>
<body>
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
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link">Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link active">Items</a></li>
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link">Billing</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link">Help</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- Page Header -->
    <div class="add-item-header">
        <h1><i class="fas fa-plus-circle"></i>Add New Item</h1>
        <p><i class="fas fa-book-reader"></i>Add a new book or educational material to your inventory</p>
    </div>

    <!-- Display Error Messages -->
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <i class="icon-error">✗</i>
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <!-- Validation Summary -->
    <div id="validationSummary" class="validation-summary">
        <h4><i class="fas fa-exclamation-triangle"></i>Please fix the following errors:</h4>
        <ul id="validationList"></ul>
    </div>

    <!-- Add Item Form -->
    <div class="form-container">
        <form id="addItemForm" action="${pageContext.request.contextPath}/item" method="post" novalidate>
            <input type="hidden" name="action" value="add">

            <!-- Basic Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-info-circle"></i>Basic Information
                </h3>

                <div class="form-row">
                    <div class="form-group">
                        <label for="itemId" class="required">Item ID</label>
                        <div class="input-group">
                            <input type="text"
                                   id="itemId"
                                   name="itemId"
                                   class="form-control"
                                   value="<%= request.getAttribute("itemId") != null ? request.getAttribute("itemId") : "" %>"
                                   placeholder="Enter unique item ID"
                                   required
                                   maxlength="20"
                                   pattern="[A-Za-z0-9_-]+">
                            <i class="fas fa-tag input-icon"></i>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-lightbulb"></i> Use only letters, numbers, hyphens, and underscores (3-20 characters)
                        </div>
                        <div id="itemIdError" class="error-message">
                            <i class="fas fa-times-circle"></i> <span></span>
                        </div>
                        <div class="example-box">
                            <h5><i class="fas fa-code"></i>Examples:</h5>
                            <p>BOOK001, MATH_G10, SCIENCE-11</p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="itemName" class="required">Item Name</label>
                        <div class="input-group">
                            <input type="text"
                                   id="itemName"
                                   name="itemName"
                                   class="form-control"
                                   value="<%= request.getAttribute("itemName") != null ? request.getAttribute("itemName") : "" %>"
                                   placeholder="Enter item name"
                                   required
                                   maxlength="100">
                            <i class="fas fa-book-open input-icon"></i>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-pen-fancy"></i> Enter the complete name or title of the book/material
                        </div>
                        <div id="itemNameError" class="error-message">
                            <i class="fas fa-times-circle"></i> <span></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pricing & Stock Section -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-coins"></i>Pricing & Stock Information
                </h3>

                <div class="form-row">
                    <div class="form-group">
                        <label for="price" class="required">Price (LKR)</label>
                        <div class="currency-input">
                            <span class="currency-symbol">LKR</span>
                            <input type="number"
                                   id="price"
                                   name="price"
                                   class="form-control"
                                   value="<%= request.getAttribute("price") != null ? request.getAttribute("price") : "" %>"
                                   placeholder="0.00"
                                   required
                                   min="0.01"
                                   max="999999.99"
                                   step="0.01">
                        </div>
                        <div class="help-text">
                            <i class="fas fa-money-bill-wave"></i> Enter the selling price in Sri Lankan Rupees
                        </div>
                        <div id="priceError" class="error-message">
                            <i class="fas fa-times-circle"></i> <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="stock" class="required">Initial Stock Quantity</label>
                        <div class="input-group">
                            <input type="number"
                                   id="stock"
                                   name="stock"
                                   class="form-control"
                                   value="<%= request.getAttribute("stock") != null ? request.getAttribute("stock") : "0" %>"
                                   placeholder="Enter stock quantity"
                                   required
                                   min="0"
                                   max="9999">
                            <i class="fas fa-boxes input-icon"></i>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-warehouse"></i> Number of units available for sale
                        </div>
                        <div id="stockError" class="error-message">
                            <i class="fas fa-times-circle"></i> <span></span>
                        </div>
                    </div>
                </div>

                <!-- Price Calculator -->
                <div class="price-calculator" id="priceCalculator" style="display: none;">
                    <h5><i class="fas fa-calculator"></i>Inventory Value Calculator</h5>
                    <div class="price-row">
                        <span>Unit Price:</span>
                        <span id="calcUnitPrice">LKR 0.00</span>
                    </div>
                    <div class="price-row">
                        <span>Stock Quantity:</span>
                        <span id="calcQuantity">0 units</span>
                    </div>
                    <div class="price-row total">
                        <span>Total Inventory Value:</span>
                        <span id="calcTotalValue">LKR 0.00</span>
                    </div>
                </div>
            </div>

            <!-- Additional Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    <i class="fas fa-clipboard-list"></i>Additional Information
                </h3>

                <div class="form-group">
                    <label for="category">Category</label>
                    <div class="input-group">
                        <input type="text"
                               id="category"
                               name="category"
                               class="form-control"
                               value="<%= request.getAttribute("category") != null ? request.getAttribute("category") : "" %>"
                               placeholder="Enter item category"
                               list="categoryList"
                               maxlength="50">
                        <i class="fas fa-list input-icon"></i>
                        <datalist id="categoryList">
                            <option value="Textbooks">
                            <option value="Reference Books">
                            <option value="Fiction">
                            <option value="Non-Fiction">
                            <option value="Children's Books">
                            <option value="Academic">
                            <option value="Educational Materials">
                            <option value="Workbooks">
                            <option value="Study Guides">
                        </datalist>
                    </div>
                    <div class="help-text">
                        <i class="fas fa-tags"></i> Categorize the item for better organization (optional)
                    </div>
                    <div id="categoryError" class="error-message">
                        <i class="fas fa-times-circle"></i> <span></span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <div class="input-group">
                        <textarea id="description"
                                  name="description"
                                  class="form-control"
                                  placeholder="Enter item description (optional)"
                                  rows="4"
                                  maxlength="500"><%= request.getAttribute("description") != null ? request.getAttribute("description") : "" %></textarea>
                        <i class="fas fa-align-left input-icon"></i>
                    </div>
                    <div class="help-text">
                        <i class="fas fa-edit"></i> Add a detailed description, author, publisher, or other relevant information
                    </div>
                    <div id="descriptionError" class="error-message">
                        <i class="fas fa-times-circle"></i> <span></span>
                    </div>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="submit" id="submitBtn" class="btn-submit">
                    <span class="btn-text"><i class="fas fa-check-circle"></i> Add Item</span>
                    <span class="btn-loading">
                        <span class="spinner"></span>
                        Adding Item...
                    </span>
                </button>
                <a href="${pageContext.request.contextPath}/item" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    // Form validation
    const form = document.getElementById('addItemForm');
    const submitBtn = document.getElementById('submitBtn');
    const validationSummary = document.getElementById('validationSummary');
    const validationList = document.getElementById('validationList');
    const priceCalculator = document.getElementById('priceCalculator');

    // Field references
    const fields = {
        itemId: document.getElementById('itemId'),
        itemName: document.getElementById('itemName'),
        price: document.getElementById('price'),
        stock: document.getElementById('stock'),
        category: document.getElementById('category'),
        description: document.getElementById('description')
    };

    // Validation rules
    const validationRules = {
        itemId: {
            required: true,
            minLength: 3,
            maxLength: 20,
            pattern: /^[A-Za-z0-9_-]+$/,
            message: 'Item ID must be 3-20 characters long and contain only letters, numbers, hyphens, and underscores'
        },
        itemName: {
            required: true,
            minLength: 2,
            maxLength: 100,
            message: 'Item name must be 2-100 characters long'
        },
        price: {
            required: true,
            min: 0.01,
            max: 999999.99,
            message: 'Price must be between LKR 0.01 and LKR 999,999.99'
        },
        stock: {
            required: true,
            min: 0,
            max: 9999,
            message: 'Stock must be between 0 and 9999 units'
        },
        category: {
            required: false,
            maxLength: 50,
            message: 'Category must not exceed 50 characters'
        },
        description: {
            required: false,
            maxLength: 500,
            message: 'Description must not exceed 500 characters'
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
        else if (rule.min !== undefined && parseFloat(value) < rule.min) {
            isValid = false;
            errorMessage = `${fieldName} must be at least ${rule.min}`;
        }
        else if (rule.max !== undefined && parseFloat(value) > rule.max) {
            isValid = false;
            errorMessage = `${fieldName} must not exceed ${rule.max}`;
        }
        // Pattern check
        else if (rule.pattern && value && !rule.pattern.test(value)) {
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

    // Update price calculator
    function updatePriceCalculator() {
        const price = parseFloat(fields.price.value) || 0;
        const stock = parseInt(fields.stock.value) || 0;
        const totalValue = price * stock;

        document.getElementById('calcUnitPrice').textContent = `LKR ${price.toFixed(2)}`;
        document.getElementById('calcQuantity').textContent = `${stock} units`;
        document.getElementById('calcTotalValue').textContent = `LKR ${totalValue.toFixed(2)}`;

        if (price > 0 || stock > 0) {
            priceCalculator.style.display = 'block';
        } else {
            priceCalculator.style.display = 'none';
        }
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

            // Update calculator for price and stock fields
            if (fieldName === 'price' || fieldName === 'stock') {
                updatePriceCalculator();
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

            // Add submission animation
            submitBtn.style.animation = 'pulse 0.5s infinite';

            // Submit form
            setTimeout(() => {
                form.submit();
            }, 500);
        }
    });

    // Auto-generate item ID suggestion
    fields.itemName.addEventListener('input', function() {
        const name = this.value.trim();
        if (name && !fields.itemId.value) {
            const suggestion = name.substring(0, 4).toUpperCase().replace(/[^A-Z0-9]/g, '') +
                Math.floor(Math.random() * 100).toString().padStart(2, '0');
            fields.itemId.placeholder = `Suggestion: ${suggestion}`;
        }
    });

    // Auto-focus first field with animation
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(() => {
            fields.itemId.focus();
            fields.itemId.style.animation = 'glow 1s ease-out';
        }, 500);
        updatePriceCalculator();
    });

    // Save draft functionality
    function saveDraft() {
        const draft = {};
        for (const fieldName in fields) {
            draft[fieldName] = fields[fieldName].value;
        }
        localStorage.setItem('itemDraft', JSON.stringify(draft));
    }

    function loadDraft() {
        const draft = localStorage.getItem('itemDraft');
        if (draft) {
            const data = JSON.parse(draft);
            for (const fieldName in data) {
                if (fields[fieldName] && !fields[fieldName].value) {
                    fields[fieldName].value = data[fieldName];
                }
            }
            updatePriceCalculator();
        }
    }

    // Load draft on page load
    loadDraft();

    // Save draft on input with debounce
    let draftTimeout;
    for (const fieldName in fields) {
        fields[fieldName].addEventListener('input', function() {
            clearTimeout(draftTimeout);
            draftTimeout = setTimeout(saveDraft, 1000);
        });
    }

    // Clear draft on successful submission
    form.addEventListener('submit', function() {
        if (validateForm()) {
            localStorage.removeItem('itemDraft');
        }
    });

    // Add floating label effect
    for (const fieldName in fields) {
        const field = fields[fieldName];
        const label = field.parentElement.parentElement.querySelector('label');

        field.addEventListener('focus', function() {
            label.style.transform = 'translateY(-5px) scale(0.9)';
            label.style.color = '#9C27B0';
        });

        field.addEventListener('blur', function() {
            if (!field.value) {
                label.style.transform = 'translateY(0) scale(1)';
                label.style.color = '#4A148C';
            }
        });
    }

    // Add real-time character counter for text fields
    function addCharacterCounter(fieldName) {
        const field = fields[fieldName];
        const maxLength = validationRules[fieldName].maxLength;

        if (maxLength) {
            const counter = document.createElement('div');
            counter.style.cssText = `
                position: absolute;
                right: 12px;
                bottom: 12px;
                font-size: 0.8rem;
                color: #9C27B0;
                background: rgba(255,255,255,0.9);
                padding: 2px 6px;
                border-radius: 4px;
                transition: all 0.3s ease;
            `;

            field.parentElement.style.position = 'relative';
            field.parentElement.appendChild(counter);

            function updateCounter() {
                const remaining = maxLength - field.value.length;
                counter.textContent = `${remaining} left`;

                if (remaining < 20) {
                    counter.style.color = '#FF1744';
                    counter.style.animation = 'pulse 1s infinite';
                } else {
                    counter.style.color = '#9C27B0';
                    counter.style.animation = 'none';
                }
            }

            field.addEventListener('input', updateCounter);
            updateCounter();
        }
    }

    // Add character counters to relevant fields
    addCharacterCounter('itemId');
    addCharacterCounter('itemName');
    addCharacterCounter('category');
    addCharacterCounter('description');

    // Add progressive form enhancement
    function enhanceFormExperience() {
        // Add smooth transitions to form sections
        const sections = document.querySelectorAll('.form-section');
        sections.forEach((section, index) => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(20px)';

            setTimeout(() => {
                section.style.transition = 'all 0.6s cubic-bezier(0.25, 0.8, 0.25, 1)';
                section.style.opacity = '1';
                section.style.transform = 'translateY(0)';
            }, 100 * (index + 1));
        });

        // Add interactive feedback sounds (if supported)
        function playFeedbackSound(type) {
            if (window.AudioContext || window.webkitAudioContext) {
                const audioContext = new (window.AudioContext || window.webkitAudioContext)();
                const oscillator = audioContext.createOscillator();
                const gainNode = audioContext.createGain();

                oscillator.connect(gainNode);
                gainNode.connect(audioContext.destination);

                if (type === 'success') {
                    oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
                    oscillator.frequency.setValueAtTime(1000, audioContext.currentTime + 0.1);
                } else if (type === 'error') {
                    oscillator.frequency.setValueAtTime(300, audioContext.currentTime);
                    oscillator.frequency.setValueAtTime(200, audioContext.currentTime + 0.1);
                }

                gainNode.gain.setValueAtTime(0.1, audioContext.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.2);

                oscillator.start(audioContext.currentTime);
                oscillator.stop(audioContext.currentTime + 0.2);
            }
        }

        // Add haptic feedback for mobile devices
        function addHapticFeedback(type) {
            if (navigator.vibrate) {
                if (type === 'success') {
                    navigator.vibrate(50);
                } else if (type === 'error') {
                    navigator.vibrate([50, 100, 50]);
                }
            }
        }

        // Enhance validation feedback
        const originalValidateField = validateField;
        validateField = function(fieldName) {
            const result = originalValidateField(fieldName);

            if (result) {
                playFeedbackSound('success');
                addHapticFeedback('success');
            } else {
                playFeedbackSound('error');
                addHapticFeedback('error');
            }

            return result;
        };
    }

    // Initialize enhanced form experience
    enhanceFormExperience();

    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl/Cmd + S to save draft
        if ((e.ctrlKey || e.metaKey) && e.key === 's') {
            e.preventDefault();
            saveDraft();

            // Show save confirmation
            const saveIndicator = document.createElement('div');
            saveIndicator.textContent = '💾 Draft saved!';
            saveIndicator.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: linear-gradient(145deg, #4CAF50, #45a049);
                color: white;
                padding: 12px 24px;
                border-radius: 25px;
                font-weight: 600;
                z-index: 9999;
                animation: slideInRight 0.5s ease-out;
                box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
            `;

            document.body.appendChild(saveIndicator);

            setTimeout(() => {
                saveIndicator.style.animation = 'slideOutRight 0.5s ease-out';
                setTimeout(() => document.body.removeChild(saveIndicator), 500);
            }, 2000);
        }

        // Ctrl/Cmd + Enter to submit form
        if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
            e.preventDefault();
            form.dispatchEvent(new Event('submit'));
        }
    });

    // Add CSS for additional animations
    const additionalStyles = document.createElement('style');
    additionalStyles.textContent = `
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOutRight {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }

        .form-control:focus {
            animation: focusGlow 0.5s ease-out;
        }

        @keyframes focusGlow {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
    `;
    document.head.appendChild(additionalStyles);

    console.log('✨ Enhanced add item form initialized with animations and interactions');
</script>
</body>
</html>
