<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Report - Pahana Edu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            --info-gradient: linear-gradient(135deg, #3B82F6 0%, #60A5FA 100%);

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
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Page Header */
        .page-header {
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

        .page-header::before {
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

        .header-content {
            position: relative;
            z-index: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-title {
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

        .page-subtitle {
            font-size: 1.25rem;
            opacity: 0.9;
            animation: slideInLeft 0.8s ease-out 0.2s both;
        }

        .header-actions {
            display: flex;
            gap: 1rem;
            animation: slideInRightHeader 0.8s ease-out;
        }

        @keyframes slideInRightHeader {
            from {
                transform: translateX(50px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .btn {
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .btn-white {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            backdrop-filter: blur(10px);
        }

        .btn-white:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        /* Summary Cards */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .summary-card {
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

        .summary-card:nth-child(1) { animation-delay: 0.1s; }
        .summary-card:nth-child(2) { animation-delay: 0.2s; }
        .summary-card:nth-child(3) { animation-delay: 0.3s; }
        .summary-card:nth-child(4) { animation-delay: 0.4s; }
        .summary-card:nth-child(5) { animation-delay: 0.5s; }
        .summary-card:nth-child(6) { animation-delay: 0.6s; }

        .summary-card::after {
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

        .summary-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .summary-card:hover::after {
            opacity: 1;
        }

        .summary-icon {
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 1rem;
            font-size: 1.75rem;
            color: white;
            margin-bottom: 1.5rem;
            animation: iconFloat 3s ease-in-out infinite;
        }

        @keyframes iconFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        .summary-card:nth-child(1) .summary-icon { background: var(--primary-gradient); }
        .summary-card:nth-child(2) .summary-icon { background: var(--success-gradient); }
        .summary-card:nth-child(3) .summary-icon { background: var(--warning-gradient); }
        .summary-card:nth-child(4) .summary-icon { background: var(--danger-gradient); }
        .summary-card:nth-child(5) .summary-icon { background: var(--info-gradient); }
        .summary-card:nth-child(6) .summary-icon { background: var(--secondary-gradient); }

        .summary-value {
            font-size: 2.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
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

        .summary-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .summary-trend {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.875rem;
        }

        .trend-up {
            color: var(--success-color);
        }

        .trend-down {
            color: var(--danger-color);
        }

        /* Charts Section */
        .charts-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 3rem;
        }

        @media (max-width: 1200px) {
            .charts-grid {
                grid-template-columns: 1fr;
            }
        }

        .chart-card {
            background: var(--bg-secondary);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: var(--shadow-md);
            animation: zoomIn 0.8s ease-out;
        }

        @keyframes zoomIn {
            from {
                transform: scale(0.9);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .chart-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .chart-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .chart-title i {
            color: var(--primary-color);
        }

        .chart-container {
            position: relative;
            height: 400px;
        }

        /* Category Table */
        .category-table-card {
            background: var(--bg-secondary);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: var(--shadow-md);
            animation: slideInUp 0.8s ease-out;
            margin-bottom: 2rem;
        }

        .table-responsive {
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table thead {
            background: var(--bg-primary);
        }

        .data-table th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .data-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .data-table tbody tr {
            transition: all 0.3s ease;
            animation: tableRowSlide 0.5s ease-out;
        }

        @keyframes tableRowSlide {
            from {
                transform: translateX(-20px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .data-table tbody tr:hover {
            background: var(--bg-primary);
            transform: translateX(5px);
        }

        .category-name {
            font-weight: 600;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .category-icon {
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0.5rem;
            font-size: 1rem;
        }

        .value-bar {
            background: var(--bg-primary);
            height: 8px;
            border-radius: 4px;
            overflow: hidden;
            margin-top: 0.5rem;
        }

        .value-fill {
            height: 100%;
            background: var(--primary-gradient);
            animation: progressFill 1s ease-out;
            transition: width 0.3s ease;
        }

        @keyframes progressFill {
            from {
                width: 0;
            }
        }

        /* Alert Cards */
        .alerts-section {
            margin-top: 3rem;
        }

        .alert-card {
            background: var(--bg-secondary);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--warning-color);
            animation: slideInLeftAlert 0.6s ease-out;
        }

        @keyframes slideInLeftAlert {
            from {
                transform: translateX(-50px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .alert-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .alert-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
            border-radius: 0.75rem;
            font-size: 1.25rem;
        }

        .alert-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .alert-content {
            color: var(--text-secondary);
            line-height: 1.6;
        }

        /* Export Button */
        .export-menu {
            position: relative;
        }

        .export-dropdown {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--bg-secondary);
            border-radius: 0.75rem;
            box-shadow: var(--shadow-lg);
            padding: 0.5rem;
            margin-top: 0.5rem;
            min-width: 200px;
            display: none;
            animation: dropdownSlide 0.3s ease-out;
        }

        @keyframes dropdownSlide {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .export-dropdown.show {
            display: block;
        }

        .export-option {
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .export-option:hover {
            background: var(--bg-primary);
            color: var(--primary-color);
        }

        /* Loading State */
        .loading {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 400px;
        }

        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 4px solid var(--bg-primary);
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        /* Notification Styles */
        .notification {
            position: fixed;
            top: 2rem;
            right: 2rem;
            max-width: 400px;
            padding: 1.25rem 2rem;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            z-index: 9999;
            box-shadow: var(--shadow-xl);
            animation: slideInNotif 0.5s ease-out;
            color: white;
        }

        @keyframes slideInNotif {
            from {
                transform: translateX(400px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideOutNotif {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(400px);
                opacity: 0;
            }
        }

        .notification.success { background: var(--success-color); }
        .notification.error { background: var(--danger-color); }
        .notification.info { background: var(--info-color); }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar-content {
                flex-direction: column;
                gap: 1rem;
            }

            .header-content {
                flex-direction: column;
                gap: 1rem;
            }

            .summary-grid {
                grid-template-columns: 1fr;
            }

            .chart-container {
                height: 300px;
            }
        }

        /* Print Styles */
        @media print {
            .navbar, .header-actions, .export-menu, .alerts-section {
                display: none !important;
            }

            .page-header {
                background: none !important;
                color: #000 !important;
                padding: 1rem !important;
            }

            .summary-card {
                break-inside: avoid;
                page-break-inside: avoid;
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }

            .chart-card {
                break-inside: avoid;
                page-break-inside: avoid;
            }

            body {
                print-color-adjust: exact;
                -webkit-print-color-adjust: exact;
            }
        }
    </style>
</head>
<body>
<div class="bg-animation"></div>

    <%
    // Check if user is logged in
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    // Get data from request with null checks
    Map<String, Object> summary = (Map<String, Object>) request.getAttribute("summary");
    List<Map<String, Object>> categoryValues = (List<Map<String, Object>>) request.getAttribute("categoryValues");

    // Format numbers
    DecimalFormat df = new DecimalFormat("#,##0");
    DecimalFormat cf = new DecimalFormat("#,##0.00");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, HH:mm");

    // Extract summary values with defaults
    int totalItems = 0;
    int totalStock = 0;
    BigDecimal totalInventoryValue = BigDecimal.ZERO;
    int lowStockItems = 0;
    int outOfStockItems = 0;
    int discountedItems = 0;

    if (summary != null) {
        totalItems = summary.get("totalItems") != null ? ((Number) summary.get("totalItems")).intValue() : 0;
        totalStock = summary.get("totalStock") != null ? ((Number) summary.get("totalStock")).intValue() : 0;
        totalInventoryValue = summary.get("totalInventoryValue") != null ? (BigDecimal) summary.get("totalInventoryValue") : BigDecimal.ZERO;
        lowStockItems = summary.get("lowStock") != null ? ((Number) summary.get("lowStock")).intValue() : 0;
        outOfStockItems = summary.get("outOfStock") != null ? ((Number) summary.get("outOfStock")).intValue() : 0;
        discountedItems = summary.get("discountedItems") != null ? ((Number) summary.get("discountedItems")).intValue() : 0;
    }
%>

    <%!
    private String getCategoryColor(int index) {
        String[] colors = {"#6366F1", "#10B981", "#F59E0B", "#EC4899", "#3B82F6", "#8B5CF6", "#14B8A6"};
        return colors[index % colors.length];
    }

    private String getCategoryIcon(String category) {
        if (category == null) return "book";

        switch (category.toLowerCase()) {
            case "fiction": return "book-reader";
            case "non-fiction": return "graduation-cap";
            case "children": return "child";
            case "academic": return "university";
            case "comics": return "mask";
            case "biography": return "user-tie";
            case "science": return "atom";
            case "technology": return "laptop-code";
            case "history": return "landmark";
            case "art": return "palette";
            case "cooking": return "utensils";
            case "travel": return "globe-americas";
            case "poetry": return "feather-alt";
            case "religion": return "pray";
            case "self-help": return "hands-helping";
            case "business": return "briefcase";
            case "health": return "heartbeat";
            case "sports": return "running";
            case "music": return "music";
            case "photography": return "camera";
            default: return "book";
        }
    }
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            <i class="fas fa-book-open"></i>
            Pahana Edu
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                <i class="fas fa-chart-line"></i> Dashboard
            </a></li>
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link">
                <i class="fas fa-users"></i> Customers
            </a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link active">
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
    <!-- Page Header -->
    <div class="page-header">
        <div class="header-content">
            <div>
                <h1 class="page-title">
                    <i class="fas fa-warehouse"></i> Inventory Report
                </h1>
                <p class="page-subtitle">
                    Generated on <%= dateFormat.format(new Date()) %>
                </p>
            </div>
            <div class="header-actions">
                <div class="export-menu">
                    <button class="btn btn-white" onclick="toggleExportMenu()">
                        <i class="fas fa-download"></i> Export
                    </button>
                    <div class="export-dropdown" id="exportDropdown">
                        <a href="#" class="export-option" onclick="exportToPDF()">
                            <i class="fas fa-file-pdf"></i> Export as PDF
                        </a>
                        <a href="#" class="export-option" onclick="exportToExcel()">
                            <i class="fas fa-file-excel"></i> Export as Excel
                        </a>
                        <a href="#" class="export-option" onclick="printReport()">
                            <i class="fas fa-print"></i> Print Report
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Summary Cards -->
    <div class="summary-grid">
        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-books"></i>
            </div>
            <div class="summary-value counter" data-target="<%= totalItems %>">0</div>
            <div class="summary-label">Total Books</div>
            <div class="summary-trend">
                <i class="fas fa-info-circle"></i>
                <span>Unique titles in inventory</span>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-boxes"></i>
            </div>
            <div class="summary-value counter" data-target="<%= totalStock %>">0</div>
            <div class="summary-label">Total Stock</div>
            <div class="summary-trend">
                <i class="fas fa-warehouse"></i>
                <span>Books in warehouse</span>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-rupee-sign"></i>
            </div>
            <div class="summary-value">Rs. <span class="counter" data-target="<%= totalInventoryValue.intValue() %>">0</span></div>
            <div class="summary-label">Inventory Value</div>
            <div class="summary-trend trend-up">
                <i class="fas fa-arrow-up"></i>
                <span>Total worth of stock</span>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <div class="summary-value counter" data-target="<%= lowStockItems %>">0</div>
            <div class="summary-label">Low Stock Items</div>
            <div class="summary-trend <%= lowStockItems > 0 ? "trend-down" : "trend-up" %>">
                <i class="fas fa-<%= lowStockItems > 0 ? "arrow-down" : "check-circle" %>"></i>
                <span><%= lowStockItems > 0 ? "Need restocking" : "Stock levels good" %></span>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-times-circle"></i>
            </div>
            <div class="summary-value counter" data-target="<%= outOfStockItems %>">0</div>
            <div class="summary-label">Out of Stock</div>
            <div class="summary-trend <%= outOfStockItems > 0 ? "trend-down" : "trend-up" %>">
                <i class="fas fa-<%= outOfStockItems > 0 ? "exclamation" : "check" %>"></i>
                <span><%= outOfStockItems > 0 ? "Urgent restocking needed" : "All items in stock" %></span>
            </div>
        </div>

        <div class="summary-card">
            <div class="summary-icon">
                <i class="fas fa-percentage"></i>
            </div>
            <div class="summary-value counter" data-target="<%= discountedItems %>">0</div>
            <div class="summary-label">On Discount</div>
            <div class="summary-trend">
                <i class="fas fa-tag"></i>
                <span>Active promotions</span>
            </div>
        </div>
    </div>

    <!-- Charts Section -->
    <div class="charts-grid">
        <!-- Category Distribution Chart -->
        <div class="chart-card">
            <div class="chart-header">
                <h3 class="chart-title">
                    <i class="fas fa-chart-bar"></i> Inventory Value by Category
                </h3>
            </div>
            <div class="chart-container">
                <canvas id="categoryValueChart"></canvas>
            </div>
        </div>

        <!-- Stock Status Chart -->
        <div class="chart-card">
            <div class="chart-header">
                <h3 class="chart-title">
                    <i class="fas fa-chart-pie"></i> Stock Status Overview
                </h3>
            </div>
            <div class="chart-container" style="height: 300px;">
                <canvas id="stockStatusChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Category Details Table -->
    <div class="category-table-card">
        <div class="chart-header">
            <h3 class="chart-title">
                <i class="fas fa-th-list"></i> Category-wise Inventory Details
            </h3>
        </div>

        <div class="table-responsive">
            <table class="data-table">
                <thead>
                <tr>
                    <th>Category</th>
                    <th>Total Items</th>
                    <th>Total Stock</th>
                    <th>Value (Rs.)</th>
                    <th>Avg. Price</th>
                    <th>Stock Distribution</th>
                </tr>
                </thead>
                <tbody>
<%
        if (categoryValues != null && !categoryValues.isEmpty()) {
            // Find max value safely
            BigDecimal maxValue = BigDecimal.ONE;
            for (Map<String, Object> cat : categoryValues) {
                BigDecimal value = (BigDecimal) cat.get("inventoryValue");
                if (value != null && value.compareTo(maxValue) > 0) {
                    maxValue = value;
                }
            }

            int index = 0;
            for (Map<String, Object> category : categoryValues) {
                String categoryName = (String) category.get("category");
                int itemCount = category.get("itemCount") != null ?
                        ((Number) category.get("itemCount")).intValue() : 0;
                int stockCount = category.get("totalStock") != null ?
                        ((Number) category.get("totalStock")).intValue() : 0;
                BigDecimal value = (BigDecimal) category.get("inventoryValue");

                if (value == null) value = BigDecimal.ZERO;

                BigDecimal avgPrice = stockCount > 0 ?
                        value.divide(new BigDecimal(stockCount), 2, BigDecimal.ROUND_HALF_UP) : BigDecimal.ZERO;

                double percentage = 0;
                if (value.compareTo(BigDecimal.ZERO) > 0 && maxValue.compareTo(BigDecimal.ZERO) > 0) {
                    percentage = value.divide(maxValue, 2, BigDecimal.ROUND_HALF_UP)
                            .multiply(new BigDecimal(100)).doubleValue();
                }
%>
<tr style="animation-delay: <%= index * 0.1 %>s;">
    <td>
        <div class="category-name">
            <div class="category-icon" style="background: <%= getCategoryColor(index) %>20; color: <%= getCategoryColor(index) %>;">
                <i class="fas fa-<%= getCategoryIcon(categoryName) %>"></i>
            </div>
            <%= categoryName != null ? categoryName : "Unknown" %>
        </div>
    </td>
    <td><%= df.format(itemCount) %></td>
    <td><%= df.format(stockCount) %></td>
    <td><strong>Rs. <%= cf.format(value) %></strong></td>
    <td>Rs. <%= cf.format(avgPrice) %></td>
    <td>
        <div class="value-bar">
            <div class="value-fill" style="width: <%= percentage %>%; background: <%= getCategoryColor(index) %>;"></div>
        </div>
    </td>
</tr>
<%
        index++;
    }
} else {
%>
<tr>
    <td colspan="6" style="text-align: center; padding: 2rem; color: var(--text-secondary);">
        No category data available
    </td>
</tr>
<%
    }
%>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Alerts Section -->
    <% if (lowStockItems > 0 || outOfStockItems > 0) { %>
    <div class="alerts-section">
        <% if (outOfStockItems > 0) { %>
        <div class="alert-card" style="border-left-color: var(--danger-color);">
            <div class="alert-header">
                <div class="alert-icon" style="background: rgba(239, 68, 68, 0.1); color: var(--danger-color);">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <h4 class="alert-title">Critical Stock Alert</h4>
            </div>
            <div class="alert-content">
                You have <%= outOfStockItems %> book<%= outOfStockItems > 1 ? "s" : "" %> that are completely out of stock.
                This may result in lost sales opportunities.
                <a href="${pageContext.request.contextPath}/item?action=outOfStock" style="color: var(--primary-color); font-weight: 600;">View out of stock items →</a>
            </div>
        </div>
        <% } %>

        <% if (lowStockItems > 0) { %>
        <div class="alert-card">
            <div class="alert-header">
                <div class="alert-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h4 class="alert-title">Low Stock Warning</h4>
            </div>
            <div class="alert-content">
                <%= lowStockItems %> book<%= lowStockItems > 1 ? "s are" : " is" %> running low on stock (below 10 units).
                Consider restocking these items to avoid stockouts.
                <a href="${pageContext.request.contextPath}/item?action=lowStock" style="color: var(--primary-color); font-weight: 600;">View low stock items →</a>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
</div>

<!-- Charts JavaScript -->
<script>
    // Global variables for charts
    let categoryValueChart = null;
    let stockStatusChart = null;

    // Initialize everything when DOM is loaded
    document.addEventListener('DOMContentLoaded', function() {
        animateCounters();
        initializeCharts();
        setupEventListeners();
    });

    // Counter Animation
    function animateCounters() {
        const counters = document.querySelectorAll('.counter');
        const speed = 200;

        counters.forEach(counter => {
            const animate = () => {
                const target = +counter.getAttribute('data-target');
                const count = +counter.innerText.replace(/[^0-9.-]/g, '');
                const inc = target / speed;

                if (count < target) {
                    counter.innerText = Math.ceil(count + inc);
                    setTimeout(animate, 10);
                } else {
                    counter.innerText = target;
                }
            };
            animate();
        });
    }

    // Initialize Charts
    function initializeCharts() {
        // Prepare data for charts
        let categoryLabels = [];
        let categoryValuesData = [];
        let categoryStockData = [];

        <% if (categoryValues != null && !categoryValues.isEmpty()) { %>
        <%
            for (int i = 0; i < categoryValues.size(); i++) {
                Map<String, Object> cat = categoryValues.get(i);
                String catName = (String) cat.get("category");
                BigDecimal catValue = (BigDecimal) cat.get("inventoryValue");
                Number catStock = (Number) cat.get("totalStock");
        %>
        categoryLabels.push('<%= catName != null ? catName : "Unknown" %>');
        categoryValuesData.push(<%= catValue != null ? catValue : "0" %>);
        categoryStockData.push(<%= catStock != null ? catStock : "0" %>);
        <% } %>
        <% } %>

        // Category Value Chart
        const categoryValueCtx = document.getElementById('categoryValueChart').getContext('2d');
        categoryValueChart = new Chart(categoryValueCtx, {
            type: 'bar',
            data: {
                labels: categoryLabels,
                datasets: [{
                    label: 'Inventory Value (Rs.)',
                    data: categoryValuesData,
                    backgroundColor: [
                        'rgba(99, 102, 241, 0.8)',
                        'rgba(16, 185, 129, 0.8)',
                        'rgba(245, 158, 11, 0.8)',
                        'rgba(236, 72, 153, 0.8)',
                        'rgba(59, 130, 246, 0.8)',
                        'rgba(139, 92, 246, 0.8)',
                        'rgba(20, 184, 166, 0.8)'
                    ],
                    borderWidth: 0,
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderColor: '#6366F1',
                        borderWidth: 1,
                        padding: 12,
                        displayColors: false,
                        callbacks: {
                            label: function(context) {
                                const index = context.dataIndex;
                                const value = 'Rs. ' + context.parsed.y.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                const stock = categoryStockData[index] + ' units';
                                return [value, stock];
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            color: '#6B7280',
                            font: {
                                weight: '500'
                            }
                        }
                    },
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        ticks: {
                            color: '#6B7280',
                            callback: function(value) {
                                return 'Rs. ' + value.toLocaleString();
                            }
                        }
                    }
                }
            }
        });

        // Stock Status Chart
        const stockStatusCtx = document.getElementById('stockStatusChart').getContext('2d');
        const stockStatusData = {
            labels: ['In Stock', 'Low Stock', 'Out of Stock'],
            datasets: [{
                data: [
                    <%= totalItems - lowStockItems - outOfStockItems %>,
                    <%= lowStockItems %>,
                    <%= outOfStockItems %>
                ],
                backgroundColor: [
                    '#10B981',
                    '#F59E0B',
                    '#EF4444'
                ],
                borderWidth: 0,
                hoverOffset: 4
            }]
        };

        stockStatusChart = new Chart(stockStatusCtx, {
            type: 'doughnut',
            data: stockStatusData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true,
                            font: {
                                size: 12,
                                weight: '500'
                            }
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderColor: '#6366F1',
                        borderWidth: 1,
                        padding: 12,
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.parsed;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                return label + ': ' + value + ' items (' + percentage + '%)';
                            }
                        }
                    }
                },
                cutout: '70%',
                animation: {
                    animateRotate: true,
                    animateScale: true
                }
            }
        });
    }

    // Export Menu Toggle
    function toggleExportMenu() {
        const dropdown = document.getElementById('exportDropdown');
        dropdown.classList.toggle('show');

        // Close dropdown when clicking outside
        document.addEventListener('click', function closeDropdown(e) {
            if (!e.target.closest('.export-menu')) {
                dropdown.classList.remove('show');
                document.removeEventListener('click', closeDropdown);
            }
        });
    }

    // Export Functions
    function exportToPDF() {
        showNotification('info', 'Generating PDF report...');

        // In a real implementation, this would trigger server-side PDF generation
        setTimeout(() => {
            showNotification('success', 'PDF report generated successfully!');
            // window.location.href = '${pageContext.request.contextPath}/item?action=exportPDF&type=inventory';
        }, 1500);
    }

    function exportToExcel() {
        showNotification('info', 'Generating Excel report...');

        // Create CSV content
        let csvContent = 'Inventory Report - Generated on ' + new Date().toLocaleString() + '\n\n';
        csvContent += 'Summary\n';
        csvContent += 'Total Books,<%= totalItems %>\n';
        csvContent += 'Total Stock,<%= totalStock %>\n';
        csvContent += 'Total Value,Rs. <%= totalInventoryValue %>\n';
        csvContent += 'Low Stock Items,<%= lowStockItems %>\n';
        csvContent += 'Out of Stock Items,<%= outOfStockItems %>\n';
        csvContent += 'Discounted Items,<%= discountedItems %>\n\n';

        csvContent += 'Category Details\n';
        csvContent += 'Category,Total Items,Total Stock,Value (Rs.),Average Price\n';

        <% if (categoryValues != null) {
            for (Map<String, Object> category : categoryValues) {
                String catName = (String) category.get("category");
                Number itemCount = (Number) category.get("itemCount");
                Number stockCount = (Number) category.get("totalStock");
                BigDecimal value = (BigDecimal) category.get("inventoryValue");
                BigDecimal avgPrice = stockCount != null && stockCount.intValue() > 0 ?
                    value.divide(new BigDecimal(stockCount.intValue()), 2, BigDecimal.ROUND_HALF_UP) : BigDecimal.ZERO;
        %>
        csvContent += '<%= catName %>,<%= itemCount %>,<%= stockCount %>,<%= value %>,<%= avgPrice %>\n';
        <% }
        } %>

        // Create and download file
        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        const url = URL.createObjectURL(blob);
        link.href = url;
        link.download = 'inventory_report_' + new Date().toISOString().split('T')[0] + '.csv';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(url);

        showNotification('success', 'Excel report downloaded successfully!');
    }

    function printReport() {
        window.print();
    }

    // Setup event listeners
    function setupEventListeners() {
        // Prevent default behavior on export links
        document.querySelectorAll('.export-option').forEach(option => {
            option.addEventListener('click', (e) => {
                e.preventDefault();
            });
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', (e) => {
            if (e.ctrlKey || e.metaKey) {
                switch (e.key) {
                    case 'p':
                        e.preventDefault();
                        printReport();
                        break;
                    case 'e':
                        e.preventDefault();
                        exportToExcel();
                        break;
                }
            }
        });

        // Add hover effects to value bars
        document.querySelectorAll('.value-fill').forEach((bar) => {
            bar.addEventListener('mouseenter', function() {
                this.style.transform = 'scaleY(1.2)';
                this.style.boxShadow = '0 4px 10px rgba(0,0,0,0.2)';
            });

            bar.addEventListener('mouseleave', function() {
                this.style.transform = 'scaleY(1)';
                this.style.boxShadow = 'none';
            });
        });
    }

    // Notification System
    function showNotification(type, message) {
        const notification = document.createElement('div');
        notification.className = 'notification ' + type;

        const icon = type === 'success' ? 'check-circle' :
            type === 'error' ? 'times-circle' :
                'info-circle';

        notification.innerHTML = `
            <i class="fas fa-${icon}" style="font-size: 1.5rem;"></i>
            <span>${message}</span>
        `;

        document.body.appendChild(notification);

        // Auto remove after 3 seconds
        setTimeout(() => {
            notification.style.animation = 'slideOutNotif 0.5s ease-in forwards';
            setTimeout(() => notification.remove(), 500);
        }, 3000);
    }

    // Auto-refresh functionality
    let refreshTimeout;
    function startAutoRefresh() {
        // Refresh every 5 minutes
        refreshTimeout = setTimeout(() => {
            showNotification('info', 'Refreshing inventory data...');
            location.reload();
        }, 300000);
    }

    // Start auto-refresh when page loads
    startAutoRefresh();

    // Clear timeout when user interacts with the page
    document.addEventListener('click', () => {
        clearTimeout(refreshTimeout);
        startAutoRefresh();
    });

    // Add smooth scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    // Error handling for charts
    window.addEventListener('error', function(e) {
        console.error('Chart error:', e.message);
        showNotification('error', 'Error loading chart data. Please refresh the page.');
    });

    // Update charts on window resize
    window.addEventListener('resize', () => {
        if (categoryValueChart) {
            categoryValueChart.resize();
        }
        if (stockStatusChart) {
            stockStatusChart.resize();
        }
    });

    // Add loading state for data refresh
    function refreshData() {
        const container = document.querySelector('.container');
        container.style.opacity = '0.5';
        container.style.pointerEvents = 'none';

        showNotification('info', 'Refreshing data...');

        // Simulate data refresh
        setTimeout(() => {
            location.reload();
        }, 1000);
    }

    // Check for success/error messages from servlet
    <%
    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");

    if (successMsg != null && !successMsg.isEmpty()) { %>
    showNotification('success', '<%= successMsg %>');
    <% }

    if (errorMsg != null && !errorMsg.isEmpty()) { %>
    showNotification('error', '<%= errorMsg %>');
    <% } %>
</script>
</body>
</html>
