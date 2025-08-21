<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahana Edu Management System</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
    <!-- Font Awesome for beautiful icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* Complete UI Redesign with Modern Gradient Theme */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
            position: relative;
        }

        /* Animated Background Particles */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image:
                    radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 40% 80%, rgba(120, 219, 255, 0.3) 0%, transparent 50%);
            animation: backgroundMove 20s ease-in-out infinite;
        }

        @keyframes backgroundMove {
            0%, 100% { transform: translateX(0) translateY(0); }
            33% { transform: translateX(-30px) translateY(-50px); }
            66% { transform: translateX(20px) translateY(30px); }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow:
                    0 20px 40px rgba(0, 0, 0, 0.1),
                    0 15px 12px rgba(0, 0, 0, 0.08),
                    inset 0 1px 0 rgba(255, 255, 255, 0.1);
            width: 450px;
            max-width: 95vw;
            padding: 3rem 2.5rem;
            position: relative;
            z-index: 1;
            animation: slideInUp 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
            animation: fadeInDown 1s ease 0.3s both;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header h1 {
            font-size: 2.2rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
            position: relative;
        }

        .login-header h1::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        .login-header h2 {
            color: #6b7280;
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: #9ca3af;
            font-size: 0.95rem;
            font-weight: 400;
        }

        /* Alert Styles */
        .alert {
            padding: 1rem 1.2rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.9rem;
            font-weight: 500;
            animation: alertSlideIn 0.5s ease;
            transition: all 0.3s ease;
        }

        @keyframes alertSlideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-success {
            background: linear-gradient(135deg, #10b981, #065f46);
            color: white;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }

        .alert-error {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }

        .icon-success, .icon-error {
            font-size: 1.1rem;
            font-weight: bold;
        }

        /* Form Styles */
        .login-form-container {
            animation: fadeInUp 1s ease 0.5s both;
        }

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

        .form-group {
            margin-bottom: 1.8rem;
            animation: fadeInLeft 0.8s ease both;
        }

        .form-group:nth-child(1) { animation-delay: 0.6s; }
        .form-group:nth-child(2) { animation-delay: 0.7s; }
        .form-group:nth-child(3) { animation-delay: 0.8s; }

        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-group label {
            display: block;
            margin-bottom: 0.6rem;
            color: #374151;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .input-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-container input {
            width: 100%;
            padding: 1rem 1rem 1rem 3.2rem;
            border: 2px solid #e5e7eb;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 400;
            background: #f9fafb;
            transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            color: #374151;
        }

        .input-container input:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            color: #9ca3af;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            z-index: 2;
        }

        .input-container input:focus + .input-icon {
            color: #667eea;
            transform: scale(1.1);
        }

        .toggle-password {
            position: absolute;
            right: 1rem;
            background: none;
            border: none;
            color: #9ca3af;
            font-size: 1.1rem;
            cursor: pointer;
            padding: 0.2rem;
            border-radius: 6px;
            transition: all 0.3s ease;
            z-index: 2;
        }

        .toggle-password:hover {
            color: #667eea;
            background: rgba(102, 126, 234, 0.1);
            transform: scale(1.1);
        }

        .error-message {
            display: block;
            color: #ef4444;
            font-size: 0.85rem;
            margin-top: 0.5rem;
            font-weight: 500;
            min-height: 1.2rem;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        /* Button Styles */
        .btn-login {
            width: 100%;
            padding: 1.1rem 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-login::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transition: left 0.3s ease;
            z-index: 0;
        }

        .btn-login:hover::before {
            left: 0;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .btn-login:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .btn-text, .btn-loading {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .spinner {
            width: 18px;
            height: 18px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Login Help Section */
        .login-help {
            margin-top: 2.5rem;
            animation: fadeIn 1s ease 1s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .demo-credentials {
            background: linear-gradient(135deg, #f0f9ff, #e0f2fe);
            padding: 1.5rem;
            border-radius: 15px;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(56, 189, 248, 0.2);
            transition: all 0.3s ease;
        }

        .demo-credentials:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(56, 189, 248, 0.1);
        }

        .demo-credentials h4 {
            color: #0369a1;
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .demo-credentials h4::before {
            content: '🔑';
            font-size: 1.1rem;
        }

        .demo-credentials p {
            color: #0c4a6e;
            font-size: 0.9rem;
            margin-bottom: 0.4rem;
            font-weight: 500;
        }

        .demo-credentials strong {
            color: #1e40af;
        }

        .system-info {
            text-align: center;
            color: #9ca3af;
        }

        .system-info p {
            font-size: 0.85rem;
            margin-bottom: 0.3rem;
        }

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }

        .loading-spinner {
            text-align: center;
            color: white;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .spinner-large {
            width: 60px;
            height: 60px;
            border: 4px solid rgba(255, 255, 255, 0.3);
            border-top: 4px solid white;
            border-radius: 50%;
            margin: 0 auto 1rem;
            animation: spin 1s linear infinite;
        }

        .loading-spinner p {
            font-size: 1.1rem;
            font-weight: 500;
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .login-container {
                padding: 2rem 1.5rem;
                margin: 1rem;
            }

            .login-header h1 {
                font-size: 1.8rem;
            }

            .login-header h2 {
                font-size: 1rem;
            }
        }

        /* Additional Animations */
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .login-container:hover {
            animation: float 3s ease-in-out infinite;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
        }
    </style>
</head>
<body class="login-page">
<div class="login-container">
    <div class="login-header">
        <h1>Pahana Edu</h1>
        <h2>Bookshop Management System</h2>
        <p>Admin Portal</p>
    </div>

    <div class="login-form-container">
        <!-- Display success message if logout was successful -->
        <% if ("success".equals(request.getParameter("logout"))) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle icon-success"></i>
            You have been successfully logged out.
        </div>
        <% } %>

        <!-- Display error message if logout failed -->
        <% if ("logout_failed".equals(request.getParameter("error"))) { %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-triangle icon-error"></i>
            Logout failed. Please try again.
        </div>
        <% } %>

        <!-- Display error message from servlet -->
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-error">
            <i class="fas fa-times-circle icon-error"></i>
            <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <!-- Display success message from servlet -->
        <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle icon-success"></i>
            <%= request.getAttribute("successMessage") %>
        </div>
        <% } %>

        <form action="login" method="post" class="login-form" id="loginForm">
            <input type="hidden" name="action" value="login">

            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-container">
                    <input type="text"
                           id="username"
                           name="username"
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                           placeholder="Enter your username"
                           required
                           autocomplete="username"
                           maxlength="50">
                    <span class="input-icon"><i class="fas fa-user"></i></span>
                </div>
                <span class="error-message" id="usernameError"></span>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-container">
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Enter your password"
                           required
                           autocomplete="current-password"
                           maxlength="255">
                    <span class="input-icon"><i class="fas fa-lock"></i></span>
                    <button type="button" class="toggle-password" id="togglePassword">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <span class="error-message" id="passwordError"></span>
            </div>

            <div class="form-group">
                <button type="submit" class="btn-login" id="loginBtn">
                    <span class="btn-text">
                        <i class="fas fa-sign-in-alt"></i>
                        Login
                    </span>
                    <span class="btn-loading" style="display: none;">
                        <span class="spinner"></span>
                        Authenticating...
                    </span>
                </button>
            </div>
        </form>

        <div class="login-help">

            <div class="system-info">
                <p><small>© 2025 Pahana Edu Bookshop Management System</small></p>
                <p><small>Version 1.0.0</small></p>
            </div>
        </div>
    </div>
</div>

<!-- Loading overlay -->
<div id="loadingOverlay" class="loading-overlay" style="display: none;">
    <div class="loading-spinner">
        <div class="spinner-large"></div>
        <p>Authenticating...</p>
    </div>
</div>

<script>
    // Auto-hide alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        console.log('🔥 LOGIN PAGE LOADED - ready for debugging');

        // Show debug info from previous submission if it exists
        const debugInfo = localStorage.getItem('loginDebug');
        if (debugInfo) {
            const parsed = JSON.parse(debugInfo);
            console.log('🔥🔥🔥 FORM WAS SUBMITTED WITH THESE VALUES:');
            console.log('🔥 Username sent:', parsed.username);
            console.log('🔥 Password length sent:', parsed.passwordLength);
            console.log('🔥 Form action was:', parsed.formAction);
            console.log('🔥 Username field name:', parsed.usernameFieldName);
            console.log('🔥 Password field name:', parsed.passwordFieldName);
            console.log('🔥🔥🔥 END DEBUG INFO');
            // Clear it so we don't show it again
            localStorage.removeItem('loginDebug');
        } else {
            console.log('🔥 No previous submission found - this is the first load');
        }
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            setTimeout(function() {
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.style.display = 'none';
                }, 300);
            }, 5000);
        });

        // Focus on username field
        const usernameField = document.getElementById('username');
        if (usernameField && !usernameField.value) {
            usernameField.focus();
        } else {
            const passwordField = document.getElementById('password');
            if (passwordField) {
                passwordField.focus();
            }
        }
    });

    // Password toggle functionality
    document.getElementById('togglePassword').addEventListener('click', function() {
        const passwordField = document.getElementById('password');
        const toggleIcon = this.querySelector('i');

        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            toggleIcon.className = 'fas fa-eye-slash';
        } else {
            passwordField.type = 'password';
            toggleIcon.className = 'fas fa-eye';
        }
    });

    // Form submission handling with debugging
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        console.log('🔥 FORM SUBMISSION STARTED');

        // Save debug info that persists across page reload
        const debugInfo = {
            timestamp: new Date().toISOString(),
            formAction: this.action,
            formMethod: this.method,
            username: document.getElementById('username').value.trim(),
            passwordLength: document.getElementById('password').value.trim().length,
            usernameFieldName: document.getElementById('username').name,
            passwordFieldName: document.getElementById('password').name
        };

        localStorage.setItem('loginDebug', JSON.stringify(debugInfo));
        console.log('🔥 DEBUG INFO SAVED:', debugInfo);

        const loginBtn = document.getElementById('loginBtn');
        const btnText = loginBtn.querySelector('.btn-text');
        const btnLoading = loginBtn.querySelector('.btn-loading');
        const overlay = document.getElementById('loadingOverlay');

        // Basic client-side validation
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        console.log('🔥 VALIDATING - Username: "' + username + '" (length: ' + username.length + ')');
        console.log('🔥 VALIDATING - Password length: ' + password.length);

        if (!username || !password) {
            console.log('🔥 VALIDATION FAILED - empty fields, preventing submission');
            e.preventDefault();
            if (!username) {
                document.getElementById('usernameError').textContent = 'Username is required';
            }
            if (!password) {
                document.getElementById('passwordError').textContent = 'Password is required';
            }
            return false;
        }

        console.log('🔥 VALIDATION PASSED - allowing form to submit naturally');

        // Show loading state
        if (btnText && btnLoading) {
            btnText.style.display = 'none';
            btnLoading.style.display = 'inline-flex';
        }
        if (loginBtn) {
            loginBtn.disabled = true;
        }
        if (overlay) {
            overlay.style.display = 'flex';
        }

        // Allow form to submit normally
        return true;
    });

    // Clear error messages on input
    ['username', 'password'].forEach(function(fieldId) {
        document.getElementById(fieldId).addEventListener('input', function() {
            document.getElementById(fieldId + 'Error').textContent = '';
        });
    });
</script>
</body>
</html>
