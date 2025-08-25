<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Pahana Edu  Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        @keyframes slideDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        /* Dashboard Welcome */
        .dashboard-welcome {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem;
            border-radius: 2rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            animation: scaleIn 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @keyframes scaleIn {
            from {
                transform: scale(0.9);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .dashboard-welcome::before {
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

        .welcome-content {
            position: relative;
            z-index: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            animation: slideInLeft 0.8s ease-out;
        }

        @keyframes slideInLeft {
            from {
                transform: translateX(-50px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .welcome-text p {
            font-size: 1.25rem;
            opacity: 0.9;
            animation: slideInLeft 0.8s ease-out 0.2s both;
        }

        .welcome-illustration {
            font-size: 8rem;
            opacity: 0.2;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        /* Notification System */
        .notification {
            padding: 1.25rem 2rem;
            border-radius: 1rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: slideInRight 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
        }

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

        .notification::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            animation: notificationPulse 2s ease-in-out infinite;
        }

        @keyframes notificationPulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .notification-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .notification-success::before {
            background: var(--success-color);
        }

        .notification-error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .notification-error::before {
            background: var(--danger-color);
        }

        .notification-warning {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .notification-warning::before {
            background: var(--warning-color);
        }

        .notification-icon {
            font-size: 1.5rem;
            animation: iconBounce 0.6s ease-out;
        }

        @keyframes iconBounce {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }

        .notification-close {
            margin-left: auto;
            background: none;
            border: none;
            font-size: 1.25rem;
            cursor: pointer;
            opacity: 0.5;
            transition: opacity 0.3s ease;
        }

        .notification-close:hover {
            opacity: 1;
        }

        /* Quick Stats */
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: var(--bg-secondary);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .stat-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, transparent 0%, rgba(99, 102, 241, 0.1) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .stat-card:hover::after {
            opacity: 1;
        }

        .stat-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 1rem;
            font-size: 1.75rem;
            color: white;
            position: relative;
            animation: iconFloat 3s ease-in-out infinite;
        }

        @keyframes iconFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        .stat-card:nth-child(1) .stat-icon {
            background: var(--primary-gradient);
        }

        .stat-card:nth-child(2) .stat-icon {
            background: var(--secondary-gradient);
        }

        .stat-card:nth-child(3) .stat-icon {
            background: var(--success-gradient);
        }

        .stat-card:nth-child(4) .stat-icon {
            background: var(--warning-gradient);
        }

        .stat-content h3 {
            font-size: 2.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
            animation: countUp 1s ease-out;
        }

        @keyframes countUp {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }

        .stat-content p {
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-footer {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
        }

        .stat-change {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            font-weight: 600;
        }

        .stat-change.positive {
            color: var(--success-color);
        }

        .stat-change.negative {
            color: var(--danger-color);
        }

        .stat-change i {
            font-size: 0.75rem;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .action-card {
            background: var(--bg-secondary);
            border: 2px solid var(--border-color);
            padding: 2rem;
            border-radius: 1.5rem;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: zoomIn 0.6s ease-out;
        }

        @keyframes zoomIn {
            from {
                transform: scale(0.8);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .action-card:nth-child(1) { animation-delay: 0.1s; }
        .action-card:nth-child(2) { animation-delay: 0.2s; }
        .action-card:nth-child(3) { animation-delay: 0.3s; }
        .action-card:nth-child(4) { animation-delay: 0.4s; }

        .action-card::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: var(--primary-gradient);
            border-radius: 1.5rem;
            opacity: 0;
            z-index: -1;
            transition: opacity 0.3s ease;
        }

        .action-card:hover {
            transform: translateY(-5px);
            border-color: transparent;
        }

        .action-card:hover::before {
            opacity: 1;
        }

        .action-card:hover .action-icon {
            transform: rotateY(360deg);
            background: white;
            color: var(--primary-color);
        }

        .action-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            border-radius: 1.25rem;
            background: var(--primary-gradient);
            color: white;
            transition: all 0.6s ease;
        }

        .action-card:nth-child(2) .action-icon {
            background: var(--secondary-gradient);
        }

        .action-card:nth-child(3) .action-icon {
            background: var(--success-gradient);
        }

        .action-card:nth-child(4) .action-icon {
            background: var(--warning-gradient);
        }

        .action-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.75rem;
        }

        .action-description {
            color: var(--text-secondary);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        /* Recent Activity */
        .recent-activity {
            background: var(--bg-secondary);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: var(--shadow-md);
            animation: slideInUp 0.8s ease-out;
        }

        @keyframes slideInUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .activity-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .activity-header h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .activity-header h3 i {
            color: var(--primary-color);
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            padding: 1.25rem;
            border-radius: 1rem;
            background: var(--bg-primary);
            transition: all 0.3s ease;
            animation: slideInFromLeft 0.6s ease-out;
        }

        @keyframes slideInFromLeft {
            from {
                transform: translateX(-30px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .activity-item:nth-child(1) { animation-delay: 0.1s; }
        .activity-item:nth-child(2) { animation-delay: 0.2s; }
        .activity-item:nth-child(3) { animation-delay: 0.3s; }
        .activity-item:nth-child(4) { animation-delay: 0.4s; }

        .activity-item:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow-md);
        }

        .activity-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0.75rem;
            font-size: 1.25rem;
            color: white;
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .activity-time {
            font-size: 0.875rem;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Buttons */
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
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn:active::before {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
        }

        /* Loading Spinner */
        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Low Stock Alert */
        .low-stock-alert {
            background: var(--danger-gradient);
            color: white;
            padding: 1.5rem 2rem;
            border-radius: 1rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .low-stock-alert i {
            font-size: 1.5rem;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }

            .navbar-nav {
                flex-wrap: wrap;
                justify-content: center;
            }

            .welcome-content {
                flex-direction: column;
                text-align: center;
            }

            .welcome-illustration {
                font-size: 5rem;
            }

            .quick-stats,
            .quick-actions {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="bg-animation"></div>

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
            <i class="fas fa-book-open"></i>
            Pahana Edu
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link active">
                <i class="fas fa-chart-line"></i> Dashboard
            </a></li>
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link">
                <i class="fas fa-users"></i> Customers
            </a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link">
                <i class="fas fa-books"></i> Books
            </a></li>
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link">
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
    <!-- Welcome Section -->
    <div class="dashboard-welcome">
        <div class="welcome-content">
            <div class="welcome-text">
                <h1>Welcome back, <%= adminUsername %>!</h1>
                <p>Your Pahana Edu Dashboard - Managing Knowledge, One Book at a Time</p>
            </div>
            <div class="welcome-illustration">
                <i class="fas fa-book-reader"></i>
            </div>
        </div>
    </div>

    <!-- Notifications -->
    <% if (request.getParameter("success") != null) { %>
    <div class="notification notification-success">
        <i class="fas fa-check-circle notification-icon"></i>
        <div>
            <strong>Success!</strong> <%= request.getParameter("success") %>
        </div>
        <button class="notification-close" onclick="this.parentElement.style.display='none'">
            <i class="fas fa-times"></i>
        </button>
    </div>
    <% } %>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="notification notification-error">
        <i class="fas fa-exclamation-circle notification-icon"></i>
        <div>
            <strong>Error!</strong> <%= request.getAttribute("errorMessage") %>
        </div>
        <button class="notification-close" onclick="this.parentElement.style.display='none'">
            <i class="fas fa-times"></i>
        </button>
    </div>
    <% } %>

    <!-- Low Stock Alert -->
    <% if (hasLowStock && lowStockCount > 0) { %>
    <div class="low-stock-alert">
        <i class="fas fa-exclamation-triangle"></i>
        <div style="flex: 1;">
            <strong>Low Stock Alert!</strong>
            <%= lowStockCount %> book(s) are running low. Restock them to avoid lost sales.
        </div>
        <a href="${pageContext.request.contextPath}/item?action=lowStock" class="btn btn-primary">
            <i class="fas fa-boxes"></i> View Low Stock
        </a>
    </div>
    <% } %>

    <!-- Quick Statistics -->
    <div class="quick-stats">
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-content">
                    <h3><%= totalCustomers %></h3>
                    <p>Total Customers</p>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
            </div>
            <div class="stat-footer">
                <% if (hasCustomers) { %>
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i> Active readers
                </div>
                <% } else { %>
                <div class="stat-change">
                    <i class="fas fa-info-circle"></i> Start adding customers
                </div>
                <% } %>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-content">
                    <h3><%= totalItems %></h3>
                    <p>Book Titles</p>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-book"></i>
                </div>
            </div>
            <div class="stat-footer">
                <div class="stat-change">
                    <i class="fas fa-layer-group"></i> <%= totalStock %> total copies
                    <% if (lowStockCount > 0) { %>
                    <span style="color: var(--danger-color); margin-left: 0.5rem;">
                        • <%= lowStockCount %> low stock
                    </span>
                    <% } %>
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-content">
                    <h3>LKR <%= String.format("%,.2f", todaysRevenue) %></h3>
                    <p>Today's Sales</p>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
            </div>
            <div class="stat-footer">
                <div class="stat-change">
                    <i class="fas fa-calendar-alt"></i>
                    Month: LKR <%= String.format("%,.2f", monthlyRevenue) %>
                </div>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-content">
                    <h3>LKR <%= String.format("%,.2f", inventoryValue) %></h3>
                    <p>Inventory Value</p>
                </div>
                <div class="stat-icon">
                    <i class="fas fa-coins"></i>
                </div>
            </div>
            <div class="stat-footer">
                <div class="stat-change positive">
                    <i class="fas fa-shield-alt"></i> Total assets secured
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <div class="action-card">
            <div class="action-icon">
                <i class="fas fa-user-plus"></i>
            </div>
            <h3 class="action-title">Customer Management</h3>
            <p class="action-description">Register new readers, manage accounts, and track customer preferences</p>
            <a href="${pageContext.request.contextPath}/customer" class="btn btn-primary">
                <i class="fas fa-arrow-right"></i> Manage Customers
            </a>
        </div>

        <div class="action-card">
            <div class="action-icon">
                <i class="fas fa-book-medical"></i>
            </div>
            <h3 class="action-title">Book Inventory</h3>
            <p class="action-description">Add new books, update stock levels, and manage your catalog</p>
            <a href="${pageContext.request.contextPath}/item" class="btn btn-primary">
                <i class="fas fa-arrow-right"></i> Manage Books
            </a>
        </div>

        <div class="action-card">
            <div class="action-icon">
                <i class="fas fa-file-invoice-dollar"></i>
            </div>
            <h3 class="action-title">Create Invoice</h3>
            <p class="action-description">Process sales, generate bills, and manage transactions</p>
            <a href="${pageContext.request.contextPath}/bill" class="btn btn-primary">
                <i class="fas fa-arrow-right"></i> New Invoice
            </a>
        </div>

        <div class="action-card">
            <div class="action-icon">
                <i class="fas fa-headset"></i>
            </div>
            <h3 class="action-title">Support Center</h3>
            <p class="action-description">Get help with system features and troubleshooting</p>
            <a href="${pageContext.request.contextPath}/jsp/help.jsp" class="btn btn-primary">
                <i class="fas fa-arrow-right"></i> Get Support
            </a>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="recent-activity">
        <div class="activity-header">
            <h3><i class="fas fa-clock"></i> System Overview</h3>
            <small id="lastUpdate">Last updated: Just now</small>
        </div>

        <div class="activity-list">
            <div class="activity-item">
                <div class="activity-icon" style="background: var(--primary-gradient);">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-title">Sales Performance</div>
                    <div class="activity-time">
                        <i class="fas fa-shopping-cart"></i>
                        <%= billStats %>
                    </div>
                </div>
            </div>

            <div class="activity-item">
                <div class="activity-icon" style="background: var(--secondary-gradient);">
                    <i class="fas fa-warehouse"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-title">Inventory Status</div>
                    <div class="activity-time">
                        <i class="fas fa-boxes"></i>
                        <%= totalItems %> unique titles • <%= totalStock %> total books
                        <% if (lowStockCount > 0) { %>
                        <span style="color: var(--danger-color); font-weight: 600;">
                            • <%= lowStockCount %> need restocking
                        </span>
                        <% } else { %>
                        <span style="color: var(--success-color); font-weight: 600;">
                            • All books well stocked
                        </span>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="activity-item">
                <div class="activity-icon" style="background: var(--success-gradient);">
                    <i class="fas fa-user-check"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-title">Customer Base</div>
                    <div class="activity-time">
                        <i class="fas fa-address-book"></i>
                        <%= totalCustomers %> registered customers
                        <% if (hasCustomers) { %>
                        <span style="color: var(--success-color); font-weight: 600;">
                            • Ready for transactions
                        </span>
                        <% } else { %>
                        <span style="color: var(--warning-color); font-weight: 600;">
                            • Add customers to start
                        </span>
                        <% } %>
                    </div>
                </div>
            </div>

            <% if (!hasCustomers || !hasItems) { %>
            <div class="activity-item">
                <div class="activity-icon" style="background: var(--warning-gradient);">
                    <i class="fas fa-rocket"></i>
                </div>
                <div class="activity-content">
                    <div class="activity-title">Getting Started</div>
                    <div class="activity-time">
                        <i class="fas fa-info-circle"></i>
                        <% if (!hasCustomers && !hasItems) { %>
                        Welcome! Start by adding customers and books to your inventory
                        <% } else if (!hasCustomers) { %>
                        Add customers to start creating invoices
                        <% } else { %>
                        Add books to your inventory to begin sales
                        <% } %>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Quick Insights Section -->
    <div class="quick-insights" style="margin-top: 2rem;">
        <div class="insights-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem;">
            <div class="insight-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 1.5rem; border-radius: 1rem; text-align: center;">
                <i class="fas fa-fire" style="font-size: 2rem; margin-bottom: 0.5rem;"></i>
                <h4 style="margin: 0.5rem 0;">Best Sellers</h4>
                <p style="margin: 0; opacity: 0.9;">Track your top-selling books</p>
                <a href="${pageContext.request.contextPath}/item?action=popular" style="color: white; text-decoration: underline; font-size: 0.875rem;">View Report →</a>
            </div>

            <div class="insight-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; padding: 1.5rem; border-radius: 1rem; text-align: center;">
                <i class="fas fa-percentage" style="font-size: 2rem; margin-bottom: 0.5rem;"></i>
                <h4 style="margin: 0.5rem 0;">Active Discounts</h4>
                <p style="margin: 0; opacity: 0.9;">Manage special offers</p>
                <a href="${pageContext.request.contextPath}/item?action=manageDiscount" style="color: white; text-decoration: underline; font-size: 0.875rem;">Manage Discounts →</a>
            </div>

            <div class="insight-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; padding: 1.5rem; border-radius: 1rem; text-align: center;">
                <i class="fas fa-history" style="font-size: 2rem; margin-bottom: 0.5rem;"></i>
                <h4 style="margin: 0.5rem 0;">Recent Bills</h4>
                <p style="margin: 0; opacity: 0.9;">View latest transactions</p>
                <a href="${pageContext.request.contextPath}/bill?action=recent" style="color: white; text-decoration: underline; font-size: 0.875rem;">View Bills →</a>
            </div>

            <div class="insight-card" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: white; padding: 1.5rem; border-radius: 1rem; text-align: center;">
                <i class="fas fa-chart-pie" style="font-size: 2rem; margin-bottom: 0.5rem;"></i>
                <h4 style="margin: 0.5rem 0;">Reports</h4>
                <p style="margin: 0; opacity: 0.9;">Analytics & insights</p>
                <a href="${pageContext.request.contextPath}/reports" style="color: white; text-decoration: underline; font-size: 0.875rem;">View Reports →</a>
            </div>
        </div>
    </div>
</div>

<!-- Floating Action Button -->
<div class="fab-container" style="position: fixed; bottom: 2rem; right: 2rem; z-index: 1000;">
    <button class="fab" id="fabButton" style="width: 60px; height: 60px; border-radius: 50%; background: var(--primary-gradient); color: white; border: none; box-shadow: var(--shadow-xl); cursor: pointer; font-size: 1.5rem; transition: all 0.3s ease; position: relative;">
        <i class="fas fa-plus" style="transition: transform 0.3s ease;"></i>
    </button>
    <div class="fab-menu" id="fabMenu" style="position: absolute; bottom: 70px; right: 0; display: none;">
        <a href="${pageContext.request.contextPath}/bill?action=new" class="fab-item" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem 1.25rem; background: white; border-radius: 2rem; box-shadow: var(--shadow-lg); margin-bottom: 0.75rem; text-decoration: none; color: var(--text-primary); font-weight: 500; white-space: nowrap; transform: scale(0); animation: fabItemPop 0.3s ease forwards;">
            <i class="fas fa-file-invoice" style="color: var(--primary-color);"></i> New Invoice
        </a>
        <a href="${pageContext.request.contextPath}/customer?action=add" class="fab-item" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem 1.25rem; background: white; border-radius: 2rem; box-shadow: var(--shadow-lg); margin-bottom: 0.75rem; text-decoration: none; color: var(--text-primary); font-weight: 500; white-space: nowrap; transform: scale(0); animation: fabItemPop 0.3s ease forwards; animation-delay: 0.1s;">
            <i class="fas fa-user-plus" style="color: var(--secondary-color);"></i> Add Customer
        </a>
        <a href="${pageContext.request.contextPath}/item?action=add" class="fab-item" style="display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem 1.25rem; background: white; border-radius: 2rem; box-shadow: var(--shadow-lg); margin-bottom: 0.75rem; text-decoration: none; color: var(--text-primary); font-weight: 500; white-space: nowrap; transform: scale(0); animation: fabItemPop 0.3s ease forwards; animation-delay: 0.2s;">
            <i class="fas fa-book-medical" style="color: var(--success-color);"></i> Add Book
        </a>
    </div>
</div>

<style>
    @keyframes fabItemPop {
        to {
            transform: scale(1);
        }
    }

    .fab:hover {
        transform: scale(1.1);
    }

    .fab-item:hover {
        transform: translateX(-5px);
    }

    /* Additional animations for insights cards */
    .insight-card {
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        animation: fadeInUp 0.8s ease-out;
    }

    .insight-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
    }

    .insights-grid > :nth-child(1) { animation-delay: 0.1s; }
    .insights-grid > :nth-child(2) { animation-delay: 0.2s; }
    .insights-grid > :nth-child(3) { animation-delay: 0.3s; }
    .insights-grid > :nth-child(4) { animation-delay: 0.4s; }
</style>

<script>
    // Auto-refresh dashboard every 5 minutes
    let refreshTimeout = setTimeout(function() {
        window.location.reload();
    }, 300000); // 5 minutes

    // Update timestamp
    let startTime = Date.now();
    function updateTimestamp() {
        let elapsed = Math.floor((Date.now() - startTime) / 1000);
        let timeString;

        if (elapsed < 60) {
            timeString = 'Just now';
        } else if (elapsed < 3600) {
            let minutes = Math.floor(elapsed / 60);
            timeString = minutes + ' minute' + (minutes > 1 ? 's' : '') + ' ago';
        } else {
            let hours = Math.floor(elapsed / 3600);
            timeString = hours + ' hour' + (hours > 1 ? 's' : '') + ' ago';
        }

        document.getElementById('lastUpdate').textContent = 'Last updated: ' + timeString;
    }

    setInterval(updateTimestamp, 10000); // Update every 10 seconds

    // FAB Menu Toggle
    const fabButton = document.getElementById('fabButton');
    const fabMenu = document.getElementById('fabMenu');
    let fabOpen = false;

    fabButton.addEventListener('click', function() {
        fabOpen = !fabOpen;
        if (fabOpen) {
            fabMenu.style.display = 'block';
            fabButton.querySelector('i').style.transform = 'rotate(45deg)';
            fabButton.style.background = 'var(--danger-gradient)';
        } else {
            fabMenu.style.display = 'none';
            fabButton.querySelector('i').style.transform = 'rotate(0deg)';
            fabButton.style.background = 'var(--primary-gradient)';
        }
    });

    // Close FAB menu when clicking outside
    document.addEventListener('click', function(e) {
        if (!fabButton.contains(e.target) && !fabMenu.contains(e.target) && fabOpen) {
            fabOpen = false;
            fabMenu.style.display = 'none';
            fabButton.querySelector('i').style.transform = 'rotate(0deg)';
            fabButton.style.background = 'var(--primary-gradient)';
        }
    });

    // Add loading animation for action buttons
    document.querySelectorAll('.action-card .btn').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            const originalContent = this.innerHTML;
            this.innerHTML = '<span class="spinner"></span> Loading...';
            this.disabled = true;

            // Prevent default if something goes wrong
            setTimeout(() => {
                if (this.disabled) {
                    this.innerHTML = originalContent;
                    this.disabled = false;
                }
            }, 5000);
        });
    });

    // Notification auto-hide
    document.querySelectorAll('.notification').forEach(function(notification) {
        setTimeout(function() {
            notification.style.animation = 'slideOutRight 0.5s ease forwards';
            setTimeout(function() {
                notification.style.display = 'none';
            }, 500);
        }, 5000);
    });

    // Add number animation for statistics
    function animateNumber(element, target) {
        const start = 0;
        const duration = 1000;
        const increment = target / (duration / 16);
        let current = start;

        const timer = setInterval(function() {
            current += increment;
            if (current >= target) {
                current = target;
                clearInterval(timer);
            }

            if (element.textContent.includes('LKR')) {
                element.textContent = 'LKR ' + current.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            } else {
                element.textContent = Math.floor(current);
            }
        }, 16);
    }

    // Animate statistics on page load
    window.addEventListener('load', function() {
        document.querySelectorAll('.stat-content h3').forEach(function(stat) {
            const text = stat.textContent;
            if (text.includes('LKR')) {
                const value = parseFloat(text.replace(/[^0-9.-]+/g, ''));
                animateNumber(stat, value);
            } else {
                const value = parseInt(text.replace(/[^0-9-]+/g, ''));
                animateNumber(stat, value);
            }
        });
    });

    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl/Cmd + N: New Invoice
        if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
            e.preventDefault();
            window.location.href = '${pageContext.request.contextPath}/bill?action=new';
        }
        // Ctrl/Cmd + I: Go to Items
        if ((e.ctrlKey || e.metaKey) && e.key === 'i') {
            e.preventDefault();
            window.location.href = '${pageContext.request.contextPath}/item';
        }
        // Ctrl/Cmd + U: Go to Customers
        if ((e.ctrlKey || e.metaKey) && e.key === 'u') {
            e.preventDefault();
            window.location.href = '${pageContext.request.contextPath}/customer';
        }
    });

    // Add tooltip for keyboard shortcuts
    const shortcutTooltip = document.createElement('div');
    shortcutTooltip.style.cssText = `
        position: fixed;
        bottom: 2rem;
        left: 2rem;
        background: var(--bg-dark);
        color: white;
        padding: 0.75rem 1.25rem;
        border-radius: 0.5rem;
        font-size: 0.875rem;
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: 1000;
    `;
    shortcutTooltip.innerHTML = `
        <strong>Keyboard Shortcuts:</strong><br>
        Ctrl+N - New Invoice<br>
        Ctrl+I - Inventory<br>
        Ctrl+U - Customers
    `;
    document.body.appendChild(shortcutTooltip);

    // Show tooltip on Ctrl/Cmd press
    let ctrlTimeout;
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey || e.metaKey) {
            shortcutTooltip.style.opacity = '0.9';
            clearTimeout(ctrlTimeout);
        }
    });

    document.addEventListener('keyup', function(e) {
        if (!e.ctrlKey && !e.metaKey) {
            ctrlTimeout = setTimeout(function() {
                shortcutTooltip.style.opacity = '0';
            }, 500);
        }
    });

    // Performance monitoring
    window.addEventListener('load', function() {
        const loadTime = performance.timing.loadEventEnd - performance.timing.navigationStart;
        console.log('Dashboard loaded in ' + loadTime + 'ms');

        // Show performance warning if load time is high
        if (loadTime > 3000) {
            console.warn('Dashboard load time is high. Consider optimizing queries.');
        }
    });

    // Prevent session timeout warning
    let warningShown = false;
    let sessionWarningTimeout = setTimeout(function() {
        if (!warningShown) {
            warningShown = true;
            if (confirm('Your session will expire soon. Do you want to stay logged in?')) {
                // Refresh the page to extend session
                clearTimeout(refreshTimeout);
                window.location.reload();
            }
        }
    }, 240000); // 4 minutes (1 minute before auto-refresh)
</script>

</body>
</html>
