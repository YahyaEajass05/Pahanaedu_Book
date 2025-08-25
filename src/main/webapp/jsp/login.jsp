<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - BookStore Pro Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* Modern BookStore Theme */
        :root {
            --primary-color: #6366F1;
            --primary-dark: #4F46E5;
            --primary-light: #818CF8;
            --secondary-color: #EC4899;
            --accent-color: #14B8A6;
            --success-color: #10B981;
            --warning-color: #F59E0B;
            --danger-color: #EF4444;
            --info-color: #3B82F6;

            --bg-primary: #0F172A;
            --bg-secondary: #1E293B;
            --bg-card: #334155;
            --text-primary: #F1F5F9;
            --text-secondary: #94A3B8;
            --border-color: #475569;

            --gradient-primary: linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%);
            --gradient-secondary: linear-gradient(135deg, #EC4899 0%, #F472B6 100%);
            --gradient-dark: linear-gradient(135deg, #1E293B 0%, #334155 100%);
            --gradient-success: linear-gradient(135deg, #10B981 0%, #14B8A6 100%);
            --gradient-danger: linear-gradient(135deg, #EF4444 0%, #F87171 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        /* Animated Background */
        .bg-wrapper {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .bg-gradient {
            position: absolute;
            width: 150%;
            height: 150%;
            top: -25%;
            left: -25%;
            background: radial-gradient(circle at 20% 50%, rgba(99, 102, 241, 0.3) 0%, transparent 40%),
            radial-gradient(circle at 80% 80%, rgba(236, 72, 153, 0.3) 0%, transparent 40%),
            radial-gradient(circle at 40% 20%, rgba(20, 184, 166, 0.3) 0%, transparent 40%);
            animation: bgRotate 30s linear infinite;
        }

        @keyframes bgRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Floating Books Animation */
        .floating-books {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .book {
            position: absolute;
            font-size: 2rem;
            color: rgba(99, 102, 241, 0.2);
            animation: float 20s infinite ease-in-out;
        }

        .book:nth-child(1) { left: 10%; top: 20%; animation-delay: 0s; }
        .book:nth-child(2) { left: 70%; top: 80%; animation-delay: 5s; }
        .book:nth-child(3) { left: 30%; top: 60%; animation-delay: 10s; }
        .book:nth-child(4) { left: 90%; top: 10%; animation-delay: 15s; }
        .book:nth-child(5) { left: 50%; top: 30%; animation-delay: 7s; }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            33% { transform: translateY(-30px) rotate(10deg); }
            66% { transform: translateY(20px) rotate(-10deg); }
        }

        /* Login Container */
        .login-wrapper {
            display: flex;
            background: rgba(30, 41, 59, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 24px;
            overflow: hidden;
            width: 900px;
            max-width: 95vw;
            min-height: 500px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5),
            0 0 0 1px rgba(99, 102, 241, 0.1);
            animation: containerAppear 1s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @keyframes containerAppear {
            0% {
                opacity: 0;
                transform: scale(0.9) translateY(20px);
            }
            100% {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        /* Left Side - Illustration */
        .login-illustration {
            flex: 1;
            background: var(--gradient-primary);
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .illustration-content {
            text-align: center;
            z-index: 1;
            animation: illustrationFade 1s ease-out 0.5s both;
        }

        @keyframes illustrationFade {
            0% { opacity: 0; transform: translateY(30px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .illustration-icon {
            font-size: 6rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
            animation: bookPulse 3s ease-in-out infinite;
        }

        @keyframes bookPulse {
            0%, 100% { transform: scale(1) rotate(0deg); }
            50% { transform: scale(1.1) rotate(5deg); }
        }

        .illustration-title {
            font-size: 2rem;
            font-weight: 800;
            color: white;
            margin-bottom: 1rem;
        }

        .illustration-subtitle {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.6;
        }

        /* Right Side - Login Form */
        .login-form-section {
            flex: 1.2;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
            animation: headerSlide 1s ease-out 0.3s both;
        }

        @keyframes headerSlide {
            0% { opacity: 0; transform: translateX(30px); }
            100% { opacity: 1; transform: translateX(0); }
        }

        .logo {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
        }

        .logo-icon {
            width: 50px;
            height: 50px;
            background: var(--gradient-primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.5);
            animation: logoRotate 20s linear infinite;
        }

        @keyframes logoRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .logo-text {
            font-size: 1.75rem;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .login-subtitle {
            color: var(--text-secondary);
            font-size: 1rem;
        }

        /* Alert Messages */
        .alert {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 0.925rem;
            animation: alertBounce 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
        }

        @keyframes alertBounce {
            0% { transform: translateY(-100px) scale(0.8); opacity: 0; }
            80% { transform: translateY(5px) scale(1.02); }
            100% { transform: translateY(0) scale(1); opacity: 1; }
        }

        .alert::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: alertShine 1s ease-out;
        }

        @keyframes alertShine {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: var(--success-color);
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: var(--danger-color);
        }

        .alert-icon {
            font-size: 1.25rem;
            animation: iconSpin 0.5s ease-out;
        }

        @keyframes iconSpin {
            0% { transform: rotate(-180deg) scale(0); }
            100% { transform: rotate(0) scale(1); }
        }

        /* Form Styles */
        .login-form {
            animation: formFade 1s ease-out 0.5s both;
        }

        @keyframes formFade {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .form-group {
            margin-bottom: 1.75rem;
            position: relative;
        }

        .form-label {
            display: block;
            margin-bottom: 0.75rem;
            color: var(--text-primary);
            font-weight: 600;
            font-size: 0.925rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label i {
            color: var(--primary-color);
        }

        .input-wrapper {
            position: relative;
        }

        .form-input {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 3rem;
            background: rgba(51, 65, 85, 0.5);
            border: 2px solid transparent;
            border-radius: 12px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            background: rgba(51, 65, 85, 0.8);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1),
            0 0 20px rgba(99, 102, 241, 0.2);
            transform: translateY(-2px);
        }

        .form-input::placeholder {
            color: var(--text-secondary);
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            transition: all 0.3s ease;
        }

        .form-input:focus ~ .input-icon {
            color: var(--primary-color);
            transform: translateY(-50%) scale(1.1);
        }

        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            padding: 0.25rem;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .password-toggle:hover {
            color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
        }

        .error-message {
            display: block;
            color: var(--danger-color);
            font-size: 0.825rem;
            margin-top: 0.5rem;
            font-weight: 500;
            opacity: 0;
            animation: errorShake 0.5s ease-in-out;
        }

        .error-message.show {
            opacity: 1;
        }

        @keyframes errorShake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        /* Submit Button */
        .btn-submit {
            width: 100%;
            padding: 1rem;
            background: var(--gradient-primary);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px -5px rgba(99, 102, 241, 0.5);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px -5px rgba(99, 102, 241, 0.6);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .btn-submit:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .btn-content {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        /* Loading State */
        .loading-spinner {
            width: 18px;
            height: 18px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Footer */
        .login-footer {
            margin-top: 2rem;
            text-align: center;
            color: var(--text-secondary);
            font-size: 0.875rem;
            animation: footerFade 1s ease-out 0.8s both;
        }

        @keyframes footerFade {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        .login-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .login-footer a:hover {
            color: var(--primary-light);
            text-decoration: underline;
        }

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.9);
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .loading-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        .loading-content {
            text-align: center;
            animation: loadingPulse 1.5s ease-in-out infinite;
        }

        @keyframes loadingPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .loading-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            animation: bookFlip 1s ease-in-out infinite;
        }

        @keyframes bookFlip {
            0%, 100% { transform: rotateY(0); }
            50% { transform: rotateY(180deg); }
        }

        .loading-text {
            color: var(--text-primary);
            font-size: 1.25rem;
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
                width: 95%;
                max-width: 400px;
            }

            .login-illustration {
                padding: 2rem;
                min-height: 200px;
            }

            .illustration-icon {
                font-size: 4rem;
            }

            .login-form-section {
                padding: 2rem;
            }
        }

        /* Additional Effects */
        .glow {
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from { filter: drop-shadow(0 0 5px rgba(99, 102, 241, 0.5)); }
            to { filter: drop-shadow(0 0 20px rgba(99, 102, 241, 0.8)); }
        }
    </style>
</head>
<body>
<!-- Background Elements -->
<div class="bg-wrapper">
    <div class="bg-gradient"></div>
    <div class="floating-books">
        <i class="fas fa-book book"></i>
        <i class="fas fa-book-open book"></i>
        <i class="fas fa-bookmark book"></i>
        <i class="fas fa-book-reader book"></i>
        <i class="fas fa-books book"></i>
    </div>
</div>

<!-- Login Container -->
<div class="login-wrapper">
    <!-- Left Side - Illustration -->
    <div class="login-illustration">
        <div class="illustration-content">
            <div class="illustration-icon glow">
                <i class="fas fa-book-open"></i>
            </div>
            <h2 class="illustration-title">Welcome Back!</h2>
            <p class="illustration-subtitle">
                Your gateway to efficient bookstore management.<br>
                Organize, track, and grow your business.
            </p>
        </div>
    </div>

    <!-- Right Side - Login Form -->
    <div class="login-form-section">
        <div class="login-header">
            <div class="logo">
                <div class="logo-icon">
                    <i class="fas fa-book"></i>
                </div>
                <h1 class="logo-text">Pahana Edu </h1>
            </div>
            <p class="login-subtitle">Admin Portal Access</p>
        </div>

        <!-- Alert Messages -->
        <% if ("success".equals(request.getParameter("logout"))) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle alert-icon"></i>
            <span>You have been successfully logged out. See you next time!</span>
        </div>
        <% } %>

        <% if ("logout_failed".equals(request.getParameter("error"))) { %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle alert-icon"></i>
            <span>Logout failed. Please try again.</span>
        </div>
        <% } %>

        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-error">
            <i class="fas fa-times-circle alert-icon"></i>
            <span><%= request.getAttribute("errorMessage") %></span>
        </div>
        <% } %>

        <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle alert-icon"></i>
            <span><%= request.getAttribute("successMessage") %></span>
        </div>
        <% } %>

        <!-- Login Form -->
        <form action="login" method="post" class="login-form" id="loginForm">
            <input type="hidden" name="action" value="login">

            <div class="form-group">
                <label for="username" class="form-label">
                    <i class="fas fa-user-circle"></i>
                    Username
                </label>
                <div class="input-wrapper">
                    <input type="text"
                           id="username"
                           name="username"
                           class="form-input"
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                           placeholder="Enter your username"
                           required
                           autocomplete="username">
                    <i class="fas fa-user input-icon"></i>
                </div>
                <span class="error-message" id="usernameError"></span>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">
                    <i class="fas fa-key"></i>
                    Password
                </label>
                <div class="input-wrapper">
                    <input type="password"
                           id="password"
                           name="password"
                           class="form-input"
                           placeholder="Enter your password"
                           required
                           autocomplete="current-password">
                    <i class="fas fa-lock input-icon"></i>
                    <button type="button" class="password-toggle" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <span class="error-message" id="passwordError"></span>
            </div>

            <button type="submit" class="btn-submit" id="loginBtn">
                    <span class="btn-content" id="btnText">
                        <i class="fas fa-sign-in-alt"></i>
                        Sign In
                    </span>
                <span class="btn-content" id="btnLoading" style="display: none;">
                        <div class="loading-spinner"></div>
                        Authenticating...
                    </span>
            </button>
        </form>

        <div class="login-footer">
            <p>© 2025 Pahana Edu  Management System</p>
            <p>Version 2.0 | <a href="#">Help & Support</a></p>
        </div>
    </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-content">
        <div class="loading-icon">
            <i class="fas fa-book"></i>
        </div>
        <div class="loading-text">Verifying Credentials...</div>
    </div>
</div>

<script>
    // Auto-hide alerts
    document.addEventListener('DOMContentLoaded', function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.animation = 'alertBounce 0.5s reverse';
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 500);
            }, 5000);
        });

        // Focus on first empty field
        const usernameField = document.getElementById('username');
        const passwordField = document.getElementById('password');
        if (!usernameField.value) {
            usernameField.focus();
        } else {
            passwordField.focus();
        }
    });

    // Password toggle
    document.getElementById('togglePassword').addEventListener('click', function() {
        const passwordField = document.getElementById('password');
        const icon = this.querySelector('i');

        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            passwordField.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    });

    // Form submission
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();
        const usernameError = document.getElementById('usernameError');
        const passwordError = document.getElementById('passwordError');

        // Reset errors
        usernameError.textContent = '';
        usernameError.classList.remove('show');
        passwordError.textContent = '';
        passwordError.classList.remove('show');

        let hasError = false;

        // Validation
        if (!username) {
            usernameError.textContent = 'Username is required';
            usernameError.classList.add('show');
            hasError = true;
        } else if (username.length < 3) {
            usernameError.textContent = 'Username must be at least 3 characters';
            usernameError.classList.add('show');
            hasError = true;
        }

        if (!password) {
            passwordError.textContent = 'Password is required';
            passwordError.classList.add('show');
            hasError = true;
        } else if (password.length < 4) {
            passwordError.textContent = 'Password must be at least 4 characters';
            passwordError.classList.add('show');
            hasError = true;
        }

        if (hasError) {
            e.preventDefault();
            return false;
        }

        // Show loading state
        document.getElementById('btnText').style.display = 'none';
        document.getElementById('btnLoading').style.display = 'flex';
        document.getElementById('loginBtn').disabled = true;
        document.getElementById('loadingOverlay').classList.add('active');
    });

    // Clear errors on input
    ['username', 'password'].forEach(fieldId => {
        document.getElementById(fieldId).addEventListener('input', function() {
            const error = document.getElementById(fieldId + 'Error');
            error.textContent = '';
            error.classList.remove('show');
        });
    });

    // Add ripple effect to button
    document.getElementById('loginBtn').addEventListener('mousedown', function(e) {
        const ripple = document.createElement('span');
        ripple.className = 'ripple';
        this.appendChild(ripple);

        const rect = this.getBoundingClientRect();
        const size = Math.max(rect.width, rect.height);
        const x = e.clientX - rect.left - size / 2;
        const y = e.clientY - rect.top - size / 2;

        ripple.style.width = ripple.style.height = size + 'px';
        ripple.style.left = x + 'px';
        ripple.style.top = y + 'px';

        setTimeout(() => ripple.remove(), 600);
    });
</script>

<style>
    /* Ripple effect */
    .ripple {
        position: absolute;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.5);
        transform: scale(0);
        animation: ripple 0.6s ease-out;
    }

    @keyframes ripple {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }
</style>
</body>
</html>
