<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer - Pahana Edu </title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        :root {
            /* Modern Color Palette */
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

            /* Membership Gradients */
            --regular-gradient: linear-gradient(135deg, #6B7280 0%, #9CA3AF 100%);
            --premium-gradient: linear-gradient(135deg, #F59E0B 0%, #FCD34D 100%);
            --vip-gradient: linear-gradient(135deg, #8B5CF6 0%, #A78BFA 100%);

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
            min-height: 100vh;
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

        .bg-animation::before {
            content: '';
            position: absolute;
            width: 150%;
            height: 150%;
            top: -25%;
            left: -25%;
            background:
                    radial-gradient(circle at 20% 80%, rgba(99, 102, 241, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(236, 72, 153, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 40% 40%, rgba(20, 184, 166, 0.1) 0%, transparent 50%);
            animation: bgRotate 30s linear infinite;
        }

        @keyframes bgRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .floating-element {
            position: absolute;
            opacity: 0.05;
            animation: float 20s infinite ease-in-out;
        }

        .floating-element:nth-child(1) {
            top: 20%;
            left: 10%;
            font-size: 100px;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            top: 60%;
            right: 10%;
            font-size: 120px;
            animation-delay: 5s;
        }

        .floating-element:nth-child(3) {
            bottom: 10%;
            left: 50%;
            font-size: 80px;
            animation-delay: 10s;
        }

        @keyframes float {
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
        }

        .nav-link:hover {
            color: var(--primary-color);
            background: rgba(99, 102, 241, 0.1);
            transform: translateY(-2px);
        }

        .nav-link.active {
            color: white;
            background: var(--primary-gradient);
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
        }

        /* Page Header */
        .page-header {
            background: var(--bg-secondary);
            border-radius: 24px;
            padding: 3rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
            animation: fadeInScale 0.6s ease-out;
        }

        .page-header::before {
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

        .header-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            z-index: 1;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .customer-avatar {
            width: 100px;
            height: 100px;
            border-radius: 20px;
            background: var(--primary-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
            position: relative;
            overflow: hidden;
            animation: avatarFloat 3s ease-in-out infinite;
        }

        @keyframes avatarFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        .customer-avatar::after {
            content: '';
            position: absolute;
            inset: -50%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
            transform: rotate(45deg);
            animation: shimmer 3s linear infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .header-info h1 {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .header-info p {
            color: var(--text-secondary);
            font-size: 1.125rem;
        }

        .membership-indicator {
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            animation: bounceIn 0.8s ease-out;
        }

        .membership-regular {
            background: var(--regular-gradient);
            color: white;
        }

        .membership-premium {
            background: var(--premium-gradient);
            color: white;
            box-shadow: 0 4px 15px rgba(245, 158, 11, 0.3);
        }

        .membership-vip {
            background: var(--vip-gradient);
            color: white;
            box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3);
        }

        /* Form Container */
        .form-container {
            background: var(--bg-secondary);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: var(--shadow-xl);
            animation: slideUp 0.6s ease-out 0.2s both;
        }

        /* Form Sections */
        .form-section {
            margin-bottom: 3rem;
            padding: 2rem;
            background: var(--bg-primary);
            border-radius: 16px;
            position: relative;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out forwards;
            opacity: 0;
        }

        .form-section:nth-child(1) { animation-delay: 0.3s; }
        .form-section:nth-child(2) { animation-delay: 0.4s; }
        .form-section:nth-child(3) { animation-delay: 0.5s; }

        .form-section:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .section-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .form-section:nth-child(1) .section-icon {
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-color);
        }

        .form-section:nth-child(2) .section-icon {
            background: rgba(236, 72, 153, 0.1);
            color: var(--secondary-color);
        }

        .form-section:nth-child(3) .section-icon {
            background: rgba(20, 184, 166, 0.1);
            color: var(--accent-color);
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        /* Form Fields */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .form-group {
            position: relative;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }

        .form-label.required::after {
            content: ' *';
            color: var(--danger-color);
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            transition: all 0.3s ease;
        }

        .form-input {
            width: 100%;
            padding: 0.875rem 1rem 0.875rem 2.75rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s ease;
            background: white;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
        }

        .form-input:focus ~ .input-icon {
            color: var(--primary-color);
            transform: translateY(-50%) scale(1.1);
        }

        .form-input.has-error {
            border-color: var(--danger-color);
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .form-input.has-success {
            border-color: var(--success-color);
        }

        .form-input.modified {
            background: rgba(251, 191, 36, 0.05);
            border-color: var(--warning-color);
        }

        /* Help Text */
        .help-text {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
            font-size: 0.75rem;
            color: var(--text-secondary);
            opacity: 0;
            transform: translateY(-10px);
            transition: all 0.3s ease;
        }

        .form-group:hover .help-text {
            opacity: 1;
            transform: translateY(0);
        }

        /* Error Messages */
        .error-message {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
            padding: 0.5rem 0.75rem;
            background: rgba(239, 68, 68, 0.1);
            border-left: 3px solid var(--danger-color);
            border-radius: 6px;
            color: var(--danger-color);
            font-size: 0.875rem;
            opacity: 0;
            transform: translateY(-10px) scale(0.9);
            transition: all 0.3s ease;
            visibility: hidden;
        }

        .error-message.show {
            opacity: 1;
            transform: translateY(0) scale(1);
            visibility: visible;
            animation: errorPop 0.5s ease-out;
        }

        @keyframes errorPop {
            0% { transform: scale(0.8) translateY(-10px); }
            50% { transform: scale(1.05) translateY(2px); }
            100% { transform: scale(1) translateY(0); }
        }

        /* Success Message */
        .success-message {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
            padding: 0.5rem 0.75rem;
            background: rgba(16, 185, 129, 0.1);
            border-left: 3px solid var(--success-color);
            border-radius: 6px;
            color: var(--success-color);
            font-size: 0.875rem;
            opacity: 0;
            transform: translateY(-10px) scale(0.9);
            transition: all 0.3s ease;
        }

        .success-message.show {
            opacity: 1;
            transform: translateY(0) scale(1);
            animation: successPop 0.5s ease-out;
        }

        @keyframes successPop {
            0% { transform: scale(0.8) translateY(-10px); }
            50% { transform: scale(1.05) translateY(2px); }
            100% { transform: scale(1) translateY(0); }
        }

        /* Change Indicator */
        .change-indicator {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--warning-color);
            opacity: 0;
            transition: all 0.3s ease;
        }

        .change-indicator.show {
            opacity: 1;
            animation: blink 2s ease-in-out infinite;
        }

        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.3; }
        }

        /* Changes Summary */
        .changes-summary {
            background: var(--info-gradient);
            color: white;
            padding: 1.5rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            display: none;
            animation: slideDown 0.5s ease-out;
            position: relative;
            overflow: hidden;
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
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: sweep 3s linear infinite;
        }

        @keyframes sweep {
            0% { transform: translateX(-100%) translateY(100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(-100%) rotate(45deg); }
        }

        .changes-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            font-weight: 600;
            position: relative;
            z-index: 1;
        }

        .changes-list {
            list-style: none;
            position: relative;
            z-index: 1;
        }

        .change-item {
            padding: 0.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            opacity: 0;
            animation: slideInLeft 0.5s ease-out forwards;
        }

        .change-item:nth-child(1) { animation-delay: 0.1s; }
        .change-item:nth-child(2) { animation-delay: 0.2s; }
        .change-item:nth-child(3) { animation-delay: 0.3s; }
        .change-item:nth-child(4) { animation-delay: 0.4s; }

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 2px solid var(--border-color);
        }

        .btn {
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
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
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }

        .btn:active::before {
            width: 300px;
            height: 300px;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.5);
        }

        .btn-primary:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .btn-secondary {
            background: #E5E7EB;
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: #D1D5DB;
            transform: translateY(-2px);
        }

        /* Loading State */
        .btn-loading {
            position: relative;
            color: transparent;
        }

        .btn-loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            top: 50%;
            left: 50%;
            margin-left: -10px;
            margin-top: -10px;
            border: 2px solid white;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spinner 0.8s linear infinite;
        }

        @keyframes spinner {
            to { transform: rotate(360deg); }
        }

        /* Notification Toast */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .toast {
            min-width: 350px;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            box-shadow: var(--shadow-xl);
            display: flex;
            align-items: center;
            gap: 1rem;
            position: relative;
            transform: translateX(400px);
            animation: toastSlideIn 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards;
        }

        @keyframes toastSlideIn {
            to { transform: translateX(0); }
        }

        .toast.hide {
            animation: toastSlideOut 0.5s ease-out forwards;
        }

        @keyframes toastSlideOut {
            to {
                transform: translateX(400px);
                opacity: 0;
            }
        }

        .toast-success {
            background: var(--success-gradient);
            color: white;
        }

        .toast-error {
            background: var(--danger-gradient);
            color: white;
        }

        .toast-warning {
            background: var(--warning-gradient);
            color: white;
        }

        .toast-info {
            background: var(--info-gradient);
            color: white;
        }

        .toast-icon {
            font-size: 1.5rem;
            animation: toastIconPop 0.5s ease-out;
        }

        @keyframes toastIconPop {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }

        .toast-content {
            flex: 1;
        }

        .toast-title {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .toast-message {
            font-size: 0.875rem;
            opacity: 0.9;
        }

        .toast-close {
            background: none;
            border: none;
            color: white;
            font-size: 1.25rem;
            cursor: pointer;
            opacity: 0.8;
            transition: all 0.3s ease;
        }

        .toast-close:hover {
            opacity: 1;
            transform: rotate(90deg);
        }

        .toast-progress {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            background: rgba(255, 255, 255, 0.5);
            animation: progress 5s linear forwards;
        }

        @keyframes progress {
            from { width: 100%; }
            to { width: 0%; }
        }

        /* Confirmation Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(5px);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .modal-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .modal {
            background: white;
            padding: 2.5rem;
            border-radius: 20px;
            max-width: 500px;
            width: 90%;
            transform: scale(0.8);
            transition: all 0.3s ease;
            text-align: center;
            position: relative;
        }

        .modal-overlay.show .modal {
            transform: scale(1);
            animation: modalBounce 0.5s ease-out;
        }

        @keyframes modalBounce {
            0% { transform: scale(0.8); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .modal-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            border-radius: 50%;
            background: rgba(99, 102, 241, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: var(--primary-color);
            animation: modalIconPulse 2s ease-in-out infinite;
        }

        @keyframes modalIconPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .modal-message {
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

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
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

        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: scale(0.3);
            }
            50% {
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

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .page-header {
                padding: 2rem;
            }

            .header-content {
                flex-direction: column;
                text-align: center;
                gap: 1.5rem;
            }

            .header-left {
                flex-direction: column;
            }

            .form-container {
                padding: 1.5rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .toast {
                min-width: auto;
                margin: 0 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Animated Background -->
<div class="bg-animation">
    <div class="floating-element">📚</div>
    <div class="floating-element">📖</div>
    <div class="floating-element">📕</div>
</div>

<!-- Check Authentication -->
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

<!-- Navigation -->
<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/dashboard" class="nav-brand">
            <i class="fas fa-store"></i>
            Pahana Edu
        </a>
        <ul class="nav-menu">
            <li>
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                    <i class="fas fa-chart-line"></i>
                    Dashboard
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/customer" class="nav-link active">
                    <i class="fas fa-user-friends"></i>
                    Customers
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/item" class="nav-link">
                    <i class="fas fa-books"></i>
                    Inventory
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/bill" class="nav-link">
                    <i class="fas fa-cash-register"></i>
                    Billing
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link">
                    <i class="fas fa-headset"></i>
                    Support
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                    <i class="fas fa-power-off"></i>
                    Logout
                </a>
            </li>
        </ul>
    </div>
</nav>

<!-- Toast Container -->
<div class="toast-container" id="toastContainer">
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="toast toast-error" id="errorToast">
        <i class="fas fa-exclamation-circle toast-icon"></i>
        <div class="toast-content">
            <div class="toast-title">Error</div>
            <div class="toast-message"><%= request.getAttribute("errorMessage") %></div>
        </div>
        <button class="toast-close" onclick="closeToast('errorToast')">
            <i class="fas fa-times"></i>
        </button>
        <div class="toast-progress"></div>
    </div>
    <% } %>
</div>

<!-- Main Container -->
<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <div class="header-content">
            <div class="header-left">
                <div class="customer-avatar">
                    <%= customer.getName().substring(0, Math.min(2, customer.getName().length())).toUpperCase() %>
                </div>
                <div class="header-info">
                    <h1>
                        <i class="fas fa-user-edit"></i>
                        Edit Customer
                    </h1>
                    <p>Update information for <%= customer.getName() %></p>
                </div>
            </div>
            <div class="membership-indicator membership-<%= customer.getMembershipType().toLowerCase() %>">
                <% if ("VIP".equals(customer.getMembershipType())) { %>
                <i class="fas fa-crown"></i>
                <% } else if ("PREMIUM".equals(customer.getMembershipType())) { %>
                <i class="fas fa-star"></i>
                <% } else { %>
                <i class="fas fa-user"></i>
                <% } %>
                <%= customer.getMembershipType() %> Member
            </div>
        </div>
    </div>

    <!-- Changes Summary -->
    <div id="changesSummary" class="changes-summary">
        <div class="changes-header">
            <i class="fas fa-info-circle"></i>
            <span>Unsaved Changes</span>
        </div>
        <ul class="changes-list" id="changesList"></ul>
    </div>


    <!-- Form Container -->
    <div class="form-container">
        <form id="editCustomerForm" action="${pageContext.request.contextPath}/customer" method="post" novalidate>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">

            <!-- Personal Information Section -->
            <div class="form-section">
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3 class="section-title">Personal Information</h3>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="name" class="form-label required">Full Name</label>
                        <div class="input-wrapper">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text"
                                   id="name"
                                   name="name"
                                   class="form-input"
                                   value="<%= customer.getName() %>"
                                   placeholder="Enter customer name"
                                   required
                                   maxlength="100"
                                   data-original="<%= customer.getName() %>">
                            <span class="change-indicator" id="nameChange"></span>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Customer's full name for identification
                        </div>
                        <div class="error-message" id="nameError">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label required">Email Address</label>
                        <div class="input-wrapper">
                            <i class="fas fa-envelope input-icon"></i>
                            <input type="email"
                                   id="email"
                                   name="email"
                                   class="form-input"
                                   value="<%= customer.getEmail() %>"
                                   placeholder="customer@example.com"
                                   required
                                   maxlength="100"
                                   data-original="<%= customer.getEmail() %>">
                            <span class="change-indicator" id="emailChange"></span>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Email for receipts and notifications
                        </div>
                        <div class="error-message" id="emailError">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="form-label required">Phone Number</label>
                        <div class="input-wrapper">
                            <i class="fas fa-phone input-icon"></i>
                            <input type="tel"
                                   id="phone"
                                   name="phone"
                                   class="form-input"
                                   value="<%= customer.getPhone() %>"
                                   placeholder="+1 (555) 123-4567"
                                   required
                                   maxlength="15"
                                   data-original="<%= customer.getPhone() %>">
                            <span class="change-indicator" id="phoneChange"></span>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Contact number for order updates
                        </div>
                        <div class="error-message" id="phoneError">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address" class="form-label required">Address</label>
                        <div class="input-wrapper">
                            <i class="fas fa-map-marker-alt input-icon"></i>
                            <textarea id="address"
                                      name="address"
                                      class="form-input"
                                      placeholder="Enter complete address"
                                      required
                                      rows="3"
                                      maxlength="500"
                                      data-original="<%= customer.getAddress() %>"><%= customer.getAddress() %></textarea>
                            <span class="change-indicator" id="addressChange"></span>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Delivery address for book orders
                        </div>
                        <div class="error-message" id="addressError">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Membership Information Section -->
            <div class="form-section">
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-medal"></i>
                    </div>
                    <h3 class="section-title">Membership & Billing</h3>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="membershipType" class="form-label">Membership Type</label>
                        <div class="input-wrapper">
                            <i class="fas fa-crown input-icon"></i>
                            <select id="membershipType"
                                    name="membershipType"
                                    class="form-input"
                                    data-original="<%= customer.getMembershipType() %>">
                                <option value="REGULAR" <%= "REGULAR".equals(customer.getMembershipType()) ? "selected" : "" %>>Regular Member</option>
                                <option value="PREMIUM" <%= "PREMIUM".equals(customer.getMembershipType()) ? "selected" : "" %>>Premium Member (10% off)</option>
                                <option value="VIP" <%= "VIP".equals(customer.getMembershipType()) ? "selected" : "" %>>VIP Member (20% off)</option>
                            </select>
                            <span class="change-indicator" id="membershipTypeChange"></span>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Membership level affects discounts
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="totalPurchases" class="form-label">Total Purchases</label>
                        <div class="input-wrapper">
                            <i class="fas fa-dollar-sign input-icon"></i>
                            <input type="number"
                                   id="totalPurchases"
                                   name="totalPurchases"
                                   class="form-input"
                                   value="<%= customer.getTotalPurchases() %>"
                                   placeholder="0.00"
                                   step="0.01"
                                   min="0"
                                   data-original="<%= customer.getTotalPurchases() %>">
                            <span class="change-indicator" id="totalPurchasesChange"></span>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            Lifetime purchase amount
                        </div>
                        <div class="error-message" id="totalPurchasesError">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="loyaltyPoints" class="form-label">Loyalty Points</label>
                        <div class="input-wrapper">
                            <i class="fas fa-coins input-icon"></i>
                            <input type="number"
                                   id="loyaltyPoints"
                                   name="loyaltyPoints"
                                   class="form-input"
                                   value="<%= customer.getLoyaltyPoints() %>"
                                   placeholder="0"
                                   min="0"
                                   data-original="<%= customer.getLoyaltyPoints() %>">
                            <span class="change-indicator" id="loyaltyPointsChange"></span>
                        </div>
                        <div class="help-text">
                            <i class="fas fa-info-circle"></i>
                            1 point = $0.01 discount
                        </div>
                        <div class="error-message" id="loyaltyPointsError">
                            <i class="fas fa-exclamation-triangle"></i>
                            <span></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Account Status Section -->
            <div class="form-section">
                <div class="section-header">
                    <div class="section-icon">
                        <i class="fas fa-info-circle"></i>
                    </div>
                    <h3 class="section-title">Account Information</h3>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Customer ID</label>
                        <div class="input-wrapper">
                            <i class="fas fa-hashtag input-icon"></i>
                            <input type="text"
                                   class="form-input"
                                   value="<%= customer.getCustomerId() %>"
                                   readonly
                                   style="background: #F3F4F6; cursor: not-allowed;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Member Since</label>
                        <div class="input-wrapper">
                            <i class="fas fa-calendar-alt input-icon"></i>
                            <input type="text"
                                   class="form-input"
                                   value="<%= customer.getCreatedAt() != null ? new java.text.SimpleDateFormat("MMM dd, yyyy").format(customer.getCreatedAt()) : "N/A" %>"
                                   readonly
                                   style="background: #F3F4F6; cursor: not-allowed;">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class="fas fa-save"></i>
                    <span class="btn-text">Save Changes</span>
                </button>
                <a href="${pageContext.request.contextPath}/customer?action=view&customerId=<%= customer.getCustomerId() %>"
                   class="btn btn-secondary">
                    <i class="fas fa-times"></i>
                    Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<!-- Confirmation Modal -->
<div class="modal-overlay" id="confirmModal">
    <div class="modal">
        <div class="modal-icon">
            <i class="fas fa-question"></i>
        </div>
        <h3 class="modal-title">Confirm Changes</h3>
        <p class="modal-message">Are you sure you want to save these changes?</p>
        <div class="modal-actions">
            <button class="btn btn-primary" onclick="confirmSave()">
                <i class="fas fa-check"></i>
                Yes, Save
            </button>
            <button class="btn btn-secondary" onclick="closeModal()">
                <i class="fas fa-times"></i>
                Cancel
            </button>
        </div>
    </div>
</div>

<script>
    // Global variables
    const form = document.getElementById('editCustomerForm');
    const submitBtn = document.getElementById('submitBtn');
    const changesSummary = document.getElementById('changesSummary');
    const changesList = document.getElementById('changesList');
    const toastContainer = document.getElementById('toastContainer');

    // Field tracking
    const fields = {
        name: document.getElementById('name'),
        email: document.getElementById('email'),
        phone: document.getElementById('phone'),
        address: document.getElementById('address'),
        membershipType: document.getElementById('membershipType'),
        totalPurchases: document.getElementById('totalPurchases'),
        loyaltyPoints: document.getElementById('loyaltyPoints')
    };

    // Validation rules
    const validators = {
        name: {
            required: true,
            minLength: 2,
            maxLength: 100,
            pattern: /^[A-Za-z\s\-'.]+$/,
            message: 'Name should only contain letters, spaces, hyphens, and apostrophes'
        },
        email: {
            required: true,
            pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
            message: 'Please enter a valid email address'
        },
        phone: {
            required: true,
            pattern: /^[\d\s\-\+\(\)]+$/,
            minLength: 7,
            maxLength: 15,
            message: 'Please enter a valid phone number'
        },
        address: {
            required: true,
            minLength: 10,
            maxLength: 500,
            message: 'Address must be between 10 and 500 characters'
        },
        totalPurchases: {
            min: 0,
            pattern: /^\d+(\.\d{1,2})?$/,
            message: 'Please enter a valid amount'
        },
        loyaltyPoints: {
            min: 0,
            pattern: /^\d+$/,
            message: 'Please enter a valid number'
        }
    };

    // Initialize
    document.addEventListener('DOMContentLoaded', function() {
        initializeForm();
        setupEventListeners();
        checkForChanges();

        // Show keyboard shortcuts tooltip
        setTimeout(() => {
            showToast('info', 'Tip', 'Use Ctrl+S to save changes quickly!');
        }, 3000);
    });

    // Initialize form
    function initializeForm() {
        // Focus first field
        fields.name.focus();

        // Load saved draft if exists
        loadDraft();
    }

    // Setup event listeners
    function setupEventListeners() {
        // Field change listeners
        Object.keys(fields).forEach(fieldName => {
            const field = fields[fieldName];

            field.addEventListener('input', () => {
                validateField(fieldName);
                checkForChanges();
                saveDraft();
            });

            field.addEventListener('blur', () => {
                validateField(fieldName);
            });

            // Add animation on focus
            field.addEventListener('focus', function() {
                this.parentElement.querySelector('.input-icon').style.color = 'var(--primary-color)';
            });

            field.addEventListener('blur', function() {
                this.parentElement.querySelector('.input-icon').style.color = 'var(--text-secondary)';
            });
        });

        // Form submit
        form.addEventListener('submit', handleSubmit);

        // Keyboard shortcuts
        document.addEventListener('keydown', handleKeyboardShortcuts);

        // Prevent accidental navigation
        window.addEventListener('beforeunload', handleBeforeUnload);

        // Phone formatting
        fields.phone.addEventListener('input', formatPhoneNumber);

        // Email lowercase
        fields.email.addEventListener('blur', function() {
            this.value = this.value.toLowerCase().trim();
        });
    }

    // Validate field
    function validateField(fieldName) {
        const field = fields[fieldName];
        const value = field.value.trim();
        const validator = validators[fieldName];
        const errorElement = document.getElementById(fieldName + 'Error');

        if (!validator) return true;

        let isValid = true;
        let errorMessage = '';

        // Required check
        if (validator.required && !value) {
            isValid = false;
            errorMessage = fieldName.charAt(0).toUpperCase() + fieldName.slice(1) + ' is required';
        }
        // Min length check
        else if (validator.minLength && value.length < validator.minLength) {
            isValid = false;
            errorMessage = 'Minimum ' + validator.minLength + ' characters required';
        }
        // Max length check
        else if (validator.maxLength && value.length > validator.maxLength) {
            isValid = false;
            errorMessage = 'Maximum ' + validator.maxLength + ' characters allowed';
        }
        // Pattern check
        else if (validator.pattern && !validator.pattern.test(value)) {
            isValid = false;
            errorMessage = validator.message;
        }
        // Min value check
        else if (validator.min !== undefined && parseFloat(value) < validator.min) {
            isValid = false;
            errorMessage = 'Value must be at least ' + validator.min;
        }

        // Update UI
        if (isValid) {
            field.classList.remove('has-error');
            field.classList.add('has-success');
            if (errorElement) {
                errorElement.classList.remove('show');
            }
        } else {
            field.classList.add('has-error');
            field.classList.remove('has-success');
            if (errorElement) {
                errorElement.querySelector('span').textContent = errorMessage;
                errorElement.classList.add('show');
            }
        }

        return isValid;
    }

    // Check for changes
    function checkForChanges() {
        const changes = [];
        let hasChanges = false;

        Object.keys(fields).forEach(fieldName => {
            const field = fields[fieldName];
            const currentValue = field.value.trim();
            const originalValue = field.getAttribute('data-original').trim();
            const changeIndicator = document.getElementById(fieldName + 'Change');

            if (currentValue !== originalValue) {
                hasChanges = true;
                field.classList.add('modified');
                if (changeIndicator) {
                    changeIndicator.classList.add('show');
                }

                // Format change text
                let changeText = formatFieldName(fieldName);
                let changeItem = '';

                if (fieldName === 'totalPurchases') {
                    changeItem = changeText + ': $' + originalValue + ' → $' + currentValue;
                } else if (fieldName === 'loyaltyPoints') {
                    changeItem = changeText + ': ' + originalValue + ' → ' + currentValue + ' points';
                } else {
                    changeItem = changeText + ': "' + originalValue + '" → "' + currentValue + '"';
                }

                changes.push(changeItem);
            } else {
                field.classList.remove('modified');
                if (changeIndicator) {
                    changeIndicator.classList.remove('show');
                }
            }
        });

        // Update UI
        if (hasChanges) {
            let changesHTML = '';
            changes.forEach((change, index) => {
                changesHTML += '<li class="change-item" style="animation-delay: ' + (index * 0.1) + 's;">';
                changesHTML += '<i class="fas fa-chevron-right"></i> ' + change;
                changesHTML += '</li>';
            });
            changesList.innerHTML = changesHTML;
            changesSummary.classList.add('show');
            submitBtn.disabled = false;
        } else {
            changesSummary.classList.remove('show');
            submitBtn.disabled = true;
        }
    }

    // Format field name
    function formatFieldName(fieldName) {
        return fieldName
            .replace(/([A-Z])/g, ' $1')
            .replace(/^./, str => str.toUpperCase());
    }

    // Handle form submit
    function handleSubmit(e) {
        e.preventDefault();

        // Validate all fields
        let isValid = true;
        Object.keys(fields).forEach(fieldName => {
            if (!validateField(fieldName)) {
                isValid = false;
            }
        });

        if (!isValid) {
            showToast('error', 'Validation Error', 'Please fix all errors before submitting');
            return;
        }

        // Check for changes
        if (submitBtn.disabled) {
            showToast('warning', 'No Changes', 'No changes have been made');
            return;
        }

        // Show confirmation modal
        showModal();
    }

    // Show modal
    function showModal() {
        const modal = document.getElementById('confirmModal');
        modal.classList.add('show');
    }

    // Close modal
    function closeModal() {
        const modal = document.getElementById('confirmModal');
        modal.classList.remove('show');
    }

    // Confirm save
    function confirmSave() {
        closeModal();

        // Show loading state
        submitBtn.classList.add('btn-loading');
        submitBtn.disabled = true;

        // Clear draft
        clearDraft();

        // Submit form
        setTimeout(() => {
            form.submit();
        }, 500);
    }

    // Format phone number
    function formatPhoneNumber(e) {
        let value = e.target.value.replace(/[^\d]/g, '');
        if (value.length > 0) {
            if (value.length <= 3) {
                value = value;
            } else if (value.length <= 6) {
                value = value.slice(0, 3) + '-' + value.slice(3);
            } else {
                value = value.slice(0, 3) + '-' + value.slice(3, 6) + '-' + value.slice(6, 10);
            }
        }
        e.target.value = value;
    }

    // Save draft
    function saveDraft() {
        const draft = {};
        Object.keys(fields).forEach(fieldName => {
            draft[fieldName] = fields[fieldName].value;
        });
        localStorage.setItem('customerEdit_<%= customer.getCustomerId() %>', JSON.stringify(draft));
    }

    // Load draft
    function loadDraft() {
        const draftData = localStorage.getItem('customerEdit_<%= customer.getCustomerId() %>');
        if (draftData) {
            const draft = JSON.parse(draftData);
            let hasDraft = false;

            Object.keys(draft).forEach(fieldName => {
                if (fields[fieldName] && draft[fieldName] !== fields[fieldName].getAttribute('data-original')) {
                    fields[fieldName].value = draft[fieldName];
                    hasDraft = true;
                }
            });

            if (hasDraft) {
                checkForChanges();
                showToast('info', 'Draft Restored', 'Previous changes have been restored');
            }
        }
    }

    // Clear draft
    function clearDraft() {
        localStorage.removeItem('customerEdit_<%= customer.getCustomerId() %>');
    }

    // Handle keyboard shortcuts
    function handleKeyboardShortcuts(e) {
        // Ctrl/Cmd + S: Save
        if ((e.ctrlKey || e.metaKey) && e.key === 's') {
            e.preventDefault();
            if (!submitBtn.disabled) {
                handleSubmit(e);
            }
        }

        // Ctrl/Cmd + Z: Reset
        if ((e.ctrlKey || e.metaKey) && e.key === 'z') {
            e.preventDefault();
            resetForm();
        }

        // Escape: Cancel
        if (e.key === 'Escape') {
            if (!submitBtn.disabled) {
                if (confirm('You have unsaved changes. Are you sure you want to leave?')) {
                    window.location.href = '${pageContext.request.contextPath}/customer?action=view&customerId=<%= customer.getCustomerId() %>';
                }
            } else {
                window.location.href = '${pageContext.request.contextPath}/customer?action=view&customerId=<%= customer.getCustomerId() %>';
            }
        }
    }

    // Handle before unload
    function handleBeforeUnload(e) {
        if (!submitBtn.disabled) {
            e.preventDefault();
            e.returnValue = '';
        }
    }

    // Reset form
    function resetForm() {
        Object.keys(fields).forEach(fieldName => {
            const field = fields[fieldName];
            field.value = field.getAttribute('data-original');
            field.classList.remove('has-error', 'has-success', 'modified');
            const errorElement = document.getElementById(fieldName + 'Error');
            if (errorElement) {
                errorElement.classList.remove('show');
            }
        });
        checkForChanges();
        showToast('info', 'Form Reset', 'All changes have been discarded');
    }

    // Show toast notification - Fixed to avoid JSP EL conflicts
    function showToast(type, title, message) {
        const toast = document.createElement('div');
        toast.className = 'toast toast-' + type;

        const iconClass = getToastIcon(type);

        // Build HTML using string concatenation to avoid JSP EL issues
        let toastHTML = '<i class="fas fa-' + iconClass + ' toast-icon"></i>';
        toastHTML += '<div class="toast-content">';
        toastHTML += '<div class="toast-title">' + title + '</div>';
        toastHTML += '<div class="toast-message">' + message + '</div>';
        toastHTML += '</div>';
        toastHTML += '<button class="toast-close" onclick="closeToast(this)">';
        toastHTML += '<i class="fas fa-times"></i>';
        toastHTML += '</button>';
        toastHTML += '<div class="toast-progress"></div>';

        toast.innerHTML = toastHTML;
        toastContainer.appendChild(toast);

        // Auto close after 5 seconds
        setTimeout(() => {
            closeToast(toast.querySelector('.toast-close'));
        }, 5000);
    }

    // Get toast icon
    function getToastIcon(type) {
        const icons = {
            success: 'check-circle',
            error: 'exclamation-circle',
            warning: 'exclamation-triangle',
            info: 'info-circle'
        };
        return icons[type] || 'info-circle';
    }

    // Close toast
    function closeToast(element) {
        const toast = element.closest ? element.closest('.toast') : element.parentElement;
        if (toast) {
            toast.classList.add('hide');
            setTimeout(() => {
                toast.remove();
            }, 500);
        }
    }

    // Auto-save every 30 seconds
    setInterval(() => {
        if (!submitBtn.disabled) {
            saveDraft();
            console.log('Draft saved automatically');
        }
    }, 30000);

    console.log('✨ Pahana Edu  Customer Edit initialized');
</script>
</body>
</html>
