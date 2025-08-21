<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
            radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
            radial-gradient(circle at 40% 80%, rgba(120, 119, 255, 0.3) 0%, transparent 50%);
            z-index: -1;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
        }

        /* Floating Animation Elements */
        .floating-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.05);
            animation: floatUp 15s infinite ease-in-out;
        }

        .floating-circle:nth-child(1) {
            width: 100px;
            height: 100px;
            top: 100%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-circle:nth-child(2) {
            width: 60px;
            height: 60px;
            top: 100%;
            left: 70%;
            animation-delay: -5s;
        }

        .floating-circle:nth-child(3) {
            width: 80px;
            height: 80px;
            top: 100%;
            left: 40%;
            animation-delay: -10s;
        }

        @keyframes floatUp {
            0% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100vh) rotate(360deg);
                opacity: 0;
            }
        }

        .edit-customer-header {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            color: white;
            padding: 3rem 2rem;
            border-radius: 25px;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(255, 107, 107, 0.3);
            animation: slideInDown 1s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @keyframes slideInDown {
            from {
                transform: translateY(-100px) scale(0.8);
                opacity: 0;
            }
            to {
                transform: translateY(0) scale(1);
                opacity: 1;
            }
        }

        .edit-customer-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: headerShine 4s infinite;
        }

        @keyframes headerShine {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .header-info {
            display: flex;
            align-items: center;
            gap: 2rem;
            position: relative;
            z-index: 2;
            justify-content: space-between;
        }

        .customer-info-section {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .customer-avatar-edit {
            width: 80px;
            height: 80px;
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: bold;
            border: 3px solid rgba(255,255,255,0.3);
            position: relative;
            animation: avatarPulse 3s ease-in-out infinite;
        }

        @keyframes avatarPulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(255,255,255,0.4);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 0 0 10px rgba(255,255,255,0);
            }
        }

        .header-text h1 {
            margin: 0 0 0.5rem 0;
            font-size: 2.5rem;
            font-weight: 800;
            text-shadow: 0 4px 8px rgba(0,0,0,0.3);
            animation: textGlow 2s ease-in-out infinite alternate;
        }

        @keyframes textGlow {
            from {
                text-shadow: 0 4px 8px rgba(0,0,0,0.3);
            }
            to {
                text-shadow: 0 4px 8px rgba(0,0,0,0.3), 0 0 20px rgba(255,255,255,0.5);
            }
        }

        .header-text p {
            margin: 0;
            opacity: 0.95;
            font-size: 1.2rem;
            font-weight: 400;
        }

        .account-badge {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(20px);
            padding: 1rem 2rem;
            border-radius: 30px;
            font-weight: 700;
            font-size: 1.1rem;
            border: 2px solid rgba(255,255,255,0.2);
            position: relative;
            animation: badgeFloat 3s ease-in-out infinite;
        }

        @keyframes badgeFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            padding: 3rem;
            border-radius: 30px;
            box-shadow: 0 30px 60px rgba(0,0,0,0.2);
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            border: 1px solid rgba(255,255,255,0.2);
            animation: formSlideUp 1.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @keyframes formSlideUp {
            from {
                transform: translateY(50px) scale(0.95);
                opacity: 0;
            }
            to {
                transform: translateY(0) scale(1);
                opacity: 1;
            }
        }

        .form-header {
            text-align: center;
            margin-bottom: 3rem;
            padding-bottom: 2rem;
            border-bottom: 3px solid transparent;
            background: linear-gradient(90deg, #667eea, #764ba2) bottom;
            background-size: 100% 3px;
            background-repeat: no-repeat;
            position: relative;
        }

        .form-header::before {
            content: '';
            position: absolute;
            bottom: -3px;
            left: 0;
            width: 0;
            height: 3px;
            background: linear-gradient(90deg, #ff6b6b, #ee5a24);
            animation: headerUnderline 2s ease-out forwards;
        }

        @keyframes headerUnderline {
            to { width: 100%; }
        }

        .form-header h2 {
            color: #2d3436;
            margin: 0 0 1rem 0;
            font-size: 2rem;
            font-weight: 700;
        }

        .form-header p {
            color: #636e72;
            margin: 0;
            font-size: 1.1rem;
        }

        .form-section {
            margin-bottom: 2.5rem;
            padding: 2rem;
            background: linear-gradient(135deg, #f8f9ff 0%, #fef7ff 100%);
            border-radius: 20px;
            border-left: 5px solid #6c5ce7;
            position: relative;
            transition: all 0.3s ease;
            animation: sectionFadeIn 0.8s ease-out forwards;
            opacity: 0;
            transform: translateX(-30px);
        }

        .form-section:nth-child(1) { animation-delay: 0.2s; }
        .form-section:nth-child(2) { animation-delay: 0.4s; }
        .form-section:nth-child(3) { animation-delay: 0.6s; }

        @keyframes sectionFadeIn {
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(108, 92, 231, 0.15);
        }

        .form-section:last-child {
            margin-bottom: 0;
        }

        .section-title {
            color: #2d3436;
            font-size: 1.4rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-weight: 700;
            position: relative;
        }

        .section-title::after {
            content: '';
            flex: 1;
            height: 2px;
            background: linear-gradient(90deg, #6c5ce7, transparent);
            border-radius: 1px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .form-row.single {
            grid-template-columns: 1fr;
        }

        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 600;
            color: #2d3436;
            font-size: 1.1rem;
            position: relative;
            transition: all 0.3s ease;
        }

        .required::after {
            content: ' ✦';
            color: #fd79a8;
            font-weight: bold;
            animation: requirePulse 2s infinite;
        }

        @keyframes requirePulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.7; transform: scale(1.2); }
        }

        .readonly-field {
            background: linear-gradient(145deg, #e9ecef 0%, #f8f9fa 100%) !important;
            border: 3px solid #dee2e6 !important;
            color: #6c757d !important;
            cursor: not-allowed !important;
            position: relative;
        }

        .readonly-field:focus {
            box-shadow: none !important;
            border-color: #dee2e6 !important;
        }

        .readonly-field::after {
            content: '🔒';
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            opacity: 0.5;
        }

        .form-control {
            width: 100%;
            padding: 1.25rem 1rem 1.25rem 3.5rem;
            border: 3px solid #e9ecef;
            border-radius: 15px;
            font-size: 1.1rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            font-family: 'Inter', sans-serif;
            position: relative;
        }

        .form-control:focus {
            outline: none;
            border-color: #fd79a8;
            background: #ffffff;
            box-shadow: 0 0 0 0.25rem rgba(253, 121, 168, 0.15),
            0 10px 30px rgba(253, 121, 168, 0.1);
            transform: translateY(-2px);
        }

        .form-control:valid:not(.readonly-field) {
            border-color: #00b894;
            background: linear-gradient(145deg, #f0fff4 0%, #e8f5e8 100%);
        }

        .form-control.error {
            border-color: #e74c3c;
            background: linear-gradient(145deg, #fdf2f2 0%, #ffeaa7 100%);
            box-shadow: 0 0 0 0.25rem rgba(231, 76, 60, 0.25);
            animation: fieldShake 0.5s ease-in-out;
        }

        @keyframes fieldShake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1.25rem;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.4rem;
            z-index: 2;
            transition: all 0.3s ease;
            background: linear-gradient(135deg, #a29bfe 0%, #6c5ce7 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .input-group:focus-within .input-icon {
            transform: translateY(-50%) scale(1.1);
            filter: drop-shadow(0 0 8px rgba(108, 92, 231, 0.5));
            animation: iconBounce 0.6s ease;
        }

        @keyframes iconBounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(-50%) scale(1.1);
            }
            40% {
                transform: translateY(-60%) scale(1.2);
            }
            60% {
                transform: translateY(-55%) scale(1.15);
            }
        }

        .help-text {
            font-size: 0.95rem;
            color: #636e72;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 10px;
            border-left: 3px solid #74b9ff;
        }

        .error-message {
            color: #d63031;
            font-size: 0.95rem;
            margin-top: 0.75rem;
            display: none;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem;
            background: linear-gradient(135deg, #ffeaa7 0%, #fab1a0 100%);
            border-radius: 10px;
            border-left: 3px solid #d63031;
            animation: errorSlideIn 0.3s ease-out;
        }

        @keyframes errorSlideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-message.show {
            display: flex;
        }

        .change-indicator {
            background: linear-gradient(135deg, #fdcb6e 0%, #fd79a8 100%);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 0.75rem;
            margin-top: 0.75rem;
            font-size: 0.9rem;
            font-weight: 500;
            display: none;
            position: relative;
            overflow: hidden;
            animation: changeIndicatorPulse 2s infinite;
        }

        @keyframes changeIndicatorPulse {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(253, 203, 110, 0.7);
            }
            50% {
                box-shadow: 0 0 0 10px rgba(253, 203, 110, 0);
            }
        }

        .change-indicator::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            animation: changeShimmer 2s infinite;
        }

        @keyframes changeShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .change-indicator.show {
            display: block;
        }

        .form-actions {
            display: flex;
            gap: 2rem;
            justify-content: center;
            margin-top: 3rem;
            padding-top: 2rem;
        }

        .btn-update {
            background: linear-gradient(135deg, #00b894 0%, #00cec9 100%);
            color: white;
            padding: 1.5rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            min-width: 200px;
            box-shadow: 0 10px 30px rgba(0, 184, 148, 0.3);
            font-family: 'Inter', sans-serif;
        }

        .btn-update::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-update:hover:not(:disabled)::before {
            left: 100%;
        }

        .btn-update:hover:not(:disabled) {
            background: linear-gradient(135deg, #00a085 0%, #00b8b3 100%);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 40px rgba(0, 184, 148, 0.4);
        }

        .btn-update:active {
            transform: translateY(-1px) scale(1.02);
        }

        .btn-update:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
            background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
        }

        .btn-loading {
            display: none;
            align-items: center;
            gap: 0.75rem;
        }

        .spinner {
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s cubic-bezier(0.68, -0.55, 0.265, 1.55) infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .changes-summary {
            background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
            color: white;
            border: none;
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            display: none;
            box-shadow: 0 15px 35px rgba(116, 185, 255, 0.3);
            position: relative;
            overflow: hidden;
            animation: summarySlideIn 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        @keyframes summarySlideIn {
            from {
                opacity: 0;
                transform: scale(0.9) translateY(-20px);
            }
            to {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        .changes-summary.show {
            display: block;
        }

        .changes-summary::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: summaryShine 3s infinite;
        }

        @keyframes summaryShine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .changes-summary h4 {
            color: white;
            margin: 0 0 1rem 0;
            font-size: 1.3rem;
            font-weight: 700;
            position: relative;
            z-index: 2;
        }

        .changes-list {
            margin: 0;
            padding-left: 2rem;
            color: white;
            position: relative;
            z-index: 2;
        }

        .changes-list li {
            margin-bottom: 0.5rem;
            font-size: 1rem;
            font-weight: 500;
        }

        .original-values {
            background: linear-gradient(135deg, #ddd6fe 0%, #c7d2fe 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 2rem;
            border: 2px solid rgba(139, 92, 246, 0.2);
            position: relative;
            overflow: hidden;
        }

        .original-values::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #8b5cf6, #a78bfa, #c4b5fd);
            animation: originalValuesGradient 3s ease-in-out infinite;
        }

        @keyframes originalValuesGradient {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .original-values h5 {
            margin: 0 0 1rem 0;
            color: #6b21a8;
            font-size: 1.1rem;
            font-weight: 700;
        }

        .original-value {
            font-size: 0.95rem;
            color: #6b21a8;
            margin-bottom: 0.5rem;
            padding: 0.5rem;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 8px;
            border-left: 3px solid #8b5cf6;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
            color: white;
            padding: 1.5rem 3rem;
            border: none;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(99, 110, 114, 0.3);
            font-family: 'Inter', sans-serif;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #2d3436 0%, #636e72 100%);
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(99, 110, 114, 0.4);
        }

        /* Alert Styles */
        .alert {
            padding: 1.5rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            animation: alertSlideIn 0.5s ease-out;
            position: relative;
            overflow: hidden;
        }

        @keyframes alertSlideIn {
            from {
                opacity: 0;
                transform: translateX(-50px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-error {
            background: linear-gradient(135deg, #ff7675 0%, #d63031 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(255, 118, 117, 0.3);
        }

        .alert-error::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: alertShine 2s infinite;
        }

        @keyframes alertShine {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .icon-error {
            font-size: 1.5rem;
            animation: errorBounce 1s infinite;
        }

        @keyframes errorBounce {
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

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .edit-customer-header {
                padding: 2rem 1.5rem;
                margin-bottom: 2rem;
                border-radius: 20px;
            }

            .header-info {
                flex-direction: column;
                text-align: center;
                gap: 1.5rem;
            }

            .customer-info-section {
                flex-direction: column;
                gap: 1rem;
            }

            .customer-avatar-edit {
                width: 60px;
                height: 60px;
                font-size: 1.5rem;
            }

            .header-text h1 {
                font-size: 2rem;
            }

            .form-container {
                padding: 2rem;
                margin: 1rem;
                border-radius: 20px;
            }

            .form-section {
                padding: 1.5rem;
                margin-bottom: 2rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .form-actions {
                flex-direction: column;
                align-items: center;
                gap: 1rem;
            }

            .btn-update,
            .btn-secondary {
                width: 100%;
                max-width: 300px;
            }
        }

        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #6c5ce7 0%, #a29bfe 100%);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #5f4fcf 0%, #9085e8 100%);
        }
    </style>
</head>
<body>
<!-- Floating Animation Elements -->
<div class="floating-elements">
    <div class="floating-circle"></div>
    <div class="floating-circle"></div>
    <div class="floating-circle"></div>
</div>

<!-- Check if user is logged in -->
    <%
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    Customer customer = (Customer) request.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/customer");
        return;
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
    <!-- Page Header -->
    <div class="edit-customer-header">
        <div class="header-info">
            <div class="customer-info-section">
                <div class="customer-avatar-edit">
                    <%= customer.getName().substring(0, 1).toUpperCase() %>
                </div>
                <div class="header-text">
                    <h1>🎨 Edit Customer</h1>
                    <p>Modify <%= customer.getName() %>'s profile information</p>
                </div>
            </div>
            <div class="account-badge">
                🏆 <%= customer.getAccountNumber() %>
            </div>
        </div>
    </div>

    <!-- Display Error Messages -->
        <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <i class="icon-error">⚠️</i>
        <%= request.getAttribute("errorMessage") %>
    </div>
        <% } %>

    <!-- Changes Summary -->
    <div id="changesSummary" class="changes-summary">
        <h4>🔄 Pending Changes</h4>
        <ul id="changesList" class="changes-list"></ul>
    </div>

    <!-- Edit Customer Form -->
    <div class="form-container">
        <div class="form-header">
            <h2>Customer Information</h2>
            <p>Update the customer details with our enhanced interface</p>
        </div>

        <form id="editCustomerForm" action="${pageContext.request.contextPath}/customer" method="post" novalidate>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">

            <!-- Account Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    🎯 Account Information
                </h3>

                <div class="form-group">
                    <label for="accountNumber">Account Number</label>
                    <div class="input-group">
                        <span class="input-icon">🎯</span>
                        <input type="text"
                               id="accountNumber"
                               class="form-control readonly-field"
                               value="<%= customer.getAccountNumber() %>"
                               readonly>
                    </div>
                    <div class="help-text">
                        🔐 Account number is permanently locked after creation
                    </div>
                </div>
            </div>

            <!-- Personal Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    👑 Personal Information
                </h3>

                <div class="form-group">
                    <label for="name" class="required">Full Name</label>
                    <div class="input-group">
                        <span class="input-icon">👤</span>
                        <input type="text"
                               id="name"
                               name="name"
                               class="form-control"
                               value="<%= customer.getName() %>"
                               placeholder="Enter customer's full name"
                               required
                               maxlength="100"
                               pattern="[A-Za-z\s.']+">
                    </div>
                    <div class="help-text">
                        ✨ Enter the customer's complete name
                    </div>
                    <div id="nameError" class="error-message">
                        🔥 <span></span>
                    </div>
                    <div id="nameChange" class="change-indicator">
                        Original: <span id="nameOriginal"><%= customer.getName() %></span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="address" class="required">Address</label>
                    <div class="input-group">
                        <span class="input-icon">🏰</span>
                        <textarea id="address"
                                  name="address"
                                  class="form-control"
                                  placeholder="Enter complete address"
                                  required
                                  maxlength="500"
                                  rows="3"><%= customer.getAddress() %></textarea>
                    </div>
                    <div class="help-text">
                        🗺️ Include complete address with postal code
                    </div>
                    <div id="addressError" class="error-message">
                        🔥 <span></span>
                    </div>
                    <div id="addressChange" class="change-indicator">
                        Original: <span id="addressOriginal"><%= customer.getAddress() %></span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="telephone" class="required">Telephone Number</label>
                    <div class="input-group">
                        <span class="input-icon">📱</span>
                        <input type="tel"
                               id="telephone"
                               name="telephone"
                               class="form-control"
                               value="<%= customer.getTelephone() %>"
                               placeholder="Enter contact number"
                               required
                               maxlength="15"
                               pattern="[0-9\s\-\+\(\)]+">
                    </div>
                    <div class="help-text">
                        📞 Enter a valid contact number
                    </div>
                    <div id="telephoneError" class="error-message">
                        🔥 <span></span>
                    </div>
                    <div id="telephoneChange" class="change-indicator">
                        Original: <span id="telephoneOriginal"><%= customer.getTelephone() %></span>
                    </div>
                </div>
            </div>

            <!-- Usage Information Section -->
            <div class="form-section">
                <h3 class="section-title">
                    ⚡ Usage Information
                </h3>

                <div class="form-group">
                    <label for="unitsConsumed" class="required">Units Consumed</label>
                    <div class="input-group">
                        <span class="input-icon">⚡</span>
                        <input type="number"
                               id="unitsConsumed"
                               name="unitsConsumed"
                               class="form-control"
                               value="<%= customer.getUnitsConsumed() %>"
                               placeholder="Enter current reading"
                               required
                               min="0"
                               max="9999">
                    </div>
                    <div class="help-text">
                        🔋 Current meter reading or consumption units
                    </div>
                    <div id="unitsConsumedError" class="error-message">
                        🔥 <span></span>
                    </div>
                    <div id="unitsConsumedChange" class="change-indicator">
                        Original: <span id="unitsConsumedOriginal"><%= customer.getUnitsConsumed() %></span> units
                    </div>
                </div>
            </div>

            <!-- Original Values (Hidden for reference) -->
            <div class="original-values">
                <h5>📋 Original Values (for reference)</h5>
                <div class="original-value"><strong>Name:</strong> <%= customer.getName() %></div>
                <div class="original-value"><strong>Address:</strong> <%= customer.getAddress() %></div>
                <div class="original-value"><strong>Telephone:</strong> <%= customer.getTelephone() %></div>
                <div class="original-value"><strong>Units:</strong> <%= customer.getUnitsConsumed() %></div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="submit" id="updateBtn" class="btn-update">
                    <span class="btn-text">🚀 Update Customer</span>
                    <span class="btn-loading" style="display: none;">
                            <span class="spinner"></span>
                            Updating...
                        </span>
                </button>
                <a href="${pageContext.request.contextPath}/customer?action=view&accountNumber=<%= customer.getAccountNumber() %>"
                   class="btn btn-secondary btn-lg">
                    🔙 Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    // Store original values
    const originalValues = {
        name: '<%= customer.getName() %>',
        address: '<%= customer.getAddress() %>',
        telephone: '<%= customer.getTelephone() %>',
        unitsConsumed: '<%= customer.getUnitsConsumed() %>'
    };

    // Form elements
    const form = document.getElementById('editCustomerForm');
    const updateBtn = document.getElementById('updateBtn');
    const changesSummary = document.getElementById('changesSummary');
    const changesList = document.getElementById('changesList');

    // Field references
    const fields = {
        name: document.getElementById('name'),
        address: document.getElementById('address'),
        telephone: document.getElementById('telephone'),
        unitsConsumed: document.getElementById('unitsConsumed')
    };

    // Validation rules (same as add form)
    const validationRules = {
        name: {
            required: true,
            minLength: 2,
            maxLength: 100,
            pattern: /^[A-Za-z\s.']+$/,
            message: 'Name must be 2-100 characters long and contain only letters, spaces, dots, and apostrophes'
        },
        address: {
            required: true,
            minLength: 5,
            maxLength: 500,
            message: 'Address must be 5-500 characters long'
        },
        telephone: {
            required: true,
            minLength: 7,
            maxLength: 15,
            pattern: /^[0-9\s\-\+\(\)]+$/,
            message: 'Telephone must be 7-15 characters long and contain only numbers, spaces, hyphens, plus signs, and parentheses'
        },
        unitsConsumed: {
            required: true,
            min: 0,
            max: 9999,
            message: 'Units consumed must be between 0 and 9999'
        }
    };

    // Validate field function (same as add form)
    function validateField(fieldName) {
        const field = fields[fieldName];
        const rule = validationRules[fieldName];
        const value = field.value.trim();
        const errorElement = document.getElementById(fieldName + 'Error');

        let isValid = true;
        let errorMessage = '';

        if (rule.required && !value) {
            isValid = false;
            errorMessage = `${fieldName} is required`;
        } else if (rule.minLength && value.length < rule.minLength) {
            isValid = false;
            errorMessage = `${fieldName} must be at least ${rule.minLength} characters`;
        } else if (rule.maxLength && value.length > rule.maxLength) {
            isValid = false;
            errorMessage = `${fieldName} must not exceed ${rule.maxLength} characters`;
        } else if (rule.min !== undefined && parseInt(value) < rule.min) {
            isValid = false;
            errorMessage = `${fieldName} must be at least ${rule.min}`;
        } else if (rule.max !== undefined && parseInt(value) > rule.max) {
            isValid = false;
            errorMessage = `${fieldName} must not exceed ${rule.max}`;
        } else if (rule.pattern && !rule.pattern.test(value)) {
            isValid = false;
            errorMessage = rule.message;
        }

        // Update UI
        if (isValid) {
            field.classList.remove('error');
            errorElement.classList.remove('show');
        } else {
            field.classList.add('error');
            errorElement.querySelector('span').textContent = errorMessage;
            errorElement.classList.add('show');
        }

        return isValid;
    }

    // Check for changes and update UI
    function checkForChanges() {
        const changes = [];
        let hasChanges = false;

        for (const fieldName in fields) {
            const field = fields[fieldName];
            const currentValue = field.value.trim();
            const originalValue = originalValues[fieldName].toString().trim();
            const changeIndicator = document.getElementById(fieldName + 'Change');

            if (currentValue !== originalValue) {
                hasChanges = true;
                changes.push(`${fieldName}: "${originalValue}" → "${currentValue}"`);
                changeIndicator.classList.add('show');
            } else {
                changeIndicator.classList.remove('show');
            }
        }

        // Update changes summary
        if (hasChanges) {
            changesList.innerHTML = changes.map(change => `<li>${change}</li>`).join('');
            changesSummary.classList.add('show');
            updateBtn.disabled = false;
        } else {
            changesSummary.classList.remove('show');
            updateBtn.disabled = true;
        }
    }

    // Enhanced field interactions with animations
    function addFieldEnhancements() {
        for (const fieldName in fields) {
            const field = fields[fieldName];
            const inputGroup = field.closest('.input-group');
            const icon = inputGroup ? inputGroup.querySelector('.input-icon') : null;

            // Focus animations
            field.addEventListener('focus', function() {
                if (icon) {
                    icon.style.transform = 'translateY(-50%) scale(1.2)';
                    icon.style.filter = 'drop-shadow(0 0 15px rgba(253, 121, 168, 0.7))';
                }

                // Add glow effect to form section
                const formSection = this.closest('.form-section');
                formSection.style.transform = 'translateY(-3px)';
                formSection.style.boxShadow = '0 25px 50px rgba(253, 121, 168, 0.2)';
            });

            // Blur animations
            field.addEventListener('blur', function() {
                if (icon) {
                    icon.style.transform = 'translateY(-50%) scale(1)';
                    icon.style.filter = 'drop-shadow(0 0 8px rgba(108, 92, 231, 0.5))';
                }

                // Remove glow effect
                const formSection = this.closest('.form-section');
                formSection.style.transform = 'translateY(0)';
                formSection.style.boxShadow = '0 20px 40px rgba(108, 92, 231, 0.15)';
            });

            // Input animations
            field.addEventListener('input', function() {
                if (icon) {
                    icon.style.animation = 'iconBounce 0.6s ease';
                    setTimeout(() => {
                        icon.style.animation = '';
                    }, 600);
                }

                // Show typing indicator
                this.style.borderColor = '#74b9ff';
                this.style.boxShadow = '0 0 0 0.25rem rgba(116, 185, 255, 0.15)';

                setTimeout(() => {
                    if (!this.classList.contains('error')) {
                        this.style.borderColor = '';
                        this.style.boxShadow = '';
                    }
                }, 1000);
            });
        }
    }

    // Initialize field enhancements
    addFieldEnhancements();

    // Enhanced change tracking with visual feedback
    function enhancedChangeTracking() {
        for (const fieldName in fields) {
            const field = fields[fieldName];

            field.addEventListener('input', function() {
                const currentValue = this.value.trim();
                const originalValue = originalValues[fieldName].toString().trim();

                if (currentValue !== originalValue) {
                    // Add change indicator animation
                    this.style.background = 'linear-gradient(145deg, #fff3cd 0%, #ffeaa7 100%)';
                    this.style.borderLeft = '4px solid #fd79a8';
                } else {
                    this.style.background = '';
                    this.style.borderLeft = '';
                }

                checkForChanges();
            });
        }
    }

    // Initialize enhanced change tracking
    enhancedChangeTracking();

    // Progress indicator for form completion
    function addProgressIndicator() {
        const progressBar = document.createElement('div');
        progressBar.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 0%;
            height: 4px;
            background: linear-gradient(90deg, #fd79a8 0%, #74b9ff 100%);
            transition: width 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 9999;
            box-shadow: 0 0 15px rgba(253, 121, 168, 0.6);
        `;

        document.body.appendChild(progressBar);

        function updateProgress() {
            const totalFields = Object.keys(fields).length;
            let validFields = 0;

            for (const fieldName in fields) {
                if (fields[fieldName].value.trim() && !fields[fieldName].classList.contains('error')) {
                    validFields++;
                }
            }

            const progress = (validFields / totalFields) * 100;
            progressBar.style.width = progress + '%';

            // Dynamic color based on progress
            if (progress < 30) {
                progressBar.style.background = 'linear-gradient(90deg, #ff7675 0%, #d63031 100%)';
            } else if (progress < 70) {
                progressBar.style.background = 'linear-gradient(90deg, #fdcb6e 0%, #fd79a8 100%)';
            } else {
                progressBar.style.background = 'linear-gradient(90deg, #00b894 0%, #74b9ff 100%)';
            }
        }

        // Update progress on field changes
        for (const fieldName in fields) {
            fields[fieldName].addEventListener('input', updateProgress);
            fields[fieldName].addEventListener('blur', updateProgress);
        }

        updateProgress();
    }

    // Initialize progress indicator
    addProgressIndicator();

    // Add event listeners
    for (const fieldName in fields) {
        const field = fields[fieldName];

        field.addEventListener('input', () => {
            checkForChanges();
            if (field.classList.contains('error')) {
                validateField(fieldName);
            }
        });

        field.addEventListener('blur', () => validateField(fieldName));
    }

    // Enhanced form submission with animation
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        // Validate all fields
        let isValid = true;
        for (const fieldName in fields) {
            if (!validateField(fieldName)) {
                isValid = false;
            }
        }

        if (!isValid) {
            const firstError = form.querySelector('.error');
            if (firstError) {
                firstError.focus();
                firstError.style.animation = 'fieldShake 0.5s ease-in-out';
                setTimeout(() => {
                    firstError.style.animation = '';
                }, 500);
            }
            return;
        }

        // Check if there are actually changes
        checkForChanges();
        if (updateBtn.disabled) {
            // Show no changes animation
            const noChangesAlert = document.createElement('div');
            noChangesAlert.style.cssText = `
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: linear-gradient(135deg, #fdcb6e 0%, #fd79a8 100%);
                color: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(253, 203, 110, 0.4);
                z-index: 10000;
                text-align: center;
                animation: bounceIn 0.6s ease-out;
            `;
            noChangesAlert.innerHTML = `
                <h3 style="margin: 0 0 1rem 0;">🤔 No Changes Detected</h3>
                <p style="margin: 0;">Please make changes before updating.</p>
            `;

            document.body.appendChild(noChangesAlert);

            setTimeout(() => {
                noChangesAlert.style.animation = 'fadeOut 0.3s ease-out forwards';
                setTimeout(() => {
                    document.body.removeChild(noChangesAlert);
                }, 300);
            }, 2000);

            return;
        }

        // Enhanced confirmation dialog
        const confirmationDialog = document.createElement('div');
        confirmationDialog.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            animation: fadeIn 0.3s ease-out;
        `;

        confirmationDialog.innerHTML = `
            <div style="
                background: white;
                padding: 2rem;
                border-radius: 20px;
                max-width: 500px;
                text-align: center;
                animation: bounceIn 0.6s ease-out;
                box-shadow: 0 25px 50px rgba(0,0,0,0.3);
            ">
                <h3 style="margin: 0 0 1rem 0; color: #2d3436;">💾 Confirm Changes</h3>
                <p style="margin: 0 0 2rem 0; color: #636e72;">Are you sure you want to save these changes?</p>
                <div style="display: flex; gap: 1rem; justify-content: center;">
                    <button id="confirmYes" style="
                        background: linear-gradient(135deg, #00b894 0%, #00cec9 100%);
                        color: white;
                        border: none;
                        padding: 1rem 2rem;
                        border-radius: 50px;
                        cursor: pointer;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    ">✅ Yes, Save</button>
                    <button id="confirmNo" style="
                        background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
                        color: white;
                        border: none;
                        padding: 1rem 2rem;
                        border-radius: 50px;
                        cursor: pointer;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    ">❌ Cancel</button>
                </div>
            </div>
        `;

        document.body.appendChild(confirmationDialog);

        // Handle confirmation
        document.getElementById('confirmYes').addEventListener('click', function() {
            document.body.removeChild(confirmationDialog);

            // Show loading state with enhanced animation
            const btnText = updateBtn.querySelector('.btn-text');
            const btnLoading = updateBtn.querySelector('.btn-loading');

            btnText.style.display = 'none';
            btnLoading.style.display = 'inline-flex';
            updateBtn.disabled = true;

            // Add success animation to form
            form.style.animation = 'formSuccess 1s ease-out forwards';

            // Submit form after animation
            setTimeout(() => {
                form.submit();
            }, 1000);
        });

        document.getElementById('confirmNo').addEventListener('click', function() {
            confirmationDialog.style.animation = 'fadeOut 0.3s ease-out forwards';
            setTimeout(() => {
                document.body.removeChild(confirmationDialog);
            }, 300);
        });
    });

    // Reset form with animation
    function resetForm() {
        for (const fieldName in fields) {
            const field = fields[fieldName];
            field.value = originalValues[fieldName];
            field.classList.remove('error');
            field.style.background = '';
            field.style.borderLeft = '';
            document.getElementById(fieldName + 'Error').classList.remove('show');
            document.getElementById(fieldName + 'Change').classList.remove('show');
        }
        changesSummary.classList.remove('show');
        updateBtn.disabled = true;

        // Add reset animation
        form.style.animation = 'formReset 0.8s ease-out';
        setTimeout(() => {
            form.style.animation = '';
        }, 800);
    }

    // Enhanced keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey) {
            switch(e.key) {
                case 's':
                    e.preventDefault();
                    if (!updateBtn.disabled) {
                        form.dispatchEvent(new Event('submit'));
                    }
                    break;
                case 'r':
                    e.preventDefault();
                    if (confirm('🔄 Reset all changes to original values?')) {
                        resetForm();
                    }
                    break;
                case 'z':
                    e.preventDefault();
                    resetForm();
                    break;
            }
        }

        if (e.key === 'Escape') {
            if (!updateBtn.disabled) {
                if (confirm('🚪 Discard changes and go back?')) {
                    window.location.href = '${pageContext.request.contextPath}/customer?action=view&accountNumber=<%= customer.getAccountNumber() %>';
                }
            } else {
                window.location.href = '${pageContext.request.contextPath}/customer?action=view&accountNumber=<%= customer.getAccountNumber() %>';
            }
        }
    });

    // Auto-save draft functionality
    function autoSaveDraft() {
        const draft = {};
        for (const fieldName in fields) {
            draft[fieldName] = fields[fieldName].value;
        }
        localStorage.setItem('customerEditDraft_<%= customer.getAccountNumber() %>', JSON.stringify(draft));
    }

    function loadDraft() {
        const draft = localStorage.getItem('customerEditDraft_<%= customer.getAccountNumber() %>');
        if (draft) {
            const data = JSON.parse(draft);
            for (const fieldName in data) {
                if (fields[fieldName]) {
                    fields[fieldName].value = data[fieldName];
                }
            }
            checkForChanges();
        }
    }

    // Auto-save every 30 seconds
    setInterval(autoSaveDraft, 30000);

    // Save on field changes
    for (const fieldName in fields) {
        fields[fieldName].addEventListener('input', autoSaveDraft);
    }

    // Initialize
    document.addEventListener('DOMContentLoaded', function() {
        loadDraft();
        checkForChanges();
        fields.name.focus();

        // Add welcome animation
        form.style.animation = 'formSlideUp 1.2s cubic-bezier(0.175, 0.885, 0.32, 1.275)';
    });

    // Warn before leaving with unsaved changes
    window.addEventListener('beforeunload', function(e) {
        if (!updateBtn.disabled) {
            e.preventDefault();
            e.returnValue = '⚠️ You have unsaved changes. Are you sure you want to leave?';
            return e.returnValue;
        } else {
            // Clear draft if no changes
            localStorage.removeItem('customerEditDraft_<%= customer.getAccountNumber() %>');
        }
    });

    // Clear draft on successful submission
    form.addEventListener('submit', function() {
        if (!updateBtn.disabled) {
            localStorage.removeItem('customerEditDraft_<%= customer.getAccountNumber() %>');
        }
    });

    // Add additional CSS animations
    const additionalStyles = document.createElement('style');
    additionalStyles.textContent = `
        @keyframes formSuccess {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        @keyframes formReset {
            0% { transform: scale(1); }
            50% { transform: scale(0.98); }
            100% { transform: scale(1); }
        }

        @keyframes bounceIn {
            0% { transform: scale(0.3); opacity: 0; }
            50% { transform: scale(1.05); }
            70% { transform: scale(0.9); }
            100% { transform: scale(1); opacity: 1; }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
    `;
    document.head.appendChild(additionalStyles);

    console.log('🎨 Enhanced customer edit form initialized with animations!');
</script>
</body>
</html>
