<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Error - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --error-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
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
            animation: float 8s infinite ease-in-out;
        }

        .particle:nth-child(1) { width: 20px; height: 20px; left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 15px; height: 15px; left: 20%; animation-delay: 1s; }
        .particle:nth-child(3) { width: 25px; height: 25px; left: 30%; animation-delay: 2s; }
        .particle:nth-child(4) { width: 18px; height: 18px; left: 40%; animation-delay: 3s; }
        .particle:nth-child(5) { width: 22px; height: 22px; left: 50%; animation-delay: 4s; }
        .particle:nth-child(6) { width: 16px; height: 16px; left: 60%; animation-delay: 5s; }
        .particle:nth-child(7) { width: 24px; height: 24px; left: 70%; animation-delay: 6s; }
        .particle:nth-child(8) { width: 19px; height: 19px; left: 80%; animation-delay: 7s; }
        .particle:nth-child(9) { width: 21px; height: 21px; left: 90%; animation-delay: 8s; }

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

        .error-hero {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 30px;
            padding: 4rem 3rem;
            box-shadow: var(--card-shadow);
            max-width: 700px;
            width: 100%;
            position: relative;
            overflow: hidden;
            animation: slideInDown 0.8s ease-out;
        }

        .error-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: rotate 10s linear infinite;
        }

        .error-hero-content {
            position: relative;
            z-index: 2;
        }

        .error-icon {
            font-size: 6rem;
            margin-bottom: 2rem;
            color: #fff;
            text-shadow: 0 0 30px rgba(255,255,255,0.8);
            animation: pulse 2s ease-in-out infinite;
            display: inline-block;
        }

        .error-code {
            font-size: 5rem;
            font-weight: 900;
            background: var(--error-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 0;
            animation: bounceIn 0.8s ease-out;
            text-shadow: 0 4px 20px rgba(250, 112, 154, 0.3);
        }

        .error-title {
            font-size: 2.5rem;
            color: white;
            margin: 1.5rem 0;
            font-weight: 700;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            animation: fadeInUp 0.8s ease-out 0.2s both;
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
            gap: 1.5rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 3rem;
            animation: fadeInUp 0.8s ease-out 0.6s both;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            min-width: 160px;
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
            background: var(--success-gradient);
            color: white;
        }

        .btn-secondary {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: white;
            border: 1px solid var(--glass-border);
        }

        .btn-danger {
            background: var(--error-gradient);
            color: white;
        }

        .error-details-section {
            display: grid;
            gap: 2rem;
            width: 100%;
            max-width: 700px;
            margin-top: 2rem;
            animation: slideInUp 0.8s ease-out 0.8s both;
        }

        .error-details, .error-technical {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 2rem;
            color: white;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .error-details:hover, .error-technical:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .error-details::before, .error-technical::before {
            content: '';
            position: absolute;
            top: -100%;
            left: -100%;
            width: 300%;
            height: 300%;
            background: radial-gradient(circle, rgba(255,255,255,0.05) 0%, transparent 70%);
            animation: rotate 15s linear infinite;
        }

        .details-content {
            position: relative;
            z-index: 2;
            text-align: left;
        }

        .details-grid {
            display: grid;
            grid-template-columns: auto 1fr;
            gap: 1rem;
            align-items: center;
        }

        .detail-label {
            font-weight: 700;
            color: rgba(255,255,255,0.8);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .detail-value {
            color: white;
            font-size: 1rem;
            word-break: break-all;
        }

        .error-technical h4 {
            margin: 0 0 1.5rem 0;
            color: white;
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .error-technical ul {
            margin: 1rem 0;
            padding-left: 1.5rem;
            color: rgba(255,255,255,0.9);
        }

        .error-technical li {
            margin-bottom: 0.75rem;
            line-height: 1.6;
        }

        .error-technical pre {
            background: rgba(0,0,0,0.2);
            padding: 1rem;
            border-radius: 10px;
            margin: 1rem 0;
            font-size: 0.85rem;
            white-space: pre-wrap;
            word-break: break-all;
            border-left: 4px solid #fa709a;
            color: rgba(255,255,255,0.9);
        }

        .tech-info {
            background: rgba(67, 233, 123, 0.1);
            border-left: 4px solid #43e97b;
            padding: 1rem;
            border-radius: 0 10px 10px 0;
            margin: 1rem 0;
        }

        .suggestions-box {
            background: rgba(79, 172, 254, 0.1);
            border-left: 4px solid #4facfe;
            padding: 1.5rem;
            border-radius: 0 15px 15px 0;
            margin-top: 1rem;
        }

        /* Loading animation for buttons */
        .btn.loading {
            pointer-events: none;
            position: relative;
        }

        .btn.loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            right: 15px;
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
                transform: scale(1.05);
            }
            70% {
                transform: scale(0.9);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
                text-shadow: 0 0 30px rgba(255,255,255,0.8);
            }
            50% {
                transform: scale(1.05);
                text-shadow: 0 0 40px rgba(255,255,255,1);
            }
            100% {
                transform: scale(1);
                text-shadow: 0 0 30px rgba(255,255,255,0.8);
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

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .error-hero {
                padding: 3rem 2rem;
                margin: 1rem;
            }

            .error-code {
                font-size: 3.5rem;
            }

            .error-title {
                font-size: 2rem;
            }

            .error-message {
                font-size: 1.1rem;
            }

            .error-actions {
                flex-direction: column;
                gap: 1rem;
            }

            .btn {
                min-width: auto;
                width: 100%;
            }

            .details-grid {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }

            .particles {
                display: none;
            }
        }

        /* Enhanced effects */
        .glow {
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from {
                box-shadow: 0 0 20px rgba(255,255,255,0.2);
            }
            to {
                box-shadow: 0 0 30px rgba(255,255,255,0.4);
            }
        }

        .error-icon:hover {
            animation: shake 0.5s ease-in-out;
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
</div>

<div class="error-container">
    <div class="error-hero glow">
        <div class="error-hero-content">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h1 class="error-code">500</h1>
            <h2 class="error-title">
                <i class="fas fa-server"></i>
                Internal Server Error
            </h2>
            <p class="error-message">
                <i class="fas fa-heart-broken"></i>
                Oops! Something went wrong on our server. We're sorry for the inconvenience.
                Our technical team has been notified and is working to fix this issue.
            </p>

            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">
                    <i class="fas fa-home"></i>
                    Go to Dashboard
                </a>
                <a href="javascript:location.reload()" class="btn btn-secondary">
                    <i class="fas fa-redo-alt"></i>
                    Try Again
                </a>
                <a href="${pageContext.request.contextPath}/jsp/help.jsp" class="btn btn-danger">
                    <i class="fas fa-life-ring"></i>
                    Get Help
                </a>
            </div>
        </div>
    </div>

    <div class="error-details-section">
        <div class="error-details">
            <div class="details-content">
                <h3>
                    <i class="fas fa-info-circle"></i>
                    Error Information
                </h3>
                <div class="details-grid">
                    <span class="detail-label">
                        <i class="fas fa-fingerprint"></i>
                        Error ID:
                    </span>
                    <span class="detail-value"><%= System.currentTimeMillis() %></span>

                    <span class="detail-label">
                        <i class="fas fa-clock"></i>
                        Time:
                    </span>
                    <span class="detail-value"><%= new java.util.Date() %></span>

                    <span class="detail-label">
                        <i class="fas fa-user-shield"></i>
                        User:
                    </span>
                    <span class="detail-value"><%= session != null && session.getAttribute("adminUser") != null ? "Logged in" : "Not logged in" %></span>

                    <span class="detail-label">
                        <i class="fas fa-link"></i>
                        Request URI:
                    </span>
                    <span class="detail-value"><%= request.getRequestURI() %></span>
                </div>
            </div>
        </div>

        <!-- Technical details (only show in development) -->
        <% if (exception != null) { %>
        <div class="error-technical">
            <div class="details-content">
                <h4>
                    <i class="fas fa-code"></i>
                    Technical Details
                </h4>
                <div class="tech-info">
                    <div class="details-grid">
                        <span class="detail-label">
                            <i class="fas fa-bug"></i>
                            Exception:
                        </span>
                        <span class="detail-value"><%= exception.getClass().getSimpleName() %></span>

                        <span class="detail-label">
                            <i class="fas fa-comment-alt"></i>
                            Message:
                        </span>
                        <span class="detail-value"><%= exception.getMessage() != null ? exception.getMessage() : "No message available" %></span>
                    </div>
                    <% if (exception.getCause() != null) { %>
                    <div style="margin-top: 1rem;">
                        <strong><i class="fas fa-search"></i> Cause:</strong>
                        <span><%= exception.getCause().getMessage() %></span>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
        <% } %>

        <!-- Helpful suggestions -->
        <div class="error-technical">
            <div class="details-content">
                <h4>
                    <i class="fas fa-lightbulb"></i>
                    What you can do:
                </h4>
                <div class="suggestions-box">
                    <ul>
                        <li><i class="fas fa-sync-alt"></i> Try refreshing the page</li>
                        <li><i class="fas fa-sign-in-alt"></i> Check if you're still logged in</li>
                        <li><i class="fas fa-arrow-left"></i> Go back and try a different action</li>
                        <li><i class="fas fa-headset"></i> Contact support if the problem persists</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Initialize animations and interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Add hover effects to buttons
        const buttons = document.querySelectorAll('.btn');
        buttons.forEach(button => {
            button.addEventListener('click', function(e) {
                if (this.href && this.href.includes('reload')) {
                    e.preventDefault();
                    this.classList.add('loading');
                    setTimeout(() => {
                        location.reload();
                    }, 500);
                }

                // Ripple effect
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

        // Add floating animation to particles
        const particles = document.querySelectorAll('.particle');
        particles.forEach((particle, index) => {
            particle.style.top = Math.random() * 100 + '%';
            particle.style.animationDuration = (8 + Math.random() * 4) + 's';
            particle.style.opacity = Math.random() * 0.5 + 0.2;
        });

        // Error icon interactive effects
        const errorIcon = document.querySelector('.error-icon');
        if (errorIcon) {
            errorIcon.addEventListener('click', function() {
                this.style.animation = 'shake 0.5s ease-in-out';
                setTimeout(() => {
                    this.style.animation = 'pulse 2s ease-in-out infinite';
                }, 500);
            });
        }

        // Add glow effect to cards on hover
        const cards = document.querySelectorAll('.error-details, .error-technical');
        cards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.boxShadow = '0 0 40px rgba(255,255,255,0.3)';
            });

            card.addEventListener('mouseleave', function() {
                this.style.boxShadow = '';
            });
        });

        // Typewriter effect for error message
        const errorMessage = document.querySelector('.error-message');
        if (errorMessage) {
            const originalText = errorMessage.innerHTML;
            errorMessage.innerHTML = '<i class="fas fa-heart-broken"></i>';
            let i = 0;
            const fullText = originalText.substring(originalText.indexOf('>') + 1);

            const typeWriter = () => {
                if (i < fullText.length) {
                    errorMessage.innerHTML = '<i class="fas fa-heart-broken"></i>' + fullText.substring(0, i + 1);
                    i++;
                    setTimeout(typeWriter, 30);
                }
            };

            setTimeout(typeWriter, 1000);
        }

        console.log('✨ Error page animations initialized');
    });

    // Log error for debugging
    console.error('500 Error - Internal server error occurred');
    console.error('URL:', window.location.href);
    console.error('Time:', new Date().toISOString());

    <% if (exception != null) { %>
    console.error('Exception:', '<%= exception.getClass().getSimpleName() %>');
    console.error('Message:', '<%= exception.getMessage() != null ? exception.getMessage().replace("'", "\\'") : "No message" %>');
    <% } %>

    // Auto-refresh prompt with countdown
    let countdown = 30;
    const countdownInterval = setInterval(() => {
        countdown--;
        if (countdown <= 0) {
            clearInterval(countdownInterval);
            if (confirm('Would you like to try refreshing the page?')) {
                const refreshBtn = document.querySelector('a[href*="reload"]');
                if (refreshBtn) {
                    refreshBtn.click();
                } else {
                    location.reload();
                }
            }
        }
    }, 1000);

    // Add CSS for ripple animation
    const rippleStyle = document.createElement('style');
    rippleStyle.textContent = `
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        .btn {
            overflow: hidden;
        }

        /* Additional hover effects */
        .error-technical:hover::before {
            animation-duration: 8s;
        }

        .error-details:hover::before {
            animation-duration: 10s;
        }

        /* Smooth transitions */
        * {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* Focus states for accessibility */
        .btn:focus {
            outline: 3px solid rgba(255,255,255,0.5);
            outline-offset: 2px;
        }
    `;
    document.head.appendChild(rippleStyle);

    // Performance monitoring
    const performanceObserver = new PerformanceObserver((list) => {
        list.getEntries().forEach((entry) => {
            console.log('📊 Performance:', entry.name, entry.duration.toFixed(2) + 'ms');
        });
    });

    if ('PerformanceObserver' in window) {
        performanceObserver.observe({ entryTypes: ['navigation'] });
    }

    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        switch(e.key) {
            case 'r':
                if (e.ctrlKey || e.metaKey) {
                    e.preventDefault();
                    location.reload();
                }
                break;
            case 'h':
                if (e.ctrlKey || e.metaKey) {
                    e.preventDefault();
                    window.location.href = '${pageContext.request.contextPath}/dashboard';
                }
                break;
            case 'Escape':
                window.history.back();
                break;
        }
    });

    // Error recovery suggestions
    const recoverySuggestions = [
        'Try clearing your browser cache',
        'Check your internet connection',
        'Disable browser extensions temporarily',
        'Try using a different browser',
        'Contact system administrator'
    ];

    // Show random recovery tip after 10 seconds
    setTimeout(() => {
        const randomTip = recoverySuggestions[Math.floor(Math.random() * recoverySuggestions.length)];
        console.log('💡 Recovery tip:', randomTip);
    }, 10000);

    console.log('🎨 Modern error page loaded successfully');
</script>
</body>
</html>
