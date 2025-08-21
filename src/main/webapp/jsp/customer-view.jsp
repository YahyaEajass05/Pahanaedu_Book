<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Details - Pahana Edu</title>
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Hero Section */
        .customer-hero {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 30px;
            padding: 3rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            color: white;
            animation: slideInDown 0.8s ease-out;
        }

        .customer-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        .hero-content {
            display: flex;
            align-items: center;
            gap: 2.5rem;
            position: relative;
            z-index: 2;
        }

        .customer-avatar-large {
            width: 120px;
            height: 120px;
            background: var(--success-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            font-weight: 900;
            color: white;
            box-shadow: var(--card-shadow);
            position: relative;
            animation: pulse 2s infinite;
        }

        .customer-avatar-large::after {
            content: '';
            position: absolute;
            inset: -5px;
            background: var(--success-gradient);
            border-radius: inherit;
            z-index: -1;
            filter: blur(15px);
            opacity: 0.7;
            animation: glow 2s ease-in-out infinite alternate;
        }

        .hero-info h1 {
            font-size: 3rem;
            margin: 0 0 1rem 0;
            font-weight: 800;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            animation: fadeInLeft 0.8s ease-out 0.2s both;
        }

        .hero-info p {
            font-size: 1.3rem;
            margin: 0;
            opacity: 0.9;
            animation: fadeInLeft 0.8s ease-out 0.4s both;
        }

        .status-floating {
            position: absolute;
            top: 2rem;
            right: 2rem;
            background: var(--warning-gradient);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            box-shadow: var(--card-shadow);
            animation: bounceIn 0.8s ease-out 0.6s both;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Main Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 3rem;
            margin-bottom: 3rem;
        }

        .details-panel {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            animation: slideInLeft 0.8s ease-out;
            transition: all 0.3s ease;
        }

        .details-panel:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .panel-header {
            background: var(--secondary-gradient);
            color: white;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .panel-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 15s linear infinite;
        }

        .panel-header h3 {
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            position: relative;
            z-index: 2;
        }

        .panel-content {
            padding: 2rem;
        }

        .info-grid {
            display: grid;
            gap: 2rem;
        }

        .info-item {
            padding: 1.5rem;
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            border-radius: 15px;
            border-left: 4px solid #667eea;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            animation: fadeInUp 0.6s ease-out;
        }

        .info-item:nth-child(even) {
            animation-delay: 0.1s;
        }

        .info-item:hover {
            transform: translateX(10px) scale(1.02);
            background: linear-gradient(135deg, #e8f0ff 0%, #d0e0ff 100%);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
        }

        .info-label {
            font-size: 0.9rem;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-value {
            font-size: 1.3rem;
            color: #333;
            font-weight: 700;
        }

        .info-value.highlight {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.5rem;
        }

        /* Stats Sidebar */
        .stats-sidebar {
            display: flex;
            flex-direction: column;
            gap: 2rem;
            animation: slideInRight 0.8s ease-out;
        }

        .stats-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: scale(1.02);
            box-shadow: var(--hover-shadow);
        }

        .stats-header {
            background: var(--dark-gradient);
            color: white;
            padding: 1.5rem;
            text-align: center;
            position: relative;
        }

        .stats-header h3 {
            margin: 0;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .units-showcase {
            text-align: center;
            padding: 3rem 2rem;
            background: radial-gradient(circle at center, rgba(67, 233, 123, 0.1) 0%, transparent 70%);
            position: relative;
        }

        .units-number {
            font-size: 4.5rem;
            font-weight: 900;
            margin: 0;
            background: var(--warning-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: countUp 2s ease-out;
            text-shadow: 0 2px 20px rgba(67, 233, 123, 0.3);
        }

        .units-label {
            color: #666;
            font-weight: 700;
            margin: 1rem 0;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-size: 0.9rem;
        }

        .metric-cards {
            padding: 1rem;
        }

        .metric-item {
            background: white;
            margin-bottom: 1rem;
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            border-left: 4px solid;
        }

        .metric-item:nth-child(1) { border-left-color: #4facfe; }
        .metric-item:nth-child(2) { border-left-color: #43e97b; }
        .metric-item:nth-child(3) { border-left-color: #fa709a; }

        .metric-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .metric-value {
            font-size: 1.8rem;
            font-weight: 800;
            color: #333;
            margin: 0;
        }

        .metric-label {
            color: #666;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin: 0.5rem 0 0 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.3rem;
        }

        .billing-preview {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin: 1rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.6s ease-out;
        }

        .billing-preview::before {
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

        .billing-preview h4 {
            margin: 0 0 1rem 0;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .billing-amount {
            font-size: 2.5rem;
            font-weight: 900;
            margin: 0;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
        }

        /* Activity Timeline */
        .activity-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            animation: slideInUp 0.8s ease-out;
            margin-bottom: 3rem;
        }

        .activity-header {
            background: var(--success-gradient);
            color: white;
            padding: 2rem;
            position: relative;
        }

        .activity-header h3 {
            margin: 0;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .timeline {
            padding: 2rem;
            position: relative;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 3rem;
            top: 0;
            bottom: 0;
            width: 3px;
            background: linear-gradient(to bottom, #667eea, #764ba2);
            border-radius: 2px;
        }

        .timeline-item {
            display: flex;
            align-items: flex-start;
            gap: 2rem;
            margin-bottom: 2rem;
            position: relative;
            animation: fadeInUp 0.6s ease-out;
        }

        .timeline-item:nth-child(even) {
            animation-delay: 0.1s;
        }

        .timeline-icon {
            width: 60px;
            height: 60px;
            background: var(--secondary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            box-shadow: var(--card-shadow);
            position: relative;
            z-index: 2;
            animation: pulse 2s infinite;
            transition: all 0.3s ease;
        }

        .timeline-icon:hover {
            transform: scale(1.1) rotate(10deg);
        }

        .timeline-content {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            padding: 1.5rem;
            border-radius: 15px;
            flex: 1;
            border-left: 4px solid #667eea;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .timeline-content:hover {
            transform: translateX(15px);
            background: linear-gradient(135deg, #e8f0ff 0%, #d0e0ff 100%);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .timeline-content h4 {
            margin: 0 0 0.5rem 0;
            color: #333;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .timeline-content p {
            margin: 0;
            color: #666;
            line-height: 1.7;
        }

        /* Action Buttons */
        .actions-panel {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 2rem;
            text-align: center;
            animation: slideInUp 0.8s ease-out;
            border: 1px solid var(--glass-border);
        }

        .button-group {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-modern {
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
            min-width: 180px;
            justify-content: center;
            color: white;
            box-shadow: var(--card-shadow);
        }

        .btn-modern::before {
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

        .btn-modern:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-modern:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        .btn-edit { background: var(--warning-gradient); }
        .btn-bill { background: var(--success-gradient); }
        .btn-delete { background: var(--danger-gradient); }
        .btn-back { background: var(--dark-gradient); }

        /* Phone link styling */
        .phone-link {
            color: #4facfe;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .phone-link:hover {
            color: #3498db;
            transform: scale(1.05);
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
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: scale(0.3);
            }
            50% {
                opacity: 1;
                transform: scale(1.05);
            }
            70% {
                transform: scale(0.9);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(102, 126, 234, 0.7);
            }
            70% {
                transform: scale(1.05);
                box-shadow: 0 0 0 20px rgba(102, 126, 234, 0);
            }
            100% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(102, 126, 234, 0);
            }
        }

        @keyframes glow {
            from {
                opacity: 0.7;
                filter: blur(15px);
            }
            to {
                opacity: 1;
                filter: blur(20px);
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

        @keyframes countUp {
            from {
                opacity: 0;
                transform: scale(0.5);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .stats-sidebar {
                flex-direction: row;
                overflow-x: auto;
            }

            .stats-card {
                min-width: 300px;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .hero-content {
                flex-direction: column;
                text-align: center;
            }

            .hero-info h1 {
                font-size: 2.5rem;
            }

            .status-floating {
                position: static;
                margin-top: 1rem;
            }

            .button-group {
                flex-direction: column;
                align-items: center;
            }

            .btn-modern {
                width: 100%;
                max-width: 300px;
            }

            .timeline::before {
                left: 2rem;
            }

            .timeline-item {
                gap: 1rem;
            }

            .units-number {
                font-size: 3.5rem;
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

    Customer customer = (Customer) request.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/customer");
        return;
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' HH:mm");
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
    <!-- Display Success Messages -->
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <i class="icon-success">✓</i>
        <%= request.getParameter("success") %>
    </div>
    <% } %>

    <!-- Hero Section -->
    <div class="customer-hero">
        <div class="hero-content">
            <div class="customer-avatar-large">
                <%= customer.getName().substring(0, 1).toUpperCase() %>
            </div>
            <div class="hero-info">
                <h1><%= customer.getName() %></h1>
                <p><i class="fas fa-credit-card"></i> Account: <%= customer.getAccountNumber() %></p>
            </div>
        </div>
        <div class="status-floating">
            <% if (customer.getUnitsConsumed() > 0) { %>
            <i class="fas fa-check-circle"></i>
            Active Customer
            <% } else { %>
            <i class="fas fa-pause-circle"></i>
            Inactive Customer
            <% } %>
        </div>
    </div>

    <!-- Main Content Grid -->
    <div class="content-grid">
        <!-- Customer Details Panel -->
        <div class="details-panel">
            <div class="panel-header">
                <h3>
                    <i class="fas fa-user-circle"></i>
                    Customer Information
                </h3>
            </div>
            <div class="panel-content">
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-id-badge"></i>
                            Account Number
                        </div>
                        <div class="info-value highlight"><%= customer.getAccountNumber() %></div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-user"></i>
                            Full Name
                        </div>
                        <div class="info-value"><%= customer.getName() %></div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-home"></i>
                            Address
                        </div>
                        <div class="info-value"><%= customer.getAddress() %></div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-phone"></i>
                            Telephone
                        </div>
                        <div class="info-value">
                            <a href="tel:<%= customer.getTelephone() %>" class="phone-link">
                                <i class="fas fa-phone"></i>
                                <%= customer.getTelephone() %>
                            </a>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-calendar-plus"></i>
                            Account Created
                        </div>
                        <div class="info-value">
                            <% if (customer.getCreatedAt() != null) { %>
                            <%= dateFormat.format(customer.getCreatedAt()) %>
                            <% } else { %>
                            Not available
                            <% } %>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-edit"></i>
                            Last Updated
                        </div>
                        <div class="info-value">
                            <% if (customer.getUpdatedAt() != null) { %>
                            <%= dateFormat.format(customer.getUpdatedAt()) %>
                            <% } else { %>
                            Never updated
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Sidebar -->
        <div class="stats-sidebar">
            <!-- Units Display -->
            <div class="stats-card">
                <div class="stats-header">
                    <h3>
                        <i class="fas fa-chart-bar"></i>
                        Usage Statistics
                    </h3>
                </div>
                <div class="units-showcase">
                    <div class="units-number"><%= customer.getUnitsConsumed() %></div>
                    <div class="units-label">Units Consumed</div>
                </div>
            </div>

            <!-- Metrics Cards -->
            <div class="stats-card">
                <div class="stats-header">
                    <h3>
                        <i class="fas fa-analytics"></i>
                        Account Metrics
                    </h3>
                </div>
                <div class="metric-cards">
                    <div class="metric-item">
                        <div class="metric-value">
                            <%= customer.getUnitsConsumed() > 0 ? "Active" : "Inactive" %>
                        </div>
                        <div class="metric-label">
                            <i class="fas fa-power-off"></i>
                            Account Status
                        </div>
                    </div>

                    <div class="metric-item">
                        <div class="metric-value">
                            <%
                                String priority = customer.getUnitsConsumed() >= 100 ? "High" :
                                        customer.getUnitsConsumed() >= 50 ? "Medium" : "Low";
                            %>
                            <%= priority %>
                        </div>
                        <div class="metric-label">
                            <i class="fas fa-flag"></i>
                            Priority Level
                        </div>
                    </div>

                    <div class="metric-item">
                        <div class="metric-value">
                            <%
                                String tier = customer.getUnitsConsumed() >= 100 ? "Premium" :
                                        customer.getUnitsConsumed() >= 50 ? "Standard" : "Basic";
                            %>
                            <%= tier %>
                        </div>
                        <div class="metric-label">
                            <i class="fas fa-crown"></i>
                            Customer Tier
                        </div>
                    </div>
                </div>

                <!-- Billing Preview -->
                <div class="billing-preview">
                    <h4>
                        <i class="fas fa-calculator"></i>
                        Estimated Bill
                    </h4>
                    <div class="billing-amount">
                        LKR <%= String.format("%.2f", customer.getUnitsConsumed() * 50.0 * 1.08) %>
                    </div>
                    <small>Based on current units (incl. tax)</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Activity Timeline -->
    <div class="activity-section">
        <div class="activity-header">
            <h3>
                <i class="fas fa-history"></i>
                Account Activity
            </h3>
        </div>
        <div class="timeline">
            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <div class="timeline-content">
                    <h4>Customer Account Created</h4>
                    <p>
                        <% if (customer.getCreatedAt() != null) { %>
                        Account was created on <%= dateFormat.format(customer.getCreatedAt()) %>
                        <% } else { %>
                        Account creation date not available
                        <% } %>
                    </p>
                </div>
            </div>

            <% if (customer.getUpdatedAt() != null &&
                    !customer.getUpdatedAt().equals(customer.getCreatedAt())) { %>
            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-edit"></i>
                </div>
                <div class="timeline-content">
                    <h4>Account Information Updated</h4>
                    <p>Last updated on <%= dateFormat.format(customer.getUpdatedAt()) %></p>
                </div>
            </div>
            <% } %>

            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="timeline-content">
                    <h4>Current Usage Status</h4>
                    <p>
                        <% if (customer.getUnitsConsumed() > 0) { %>
                        <i class="fas fa-check-circle" style="color: #27ae60;"></i>
                        Customer has consumed <%= customer.getUnitsConsumed() %> units and is ready for billing
                        <% } else { %>
                        <i class="fas fa-info-circle" style="color: #3498db;"></i>
                        No units consumed yet - new customer account
                        <% } %>
                    </p>
                </div>
            </div>

            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-tags"></i>
                </div>
                <div class="timeline-content">
                    <h4>Account Classification</h4>
                    <p>
                        <% if (customer.getUnitsConsumed() >= 100) { %>
                        <i class="fas fa-crown" style="color: #f39c12;"></i>
                        High-value customer - eligible for premium discounts
                        <% } else if (customer.getUnitsConsumed() >= 50) { %>
                        <i class="fas fa-medal" style="color: #e67e22;"></i>
                        Medium-value customer - eligible for standard discounts
                        <% } else if (customer.getUnitsConsumed() > 0) { %>
                        <i class="fas fa-user" style="color: #3498db;"></i>
                        Standard customer - basic billing rates apply
                        <% } else { %>
                        <i class="fas fa-user-plus" style="color: #9b59b6;"></i>
                        New customer - no consumption history yet
                        <% } %>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="actions-panel">
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/customer?action=edit&accountNumber=<%= customer.getAccountNumber() %>"
               class="btn-modern btn-edit">
                <i class="fas fa-user-edit"></i>
                Edit Customer
            </a>

            <a href="${pageContext.request.contextPath}/bill?action=generate&accountNumber=<%= customer.getAccountNumber() %>"
               class="btn-modern btn-bill">
                <i class="fas fa-file-invoice-dollar"></i>
                Generate Bill
            </a>

            <a href="${pageContext.request.contextPath}/customer?action=delete&accountNumber=<%= customer.getAccountNumber() %>"
               class="btn-modern btn-delete"
               onclick="return confirm('Are you sure you want to delete this customer? This action cannot be undone.')">
                <i class="fas fa-user-times"></i>
                Delete Customer
            </a>

            <a href="${pageContext.request.contextPath}/customer"
               class="btn-modern btn-back">
                <i class="fas fa-arrow-left"></i>
                Back to List
            </a>
        </div>
    </div>
</div>

<script>
    // Initialize animations and interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Animate units counter
        const unitsNumber = document.querySelector('.units-number');
        const finalValue = <%= customer.getUnitsConsumed() %>;

        if (unitsNumber && finalValue > 0) {
            let currentValue = 0;
            const increment = Math.ceil(finalValue / 40);
            const timer = setInterval(function() {
                currentValue += increment;
                if (currentValue >= finalValue) {
                    currentValue = finalValue;
                    clearInterval(timer);
                }
                unitsNumber.textContent = currentValue;
            }, 50);
        }

        // Add hover effects to info items
        const infoItems = document.querySelectorAll('.info-item');
        infoItems.forEach((item, index) => {
            item.style.animationDelay = `${index * 0.1}s`;

            // Add click ripple effect
            item.addEventListener('click', function(e) {
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
                    background: radial-gradient(circle, rgba(102, 126, 234, 0.3) 0%, transparent 70%);
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

        // Add floating animation to timeline icons
        const timelineIcons = document.querySelectorAll('.timeline-icon');
        timelineIcons.forEach((icon, index) => {
            icon.style.animationDelay = `${index * 0.2}s`;

            icon.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.2) rotate(15deg)';
                this.style.boxShadow = '0 15px 40px rgba(0,0,0,0.3)';
            });

            icon.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1) rotate(0deg)';
                this.style.boxShadow = '';
            });
        });

        // Add dynamic gradient animation to buttons
        const modernButtons = document.querySelectorAll('.btn-modern');
        modernButtons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                this.style.backgroundSize = '200% 200%';
                this.style.backgroundPosition = 'right center';
            });

            button.addEventListener('mouseleave', function() {
                this.style.backgroundPosition = 'left center';
            });
        });

        // Add parallax effect to hero section
        const hero = document.querySelector('.customer-hero');
        if (hero) {
            window.addEventListener('scroll', () => {
                const scrolled = window.pageYOffset;
                const parallax = scrolled * 0.5;
                hero.style.transform = `translateY(${parallax}px)`;
            });
        }

        // Add glow effect to high-value customers
        const unitsConsumed = <%= customer.getUnitsConsumed() %>;
        if (unitsConsumed >= 100) {
            const avatar = document.querySelector('.customer-avatar-large');
            if (avatar) {
                avatar.style.animation = 'pulse 2s infinite, glow 2s ease-in-out infinite alternate';
                avatar.style.boxShadow = '0 0 40px rgba(67, 233, 123, 0.8)';
            }
        }

        // Add smooth scrolling to timeline
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

        // Observe timeline items
        const timelineItems = document.querySelectorAll('.timeline-item');
        timelineItems.forEach(item => {
            item.style.opacity = '0';
            item.style.transform = 'translateY(30px)';
            item.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(item);
        });

        // Add interactive phone number
        const phoneLink = document.querySelector('.phone-link');
        if (phoneLink) {
            phoneLink.addEventListener('click', function(e) {
                this.style.animation = 'pulse 0.5s ease-in-out';
                setTimeout(() => {
                    this.style.animation = '';
                }, 500);
            });
        }

        // Add typewriter effect to customer name
        const customerName = document.querySelector('.hero-info h1');
        if (customerName) {
            const originalText = customerName.textContent;
            customerName.textContent = '';
            let i = 0;

            const typeWriter = () => {
                if (i < originalText.length) {
                    customerName.textContent += originalText.charAt(i);
                    i++;
                    setTimeout(typeWriter, 100);
                }
            };

            setTimeout(typeWriter, 800);
        }

        // Add metric card animations
        const metricItems = document.querySelectorAll('.metric-item');
        metricItems.forEach((item, index) => {
            item.style.animationDelay = `${index * 0.1}s`;
            item.style.animation = 'fadeInUp 0.6s ease-out both';

            item.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px) scale(1.02)';
                this.style.boxShadow = '0 20px 50px rgba(0,0,0,0.2)';
            });

            item.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
                this.style.boxShadow = '';
            });
        });

        console.log('✨ Customer details page animations initialized');
    });

    // Print customer details
    function printCustomerDetails() {
        const printContent = document.querySelector('.container').innerHTML;
        const printWindow = window.open('', '_blank');

        printWindow.document.write(`
            <html>
                <head>
                    <title>Customer Details - <%= customer.getName() %></title>
                    <style>
                        body { font-family: Arial, sans-serif; line-height: 1.6; }
                        .customer-hero { background: #667eea; color: white; padding: 2rem; }
                        .details-panel, .activity-section { background: white; padding: 1rem; margin: 1rem 0; }
                        .info-item { border: 1px solid #ddd; padding: 1rem; margin: 0.5rem 0; }
                        .timeline-item { border-left: 3px solid #667eea; padding-left: 1rem; margin: 1rem 0; }
                        .actions-panel { display: none; }
                        @media print { body { margin: 0; } }
                    </style>
                </head>
                <body>
                    ${printContent}
                </body>
            </html>
        `);

        printWindow.document.close();
        printWindow.print();
    }

    // Copy account number to clipboard
    function copyAccountNumber() {
        const accountNumber = '<%= customer.getAccountNumber() %>';
        navigator.clipboard.writeText(accountNumber).then(function() {
            // Show success notification
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 2rem;
                right: 2rem;
                background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
                color: white;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                font-weight: 600;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                z-index: 10000;
                animation: slideInRight 0.3s ease-out;
            `;
            notification.innerHTML = `
                <i class="fas fa-check-circle"></i>
                Account number copied: ${accountNumber}
            `;

            document.body.appendChild(notification);

            setTimeout(() => {
                notification.style.animation = 'slideOutRight 0.3s ease-out';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 3000);
        }).catch(function() {
            alert('Account number: ' + accountNumber);
        });
    }

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey) {
            switch(e.key) {
                case 'e':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/customer?action=edit&accountNumber=<%= customer.getAccountNumber() %>';
                    break;
                case 'b':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/bill?action=generate&accountNumber=<%= customer.getAccountNumber() %>';
                    break;
                case 'p':
                    e.preventDefault();
                    printCustomerDetails();
                    break;
                case 'c':
                    e.preventDefault();
                    copyAccountNumber();
                    break;
            }
        }

        // ESC key to go back
        if (e.key === 'Escape') {
            window.location.href = '${pageContext.request.contextPath}/customer';
        }

        // Arrow keys for navigation
        if (e.altKey) {
            if (e.key === 'ArrowLeft') {
                window.location.href = '${pageContext.request.contextPath}/customer';
            }
        }
    });

    // Add tooltips for keyboard shortcuts
    document.addEventListener('DOMContentLoaded', function() {
        const editBtn = document.querySelector('.btn-edit');
        const billBtn = document.querySelector('.btn-bill');

        if (editBtn) {
            editBtn.title = 'Edit Customer (Ctrl+E)';
        }
        if (billBtn) {
            billBtn.title = 'Generate Bill (Ctrl+B)';
        }

        // Add click handlers with loading states
        const buttons = document.querySelectorAll('.btn-modern');
        buttons.forEach(button => {
            button.addEventListener('click', function(e) {
                if (!this.href.includes('javascript:') && !this.onclick) {
                    this.style.opacity = '0.7';
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
                }
            });
        });
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

        .info-item {
            cursor: pointer;
        }

        .metric-item:hover {
            transform: translateY(-8px) scale(1.02);
        }

        .timeline-content {
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .btn-modern {
            background-size: 200% 200%;
            background-position: left center;
            transition: all 0.3s ease;
        }

        .btn-modern:active {
            transform: translateY(-3px) scale(0.98);
        }

        .phone-link {
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .customer-avatar-large {
            transition: all 1s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        /* Accessibility improvements */
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }

        /* Focus states */
        .btn-modern:focus,
        .info-item:focus,
        .phone-link:focus {
            outline: 3px solid rgba(102, 126, 234, 0.5);
            outline-offset: 2px;
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

    // Add accessibility features
    document.addEventListener('keydown', function(e) {
        // Focus management for accessibility
        if (e.key === 'Tab') {
            const focusableElements = document.querySelectorAll(
                'a[href], button, .info-item, [tabindex]:not([tabindex="-1"])'
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

    // Error handling for animations
    window.addEventListener('error', function(e) {
        console.warn('⚠️ Customer page animation error:', e.error);
    });

    // Add billing calculation tooltip
    const billingAmount = document.querySelector('.billing-amount');
    if (billingAmount) {
        billingAmount.addEventListener('mouseenter', function() {
            const tooltip = document.createElement('div');
            tooltip.className = 'billing-tooltip';
            tooltip.innerHTML = `
                <strong>Calculation Breakdown:</strong><br>
                Units: <%= customer.getUnitsConsumed() %><br>
                Rate: LKR 50.00/unit<br>
                Subtotal: LKR <%= String.format("%.2f", customer.getUnitsConsumed() * 50.0) %><br>
                Tax (8%): LKR <%= String.format("%.2f", customer.getUnitsConsumed() * 50.0 * 0.08) %><br>
                <strong>Total: LKR <%= String.format("%.2f", customer.getUnitsConsumed() * 50.0 * 1.08) %></strong>
            `;

            tooltip.style.cssText = `
                position: absolute;
                background: rgba(0,0,0,0.9);
                color: white;
                padding: 1rem;
                border-radius: 10px;
                font-size: 0.9rem;
                z-index: 1000;
                max-width: 250px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                animation: fadeInUp 0.3s ease-out;
            `;

            document.body.appendChild(tooltip);

            const rect = this.getBoundingClientRect();
            tooltip.style.left = `${rect.left - 125}px`;
            tooltip.style.top = `${rect.top - tooltip.offsetHeight - 10}px`;
        });

        billingAmount.addEventListener('mouseleave', function() {
            const tooltip = document.querySelector('.billing-tooltip');
            if (tooltip) {
                tooltip.style.animation = 'fadeOutUp 0.3s ease-out';
                setTimeout(() => {
                    if (tooltip.parentNode) {
                        tooltip.parentNode.removeChild(tooltip);
                    }
                }, 300);
            }
        });
    }

    // Initialize customer status indicator
    function updateCustomerStatusIndicator() {
        const statusElement = document.querySelector('.status-floating');
        const unitsConsumed = <%= customer.getUnitsConsumed() %>;

        if (unitsConsumed > 100) {
            statusElement.style.background = 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)';
            statusElement.innerHTML = '<i class="fas fa-crown"></i> Premium Customer';
        } else if (unitsConsumed > 50) {
            statusElement.style.background = 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)';
            statusElement.innerHTML = '<i class="fas fa-star"></i> Standard Customer';
        } else if (unitsConsumed > 0) {
            statusElement.style.background = 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)';
            statusElement.innerHTML = '<i class="fas fa-check-circle"></i> Active Customer';
        }
    }

    // Initialize all features
    document.addEventListener('DOMContentLoaded', function() {
        updateCustomerStatusIndicator();

        // Add smooth reveal animations
        const sections = document.querySelectorAll('.details-panel, .stats-card, .activity-section, .actions-panel');
        sections.forEach((section, index) => {
            section.style.animationDelay = `${index * 0.1}s`;
        });

        console.log('🎨 Advanced customer details interface loaded successfully');
    });
</script>
</body>
</html>
