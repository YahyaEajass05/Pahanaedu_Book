<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Item" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Book - <%= request.getAttribute("item") != null ? ((Item)request.getAttribute("item")).getItemName() : "" %> - Pahana Edu </title>
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
            --danger-dark: #DC2626;
            --info-color: #3B82F6;

            /* Gradients */
            --primary-gradient: linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%);
            --secondary-gradient: linear-gradient(135deg, #EC4899 0%, #F472B6 100%);
            --success-gradient: linear-gradient(135deg, #10B981 0%, #14B8A6 100%);
            --danger-gradient: linear-gradient(135deg, #EF4444 0%, #F87171 100%);
            --warning-gradient: linear-gradient(135deg, #F59E0B 0%, #FCD34D 100%);
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
            --shadow-danger: 0 0 30px rgba(239, 68, 68, 0.3);
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
            min-height: 100vh;
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
                    repeating-linear-gradient(45deg, #EF4444 25%, transparent 25%, transparent 75%, #EF4444 75%, #EF4444),
                    repeating-linear-gradient(-45deg, #EF4444 25%, transparent 25%, transparent 75%, #EF4444 75%, #EF4444);
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
            color: var(--danger-color);
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
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            min-height: calc(100vh - 80px);
            justify-content: center;
        }

        /* Delete Card */
        .delete-card {
            background: var(--bg-secondary);
            border-radius: 24px;
            box-shadow: var(--shadow-xl);
            overflow: hidden;
            animation: zoomIn 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .delete-card:hover {
            border-color: var(--danger-color);
            box-shadow: var(--shadow-danger);
        }

        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* Card Header */
        .card-header {
            background: var(--danger-gradient);
            padding: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .card-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .warning-icon {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            position: relative;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(255, 255, 255, 0.4); }
            50% { transform: scale(1.1); box-shadow: 0 0 0 20px rgba(255, 255, 255, 0); }
        }

        .warning-icon i {
            font-size: 2.5rem;
            color: white;
            animation: shake 2s ease-in-out infinite;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-2px); }
            20%, 40%, 60%, 80% { transform: translateX(2px); }
        }

        .card-header h2 {
            color: white;
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        /* Card Body */
        .card-body {
            padding: 2.5rem;
        }

        .delete-message {
            text-align: center;
            margin-bottom: 2rem;
            animation: fadeInUp 0.6s ease-out 0.2s both;
        }

        .delete-message p {
            font-size: 1.125rem;
            color: var(--text-secondary);
            margin-bottom: 1rem;
            line-height: 1.8;
        }

        .book-details {
            background: var(--bg-primary);
            border-radius: 16px;
            padding: 2rem;
            margin: 2rem 0;
            border: 2px solid var(--border-color);
            animation: fadeInUp 0.6s ease-out 0.3s both;
        }

        .book-details h3 {
            font-size: 1.25rem;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .book-details h3 i {
            color: var(--danger-color);
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .detail-item {
            background: white;
            padding: 1rem;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            border-color: var(--danger-color);
        }

        .detail-label {
            font-size: 0.75rem;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-label i {
            color: var(--danger-color);
        }

        .detail-value {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        /* Warning Box */
        .warning-box {
            background: rgba(239, 68, 68, 0.1);
            border: 2px solid var(--danger-color);
            border-radius: 16px;
            padding: 1.5rem;
            margin: 2rem 0;
            animation: warningPulse 2s ease-in-out infinite;
        }

        @keyframes warningPulse {
            0%, 100% { border-color: var(--danger-color); }
            50% { border-color: var(--danger-dark); }
        }

        .warning-box h4 {
            color: var(--danger-color);
            font-size: 1.125rem;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .warning-box ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .warning-box li {
            color: var(--text-primary);
            padding: 0.5rem 0;
            padding-left: 1.5rem;
            position: relative;
        }

        .warning-box li::before {
            content: '•';
            position: absolute;
            left: 0;
            color: var(--danger-color);
            font-weight: bold;
            font-size: 1.25rem;
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

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
            animation: fadeInUp 0.6s ease-out 0.4s both;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            position: relative;
            overflow: hidden;
            min-width: 150px;
            justify-content: center;
        }

        .btn-cancel {
            background: var(--dark-gradient);
            color: white;
        }

        .btn-cancel:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(239, 68, 68, 0.4);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.5);
            animation: dangerPulse 1s ease-in-out infinite;
        }

        @keyframes dangerPulse {
            0%, 100% { box-shadow: 0 6px 20px rgba(239, 68, 68, 0.5); }
            50% { box-shadow: 0 6px 30px rgba(239, 68, 68, 0.7); }
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
            border-top-color: var(--danger-color);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Confirmation Modal */
        .confirmation-modal {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .confirmation-modal.show {
            opacity: 1;
            visibility: visible;
        }

        .modal-content {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            max-width: 400px;
            text-align: center;
            animation: modalBounce 0.5s ease-out;
        }

        @keyframes modalBounce {
            0% { transform: scale(0.8); opacity: 0; }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); opacity: 1; }
        }

        .modal-icon {
            width: 80px;
            height: 80px;
            background: var(--danger-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
        }

        .modal-icon i {
            font-size: 2.5rem;
            color: white;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
        }

        .modal-text {
            color: var(--text-secondary);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .modal-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        /* Animations */
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

        /* Responsive */
        @media (max-width: 768px) {
            .navbar-container {
                padding: 1rem;
            }

            .nav-menu {
                display: none;
            }

            .container {
                padding: 1rem;
            }

            .detail-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
                width: 100%;
            }

            .btn {
                width: 100%;
            }

            .notification {
                min-width: 300px;
                right: 10px;
            }
        }
    </style>
</head>
<body>
<!-- Background Pattern -->
<div class="bg-pattern"></div>

<!-- Floating Elements -->
<div class="floating-elements">
    <div class="float-element">⚠️</div>
    <div class="float-element">🗑️</div>
    <div class="float-element">❌</div>
</div>

<!-- Check if user is logged in and item exists -->
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

        // Calculate values
        double totalValue = item.getPrice().doubleValue() * item.getStock();
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
    <!-- Delete Card -->
    <div class="delete-card">
        <div class="card-header">
            <div class="warning-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h2>Delete Book Confirmation</h2>
        </div>

        <div class="card-body">
            <div class="delete-message">
                <p>You are about to permanently delete the following book from your inventory:</p>
            </div>

            <!-- Book Details -->
            <div class="book-details">
                <h3>
                    <i class="fas fa-book"></i>
                    Book Information
                </h3>
                <div class="detail-grid">
                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-barcode"></i>
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
                            <i class="fas fa-tag"></i>
                            Category
                        </div>
                        <div class="detail-value"><%= item.getCategory() != null ? item.getCategory() : "Uncategorized" %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-dollar-sign"></i>
                            Price
                        </div>
                        <div class="detail-value">LKR <%= String.format("%,.2f", item.getPrice()) %></div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-boxes"></i>
                            Current Stock
                        </div>
                        <div class="detail-value"><%= item.getStock() %> units</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">
                            <i class="fas fa-calculator"></i>
                            Total Value
                        </div>
                        <div class="detail-value">LKR <%= String.format("%,.2f", totalValue) %></div>
                    </div>
                </div>
            </div>

            <!-- Warning Box -->
            <div class="warning-box">
                <h4>
                    <i class="fas fa-exclamation-circle"></i>
                    Important Notice
                </h4>
                <ul>
                    <li>This action cannot be undone</li>
                    <li>All book data will be permanently removed</li>
                    <li>The book cannot be recovered after deletion</li>
                    <% if (item.getStock() > 0) { %>
                    <li><strong>Warning: This book still has <%= item.getStock() %> units in stock!</strong></li>
                    <% } %>
                </ul>
            </div>

            <!-- Action Buttons -->
            <form id="deleteForm" action="${pageContext.request.contextPath}/item" method="post">
                <input type="hidden" name="action" value="confirmDelete">
                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">

                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/item?action=view&itemId=<%= item.getItemId() %>"
                       class="btn btn-cancel">
                        <i class="fas fa-arrow-left"></i>
                        Cancel
                    </a>
                    <button type="button"
                            id="deleteBtn"
                            class="btn btn-danger"
                            onclick="showConfirmationModal()">
                        <i class="fas fa-trash"></i>
                        Delete Book
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Confirmation Modal -->
<div class="confirmation-modal" id="confirmationModal">
    <div class="modal-content">
        <div class="modal-icon">
            <i class="fas fa-trash-alt"></i>
        </div>
        <h3 class="modal-title">Final Confirmation</h3>
        <p class="modal-text">
            Are you absolutely sure you want to delete<br>
            <strong>"<%= item.getItemName() %>"</strong>?<br>
            This action is permanent and irreversible.
        </p>
        <div class="modal-actions">
            <button class="btn btn-cancel" onclick="hideConfirmationModal()">
                <i class="fas fa-times"></i>
                Cancel
            </button>
            <button class="btn btn-danger" onclick="confirmDelete()">
                <i class="fas fa-check"></i>
                Yes, Delete
            </button>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loader"></div>
</div>

<script>
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
        content.innerHTML = '<h4>' + (type.charAt(0).toUpperCase() + type.slice(1)) + '</h4>' +
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

    // Show/Hide Loading
    function showLoading(show) {
        const overlay = document.getElementById('loadingOverlay');
        if (show) {
            overlay.classList.add('show');
        } else {
            overlay.classList.remove('show');
        }
    }

    // Confirmation Modal
    function showConfirmationModal() {
        const modal = document.getElementById('confirmationModal');
        modal.classList.add('show');

        // Add shake animation to delete button
        const deleteBtn = document.getElementById('deleteBtn');
        deleteBtn.style.animation = 'shake 0.5s ease-in-out';
        setTimeout(() => {
            deleteBtn.style.animation = '';
        }, 500);
    }

    function hideConfirmationModal() {
        const modal = document.getElementById('confirmationModal');
        modal.classList.remove('show');
    }

    function confirmDelete() {
        showLoading(true);
        showNotification('Deleting book...', 'info');

        // Submit the form
        setTimeout(() => {
            document.getElementById('deleteForm').submit();
        }, 500);
    }

    // Initialize on load
    document.addEventListener('DOMContentLoaded', function() {
        // Show warning if book has stock
        <% if (item.getStock() > 0) { %>
        setTimeout(() => {
            showNotification('Warning: This book still has <%= item.getStock() %> units in stock!', 'error', 7000);
        }, 500);
        <% } %>

        // Animate elements
        const detailItems = document.querySelectorAll('.detail-item');
        detailItems.forEach((item, index) => {
            item.style.opacity = '0';
            item.style.transform = 'translateY(20px)';
            setTimeout(() => {
                item.style.transition = 'all 0.5s ease';
                item.style.opacity = '1';
                item.style.transform = 'translateY(0)';
            }, index * 100);
        });

        // Add keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // ESC to cancel
            if (e.key === 'Escape') {
                if (document.getElementById('confirmationModal').classList.contains('show')) {
                    hideConfirmationModal();
                } else {
                    window.location.href = '${pageContext.request.contextPath}/item?action=view&itemId=<%= item.getItemId() %>';
                }
            }

            // Ctrl/Cmd + D to delete
            if ((e.ctrlKey || e.metaKey) && e.key === 'd') {
                e.preventDefault();
                showConfirmationModal();
            }
        });

        // Click outside modal to close
        document.getElementById('confirmationModal').addEventListener('click', function(e) {
            if (e.target === this) {
                hideConfirmationModal();
            }
        });

        // Add hover effect to detail items
        const detailItemsHover = document.querySelectorAll('.detail-item');
        detailItemsHover.forEach(item => {
            item.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px) scale(1.02)';
            });

            item.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(-2px) scale(1)';
            });
        });

        // Add ripple effect to buttons
        document.querySelectorAll('.btn').forEach(button => {
            button.addEventListener('click', function(e) {
                const rect = this.getBoundingClientRect();
                const ripple = document.createElement('span');
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;

                ripple.style.cssText = 'position: absolute; width: ' + size + 'px; height: ' + size + 'px;' +
                    'left: ' + x + 'px; top: ' + y + 'px; border-radius: 50%;' +
                    'background: rgba(255, 255, 255, 0.5); transform: scale(0);' +
                    'animation: ripple-effect 0.6s ease-out;';

                this.style.position = 'relative';
                this.style.overflow = 'hidden';
                this.appendChild(ripple);

                setTimeout(() => ripple.remove(), 600);
            });
        });

        // Show keyboard shortcuts tip
        setTimeout(() => {
            showNotification('Tip: Press ESC to cancel, Ctrl+D to delete', 'info', 4000);
        }, 2000);
    });

    // Add ripple animation CSS
    const style = document.createElement('style');
    style.textContent = '@keyframes ripple-effect { to { transform: scale(4); opacity: 0; } }';
    document.head.appendChild(style);

    // Prevent accidental deletion
    let deleteClickCount = 0;
    const deleteButton = document.getElementById('deleteBtn');

    deleteButton.addEventListener('click', function(e) {
        deleteClickCount++;

        if (deleteClickCount === 1) {
            // First click - show warning
            this.textContent = 'Click again to confirm';
            this.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Click again to confirm';
            this.style.animation = 'dangerPulse 1s ease-in-out infinite';

            // Reset after 3 seconds
            setTimeout(() => {
                if (deleteClickCount === 1) {
                    deleteClickCount = 0;
                    this.innerHTML = '<i class="fas fa-trash"></i> Delete Book';
                    this.style.animation = '';
                }
            }, 3000);
        }
    });

    // Add visual feedback for high-value items
    const totalValue = <%= totalValue %>;
    if (totalValue > 100000) {
        const warningBox = document.querySelector('.warning-box');
        warningBox.style.background = 'rgba(239, 68, 68, 0.2)';
        warningBox.style.borderColor = 'var(--danger-dark)';

        // Add additional warning
        const highValueWarning = document.createElement('li');
        highValueWarning.innerHTML = '<strong style="color: var(--danger-color);">⚠️ High Value Alert: This deletion will remove LKR ' +
            totalValue.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) +
            ' worth of inventory!</strong>';
        warningBox.querySelector('ul').appendChild(highValueWarning);
    }

    // Auto-save deletion reason (for future implementation)
    function saveDeletionReason() {
        const reason = prompt('Please provide a reason for deleting this book (optional):');
        if (reason) {
            // Store in session storage for audit trail
            sessionStorage.setItem('deletionReason_<%= item.getItemId() %>', reason);
            sessionStorage.setItem('deletionTimestamp_<%= item.getItemId() %>', new Date().toISOString());
        }
    }

    // Enhanced delete confirmation with reason
    const originalConfirmDelete = confirmDelete;
    confirmDelete = function() {
        // saveDeletionReason(); // Uncomment to enable deletion reason prompt
        originalConfirmDelete();
    };

    // Add countdown timer for auto-cancel
    let countdownTimer;
    let countdown = 60; // 60 seconds

    function startCountdown() {
        const cancelBtn = document.querySelector('.btn-cancel');
        const originalText = cancelBtn.innerHTML;

        countdownTimer = setInterval(() => {
            countdown--;
            cancelBtn.innerHTML = '<i class="fas fa-arrow-left"></i> Cancel (' + countdown + 's)';

            if (countdown <= 10) {
                cancelBtn.style.animation = 'pulse 1s ease-in-out infinite';
            }

            if (countdown <= 0) {
                clearInterval(countdownTimer);
                showNotification('Auto-cancelling deletion for safety', 'info');
                setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/item?action=view&itemId=<%= item.getItemId() %>';
                }, 1500);
            }
        }, 1000);
    }

    // Start countdown when page loads
    startCountdown();

    // Stop countdown on any user interaction
    document.addEventListener('click', function() {
        if (countdownTimer) {
            clearInterval(countdownTimer);
            const cancelBtn = document.querySelector('.btn-cancel');
            cancelBtn.innerHTML = '<i class="fas fa-arrow-left"></i> Cancel';
            cancelBtn.style.animation = '';
        }
    });

    // Add visual emphasis for stock warning
    <% if (item.getStock() > 0) { %>
    const stockDetail = Array.from(document.querySelectorAll('.detail-item')).find(item =>
        item.textContent.includes('Current Stock')
    );
    if (stockDetail) {
        stockDetail.style.background = 'rgba(239, 68, 68, 0.1)';
        stockDetail.style.borderColor = 'var(--danger-color)';
        stockDetail.querySelector('.detail-value').style.color = 'var(--danger-color)';
        stockDetail.querySelector('.detail-value').style.fontWeight = '700';
    }
    <% } %>

    // Add book preview animation
    const bookDetails = document.querySelector('.book-details');
    bookDetails.addEventListener('mouseenter', function() {
        this.style.transform = 'scale(1.02)';
        this.style.boxShadow = '0 10px 30px rgba(0, 0, 0, 0.1)';
    });

    bookDetails.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
        this.style.boxShadow = 'none';
    });

    // Error handling for form submission
    document.getElementById('deleteForm').addEventListener('submit', function(e) {
        // Prevent double submission
        const submitButton = this.querySelector('button[type="submit"]');
        if (submitButton && submitButton.disabled) {
            e.preventDefault();
            return false;
        }

        // Disable submit button
        if (submitButton) {
            submitButton.disabled = true;
        }
    });

    // Add page visibility tracking
    document.addEventListener('visibilitychange', function() {
        if (document.hidden && countdownTimer) {
            // Page is hidden, pause countdown
            clearInterval(countdownTimer);
        } else if (!document.hidden && countdown > 0) {
            // Page is visible again, resume countdown
            startCountdown();
        }
    });

    // Log deletion attempt for analytics
    console.log('Book deletion page loaded:', {
        bookId: '<%= item.getItemId() %>',
        bookTitle: '<%= item.getItemName() %>',
        stock: <%= item.getStock() %>,
        value: <%= totalValue %>,
        timestamp: new Date().toISOString()
    });

    // Add confirmation sound effect (optional)
    function playSound(type) {
        // Create audio context for sound effects
        if (window.AudioContext || window.webkitAudioContext) {
            const audioContext = new (window.AudioContext || window.webkitAudioContext)();
            const oscillator = audioContext.createOscillator();
            const gainNode = audioContext.createGain();

            oscillator.connect(gainNode);
            gainNode.connect(audioContext.destination);

            if (type === 'warning') {
                oscillator.frequency.setValueAtTime(300, audioContext.currentTime);
                oscillator.frequency.setValueAtTime(200, audioContext.currentTime + 0.1);
            } else if (type === 'confirm') {
                oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
                oscillator.frequency.setValueAtTime(1000, audioContext.currentTime + 0.1);
            }

            gainNode.gain.setValueAtTime(0.1, audioContext.currentTime);
            gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.2);

            oscillator.start(audioContext.currentTime);
            oscillator.stop(audioContext.currentTime + 0.2);
        }
    }

    // Play warning sound on modal show
    const originalShowModal = showConfirmationModal;
    showConfirmationModal = function() {
        originalShowModal();
        playSound('warning');
    };

    // Print deletion receipt (for record keeping)
    function printDeletionRecord() {
        const printWindow = window.open('', '_blank');
        const printContent = `
                <html>
                <head>
                    <title>Book Deletion Record</title>
                    <style>
                        body { font-family: Arial, sans-serif; padding: 20px; }
                        h1 { color: #EF4444; }
                        .details { margin: 20px 0; }
                        .detail-row { margin: 10px 0; }
                        .timestamp { margin-top: 30px; font-style: italic; }
                    </style>
                </head>
                <body>
                    <h1>Book Deletion Record</h1>
                    <div class="details">
                        <div class="detail-row"><strong>ISBN:</strong> <%= item.getItemId() %></div>
                        <div class="detail-row"><strong>Title:</strong> <%= item.getItemName() %></div>
                        <div class="detail-row"><strong>Category:</strong> <%= item.getCategory() != null ? item.getCategory() : "Uncategorized" %></div>
                        <div class="detail-row"><strong>Price:</strong> LKR <%= String.format("%,.2f", item.getPrice()) %></div>
                        <div class="detail-row"><strong>Stock:</strong> <%= item.getStock() %> units</div>
                        <div class="detail-row"><strong>Total Value:</strong> LKR <%= String.format("%,.2f", totalValue) %></div>
                    </div>
                    <div class="timestamp">
                        <p>Deletion initiated on: ' + new Date().toLocaleString() + '</p>
                        <p>User: ${sessionStorage.getItem('adminUser') || 'Administrator'}</p>
                    </div>
                </body>
                </html>
            `;

        printWindow.document.write(printContent);
        printWindow.document.close();
        printWindow.print();
    }

    // Add print button functionality (optional)
    // Uncomment to enable printing deletion records
    /*
    const printBtn = document.createElement('button');
    printBtn.className = 'btn btn-info';
    printBtn.innerHTML = '<i class="fas fa-print"></i> Print Record';
    printBtn.onclick = printDeletionRecord;
    printBtn.style.marginLeft = '1rem';
    document.querySelector('.action-buttons').appendChild(printBtn);
    */

    console.log('✨ Book deletion page initialized with enhanced safety features');
</script>
</body>
</html>
