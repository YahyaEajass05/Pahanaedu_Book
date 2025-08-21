<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Pahana Edu</title>
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

        /* Hero Header */
        .customers-hero {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            color: white;
            padding: 3rem;
            border-radius: 30px;
            margin-bottom: 3rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
            animation: slideInDown 0.8s ease-out;
        }

        .customers-hero::before {
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
            position: relative;
            z-index: 2;
        }

        .customers-hero h1 {
            margin: 0;
            font-size: 3rem;
            font-weight: 800;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            animation: fadeInLeft 0.8s ease-out;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .customers-hero p {
            margin: 0.5rem 0 0 0;
            opacity: 0.9;
            font-size: 1.3rem;
            animation: fadeInLeft 0.8s ease-out 0.2s both;
        }

        .header-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
            position: relative;
            z-index: 2;
            animation: fadeInRight 0.8s ease-out 0.4s both;
        }

        .btn-add-customer {
            background: var(--warning-gradient);
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            font-size: 1.1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
        }

        .btn-add-customer::before {
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

        .btn-add-customer:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-add-customer:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        /* Search Panel */
        .search-panel {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 2rem;
            border-radius: 25px;
            box-shadow: var(--card-shadow);
            margin-bottom: 3rem;
            animation: slideInLeft 0.8s ease-out;
            transition: all 0.3s ease;
        }

        .search-panel:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .search-form {
            display: flex;
            gap: 2rem;
            align-items: end;
        }

        .search-group {
            flex: 1;
        }

        .search-group label {
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

        .search-input {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e9ecef;
            border-radius: 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.2);
            transform: scale(1.02);
        }

        .search-buttons {
            display: flex;
            gap: 1rem;
        }

        .btn-search, .btn-clear {
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-search {
            background: var(--success-gradient);
            color: white;
            box-shadow: var(--card-shadow);
        }

        .btn-clear {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: #2c3e50;
            border: 1px solid var(--glass-border);
            text-decoration: none;
        }

        .btn-search:hover, .btn-clear:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        /* Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
            animation: slideInUp 0.8s ease-out;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            animation: fadeInUp 0.6s ease-out;
        }

        .stat-card:nth-child(1) { border-left: 4px solid #4facfe; animation-delay: 0.1s; }
        .stat-card:nth-child(2) { border-left: 4px solid #43e97b; animation-delay: 0.2s; }
        .stat-card:nth-child(3) { border-left: 4px solid #fa709a; animation-delay: 0.3s; }
        .stat-card:nth-child(4) { border-left: 4px solid #667eea; animation-delay: 0.4s; }

        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: var(--hover-shadow);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 80px;
            height: 80px;
            background: rgba(102, 126, 234, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #667eea;
            animation: pulse 2s infinite;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 900;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 0;
            animation: countUp 2s ease-out;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
            margin: 0.5rem 0 0 0;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Table Container */
        .table-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            animation: slideInRight 0.8s ease-out;
            transition: all 0.3s ease;
        }

        .table-container:hover {
            box-shadow: var(--hover-shadow);
        }

        .table-header {
            background: var(--secondary-gradient);
            color: white;
            padding: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .table-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 15s linear infinite;
        }

        .table-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
            position: relative;
            z-index: 2;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .table-filters {
            display: flex;
            gap: 1rem;
            align-items: center;
            position: relative;
            z-index: 2;
        }

        .filter-select {
            padding: 0.75rem 1rem;
            border: none;
            border-radius: 10px;
            font-size: 0.9rem;
            background: rgba(255,255,255,0.2);
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-select:hover {
            background: rgba(255,255,255,0.3);
            transform: scale(1.05);
        }

        .btn-export {
            background: var(--warning-gradient);
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-export:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        /* Modern Table */
        .customers-table {
            width: 100%;
            border-collapse: collapse;
        }

        .customers-table th {
            background: var(--dark-gradient);
            color: white;
            padding: 1.5rem;
            text-align: left;
            font-weight: 700;
            position: sticky;
            top: 0;
            z-index: 10;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
        }

        .customers-table td {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(102, 126, 234, 0.1);
            vertical-align: middle;
            transition: all 0.3s ease;
        }

        .customers-table tbody tr {
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
        }

        .customers-table tbody tr:nth-child(even) {
            animation-delay: 0.1s;
        }

        .customers-table tbody tr:hover {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            transform: scale(1.01);
        }

        .customer-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .customer-avatar {
            width: 50px;
            height: 50px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 900;
            font-size: 1.2rem;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .customer-avatar::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: transform 0.5s ease;
            transform: translateX(-100%);
        }

        .customer-avatar:hover::before {
            transform: translateX(100%);
        }

        .customer-avatar:hover {
            transform: scale(1.1) rotate(5deg);
        }

        .customer-details h4 {
            margin: 0;
            color: #2c3e50;
            font-size: 1.1rem;
            font-weight: 700;
        }

        .customer-details p {
            margin: 0.25rem 0 0 0;
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        .account-number {
            font-weight: 800;
            background: var(--success-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.1rem;
        }

        .phone-number {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #4facfe;
            font-weight: 600;
        }

        .units-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .units-low {
            background: linear-gradient(135deg, #fee 0%, #fdd 100%);
            color: #c53030;
            border: 1px solid rgba(197, 48, 48, 0.3);
        }
        .units-medium {
            background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
            color: #856404;
            border: 1px solid rgba(133, 100, 4, 0.3);
        }
        .units-high {
            background: linear-gradient(135deg, #d4edda 0%, #b7e4c7 100%);
            color: #155724;
            border: 1px solid rgba(21, 87, 36, 0.3);
        }

        .units-badge:hover {
            transform: scale(1.05);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-success {
            background: var(--warning-gradient);
            color: white;
        }

        .badge-warning {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: #856404;
            border: 1px solid rgba(133, 100, 4, 0.3);
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.75rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 0.6rem 1.2rem;
            border: none;
            border-radius: 25px;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            position: relative;
            overflow: hidden;
        }

        .btn-action::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255,255,255,0.3);
            border-radius: 50%;
            transition: all 0.5s ease;
            transform: translate(-50%, -50%);
        }

        .btn-action:hover::before {
            width: 200px;
            height: 200px;
        }

        .btn-action:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }

        .btn-view { background: var(--success-gradient); color: white; }
        .btn-edit { background: var(--warning-gradient); color: white; }
        .btn-delete { background: var(--danger-gradient); color: white; }
        .btn-bill { background: var(--primary-gradient); color: white; }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem;
            color: #7f8c8d;
            animation: fadeInUp 0.8s ease-out;
        }

        .empty-state-icon {
            font-size: 5rem;
            margin-bottom: 2rem;
            color: rgba(102, 126, 234, 0.3);
            animation: bounce 2s infinite;
        }

        .empty-state h3 {
            margin: 0 0 1rem 0;
            color: #2c3e50;
            font-size: 2rem;
            font-weight: 700;
        }

        .empty-state p {
            margin: 0 0 3rem 0;
            font-size: 1.2rem;
            color: #7f8c8d;
        }

        .btn-first-customer {
            background: var(--primary-gradient);
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            font-size: 1.1rem;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            box-shadow: var(--card-shadow);
        }

        .btn-first-customer:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 2rem;
            padding: 2rem;
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            color: #666;
        }

        .page-info {
            font-size: 1rem;
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 0.5rem;
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

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
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
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .customers-hero {
                flex-direction: column;
                text-align: center;
                gap: 2rem;
            }

            .customers-hero h1 {
                font-size: 2.5rem;
            }

            .search-form {
                flex-direction: column;
                gap: 1rem;
            }

            .search-buttons {
                justify-content: center;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .customers-table {
                font-size: 0.875rem;
            }

            .customers-table th,
            .customers-table td {
                padding: 1rem 0.75rem;
            }

            .action-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }

            .customer-info {
                flex-direction: column;
                text-align: center;
            }

            .table-filters {
                flex-direction: column;
                gap: 0.5rem;
            }
        }

        @media (max-width: 480px) {
            .customers-table th,
            .customers-table td {
                padding: 0.75rem 0.5rem;
                font-size: 0.8rem;
            }

            .customer-avatar {
                width: 40px;
                height: 40px;
                font-size: 1rem;
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
    <!-- Hero Header -->
    <div class="customers-hero">
        <div class="hero-content">
            <h1>
                <i class="fas fa-users"></i>
                Customer Management
            </h1>
            <p>Manage customer accounts and information with modern tools</p>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/customer?action=add" class="btn-add-customer">
                <i class="fas fa-user-plus"></i>
                Add New Customer
            </a>
        </div>
    </div>

    <!-- Display Messages -->
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

    <!-- Search Panel -->
    <div class="search-panel">
        <form class="search-form" method="get" action="${pageContext.request.contextPath}/customer">
            <input type="hidden" name="action" value="list">
            <div class="search-group">
                <label for="searchName">
                    <i class="fas fa-user-search"></i>
                    Search by Name
                </label>
                <input type="text" id="searchName" name="searchName" class="search-input"
                       placeholder="Enter customer name..."
                       value="<%= request.getParameter("searchName") != null ? request.getParameter("searchName") : "" %>">
            </div>
            <div class="search-group">
                <label for="searchAccount">
                    <i class="fas fa-id-card"></i>
                    Search by Account
                </label>
                <input type="text" id="searchAccount" name="searchAccount" class="search-input"
                       placeholder="Enter account number..."
                       value="<%= request.getParameter("searchAccount") != null ? request.getParameter("searchAccount") : "" %>">
            </div>
            <div class="search-buttons">
                <button type="submit" class="btn-search">
                    <i class="fas fa-search"></i>
                    Search
                </button>
                <a href="${pageContext.request.contextPath}/customer?action=list" class="btn-clear">
                    <i class="fas fa-times"></i>
                    Clear
                </a>
            </div>
        </form>
    </div>

    <!-- Customer Statistics -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-users"></i>
            </div>
            <h2 class="stat-number"><%= customers.size() %></h2>
            <p class="stat-label">Total Customers</p>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-user-check"></i>
            </div>
            <h2 class="stat-number">
                <%
                    int activeCustomers = 0;
                    for (Customer customer : customers) {
                        if (customer.getUnitsConsumed() > 0) {
                            activeCustomers++;
                        }
                    }
                %>
                <%= activeCustomers %>
            </h2>
            <p class="stat-label">Active Customers</p>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-chart-line"></i>
            </div>
            <h2 class="stat-number">
                <%
                    int totalUnits = 0;
                    for (Customer customer : customers) {
                        totalUnits += customer.getUnitsConsumed();
                    }
                %>
                <%= totalUnits %>
            </h2>
            <p class="stat-label">Total Units</p>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-calculator"></i>
            </div>
            <h2 class="stat-number">
                <%= customers.size() > 0 ? String.format("%.1f", (double)totalUnits / customers.size()) : "0.0" %>
            </h2>
            <p class="stat-label">Avg Units/Customer</p>
        </div>
    </div>

    <!-- Customers Table -->
    <div class="table-container">
        <div class="table-header">
            <h3 class="table-title">
                <i class="fas fa-table"></i>
                Customer List
            </h3>
            <div class="table-filters">
                <select class="filter-select" onchange="filterTable(this.value)">
                    <option value="all">All Customers</option>
                    <option value="active">Active (Units > 0)</option>
                    <option value="inactive">Inactive (Units = 0)</option>
                    <option value="high">High Usage (Units > 50)</option>
                </select>
                <button onclick="exportToCSV()" class="btn-export">
                    <i class="fas fa-file-csv"></i>
                    Export CSV
                </button>
            </div>
        </div>

            <% if (customers.size() > 0) { %>
        <table class="customers-table" id="customersTable">
            <thead>
            <tr>
                <th><i class="fas fa-user"></i> Customer</th>
                <th><i class="fas fa-id-badge"></i> Account Number</th>
                <th><i class="fas fa-phone"></i> Contact</th>
                <th><i class="fas fa-chart-bar"></i> Units Consumed</th>
                <th><i class="fas fa-info-circle"></i> Status</th>
                <th><i class="fas fa-cogs"></i> Actions</th>
            </tr>
            </thead>
            <tbody>
                <% for (Customer customer : customers) { %>
            <tr data-units="<%= customer.getUnitsConsumed() %>">
                <td>
                    <div class="customer-info">
                        <div class="customer-avatar">
                            <%= customer.getName().substring(0, 1).toUpperCase() %>
                        </div>
                        <div class="customer-details">
                            <h4><%= customer.getName() %></h4>
                            <p>
                                <i class="fas fa-map-marker-alt"></i>
                                <%= customer.getAddress().length() > 30 ?
                                        customer.getAddress().substring(0, 30) + "..." :
                                        customer.getAddress() %>
                            </p>
                        </div>
                    </div>
                </td>
                <td>
                    <span class="account-number"><%= customer.getAccountNumber() %></span>
                </td>
                <td>
                    <div class="phone-number">
                        <i class="fas fa-phone"></i>
                        <%= customer.getTelephone() %>
                    </div>
                </td>
                <td>
                    <span class="units-badge <%=
                        customer.getUnitsConsumed() == 0 ? "units-low" :
                        customer.getUnitsConsumed() <= 25 ? "units-medium" : "units-high" %>">
                        <i class="fas fa-chart-pie"></i>
                        <%= customer.getUnitsConsumed() %> units
                    </span>
                </td>
                <td>
                    <% if (customer.getUnitsConsumed() > 0) { %>
                    <span class="status-badge badge-success">
                        <i class="fas fa-check-circle"></i>
                        Active
                    </span>
                    <% } else { %>
                    <span class="status-badge badge-warning">
                        <i class="fas fa-pause-circle"></i>
                        Inactive
                    </span>
                    <% } %>
                </td>
                <td>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/customer?action=view&accountNumber=<%= customer.getAccountNumber() %>"
                           class="btn-action btn-view" title="View Details">
                            <i class="fas fa-eye"></i>
                            View
                        </a>
                        <a href="${pageContext.request.contextPath}/customer?action=edit&accountNumber=<%= customer.getAccountNumber() %>"
                           class="btn-action btn-edit" title="Edit Customer">
                            <i class="fas fa-edit"></i>
                            Edit
                        </a>
                        <a href="${pageContext.request.contextPath}/bill?action=generate&accountNumber=<%= customer.getAccountNumber() %>"
                           class="btn-action btn-bill" title="Generate Bill">
                            <i class="fas fa-file-invoice-dollar"></i>
                            Bill
                        </a>
                        <a href="${pageContext.request.contextPath}/customer?action=delete&accountNumber=<%= customer.getAccountNumber() %>"
                           class="btn-action btn-delete" title="Delete Customer"
                           onclick="return confirm('Are you sure you want to delete this customer?')">
                            <i class="fas fa-trash-alt"></i>
                            Delete
                        </a>
                    </div>
                </td>
            </tr>
                <% } %>
            </tbody>
        </table>

        <div class="pagination">
            <div class="page-info">
                <i class="fas fa-info-circle"></i>
                Showing <%= customers.size() %> customer(s)
            </div>
        </div>
        <% } else { %>
        <div class="empty-state">
            <div class="empty-state-icon">
                <i class="fas fa-users-slash"></i>
            </div>
            <h3>No Customers Found</h3>
            <p>You haven't added any customers yet. Start by adding your first customer to get started with the system!</p>
            <a href="${pageContext.request.contextPath}/customer?action=add" class="btn-first-customer">
                <i class="fas fa-user-plus"></i>
                Add Your First Customer
            </a>
        </div>
        <% } %>
    </div>
</div>

<script>
    // Initialize animations and interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Animate statistics cards
        const statNumbers = document.querySelectorAll('.stat-number');
        statNumbers.forEach((statNumber, index) => {
            const finalValue = parseInt(statNumber.textContent) || parseFloat(statNumber.textContent);
            if (finalValue > 0 && !isNaN(finalValue)) {
                let currentValue = 0;
                const isFloat = statNumber.textContent.includes('.');
                const increment = isFloat ? finalValue / 50 : Math.ceil(finalValue / 20);

                const timer = setInterval(function() {
                    currentValue += increment;
                    if (currentValue >= finalValue) {
                        currentValue = finalValue;
                        clearInterval(timer);
                    }
                    statNumber.textContent = isFloat ? currentValue.toFixed(1) : Math.floor(currentValue);
                }, 50);
            }
        });

        // Add hover effects to table rows
        const tableRows = document.querySelectorAll('.customers-table tbody tr');
        tableRows.forEach((row, index) => {
            row.style.animationDelay = `${index * 0.05}s`;

            // Add ripple effect on row click
            row.addEventListener('click', function(e) {
                if (e.target.closest('.btn-action')) return;

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
                    background: radial-gradient(circle, rgba(102, 126, 234, 0.1) 0%, transparent 70%);
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

        // Add floating animation to customer avatars
        const avatars = document.querySelectorAll('.customer-avatar');
        avatars.forEach((avatar, index) => {
            avatar.style.animationDelay = `${index * 0.1}s`;

            avatar.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.2) rotate(10deg)';
                this.style.boxShadow = '0 10px 30px rgba(102, 126, 234, 0.5)';
            });

            avatar.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1) rotate(0deg)';
                this.style.boxShadow = '';
            });
        });

        // Add dynamic gradient animation to action buttons
        const actionButtons = document.querySelectorAll('.btn-action');
        actionButtons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                this.style.backgroundSize = '200% 200%';
                this.style.backgroundPosition = 'right center';
            });

            button.addEventListener('mouseleave', function() {
                this.style.backgroundPosition = 'left center';
            });
        });

        // Add parallax effect to hero section
        const hero = document.querySelector('.customers-hero');
        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const parallax = scrolled * 0.5;
            if (hero) {
                hero.style.transform = `translateY(${parallax}px)`;
            }
        });

        // Add search input animations
        const searchInputs = document.querySelectorAll('.search-input');
        searchInputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
                this.parentElement.style.zIndex = '10';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
                this.parentElement.style.zIndex = '1';
            });
        });

        console.log('✨ Customer management page animations initialized');
    });

    // Filter table functionality with animations
    function filterTable(filter) {
        const table = document.getElementById('customersTable');
        if (!table) return;

        const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
        let visibleCount = 0;

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const units = parseInt(row.getAttribute('data-units'));
            let show = true;

            switch(filter) {
                case 'active':
                    show = units > 0;
                    break;
                case 'inactive':
                    show = units === 0;
                    break;
                case 'high':
                    show = units > 50;
                    break;
                case 'all':
                default:
                    show = true;
                    break;
            }

            if (show) {
                row.style.display = '';
                row.style.animation = `fadeInUp 0.3s ease-out ${visibleCount * 0.05}s both`;
                visibleCount++;
            } else {
                row.style.animation = 'fadeOutDown 0.3s ease-out';
                setTimeout(() => {
                    row.style.display = 'none';
                }, 300);
            }
        }

        // Update pagination info
        const pageInfo = document.querySelector('.page-info');
        if (pageInfo) {
            setTimeout(() => {
                pageInfo.innerHTML = `
                    <i class="fas fa-filter"></i>
                    Showing ${visibleCount} customer(s) (${filter} filter)
                `;
            }, 350);
        }
    }

    // Export to CSV functionality with loading animation
    function exportToCSV() {
        const exportBtn = document.querySelector('.btn-export');
        const originalHTML = exportBtn.innerHTML;

        // Show loading state
        exportBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Exporting...';
        exportBtn.disabled = true;

        const table = document.getElementById('customersTable');
        if (!table) {
            exportBtn.innerHTML = originalHTML;
            exportBtn.disabled = false;
            return;
        }

        const rows = table.getElementsByTagName('tr');
        let csv = [];

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const cols = row.getElementsByTagName(i === 0 ? 'th' : 'td');
            let csvRow = [];

            for (let j = 0; j < cols.length - 1; j++) { // Exclude actions column
                let cellText = cols[j].innerText.replace(/,/g, '').replace(/\n/g, ' ').trim();
                csvRow.push('"' + cellText + '"');
            }
            csv.push(csvRow.join(','));
        }

        // Simulate processing time for better UX
        setTimeout(() => {
            // Download CSV
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'customers_' + new Date().toISOString().split('T')[0] + '.csv';
            a.click();
            window.URL.revokeObjectURL(url);

            // Reset button
            exportBtn.innerHTML = '<i class="fas fa-check"></i> Exported!';
            setTimeout(() => {
                exportBtn.innerHTML = originalHTML;
                exportBtn.disabled = false;
            }, 2000);
        }, 1000);
    }

    // Enhanced search functionality with debouncing
    let searchTimeout;
    document.getElementById('searchName').addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();

        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            filterByName(searchTerm);
        }, 300);
    });

    function filterByName(searchTerm) {
        const table = document.getElementById('customersTable');
        if (!table) return;

        const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
        let visibleCount = 0;

        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const nameCell = row.getElementsByTagName('td')[0];
            const name = nameCell.innerText.toLowerCase();

            if (name.includes(searchTerm) || searchTerm === '') {
                row.style.display = '';
                row.style.animation = `fadeInUp 0.3s ease-out ${visibleCount * 0.05}s both`;
                visibleCount++;
            } else {
                row.style.animation = 'fadeOutDown 0.3s ease-out';
                setTimeout(() => {
                    row.style.display = 'none';
                }, 300);
            }
        }
    }

    // Auto-refresh functionality with user notification
    let refreshInterval;
    let lastInteraction = Date.now();

    function startAutoRefresh() {
        refreshInterval = setInterval(function() {
            const timeSinceLastInteraction = Date.now() - lastInteraction;

            // Only refresh if user hasn't interacted for 2 minutes
            if (timeSinceLastInteraction > 120000) {
                showRefreshNotification();
            }
        }, 60000);
    }

    function showRefreshNotification() {
        const notification = document.createElement('div');
        notification.style.cssText = `
            position: fixed;
            top: 2rem;
            right: 2rem;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            z-index: 10000;
            animation: slideInRight 0.3s ease-out;
            cursor: pointer;
        `;
        notification.innerHTML = `
            <i class="fas fa-sync-alt"></i>
            Click to refresh customer data
        `;

        notification.addEventListener('click', () => {
            window.location.reload();
        });

        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease-out';
            setTimeout(() => {
                if (document.body.contains(notification)) {
                    document.body.removeChild(notification);
                }
            }, 300);
        }, 5000);
    }

    function updateLastInteraction() {
        lastInteraction = Date.now();
    }

    // Track user interactions
    document.addEventListener('click', updateLastInteraction);
    document.addEventListener('keypress', updateLastInteraction);
    document.addEventListener('scroll', updateLastInteraction);

    // Start auto-refresh when page loads
    document.addEventListener('DOMContentLoaded', function() {
        startAutoRefresh();
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

        @keyframes fadeOutDown {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(30px);
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

        .customers-table tbody tr {
            cursor: pointer;
        }

        .search-group {
            transition: all 0.3s ease;
        }

        .btn-action {
            background-size: 200% 200%;
            background-position: left center;
            transition: all 0.3s ease;
        }

        .btn-export:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
    `;
    document.head.appendChild(additionalStyles);

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey || e.metaKey) {
            switch(e.key) {
                case 'f':
                    e.preventDefault();
                    document.getElementById('searchName').focus();
                    break;
                case 'n':
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/customer?action=add';
                    break;
                case 'e':
                    e.preventDefault();
                    exportToCSV();
                    break;
            }
        }
    });

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
        if (e.key === 'Tab') {
            const focusableElements = document.querySelectorAll(
                'a[href], button, input, select, [tabindex]:not([tabindex="-1"])'
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

    // Error handling
    window.addEventListener('error', function(e) {
        console.warn('⚠️ Customer management page error:', e.error);
    });

    console.log('🎨 Advanced customer management interface loaded successfully');
</script>
</body>
</html>
