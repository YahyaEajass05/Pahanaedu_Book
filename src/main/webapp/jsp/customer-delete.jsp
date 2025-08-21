<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Customer - Pahana Edu</title>
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Hero Warning Section */
        .delete-warning-hero {
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

        .delete-warning-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg, transparent, rgba(250, 112, 154, 0.3), transparent);
            animation: rotate 20s linear infinite;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .warning-icon {
            font-size: 5rem;
            margin-bottom: 2rem;
            animation: bounce 2s infinite;
            display: inline-block;
        }

        .delete-warning-hero h1 {
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

        .delete-warning-hero p {
            margin: 0;
            font-size: 1.3rem;
            opacity: 0.9;
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        /* Main Delete Container */
        .delete-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            animation: slideInUp 0.8s ease-out;
            transition: all 0.3s ease;
        }

        .delete-container:hover {
            box-shadow: var(--hover-shadow);
        }

        /* Danger Alert */
        .danger-alert {
            background: var(--danger-gradient);
            color: white;
            padding: 2rem;
            margin-bottom: 0;
            position: relative;
            overflow: hidden;
            animation: slideInLeft 0.6s ease-out;
        }

        .danger-alert::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 15s linear infinite;
        }

        .danger-alert-content {
            position: relative;
            z-index: 2;
        }

        .danger-alert h3 {
            color: white;
            margin: 0 0 1.5rem 0;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .danger-alert ul {
            color: rgba(255,255,255,0.95);
            margin: 0;
            padding-left: 2rem;
        }

        .danger-alert li {
            margin-bottom: 0.75rem;
            line-height: 1.6;
            font-size: 1rem;
        }

        /* Customer Summary Section */
        .customer-summary {
            padding: 3rem;
            border-bottom: 2px solid rgba(102, 126, 234, 0.1);
            animation: fadeInUp 0.6s ease-out;
        }

        .summary-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .summary-header h2 {
            color: #2c3e50;
            margin: 0 0 1rem 0;
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .summary-header p {
            color: #7f8c8d;
            margin: 0;
            font-size: 1.1rem;
        }

        .customer-card {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 20px;
            padding: 3rem;
            position: relative;
            transition: all 0.3s ease;
            animation: scaleIn 0.6s ease-out;
        }

        .customer-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
        }

        .customer-header-info {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .customer-avatar-delete {
            width: 100px;
            height: 100px;
            background: var(--danger-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: 900;
            color: white;
            box-shadow: var(--card-shadow);
            position: relative;
            animation: pulse 2s infinite;
        }

        .customer-avatar-delete::after {
            content: '';
            position: absolute;
            inset: -5px;
            background: var(--danger-gradient);
            border-radius: inherit;
            z-index: -1;
            filter: blur(15px);
            opacity: 0.7;
            animation: glow 2s ease-in-out infinite alternate;
        }

        .customer-main-info h3 {
            margin: 0 0 0.5rem 0;
            color: #2c3e50;
            font-size: 2.2rem;
            font-weight: 800;
        }

        .customer-main-info p {
            margin: 0;
            color: #7f8c8d;
            font-size: 1.2rem;
        }

        .deletion-badge {
            position: absolute;
            top: 2rem;
            right: 2rem;
            background: var(--danger-gradient);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 700;
            box-shadow: var(--card-shadow);
            animation: pulse 2s infinite;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .customer-details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
        }

        .detail-box {
            background: white;
            border: 1px solid rgba(102, 126, 234, 0.1);
            border-radius: 15px;
            padding: 2rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            animation: fadeInUp 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .detail-box:nth-child(even) {
            animation-delay: 0.1s;
        }

        .detail-box:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
        }

        .detail-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            transition: left 0.5s ease;
        }

        .detail-box:hover::before {
            left: 100%;
        }

        .detail-label {
            font-size: 0.9rem;
            color: #7f8c8d;
            margin-bottom: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-value {
            font-size: 1.2rem;
            color: #2c3e50;
            font-weight: 600;
            word-break: break-word;
        }

        .units-highlight {
            background: var(--warning-gradient) !important;
            color: white !important;
            text-align: center;
        }

        .units-highlight .detail-label {
            color: rgba(255,255,255,0.9);
        }

        .units-highlight .detail-value {
            color: white;
        }

        .units-number {
            font-size: 3rem;
            font-weight: 900;
            color: white;
            margin: 0;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
        }

        .units-label {
            color: rgba(255,255,255,0.9);
            font-weight: 600;
            margin: 0;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Impact Analysis */
        .impact-analysis {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 15px;
            padding: 2rem;
            margin: 3rem 0;
            color: white;
            animation: slideInRight 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .impact-analysis::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -30%;
            width: 120px;
            height: 120px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
        }

        .impact-analysis-content {
            position: relative;
            z-index: 2;
        }

        .impact-analysis h4 {
            color: white;
            margin: 0 0 1.5rem 0;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .impact-list {
            margin: 0;
            color: rgba(255,255,255,0.9);
            padding-left: 1.5rem;
        }

        .impact-list li {
            margin-bottom: 1rem;
            line-height: 1.6;
            font-size: 1rem;
        }

        /* Customer Activity Summary */
        .customer-activity-summary {
            background: var(--success-gradient);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin: 3rem 0;
            animation: slideInLeft 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .customer-activity-summary::before {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -20%;
            width: 100px;
            height: 100px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite reverse;
        }

        .activity-summary-content {
            position: relative;
            z-index: 2;
        }

        .customer-activity-summary h4 {
            color: white;
            margin: 0 0 2rem 0;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .activity-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1.5rem;
        }

        .activity-stat {
            text-align: center;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(20px);
            padding: 2rem;
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        .activity-stat:hover {
            transform: scale(1.05);
            background: rgba(255,255,255,0.3);
        }

        .activity-stat-number {
            font-size: 2rem;
            font-weight: 900;
            color: white;
            margin: 0;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
        }

        .activity-stat-label {
            font-size: 0.9rem;
            color: rgba(255,255,255,0.9);
            margin: 0.5rem 0 0 0;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Confirmation Section */
        .confirmation-section {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            padding: 3rem;
            text-align: center;
            animation: slideInUp 0.6s ease-out;
        }

        .confirmation-checkbox {
            background: white;
            border: 2px solid rgba(102, 126, 234, 0.2);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 3rem;
            display: inline-block;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
        }

        .confirmation-checkbox::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            transition: left 0.5s ease;
        }

        .confirmation-checkbox:hover::before {
            left: 100%;
        }

        .confirmation-checkbox:hover {
            border-color: #667eea;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9ff 100%);
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
        }

        .confirmation-checkbox input[type="checkbox"] {
            margin-right: 1rem;
            transform: scale(1.3);
            cursor: pointer;
        }

        .confirmation-text {
            color: #2c3e50;
            font-weight: 700;
            user-select: none;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        /* Action Buttons */
        .delete-actions {
            display: flex;
            gap: 2rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-delete-confirm {
            background: var(--danger-gradient);
            color: white;
            padding: 1.2rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
            min-width: 250px;
            opacity: 0.5;
            cursor: not-allowed;
            box-shadow: var(--card-shadow);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .btn-delete-confirm::before {
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

        .btn-delete-confirm.enabled::before {
            width: 300px;
            height: 300px;
        }

        .btn-delete-confirm.enabled {
            opacity: 1;
            cursor: pointer;
        }

        .btn-delete-confirm.enabled:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        .btn-keep, .btn-back {
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

        .btn-keep {
            background: var(--success-gradient);
            color: white;
        }

        .btn-back {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: white;
            border: 1px solid var(--glass-border);
        }

        .btn-keep:hover, .btn-back:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        .countdown {
            background: var(--primary-gradient);
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 800;
            margin-left: 1rem;
            animation: pulse 1s infinite;
        }

        /* Loading Spinner */
        .spinner {
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 0.5rem;
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

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .delete-warning-hero {
                padding: 3rem 1.5rem;
            }

            .delete-warning-hero h1 {
                font-size: 2.5rem;
                flex-direction: column;
                gap: 0.5rem;
            }

            .customer-header-info {
                flex-direction: column;
                text-align: center;
            }

            .customer-details-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .activity-stats {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .delete-actions {
                flex-direction: column;
                align-items: center;
            }

            .btn-delete-confirm,
            .btn-keep,
            .btn-back {
                width: 100%;
                max-width: 300px;
            }

            .deletion-badge {
                position: static;
                margin-top: 1rem;
                display: inline-flex;
            }
        }

        @media (max-width: 480px) {
            .warning-icon {
                font-size: 3.5rem;
            }

            .customer-avatar-delete {
                width: 80px;
                height: 80px;
                font-size: 2rem;
            }

            .customer-main-info h3 {
                font-size: 1.8rem;
            }
        }

        /* Accessibility */
        .btn-delete-confirm:focus,
        .btn-keep:focus,
        .btn-back:focus,
        .confirmation-checkbox:focus-within {
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

    Customer customer = (Customer) request.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/customer");
        return;
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
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
    <!-- Warning Hero Section -->
    <div class="delete-warning-hero">
        <div class="hero-content">
            <div class="warning-icon">
                <i class="fas fa-skull-crossbones"></i>
            </div>
            <h1>
                <i class="fas fa-user-times"></i>
                Delete Customer
            </h1>
            <p>This action will permanently remove the customer from the system</p>
        </div>
    </div>

    <!-- Delete Container -->
    <div class="delete-container">
        <!-- Danger Alert -->
        <div class="danger-alert">
            <div class="danger-alert-content">
                <h3>
                    <i class="fas fa-exclamation-triangle"></i>
                    Warning - Permanent Action
                </h3>
                <ul>
                    <li><strong>This action cannot be undone</strong> - the customer will be permanently deleted</li>
                    <li>All billing history associated with this customer will also be removed</li>
                    <li>Any pending bills or transactions will be lost</li>
                    <li>Customer data will be immediately removed from all reports</li>
                </ul>
            </div>
        </div>

        <!-- Customer Summary -->
        <div class="customer-summary">
            <div class="summary-header">
                <h2>
                    <i class="fas fa-user-slash"></i>
                    Customer to be Deleted
                </h2>
                <p>Review the customer information below before confirming deletion</p>
            </div>

            <div class="customer-card">
                <div class="deletion-badge">
                    <i class="fas fa-ban"></i>
                    TO BE DELETED
                </div>

                <div class="customer-header-info">
                    <div class="customer-avatar-delete">
                        <%= customer.getName().substring(0, 1).toUpperCase() %>
                    </div>
                    <div class="customer-main-info">
                        <h3><%= customer.getName() %></h3>
                        <p>Account: <%= customer.getAccountNumber() %></p>
                    </div>
                </div>

                <div class="customer-details-grid">
                    <div class="detail-box">
                        <div class="detail-label">
                            <i class="fas fa-user"></i>
                            Full Name
                        </div>
                        <div class="detail-value"><%= customer.getName() %></div>
                    </div>

                    <div class="detail-box">
                        <div class="detail-label">
                            <i class="fas fa-id-card"></i>
                            Account Number
                        </div>
                        <div class="detail-value"><%= customer.getAccountNumber() %></div>
                    </div>

                    <div class="detail-box">
                        <div class="detail-label">
                            <i class="fas fa-map-marker-alt"></i>
                            Address
                        </div>
                        <div class="detail-value"><%= customer.getAddress() %></div>
                    </div>

                    <div class="detail-box">
                        <div class="detail-label">
                            <i class="fas fa-phone"></i>
                            Telephone
                        </div>
                        <div class="detail-value"><%= customer.getTelephone() %></div>
                    </div>

                    <div class="detail-box units-highlight">
                        <div class="detail-label">
                            <i class="fas fa-tachometer-alt"></i>
                            Units Consumed
                        </div>
                        <h3 class="units-number"><%= customer.getUnitsConsumed() %></h3>
                        <p class="units-label">units</p>
                    </div>

                    <div class="detail-box">
                        <div class="detail-label">
                            <i class="fas fa-calendar-plus"></i>
                            Account Created
                        </div>
                        <div class="detail-value">
                            <% if (customer.getCreatedAt() != null) { %>
                            <%= dateFormat.format(customer.getCreatedAt()) %>
                            <% } else { %>
                            Unknown
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Impact Analysis -->
            <div class="impact-analysis">
                <div class="impact-analysis-content">
                    <h4>
                        <i class="fas fa-chart-line"></i>
                        Deletion Impact Analysis
                    </h4>
                    <ul class="impact-list">
                        <li><strong><i class="fas fa-user-circle"></i> Customer Record:</strong> Complete customer profile will be removed</li>
                        <li><strong><i class="fas fa-file-invoice"></i> Billing History:</strong> All past bills and transactions will be deleted</li>
                        <li><strong><i class="fas fa-dollar-sign"></i> Financial Impact:</strong>
                            <% if (customer.getUnitsConsumed() > 0) { %>
                            Outstanding consumption of <%= customer.getUnitsConsumed() %> units will be lost
                            <% } else { %>
                            No outstanding consumption to be lost
                            <% } %>
                        </li>
                        <li><strong><i class="fas fa-chart-bar"></i> Reports:</strong> Customer will be removed from all future reports and analytics</li>
                    </ul>
                </div>
            </div>

            <!-- Customer Activity Summary -->
            <div class="customer-activity-summary">
                <div class="activity-summary-content">
                    <h4>
                        <i class="fas fa-analytics"></i>
                        Customer Activity Summary
                    </h4>
                    <div class="activity-stats">
                        <div class="activity-stat">
                            <h3 class="activity-stat-number"><%= customer.getUnitsConsumed() %></h3>
                            <p class="activity-stat-label">Total Units</p>
                        </div>
                        <div class="activity-stat">
                            <h3 class="activity-stat-number">
                                <%= customer.getUnitsConsumed() > 0 ? "Active" : "Inactive" %>
                            </h3>
                            <p class="activity-stat-label">Status</p>
                        </div>
                        <div class="activity-stat">
                            <h3 class="activity-stat-number">
                                LKR <%= String.format("%.2f", customer.getUnitsConsumed() * 50.0 * 1.08) %>
                            </h3>
                            <p class="activity-stat-label">Est. Value</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirmation Section -->
        <div class="confirmation-section">
            <label class="confirmation-checkbox" for="confirmDelete">
                <span class="confirmation-text">
                    <input type="checkbox" id="confirmDelete">
                    <i class="fas fa-shield-alt"></i>
                    I understand that this action will permanently delete the customer and cannot be undone
                </span>
            </label>

            <div class="delete-actions">
                <form action="${pageContext.request.contextPath}/customer" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="confirmDelete">
                    <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">
                    <button type="submit" id="deleteBtn" class="btn-delete-confirm">
                        <i class="fas fa-skull"></i>
                        Delete Customer Permanently
                        <span id="countdown" class="countdown" style="display: none;"></span>
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/customer?action=view&accountNumber=<%= customer.getAccountNumber() %>"
                   class="btn-keep">
                    <i class="fas fa-shield-alt"></i>
                    Keep Customer
                </a>

                <a href="${pageContext.request.contextPath}/customer"
                   class="btn-back">
                    <i class="fas fa-arrow-left"></i>
                    Back to List
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    // Initialize animations and interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Add ripple effects to buttons
        const buttons = document.querySelectorAll('.btn-delete-confirm, .btn-keep, .btn-back');
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

        // Animate detail boxes on scroll
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

        const detailBoxes = document.querySelectorAll('.detail-box');
        detailBoxes.forEach((box, index) => {
            box.style.opacity = '0';
            box.style.transform = 'translateY(30px)';
            box.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
            observer.observe(box);
        });

        // Add hover effects to activity stats
        const activityStats = document.querySelectorAll('.activity-stat');
        activityStats.forEach((stat, index) => {
            stat.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.1) rotate(2deg)';
                this.style.boxShadow = '0 15px 40px rgba(255,255,255,0.3)';
            });

            stat.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1) rotate(0deg)';
                this.style.boxShadow = '';
            });
        });

        // Add floating animation to warning icon
        const warningIcon = document.querySelector('.warning-icon');
        if (warningIcon) {
            setInterval(() => {
                warningIcon.style.transform = 'translateY(-10px) scale(1.05)';
                setTimeout(() => {
                    warningIcon.style.transform = 'translateY(0) scale(1)';
                }, 1000);
            }, 3000);
        }

        console.log('✨ Delete customer page animations initialized');
    });

    const confirmCheckbox = document.getElementById('confirmDelete');
    const deleteBtn = document.getElementById('deleteBtn');
    const countdownElement = document.getElementById('countdown');
    let countdownTimer;
    let countdownSeconds = 5;

    // Enhanced checkbox change handler
    confirmCheckbox.addEventListener('change', function() {
        if (this.checked) {
            deleteBtn.classList.add('enabled');
            startCountdown();

            // Add glow effect to delete button
            deleteBtn.style.boxShadow = '0 0 30px rgba(250, 112, 154, 0.5)';
            deleteBtn.style.animation = 'pulse 1s infinite';
        } else {
            deleteBtn.classList.remove('enabled');
            stopCountdown();

            // Remove glow effect
            deleteBtn.style.boxShadow = '';
            deleteBtn.style.animation = '';
        }
    });

    // Enhanced countdown functionality
    function startCountdown() {
        countdownSeconds = 5;
        countdownElement.style.display = 'inline-block';
        countdownElement.style.animation = 'pulse 0.5s infinite';
        updateCountdown();

        countdownTimer = setInterval(function() {
            countdownSeconds--;
            updateCountdown();

            if (countdownSeconds <= 0) {
                stopCountdown();
                enableDeleteButton();
            }
        }, 1000);
    }

    function stopCountdown() {
        if (countdownTimer) {
            clearInterval(countdownTimer);
        }
        countdownElement.style.display = 'none';
        countdownElement.style.animation = '';
        deleteBtn.disabled = true;
    }

    function updateCountdown() {
        countdownElement.textContent = countdownSeconds;
        deleteBtn.disabled = true;

        // Add urgency colors as countdown decreases
        if (countdownSeconds <= 2) {
            countdownElement.style.background = 'var(--danger-gradient)';
            countdownElement.style.animation = 'pulse 0.3s infinite';
        } else if (countdownSeconds <= 3) {
            countdownElement.style.background = 'var(--warning-gradient)';
        }
    }

    function enableDeleteButton() {
        deleteBtn.disabled = false;
        deleteBtn.innerHTML = `
            <i class="fas fa-skull"></i>
            Delete Customer Permanently
        `;

        // Add ready state visual feedback
        deleteBtn.style.animation = 'glow 1s ease-in-out infinite alternate';
        showNotification('Delete button is now active', 'warning');
    }

    // Enhanced form submission with multiple confirmations
    deleteBtn.closest('form').addEventListener('submit', function(e) {
        if (!confirmCheckbox.checked) {
            e.preventDefault();
            showNotification('Please confirm that you understand this action cannot be undone.', 'error');
            confirmCheckbox.focus();
            confirmCheckbox.parentElement.style.animation = 'shake 0.5s ease-in-out';
            return false;
        }

        if (deleteBtn.disabled) {
            e.preventDefault();
            showNotification('Please wait for the countdown to complete', 'warning');
            return false;
        }

        // First confirmation dialog
        const customerName = '<%= customer.getName() %>';
        const accountNumber = '<%= customer.getAccountNumber() %>';

        const firstConfirmation = confirm(
            `⚠️ CRITICAL ACTION WARNING ⚠️\n\n` +
            `You are about to permanently delete:\n` +
            `Customer: ${customerName}\n` +
            `Account: ${accountNumber}\n\n` +
            `This action CANNOT be undone!\n\n` +
            `Click OK to continue with the deletion process.`
        );

        if (!firstConfirmation) {
            e.preventDefault();
            showNotification('Deletion cancelled by user', 'info');
            return false;
        }

        // Second confirmation with name verification
        const typedName = prompt(
            `🔐 FINAL SECURITY CHECK 🔐\n\n` +
            `To confirm deletion, please type the customer name exactly:\n\n` +
            `"${customerName}"\n\n` +
            `Type the name below:`
        );

        if (typedName !== customerName) {
            e.preventDefault();
            if (typedName === null) {
                showNotification('Deletion cancelled by user', 'info');
            } else {
                showNotification('Customer name does not match. Deletion cancelled for security.', 'error');
                // Add shake animation to form
                this.style.animation = 'shake 0.5s ease-in-out';
            }
            return false;
        }

        // Third and final confirmation
        const finalConfirmation = confirm(
            `💀 POINT OF NO RETURN 💀\n\n` +
            `This is your FINAL chance to cancel.\n\n` +
            `Customer "${customerName}" will be PERMANENTLY DELETED in 3 seconds.\n\n` +
            `Click OK to proceed with IRREVERSIBLE DELETION.`
        );

        if (!finalConfirmation) {
            e.preventDefault();
            showNotification('Deletion cancelled at final confirmation', 'info');
            return false;
        }

        // Show enhanced loading state
        deleteBtn.innerHTML = `
            <span class="spinner"></span>
            <i class="fas fa-trash-alt"></i>
            Deleting Customer...
        `;
        deleteBtn.disabled = true;
        deleteBtn.style.animation = 'pulse 0.5s infinite';

        // Disable all form fields and buttons
        const allButtons = document.querySelectorAll('button, a.btn-keep, a.btn-back');
        allButtons.forEach(btn => {
            btn.style.opacity = '0.5';
            btn.style.pointerEvents = 'none';
        });

        // Add deletion in progress notification
        showNotification('Customer deletion in progress...', 'warning');

        // Show countdown overlay
        showDeletionCountdown();

        return true;
    });

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

    // Deletion countdown overlay
    function showDeletionCountdown() {
        const overlay = document.createElement('div');
        overlay.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.8);
            backdrop-filter: blur(10px);
            z-index: 10000;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            color: white;
            font-size: 2rem;
            font-weight: bold;
        `;

        overlay.innerHTML = `
            <i class="fas fa-skull-crossbones" style="font-size: 4rem; margin-bottom: 2rem; color: #fa709a;"></i>
            <div>Deleting Customer...</div>
            <div style="font-size: 1rem; opacity: 0.8; margin-top: 1rem;">Please do not close this window</div>
        `;

        document.body.appendChild(overlay);
    }

    // Enhanced keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // ESC to cancel
        if (e.key === 'Escape') {
            if (!deleteBtn.disabled) {
                const shouldLeave = confirm('Are you sure you want to leave the deletion page?');
                if (shouldLeave) {
                    window.location.href = '${pageContext.request.contextPath}/customer?action=view&accountNumber=<%= customer.getAccountNumber() %>';
                }
            }
        }

        // Space to toggle checkbox
        if (e.key === ' ' && e.target !== confirmCheckbox && e.target.tagName !== 'BUTTON') {
            e.preventDefault();
            confirmCheckbox.checked = !confirmCheckbox.checked;
            confirmCheckbox.dispatchEvent(new Event('change'));

            // Visual feedback
            confirmCheckbox.parentElement.style.transform = 'scale(1.05)';
            setTimeout(() => {
                confirmCheckbox.parentElement.style.transform = 'scale(1)';
            }, 200);
        }

        // D key to focus delete button (when enabled)
        if (e.key === 'd' || e.key === 'D') {
            if (!deleteBtn.disabled && confirmCheckbox.checked) {
                deleteBtn.focus();
                deleteBtn.style.animation = 'pulse 1s ease-in-out';
            }
        }
    });

    // Enhanced navigation warning
    window.addEventListener('beforeunload', function(e) {
        if (confirmCheckbox.checked && !deleteBtn.disabled) {
            e.preventDefault();
            e.returnValue = '⚠️ You have initiated the customer deletion process. Are you sure you want to leave?';
            return e.returnValue;
        }
    });

    // Auto-focus and accessibility improvements
    document.addEventListener('DOMContentLoaded', function() {
        // Focus the confirmation checkbox for accessibility
        setTimeout(() => {
            confirmCheckbox.focus();
            confirmCheckbox.parentElement.style.animation = 'pulse 2s ease-in-out';
        }, 1000);

        // Add tooltips for better UX
        deleteBtn.title = 'This button will be enabled after confirming and waiting for the countdown';
        confirmCheckbox.title = 'Check this box to acknowledge the permanent nature of this action';
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

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
            20%, 40%, 60%, 80% { transform: translateX(10px); }
        }

        @keyframes glow {
            from {
                box-shadow: 0 0 20px rgba(250, 112, 154, 0.5);
            }
            to {
                box-shadow: 0 0 40px rgba(250, 112, 154, 0.8), 0 0 60px rgba(250, 112, 154, 0.3);
            }
        }

        .btn-delete-confirm, .btn-keep, .btn-back {
            position: relative;
            overflow: hidden;
        }

        .confirmation-checkbox {
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .activity-stat {
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        /* Enhanced focus states */
        .btn-delete-confirm:focus,
        .btn-keep:focus,
        .btn-back:focus {
            outline: 3px solid rgba(250, 112, 154, 0.5);
            outline-offset: 2px;
        }

        /* Improved accessibility */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }

        /* High contrast mode support */
        @media (prefers-contrast: high) {
            .delete-container {
                border: 2px solid #000;
            }

            .danger-alert {
                border: 3px solid #ff0000;
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

    // Error handling and logging
    window.addEventListener('error', function(e) {
        console.error('❌ Delete page error:', e.error);
        showNotification('An error occurred. Please refresh and try again.', 'error');
    });

    console.log('💀 Advanced customer deletion interface loaded successfully');
</script>
</body>
</html>
