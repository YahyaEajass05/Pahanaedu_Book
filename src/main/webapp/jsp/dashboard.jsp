<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Pahana Edu Management System</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @keyframes slideInFromTop {
            0% { transform: translateY(-50px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        @keyframes slideInFromLeft {
            0% { transform: translateX(-50px); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideInFromRight {
            0% { transform: translateX(50px); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }

        @keyframes fadeInUp {
            0% { transform: translateY(30px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }

        @keyframes glow {
            0%, 100% { box-shadow: 0 0 5px rgba(139, 69, 19, 0.3); }
            50% { box-shadow: 0 0 20px rgba(139, 69, 19, 0.6), 0 0 30px rgba(139, 69, 19, 0.4); }
        }

        .dashboard-welcome {
            background: linear-gradient(135deg, #8B4513 0%, #D2691E 50%, #CD853F 100%);
            color: white;
            padding: 3rem 2rem;
            border-radius: 25px;
            margin-bottom: 3rem;
            text-align: center;
            box-shadow: 0 15px 35px rgba(139, 69, 19, 0.3);
            position: relative;
            overflow: hidden;
            animation: slideInFromTop 0.8s ease-out;
        }

        .dashboard-welcome::before {
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

        .dashboard-welcome h1 {
            margin: 0 0 1rem 0;
            font-size: 3rem;
            font-weight: 800;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }

        .dashboard-welcome p {
            margin: 0;
            font-size: 1.4rem;
            opacity: 0.95;
            position: relative;
            z-index: 1;
        }

        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-top: 4px solid #FF6B35;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }

        .stat-card:hover::before {
            left: 100%;
        }

        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .stat-card:nth-child(1) {
            border-top-color: #FF6B35;
            animation-delay: 0.1s;
        }
        .stat-card:nth-child(2) {
            border-top-color: #4ECDC4;
            animation-delay: 0.2s;
        }
        .stat-card:nth-child(3) {
            border-top-color: #45B7D1;
            animation-delay: 0.3s;
        }
        .stat-card:nth-child(4) {
            border-top-color: #96CEB4;
            animation-delay: 0.4s;
        }

        .stat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .stat-icon {
            font-size: 3.5rem;
            opacity: 0.8;
            transition: all 0.3s ease;
            animation: bounce 2s infinite;
        }

        .stat-card:hover .stat-icon {
            opacity: 1;
            transform: rotate(10deg) scale(1.1);
            animation-play-state: paused;
        }

        .stat-card:nth-child(1) .stat-icon { color: #FF6B35; }
        .stat-card:nth-child(2) .stat-icon { color: #4ECDC4; }
        .stat-card:nth-child(3) .stat-icon { color: #45B7D1; }
        .stat-card:nth-child(4) .stat-icon { color: #96CEB4; }

        .stat-number {
            font-size: 2.8rem;
            font-weight: 900;
            color: #2c3e50;
            margin: 0;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .stat-label {
            color: #5a6c7d;
            font-size: 1.1rem;
            font-weight: 600;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .stat-change {
            font-size: 0.95rem;
            margin-top: 0.8rem;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 15px;
            background: rgba(0,0,0,0.05);
        }

        .stat-change.positive {
            color: #27ae60;
            background: rgba(39, 174, 96, 0.1);
        }

        .stat-change.negative {
            color: #e74c3c;
            background: rgba(231, 76, 60, 0.1);
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .action-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2.5rem 2rem;
            border-radius: 25px;
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.3);
            text-align: center;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            animation: slideInFromLeft 0.8s ease-out;
        }

        .action-card:nth-child(1) {
            background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
            box-shadow: 0 15px 30px rgba(255, 107, 53, 0.3);
            animation: slideInFromLeft 0.8s ease-out;
            animation-delay: 0.1s;
        }
        .action-card:nth-child(2) {
            background: linear-gradient(135deg, #4ECDC4 0%, #44A08D 100%);
            box-shadow: 0 15px 30px rgba(78, 205, 196, 0.3);
            animation: slideInFromRight 0.8s ease-out;
            animation-delay: 0.2s;
        }
        .action-card:nth-child(3) {
            background: linear-gradient(135deg, #45B7D1 0%, #96C93D 100%);
            box-shadow: 0 15px 30px rgba(69, 183, 209, 0.3);
            animation: slideInFromLeft 0.8s ease-out;
            animation-delay: 0.3s;
        }
        .action-card:nth-child(4) {
            background: linear-gradient(135deg, #96CEB4 0%, #FCEA2B 100%);
            box-shadow: 0 15px 30px rgba(150, 206, 180, 0.3);
            animation: slideInFromRight 0.8s ease-out;
            animation-delay: 0.4s;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.6s;
        }

        .action-card:hover::before {
            left: 100%;
        }

        .action-card:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
        }

        .action-icon {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            color: rgba(255,255,255,0.9);
            transition: all 0.3s ease;
            animation: pulse 2s infinite;
        }

        .action-card:hover .action-icon {
            transform: scale(1.2) rotate(360deg);
            animation-play-state: paused;
        }

        .action-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .action-description {
            margin-bottom: 2rem;
            line-height: 1.6;
            opacity: 0.9;
            font-size: 1.05rem;
        }

        .recent-activity {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            padding: 2.5rem;
            border-radius: 25px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            animation: fadeInUp 1s ease-out;
            animation-delay: 0.5s;
        }

        .activity-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #e9ecef;
        }

        .activity-header h3 {
            color: #8B4513;
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
        }

        .activity-item {
            padding: 1.5rem 0;
            border-bottom: 1px solid #f1f3f4;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            transition: all 0.3s ease;
            animation: slideInFromLeft 0.6s ease-out;
        }

        .activity-item:nth-child(even) {
            animation: slideInFromRight 0.6s ease-out;
        }

        .activity-item:hover {
            transform: translateX(10px);
            background: rgba(139, 69, 19, 0.05);
            border-radius: 15px;
            padding-left: 1rem;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 55px;
            height: 55px;
            background: linear-gradient(135deg, #8B4513 0%, #D2691E 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            transition: all 0.3s ease;
            animation: glow 2s infinite;
        }

        .activity-item:hover .activity-icon {
            transform: rotate(360deg) scale(1.1);
            animation-play-state: paused;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 700;
            color: #2c3e50;
            margin: 0 0 0.5rem 0;
            font-size: 1.2rem;
        }

        .activity-time {
            color: #6c757d;
            font-size: 1rem;
            margin: 0;
            line-height: 1.5;
        }

        .low-stock-alert {
            background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 20px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            box-shadow: 0 10px 25px rgba(255, 107, 53, 0.3);
            animation: slideInFromTop 0.6s ease-out, pulse 2s infinite;
        }

        .alert-icon {
            font-size: 2rem;
            animation: bounce 1s infinite;
        }

        .no-data {
            text-align: center;
            color: #8B4513;
            font-style: italic;
            padding: 3rem;
            font-size: 1.1rem;
        }

        /* Button Styles */
        .btn {
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
            color: white;
            box-shadow: 0 8px 15px rgba(255, 107, 53, 0.3);
        }

        .btn-warning {
            background: linear-gradient(135deg, #4ECDC4 0%, #44A08D 100%);
            color: white;
            box-shadow: 0 8px 15px rgba(78, 205, 196, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #45B7D1 0%, #96C93D 100%);
            color: white;
            box-shadow: 0 8px 15px rgba(69, 183, 209, 0.3);
        }

        .btn-info {
            background: linear-gradient(135deg, #96CEB4 0%, #FCEA2B 100%);
            color: #2c3e50;
            box-shadow: 0 8px 15px rgba(150, 206, 180, 0.3);
        }

        .btn:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 25px rgba(0,0,0,0.2);
        }

        /* Loading Spinner */
        .spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive Animations */
        @media (max-width: 768px) {
            .dashboard-welcome h1 {
                font-size: 2rem;
            }

            .stat-number {
                font-size: 2.2rem;
            }

            .action-icon {
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

    String adminUsername = (String) session.getAttribute("username");
    if (adminUsername == null) adminUsername = "Admin";

    // Get dashboard data
    Integer totalCustomers = (Integer) request.getAttribute("totalCustomers");
    Integer totalItems = (Integer) request.getAttribute("totalItems");
    Integer totalStock = (Integer) request.getAttribute("totalStock");
    BigDecimal inventoryValue = (BigDecimal) request.getAttribute("inventoryValue");
    Integer lowStockCount = (Integer) request.getAttribute("lowStockCount");
    BigDecimal todaysRevenue = (BigDecimal) request.getAttribute("todaysRevenue");
    BigDecimal monthlyRevenue = (BigDecimal) request.getAttribute("monthlyRevenue");
    String billStats = (String) request.getAttribute("billStats");
    Boolean hasLowStock = (Boolean) request.getAttribute("hasLowStock");
    Boolean hasCustomers = (Boolean) request.getAttribute("hasCustomers");
    Boolean hasItems = (Boolean) request.getAttribute("hasItems");

    // Set default values if null
    if (totalCustomers == null) totalCustomers = 0;
    if (totalItems == null) totalItems = 0;
    if (totalStock == null) totalStock = 0;
    if (inventoryValue == null) inventoryValue = BigDecimal.ZERO;
    if (lowStockCount == null) lowStockCount = 0;
    if (todaysRevenue == null) todaysRevenue = BigDecimal.ZERO;
    if (monthlyRevenue == null) monthlyRevenue = BigDecimal.ZERO;
    if (billStats == null) billStats = "No billing data available";
    if (hasLowStock == null) hasLowStock = false;
    if (hasCustomers == null) hasCustomers = false;
    if (hasItems == null) hasItems = false;
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            Pahana Edu Management
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link active">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link">Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link">Items</a></li>
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link">Billing</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link">Help</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- Welcome Section -->
    <div class="dashboard-welcome">
        <h1><i class="fas fa-graduation-cap" style="margin-right: 15px;"></i>Welcome, <%= adminUsername %>!</h1>
        <p><i class="fas fa-store" style="margin-right: 10px;"></i>Pahana Edu Bookshop Management System Dashboard</p>
    </div>

    <!-- Display success/error messages -->
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <i class="icon-success">✓</i>
        <%= request.getParameter("success") %>
    </div>
    <% } %>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <i class="icon-error">✗</i>
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <!-- Low Stock Alert -->
    <% if (hasLowStock && lowStockCount > 0) { %>
    <div class="low-stock-alert">
        <span class="alert-icon"><i class="fas fa-exclamation-triangle"></i></span>
        <div>
            <strong>Low Stock Alert!</strong>
            <%= lowStockCount %> item(s) are running low on stock.
            <a href="${pageContext.request.contextPath}/item?action=lowStock"
               style="color: white; text-decoration: underline; margin-left: 1rem;">View Items</a>
        </div>
    </div>
    <% } %>

    <!-- Quick Statistics -->
    <div class="quick-stats">
        <div class="stat-card">
            <div class="stat-header">
                <div>
                    <h2 class="stat-number"><%= totalCustomers %></h2>
                    <p class="stat-label">Total Customers</p>
                </div>
                <span class="stat-icon"><i class="fas fa-users"></i></span>
            </div>
            <% if (hasCustomers) { %>
            <div class="stat-change positive"><i class="fas fa-chart-line"></i> Active customer base</div>
            <% } else { %>
            <div class="stat-change">No customers registered yet</div>
            <% } %>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div>
                    <h2 class="stat-number"><%= totalItems %></h2>
                    <p class="stat-label">Total Items</p>
                </div>
                <span class="stat-icon"><i class="fas fa-book-open"></i></span>
            </div>
            <div class="stat-change">
                <%= totalStock %> units in stock
                <% if (lowStockCount > 0) { %>
                • <span style="color: #e74c3c;"><%= lowStockCount %> low stock</span>
                <% } %>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div>
                    <h2 class="stat-number">LKR <%= String.format("%.2f", todaysRevenue) %></h2>
                    <p class="stat-label">Today's Revenue</p>
                </div>
                <span class="stat-icon"><i class="fas fa-coins"></i></span>
            </div>
            <div class="stat-change">
                Monthly: LKR <%= String.format("%.2f", monthlyRevenue) %>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div>
                    <h2 class="stat-number">LKR <%= String.format("%.2f", inventoryValue) %></h2>
                    <p class="stat-label">Inventory Value</p>
                </div>
                <span class="stat-icon"><i class="fas fa-chart-pie"></i></span>
            </div>
            <div class="stat-change">Total asset value</div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <div class="action-card">
            <div class="action-icon"><i class="fas fa-user-friends"></i></div>
            <div class="action-title">Manage Customers</div>
            <div class="action-description">Add, edit, or view customer information and account details</div>
            <a href="${pageContext.request.contextPath}/customer" class="btn btn-primary">Go to Customers</a>
        </div>

        <div class="action-card">
            <div class="action-icon"><i class="fas fa-books"></i></div>
            <div class="action-title">Manage Items</div>
            <div class="action-description">Add new books, update inventory, and manage stock levels</div>
            <a href="${pageContext.request.contextPath}/item" class="btn btn-warning">Go to Items</a>
        </div>

        <div class="action-card">
            <div class="action-icon"><i class="fas fa-receipt"></i></div>
            <div class="action-title">Generate Bills</div>
            <div class="action-description">Create customer bills, calculate charges, and print invoices</div>
            <a href="${pageContext.request.contextPath}/bill" class="btn btn-success">Go to Billing</a>
        </div>

        <div class="action-card">
            <div class="action-icon"><i class="fas fa-question-circle"></i></div>
            <div class="action-title">Help & Support</div>
            <div class="action-description">View system usage guidelines and get help with features</div>
            <a href="${pageContext.request.contextPath}/jsp/help.jsp" class="btn btn-info">Get Help</a>
        </div>
    </div>

    <!-- Recent Activity / System Status -->
    <div class="recent-activity">
        <div class="activity-header">
            <h3><i class="fas fa-tachometer-alt" style="margin-right: 10px;"></i>System Status</h3>
            <small>Last updated: <%= new java.util.Date() %></small>
        </div>

        <div class="activity-item">
            <div class="activity-icon"><i class="fas fa-chart-bar"></i></div>
            <div class="activity-content">
                <p class="activity-title">Billing Statistics</p>
                <p class="activity-time"><%= billStats %></p>
            </div>
        </div>

        <div class="activity-item">
            <div class="activity-icon"><i class="fas fa-warehouse"></i></div>
            <div class="activity-content">
                <p class="activity-title">Inventory Status</p>
                <p class="activity-time">
                    <%= totalItems %> items with <%= totalStock %> total units
                    <% if (lowStockCount > 0) { %>
                    • <%= lowStockCount %> items need restocking
                    <% } else { %>
                    • All items adequately stocked
                    <% } %>
                </p>
            </div>
        </div>

        <div class="activity-item">
            <div class="activity-icon"><i class="fas fa-user-check"></i></div>
            <div class="activity-content">
                <p class="activity-title">Customer Base</p>
                <p class="activity-time">
                    <%= totalCustomers %> registered customers
                    <% if (hasCustomers) { %>
                    • Ready for billing operations
                    <% } else { %>
                    • Add customers to start billing
                    <% } %>
                </p>
            </div>
        </div>

        <% if (!hasCustomers && !hasItems) { %>
        <div class="activity-item">
            <div class="activity-icon"><i class="fas fa-rocket"></i></div>
            <div class="activity-content">
                <p class="activity-title">Getting Started</p>
                <p class="activity-time">
                    Welcome to Pahana Edu! Start by adding customers and items to begin using the system.
                </p>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script>
    // Auto-refresh dashboard every 5 minutes
    setTimeout(function() {
        window.location.reload();
    }, 300000); // 5 minutes

    // Add loading animation for action buttons
    document.querySelectorAll('.action-card .btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            this.innerHTML = '<span class="spinner"></span> Loading...';
            this.disabled = true;
        });
    });

    // Show time since page load
    let startTime = Date.now();
    function updateTimestamp() {
        let elapsed = Math.floor((Date.now() - startTime) / 1000);
        let minutes = Math.floor(elapsed / 60);
        let seconds = elapsed % 60;

        let timeString = minutes > 0 ?
            minutes + 'm ' + seconds + 's ago' :
            seconds + 's ago';

        document.querySelector('.activity-header small').textContent =
            'Last updated: ' + timeString;
    }

    // Update timestamp every second
    setInterval(updateTimestamp, 1000);

    // Add scroll reveal animation
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe elements for animation
    document.querySelectorAll('.stat-card, .action-card, .activity-item').forEach(el => {
        observer.observe(el);
    });
</script>
</body>
</html>
