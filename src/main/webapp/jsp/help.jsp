<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Center - Pahana Edu </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap');

        :root {
            /* Modern BookStore Color Palette */
            --primary-color: #6366F1;
            --primary-dark: #4F46E5;
            --primary-light: #818CF8;
            --secondary-color: #EC4899;
            --accent-color: #14B8A6;
            --success-color: #10B981;
            --warning-color: #F59E0B;
            --danger-color: #EF4444;
            --info-color: #3B82F6;

            /* Dark Theme */
            --bg-primary: #0F172A;
            --bg-secondary: #1E293B;
            --bg-card: #334155;
            --text-primary: #F1F5F9;
            --text-secondary: #94A3B8;
            --text-muted: #64748B;
            --border-color: #475569;

            /* Gradients */
            --gradient-primary: linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%);
            --gradient-secondary: linear-gradient(135deg, #EC4899 0%, #F472B6 100%);
            --gradient-success: linear-gradient(135deg, #10B981 0%, #14B8A6 100%);
            --gradient-warning: linear-gradient(135deg, #F59E0B 0%, #FCD34D 100%);
            --gradient-danger: linear-gradient(135deg, #EF4444 0%, #F87171 100%);
            --gradient-dark: linear-gradient(135deg, #1E293B 0%, #334155 100%);
            --gradient-glass: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0.05) 100%);

            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.2);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
            --shadow-glow: 0 0 20px rgba(99, 102, 241, 0.5);
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
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Animated Background */
        .bg-animation {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            overflow: hidden;
        }

        .bg-grid {
            position: absolute;
            width: 100%;
            height: 100%;
            background-image:
                    linear-gradient(rgba(99, 102, 241, 0.03) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(99, 102, 241, 0.03) 1px, transparent 1px);
            background-size: 50px 50px;
            animation: gridMove 20s linear infinite;
        }

        @keyframes gridMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(50px, 50px); }
        }

        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        .shape {
            position: absolute;
            background: var(--gradient-primary);
            opacity: 0.05;
            filter: blur(100px);
            border-radius: 50%;
            animation: floatShape 20s infinite ease-in-out;
        }

        .shape:nth-child(1) {
            width: 400px;
            height: 400px;
            top: -200px;
            left: -200px;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 300px;
            height: 300px;
            bottom: -150px;
            right: -150px;
            animation-delay: 5s;
            background: var(--gradient-secondary);
        }

        .shape:nth-child(3) {
            width: 250px;
            height: 250px;
            top: 50%;
            left: 50%;
            animation-delay: 10s;
            background: var(--gradient-success);
        }

        @keyframes floatShape {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(30px, -30px) scale(1.1); }
            66% { transform: translate(-20px, 20px) scale(0.9); }
        }

        /* Navigation */
        .navbar {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color);
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
            background: var(--gradient-primary);
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
        }

        .nav-link:hover {
            color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
        }

        .nav-link.active {
            color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
        }

        /* Main Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Hero Section */
        .hero-section {
            background: var(--gradient-primary);
            border-radius: 24px;
            padding: 4rem 3rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            animation: heroSlide 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @keyframes heroSlide {
            from {
                opacity: 0;
                transform: translateY(-50px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .hero-content {
            position: relative;
            z-index: 1;
            text-align: center;
            color: white;
        }

        .hero-icon {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            animation: iconFloat 3s ease-in-out infinite;
        }

        @keyframes iconFloat {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        .hero-title {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
            animation: titleGlow 2s ease-in-out infinite alternate;
        }

        @keyframes titleGlow {
            from { text-shadow: 0 0 20px rgba(255,255,255,0.5); }
            to { text-shadow: 0 0 30px rgba(255,255,255,0.8); }
        }

        .hero-subtitle {
            font-size: 1.25rem;
            opacity: 0.9;
        }

        /* Quick Navigation */
        .quick-nav {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .nav-card {
            background: rgba(30, 41, 59, 0.6);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 1.5rem;
            text-decoration: none;
            color: var(--text-primary);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: cardFadeIn 0.6s ease-out;
        }

        @keyframes cardFadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .nav-card:nth-child(1) { animation-delay: 0.1s; }
        .nav-card:nth-child(2) { animation-delay: 0.2s; }
        .nav-card:nth-child(3) { animation-delay: 0.3s; }
        .nav-card:nth-child(4) { animation-delay: 0.4s; }
        .nav-card:nth-child(5) { animation-delay: 0.5s; }
        .nav-card:nth-child(6) { animation-delay: 0.6s; }

        .nav-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(99, 102, 241, 0.2), transparent);
            transition: left 0.5s;
        }

        .nav-card:hover::before {
            left: 100%;
        }

        .nav-card:hover {
            transform: translateY(-5px) scale(1.02);
            border-color: var(--primary-color);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.3);
        }

        .nav-card-icon {
            width: 50px;
            height: 50px;
            background: var(--gradient-primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }

        .nav-card:hover .nav-card-icon {
            transform: rotate(360deg) scale(1.1);
        }

        .nav-card-title {
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .nav-card-desc {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        /* Content Sections */
        .help-section {
            background: rgba(30, 41, 59, 0.4);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            margin-bottom: 2rem;
            overflow: hidden;
            animation: sectionSlide 0.8s ease-out;
        }

        @keyframes sectionSlide {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .section-header {
            background: var(--gradient-dark);
            padding: 2rem;
            border-bottom: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .section-header::after {
            content: '';
            position: absolute;
            top: 0;
            right: -100px;
            width: 200px;
            height: 100%;
            background: rgba(99, 102, 241, 0.1);
            transform: skewX(-20deg);
            animation: headerShine 3s linear infinite;
        }

        @keyframes headerShine {
            from { right: -200px; }
            to { right: calc(100% + 200px); }
        }

        .section-title {
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 0;
        }

        .section-content {
            padding: 2rem;
        }

        .content-block {
            margin-bottom: 2rem;
        }

        .content-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Feature Cards */
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin: 1.5rem 0;
        }

        .feature-card {
            background: var(--gradient-primary);
            border-radius: 16px;
            padding: 1.5rem;
            color: white;
            position: relative;
            overflow: hidden;
            animation: featureBounce 0.6s ease-out;
        }

        @keyframes featureBounce {
            0% { transform: scale(0); }
            60% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: featureRotate 10s linear infinite;
        }

        @keyframes featureRotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .feature-icon {
            font-size: 2rem;
            margin-bottom: 1rem;
            display: inline-block;
            animation: iconPulse 2s ease-in-out infinite;
        }

        @keyframes iconPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        /* Alert Boxes */
        .alert-box {
            border-radius: 12px;
            padding: 1.5rem;
            margin: 1.5rem 0;
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            animation: alertSlide 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
        }

        @keyframes alertSlide {
            from {
                opacity: 0;
                transform: translateX(-100px) scale(0.8);
            }
            to {
                opacity: 1;
                transform: translateX(0) scale(1);
            }
        }

        .alert-info {
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.3);
            color: var(--info-color);
        }

        .alert-warning {
            background: rgba(245, 158, 11, 0.1);
            border: 1px solid rgba(245, 158, 11, 0.3);
            color: var(--warning-color);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: var(--success-color);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: var(--danger-color);
        }

        .alert-icon {
            font-size: 1.5rem;
            flex-shrink: 0;
            animation: alertIconBounce 0.6s ease-out;
        }

        @keyframes alertIconBounce {
            0% { transform: scale(0) rotate(-180deg); }
            50% { transform: scale(1.2) rotate(10deg); }
            100% { transform: scale(1) rotate(0deg); }
        }

        /* Shortcut Keys */
        .shortcut {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 6px;
            padding: 0.25rem 0.5rem;
            font-family: monospace;
            font-size: 0.875rem;
            color: var(--text-primary);
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            transition: all 0.2s ease;
        }

        .shortcut:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
            background: var(--primary-color);
            border-color: var(--primary-color);
        }

        /* Steps */
        .steps-list {
            counter-reset: step;
            margin: 1.5rem 0;
        }

        .step-item {
            counter-increment: step;
            margin-bottom: 1.5rem;
            padding-left: 3rem;
            position: relative;
            animation: stepFade 0.6s ease-out;
        }

        @keyframes stepFade {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .step-item::before {
            content: counter(step);
            position: absolute;
            left: 0;
            top: 0;
            width: 2rem;
            height: 2rem;
            background: var(--gradient-primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            animation: stepNumberPop 0.6s ease-out;
        }

        @keyframes stepNumberPop {
            0% { transform: scale(0) rotate(-360deg); }
            50% { transform: scale(1.2) rotate(180deg); }
            100% { transform: scale(1) rotate(0deg); }
        }

        /* Contact Section */
        .contact-section {
            background: var(--gradient-primary);
            border-radius: 20px;
            padding: 3rem;
            margin-top: 3rem;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
            animation: contactFloat 0.8s ease-out;
        }

        @keyframes contactFloat {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .contact-icon {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            animation: contactIconSpin 10s linear infinite;
        }

        @keyframes contactIconSpin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        /* Back to Top */
        .back-to-top {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 50px;
            height: 50px;
            background: var(--gradient-primary);
            color: white;
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            cursor: pointer;
            box-shadow: var(--shadow-lg);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .back-to-top.show {
            opacity: 1;
            visibility: visible;
            animation: backToTopBounce 0.6s ease-out;
        }

        @keyframes backToTopBounce {
            0% { transform: translateY(100px); }
            60% { transform: translateY(-20px); }
            100% { transform: translateY(0); }
        }

        .back-to-top:hover {
            transform: translateY(-5px) scale(1.1);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.5);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2rem;
            }

            .quick-nav {
                grid-template-columns: 1fr;
            }

            .navbar-nav {
                display: none;
            }

            .container {
                padding: 1rem;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-track {
            background: var(--bg-secondary);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--gradient-primary);
            border-radius: 5px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary-color);
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

<!-- Animated Background -->
<div class="bg-animation">
    <div class="bg-grid"></div>
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>
</div>

<!-- Navigation -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            <i class="fas fa-book"></i>
            Pahana Edu
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
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
            <li><a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link active">
                <i class="fas fa-question-circle"></i> Help
            </a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <div class="hero-icon">
                <i class="fas fa-headset"></i>
            </div>
            <h1 class="hero-title">Help Center</h1>
            <p class="hero-subtitle">Everything you need to master Pahana Edu </p>
        </div>
    </div>

    <!-- Quick Navigation -->
    <div class="quick-nav">
        <a href="#getting-started" class="nav-card">
            <div class="nav-card-icon">
                <i class="fas fa-rocket"></i>
            </div>
            <h3 class="nav-card-title">Getting Started</h3>
            <p class="nav-card-desc">Learn the basics and set up your bookstore</p>
        </a>

        <a href="#inventory" class="nav-card">
            <div class="nav-card-icon">
                <i class="fas fa-boxes"></i>
            </div>
            <h3 class="nav-card-title">Inventory Management</h3>
            <p class="nav-card-desc">Add, edit, and track your book collection</p>
        </a>

        <a href="#customers" class="nav-card">
            <div class="nav-card-icon">
                <i class="fas fa-user-friends"></i>
            </div>
            <h3 class="nav-card-title">Customer Management</h3>
            <p class="nav-card-desc">Build and maintain customer relationships</p>
        </a>

        <a href="#billing" class="nav-card">
            <div class="nav-card-icon">
                <i class="fas fa-file-invoice-dollar"></i>
            </div>
            <h3 class="nav-card-title">Billing & Invoices</h3>
            <p class="nav-card-desc">Process sales and generate invoices</p>
        </a>

        <a href="#reports" class="nav-card">
            <div class="nav-card-icon">
                <i class="fas fa-chart-bar"></i>
            </div>
            <h3 class="nav-card-title">Reports & Analytics</h3>
            <p class="nav-card-desc">Track performance and make data-driven decisions</p>
        </a>

        <a href="#troubleshooting" class="nav-card">
            <div class="nav-card-icon">
                <i class="fas fa-tools"></i>
            </div>
            <h3 class="nav-card-title">Troubleshooting</h3>
            <p class="nav-card-desc">Solve common issues quickly</p>
        </a>
    </div>

    <!-- Content Sections -->
    <section id="getting-started" class="help-section">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-rocket"></i>
                Getting Started
            </h2>
        </div>
        <div class="section-content">
            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-star"></i> Welcome to Pahana Edu
                </h3>
                <p>Pahana Edu  is your complete solution for managing a modern bookstore. From inventory management to customer relationships and sales tracking, we've got you covered.</p>
            </div>

            <div class="feature-grid">
                <div class="feature-card">
                    <i class="fas fa-tachometer-alt feature-icon"></i>
                    <h4>Dashboard Overview</h4>
                    <p>Get real-time insights into your bookstore's performance with our intuitive dashboard.</p>
                </div>
                <div class="feature-card" style="background: var(--gradient-secondary);">
                    <i class="fas fa-book-open feature-icon"></i>
                    <h4>Quick Start Guide</h4>
                    <p>Set up your bookstore in minutes with our step-by-step onboarding process.</p>
                </div>
            </div>

            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-list-ol"></i> Initial Setup Steps
                </h3>
                <div class="steps-list">
                    <div class="step-item">
                        <strong>Login to Your Account</strong>
                        <p>Use your admin credentials to access the system</p>
                    </div>
                    <div class="step-item">
                        <strong>Add Your Book Inventory</strong>
                        <p>Start by adding your books with ISBN, titles, and prices</p>
                    </div>
                    <div class="step-item">
                        <strong>Set Up Customer Profiles</strong>
                        <p>Create customer accounts for better relationship management</p>
                    </div>
                    <div class="step-item">
                        <strong>Configure Billing Settings</strong>
                        <p>Set up tax rates, discounts, and payment methods</p>
                    </div>
                </div>
            </div>

            <div class="alert-box alert-info">
                <i class="fas fa-info-circle alert-icon"></i>
                <div>
                    <strong>Pro Tip:</strong> Start with a small batch of books to get familiar with the system before importing your entire inventory.
                </div>
            </div>
        </div>
    </section>

    <section id="inventory" class="help-section">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-boxes"></i>
                Inventory Management
            </h2>
        </div>
        <div class="section-content">
            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-plus-circle"></i> Adding New Books
                </h3>
                <p>Efficiently manage your book collection with our comprehensive inventory system:</p>
                <ul style="margin: 1rem 0; padding-left: 1.5rem;">
                    <li>Add books by ISBN for automatic details</li>
                    <li>Set custom pricing and discount rules</li>
                    <li>Track stock levels with low-stock alerts</li>
                    <li>Organize by categories and genres</li>
                </ul>
            </div>

            <div class="alert-box alert-warning">
                <i class="fas fa-exclamation-triangle alert-icon"></i>
                <div>
                    <strong>Important:</strong> Always maintain accurate stock levels to avoid overselling and customer disappointment.
                </div>
            </div>

            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-barcode"></i> ISBN Management
                </h3>
                <p>Use ISBN codes for quick and accurate book entry. The system supports both ISBN-10 and ISBN-13 formats.</p>
            </div>
        </div>
    </section>

    <section id="customers" class="help-section">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-user-friends"></i>
                Customer Management
            </h2>
        </div>
        <div class="section-content">
            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-user-plus"></i> Creating Customer Profiles
                </h3>
                <p>Build lasting relationships with your customers:</p>
            </div>

            <div class="feature-grid">
                <div class="feature-card" style="background: var(--gradient-success);">
                    <i class="fas fa-id-card feature-icon"></i>
                    <h4>Customer Information</h4>
                    <p>Store contact details, preferences, and purchase history</p>
                </div>
                <div class="feature-card" style="background: var(--gradient-warning);">
                    <i class="fas fa-gift feature-icon"></i>
                    <h4>Loyalty Programs</h4>
                    <p>Set up rewards and track customer loyalty points</p>
                </div>
            </div>

            <div class="alert-box alert-success">
                <i class="fas fa-check-circle alert-icon"></i>
                <div>
                    <strong>Best Practice:</strong> Always ask for customer consent before storing their personal information.
                </div>
            </div>
        </div>
    </section>

    <section id="billing" class="help-section">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-file-invoice-dollar"></i>
                Billing & Invoices
            </h2>
        </div>
        <div class="section-content">
            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-cash-register"></i> Processing Sales
                </h3>
                <p>Create professional invoices with just a few clicks:</p>

                <div class="steps-list">
                    <div class="step-item">
                        <strong>Select Customer</strong>
                        <p>Choose from existing customers or create a new profile</p>
                    </div>
                    <div class="step-item">
                        <strong>Add Books to Cart</strong>
                        <p>Search and add books by title, author, or ISBN</p>
                    </div>
                    <div class="step-item">
                        <strong>Apply Discounts</strong>
                        <p>Use automatic or manual discount options</p>
                    </div>
                    <div class="step-item">
                        <strong>Generate Invoice</strong>
                        <p>Print or email the invoice to your customer</p>
                    </div>
                </div>
            </div>

            <div class="alert-box alert-info">
                <i class="fas fa-calculator alert-icon"></i>
                <div>
                    <strong>Tax Calculation:</strong> The system automatically calculates taxes based on your configured rates.
                </div>
            </div>
        </div>
    </section>

    <section id="troubleshooting" class="help-section">
        <div class="section-header">
            <h2 class="section-title">
                <i class="fas fa-tools"></i>
                Troubleshooting
            </h2>
        </div>
        <div class="section-content">
            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-question-circle"></i> Common Issues
                </h3>
            </div>

            <div class="alert-box alert-danger">
                <i class="fas fa-times-circle alert-icon"></i>
                <div>
                    <strong>Login Issues:</strong> Clear your browser cache and ensure you're using the correct credentials.
                </div>
            </div>

            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-keyboard"></i> Keyboard Shortcuts
                </h3>
                <p>Speed up your workflow with these handy shortcuts:</p>
                <div style="display: flex; gap: 1rem; flex-wrap: wrap; margin-top: 1rem;">
                    <span class="shortcut"><kbd>Ctrl</kbd> + <kbd>N</kbd> New Invoice</span>
                    <span class="shortcut"><kbd>Ctrl</kbd> + <kbd>I</kbd> Inventory</span>
                    <span class="shortcut"><kbd>Ctrl</kbd> + <kbd>U</kbd> Customers</span>
                    <span class="shortcut"><kbd>Ctrl</kbd> + <kbd>D</kbd> Dashboard</span>
                    <span class="shortcut"><kbd>Ctrl</kbd> + <kbd>S</kbd> Save</span>
                    <span class="shortcut"><kbd>Esc</kbd> Cancel</span>
                </div>
            </div>

            <div class="content-block">
                <h3 class="content-title">
                    <i class="fas fa-exclamation-triangle"></i> Error Messages
                </h3>

                <div class="alert-box alert-danger" style="margin-bottom: 1rem;">
                    <i class="fas fa-ban alert-icon"></i>
                    <div>
                        <strong>Stock Error:</strong> "Insufficient stock" - The requested quantity exceeds available inventory.
                    </div>
                </div>

                <div class="alert-box alert-warning" style="margin-bottom: 1rem;">
                    <i class="fas fa-exclamation alert-icon"></i>
                    <div>
                        <strong>Duplicate Entry:</strong> "Item already exists" - Use a unique ISBN/ID for each book.
                    </div>
                </div>

                <div class="alert-box alert-info">
                    <i class="fas fa-info alert-icon"></i>
                    <div>
                        <strong>Session Timeout:</strong> "Session expired" - For security, you'll need to login again after 30 minutes of inactivity.
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Support -->
    <div class="contact-section">
        <div class="contact-icon">
            <i class="fas fa-life-ring"></i>
        </div>
        <h2>Still Need Help?</h2>
        <p style="font-size: 1.125rem; margin-bottom: 2rem;">Our support team is here to help you succeed</p>
        <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap;">
            <div>
                <i class="fas fa-envelope" style="margin-right: 0.5rem;"></i>
                support@bookstore.pro
            </div>
            <div>
                <i class="fas fa-phone" style="margin-right: 0.5rem;"></i>
                1-800-BOOKS-99
            </div>
            <div>
                <i class="fas fa-clock" style="margin-right: 0.5rem;"></i>
                Mon-Fri 9AM-6PM
            </div>
        </div>
    </div>
</div>

<!-- Back to Top Button -->
<button class="back-to-top" onclick="scrollToTop()">
    <i class="fas fa-arrow-up"></i>
</button>

<!-- Notification Toast Container -->
<div id="toastContainer" style="position: fixed; top: 20px; right: 20px; z-index: 9999;"></div>

<script>
    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        // Animate sections on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateX(0)';
                }
            });
        }, observerOptions);

        // Observe all sections
        document.querySelectorAll('.help-section').forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateX(-50px)';
            section.style.transition = 'all 0.6s ease-out';
            observer.observe(section);
        });

        // Smooth scrolling for navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    // Highlight target section
                    target.style.animation = 'highlightSection 1s ease-out';

                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });

                    // Show notification
                    showToast('Navigated to ' + this.querySelector('.nav-card-title').textContent, 'info');
                }
            });
        });

        // Initialize tooltips
        initializeTooltips();

        // Set up keyboard shortcuts
        setupKeyboardShortcuts();

        // Add click animation to cards
        addCardAnimations();

        // Initialize search functionality
        initializeSearch();

        // Show welcome message
        showToast('Welcome to Help Center! Use the navigation cards to explore.', 'success');
    });

    // Scroll to top functionality
    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
        showToast('Scrolled to top', 'info');
    }

    // Show/hide back to top button
    window.addEventListener('scroll', function() {
        const button = document.querySelector('.back-to-top');
        if (window.pageYOffset > 300) {
            button.classList.add('show');
        } else {
            button.classList.remove('show');
        }

        // Update progress indicator
        updateScrollProgress();
    });

    // Scroll progress indicator
    function updateScrollProgress() {
        const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
        const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
        const scrolled = (winScroll / height) * 100;

        // You can add a progress bar here if needed
    }

    // Toast notification system
    function showToast(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;
        toast.style.cssText = `
                background: ${type == 'success' ? 'var(--gradient-success)' :
                             type == 'error' ? 'var(--gradient-danger)' :
                             type == 'warning' ? 'var(--gradient-warning)' :
                             'var(--gradient-primary)'};
                color: white;
                padding: 1rem 1.5rem;
                border-radius: 12px;
                margin-bottom: 1rem;
                box-shadow: var(--shadow-lg);
                display: flex;
                align-items: center;
                gap: 0.75rem;
                min-width: 300px;
                animation: toastSlideIn 0.3s ease-out;
                position: relative;
                overflow: hidden;
            `;

        const icon = document.createElement('i');
        icon.className = `fas ${type == 'success' ? 'fa-check-circle' :
                                   type == 'error' ? 'fa-times-circle' :
                                   type == 'warning' ? 'fa-exclamation-triangle' :
                                   'fa-info-circle'}`;
        icon.style.fontSize = '1.25rem';
        const text = document.createElement('span');
        text.textContent = message;
        text.style.flex = '1';

        const closeBtn = document.createElement('button');
        closeBtn.innerHTML = '<i class="fas fa-times"></i>';
        closeBtn.style.cssText = `
                background: none;
                border: none;
                color: white;
                cursor: pointer;
                padding: 0.25rem;
                margin-left: 1rem;
                opacity: 0.8;
                transition: opacity 0.2s;
            `;
        closeBtn.onmouseover = () => closeBtn.style.opacity = '1';
        closeBtn.onmouseout = () => closeBtn.style.opacity = '0.8';
        closeBtn.onclick = () => removeToast(toast);

        toast.appendChild(icon);
        toast.appendChild(text);
        toast.appendChild(closeBtn);

        document.getElementById('toastContainer').appendChild(toast);

        // Auto remove after 5 seconds
        setTimeout(() => removeToast(toast), 5000);
    }

    function removeToast(toast) {
        toast.style.animation = 'toastSlideOut 0.3s ease-out';
        setTimeout(() => toast.remove(), 300);
    }

    // Keyboard shortcuts
    function setupKeyboardShortcuts() {
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                switch(e.key.toLowerCase()) {
                    case 'n':
                        e.preventDefault();
                        window.location.href = '${pageContext.request.contextPath}/bill?action=new';
                        break;
                    case 'i':
                        e.preventDefault();
                        window.location.href = '${pageContext.request.contextPath}/item';
                        break;
                    case 'u':
                        e.preventDefault();
                        window.location.href = '${pageContext.request.contextPath}/customer';
                        break;
                    case 'd':
                        e.preventDefault();
                        window.location.href = '${pageContext.request.contextPath}/dashboard';
                        break;
                    case '/':
                        e.preventDefault();
                        focusSearch();
                        break;
                    case 'h':
                        e.preventDefault();
                        showHelpDialog();
                        break;
                }
            }

            // ESC to close dialogs
            if (e.key === 'Escape') {
                closeAllDialogs();
            }
        });

        // Show shortcuts on hover
        document.querySelectorAll('.shortcut').forEach(shortcut => {
            shortcut.addEventListener('click', function() {
                const keys = this.textContent;
                showToast(`Shortcut: ${keys}`, 'info');

                // Animate the shortcut
                this.style.animation = 'shortcutPress 0.3s ease-out';
                setTimeout(() => this.style.animation = '', 300);
            });
        });
    }

    // Card animations
    function addCardAnimations() {
        document.querySelectorAll('.nav-card, .feature-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px) scale(1.02)';
            });

            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });

            card.addEventListener('click', function() {
                // Ripple effect
                const ripple = document.createElement('span');
                ripple.className = 'ripple';
                ripple.style.cssText = `
                        position: absolute;
                        background: rgba(255, 255, 255, 0.5);
                        border-radius: 50%;
                        transform: scale(0);
                        animation: rippleEffect 0.6s ease-out;
                        pointer-events: none;
                    `;
                this.style.position = 'relative';
                this.style.overflow = 'hidden';
                this.appendChild(ripple);

                // Position ripple at click point
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = event.clientX - rect.left - size / 2;
                const y = event.clientY - rect.top - size / 2;

                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';

                setTimeout(() => ripple.remove(), 600);
            });
        });
    }

    // Search functionality
    function initializeSearch() {
        // Create search overlay
        const searchOverlay = document.createElement('div');
        searchOverlay.id = 'searchOverlay';
        searchOverlay.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.9);
                display: none;
                align-items: center;
                justify-content: center;
                z-index: 9999;
                backdrop-filter: blur(10px);
            `;

        const searchBox = document.createElement('div');
        searchBox.style.cssText = `
                background: var(--bg-secondary);
                padding: 2rem;
                border-radius: 20px;
                width: 90%;
                max-width: 600px;
                animation: searchBoxAppear 0.3s ease-out;
            `;

        searchBox.innerHTML = `
                <h3 style="color: var(--text-primary); margin-bottom: 1rem;">
                    <i class="fas fa-search"></i> Search Help Topics
                </h3>
                <input type="text" id="helpSearchInput" placeholder="Type to search..."
                       style="width: 100%; padding: 1rem; border-radius: 10px;
                              border: 1px solid var(--border-color);
                              background: var(--bg-card); color: var(--text-primary);">
                <div id="searchResults" style="margin-top: 1rem; max-height: 400px; overflow-y: auto;"></div>
            `;

        searchOverlay.appendChild(searchBox);
        document.body.appendChild(searchOverlay);

        // Close on overlay click
        searchOverlay.addEventListener('click', function(e) {
            if (e.target === searchOverlay) {
                searchOverlay.style.display = 'none';
            }
        });
    }

    function focusSearch() {
        const overlay = document.getElementById('searchOverlay');
        overlay.style.display = 'flex';
        setTimeout(() => {
            document.getElementById('helpSearchInput').focus();
        }, 100);
    }

    // Tooltips
    function initializeTooltips() {
        const tooltipElements = document.querySelectorAll('[data-tooltip]');
        tooltipElements.forEach(elem => {
            elem.addEventListener('mouseenter', showTooltip);
            elem.addEventListener('mouseleave', hideTooltip);
        });
    }

    function showTooltip(e) {
        const tooltip = document.createElement('div');
        tooltip.className = 'tooltip';
        tooltip.textContent = e.target.getAttribute('data-tooltip');
        tooltip.style.cssText = `
                position: absolute;
                background: var(--bg-card);
                color: var(--text-primary);
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-size: 0.875rem;
                box-shadow: var(--shadow-lg);
                z-index: 1000;
                pointer-events: none;
                animation: tooltipFade 0.2s ease-out;
            `;

        document.body.appendChild(tooltip);

        const rect = e.target.getBoundingClientRect();
        tooltip.style.top = (rect.top - tooltip.offsetHeight - 10) + 'px';
        tooltip.style.left = (rect.left + rect.width / 2 - tooltip.offsetWidth / 2) + 'px';

        e.target._tooltip = tooltip;
    }

    function hideTooltip(e) {
        if (e.target._tooltip) {
            e.target._tooltip.remove();
            delete e.target._tooltip;
        }
    }

    // Help dialog
    function showHelpDialog() {
        showToast('Help dialog opened - Press ESC to close', 'info');
        focusSearch();
    }

    function closeAllDialogs() {
        document.getElementById('searchOverlay').style.display = 'none';
    }

    // Copy to clipboard
    document.querySelectorAll('.shortcut').forEach(shortcut => {
        shortcut.title = 'Click to copy';
        shortcut.style.cursor = 'pointer';

        shortcut.addEventListener('click', function() {
            const text = this.textContent;
            navigator.clipboard.writeText(text).then(() => {


                  showToast('Copied: ' + text, 'scess');

                  });
        });
                });

    // Print help section
    function printSection(sectionId) {
        const section = document.getElementById(sectionId);
        const printWindow = window.open('', '_blank');

        printWindow.document.write(`
        <html>
        <head>
            <title>Pahana Edu  - Help</title>
            <style>
                body { font-family: Arial, sans-serif; line-height: 1.6; padding: 20px; }
                h2 { color: #333; border-bottom: 2px solid #ddd; padding-bottom: 10px; }
                h3 { color: #555; margin-top: 20px; }
                .alert-box { padding: 15px; margin: 10px 0; border-radius: 5px; }
                .alert-info { background: #e3f2fd; color: #1976d2; }
                .alert-warning { background: #fff3cd; color: #856404; }
                .alert-danger { background: #f8d7da; color: #721c24; }
            </style>
        </head>
        <body>
            ${section.innerHTML}
            <script>window.onload = () => window.print();<\/script>
        </body>
        </html>
    `);

        printWindow.document.close();
    }

    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
    @keyframes toastSlideIn {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }

    @keyframes toastSlideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(400px);
            opacity: 0;
        }
    }

    @keyframes shortcutPress {
        0% { transform: scale(1); }
        50% { transform: scale(0.95); background: var(--primary-color); }
        100% { transform: scale(1); }
    }

    @keyframes highlightSection {
        0% { background: transparent; }
        50% { background: rgba(99, 102, 241, 0.1); }
        100% { background: transparent; }
    }

    @keyframes searchBoxAppear {
        from {
            opacity: 0;
            transform: scale(0.8);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }

    @keyframes tooltipFade {
        from {
            opacity: 0;
            transform: translateY(5px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @keyframes rippleEffect {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }

    .nav-card {
        position: relative;
        overflow: hidden;
    }

    /* Enhanced hover states */
    .content-title:hover {
        color: var(--primary-light);
        transform: translateX(5px);
        transition: all 0.3s ease;
    }

    .step-item:hover {
        background: rgba(99, 102, 241, 0.05);
        border-radius: 12px;
        padding-left: 3.5rem;
        transition: all 0.3s ease;
    }

    /* Smooth transitions for all interactive elements */
    * {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
`;
    document.head.appendChild(style);

    // Performance monitoring
    if ('PerformanceObserver' in window) {
        const perfObserver = new PerformanceObserver((list) => {
            for (const entry of list.getEntries()) {
                console.log('⚡ Performance:', entry.name, entry.duration.toFixed(2) + 'ms');
            }
        });
        perfObserver.observe({ entryTypes: ['navigation', 'resource'] });
    }

    // Log help page initialization
    console.log('📚 Pahana Edu  Help Center initialized successfully');
</script>