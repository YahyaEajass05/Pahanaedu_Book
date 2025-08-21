<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Item - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css');

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --dark-gradient: linear-gradient(135deg, #434343 0%, #000000 100%);
            --card-shadow: 0 10px 40px rgba(0,0,0,0.1);
            --hover-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Hero Section with Glassmorphism */
        .item-hero {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            padding: 3rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            animation: slideInDown 0.8s ease-out;
        }

        .item-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .hero-content {
            display: flex;
            align-items: center;
            gap: 2rem;
            position: relative;
            z-index: 2;
        }

        .item-avatar {
            width: 120px;
            height: 120px;
            background: var(--success-gradient);
            border-radius: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            box-shadow: var(--card-shadow);
            animation: pulse 2s infinite;
            position: relative;
        }

        .item-avatar::after {
            content: '';
            position: absolute;
            inset: -3px;
            background: var(--success-gradient);
            border-radius: inherit;
            z-index: -1;
            filter: blur(10px);
            opacity: 0.7;
            animation: glow 2s ease-in-out infinite alternate;
        }

        .hero-info h1 {
            font-size: 3rem;
            margin: 0 0 1rem 0;
            color: white;
            font-weight: 700;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            animation: fadeInLeft 0.8s ease-out 0.2s both;
        }

        .hero-info p {
            font-size: 1.2rem;
            color: rgba(255,255,255,0.8);
            margin: 0;
            animation: fadeInLeft 0.8s ease-out 0.4s both;
        }

        .status-badge {
            position: absolute;
            top: 2rem;
            right: 2rem;
            background: var(--warning-gradient);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            box-shadow: var(--card-shadow);
            animation: bounceIn 0.8s ease-out 0.6s both;
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
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .details-panel:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .panel-header {
            background: var(--primary-gradient);
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
            animation: rotate 10s linear infinite;
        }

        .panel-header h2 {
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
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .info-item {
            padding: 1.5rem;
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            border-radius: 15px;
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
        }

        .info-item:nth-child(even) {
            animation-delay: 0.1s;
        }

        .info-item:hover {
            transform: translateX(5px);
            background: linear-gradient(135deg, #e8f0ff 0%, #d0e0ff 100%);
        }

        .info-label {
            font-size: 0.85rem;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .info-value {
            font-size: 1.3rem;
            color: #333;
            font-weight: 700;
        }

        .info-value.price {
            background: var(--success-gradient);
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
            background: var(--secondary-gradient);
            color: white;
            padding: 1.5rem;
            text-align: center;
            position: relative;
        }

        .stats-header h3 {
            margin: 0;
            font-size: 1.2rem;
        }

        .stock-display {
            text-align: center;
            padding: 2rem;
            background: radial-gradient(circle at center, rgba(79, 172, 254, 0.1) 0%, transparent 70%);
        }

        .stock-number {
            font-size: 4rem;
            font-weight: 900;
            margin: 0;
            background: var(--warning-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: countUp 2s ease-out;
        }

        .stock-label {
            color: #666;
            font-weight: 600;
            margin: 1rem 0;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .metric-card {
            background: white;
            margin: 1rem;
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .metric-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .metric-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .metric-value {
            font-size: 2rem;
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
            background: var(--dark-gradient);
            color: white;
            padding: 2rem;
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
            width: 2px;
            background: linear-gradient(to bottom, #667eea, #764ba2);
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
            background: var(--primary-gradient);
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
        }

        .timeline-content {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            padding: 1.5rem;
            border-radius: 15px;
            flex: 1;
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
        }

        .timeline-content:hover {
            transform: translateX(10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .timeline-content h4 {
            margin: 0 0 0.5rem 0;
            color: #333;
            font-weight: 600;
        }

        .timeline-content p {
            margin: 0;
            color: #666;
            line-height: 1.6;
        }

        /* Action Buttons */
        .actions-panel {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 2rem;
            text-align: center;
            animation: slideInUp 0.8s ease-out;
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
            font-weight: 600;
            font-size: 1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            min-width: 160px;
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
            transform: translateY(-3px);
            box-shadow: var(--hover-shadow);
        }

        .btn-edit { background: var(--warning-gradient); }
        .btn-delete { background: var(--danger-gradient); }
        .btn-back { background: var(--dark-gradient); }

        /* Stock Status Indicators */
        .stock-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stock-high {
            background: rgba(67, 233, 123, 0.2);
            color: #28a745;
            border: 1px solid rgba(67, 233, 123, 0.3);
        }
        .stock-medium {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }
        .stock-low {
            background: rgba(250, 112, 154, 0.2);
            color: #dc3545;
            border: 1px solid rgba(250, 112, 154, 0.3);
            animation: pulse 1.5s infinite;
        }
        .stock-out {
            background: rgba(108, 117, 125, 0.2);
            color: #6c757d;
            border: 1px solid rgba(108, 117, 125, 0.3);
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
                filter: blur(10px);
            }
            to {
                opacity: 1;
                filter: blur(15px);
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

        @keyframes rotate {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
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
                font-size: 2rem;
            }

            .status-badge {
                position: static;
                margin-top: 1rem;
            }

            .info-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
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

            .stock-number {
                font-size: 3rem;
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

    Item item = (Item) request.getAttribute("item");
    if (item == null) {
        response.sendRedirect(request.getContextPath() + "/item");
        return;
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy 'at' HH:mm");

    // Calculate stock status
    String stockStatus = "";
    String stockClass = "";
    if (item.getStock() == 0) {
        stockStatus = "Out of Stock";
        stockClass = "stock-out";
    } else if (item.getStock() < 10) {
        stockStatus = "Low Stock";
        stockClass = "stock-low";
    } else if (item.getStock() < 50) {
        stockStatus = "Medium Stock";
        stockClass = "stock-medium";
    } else {
        stockStatus = "Well Stocked";
        stockClass = "stock-high";
    }

    // Calculate total value
    double totalValue = item.getPrice().doubleValue() * item.getStock();
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
    <!-- Display Success Messages -->
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <i class="icon-success">✓</i>
        <%= request.getParameter("success") %>
    </div>
    <% } %>

    <!-- Hero Section -->
    <div class="item-hero">
        <div class="hero-content">
            <div class="item-avatar">
                <i class="fas fa-cube"></i>
            </div>
            <div class="hero-info">
                <h1><%= item.getItemName() %></h1>
                <p><i class="fas fa-barcode"></i> Item ID: <%= item.getItemId() %></p>
            </div>
        </div>
        <div class="status-badge">
            <i class="fas fa-info-circle"></i>
            <%= stockStatus %>
        </div>
    </div>

    <!-- Main Content Grid -->
    <div class="content-grid">
        <!-- Item Details Panel -->
        <div class="details-panel">
            <div class="panel-header">
                <h2>
                    <i class="fas fa-info-circle"></i>
                    Item Details
                </h2>
            </div>
            <div class="panel-content">
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-tag"></i> Item ID
                        </div>
                        <div class="info-value"><%= item.getItemId() %></div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-box"></i> Item Name
                        </div>
                        <div class="info-value"><%= item.getItemName() %></div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-money-bill-wave"></i> Unit Price
                        </div>
                        <div class="info-value price">LKR <%= String.format("%.2f", item.getPrice()) %></div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-warehouse"></i> Stock Quantity
                        </div>
                        <div class="info-value">
                            <%= item.getStock() %> units
                            <div style="margin-top: 0.5rem;">
                                <span class="stock-indicator <%= stockClass %>">
                                    <i class="fas fa-circle"></i>
                                    <%= stockStatus %>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-calculator"></i> Total Value
                        </div>
                        <div class="info-value price">LKR <%= String.format("%.2f", totalValue) %></div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-calendar-plus"></i> Date Added
                        </div>
                        <div class="info-value">
                            <% if (item.getCreatedAt() != null) { %>
                            <%= dateFormat.format(item.getCreatedAt()) %>
                            <% } else { %>
                            Not available
                            <% } %>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-edit"></i> Last Updated
                        </div>
                        <div class="info-value">
                            <% if (item.getUpdatedAt() != null) { %>
                            <%= dateFormat.format(item.getUpdatedAt()) %>
                            <% } else { %>
                            Never updated
                            <% } %>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-chart-line"></i> Availability
                        </div>
                        <div class="info-value">
                            <%
                                String availability = item.getStock() == 0 ? "Unavailable" :
                                        item.getStock() < 10 ? "Limited" : "Available";
                            %>
                            <%= availability %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Sidebar -->
        <div class="stats-sidebar">
            <!-- Stock Display Card -->
            <div class="stats-card">
                <div class="stats-header">
                    <h3><i class="fas fa-chart-bar"></i> Stock Overview</h3>
                </div>
                <div class="stock-display">
                    <div class="stock-number"><%= item.getStock() %></div>
                    <div class="stock-label">Units Available</div>
                    <span class="stock-indicator <%= stockClass %>">
                        <i class="fas fa-circle"></i>
                        <%= stockStatus %>
                    </span>
                </div>
            </div>

            <!-- Metrics Cards -->
            <div class="stats-card">
                <div class="stats-header">
                    <h3><i class="fas fa-analytics"></i> Key Metrics</h3>
                </div>
                <div class="metric-card">
                    <div class="metric-value">LKR <%= String.format("%.2f", item.getPrice()) %></div>
                    <div class="metric-label">
                        <i class="fas fa-tag"></i> Unit Price
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-value">LKR <%= String.format("%.2f", totalValue) %></div>
                    <div class="metric-label">
                        <i class="fas fa-coins"></i> Total Value
                    </div>
                </div>
                <div class="metric-card">
                    <div class="metric-value">
                        <%
                            String priceCategory = item.getPrice().doubleValue() > 1000 ? "Premium" :
                                    item.getPrice().doubleValue() > 500 ? "Standard" : "Budget";
                        %>
                        <%= priceCategory %>
                    </div>
                    <div class="metric-label">
                        <i class="fas fa-star"></i> Category
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Activity Timeline -->
    <div class="activity-section">
        <div class="activity-header">
            <h3>
                <i class="fas fa-history"></i>
                Activity Timeline
            </h3>
        </div>
        <div class="timeline">
            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <div class="timeline-content">
                    <h4>Item Added to Inventory</h4>
                    <p>
                        <% if (item.getCreatedAt() != null) { %>
                        Item was successfully added to inventory on <%= dateFormat.format(item.getCreatedAt()) %>
                        <% } else { %>
                        Item creation date not available
                        <% } %>
                    </p>
                </div>
            </div>

            <% if (item.getUpdatedAt() != null &&
                    !item.getUpdatedAt().equals(item.getCreatedAt())) { %>
            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-edit"></i>
                </div>
                <div class="timeline-content">
                    <h4>Information Updated</h4>
                    <p>Item details were last modified on <%= dateFormat.format(item.getUpdatedAt()) %></p>
                </div>
            </div>
            <% } %>

            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="timeline-content">
                    <h4>Current Stock Status</h4>
                    <p>
                        <% if (item.getStock() == 0) { %>
                        <i class="fas fa-exclamation-triangle"></i> Item is out of stock and requires immediate restocking
                        <% } else if (item.getStock() < 10) { %>
                        <i class="fas fa-exclamation-triangle"></i> Low stock alert - only <%= item.getStock() %> units remaining
                        <% } else if (item.getStock() < 50) { %>
                        <i class="fas fa-check-circle"></i> Moderate stock levels - <%= item.getStock() %> units available
                        <% } else { %>
                        <i class="fas fa-check-circle"></i> Well stocked - <%= item.getStock() %> units available
                        <% } %>
                    </p>
                </div>
            </div>

            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="timeline-content">
                    <h4>Financial Overview</h4>
                    <p>
                        <i class="fas fa-tag"></i> Unit price: LKR <%= String.format("%.2f", item.getPrice()) %> •
                        <i class="fas fa-calculator"></i> Total inventory value: LKR <%= String.format("%.2f", totalValue) %>
                    </p>
                </div>
            </div>

            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-layer-group"></i>
                </div>
                <div class="timeline-content">
                    <h4>Item Classification</h4>
                    <p>
                        <% if (item.getPrice().doubleValue() > 1000) { %>
                        <i class="fas fa-crown"></i> Premium item - high-value category with premium pricing
                        <% } else if (item.getPrice().doubleValue() > 500) { %>
                        <i class="fas fa-medal"></i> Standard item - medium-value category with competitive pricing
                        <% } else { %>
                        <i class="fas fa-thumbs-up"></i> Budget-friendly item - affordable pricing for all customers
                        <% } %>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="actions-panel">
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/item?action=edit&itemId=<%= item.getItemId() %>"
               class="btn-modern btn-edit">
                <i class="fas fa-edit"></i>
                Edit Item
            </a>

            <a href="${pageContext.request.contextPath}/item?action=delete&itemId=<%= item.getItemId() %>"
               class="btn-modern btn-delete"
               onclick="return confirm('Are you sure you want to delete this item? This action cannot be undone.')">
                <i class="fas fa-trash-alt"></i>
                Delete Item
            </a>

            <a href="${pageContext.request.contextPath}/item"
               class="btn-modern btn-back">
                <i class="fas fa-arrow-left"></i>
                Back to Items
            </a>
        </div>
    </div>
</div>

<script>
    // Print item details
    function printItemDetails() {
        window.print();
    }

    // Copy item ID to clipboard
    function copyItemId() {
        const itemId = '<%= item.getItemId() %>';
        navigator.clipboard.writeText(itemId).then(function() {
            alert('Item ID copied to clipboard: ' + itemId);
        });
    }

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey) {
            switch(e.key) {
                case 'e':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/item?action=edit&itemId=<%= item.getItemId() %>';
                    break;
                case 'p':
                    e.preventDefault();
                    printItemDetails();
                    break;
                case 'c':
                    e.preventDefault();
                    copyItemId();
                    break;
            }
        }

        // ESC key to go back
        if (e.key === 'Escape') {
            window.location.href = '${pageContext.request.contextPath}/item';
        }
    });

    // Add tooltips for keyboard shortcuts
    document.addEventListener('DOMContentLoaded', function() {
        const editBtn = document.querySelector('.btn-edit');

        if (editBtn) {
            editBtn.title = 'Edit Item (Ctrl+E)';
        }
    });

    // Animate stats on page load
    document.addEventListener('DOMContentLoaded', function() {
        const stockNumber = document.querySelector('.stock-number');
        const finalValue = <%= item.getStock() %>;

        if (stockNumber && finalValue > 0) {
            let currentValue = 0;
            const increment = Math.ceil(finalValue / 30);
            const timer = setInterval(function() {
                currentValue += increment;
                if (currentValue >= finalValue) {
                    currentValue = finalValue;
                    clearInterval(timer);
                }
                stockNumber.textContent = currentValue;
            }, 50);
        }
    });

    // Stock level indicator animation
    function updateStockIndicator() {
        const stockStatus = document.querySelector('.stock-indicator');
        const stockValue = <%= item.getStock() %>;

        if (stockValue === 0) {
            stockStatus.style.animation = 'pulse 1s infinite';
        } else if (stockValue < 10) {
            stockStatus.style.animation = 'pulse 2s infinite';
        }
    }

    // Initialize animations and interactions
    document.addEventListener('DOMContentLoaded', function() {
        updateStockIndicator();

        // Add hover effects to timeline items
        const timelineItems = document.querySelectorAll('.timeline-item');
        timelineItems.forEach((item, index) => {
            item.style.animationDelay = `${index * 0.1}s`;

            item.addEventListener('mouseenter', function() {
                this.querySelector('.timeline-icon').style.transform = 'scale(1.1) rotate(5deg)';
                this.querySelector('.timeline-content').style.transform = 'translateX(15px)';
            });

            item.addEventListener('mouseleave', function() {
                this.querySelector('.timeline-icon').style.transform = 'scale(1) rotate(0deg)';
                this.querySelector('.timeline-content').style.transform = 'translateX(0)';
            });
        });

        // Add floating animation to hero elements
        const heroAvatar = document.querySelector('.item-avatar');
        if (heroAvatar) {
            setInterval(() => {
                heroAvatar.style.transform = 'translateY(-5px)';
                setTimeout(() => {
                    heroAvatar.style.transform = 'translateY(0px)';
                }, 1000);
            }, 2000);
        }

        // Add stagger animation to info items
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

        // Add dynamic gradient animation to buttons
        const modernButtons = document.querySelectorAll('.btn-modern');
        modernButtons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                this.style.backgroundSize = '200% 200%';
                this.style.backgroundPosition = 'right center';
                this.style.transition = 'all 0.3s ease';
            });

            button.addEventListener('mouseleave', function() {
                this.style.backgroundPosition = 'left center';
            });
        });

        // Add parallax effect to hero background
        const hero = document.querySelector('.item-hero');
        if (hero) {
            window.addEventListener('scroll', () => {
                const scrolled = window.pageYOffset;
                const parallax = scrolled * 0.5;
                hero.style.transform = `translateY(${parallax}px)`;
            });
        }

        // Add counting animation to metric values
        const metricValues = document.querySelectorAll('.metric-value');
        metricValues.forEach(metric => {
            const text = metric.textContent;
            if (text.includes('LKR')) {
                const numMatch = text.match(/[\d,.]+/);
                if (numMatch) {
                    const finalValue = parseFloat(numMatch[0].replace(',', ''));
                    let currentValue = 0;
                    const increment = finalValue / 50;
                    const prefix = text.split(numMatch[0])[0];
                    const suffix = text.split(numMatch[0])[1] || '';

                    const timer = setInterval(() => {
                        currentValue += increment;
                        if (currentValue >= finalValue) {
                            currentValue = finalValue;
                            clearInterval(timer);
                        }
                        metric.textContent = prefix + currentValue.toFixed(2) + suffix;
                    }, 30);
                }
            }
        });

        // Add smooth scrolling to sections
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

        // Observe all major sections
        const sections = document.querySelectorAll('.details-panel, .stats-card, .activity-section, .actions-panel');
        sections.forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(30px)';
            section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(section);
        });

        // Add dynamic typing effect to item name
        const itemName = document.querySelector('.hero-info h1');
        if (itemName) {
            const originalText = itemName.textContent;
            itemName.textContent = '';
            let i = 0;

            const typeWriter = () => {
                if (i < originalText.length) {
                    itemName.textContent += originalText.charAt(i);
                    i++;
                    setTimeout(typeWriter, 100);
                }
            };

            setTimeout(typeWriter, 500);
        }

        // Add glow effect to high-value items
        const priceElements = document.querySelectorAll('.info-value.price');
        priceElements.forEach(price => {
            const value = parseFloat(price.textContent.replace(/[^\d.]/g, ''));
            if (value > 1000) {
                price.style.textShadow = '0 0 20px rgba(67, 233, 123, 0.5)';
                price.style.animation = 'glow 2s ease-in-out infinite alternate';
            }
        });

        // Add interactive stock status indicator
        const stockIndicators = document.querySelectorAll('.stock-indicator');
        stockIndicators.forEach(indicator => {
            indicator.addEventListener('click', function() {
                this.style.transform = 'scale(1.1)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 200);
            });
        });

        // Add particle effect to low stock items
        const stockValue = <%= item.getStock() %>;
        if (stockValue < 10) {
            createParticleEffect();
        }

        // Add tooltip functionality
        const tooltipElements = document.querySelectorAll('[data-tooltip]');
        tooltipElements.forEach(element => {
            element.addEventListener('mouseenter', showTooltip);
            element.addEventListener('mouseleave', hideTooltip);
        });

        console.log('✨ Item view page animations initialized');
    });

    // Particle effect for low stock warning
    function createParticleEffect() {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        canvas.style.position = 'fixed';
        canvas.style.top = '0';
        canvas.style.left = '0';
        canvas.style.width = '100%';
        canvas.style.height = '100%';
        canvas.style.pointerEvents = 'none';
        canvas.style.zIndex = '1000';
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        document.body.appendChild(canvas);

        const particles = [];
        for (let i = 0; i < 50; i++) {
            particles.push({
                x: Math.random() * canvas.width,
                y: Math.random() * canvas.height,
                vx: (Math.random() - 0.5) * 2,
                vy: (Math.random() - 0.5) * 2,
                size: Math.random() * 3 + 1,
                opacity: Math.random() * 0.5 + 0.2
            });
        }

        function animateParticles() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            particles.forEach(particle => {
                particle.x += particle.vx;
                particle.y += particle.vy;

                if (particle.x < 0 || particle.x > canvas.width) particle.vx *= -1;
                if (particle.y < 0 || particle.y > canvas.height) particle.vy *= -1;

                ctx.beginPath();
                ctx.arc(particle.x, particle.y, particle.size, 0, Math.PI * 2);
                ctx.fillStyle = `rgba(250, 112, 154, ${particle.opacity})`;
                ctx.fill();
            });

            requestAnimationFrame(animateParticles);
        }

        animateParticles();

        // Remove particles after 10 seconds
        setTimeout(() => {
            document.body.removeChild(canvas);
        }, 10000);
    }

    // Tooltip functions
    function showTooltip(e) {
        const tooltip = document.createElement('div');
        tooltip.className = 'tooltip';
        tooltip.textContent = e.target.getAttribute('data-tooltip');
        tooltip.style.cssText = `
            position: absolute;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 0.5rem;
            border-radius: 5px;
            font-size: 0.8rem;
            z-index: 1000;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s ease;
        `;

        document.body.appendChild(tooltip);

        const rect = tooltip.getBoundingClientRect();
        tooltip.style.left = `${e.pageX - rect.width / 2}px`;
        tooltip.style.top = `${e.pageY - rect.height - 10}px`;

        setTimeout(() => {
            tooltip.style.opacity = '1';
        }, 10);
    }

    function hideTooltip() {
        const tooltips = document.querySelectorAll('.tooltip');
        tooltips.forEach(tooltip => {
            tooltip.style.opacity = '0';
            setTimeout(() => {
                if (tooltip.parentNode) {
                    tooltip.parentNode.removeChild(tooltip);
                }
            }, 300);
        });
    }

    // Add CSS for ripple effect
    const rippleStyle = document.createElement('style');
    rippleStyle.textContent = `
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        .particle-canvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1000;
        }

        .info-item {
            cursor: pointer;
        }

        .metric-card:hover {
            transform: translateY(-8px) scale(1.02);
        }

        .timeline-icon {
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
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
            transform: translateY(-2px) scale(0.98);
        }

        .stock-indicator {
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            cursor: pointer;
        }

        .item-avatar {
            transition: all 1s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
    `;
    document.head.appendChild(rippleStyle);

    // Performance monitoring
    const performanceObserver = new PerformanceObserver((list) => {
        list.getEntries().forEach((entry) => {
            console.log('🔍 Performance:', entry.name, entry.duration.toFixed(2) + 'ms');
        });
    });

    if ('PerformanceObserver' in window) {
        performanceObserver.observe({ entryTypes: ['navigation', 'resource'] });
    }

    // Add keyboard accessibility
    document.addEventListener('keydown', function(e) {
        // Focus management for accessibility
        if (e.key === 'Tab') {
            const focusableElements = document.querySelectorAll(
                'a[href], button, input, select, textarea, [tabindex]:not([tabindex="-1"])'
            );

            focusableElements.forEach(element => {
                element.addEventListener('focus', function() {
                    this.style.outline = '3px solid #667eea';
                    this.style.outlineOffset = '2px';
                });

                element.addEventListener('blur', function() {
                    this.style.outline = '';
                    this.style.outlineOffset = '';
                });
            });
        }
    });

    // Add error handling for animations
    window.addEventListener('error', function(e) {
        console.warn('⚠️ Animation error caught:', e.error);
    });

    console.log('🎨 Advanced item view interface loaded successfully');
</script>
</body>
</html>
