<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("item") != null ? ((Item)request.getAttribute("item")).getItemName() : "View Book" %> - Pahana Edu </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        :root {
            /* Modern Purple & Blue Theme */
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
            --dark-gradient: linear-gradient(135deg, #1F2937 0%, #374151 100%);

            /* Background & Glass */
            --bg-primary: #F9FAFB;
            --bg-secondary: #FFFFFF;
            --glass-white: rgba(255, 255, 255, 0.85);
            --glass-dark: rgba(31, 41, 55, 0.85);
            --border-color: #E5E7EB;
            --text-primary: #1F2937;
            --text-secondary: #6B7280;

            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --shadow-glow: 0 0 20px rgba(99, 102, 241, 0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
            position: relative;
        }

        /* Animated Background Pattern */
        .bg-pattern {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            opacity: 0.03;
            background-image:
                    repeating-linear-gradient(45deg, #6366F1 25%, transparent 25%, transparent 75%, #6366F1 75%, #6366F1),
                    repeating-linear-gradient(-45deg, #6366F1 25%, transparent 25%, transparent 75%, #6366F1 75%, #6366F1);
            background-size: 60px 60px;
            background-position: 0 0, 30px 30px;
            animation: backgroundMove 20s linear infinite;
        }

        @keyframes backgroundMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(30px, 30px); }
        }

        /* Floating Elements */
        .floating-elements {
            position: fixed;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .float-element {
            position: absolute;
            opacity: 0.1;
            animation: floatAnimation 20s infinite ease-in-out;
        }

        .float-element:nth-child(1) {
            top: 20%;
            left: 10%;
            font-size: 60px;
            animation-delay: 0s;
        }

        .float-element:nth-child(2) {
            top: 60%;
            right: 10%;
            font-size: 80px;
            animation-delay: 5s;
        }

        .float-element:nth-child(3) {
            bottom: 20%;
            left: 50%;
            font-size: 70px;
            animation-delay: 10s;
        }

        @keyframes floatAnimation {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(30px, -30px) rotate(120deg); }
            66% { transform: translate(-20px, 20px) rotate(240deg); }
        }

        /* Navigation */
        .navbar {
            background: var(--glass-white);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 1000;
            animation: slideDown 0.5s ease-out;
        }

        .navbar-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-brand {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .nav-brand:hover {
            transform: scale(1.05);
        }

        .nav-brand i {
            font-size: 1.75rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 0.5rem;
            align-items: center;
        }

        .nav-item {
            position: relative;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            text-decoration: none;
            color: var(--text-secondary);
            font-weight: 500;
            border-radius: 12px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .nav-link:hover {
            color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
            transform: translateY(-2px);
        }

        .nav-link.active {
            color: white;
            background: var(--primary-gradient);
            box-shadow: var(--shadow-glow);
        }

        .nav-link.active::before {
            left: 0;
        }

        /* Main Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Notification System */
        .notification-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .notification {
            min-width: 350px;
            padding: 1.25rem;
            border-radius: 16px;
            box-shadow: var(--shadow-xl);
            display: flex;
            align-items: center;
            gap: 1rem;
            position: relative;
            transform: translateX(400px);
            animation: notificationSlideIn 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards;
        }

        @keyframes notificationSlideIn {
            to {
                transform: translateX(0);
            }
        }

        .notification.hide {
            animation: notificationSlideOut 0.5s ease-out forwards;
        }

        @keyframes notificationSlideOut {
            to {
                transform: translateX(400px);
                opacity: 0;
            }
        }

        .notification-success {
            background: var(--success-gradient);
            color: white;
        }

        .notification-error {
            background: var(--danger-gradient);
            color: white;
        }

        .notification-icon {
            font-size: 1.5rem;
            animation: iconBounce 1s ease-in-out infinite;
        }

        @keyframes iconBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        .notification-content h4 {
            margin: 0 0 0.25rem 0;
            font-size: 1rem;
            font-weight: 600;
        }

        .notification-content p {
            margin: 0;
            font-size: 0.875rem;
            opacity: 0.9;
        }

        .notification-close {
            position: absolute;
            top: 0.75rem;
            right: 0.75rem;
            background: rgba(255, 255, 255, 0.2);
            border: none;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            color: white;
        }

        .notification-close:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: rotate(90deg);
        }

        .notification-progress {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            background: rgba(255, 255, 255, 0.5);
            animation: progressBar 5s linear forwards;
        }

        @keyframes progressBar {
            from { width: 100%; }
            to { width: 0%; }
        }

        /* Book Hero Section */
        .book-hero {
            background: var(--bg-secondary);
            border-radius: 24px;
            padding: 3rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
            animation: fadeInScale 0.6s ease-out;
        }

        .book-hero::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: var(--primary-gradient);
            opacity: 0.1;
            border-radius: 50%;
            animation: pulse 4s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .hero-content {
            display: flex;
            align-items: center;
            gap: 3rem;
            position: relative;
            z-index: 2;
        }

        .book-avatar {
            width: 150px;
            height: 150px;
            background: var(--primary-gradient);
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: white;
            box-shadow: var(--shadow-xl);
            position: relative;
            animation: floatAnimation 3s ease-in-out infinite;
        }

        .book-avatar::after {
            content: '';
            position: absolute;
            inset: -3px;
            background: var(--primary-gradient);
            border-radius: inherit;
            z-index: -1;
            filter: blur(20px);
            opacity: 0.5;
        }

        .hero-info h1 {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            animation: slideInLeft 0.6s ease-out 0.2s both;
        }

        .hero-info p {
            color: var(--text-secondary);
            font-size: 1.125rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            animation: slideInLeft 0.6s ease-out 0.3s both;
        }

        .hero-meta {
            display: flex;
            gap: 2rem;
            margin-top: 1rem;
            animation: slideInLeft 0.6s ease-out 0.4s both;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .meta-item i {
            color: var(--primary-color);
        }

        /* Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        /* Details Panel */
        .details-panel {
            background: var(--bg-secondary);
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            animation: slideInLeft 0.6s ease-out 0.5s both;
        }

        .panel-header {
            background: var(--primary-gradient);
            color: white;
            padding: 1.5rem 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .panel-header h2 {
            font-size: 1.25rem;
            font-weight: 700;
            margin: 0;
        }

        .panel-content {
            padding: 2rem;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .detail-item {
            background: var(--bg-primary);
            padding: 1.5rem;
            border-radius: 16px;
            border-left: 4px solid var(--primary-color);
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow-md);
        }

        .detail-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.75rem;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .detail-label i {
            color: var(--primary-color);
        }

        .detail-value {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .detail-value.price {
            font-size: 1.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Stats Sidebar */
        .stats-sidebar {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            animation: slideInRight 0.6s ease-out 0.5s both;
        }

        .stat-card {
            background: var(--bg-secondary);
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .stat-header {
            background: var(--secondary-gradient);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }

        .stat-header h3 {
            margin: 0;
            font-size: 1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .stock-display {
            text-align: center;
            padding: 2rem;
        }

        .stock-number {
            font-size: 3.5rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
        }

        .stock-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-top: 0.5rem;
        }

        .stock-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 1rem;
        }

        .stock-high {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .stock-medium {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .stock-low {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            animation: pulse 2s ease-in-out infinite;
        }

        .stock-out {
            background: rgba(107, 114, 128, 0.1);
            color: var(--text-secondary);
        }

        /* Pricing Cards */
        .pricing-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .price-card {
            background: var(--bg-primary);
            padding: 1.5rem;
            border-radius: 16px;
            text-align: center;
            border-top: 4px solid var(--primary-color);
        }

        .price-card:nth-child(2) {
            border-top-color: var(--secondary-color);
        }

        .price-card:nth-child(3) {
            border-top-color: var(--accent-color);
        }

        .price-label {
            font-size: 0.75rem;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .price-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        /* Activity Timeline */
        .activity-section {
            background: var(--bg-secondary);
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            animation: slideUp 0.6s ease-out 0.6s both;
            margin-bottom: 2rem;
        }

        .activity-header {
            background: var(--dark-gradient);
            color: white;
            padding: 1.5rem 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .activity-header h3 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
        }

        .timeline {
            padding: 2rem;
            position: relative;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 2.5rem;
            top: 0;
            bottom: 0;
            width: 2px;
            background: var(--border-color);
        }

        .timeline-item {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 2rem;
            position: relative;
        }

        .timeline-icon {
            width: 50px;
            height: 50px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
            box-shadow: var(--shadow-md);
            position: relative;
            z-index: 2;
        }

        .timeline-content {
            background: var(--bg-primary);
            padding: 1.5rem;
            border-radius: 16px;
            flex: 1;
            border-left: 4px solid var(--primary-color);
            transition: all 0.3s ease;
        }

        .timeline-content:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow-md);
        }

        .timeline-content h4 {
            margin: 0 0 0.5rem 0;
            color: var(--text-primary);
            font-weight: 600;
        }

        .timeline-content p {
            margin: 0;
            color: var(--text-secondary);
            font-size: 0.875rem;
            line-height: 1.6;
        }

        .timeline-date {
            font-size: 0.75rem;
            color: var(--text-secondary);
            margin-top: 0.5rem;
        }

        /* Action Buttons */
        .actions-panel {
            background: var(--bg-secondary);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-md);
            text-align: center;
            animation: slideUp 0.6s ease-out 0.7s both;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.875rem 1.75rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(99, 102, 241, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color) 0%, #FCD34D 100%);
            color: white;
        }

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-secondary {
            background: var(--dark-gradient);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn::after {
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

        .btn:active::after {
            width: 300px;
            height: 300px;
        }

        /* Animations */
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.9);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .loading-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .loader {
            width: 50px;
            height: 50px;
            border: 4px solid var(--border-color);
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }

            .stats-sidebar {
                flex-direction: row;
                overflow-x: auto;
            }

            .stat-card {
                min-width: 300px;
            }
        }

        @media (max-width: 768px) {
            .navbar-container {
                padding: 1rem;
            }

            .nav-menu {
                display: none;
            }

            .hero-content {
                flex-direction: column;
                text-align: center;
            }

            .hero-info h1 {
                font-size: 2rem;
            }

            .detail-grid {
                grid-template-columns: 1fr;
            }

            .button-group {
                flex-direction: column;
                width: 100%;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<!-- Background Pattern -->
<div class="bg-pattern"></div>

<!-- Floating Elements -->
<div class="floating-elements">
    <div class="float-element">📚</div>
    <div class="float-element">📖</div>
    <div class="float-element">📕</div>
</div>

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

        // Calculate values
        double unitPrice = item.getPrice().doubleValue();
        double totalValue = unitPrice * item.getStock();
        double discountedPrice = unitPrice;
        if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) {
            discountedPrice = unitPrice * (1 - item.getDiscountPercentage().doubleValue() / 100);
        }
    %>

<!-- Navigation -->
<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/dashboard" class="nav-brand">
            <i class="fas fa-store"></i>
            Pahana Edu
        </a>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                    <i class="fas fa-chart-line"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/customer" class="nav-link">
                    <i class="fas fa-user-friends"></i>
                    Customers
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/item" class="nav-link active">
                    <i class="fas fa-books"></i>
                    Inventory
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/bill" class="nav-link">
                    <i class="fas fa-cash-register"></i>
                    Billing
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link">
                    <i class="fas fa-headset"></i>
                    Support
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                    <i class="fas fa-power-off"></i>
                    Logout
                </a>
            </li>
        </ul>
    </div>
</nav>

<!-- Notification Container -->
<div class="notification-container" id="notificationContainer"></div>

<!-- Main Container -->
<div class="container">
    <!-- Book Hero Section -->
    <div class="book-hero">
        <div class="hero-content">
            <div class="book-avatar">
                <i class="fas fa-book"></i>
            </div>
            <div class="hero-info">
                <h1><%= item.getItemName() %></h1>
                <p>
                    <i class="fas fa-barcode"></i>
                    ISBN: <%= item.getItemId() %>
                </p>
                <div class="hero-meta">
                    <div class="meta-item">
                        <i class="fas fa-tag"></i>
                        <%= item.getCategory() != null ? item.getCategory() : "Uncategorized" %>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-warehouse"></i>
                        <%= item.getStock() %> units in stock
                    </div>
                    <% if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) { %>
                    <div class="meta-item">
                        <i class="fas fa-percentage"></i>
                        <%= String.format("%.0f", item.getDiscountPercentage()) %>% OFF
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <!-- Content Grid -->
    <div class="content-grid">
        <!-- Book Details Panel -->
        <div class="details-panel">
            <div class="panel-header">
                <i class="fas fa-info-circle"></i>
                <h2>Book Details</h2>
            </div>
            <div class="panel-content">
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-fingerprint"></i>
                            ISBN
                        </div>
                        <div class="detail-value"><%= item.getItemId() %></div>
                    </div>

                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-book-open"></i>
                            Title
                        </div>
                        <div class="detail-value"><%= item.getItemName() %></div>
                    </div>

                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-tags"></i>
                            Category
                        </div>
                        <div class="detail-value"><%= item.getCategory() != null ? item.getCategory() : "General" %></div>
                    </div>

                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-dollar-sign"></i>
                            Unit Price
                        </div>
                        <div class="detail-value price">
                            <% if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) { %>
                            <span style="text-decoration: line-through; color: var(--text-secondary); font-size: 1rem;">
                                        LKR <%= String.format("%,.2f", unitPrice) %>
                                    </span><br>
                            LKR <%= String.format("%,.2f", discountedPrice) %>
                            <% } else { %>
                            LKR <%= String.format("%,.2f", unitPrice) %>
                            <% } %>
                        </div>
                    </div>

                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-boxes"></i>
                            Stock Quantity
                        </div>
                        <div class="detail-value">
                            <%= item.getStock() %> units
                            <span class="stock-indicator <%= stockClass %>">
                                    <i class="fas fa-circle"></i>
                                    <%= stockStatus %>
                                </span>
                        </div>
                    </div>

                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-calculator"></i>
                            Total Value
                        </div>
                        <div class="detail-value price">LKR <%= String.format("%,.2f", totalValue) %></div>
                    </div>

                        <% if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) { %>
                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-percentage"></i>
                            Discount
                        </div>
                        <div class="detail-value">
                            <%= String.format("%.0f", item.getDiscountPercentage()) %>% OFF
                            <span style="color: var(--danger-color); font-size: 0.875rem;">
                                    (Save LKR <%= String.format("%,.2f", unitPrice - discountedPrice) %>)
                                </span>
                        </div>
                    </div>
                        <% } %>

                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-chart-line"></i>
                            Availability
                        </div>
                        <div class="detail-value">
                            <% if (item.getStock() == 0) { %>
                            <span style="color: var(--danger-color);">Unavailable</span>
                            <% } else if (item.getStock() < 10) { %>
                            <span style="color: var(--warning-color);">Limited Stock</span>
                            <% } else { %>
                            <span style="color: var(--success-color);">Available</span>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Sidebar -->
        <div class="stats-sidebar">
            <!-- Stock Overview Card -->
            <div class="stat-card">
                <div class="stat-header">
                    <h3>
                        <i class="fas fa-chart-bar"></i>
                        Stock Overview
                    </h3>
                </div>
                <div class="stock-display">
                    <div class="stock-number" data-value="<%= item.getStock() %>">0</div>
                    <div class="stock-label">Units Available</div>
                    <span class="stock-indicator <%= stockClass %>">
                            <i class="fas fa-circle"></i>
                            <%= stockStatus %>
                        </span>
                </div>
            </div>

            <!-- Pricing Information -->
            <div class="stat-card">
                <div class="stat-header">
                    <h3>
                        <i class="fas fa-dollar-sign"></i>
                        Pricing Information
                    </h3>
                </div>
                <div class="pricing-cards">
                    <div class="price-card">
                        <div class="price-label">Unit Price</div>
                        <div class="price-value">LKR <%= String.format("%,.2f", unitPrice) %></div>
                    </div>
                    <% if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) { %>
                    <div class="price-card">
                        <div class="price-label">Sale Price</div>
                        <div class="price-value" style="color: var(--danger-color);">
                            LKR <%= String.format("%,.2f", discountedPrice) %>
                        </div>
                    </div>
                    <div class="price-card">
                        <div class="price-label">You Save</div>
                        <div class="price-value" style="color: var(--success-color);">
                            LKR <%= String.format("%,.2f", unitPrice - discountedPrice) %>
                        </div>
                    </div>
                    <% } %>
                    <div class="price-card">
                        <div class="price-label">Total Value</div>
                        <div class="price-value">LKR <%= String.format("%,.2f", totalValue) %></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Activity Timeline -->
    <div class="activity-section">
        <div class="activity-header">
            <i class="fas fa-history"></i>
            <h3>Activity Timeline</h3>
        </div>
        <div class="timeline">
            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <div class="timeline-content">
                    <h4>Book Added to Inventory</h4>
                    <p>This book was successfully added to the inventory system.</p>
                    <div class="timeline-date">
                        <i class="fas fa-clock"></i>
                        <% if (item.getCreatedAt() != null) { %>
                        <%= dateFormat.format(item.getCreatedAt()) %>
                        <% } else { %>
                        Date not available
                        <% } %>
                    </div>
                </div>
            </div>

            <% if (item.getUpdatedAt() != null && !item.getUpdatedAt().equals(item.getCreatedAt())) { %>
            <div class="timeline-item">
                <div class="timeline-icon">
                    <i class="fas fa-edit"></i>
                </div>
                <div class="timeline-content">
                    <h4>Information Updated</h4>
                    <p>Book details were modified.</p>
                    <div class="timeline-date">
                        <i class="fas fa-clock"></i>
                        <%= dateFormat.format(item.getUpdatedAt()) %>
                    </div>
                </div>
            </div>
            <% } %>

            <div class="timeline-item">
                <div class="timeline-icon" style="background: <%=
                        item.getStock() == 0 ? "var(--danger-gradient)" :
                        item.getStock() < 10 ? "var(--warning-color)" :
                        "var(--success-gradient)" %>;">
                    <i class="fas fa-<%=
                            item.getStock() == 0 ? "times-circle" :
                            item.getStock() < 10 ? "exclamation-triangle" :
                            "check-circle" %>"></i>
                </div>
                <div class="timeline-content">
                    <h4>Current Stock Status</h4>
                    <p>
                        <% if (item.getStock() == 0) { %>
                        This book is currently out of stock and requires immediate restocking.
                        <% } else if (item.getStock() < 10) { %>
                        Low stock alert! Only <%= item.getStock() %> units remaining. Consider restocking soon.
                        <% } else if (item.getStock() < 50) { %>
                        Moderate stock levels with <%= item.getStock() %> units available.
                        <% } else { %>
                        Well stocked with <%= item.getStock() %> units in inventory.
                        <% } %>
                    </p>
                    <div class="timeline-date">
                        <i class="fas fa-clock"></i>
                        Current Status
                    </div>
                </div>
            </div>

            <% if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) { %>
            <div class="timeline-item">
                <div class="timeline-icon" style="background: var(--secondary-gradient);">
                    <i class="fas fa-tag"></i>
                </div>
                <div class="timeline-content">
                    <h4>Special Discount Active</h4>
                    <p>
                        This book is currently on sale with <%= String.format("%.0f", item.getDiscountPercentage()) %>% discount.
                        Customers save LKR <%= String.format("%,.2f", unitPrice - discountedPrice) %> per unit.
                    </p>
                    <div class="timeline-date">
                        <i class="fas fa-clock"></i>
                        Active Promotion
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="actions-panel">
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/item?action=edit&itemId=<%= item.getItemId() %>"
               class="btn btn-primary">
                <i class="fas fa-edit"></i>
                Edit Book
            </a>

            <a href="${pageContext.request.contextPath}/item?action=manageDiscount&itemId=<%= item.getItemId() %>"
               class="btn btn-warning">
                <i class="fas fa-percentage"></i>
                Manage Discount
            </a>

            <a href="${pageContext.request.contextPath}/item?action=delete&itemId=<%= item.getItemId() %>"
               class="btn btn-danger"
               onclick="return confirmDelete()">
                <i class="fas fa-trash"></i>
                Delete Book
            </a>

            <a href="${pageContext.request.contextPath}/item"
               class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>
                Back to Inventory
            </a>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loader"></div>
</div>

<script>
    // Show notifications from server
    <% if (request.getParameter("success") != null) { %>
    showNotification('<%= request.getParameter("success") %>', 'success');
    <% } %>

    <% String successMessage = (String) request.getAttribute("successMessage"); %>
    <% if (successMessage != null) { %>
    showNotification('<%= successMessage %>', 'success');
    <% } %>

    // Notification System
    function showNotification(message, type = 'info', duration = 5000) {
        const container = document.getElementById('notificationContainer');

        const notification = document.createElement('div');
        notification.className = 'notification notification-' + type;

        const icon = document.createElement('div');
        icon.className = 'notification-icon';
        icon.innerHTML = type === 'success' ? '<i class="fas fa-check-circle"></i>' :
            type === 'error' ? '<i class="fas fa-exclamation-circle"></i>' :
                '<i class="fas fa-info-circle"></i>';

        const content = document.createElement('div');
        content.className = 'notification-content';
        content.innerHTML = '<h4>' + type.charAt(0).toUpperCase() + type.slice(1) + '</h4>' +
            '<p>' + message + '</p>';

        const closeBtn = document.createElement('button');
        closeBtn.className = 'notification-close';
        closeBtn.innerHTML = '<i class="fas fa-times"></i>';
        closeBtn.onclick = () => hideNotification(notification);

        const progress = document.createElement('div');
        progress.className = 'notification-progress';

        notification.appendChild(icon);
        notification.appendChild(content);
        notification.appendChild(closeBtn);
        notification.appendChild(progress);

        container.appendChild(notification);

        // Auto hide after duration
        setTimeout(() => {
            hideNotification(notification);
        }, duration);
    }

    function hideNotification(notification) {
        notification.classList.add('hide');
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 500);
    }

    // Confirm Delete
    function confirmDelete() {
        const result = confirm('Are you sure you want to delete "<%= item.getItemName() %>"?\n\nThis action cannot be undone.');
        if (result) {
            showLoading(true);
        }
        return result;
    }

    // Show/Hide Loading
    function showLoading(show) {
        const overlay = document.getElementById('loadingOverlay');
        if (show) {
            overlay.classList.add('show');
        } else {
            overlay.classList.remove('show');
        }
    }

    // Animate stock number
    function animateStockNumber() {
        const stockNumber = document.querySelector('.stock-number');
        if (!stockNumber) return;

        const finalValue = parseInt(stockNumber.getAttribute('data-value'));
        const duration = 1500;
        const step = finalValue / (duration / 16);
        let current = 0;

        const timer = setInterval(() => {
            current += step;
            if (current >= finalValue) {
                current = finalValue;
                clearInterval(timer);
            }
            stockNumber.textContent = Math.floor(current);
        }, 16);
    }

    // Copy ISBN to clipboard
    function copyISBN() {
        const isbn = '<%= item.getItemId() %>';
        navigator.clipboard.writeText(isbn).then(() => {
            showNotification('ISBN copied to clipboard: ' + isbn, 'success', 3000);
        }).catch(() => {
            showNotification('Failed to copy ISBN', 'error', 3000);
        });
    }

    // Print book details
    function printBookDetails() {
        window.print();
    }

    // Initialize on load
    document.addEventListener('DOMContentLoaded', function() {
        // Animate stock number
        animateStockNumber();

        // Add click to copy for ISBN
        const isbnElements = document.querySelectorAll('.detail-value');
        isbnElements.forEach(element => {
            if (element.textContent.includes('<%= item.getItemId() %>')) {
                element.style.cursor = 'pointer';
                element.title = 'Click to copy';
                element.addEventListener('click', copyISBN);
            }
        });

        // Add hover effects to timeline items
        const timelineItems = document.querySelectorAll('.timeline-item');
        timelineItems.forEach((item, index) => {
            item.style.opacity = '0';
            item.style.transform = 'translateX(-20px)';
            item.style.transition = 'all 0.6s ease';

            setTimeout(() => {
                item.style.opacity = '1';
                item.style.transform = 'translateX(0)';
            }, index * 200);
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl/Cmd + E - Edit
            if ((e.ctrlKey || e.metaKey) && e.key === 'e') {
                e.preventDefault();
                window.location.href = '${pageContext.request.contextPath}/item?action=edit&itemId=<%= item.getItemId() %>';
            }

            // Ctrl/Cmd + P - Print
            if ((e.ctrlKey || e.metaKey) && e.key === 'p') {
                e.preventDefault();
                printBookDetails();
            }

            // Ctrl/Cmd + C - Copy ISBN
            if ((e.ctrlKey || e.metaKey) && e.key === 'c') {
                e.preventDefault();
                copyISBN();
            }

            // ESC - Go back
            if (e.key === 'Escape') {
                window.location.href = '${pageContext.request.contextPath}/item';
            }
        });

        // Add tooltips
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(btn => {
            if (btn.textContent.includes('Edit')) btn.title = 'Edit Book (Ctrl+E)';
            if (btn.textContent.includes('Back')) btn.title = 'Go Back (ESC)';
        });

        // Add animation to detail items
        const detailItems = document.querySelectorAll('.detail-item');
        detailItems.forEach((item, index) => {
            item.style.opacity = '0';
            item.style.transform = 'translateY(20px)';
            item.style.transition = 'all 0.4s ease';

            setTimeout(() => {
                item.style.opacity = '1';
                item.style.transform = 'translateY(0)';
            }, index * 50);
        });

        // Add ripple effect to buttons
        const btns = document.querySelectorAll('.btn');
        btns.forEach(btn => {
            btn.addEventListener('click', function(e) {
                const rect = this.getBoundingClientRect();
                const ripple = document.createElement('span');
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;

                ripple.style.cssText = 'position: absolute; width: ' + size + 'px; height: ' + size + 'px; ' +
                    'left: ' + x + 'px; top: ' + y + 'px; border-radius: 50%; ' +
                    'background: rgba(255, 255, 255, 0.5); transform: scale(0); ' +
                    'animation: ripple 0.6s ease-out;';

                this.appendChild(ripple);

                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });

        // Check stock status and show warning
        const stockValue = <%= item.getStock() %>;
        if (stockValue < 10 && stockValue > 0) {
            setTimeout(() => {
                showNotification('Low stock warning! Only ' + stockValue + ' units remaining.', 'warning');
            }, 1000);
        } else if (stockValue === 0) {
            setTimeout(() => {
                showNotification('This book is out of stock!', 'error');
            }, 1000);
        }
    });

    // Add print styles
    const printStyles = document.createElement('style');
    printStyles.innerHTML = '@media print {' +
        '.navbar, .actions-panel, .notification-container, .loading-overlay, ' +
        '.floating-elements, .bg-pattern { display: none !important; }' +
        '.container { padding: 1rem; }' +
        '.book-hero, .details-panel, .stat-card, .activity-section { ' +
        'box-shadow: none; page-break-inside: avoid; }' +
        '.detail-grid { grid-template-columns: repeat(2, 1fr); }' +
        '}';
    document.head.appendChild(printStyles);

    // Add ripple animation CSS
    const style = document.createElement('style');
    style.textContent = '@keyframes ripple { to { transform: scale(4); opacity: 0; } }';
    document.head.appendChild(style);
</script>
</body>
</html>
