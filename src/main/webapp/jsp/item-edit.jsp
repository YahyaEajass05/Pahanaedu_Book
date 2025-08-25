Here's the complete item-edit.jsp with modern UI design for your bookstore management system:

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Item" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book - <%= request.getAttribute("item") != null ? ((Item)request.getAttribute("item")).getItemName() : "" %> - Pahana Edu </title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
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

        .page-header::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: var(--warning-gradient);
            opacity: 0.1;
            border-radius: 50%;
            animation: pulse 4s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .header-content {
            position: relative;
            z-index: 1;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .page-subtitle {
            color: var(--text-secondary);
            font-size: 1.125rem;
        }

        .book-info-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--warning-gradient);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            margin-left: 1rem;
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

        .notification-warning {
            background: linear-gradient(135deg, #F59E0B 0%, #FCD34D 100%);
            color: white;
        }

        .notification-info {
            background: linear-gradient(135deg, #3B82F6 0%, #60A5FA 100%);
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

        /* Alert Messages */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            animation: slideUp 0.5s ease-out;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        /* Form Container */
        .form-container {
            background: var(--bg-secondary);
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
            animation: slideUp 0.6s ease-out 0.2s both;
        }

        .form-header {
            background: var(--warning-gradient);
            padding: 1.5rem 2rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .form-header h3 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .last-updated {
            font-size: 0.875rem;
            opacity: 0.9;
        }

        .form-body {
            padding: 2rem;
        }

        /* Compare Section */
        .compare-section {
            background: var(--bg-primary);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 2px solid var(--warning-color);
            animation: fadeIn 0.6s ease-out;
        }

        .compare-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-top: 1rem;
        }

        .compare-column {
            text-align: center;
        }

        .compare-label {
            font-size: 0.875rem;
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .compare-value {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .compare-value.changed {
            color: var(--warning-color);
            position: relative;
        }

        .compare-arrow {
            display: inline-block;
            margin: 0 0.5rem;
            color: var(--warning-color);
            animation: arrowPulse 1s ease-in-out infinite;
        }

        @keyframes arrowPulse {
            0%, 100% { transform: translateX(0); }
            50% { transform: translateX(5px); }
        }

        /* Form Sections */
        .form-section {
            background: var(--bg-primary);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .form-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--warning-gradient);
            opacity: 0;
            transition: opacity 0.3s ease;
            pointer-events: none;
        }

        .form-section:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-2px);
        }

        .form-section:hover::before {
            opacity: 0.03;
        }

        .section-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-title i {
            color: var(--warning-color);
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }

        .form-grid.single {
            grid-template-columns: 1fr;
        }

        /* Form Groups */
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            position: relative;
        }

        .form-label {
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .required::after {
            content: '*';
            color: var(--danger-color);
            margin-left: 0.25rem;
        }

        .form-input {
            padding: 0.875rem 1.25rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--warning-color);
            box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.1);
            transform: translateY(-2px);
        }

        .form-input:disabled {
            background: var(--bg-primary);
            cursor: not-allowed;
            opacity: 0.7;
        }

        .form-input.error {
            border-color: var(--danger-color);
            background: rgba(239, 68, 68, 0.05);
            animation: shake 0.5s ease-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .form-input.success {
            border-color: var(--success-color);
            background: rgba(16, 185, 129, 0.05);
        }

        .form-input.changed {
            border-color: var(--warning-color);
            background: rgba(245, 158, 11, 0.05);
        }

        .form-textarea {
            padding: 0.875rem 1.25rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            resize: vertical;
            min-height: 100px;
        }

        .form-textarea:focus {
            outline: none;
            border-color: var(--warning-color);
            box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.1);
        }

        /* Input with Icon */
        .input-icon-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .input-icon-wrapper:focus-within .input-icon {
            color: var(--warning-color);
        }

        .input-icon-wrapper .form-input {
            padding-left: 2.75rem;
        }

        /* Currency Input */
        .currency-input {
            position: relative;
        }

        .currency-symbol {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--warning-color);
            font-weight: 600;
            pointer-events: none;
        }

        .currency-input .form-input {
            padding-left: 3.5rem;
        }

        /* Help Text */
        .help-text {
            font-size: 0.75rem;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .help-text i {
            font-size: 0.875rem;
            color: var(--warning-color);
        }

        /* Error Messages */
        .error-message {
            font-size: 0.75rem;
            color: var(--danger-color);
            display: none;
            align-items: center;
            gap: 0.25rem;
            animation: errorSlideIn 0.3s ease-out;
        }

        .error-message.show {
            display: flex;
        }

        .error-message i {
            font-size: 0.875rem;
            animation: errorShake 0.5s ease-out;
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

        @keyframes errorShake {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(-10deg); }
            75% { transform: rotate(10deg); }
        }

        /* Change Indicator */
        .change-indicator {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            width: 8px;
            height: 8px;
            background: var(--warning-color);
            border-radius: 50%;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .form-input.changed ~ .change-indicator {
            opacity: 1;
            animation: pulse 2s ease-in-out infinite;
        }

        /* Price Calculator */
        .price-calculator {
            background: var(--bg-primary);
            border-radius: 16px;
            padding: 1.5rem;
            margin-top: 1.5rem;
            border: 2px solid var(--warning-color);
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.3s ease;
        }

        .price-calculator.show {
            opacity: 1;
            transform: translateY(0);
        }

        .calculator-header {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
            color: var(--warning-color);
            font-weight: 600;
        }

        .calculator-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            font-size: 0.875rem;
        }

        .calculator-row.total {
            border-top: 2px solid var(--border-color);
            margin-top: 0.5rem;
            padding-top: 1rem;
            font-weight: 700;
            font-size: 1rem;
            color: var(--warning-color);
        }

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: space-between;
            padding: 2rem;
            background: var(--bg-primary);
            border-top: 1px solid var(--border-color);
        }

        .action-group {
            display: flex;
            gap: 1rem;
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
            background: var(--warning-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(245, 158, 11, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(245, 158, 11, 0.5);
        }

        .btn-secondary {
            background: var(--dark-gradient);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.4);
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
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

        .btn-loading {
            position: relative;
            color: transparent;
        }

        .btn-loading::before {
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
            border-top-color: var(--warning-color);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Character Counter */
        .char-counter {
            position: absolute;
            right: 1rem;
            bottom: -1.5rem;
            font-size: 0.75rem;
            color: var(--text-secondary);
            transition: color 0.3s ease;
        }

        .char-counter.warning {
            color: var(--warning-color);
        }

        .char-counter.danger {
            color: var(--danger-color);
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

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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

            .page-header {
                padding: 2rem;
            }

            .page-title {
                font-size: 1.75rem;
                flex-direction: column;
                align-items: flex-start;
            }

            .book-info-badge {
                margin-left: 0;
                margin-top: 0.5rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .compare-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .form-actions {
                flex-direction: column;
                gap: 1rem;
            }

            .action-group {
                width: 100%;
                flex-direction: column;
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
    <div class="float-element">✏️</div>
    <div class="float-element">📖</div>
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
        
        @SuppressWarnings("unchecked")
        java.util.List<String> categories = (java.util.List<String>) request.getAttribute("categories");
        if (categories == null) {
            categories = new java.util.ArrayList<>();
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
    <!-- Page Header -->
    <div class="page-header">
        <div class="header-content">
            <h1 class="page-title">
                <i class="fas fa-edit"></i>
                Edit Book
                <span class="book-info-badge">
                        <i class="fas fa-barcode"></i>
                        <%= item.getItemId() %>
                    </span>
            </h1>
            <p class="page-subtitle">Update book information and manage inventory</p>
        </div>
    </div>

    <!-- Display Error Messages -->
        <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i>
        <%= request.getAttribute("errorMessage") %>
    </div>
        <% } %>

    <!-- Form Container -->
    <div class="form-container">
        <div class="form-header">
            <h3>
                <i class="fas fa-book"></i>
                Editing: <%= item.getItemName() %>
            </h3>
            <% if (item.getUpdatedAt() != null) { %>
            <span class="last-updated">
                        <i class="fas fa-clock"></i>
                        Last updated: <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(item.getUpdatedAt()) %>
                    </span>
            <% } %>
        </div>

        <form id="editBookForm" action="${pageContext.request.contextPath}/item" method="post" novalidate>
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
            <input type="hidden" id="originalData" value='{}'>

            <div class="form-body">
                <!-- Change Comparison Section -->
                <div class="compare-section" id="compareSection" style="display: none;">
                    <h4 class="section-title">
                        <i class="fas fa-exchange-alt"></i>
                        Pending Changes
                    </h4>
                    <div class="compare-grid" id="compareGrid">
                        <!-- Changes will be shown here dynamically -->
                    </div>
                </div>

                <!-- Basic Information -->
                <div class="form-section">
                    <h4 class="section-title">
                        <i class="fas fa-info-circle"></i>
                        Basic Information
                    </h4>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label required" for="itemId">
                                <i class="fas fa-barcode"></i>
                                ISBN
                            </label>
                            <div class="input-icon-wrapper">
                                <i class="fas fa-fingerprint input-icon"></i>
                                <input type="text"
                                       id="itemIdDisplay"
                                       class="form-input"
                                       value="<%= item.getItemId() %>"
                                       disabled>
                                <span class="change-indicator"></span>
                            </div>
                            <div class="help-text">
                                <i class="fas fa-info-circle"></i>
                                ISBN cannot be changed
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label required" for="itemName">
                                <i class="fas fa-book"></i>
                                Book Title
                            </label>
                            <div class="input-icon-wrapper">
                                <i class="fas fa-pen input-icon"></i>
                                <input type="text"
                                       id="itemName"
                                       name="itemName"
                                       class="form-input"
                                       value="<%= item.getItemName() %>"
                                       data-original="<%= item.getItemName() %>"
                                       placeholder="Enter book title"
                                       required
                                       maxlength="100">
                                <span class="change-indicator"></span>
                            </div>
                            <div class="help-text">
                                <i class="fas fa-info-circle"></i>
                                Enter the complete title of the book
                            </div>
                            <div id="itemNameError" class="error-message">
                                <i class="fas fa-exclamation-circle"></i>
                                <span></span>
                            </div>
                        </div>
                    </div>

                    <div class="form-grid single">
                        <div class="form-group">
                            <label class="form-label" for="category">
                                <i class="fas fa-tag"></i>
                                Category
                            </label>
                            <select id="category"
                                    name="category"
                                    class="form-input"
                                    data-original="<%= item.getCategory() != null ? item.getCategory() : "" %>">
                                <option value="">Select a category</option>
                                <%
                                    String[] defaultCategories = {
                                            "Fiction", "Non-Fiction", "Science", "Mathematics",
                                            "History", "Biography", "Self-Help", "Children",
                                            "Technology", "Arts", "Business", "Education"
                                    };
                                    String currentCategory = item.getCategory();
                                    for (String cat : defaultCategories) {
                                %>
                                <option value="<%= cat %>"
                                        <%= cat.equals(currentCategory) ? "selected" : "" %>>
                                    <%= cat %>
                                </option>
                                <% } %>
                                <% for (String cat : categories) {
                                    boolean isDuplicate = false;
                                    for (String defaultCat : defaultCategories) {
                                        if (defaultCat.equals(cat)) {
                                            isDuplicate = true;
                                            break;
                                        }
                                    }
                                    if (!isDuplicate) {
                                %>
                                <option value="<%= cat %>"
                                        <%= cat.equals(currentCategory) ? "selected" : "" %>>
                                    <%= cat %>
                                </option>
                                <% }} %>
                            </select>
                            <span class="change-indicator"></span>
                            <div class="help-text">
                                <i class="fas fa-info-circle"></i>
                                Select or add a category for better organization
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pricing & Stock -->
                <div class="form-section">
                    <h4 class="section-title">
                        <i class="fas fa-dollar-sign"></i>
                        Pricing & Stock
                    </h4>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label required" for="price">
                                <i class="fas fa-tag"></i>
                                Price
                            </label>
                            <div class="currency-input">
                                <span class="currency-symbol">LKR</span>
                                <input type="number"
                                       id="price"
                                       name="price"
                                       class="form-input"
                                       value="<%= item.getPrice() %>"
                                       data-original="<%= item.getPrice() %>"
                                       placeholder="0.00"
                                       required
                                       min="0.01"
                                       step="0.01">
                                <span class="change-indicator"></span>
                            </div>
                            <div class="help-text">
                                <i class="fas fa-info-circle"></i>
                                Enter the selling price
                            </div>
                            <div id="priceError" class="error-message">
                                <i class="fas fa-exclamation-circle"></i>
                                <span></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label required" for="stock">
                                <i class="fas fa-boxes"></i>
                                Stock Quantity
                            </label>
                            <div class="input-icon-wrapper">
                                <i class="fas fa-warehouse input-icon"></i>
                                <input type="number"
                                       id="stock"
                                       name="stock"
                                       class="form-input"
                                       value="<%= item.getStock() %>"
                                       data-original="<%= item.getStock() %>"
                                       placeholder="0"
                                       required
                                       min="0"
                                       max="9999">
                                <span class="change-indicator"></span>
                            </div>
                            <div class="help-text">
                                <i class="fas fa-info-circle"></i>
                                Number of units available
                            </div>
                            <div id="stockError" class="error-message">
                                <i class="fas fa-exclamation-circle"></i>
                                <span></span>
                            </div>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="discountPercentage">
                                <i class="fas fa-percentage"></i>
                                Discount Percentage
                            </label>
                            <div class="input-icon-wrapper">
                                <i class="fas fa-tag input-icon"></i>
                                <input type="number"
                                       id="discountPercentage"
                                       name="discountPercentage"
                                       class="form-input"
                                       value="<%= item.getDiscountPercentage() != null ? item.getDiscountPercentage() : "0" %>"
                                       data-original="<%= item.getDiscountPercentage() != null ? item.getDiscountPercentage() : "0" %>"
                                       placeholder="0"
                                       min="0"
                                       max="100"
                                       step="0.01">
                                <span class="change-indicator"></span>
                            </div>
                            <div class="help-text">
                                <i class="fas fa-info-circle"></i>
                                Enter discount percentage (0-100)
                            </div>
                            <div id="discountError" class="error-message">
                                <i class="fas fa-exclamation-circle"></i>
                                <span></span>
                            </div>
                        </div>
                    </div>

                    <!-- Price Calculator -->
                    <div id="priceCalculator" class="price-calculator">
                        <div class="calculator-header">
                            <i class="fas fa-calculator"></i>
                            Inventory Value Calculator
                        </div>
                        <div class="calculator-row">
                            <span>Unit Price:</span>
                            <span id="calcUnitPrice">LKR 0.00</span>
                        </div>
                        <div class="calculator-row">
                            <span>Discount:</span>
                            <span id="calcDiscount">0%</span>
                        </div>
                        <div class="calculator-row">
                            <span>Sale Price:</span>
                            <span id="calcSalePrice">LKR 0.00</span>
                        </div>
                        <div class="calculator-row">
                            <span>Stock Quantity:</span>
                            <span id="calcQuantity">0 units</span>
                        </div>
                        <div class="calculator-row total">
                            <span>Total Inventory Value:</span>
                            <span id="calcTotalValue">LKR 0.00</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <div class="action-group">
                    <a href="${pageContext.request.contextPath}/item?action=delete&itemId=<%= item.getItemId() %>"
                       class="btn btn-danger"
                       onclick="return confirmDelete()">
                        <i class="fas fa-trash"></i>
                        Delete Book
                    </a>
                </div>
                <div class="action-group">
                    <a href="${pageContext.request.contextPath}/item?action=view&itemId=<%= item.getItemId() %>"
                       class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                    <button type="submit" id="submitBtn" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        <span class="btn-text">Save Changes</span>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loader"></div>
</div>

<script>
    // Store original values
    const originalData = {
        itemId: '<%= item.getItemId() %>',
        itemName: '<%= item.getItemName() %>',
        category: '<%= item.getCategory() != null ? item.getCategory() : "" %>',
        price: '<%= item.getPrice() %>',
        stock: '<%= item.getStock() %>',
        discountPercentage: '<%= item.getDiscountPercentage() != null ? item.getDiscountPercentage() : "0" %>'
    };

    // Form elements
    const form = document.getElementById('editBookForm');
    const submitBtn = document.getElementById('submitBtn');
    const compareSection = document.getElementById('compareSection');
    const compareGrid = document.getElementById('compareGrid');
    const fields = {
        itemName: document.getElementById('itemName'),
        category: document.getElementById('category'),
        price: document.getElementById('price'),
        stock: document.getElementById('stock'),
        discountPercentage: document.getElementById('discountPercentage')
    };

    // Price calculator elements
    const priceCalculator = document.getElementById('priceCalculator');
    const calcElements = {
        unitPrice: document.getElementById('calcUnitPrice'),
        discount: document.getElementById('calcDiscount'),
        salePrice: document.getElementById('calcSalePrice'),
        quantity: document.getElementById('calcQuantity'),
        totalValue: document.getElementById('calcTotalValue')
    };

    // Track changes
    let hasChanges = false;
    const changes = {};

    // Notification System
    function showNotification(message, type = 'info', duration = 5000) {
        const container = document.getElementById('notificationContainer');

        const notification = document.createElement('div');
        notification.className = 'notification notification-' + type;

        const icon = document.createElement('div');
        icon.className = 'notification-icon';
        icon.innerHTML = type === 'success' ? '<i class="fas fa-check-circle"></i>' :
            type === 'error' ? '<i class="fas fa-exclamation-circle"></i>' :
                type === 'warning' ? '<i class="fas fa-exclamation-triangle"></i>' :
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

    // Validation Rules
    const validationRules = {
        itemName: {
            required: true,
            minLength: 2,
            maxLength: 100,
            message: 'Book title must be 2-100 characters'
        },
        price: {
            required: true,
            min: 0.01,
            max: 999999.99,
            message: 'Price must be between LKR 0.01 and LKR 999,999.99'
        },
        stock: {
            required: true,
            min: 0,
            max: 9999,
            message: 'Stock must be between 0 and 9999'
        },
        discountPercentage: {
            required: false,
            min: 0,
            max: 100,
            message: 'Discount must be between 0% and 100%'
        }
    };

    // Validate individual field
    function validateField(fieldName) {
        const field = fields[fieldName];
        if (!field) return true;

        const rule = validationRules[fieldName];
        const value = field.value.trim();
        const errorElement = document.getElementById(fieldName + 'Error');

        let isValid = true;
        let errorMessage = '';

        // Required check
        if (rule.required && !value) {
            isValid = false;
            errorMessage = fieldName.replace(/([A-Z])/g, ' $1').trim() + ' is required';
        }
        // Length checks
        else if (rule.minLength && value.length < rule.minLength) {
            isValid = false;
            errorMessage = rule.message;
        }
        else if (rule.maxLength && value.length > rule.maxLength) {
            isValid = false;
            errorMessage = rule.message;
        }
        // Number checks
        else if (rule.min !== undefined && parseFloat(value) < rule.min) {
            isValid = false;
            errorMessage = rule.message;
        }
        else if (rule.max !== undefined && parseFloat(value) > rule.max) {
            isValid = false;
            errorMessage = rule.message;
        }

        // Update UI
        if (isValid) {
            field.classList.remove('error');
            if (errorElement) {
                errorElement.classList.remove('show');
            }
        } else {
            field.classList.add('error');
            if (errorElement) {
                errorElement.querySelector('span').textContent = errorMessage;
                errorElement.classList.add('show');
            }
        }

        return isValid;
    }

    // Validate entire form
    function validateForm() {
        let isValid = true;

        for (const fieldName in validationRules) {
            if (!validateField(fieldName)) {
                isValid = false;
            }
        }

        return isValid;
    }

    // Check for changes
    function checkForChanges() {
        hasChanges = false;
        const changedFields = [];

        for (const fieldName in fields) {
            const field = fields[fieldName];
            const originalValue = field.getAttribute('data-original') || '';
            const currentValue = field.value;

            if (originalValue !== currentValue) {
                hasChanges = true;
                field.classList.add('changed');
                changes[fieldName] = {
                    original: originalValue,
                    current: currentValue
                };
                changedFields.push({
                    name: fieldName,
                    label: getFieldLabel(fieldName),
                    original: originalValue || 'None',
                    current: currentValue || 'None'
                });
            } else {
                field.classList.remove('changed');
                delete changes[fieldName];
            }
        }

        // Update compare section
        if (changedFields.length > 0) {
            compareSection.style.display = 'block';
            compareGrid.innerHTML = changedFields.map(field => `
                    <div class="compare-column">
                        <div class="compare-label">${field.label} - Original</div>
                        <div class="compare-value">${field.original}</div>
                    </div>
                    <div class="compare-column">
                        <div class="compare-label">${field.label} - New</div>
                        <div class="compare-value changed">${field.current}</div>
                    </div>
                `).join('');
        } else {
            compareSection.style.display = 'none';
        }

        // Update submit button
        if (hasChanges) {
            submitBtn.querySelector('.btn-text').textContent = 'Save Changes (' + changedFields.length + ')';
        } else {
            submitBtn.querySelector('.btn-text').textContent = 'Save Changes';
        }

        return hasChanges;
    }

    function getFieldLabel(fieldName) {
        const labels = {
            itemName: 'Book Title',
            category: 'Category',
            price: 'Price',
            stock: 'Stock',
            discountPercentage: 'Discount'
        };
        return labels[fieldName] || fieldName;
    }

    // Update price calculator
    function updatePriceCalculator() {
        const price = parseFloat(fields.price.value) || 0;
        const stock = parseInt(fields.stock.value) || 0;
        const discount = parseFloat(fields.discountPercentage.value) || 0;

        const salePrice = price * (1 - discount / 100);
        const totalValue = salePrice * stock;

        calcElements.unitPrice.textContent = 'LKR ' + price.toFixed(2).toLocaleString();
        calcElements.discount.textContent = discount.toFixed(0) + '%';
        calcElements.salePrice.textContent = 'LKR ' + salePrice.toFixed(2).toLocaleString();
        calcElements.quantity.textContent = stock + ' units';
        calcElements.totalValue.textContent = 'LKR ' + totalValue.toFixed(2).toLocaleString();

        // Show calculator
        priceCalculator.classList.add('show');
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

    // Confirm Delete
    function confirmDelete() {
        const bookName = '<%= item.getItemName() %>';
        return confirm('Are you sure you want to delete "' + bookName + '"?\n\nThis action cannot be undone and will remove the book from your inventory.');
    }

    // Add event listeners
    for (const fieldName in fields) {
        const field = fields[fieldName];

        // Check for changes on input
        field.addEventListener('input', () => {
            checkForChanges();

            // Validate on input if there's an error
            if (field.classList.contains('error')) {
                validateField(fieldName);
            }

            // Update calculator for relevant fields
            if (['price', 'stock', 'discountPercentage'].includes(fieldName)) {
                updatePriceCalculator();
            }
        });

        // Validate on blur
        field.addEventListener('blur', () => {
            validateField(fieldName);
        });
    }

    // Form submission
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        if (!checkForChanges()) {
            showNotification('No changes detected', 'warning');
            return;
        }

        if (validateForm()) {
            // Show loading
            showLoading(true);
            submitBtn.classList.add('btn-loading');
            submitBtn.disabled = true;

            // Show saving notification
            showNotification('Saving changes...', 'info');

            // Submit form after brief delay
            setTimeout(() => {
                form.submit();
            }, 500);
        } else {
            // Show error notification
            showNotification('Please fix the errors in the form', 'error');

            // Scroll to first error
            const firstError = document.querySelector('.form-input.error');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstError.focus();
            }
        }
    });

    // Warn about unsaved changes
    window.addEventListener('beforeunload', function(e) {
        if (hasChanges) {
            e.preventDefault();
            e.returnValue = 'You have unsaved changes. Are you sure you want to leave?';
        }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl/Cmd + S to save
        if ((e.ctrlKey || e.metaKey) && e.key === 's') {
            e.preventDefault();
            form.dispatchEvent(new Event('submit'));
        }

        // Ctrl/Cmd + R to reset
        if ((e.ctrlKey || e.metaKey) && e.key === 'r') {
            e.preventDefault();
            if (confirm('Reset all changes to original values?')) {
                resetForm();
            }
        }

        // ESC to cancel
        if (e.key === 'Escape') {
            if (hasChanges) {
                if (confirm('You have unsaved changes. Are you sure you want to cancel?')) {
                    window.location.href = '${pageContext.request.contextPath}/item?action=view&itemId=<%= item.getItemId() %>';
                }
            } else {
                window.location.href = '${pageContext.request.contextPath}/item?action=view&itemId=<%= item.getItemId() %>';
            }
        }
    });

    // Reset form to original values
    function resetForm() {
        for (const fieldName in fields) {
            const field = fields[fieldName];
            const originalValue = field.getAttribute('data-original') || '';
            field.value = originalValue;
            field.classList.remove('changed', 'error');
        }
        checkForChanges();
        updatePriceCalculator();
        showNotification('Form reset to original values', 'info');
    }

    // Initialize on load
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize calculator
        updatePriceCalculator();

        // Check for initial changes (in case of browser autofill)
        checkForChanges();

        // Add field animations
        const formSections = document.querySelectorAll('.form-section');
        formSections.forEach((section, index) => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(20px)';
            setTimeout(() => {
                section.style.transition = 'all 0.5s ease';
                section.style.opacity = '1';
                section.style.transform = 'translateY(0)';
            }, index * 100);
        });

        // Show keyboard shortcuts tip
        setTimeout(() => {
            showNotification('Tip: Use Ctrl+S to save, Ctrl+R to reset, ESC to cancel', 'info', 4000);
        }, 2000);
    });

    // Character counter for text fields
    function addCharacterCounter(field, maxLength) {
        const wrapper = field.closest('.form-group');
        const counter = document.createElement('div');
        counter.className = 'char-counter';
        counter.style.position = 'relative';
        counter.style.textAlign = 'right';
        counter.style.fontSize = '0.75rem';
        counter.style.color = 'var(--text-secondary)';
        counter.style.marginTop = '0.25rem';

        function updateCounter() {
            const remaining = maxLength - field.value.length;
            counter.textContent = remaining + ' characters remaining';

            if (remaining < 10) {
                counter.classList.add('danger');
            } else if (remaining < 20) {
                counter.classList.add('warning');
            } else {
                counter.classList.remove('danger', 'warning');
            }
        }

        field.addEventListener('input', updateCounter);
        wrapper.appendChild(counter);
        updateCounter();
    }

    // Add character counters
    addCharacterCounter(fields.itemName, 100);

    // Enhanced form validation feedback
    const formInputs = document.querySelectorAll('.form-input');
    formInputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
            this.parentElement.style.transition = 'transform 0.2s ease';
        });

        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
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

    // Add ripple animation
    const style = document.createElement('style');
    style.textContent = '@keyframes ripple-effect { to { transform: scale(4); opacity: 0; } }';
    document.head.appendChild(style);

    // Show success message if redirected from successful update
    <% if (request.getParameter("success") != null) { %>
    showNotification('<%= request.getParameter("success") %>', 'success');
    <% } %>

    console.log('✨ Edit Book form initialized with change tracking');
</script>
</body>
</html>
