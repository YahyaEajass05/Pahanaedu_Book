<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Pahana Edu </title>
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

            /* Dark Theme Colors */
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
            --gradient-danger: linear-gradient(135deg, #EF4444 0%, #F87171 100%);
            --gradient-success: linear-gradient(135deg, #10B981 0%, #14B8A6 100%);
            --gradient-dark: linear-gradient(135deg, #1E293B 0%, #334155 100%);
            --gradient-404: linear-gradient(135deg, #FF6B6B 0%, #4ECDC4 100%);

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
        .background-animation {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -2;
            background: var(--bg-primary);
        }

        .grid-background {
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

        /* Floating Books Background */
        .floating-books-bg {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            overflow: hidden;
        }

        .floating-book {
            position: absolute;
            color: rgba(99, 102, 241, 0.1);
            font-size: 3rem;
            animation: floatBook 15s infinite ease-in-out;
        }

        .floating-book:nth-child(1) { left: 5%; top: 10%; animation-delay: 0s; font-size: 4rem; }
        .floating-book:nth-child(2) { left: 85%; top: 20%; animation-delay: 3s; }
        .floating-book:nth-child(3) { left: 15%; top: 70%; animation-delay: 6s; font-size: 2.5rem; }
        .floating-book:nth-child(4) { left: 70%; top: 80%; animation-delay: 9s; }
        .floating-book:nth-child(5) { left: 45%; top: 40%; animation-delay: 12s; font-size: 3.5rem; }
        .floating-book:nth-child(6) { left: 25%; top: 30%; animation-delay: 15s; }
        .floating-book:nth-child(7) { left: 60%; top: 60%; animation-delay: 18s; font-size: 2.8rem; }

        @keyframes floatBook {
            0%, 100% {
                transform: translateY(0) rotate(0deg) scale(1);
                opacity: 0.1;
            }
            25% {
                transform: translateY(-30px) rotate(5deg) scale(1.1);
                opacity: 0.15;
            }
            50% {
                transform: translateY(20px) rotate(-5deg) scale(0.9);
                opacity: 0.1;
            }
            75% {
                transform: translateY(-15px) rotate(3deg) scale(1.05);
                opacity: 0.12;
            }
        }

        /* Main Container */
        .error-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 2rem;
            position: relative;
            z-index: 1;
        }

        /* 404 Display */
        .error-404 {
            text-align: center;
            margin-bottom: 3rem;
            animation: slideDown 0.8s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-100px) scale(0.8);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .error-number {
            font-size: 12rem;
            font-weight: 900;
            line-height: 1;
            background: var(--gradient-404);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            position: relative;
            animation: glowPulse 3s ease-in-out infinite;
            text-shadow: 0 0 80px rgba(236, 72, 153, 0.5);
        }

        @keyframes glowPulse {
            0%, 100% {
                filter: brightness(1) drop-shadow(0 0 20px rgba(236, 72, 153, 0.5));
            }
            50% {
                filter: brightness(1.2) drop-shadow(0 0 40px rgba(236, 72, 153, 0.8));
            }
        }

        .error-number::before {
            content: '404';
            position: absolute;
            top: 5px;
            left: 5px;
            z-index: -1;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            opacity: 0.3;
        }

        /* Book Icon Animation */
        .book-icon-container {
            position: relative;
            margin: 2rem auto;
            width: 200px;
            height: 200px;
            animation: bookFloat 4s ease-in-out infinite;
        }

        @keyframes bookFloat {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            25% { transform: translateY(-20px) rotate(-5deg); }
            75% { transform: translateY(10px) rotate(5deg); }
        }

        .main-book-icon {
            font-size: 8rem;
            color: var(--primary-color);
            filter: drop-shadow(0 10px 30px rgba(99, 102, 241, 0.5));
            animation: bookOpen 3s ease-in-out infinite;
        }

        @keyframes bookOpen {
            0%, 100% { transform: rotateY(0); }
            50% { transform: rotateY(20deg); }
        }

        .orbiting-icons {
            position: absolute;
            width: 100%;
            height: 100%;
            animation: orbit 10s linear infinite;
        }

        @keyframes orbit {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .orbit-icon {
            position: absolute;
            font-size: 1.5rem;
            color: var(--secondary-color);
            animation: counterOrbit 10s linear infinite;
        }

        @keyframes counterOrbit {
            from { transform: rotate(0deg); }
            to { transform: rotate(-360deg); }
        }

        .orbit-icon:nth-child(1) { top: 0; left: 50%; transform: translateX(-50%); }
        .orbit-icon:nth-child(2) { top: 50%; right: 0; transform: translateY(-50%); }
        .orbit-icon:nth-child(3) { bottom: 0; left: 50%; transform: translateX(-50%); }
        .orbit-icon:nth-child(4) { top: 50%; left: 0; transform: translateY(-50%); }

        /* Error Content */
        .error-content {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 24px;
            padding: 3rem;
            max-width: 600px;
            width: 100%;
            text-align: center;
            box-shadow: var(--shadow-xl);
            animation: fadeInScale 0.8s ease-out 0.3s both;
        }

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .error-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .error-message {
            color: var(--text-secondary);
            font-size: 1.125rem;
            line-height: 1.8;
            margin-bottom: 2rem;
        }

        /* Action Buttons */
        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
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
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
            box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.5);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px -5px rgba(99, 102, 241, 0.6);
        }

        .btn-secondary {
            background: rgba(51, 65, 85, 0.8);
            color: white;
            border: 1px solid rgba(99, 102, 241, 0.3);
        }

        .btn-secondary:hover {
            background: rgba(51, 65, 85, 1);
            transform: translateY(-2px);
            border-color: var(--primary-color);
            box-shadow: 0 10px 20px -5px rgba(0, 0, 0, 0.5);
        }

        /* Quick Links */
        .quick-links {
            margin-top: 3rem;
            animation: slideUp 0.8s ease-out 0.6s both;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .quick-links-title {
            text-align: center;
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            color: var(--text-primary);
        }

        .links-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .link-card {
            background: rgba(30, 41, 59, 0.6);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(99, 102, 241, 0.1);
            border-radius: 16px;
            padding: 1.5rem;
            text-decoration: none;
            color: var(--text-primary);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 1rem;
            position: relative;
            overflow: hidden;
        }

        .link-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(99, 102, 241, 0.1), transparent);
            transition: left 0.5s;
        }

        .link-card:hover::after {
            left: 100%;
        }

        .link-card:hover {
            transform: translateY(-5px) scale(1.02);
            border-color: var(--primary-color);
            box-shadow: 0 10px 30px -10px rgba(99, 102, 241, 0.5);
        }

        .link-icon {
            width: 50px;
            height: 50px;
            background: var(--gradient-primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            flex-shrink: 0;
            transition: all 0.3s ease;
        }

        .link-card:hover .link-icon {
            transform: rotate(360deg) scale(1.1);
        }

        .link-content h3 {
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .link-content p {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        /* Fun Message */
        .fun-message {
            margin-top: 3rem;
            text-align: center;
            color: var(--text-muted);
            font-size: 0.875rem;
            animation: fadeIn 1s ease-out 1s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Animated Notification */
        .notification-toast {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: var(--gradient-primary);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            box-shadow: var(--shadow-xl);
            animation: notificationSlide 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 1000;
        }

        @keyframes notificationSlide {
            from {
                transform: translateX(400px);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .notification-icon {
            font-size: 1.25rem;
            animation: bellRing 2s ease-in-out infinite;
        }

        @keyframes bellRing {
            0%, 100% { transform: rotate(0); }
            5%, 15% { transform: rotate(-10deg); }
            10%, 20% { transform: rotate(10deg); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .error-number {
                font-size: 8rem;
            }

            .error-content {
                padding: 2rem;
            }

            .error-title {
                font-size: 2rem;
            }

            .error-actions {
                flex-direction: column;
                width: 100%;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .links-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Easter Egg */
        .easter-egg {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0);
            font-size: 5rem;
            z-index: 9999;
            animation: easterEggPop 1s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @keyframes easterEggPop {
            0% { transform: translate(-50%, -50%) scale(0) rotate(0); }
            50% { transform: translate(-50%, -50%) scale(1.2) rotate(180deg); }
            100% { transform: translate(-50%, -50%) scale(1) rotate(360deg); }
        }
    </style>
</head>
<body>
<!-- Animated Background -->
<div class="background-animation">
    <div class="grid-background"></div>
</div>

<!-- Floating Books Background -->
<div class="floating-books-bg">
    <i class="fas fa-book floating-book"></i>
    <i class="fas fa-book-open floating-book"></i>
    <i class="fas fa-bookmark floating-book"></i>
    <i class="fas fa-book-reader floating-book"></i>
    <i class="fas fa-atlas floating-book"></i>
    <i class="fas fa-journal-whills floating-book"></i>
    <i class="fas fa-bible floating-book"></i>
</div>

<!-- Main Content -->
<div class="error-container">
    <!-- 404 Display -->
    <div class="error-404">
        <div class="error-number">404</div>
        <div class="book-icon-container">
            <i class="fas fa-book-open main-book-icon"></i>
            <div class="orbiting-icons">
                <i class="fas fa-question orbit-icon"></i>
                <i class="fas fa-search orbit-icon"></i>
                <i class="fas fa-exclamation orbit-icon"></i>
                <i class="fas fa-times orbit-icon"></i>
            </div>
        </div>
    </div>

    <!-- Error Content -->
    <div class="error-content">
        <h1 class="error-title">Page Not Found</h1>
        <p class="error-message">
            Looks like this page took a permanent vacation to the fiction section!
            The page you're looking for has mysteriously disappeared from our shelves.
            Let's get you back to familiar territory.
        </p>

        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">
                <i class="fas fa-home"></i>
                Back to Dashboard
            </a>
            <a href="javascript:history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>
                Previous Page
            </a>
        </div>
    </div>

    <!-- Quick Links -->
    <div class="quick-links">
        <h2 class="quick-links-title">Popular Destinations</h2>
        <div class="links-grid">
            <a href="${pageContext.request.contextPath}/dashboard" class="link-card">
                <div class="link-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="link-content">
                    <h3>Dashboard</h3>
                    <p>View your store analytics</p>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/item" class="link-card">
                <div class="link-icon">
                    <i class="fas fa-books"></i>
                </div>
                <div class="link-content">
                    <h3>Inventory</h3>
                    <p>Manage your book collection</p>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/bill" class="link-card">
                <div class="link-icon">
                    <i class="fas fa-cash-register"></i>
                </div>
                <div class="link-content">
                    <h3>Billing</h3>
                    <p>Process customer transactions</p>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/customer" class="link-card">
                <div class="link-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="link-content">
                    <h3>Customers</h3>
                    <p>View customer information</p>
                </div>
            </a>
        </div>
    </div>

    <!-- Fun Message -->
    <div class="fun-message">
        <p>📚 Fun fact: Even in the digital age, getting lost in a good book is still the best adventure!</p>
    </div>
</div>

<!-- Notification Toast -->
<div class="notification-toast" id="notificationToast" style="display: none;">
    <i class="fas fa-info-circle notification-icon"></i>
    <span>Redirecting to dashboard in <span id="countdown">5</span> seconds...</span>
</div>

<script>
    // Page initialization
    document.addEventListener('DOMContentLoaded', function() {
        console.log('📚 404 Page loaded - Pahana Edu ');

        // Add stagger animation to link cards
        const linkCards = document.querySelectorAll('.link-card');
        linkCards.forEach((card, index) => {
            card.style.animationDelay = `${0.8 + (index * 0.1)}s`;
            card.style.animation = 'fadeInScale 0.6s ease-out both';
        });

        // Button ripple effect
        document.querySelectorAll('.btn').forEach(button => {
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
                        background: radial-gradient(circle, rgba(255,255,255,0.5) 0%, transparent 70%);
                        border-radius: 50%;
                        transform: scale(0);
                        animation: rippleEffect 0.6s ease-out;
                        pointer-events: none;
                    `;

                this.appendChild(ripple);
                setTimeout(() => ripple.remove(), 600);
            });
        });

        // Auto-redirect with countdown
        let redirectTimeout;
        let countdownInterval;
        let seconds = 5;

        function startRedirectCountdown() {
            const toast = document.getElementById('notificationToast');
            const countdownElement = document.getElementById('countdown');

            setTimeout(() => {
                toast.style.display = 'flex';

                countdownInterval = setInterval(() => {
                    seconds--;
                    countdownElement.textContent = seconds;

                    if (seconds <= 0) {
                        clearInterval(countdownInterval);
                        window.location.href = '${pageContext.request.contextPath}/dashboard';
                    }
                }, 1000);
            }, 3000);
        }

        // Start countdown
        startRedirectCountdown();

        // Cancel redirect on user interaction
        ['click', 'keydown', 'touchstart'].forEach(event => {
            document.addEventListener(event, function() {
                if (countdownInterval) {
                    clearInterval(countdownInterval);
                    clearTimeout(redirectTimeout);
                    const toast = document.getElementById('notificationToast');
                    if (toast) {
                        toast.style.animation = 'notificationSlide 0.5s reverse';
                        setTimeout(() => {
                            toast.style.display = 'none';
                        }, 500);
                    }
                }
            }, { once: true });
        });

        // Easter egg - Konami code
        const konamiCode = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a'];
        let konamiIndex = 0;

        document.addEventListener('keydown', function(e) {
            if (e.key === konamiCode[konamiIndex]) {
                konamiIndex++;
                if (konamiIndex === konamiCode.length) {
                    activateEasterEgg();
                    konamiIndex = 0;
                }
            } else {
                konamiIndex = 0;
            }
        });

        function activateEasterEgg() {
            const egg = document.createElement('div');
            egg.className = 'easter-egg';
            egg.innerHTML = '🎉';
            document.body.appendChild(egg);

            // Rainbow background
            document.body.style.animation = 'rainbow 2s linear infinite';

            const style = document.createElement('style');
            style.textContent = `
                    @keyframes rainbow {
                        0% { filter: hue-rotate(0deg); }
                        100% { filter: hue-rotate(360deg); }
                    }
                    @keyframes rippleEffect {
                        to {
                            transform: scale(4);
                            opacity: 0;
                        }
                    }
                `;
            document.head.appendChild(style);

            setTimeout(() => {
                egg.remove();
                document.body.style.animation = '';
            }, 3000);
        }

        // Log error details
        console.error('404 Error Details:', {
            url: '<%= request.getRequestURL() %>',
            timestamp: new Date().toISOString(),
            userAgent: navigator.userAgent
        });
    });

    // Parallax effect on mouse move
    document.addEventListener('mousemove', function(e) {
        const books = document.querySelectorAll('.floating-book');
        const x = e.clientX / window.innerWidth;
        const y = e.clientY / window.innerHeight;

        books.forEach((book, index) => {
            const speed = (index + 1) * 0.5;
            const xOffset = (x - 0.5) * speed * 20;
            const yOffset = (y - 0.5) * speed * 20;
            book.style.transform = `translate(${xOffset}px, ${yOffset}px)`;
        });
    });
</script>
</body>
</html>
