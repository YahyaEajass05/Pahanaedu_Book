<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help - Pahana Edu Management System</title>
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
            --info-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --card-shadow: 0 15px 35px rgba(0,0,0,0.1);
            --hover-shadow: 0 25px 50px rgba(0,0,0,0.25);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
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

        /* Hero Section */
        .help-hero {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 30px;
            color: white;
            padding: 4rem 2rem;
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            animation: slideInDown 0.8s ease-out;
        }

        .help-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        .help-hero-content {
            position: relative;
            z-index: 2;
        }

        .help-hero h1 {
            font-size: 3.5rem;
            margin: 0 0 1rem 0;
            font-weight: 800;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        .help-hero p {
            font-size: 1.3rem;
            margin: 0;
            opacity: 0.9;
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .help-hero .hero-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            animation: bounce 2s infinite;
        }

        /* Modern Navigation */
        .help-nav {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 2rem;
            margin-bottom: 3rem;
            box-shadow: var(--card-shadow);
            animation: slideInLeft 0.8s ease-out;
        }

        .help-nav h3 {
            margin: 0 0 2rem 0;
            color: #2c3e50;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
        }

        .nav-card {
            background: var(--primary-gradient);
            color: white;
            padding: 1.5rem;
            border-radius: 15px;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .nav-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }

        .nav-card:hover::before {
            left: 100%;
        }

        .nav-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: var(--hover-shadow);
        }

        .nav-card i {
            font-size: 2rem;
        }

        .nav-card-content h4 {
            margin: 0 0 0.5rem 0;
            font-size: 1.1rem;
        }

        .nav-card-content p {
            margin: 0;
            font-size: 0.9rem;
            opacity: 0.9;
        }

        /* Content Sections */
        .help-content {
            display: grid;
            gap: 3rem;
        }

        .help-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 0;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            animation: slideInUp 0.8s ease-out;
            transition: all 0.3s ease;
        }

        .help-section:hover {
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

        .section-header h2 {
            margin: 0;
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 1rem;
            position: relative;
            z-index: 2;
        }

        .section-content {
            padding: 2rem;
        }

        .section-content h3 {
            color: #2c3e50;
            margin: 2rem 0 1rem 0;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #667eea;
            width: fit-content;
        }

        .section-content p {
            line-height: 1.8;
            margin-bottom: 1.5rem;
            color: #555;
            font-size: 1rem;
        }

        .section-content ul, .section-content ol {
            margin-bottom: 1.5rem;
            padding-left: 2rem;
        }

        .section-content li {
            margin-bottom: 0.75rem;
            line-height: 1.7;
        }

        /* Feature Boxes */
        .feature-box {
            background: var(--success-gradient);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem 0;
            position: relative;
            overflow: hidden;
            animation: slideInLeft 0.6s ease-out;
        }

        .feature-box::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 100px;
            height: 100px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .feature-box h4 {
            margin: 0 0 1rem 0;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .feature-box ul {
            margin: 0;
            padding-left: 1.5rem;
        }

        .feature-box li {
            margin-bottom: 0.5rem;
        }

        .warning-box {
            background: var(--warning-gradient);
            color: #2d3436;
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem 0;
            position: relative;
            overflow: hidden;
            animation: slideInRight 0.6s ease-out;
            box-shadow: 0 10px 30px rgba(67, 233, 123, 0.3);
        }

        .warning-box::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -20%;
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.15);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite reverse;
        }

        .warning-box h4 {
            margin: 0 0 1rem 0;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 700;
        }

        .step-by-step {
            background: var(--info-gradient);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem 0;
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.6s ease-out;
        }

        .step-by-step::before {
            content: '';
            position: absolute;
            bottom: -30%;
            right: -10%;
            width: 120px;
            height: 120px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: pulse 3s ease-in-out infinite;
        }

        .step-by-step h4 {
            margin: 0 0 1rem 0;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Shortcut Keys */
        .shortcut-key {
            background: var(--dark-gradient);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-weight: bold;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            transition: all 0.3s ease;
        }

        .shortcut-key:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        }

        /* Contact Section */
        .contact-info {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            color: white;
            padding: 3rem;
            border-radius: 25px;
            margin-top: 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.8s ease-out;
        }

        .contact-info::before {
            content: '';
            position: absolute;
            top: -100%;
            left: -100%;
            width: 300%;
            height: 300%;
            background: conic-gradient(from 0deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: rotate 10s linear infinite;
        }

        .contact-info-content {
            position: relative;
            z-index: 2;
        }

        .contact-info h3 {
            color: white;
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .contact-info p {
            margin-bottom: 0.8rem;
            font-size: 1.1rem;
        }

        /* Back to Top Button */
        .back-to-top {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: var(--secondary-gradient);
            color: white;
            border: none;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            font-size: 1.5rem;
            cursor: pointer;
            box-shadow: var(--card-shadow);
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            display: none;
            z-index: 1000;
            animation: bounce 2s infinite;
        }

        .back-to-top:hover {
            transform: translateY(-5px) scale(1.1);
            box-shadow: var(--hover-shadow);
            animation: none;
        }

        .back-to-top.show {
            display: block;
            animation: slideInUp 0.3s ease-out;
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

        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.7;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .help-hero {
                padding: 3rem 1.5rem;
            }

            .help-hero h1 {
                font-size: 2.5rem;
            }

            .nav-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .section-header h2 {
                font-size: 1.5rem;
            }

            .back-to-top {
                width: 50px;
                height: 50px;
                font-size: 1.2rem;
                bottom: 1rem;
                right: 1rem;
            }
        }

        /* Scroll reveal animation */
        .reveal {
            opacity: 0;
            transform: translateY(50px);
            transition: all 0.6s ease;
        }

        .reveal.revealed {
            opacity: 1;
            transform: translateY(0);
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--secondary-gradient);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary-gradient);
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
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link">Billing</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link active">Help</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- Hero Section -->
    <div class="help-hero">
        <div class="help-hero-content">
            <div class="hero-icon">
                <i class="fas fa-question-circle"></i>
            </div>
            <h1><i class="fas fa-book-open"></i> Help & User Guide</h1>
            <p>Master the Pahana Edu Management System with our comprehensive guide</p>
        </div>
    </div>

    <!-- Quick Navigation -->
    <div class="help-nav reveal">
        <h3>
            <i class="fas fa-compass"></i>
            Quick Navigation
        </h3>
        <div class="nav-grid">
            <a href="#getting-started" class="nav-card">
                <i class="fas fa-rocket"></i>
                <div class="nav-card-content">
                    <h4>Getting Started</h4>
                    <p>Begin your journey with system basics</p>
                </div>
            </a>
            <a href="#customer-management" class="nav-card">
                <i class="fas fa-users"></i>
                <div class="nav-card-content">
                    <h4>Customer Management</h4>
                    <p>Manage customer accounts efficiently</p>
                </div>
            </a>
            <a href="#item-management" class="nav-card">
                <i class="fas fa-boxes"></i>
                <div class="nav-card-content">
                    <h4>Item Management</h4>
                    <p>Control your inventory and products</p>
                </div>
            </a>
            <a href="#billing-system" class="nav-card">
                <i class="fas fa-file-invoice-dollar"></i>
                <div class="nav-card-content">
                    <h4>Billing System</h4>
                    <p>Generate and manage invoices</p>
                </div>
            </a>
            <a href="#tips-tricks" class="nav-card">
                <i class="fas fa-lightbulb"></i>
                <div class="nav-card-content">
                    <h4>Tips & Tricks</h4>
                    <p>Productivity hacks and shortcuts</p>
                </div>
            </a>
            <a href="#troubleshooting" class="nav-card">
                <i class="fas fa-tools"></i>
                <div class="nav-card-content">
                    <h4>Troubleshooting</h4>
                    <p>Solve common issues quickly</p>
                </div>
            </a>
        </div>
    </div>

    <div class="help-content">
        <!-- Getting Started Section -->
        <section id="getting-started" class="help-section reveal">
            <div class="section-header">
                <h2>
                    <i class="fas fa-rocket"></i>
                    Getting Started
                </h2>
            </div>
            <div class="section-content">
                <h3><i class="fas fa-eye"></i> System Overview</h3>
                <p>The Pahana Edu Management System is your complete solution for managing bookshop operations. Our intuitive platform streamlines customer management, inventory tracking, and billing processes to maximize your business efficiency.</p>

                <div class="feature-box">
                    <h4><i class="fas fa-star"></i> Main Features</h4>
                    <ul>
                        <li><strong><i class="fas fa-tachometer-alt"></i> Dashboard:</strong> Real-time business metrics and quick access hub</li>
                        <li><strong><i class="fas fa-users"></i> Customer Management:</strong> Complete customer lifecycle management</li>
                        <li><strong><i class="fas fa-warehouse"></i> Item Management:</strong> Advanced inventory control and pricing</li>
                        <li><strong><i class="fas fa-cash-register"></i> Billing System:</strong> Professional invoicing with automated calculations</li>
                    </ul>
                </div>

                <h3><i class="fas fa-cog"></i> First Time Setup</h3>
                <div class="step-by-step">
                    <h4><i class="fas fa-list-ol"></i> Step-by-Step Setup</h4>
                    <ol>
                        <li><i class="fas fa-sign-in-alt"></i> Log in using your admin credentials (username: admin, password: admin123)</li>
                        <li><i class="fas fa-user-plus"></i> Add customer information in the Customer Management section</li>
                        <li><i class="fas fa-plus-circle"></i> Add book items and set inventory in the Item Management section</li>
                        <li><i class="fas fa-receipt"></i> Start generating bills for customers using the Billing System</li>
                        <li><i class="fas fa-chart-line"></i> Monitor your business through the Dashboard</li>
                    </ol>
                </div>
            </div>
        </section>

        <!-- Customer Management Section -->
        <section id="customer-management" class="help-section reveal">
            <div class="section-header">
                <h2>
                    <i class="fas fa-users"></i>
                    Customer Management
                </h2>
            </div>
            <div class="section-content">
                <h3><i class="fas fa-user-plus"></i> Adding New Customers</h3>
                <p>Streamline customer onboarding with our intuitive registration process:</p>
                <ol>
                    <li><i class="fas fa-mouse-pointer"></i> Navigate to <strong>Customers</strong> from the main menu</li>
                    <li><i class="fas fa-plus"></i> Click <strong>"Add New Customer"</strong></li>
                    <li><i class="fas fa-edit"></i> Fill in the required information:
                        <ul>
                            <li><strong><i class="fas fa-id-card"></i> Account Number:</strong> Unique identifier (e.g., CUST001)</li>
                            <li><strong><i class="fas fa-user"></i> Name:</strong> Customer's full name</li>
                            <li><strong><i class="fas fa-map-marker-alt"></i> Address:</strong> Complete address</li>
                            <li><strong><i class="fas fa-phone"></i> Telephone:</strong> Contact number</li>
                            <li><strong><i class="fas fa-calculator"></i> Units Consumed:</strong> Initial reading (usually 0)</li>
                        </ul>
                    </li>
                    <li><i class="fas fa-save"></i> Click <strong>"Save Customer"</strong></li>
                </ol>

                <h3><i class="fas fa-tasks"></i> Managing Existing Customers</h3>
                <div class="feature-box">
                    <h4><i class="fas fa-tools"></i> Available Actions</h4>
                    <ul>
                        <li><strong><i class="fas fa-eye"></i> View:</strong> Complete customer profile and transaction history</li>
                        <li><strong><i class="fas fa-edit"></i> Edit:</strong> Update customer information and preferences</li>
                        <li><strong><i class="fas fa-trash-alt"></i> Delete:</strong> Remove customer from system (use with caution)</li>
                    </ul>
                </div>

                <div class="warning-box">
                    <h4><i class="fas fa-exclamation-triangle"></i> Important Notes</h4>
                    <ul>
                        <li><i class="fas fa-lock"></i> Account numbers must be unique and cannot be changed after creation</li>
                        <li><i class="fas fa-history"></i> Deleting a customer will also delete their billing history</li>
                        <li><i class="fas fa-chart-bar"></i> Units consumed directly affects billing calculations</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Item Management Section -->
        <section id="item-management" class="help-section reveal">
            <div class="section-header">
                <h2>
                    <i class="fas fa-boxes"></i>
                    Item Management
                </h2>
            </div>
            <div class="section-content">
                <h3><i class="fas fa-plus-square"></i> Adding New Items</h3>
                <p>Efficiently manage your inventory with our comprehensive item system:</p>
                <ol>
                    <li><i class="fas fa-arrow-right"></i> Go to <strong>Items</strong> from the main menu</li>
                    <li><i class="fas fa-plus-circle"></i> Click <strong>"Add New Item"</strong></li>
                    <li><i class="fas fa-keyboard"></i> Enter item details:
                        <ul>
                            <li><strong><i class="fas fa-barcode"></i> Item ID:</strong> Unique code (e.g., BOOK001)</li>
                            <li><strong><i class="fas fa-tag"></i> Item Name:</strong> Book title or product name</li>
                            <li><strong><i class="fas fa-dollar-sign"></i> Price:</strong> Selling price in LKR</li>
                            <li><strong><i class="fas fa-cubes"></i> Stock:</strong> Available quantity</li>
                        </ul>
                    </li>
                    <li><i class="fas fa-check"></i> Save the item</li>
                </ol>

                <h3><i class="fas fa-warehouse"></i> Stock Management</h3>
                <div class="feature-box">
                    <h4><i class="fas fa-chart-pie"></i> Stock Features</h4>
                    <ul>
                        <li><strong><i class="fas fa-bell"></i> Low Stock Alerts:</strong> System warns when stock is below 10 units</li>
                        <li><strong><i class="fas fa-sync-alt"></i> Stock Updates:</strong> Edit items to update quantities</li>
                        <li><strong><i class="fas fa-coins"></i> Inventory Value:</strong> Dashboard shows total inventory worth</li>
                    </ul>
                </div>

                <h3><i class="fas fa-money-bill-wave"></i> Pricing Guidelines</h3>
                <div class="step-by-step">
                    <h4><i class="fas fa-thumbs-up"></i> Best Practices</h4>
                    <ul>
                        <li><i class="fas fa-search"></i> Set competitive prices based on market research</li>
                        <li><i class="fas fa-shopping-cart"></i> Consider bulk discounts for large orders</li>
                        <li><i class="fas fa-calendar-alt"></i> Update prices regularly to maintain profitability</li>
                        <li><i class="fas fa-spell-check"></i> Use clear, descriptive names for easy identification</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Billing System Section -->
        <section id="billing-system" class="help-section reveal">
            <div class="section-header">
                <h2>
                    <i class="fas fa-file-invoice-dollar"></i>
                    Billing System
                </h2>
            </div>
            <div class="section-content">
                <h3><i class="fas fa-receipt"></i> Generating Bills</h3>
                <p>Create professional invoices with automated calculations:</p>
                <ol>
                    <li><i class="fas fa-clipboard-list"></i> Go to <strong>Billing</strong> from the main menu</li>
                    <li><i class="fas fa-user-check"></i> Select a customer from the dropdown</li>
                    <li><i class="fas fa-calculator"></i> Enter or verify units consumed</li>
                    <li><i class="fas fa-eye"></i> Review the calculated amount</li>
                    <li><i class="fas fa-print"></i> Generate and print the bill</li>
                </ol>

                <h3><i class="fas fa-percentage"></i> Billing Calculation</h3>
                <div class="feature-box">
                    <h4><i class="fas fa-calculator"></i> How Bills Are Calculated</h4>
                    <ul>
                        <li><strong><i class="fas fa-tag"></i> Base Rate:</strong> LKR 50.00 per unit</li>
                        <li><strong><i class="fas fa-percent"></i> Discounts:</strong>
                            <ul>
                                <li><i class="fas fa-gift"></i> 5% discount for 20-49 units</li>
                                <li><i class="fas fa-gift"></i> 10% discount for 50-99 units</li>
                                <li><i class="fas fa-gift"></i> 15% discount for 100+ units</li>
                            </ul>
                        </li>
                        <li><strong><i class="fas fa-receipt"></i> Tax:</strong> 8% tax applied to final amount</li>
                    </ul>
                </div>

                <h3><i class="fas fa-folder-open"></i> Bill Management</h3>
                <p>After generating bills, you can:</p>
                <ul>
                    <li><strong><i class="fas fa-list-alt"></i> View Bills:</strong> See all generated bills with details</li>
                    <li><strong><i class="fas fa-print"></i> Print Bills:</strong> Generate printer-friendly versions</li>
                    <li><strong><i class="fas fa-history"></i> Customer History:</strong> View all bills for a specific customer</li>
                    <li><strong><i class="fas fa-chart-line"></i> Revenue Reports:</strong> Track daily and monthly earnings</li>
                </ul>
            </div>
        </section>

        <!-- Tips & Tricks Section -->
        <section id="tips-tricks" class="help-section reveal">
            <div class="section-header">
                <h2>
                    <i class="fas fa-lightbulb"></i>
                    Tips & Tricks
                </h2>
            </div>
            <div class="section-content">
                <h3><i class="fas fa-keyboard"></i> Keyboard Shortcuts</h3>
                <ul>
                    <li><span class="shortcut-key"><i class="fas fa-key"></i> Ctrl + D</span> - Go to Dashboard</li>
                    <li><span class="shortcut-key"><i class="fas fa-key"></i> Ctrl + C</span> - Customer Management</li>
                    <li><span class="shortcut-key"><i class="fas fa-key"></i> Ctrl + I</span> - Item Management</li>
                    <li><span class="shortcut-key"><i class="fas fa-key"></i> Ctrl + B</span> - Billing System</li>
                    <li><span class="shortcut-key"><i class="fas fa-key"></i> Ctrl + H</span> - Help Page</li>
                    <li><span class="shortcut-key"><i class="fas fa-key"></i> Ctrl + L</span> - Logout</li>
                </ul>

                <h3><i class="fas fa-rocket"></i> Efficiency Tips</h3>
                <div class="feature-box">
                    <h4><i class="fas fa-brain"></i> Work Smarter</h4>
                    <ul>
                        <li><i class="fas fa-font"></i> Use consistent naming conventions for account numbers and item IDs</li>
                        <li><i class="fas fa-sync"></i> Regularly update stock levels to avoid overselling</li>
                        <li><i class="fas fa-chart-bar"></i> Check the dashboard daily for business insights</li>
                        <li><i class="fas fa-file-pdf"></i> Print bills immediately after generation for record keeping</li>
                        <li><i class="fas fa-bell"></i> Monitor low stock alerts to maintain inventory</li>
                    </ul>
                </div>

                <h3><i class="fas fa-database"></i> Data Management</h3>
                <div class="step-by-step">
                    <h4><i class="fas fa-star"></i> Best Practices</h4>
                    <ul>
                        <li><i class="fas fa-backup"></i> Backup your data regularly</li>
                        <li><i class="fas fa-folder"></i> Keep physical copies of important bills</li>
                        <li><i class="fas fa-user-check"></i> Review customer information periodically</li>
                        <li><i class="fas fa-price-tag"></i> Update item prices based on supplier changes</li>
                        <li><i class="fas fa-analytics"></i> Track inventory turnover rates</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Troubleshooting Section -->
        <section id="troubleshooting" class="help-section reveal">
            <div class="section-header">
                <h2>
                    <i class="fas fa-tools"></i>
                    Troubleshooting
                </h2>
            </div>
            <div class="section-content">
                <h3><i class="fas fa-exclamation-circle"></i> Common Issues</h3>

                <div class="warning-box">
                    <h4><i class="fas fa-lock"></i> Login Problems</h4>
                    <ul>
                        <li><strong><i class="fas fa-user-times"></i> Invalid credentials:</strong> Ensure username is "admin" and password is "admin123"</li>
                        <li><strong><i class="fas fa-clock"></i> Session expired:</strong> Login again if you've been inactive</li>
                        <li><strong><i class="fas fa-browser"></i> Browser issues:</strong> Clear cache and cookies, try a different browser</li>
                    </ul>
                </div>

                <div class="warning-box">
                    <h4><i class="fas fa-keyboard"></i> Data Entry Issues</h4>
                    <ul>
                        <li><strong><i class="fas fa-copy"></i> Duplicate account numbers:</strong> Each customer must have a unique account number</li>
                        <li><strong><i class="fas fa-format-align-left"></i> Invalid formats:</strong> Use only letters, numbers, and allowed symbols</li>
                        <li><strong><i class="fas fa-asterisk"></i> Required fields:</strong> All marked fields must be completed</li>
                    </ul>
                </div>

                <div class="warning-box">
                    <h4><i class="fas fa-calculator"></i> Billing Problems</h4>
                    <ul>
                        <li><strong><i class="fas fa-bug"></i> Calculation errors:</strong> Verify units consumed and check for system updates</li>
                        <li><strong><i class="fas fa-print"></i> Printing issues:</strong> Check printer connection and paper supply</li>
                        <li><strong><i class="fas fa-user-slash"></i> Missing customers:</strong> Ensure customer is added before generating bills</li>
                    </ul>
                </div>

                <h3><i class="fas fa-life-ring"></i> Getting Help</h3>
                <p>If you encounter issues not covered in this guide:</p>
                <ol>
                    <li><i class="fas fa-search"></i> Check the error message for specific details</li>
                    <li><i class="fas fa-redo"></i> Try refreshing the page</li>
                    <li><i class="fas fa-sign-out-alt"></i> Logout and login again</li>
                    <li><i class="fas fa-headset"></i> Contact system administrator if problems persist</li>
                </ol>
            </div>
        </section>
    </div>

    <!-- Contact Information -->
    <div class="contact-info reveal">
        <div class="contact-info-content">
            <h3>
                <i class="fas fa-headset"></i>
                Need More Help?
            </h3>
            <p><strong><i class="fas fa-building"></i> Pahana Edu Bookshop Management System</strong></p>
            <p><i class="fas fa-code-branch"></i> System Version: 1.0.0</p>
            <p><i class="fas fa-envelope"></i> For technical support, contact your system administrator</p>
            <p><em><i class="fas fa-quote-left"></i> This system is designed to streamline your bookshop operations efficiently and effectively. <i class="fas fa-quote-right"></i></em></p>
        </div>
    </div>

    <!-- Back to Top Button -->
    <button class="back-to-top" onclick="scrollToTop()">
        <i class="fas fa-arrow-up"></i>
    </button>
</div>

<script>
    // Initialize animations and interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Scroll reveal animation
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('revealed');
                }
            });
        }, observerOptions);

        // Observe all reveal elements
        document.querySelectorAll('.reveal').forEach(el => {
            observer.observe(el);
        });

        // Stagger animation for navigation cards
        const navCards = document.querySelectorAll('.nav-card');
        navCards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
            card.style.animation = 'slideInUp 0.6s ease-out both';
        });

        // Add hover effects to feature boxes
        const featureBoxes = document.querySelectorAll('.feature-box, .warning-box, .step-by-step');
        featureBoxes.forEach(box => {
            box.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-10px) scale(1.02)';
                this.style.boxShadow = '0 25px 50px rgba(0,0,0,0.3)';
            });

            box.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
                this.style.boxShadow = '';
            });
        });

        // Add ripple effect to shortcut keys
        const shortcutKeys = document.querySelectorAll('.shortcut-key');
        shortcutKeys.forEach(key => {
            key.addEventListener('click', function(e) {
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

        // Add floating animation to icons
        const icons = document.querySelectorAll('.hero-icon i, .section-header i');
        icons.forEach(icon => {
            icon.addEventListener('mouseenter', function() {
                this.style.animation = 'bounce 1s ease-in-out';
            });

            icon.addEventListener('animationend', function() {
                this.style.animation = '';
            });
        });

        // Add parallax effect to hero section
        const hero = document.querySelector('.help-hero');
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const parallax = scrolled * 0.5;
            if (hero) {
                hero.style.transform = `translateY(${parallax}px)`;
            }
        });

        // Smooth scrolling for navigation links
        document.querySelectorAll('.nav-card').forEach(function(link) {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const targetId = this.getAttribute('href').substring(1);
                const targetElement = document.getElementById(targetId);
                if (targetElement) {
                    targetElement.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });

                    // Add highlight effect
                    targetElement.style.animation = 'pulse 1s ease-in-out';
                    setTimeout(() => {
                        targetElement.style.animation = '';
                    }, 1000);
                }
            });
        });

        // Add glow effect to important elements
        const importantElements = document.querySelectorAll('.feature-box h4, .warning-box h4, .step-by-step h4');
        importantElements.forEach(element => {
            element.addEventListener('mouseenter', function() {
                this.style.textShadow = '0 0 20px rgba(255,255,255,0.8)';
            });

            element.addEventListener('mouseleave', function() {
                this.style.textShadow = '';
            });
        });

        console.log('✨ Help page animations initialized');
    });

    // Back to top functionality
    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }

    // Show/hide back to top button with animation
    window.addEventListener('scroll', function() {
        const backToTop = document.querySelector('.back-to-top');
        const scrollPosition = window.pageYOffset;

        if (scrollPosition > 300) {
            backToTop.classList.add('show');
            backToTop.style.display = 'block';
        } else {
            backToTop.classList.remove('show');
            setTimeout(() => {
                if (!backToTop.classList.contains('show')) {
                    backToTop.style.display = 'none';
                }
            }, 300);
        }

        // Change back to top button color based on scroll
        const scrollPercent = (scrollPosition / (document.body.scrollHeight - window.innerHeight)) * 100;
        backToTop.style.background = `linear-gradient(135deg,
            hsl(${240 + scrollPercent * 1.2}, 70%, 60%) 0%,
            hsl(${280 + scrollPercent * 0.8}, 70%, 60%) 100%)`;
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey) {
            switch(e.key) {
                case 'd':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/dashboard';
                    break;
                case 'c':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/customer';
                    break;
                case 'i':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/item';
                    break;
                case 'b':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/bill';
                    break;
                case 'l':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/logout';
                    break;
                case 'p':
                    e.preventDefault();
                    printHelp();
                    break;
            }
        }

        // Navigate sections with arrow keys
        if (e.altKey) {
            const sections = ['getting-started', 'customer-management', 'item-management', 'billing-system', 'tips-tricks', 'troubleshooting'];
            let currentSection = 0;

            // Find current section
            sections.forEach((section, index) => {
                const element = document.getElementById(section);
                if (element && isInViewport(element)) {
                    currentSection = index;
                }
            });

            if (e.key === 'ArrowDown' && currentSection < sections.length - 1) {
                e.preventDefault();
                document.getElementById(sections[currentSection + 1]).scrollIntoView({ behavior: 'smooth' });
            } else if (e.key === 'ArrowUp' && currentSection > 0) {
                e.preventDefault();
                document.getElementById(sections[currentSection - 1]).scrollIntoView({ behavior: 'smooth' });
            }
        }
    });

    // Helper function to check if element is in viewport
    function isInViewport(element) {
        const rect = element.getBoundingClientRect();
        return rect.top >= 0 && rect.top <= window.innerHeight / 2;
    }

    // Print functionality
    function printHelp() {
        const printWindow = window.open('', '_blank');
        const printContent = document.querySelector('.help-content').innerHTML;

        printWindow.document.write(`
            <html>
                <head>
                    <title>Pahana Edu - Help Guide</title>
                    <style>
                        body { font-family: Arial, sans-serif; line-height: 1.6; }
                        .section-header { background: #667eea; color: white; padding: 1rem; }
                        .section-content { padding: 1rem; }
                        .feature-box, .warning-box, .step-by-step {
                            border: 2px solid #ddd;
                            padding: 1rem;
                            margin: 1rem 0;
                        }
                    </style>
                </head>
                <body>
                    <h1>Pahana Edu Management System - Help Guide</h1>
                    ${printContent}
                </body>
            </html>
        `);

        printWindow.document.close();
        printWindow.print();
    }

    // Add CSS for additional animations
    const additionalStyles = document.createElement('style');
    additionalStyles.textContent = `
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        .nav-card {
            transform: translateY(50px);
            opacity: 0;
        }

        .shortcut-key {
            position: relative;
            overflow: hidden;
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }

        /* Section highlight animation */
        .help-section.highlight {
            animation: sectionHighlight 2s ease-in-out;
        }

        @keyframes sectionHighlight {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }

        /* Loading animation for sections */
        .help-section {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .help-section.revealed {
            opacity: 1;
            transform: translateY(0);
        }

        /* Enhanced hover effects */
        .nav-card:hover {
            animation: cardFloat 0.6s ease-in-out;
        }

        @keyframes cardFloat {
            0%, 100% { transform: translateY(-5px) scale(1.02); }
            50% { transform: translateY(-10px) scale(1.05); }
        }

        /* Typewriter effect for hero title */
        .help-hero h1 {
            overflow: hidden;
            border-right: 3px solid white;
            white-space: nowrap;
            animation: typewriter 3s steps(40) 1s 1 normal both, blinkCursor 0.75s step-end infinite;
        }

        @keyframes typewriter {
            from { width: 0; }
            to { width: 100%; }
        }

        @keyframes blinkCursor {
            50% { border-color: transparent; }
        }
    `;
    document.head.appendChild(additionalStyles);

    // Performance monitoring
    const performanceObserver = new PerformanceObserver((list) => {
        list.getEntries().forEach((entry) => {
            if (entry.duration > 100) {
                console.warn('🐌 Slow operation detected:', entry.name, entry.duration.toFixed(2) + 'ms');
            }
        });
    });

    if ('PerformanceObserver' in window) {
        performanceObserver.observe({ entryTypes: ['navigation', 'resource'] });
    }

    // Add accessibility features
    document.addEventListener('keydown', function(e) {
        // Focus management
        if (e.key === 'Tab') {
            const focusableElements = document.querySelectorAll(
                'a[href], button, [tabindex]:not([tabindex="-1"])'
            );

            focusableElements.forEach(element => {
                element.addEventListener('focus', function() {
                    this.style.outline = '3px solid #667eea';
                    this.style.outlineOffset = '2px';
                    this.style.borderRadius = '5px';
                });

                element.addEventListener('blur', function() {
                    this.style.outline = '';
                    this.style.outlineOffset = '';
                });
            });
        }
    });

    // Error handling
    window.addEventListener('error', function(e) {
        console.warn('⚠️ Help page error:', e.error);
    });

    console.log('🎨 Modern help page loaded successfully with advanced animations');
</script>
</body>
</html>
