<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Pahana Edu</title>
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
            --card-shadow: 0 20px 60px rgba(0,0,0,0.15);
            --hover-shadow: 0 30px 80px rgba(0,0,0,0.25);
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        /* Animated background particles */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }

        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 12s infinite ease-in-out;
        }

        .particle:nth-child(1) { width: 30px; height: 30px; left: 5%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 20px; height: 20px; left: 15%; animation-delay: 2s; }
        .particle:nth-child(3) { width: 40px; height: 40px; left: 25%; animation-delay: 4s; }
        .particle:nth-child(4) { width: 25px; height: 25px; left: 35%; animation-delay: 6s; }
        .particle:nth-child(5) { width: 35px; height: 35px; left: 45%; animation-delay: 8s; }
        .particle:nth-child(6) { width: 18px; height: 18px; left: 55%; animation-delay: 10s; }
        .particle:nth-child(7) { width: 32px; height: 32px; left: 65%; animation-delay: 12s; }
        .particle:nth-child(8) { width: 28px; height: 28px; left: 75%; animation-delay: 14s; }
        .particle:nth-child(9) { width: 22px; height: 22px; left: 85%; animation-delay: 16s; }
        .particle:nth-child(10) { width: 36px; height: 36px; left: 95%; animation-delay: 18s; }

        .error-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            text-align: center;
            padding: 2rem;
            position: relative;
        }

        .error-main {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 30px;
            padding: 4rem;
            box-shadow: var(--card-shadow);
            max-width: 700px;
            width: 100%;
            position: relative;
            overflow: hidden;
            animation: slideInDown 0.8s ease-out;
        }

        .error-main::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg, transparent, rgba(250, 112, 154, 0.2), transparent);
            animation: rotate 20s linear infinite;
        }

        .error-content {
            position: relative;
            z-index: 2;
            color: white;
        }

        .error-icon-container {
            position: relative;
            margin-bottom: 2rem;
            animation: bounce 2s infinite;
        }

        .error-icon {
            font-size: 6rem;
            color: rgba(255,255,255,0.9);
            text-shadow: 0 0 30px rgba(255,255,255,0.5);
            animation: pulse 2s ease-in-out infinite;
        }

        .floating-icons {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            pointer-events: none;
        }

        .floating-icon {
            position: absolute;
            color: rgba(255,255,255,0.3);
            font-size: 1.5rem;
            animation: floatAround 8s infinite ease-in-out;
        }

        .floating-icon:nth-child(1) {
            top: -60px; left: -60px;
            animation-delay: 0s;
            animation-duration: 6s;
        }
        .floating-icon:nth-child(2) {
            top: -40px; right: -70px;
            animation-delay: 1s;
            animation-duration: 8s;
        }
        .floating-icon:nth-child(3) {
            bottom: -50px; left: -50px;
            animation-delay: 2s;
            animation-duration: 7s;
        }
        .floating-icon:nth-child(4) {
            bottom: -60px; right: -40px;
            animation-delay: 3s;
            animation-duration: 9s;
        }

        .error-code {
            font-size: 5rem;
            font-weight: 900;
            background: var(--danger-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 0;
            animation: bounceIn 0.8s ease-out;
            text-shadow: 0 4px 20px rgba(250, 112, 154, 0.3);
            position: relative;
        }

        .error-code::before {
            content: '404';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            z-index: -1;
            transform: translate(3px, 3px);
            opacity: 0.3;
        }

        .error-title {
            font-size: 2.5rem;
            color: white;
            margin: 2rem 0 1rem 0;
            font-weight: 800;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            animation: fadeInUp 0.8s ease-out 0.2s both;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .error-message {
            color: rgba(255,255,255,0.9);
            margin-bottom: 3rem;
            line-height: 1.8;
            font-size: 1.2rem;
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .error-actions {
            display: flex;
            gap: 2rem;
            justify-content: center;
            flex-wrap: wrap;
            animation: fadeInUp 0.8s ease-out 0.6s both;
        }

        .btn {
            padding: 1.2rem 3rem;
            border: none;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            font-size: 1.1rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            position: relative;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            min-width: 180px;
            justify-content: center;
        }

        .btn::before {
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

        .btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: var(--hover-shadow);
        }

        .btn-primary {
            background: var(--warning-gradient);
            color: white;
        }

        .btn-secondary {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: white;
            border: 1px solid var(--glass-border);
        }

        .error-details {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            margin-top: 3rem;
            padding: 2rem;
            color: rgba(255,255,255,0.9);
            animation: slideInUp 0.8s ease-out 0.8s both;
            position: relative;
            overflow: hidden;
        }

        .error-details::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.05) 0%, transparent 70%);
            animation: rotate 15s linear infinite;
        }

        .error-details-content {
            position: relative;
            z-index: 2;
        }

        .error-details h3 {
            margin: 0 0 1.5rem 0;
            color: white;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .detail-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1rem;
            padding: 1rem;
            background: rgba(255,255,255,0.05);
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            background: rgba(255,255,255,0.1);
            transform: translateX(5px);
        }

        .detail-item i {
            color: #43e97b;
            font-size: 1.2rem;
            margin-top: 0.2rem;
        }

        .detail-content {
            flex: 1;
        }

        .detail-label {
            font-weight: 700;
            color: white;
            margin-bottom: 0.25rem;
        }

        .detail-value {
            color: rgba(255,255,255,0.8);
            word-break: break-all;
            font-size: 0.95rem;
            line-height: 1.4;
        }

        /* Countdown Timer */
        .countdown-timer {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: var(--primary-gradient);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            box-shadow: var(--card-shadow);
            animation: slideInRight 0.5s ease-out 1s both;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .countdown-number {
            background: rgba(255,255,255,0.2);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            animation: pulse 1s infinite;
        }

        /* Search Suggestions */
        .suggestions-panel {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            margin-top: 3rem;
            box-shadow: var(--card-shadow);
            animation: slideInUp 0.8s ease-out 1s both;
            transition: all 0.3s ease;
        }

        .suggestions-panel:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .suggestions-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
            color: #2c3e50;
        }

        .suggestions-header h3 {
            margin: 0;
            font-size: 1.4rem;
            font-weight: 700;
        }

        .suggestion-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .suggestion-link {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            border-radius: 12px;
            text-decoration: none;
            color: #2c3e50;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            border-left: 4px solid #667eea;
        }

        .suggestion-link:hover {
            transform: translateX(5px) scale(1.02);
            background: linear-gradient(135deg, #e8f0ff 0%, #d0e0ff 100%);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
        }

        .suggestion-icon {
            width: 40px;
            height: 40px;
            background: var(--primary-gradient);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .suggestion-text h4 {
            margin: 0 0 0.25rem 0;
            font-weight: 600;
            font-size: 1rem;
        }

        .suggestion-text p {
            margin: 0;
            font-size: 0.85rem;
            color: #7f8c8d;
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

        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: scale(0.3);
            }
            50% {
                opacity: 1;
                transform: scale(1.1);
            }
            70% {
                transform: scale(0.9);
            }
            100% {
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
                transform: translateY(-100vh);
            }
        }

        @keyframes floatAround {
            0%, 100% {
                transform: translate(0, 0) rotate(0deg);
            }
            25% {
                transform: translate(20px, -20px) rotate(90deg);
            }
            50% {
                transform: translate(-15px, -10px) rotate(180deg);
            }
            75% {
                transform: translate(-25px, 15px) rotate(270deg);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .error-main {
                padding: 3rem 2rem;
                margin: 1rem;
            }

            .error-code {
                font-size: 4rem;
            }

            .error-title {
                font-size: 2rem;
                flex-direction: column;
                gap: 0.5rem;
            }

            .error-actions {
                flex-direction: column;
                align-items: center;
                gap: 1rem;
            }

            .btn {
                width: 100%;
                max-width: 300px;
            }

            .countdown-timer {
                bottom: 1rem;
                right: 1rem;
                font-size: 0.9rem;
            }

            .suggestion-links {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .error-icon {
                font-size: 4rem;
            }

            .error-code {
                font-size: 3rem;
            }

            .error-main {
                padding: 2rem 1.5rem;
            }
        }

        /* Focus states for accessibility */
        .btn:focus {
            outline: 3px solid rgba(255,255,255,0.5);
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
<!-- Animated background particles -->
<div class="particles">
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
</div>

<div class="error-container">
    <div class="error-main">
        <div class="error-content">
            <div class="error-icon-container">
                <div class="error-icon">
                    <i class="fas fa-search-minus"></i>
                </div>
                <div class="floating-icons">
                    <div class="floating-icon">
                        <i class="fas fa-question"></i>
                    </div>
                    <div class="floating-icon">
                        <i class="fas fa-exclamation"></i>
                    </div>
                    <div class="floating-icon">
                        <i class="fas fa-compass"></i>
                    </div>
                    <div class="floating-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                </div>
            </div>

            <h1 class="error-code">404</h1>

            <h2 class="error-title">
                <i class="fas fa-ghost"></i>
                Page Not Found
            </h2>

            <p class="error-message">
                Oops! It seems like this page has vanished into the digital void.
                The page you're looking for might have been moved, deleted, or perhaps never existed.
                Don't worry though - we'll help you find your way back!
            </p>

            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">
                    <i class="fas fa-home"></i>
                    Go to Dashboard
                </a>
                <a href="javascript:history.back()" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i>
                    Go Back
                </a>
            </div>
        </div>
    </div>

    <!-- Suggestions Panel -->
    <div class="suggestions-panel">
        <div class="suggestions-header">
            <i class="fas fa-lightbulb" style="color: #f39c12; font-size: 1.5rem;"></i>
            <h3>Where would you like to go?</h3>
        </div>
        <div class="suggestion-links">
            <a href="${pageContext.request.contextPath}/dashboard" class="suggestion-link">
                <div class="suggestion-icon">
                    <i class="fas fa-tachometer-alt"></i>
                </div>
                <div class="suggestion-text">
                    <h4>Dashboard</h4>
                    <p>Main overview and statistics</p>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/customer" class="suggestion-link">
                <div class="suggestion-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="suggestion-text">
                    <h4>Customers</h4>
                    <p>Manage customer accounts</p>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/item" class="suggestion-link">
                <div class="suggestion-icon">
                    <i class="fas fa-boxes"></i>
                </div>
                <div class="suggestion-text">
                    <h4>Items</h4>
                    <p>View and manage inventory</p>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/bill" class="suggestion-link">
                <div class="suggestion-icon">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
                <div class="suggestion-text">
                    <h4>Billing</h4>
                    <p>Generate and manage bills</p>
                </div>
            </a>
        </div>
    </div>

    <!-- Error Details -->
    <div class="error-details">
        <div class="error-details-content">
            <h3>
                <i class="fas fa-info-circle"></i>
                Technical Details
            </h3>

            <div class="detail-item">
                <i class="fas fa-link"></i>
                <div class="detail-content">
                    <div class="detail-label">Requested URL</div>
                    <div class="detail-value"><%= request.getRequestURL() %></div>
                </div>
            </div>

            <div class="detail-item">
                <i class="fas fa-clock"></i>
                <div class="detail-content">
                    <div class="detail-label">Timestamp</div>
                    <div class="detail-value"><%= new java.util.Date() %></div>
                </div>
            </div>

            <div class="detail-item">
                <i class="fas fa-desktop"></i>
                <div class="detail-content">
                    <div class="detail-label">User Agent</div>
                    <div class="detail-value"><%= request.getHeader("User-Agent") != null ? request.getHeader("User-Agent") : "Unknown" %></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Countdown Timer -->
    <div class="countdown-timer" id="countdownTimer" style="display: none;">
        <i class="fas fa-hourglass-half"></i>
        <span>Redirecting in</span>
        <div class="countdown-number" id="countdownNumber">10</div>
    </div>
</div>

<script>
    // Initialize animations and interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Add ripple effects to buttons
        const buttons = document.querySelectorAll('.btn');
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

        // Add hover effects to suggestion links
        const suggestionLinks = document.querySelectorAll('.suggestion-link');
        suggestionLinks.forEach((link, index) => {
            link.style.animationDelay = `${index * 0.1}s`;
            link.style.animation = 'fadeInUp 0.6s ease-out both';

            link.addEventListener('mouseenter', function() {
                this.querySelector('.suggestion-icon').style.transform = 'scale(1.1) rotate(5deg)';
            });

            link.addEventListener('mouseleave', function() {
                this.querySelector('.suggestion-icon').style.transform = 'scale(1) rotate(0deg)';
            });
        });

        // Animate particles
        const particles = document.querySelectorAll('.particle');
        particles.forEach((particle, index) => {
            particle.style.top = Math.random() * 100 + '%';
            particle.style.animationDelay = `${index * 2}s`;
            particle.style.animationDuration = `${8 + Math.random() * 8}s`;
        });

        console.log('✨ 404 page animations initialized');
    });

    // Enhanced auto-redirect with countdown
    let countdown = 10;
    const countdownTimer = document.getElementById('countdownTimer');
    const countdownNumber = document.getElementById('countdownNumber');

    // Show countdown after 3 seconds
    setTimeout(() => {
        countdownTimer.style.display = 'flex';
    }, 3000);

    const redirectTimer = setInterval(() => {
        countdown--;
        if (countdownNumber) {
            countdownNumber.textContent = countdown;
        }

        if (countdown <= 0) {
            clearInterval(redirectTimer);

            // Add farewell animation
            countdownTimer.innerHTML = '<i class="fas fa-rocket"></i> <span>Redirecting now...</span>';
            countdownTimer.style.animation = 'pulse 0.5s infinite';

            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/dashboard';
            }, 1000);
        }
    }, 1000);

    // Stop countdown on user interaction
    document.addEventListener('click', () => {
        clearInterval(redirectTimer);
        if (countdownTimer) {
            countdownTimer.style.display = 'none';
        }
    });

    document.addEventListener('keydown', () => {
        clearInterval(redirectTimer);
        if (countdownTimer) {
            countdownTimer.style.display = 'none';
        }
    });

    // Add CSS for ripple animation
    const additionalStyles = document.createElement('style');
    additionalStyles.textContent = `
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        .suggestion-icon {
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .btn {
            position: relative;
            overflow: hidden;
        }

        /* Enhanced focus effects */
        .suggestion-link:focus {
            outline: 3px solid rgba(102, 126, 234, 0.5);
            outline-offset: 2px;
        }

        /* Improved accessibility */
        @media (prefers-reduced-motion: reduce) {
            .floating-icons,
            .particles {
                display: none;
            }
        }
    `;
    document.head.appendChild(additionalStyles);

    // Log error for debugging
    console.error('404 Error - Page not found:', window.location.href);
    console.log('🔍 404 page loaded with enhanced animations');

    // Easter egg - Konami code
    let konamiCode = [];
    const konamiSequence = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'KeyB', 'KeyA'];

    document.addEventListener('keydown', function(e) {
        konamiCode.push(e.code);
        if (konamiCode.length > konamiSequence.length) {
            konamiCode.shift();
        }

        if (JSON.stringify(konamiCode) === JSON.stringify(konamiSequence)) {
            // Easter egg activated
            document.body.style.animation = 'rainbow 2s infinite';
            const style = document.createElement('style');
            style.textContent = `
                @keyframes rainbow {
                    0% { filter: hue-rotate(0deg); }
                    100% { filter: hue-rotate(360deg); }
                }
            `;
            document.head.appendChild(style);

            setTimeout(() => {
                document.body.style.animation = '';
            }, 10000);

            konamiCode = [];
        }
    });
</script>
</body>
</html>
