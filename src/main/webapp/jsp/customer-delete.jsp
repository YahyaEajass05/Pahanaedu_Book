<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Customer - BookStore Pro</title>
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

            /* Background & Glass */
            --bg-primary: #F9FAFB;
            --bg-secondary: #FFFFFF;
            --glass-white: rgba(255, 255, 255, 0.85);
            --glass-danger: rgba(239, 68, 68, 0.1);
            --border-color: #E5E7EB;
            --text-primary: #1F2937;
            --text-secondary: #6B7280;

            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            --shadow-danger: 0 20px 25px -5px rgba(239, 68, 68, 0.25);
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
                    radial-gradient(circle at 20% 80%, rgba(239, 68, 68, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(239, 68, 68, 0.05) 0%, transparent 50%),
                    radial-gradient(circle at 40% 40%, rgba(245, 158, 11, 0.05) 0%, transparent 50%);
            animation: bgRotate 30s linear infinite;
        }

        @keyframes bgRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .danger-particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: var(--danger-color);
            border-radius: 50%;
            opacity: 0;
            /* Define default values for custom properties */
            --x: 0px;
            --y: 0px;
            animation: dangerParticle 3s infinite;
        }

        @keyframes dangerParticle {
            0% {
                opacity: 0;
                transform: translate(0px, 0px) scale(0);
            }
            50% {
                opacity: 1;
                transform: translate(var(--x, 0px), var(--y, 0px)) scale(1);
            }
            100% {
                opacity: 0;
                transform: translate(calc(var(--x, 0px) * 2), calc(var(--y, 0px) * 2)) scale(0);
            }
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
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Warning Header */
        .warning-header {
            background: var(--bg-secondary);
            border-radius: 24px;
            padding: 3rem;
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            animation: fadeInScale 0.6s ease-out;
        }

        .warning-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: var(--danger-gradient);
            opacity: 0.1;
            border-radius: 50%;
            animation: pulse 4s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .warning-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 2rem;
            background: var(--glass-danger);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: var(--danger-color);
            position: relative;
            animation: warningPulse 2s ease-in-out infinite;
        }

        @keyframes warningPulse {
            0%, 100% {
                transform: scale(1);
                box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.4);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 0 0 20px rgba(239, 68, 68, 0);
            }
        }

        .warning-title {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--danger-color);
            margin-bottom: 0.5rem;
            animation: slideInUp 0.6s ease-out 0.2s both;
        }

        .warning-subtitle {
            color: var(--text-secondary);
            font-size: 1.125rem;
            animation: slideInUp 0.6s ease-out 0.3s both;
        }

        /* Alert Banner */
        .alert-banner {
            background: var(--danger-gradient);
            color: white;
            padding: 1.5rem 2rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: var(--shadow-danger);
            animation: slideInLeft 0.6s ease-out 0.4s both;
        }

        .alert-icon {
            font-size: 1.5rem;
            animation: shake 2s ease-in-out infinite;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-2px); }
            20%, 40%, 60%, 80% { transform: translateX(2px); }
        }

        .alert-content h3 {
            margin: 0 0 0.5rem 0;
            font-size: 1.25rem;
            font-weight: 700;
        }

        .alert-list {
            margin: 0;
            padding-left: 1.5rem;
            list-style: none;
        }

        .alert-list li {
            margin-bottom: 0.5rem;
            position: relative;
            padding-left: 1.5rem;
        }

        .alert-list li::before {
            content: '•';
            position: absolute;
            left: 0;
            color: rgba(255, 255, 255, 0.8);
        }

        /* Customer Card */
        .customer-delete-card {
            background: var(--bg-secondary);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: var(--shadow-xl);
            margin-bottom: 2rem;
            animation: slideInRight 0.6s ease-out 0.5s both;
            position: relative;
            border: 2px solid var(--danger-color);
        }

        .delete-marker {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--danger-gradient);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.875rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            animation: blink 2s ease-in-out infinite;
        }

        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.6; }
        }

        .card-header {
            padding: 2rem;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .customer-avatar {
            width: 100px;
            height: 100px;
            border-radius: 20px;
            background: var(--danger-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
            position: relative;
            overflow: hidden;
            animation: avatarShake 3s ease-in-out infinite;
        }

        @keyframes avatarShake {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(-5deg); }
            75% { transform: rotate(5deg); }
        }

        .customer-avatar::after {
            content: '';
            position: absolute;
            inset: -50%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
            animation: shimmer 3s linear infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .customer-header-info h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .customer-header-info p {
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Info Grid */
        .info-grid {
            padding: 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .info-item {
            background: var(--bg-primary);
            padding: 1.5rem;
            border-radius: 16px;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            animation: fadeInUp 0.6s ease-out;
        }

        .info-item:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            border-color: var(--danger-color);
        }

        .info-item:nth-child(1) { animation-delay: 0.6s; }
        .info-item:nth-child(2) { animation-delay: 0.7s; }
        .info-item:nth-child(3) { animation-delay: 0.8s; }
        .info-item:nth-child(4) { animation-delay: 0.9s; }
        .info-item:nth-child(5) { animation-delay: 1s; }
        .info-item:nth-child(6) { animation-delay: 1.1s; }

        .info-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            color: var(--text-primary);
            font-size: 1.125rem;
            font-weight: 600;
        }

        .info-item.highlight {
            background: var(--warning-gradient);
            color: white;
            border: none;
        }

        .info-item.highlight .info-label,
        .info-item.highlight .info-value {
            color: white;
        }

        .info-item.highlight .info-value {
            font-size: 2rem;
            font-weight: 800;
        }

        /* Impact Analysis */
        .impact-section {
            background: var(--bg-secondary);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            animation: slideInUp 0.6s ease-out 1.2s both;
        }

        .impact-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
            color: var(--text-primary);
        }

        .impact-header i {
            font-size: 1.5rem;
            color: var(--warning-color);
        }

        .impact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .impact-card {
            background: var(--bg-primary);
            padding: 1.5rem;
            border-radius: 12px;
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .impact-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .impact-icon {
            width: 48px;
            height: 48px;
            margin: 0 auto 1rem;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .impact-card:nth-child(1) .impact-icon {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .impact-card:nth-child(2) .impact-icon {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .impact-card:nth-child(3) .impact-icon {
            background: rgba(59, 130, 246, 0.1);
            color: var(--info-color);
        }

        .impact-card:nth-child(4) .impact-icon {
            background: rgba(139, 92, 246, 0.1);
            color: var(--primary-color);
        }

        .impact-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .impact-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        /* Confirmation Section */
        .confirmation-section {
            background: var(--bg-secondary);
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            box-shadow: var(--shadow-lg);
            animation: slideInUp 0.6s ease-out 1.4s both;
        }

        .confirmation-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 2rem;
        }

        .security-check {
            background: var(--bg-primary);
            border: 2px solid var(--danger-color);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .security-check::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--danger-gradient);
            animation: loadingBar 3s ease-in-out infinite;
        }

        @keyframes loadingBar {
            0% { transform: translateX(-100%); }
            50% { transform: translateX(0); }
            100% { transform: translateX(100%); }
        }

        .checkbox-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            cursor: pointer;
            user-select: none;
            transition: all 0.3s ease;
        }

        .checkbox-wrapper:hover {
            transform: scale(1.02);
        }

        .custom-checkbox {
            width: 24px;
            height: 24px;
            border: 2px solid var(--danger-color);
            border-radius: 6px;
            position: relative;
            transition: all 0.3s ease;
        }

        .custom-checkbox input {
            opacity: 0;
            position: absolute;
            cursor: pointer;
        }

        .custom-checkbox .checkmark {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0);
            width: 14px;
            height: 14px;
            background: var(--danger-gradient);
            border-radius: 3px;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        .custom-checkbox input:checked ~ .checkmark {
            transform: translate(-50%, -50%) scale(1);
        }

        .checkbox-label {
            color: var(--text-primary);
            font-weight: 600;
            font-size: 1rem;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
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
            text-decoration: none;
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

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(239, 68, 68, 0.4);
            opacity: 0.5;
            cursor: not-allowed;
        }

        .btn-danger.enabled {
            opacity: 1;
            cursor: pointer;
            animation: dangerPulse 2s ease-in-out infinite;
        }

        @keyframes dangerPulse {
            0%, 100% { box-shadow: 0 4px 14px rgba(239, 68, 68, 0.4); }
            50% { box-shadow: 0 4px 20px rgba(239, 68, 68, 0.6); }
        }

        .btn-danger.enabled:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.5);
        }

        .btn-success {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
        }

        .btn-secondary {
            background: #E5E7EB;
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: #D1D5DB;
            transform: translateY(-2px);
        }

        .countdown-badge {
            background: rgba(239, 68, 68, 0.2);
            color: var(--danger-color);
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.875rem;
            font-weight: 700;
            margin-left: 0.5rem;
            animation: countdownPulse 1s ease-in-out infinite;
        }

        @keyframes countdownPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        /* Toast Notifications */
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
            0% { transform: scale(0) rotate(-180deg); }
            50% { transform: scale(1.2) rotate(20deg); }
            100% { transform: scale(1) rotate(0); }
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

        /* Loading Overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.9);
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

        .delete-animation {
            text-align: center;
            color: white;
        }

        .delete-icon-animate {
            font-size: 4rem;
            color: var(--danger-color);
            margin-bottom: 2rem;
            animation: deleteIcon 2s ease-in-out infinite;
        }

        @keyframes deleteIcon {
            0% { transform: scale(1) rotate(0); }
            25% { transform: scale(1.1) rotate(5deg); }
            50% { transform: scale(1) rotate(-5deg); }
            75% { transform: scale(1.1) rotate(5deg); }
            100% { transform: scale(1) rotate(0); }
        }

        .loading-text {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .loading-bar {
            width: 300px;
            height: 4px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 2px;
            overflow: hidden;
            margin: 0 auto;
        }

        .loading-bar-fill {
            height: 100%;
            background: var(--danger-gradient);
            animation: loadingFill 2s ease-in-out;
        }

        @keyframes loadingFill {
            from { width: 0; }
            to { width: 100%; }
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

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
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

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
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

        /* Responsive */
        @media (max-width: 768px) {
            .navbar-container {
                padding: 1rem;
            }

            .nav-menu {
                display: none;
            }

            .warning-header {
                padding: 2rem;
            }

            .warning-title {
                font-size: 2rem;
            }

            .card-header {
                flex-direction: column;
                text-align: center;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .impact-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .action-buttons {
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
<div class="bg-animation"></div>

<!-- Toast Container -->
<div class="toast-container" id="toastContainer"></div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="delete-animation">
        <i class="fas fa-trash-alt delete-icon-animate"></i>
        <div class="loading-text">Deleting Customer...</div>
        <div class="loading-bar">
            <div class="loading-bar-fill"></div>
        </div>
    </div>
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

        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
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

<!-- Main Container -->
<div class="container">
    <!-- Warning Header -->
    <div class="warning-header">
        <div class="warning-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h1 class="warning-title">Delete Customer Account</h1>
        <p class="warning-subtitle">This action will permanently remove the customer from your system</p>
    </div>

    <!-- Alert Banner -->
    <div class="alert-banner">
        <i class="fas fa-shield-alt alert-icon"></i>
        <div class="alert-content">
            <h3>Important Security Notice</h3>
            <ul class="alert-list">
                <li>This action cannot be undone</li>
                <li>All customer data will be permanently deleted</li>
                <li>Purchase history and loyalty points will be lost</li>
                <li>Customer will be removed from all reports</li>
            </ul>
        </div>
    </div>

    <!-- Customer Delete Card -->
    <div class="customer-delete-card">
        <div class="delete-marker">
            <i class="fas fa-ban"></i>
            PENDING DELETION
        </div>

        <div class="card-header">
            <div class="customer-avatar">
                <%= customer.getName().substring(0, Math.min(2, customer.getName().length())).toUpperCase() %>
            </div>
            <div class="customer-header-info">
                <h2><%= customer.getName() %></h2>
                <p>
                    <i class="fas fa-envelope"></i>
                    <%= customer.getEmail() %>
                </p>
            </div>
        </div>

        <div class="info-grid">
            <div class="info-item">
                <div class="info-label">
                    <i class="fas fa-hashtag"></i>
                    Customer ID
                </div>
                <div class="info-value">#<%= customer.getCustomerId() %></div>
            </div>

            <div class="info-item">
                <div class="info-label">
                    <i class="fas fa-phone"></i>
                    Phone Number
                </div>
                <div class="info-value"><%= customer.getPhone() %></div>
            </div>

            <div class="info-item">
                <div class="info-label">
                    <i class="fas fa-map-marker-alt"></i>
                    Address
                </div>
                <div class="info-value"><%= customer.getAddress() %></div>
            </div>

            <div class="info-item">
                <div class="info-label">
                    <i class="fas fa-medal"></i>
                    Membership
                </div>
                <div class="info-value"><%= customer.getMembershipType() %></div>
            </div>

            <div class="info-item highlight">
                <div class="info-label">
                    <i class="fas fa-shopping-cart"></i>
                    Total Purchases
                </div>
                <div class="info-value">Rs<%= String.format("%.2f", customer.getTotalPurchases()) %></div>
            </div>

            <div class="info-item">
                <div class="info-label">
                    <i class="fas fa-coins"></i>
                    Loyalty Points
                </div>
                <div class="info-value"><%= customer.getLoyaltyPoints() %> pts</div>
            </div>
        </div>
    </div>

    <!-- Impact Analysis -->
    <div class="impact-section">
        <div class="impact-header">
            <i class="fas fa-chart-line"></i>
            <h3>Deletion Impact Analysis</h3>
        </div>
        <div class="impact-grid">
            <div class="impact-card">
                <div class="impact-icon">
                    <i class="fas fa-user-slash"></i>
                </div>
                <div class="impact-value">1</div>
                <div class="impact-label">Customer Record</div>
            </div>
            <div class="impact-card">
                <div class="impact-icon">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="impact-value">Rs<%= String.format("%.2f", customer.getTotalPurchases()) %></div>
                <div class="impact-label">Revenue Loss</div>
            </div>
            <div class="impact-card">
                <div class="impact-icon">
                    <i class="fas fa-coins"></i>
                </div>
                <div class="impact-value"><%= customer.getLoyaltyPoints() %></div>
                <div class="impact-label">Points Lost</div>
            </div>
            <div class="impact-card">
                <div class="impact-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="impact-value">
                    <%= customer.getCreatedAt() != null ? dateFormat.format(customer.getCreatedAt()) : "N/A" %>
                </div>
                <div class="impact-label">Member Since</div>
            </div>
        </div>
    </div>

    <!-- Confirmation Section -->
    <div class="confirmation-section">
        <h3 class="confirmation-title">Confirm Deletion</h3>

        <div class="security-check">
            <form id="deleteForm" action="${pageContext.request.contextPath}/customer" method="post">
                <input type="hidden" name="action" value="confirmDelete">
                <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">

                <div class="checkbox-wrapper" onclick="toggleCheckbox()">
                    <div class="custom-checkbox">
                        <input type="checkbox" id="confirmCheck" name="confirmCheck">
                        <span class="checkmark"></span>
                    </div>
                    <label class="checkbox-label" for="confirmCheck">
                        I understand this action is permanent and cannot be undone
                    </label>
                </div>
            </form>
        </div>

        <div class="action-buttons">
            <button type="button" class="btn btn-danger" id="deleteBtn" disabled onclick="confirmDelete()">
                <i class="fas fa-trash-alt"></i>
                Delete Customer
                <span class="countdown-badge" id="countdown" style="display: none;"></span>
            </button>

            <a href="${pageContext.request.contextPath}/customer?action=view&customerId=<%= customer.getCustomerId() %>"
               class="btn btn-success">
                <i class="fas fa-user-shield"></i>
                Keep Customer
            </a>

            <a href="${pageContext.request.contextPath}/customer"
               class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>
                Back to List
            </a>
        </div>
    </div>
</div>

<script>
    // Global variables
    let countdownTimer;
    let countdownValue = 5;
    let isDeleting = false;

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        // Add danger particles
        createDangerParticles();

        // Initialize tooltips
        initializeTooltips();

        // Setup keyboard shortcuts
        setupKeyboardShortcuts();

        console.log('✨ Pahana Edu  Delete Customer page initialized');
    });

    // Toggle checkbox
    function toggleCheckbox() {
        const checkbox = document.getElementById('confirmCheck');
        checkbox.checked = !checkbox.checked;
        handleCheckboxChange();
    }

    // Handle checkbox change
    document.getElementById('confirmCheck').addEventListener('change', handleCheckboxChange);

    function handleCheckboxChange() {
        const checkbox = document.getElementById('confirmCheck');
        const deleteBtn = document.getElementById('deleteBtn');
        const countdown = document.getElementById('countdown');

        if (checkbox.checked) {
            showToast('warning', 'Countdown Started', 'Delete button will be enabled in 5 seconds');
            startCountdown();
        } else {
            clearInterval(countdownTimer);
            countdown.style.display = 'none';
            deleteBtn.disabled = true;
            deleteBtn.classList.remove('enabled');
        }
    }

    // Start countdown
    function startCountdown() {
        const deleteBtn = document.getElementById('deleteBtn');
        const countdown = document.getElementById('countdown');

        countdownValue = 5;
        countdown.style.display = 'inline-flex';
        deleteBtn.disabled = true;

        updateCountdown();

        countdownTimer = setInterval(() => {
            countdownValue--;
            updateCountdown();

            if (countdownValue <= 0) {
                clearInterval(countdownTimer);
                countdown.style.display = 'none';
                deleteBtn.disabled = false;
                deleteBtn.classList.add('enabled');
                showToast('error', 'Delete Enabled', 'You can now delete the customer');
            }
        }, 1000);
    }

    // Update countdown display
    function updateCountdown() {
        const countdown = document.getElementById('countdown');
        countdown.textContent = countdownValue;

        // Change color based on countdown
        if (countdownValue <= 2) {
            countdown.style.background = 'rgba(239, 68, 68, 0.3)';
        }
    }

    // Confirm delete
    function confirmDelete() {
        if (isDeleting) return;

        const customerName = '<%= customer.getName() %>';
        const customerEmail = '<%= customer.getEmail() %>';
        const loyaltyPoints = <%= customer.getLoyaltyPoints() %>;
        const totalPurchases = <%= customer.getTotalPurchases() %>;

        // First confirmation
        const firstConfirm = confirm(
            '⚠️ CRITICAL ACTION WARNING\n\n' +
            'You are about to permanently delete:\n\n' +
            `Customer: ${customerName}\n` +
            `Email: ${customerEmail}\n` +
            `Total Purchases: Rs${totalPurchases.toFixed(2)}\n` +
            `Loyalty Points: ${loyaltyPoints}\n\n` +
            'Are you absolutely sure?'
        );

        if (!firstConfirm) {
            showToast('info', 'Cancelled', 'Customer deletion cancelled');
            return;
        }

        // Email verification
        const typedEmail = prompt(
            '🔐 SECURITY VERIFICATION\n\n' +
            'To confirm deletion, please type the customer\'s email address:\n\n' +
            `${customerEmail}`
        );

        if (typedEmail !== customerEmail) {
            if (typedEmail === null) {
                showToast('info', 'Cancelled', 'Customer deletion cancelled');
            } else {
                showToast('error', 'Verification Failed', 'Email address does not match');
            }
            return;
        }

        // Final confirmation
        const finalConfirm = confirm(
            '🗑️ FINAL CONFIRMATION\n\n' +
            'This is your LAST CHANCE to cancel.\n\n' +
            `"${customerName}" will be permanently deleted.\n\n` +
            'Click OK to proceed with deletion.'
        );

        if (!finalConfirm) {
            showToast('info', 'Cancelled', 'Customer deletion cancelled at final stage');
            return;
        }

        // Proceed with deletion
        performDelete();
    }

    // Perform delete
    function performDelete() {
        isDeleting = true;

        // Show loading overlay
        document.getElementById('loadingOverlay').classList.add('show');

        // Disable all buttons
        document.querySelectorAll('.btn').forEach(btn => {
            btn.style.pointerEvents = 'none';
            btn.style.opacity = '0.5';
        });

        // Submit form
        setTimeout(() => {
            document.getElementById('deleteForm').submit();
        }, 1000);
    }

    // Show toast notification
    function showToast(type, title, message) {
        const toastContainer = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        toast.className = `toast toast-${type}`;

        const icons = {
            success: 'check-circle',
            error: 'exclamation-circle',
            warning: 'exclamation-triangle',
            info: 'info-circle'
        };

        toast.innerHTML = `
        <i class="fas fa-${icons[type]} toast-icon"></i>
        <div class="toast-content">
            <div class="toast-title">${title}</div>
            <div class="toast-message">${message}</div>
        </div>
        <button class="toast-close" onclick="closeToast(this)">
            <i class="fas fa-times"></i>
        </button>
        <div class="toast-progress"></div>
    `;

        toastContainer.appendChild(toast);

        // Auto close after 5 seconds
        setTimeout(() => {
            closeToast(toast.querySelector('.toast-close'));
        }, 5000);
    }

    // Close toast
    function closeToast(element) {
        const toast = element.closest('.toast');
        if (toast) {
            toast.classList.add('hide');
            setTimeout(() => {
                toast.remove();
            }, 500);
        }
    }

    // Initialize tooltips
    function initializeTooltips() {
        const elements = document.querySelectorAll('[title]');

        elements.forEach(element => {
            const title = element.getAttribute('title');
            element.removeAttribute('title');

            element.addEventListener('mouseenter', function(e) {
                const tooltip = document.createElement('div');
                tooltip.textContent = title;
                tooltip.style.cssText = `
                position: absolute;
                background: rgba(0,0,0,0.8);
                color: white;
                padding: 0.5rem 0.75rem;
                border-radius: 6px;
                font-size: 0.75rem;
                z-index: 9999;
                pointer-events: none;
                white-space: nowrap;
                opacity: 0;
                transition: opacity 0.3s ease;
            `;

                document.body.appendChild(tooltip);

                const rect = this.getBoundingClientRect();
                tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
                tooltip.style.top = rect.top - tooltip.offsetHeight - 5 + 'px';

                setTimeout(() => {
                    tooltip.style.opacity = '1';
                }, 10);

                this.addEventListener('mouseleave', function() {
                    tooltip.style.opacity = '0';
                    setTimeout(() => tooltip.remove(), 300);
                }, { once: true });
            });
        });
    }

    // Setup keyboard shortcuts
    function setupKeyboardShortcuts() {
        document.addEventListener('keydown', function(e) {
            // Escape to go back
            if (e.key === 'Escape') {
                if (!isDeleting) {
                    window.location.href = '${pageContext.request.contextPath}/customer?action=view&customerId=<%= customer.getCustomerId() %>';
                }
            }

            // Space to toggle checkbox
            if (e.key === ' ' && document.activeElement !== document.getElementById('confirmCheck')) {
                e.preventDefault();
                toggleCheckbox();
            }

            // D to delete (when enabled)
            if ((e.key === 'd' || e.key === 'D') && !document.getElementById('deleteBtn').disabled) {
                e.preventDefault();
                confirmDelete();
            }
        });
    }

    // Create danger particles
    function createDangerParticles() {
        const container = document.querySelector('.bg-animation');

        for (let i = 0; i < 20; i++) {
            const particle = document.createElement('div');
            particle.className = 'danger-particle';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.top = Math.random() * 100 + '%';
            particle.style.setProperty('--x', (Math.random() - 0.5) * 200 + 'px');
            particle.style.setProperty('--y', (Math.random() - 0.5) * 200 + 'px');
            particle.style.animationDelay = Math.random() * 3 + 's';
            container.appendChild(particle);
        }
    }

    // Prevent accidental navigation
    window.addEventListener('beforeunload', function(e) {
        const checkbox = document.getElementById('confirmCheck');
        if (checkbox.checked && !isDeleting) {
            e.preventDefault();
            e.returnValue = 'You have started the deletion process. Are you sure you want to leave?';
        }
    });

    // Easter egg - type "SAVE" to protect customer
    let typedKeys = '';
    document.addEventListener('keypress', function(e) {
        typedKeys += e.key.toUpperCase();
        typedKeys = typedKeys.slice(-4); // Keep last 4 characters

        if (typedKeys === 'SAVE') {
            protectCustomer();
        }
    });

    // Protect customer (easter egg)
    function protectCustomer() {
        // Disable deletion
        document.getElementById('confirmCheck').checked = false;
        document.getElementById('confirmCheck').disabled = true;
        document.getElementById('deleteBtn').disabled = true;
        document.getElementById('deleteBtn').style.display = 'none';

        // Show success message
        showToast('success', '🛡️ Protection Activated', 'Customer is now protected from deletion!');

        // Add protection badge
        const protectionBadge = document.createElement('div');
        protectionBadge.style.cssText = `
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: var(--success-gradient);
        color: white;
        padding: 2rem 3rem;
        border-radius: 20px;
        font-size: 1.5rem;
        font-weight: 700;
        box-shadow: var(--shadow-xl);
        z-index: 9999;
        animation: bounceIn 0.6s ease-out;
    `;
        protectionBadge.innerHTML = `
        <i class="fas fa-shield-alt"></i> Customer Protected
    `;
        document.body.appendChild(protectionBadge);

        // Create confetti
        createConfetti();

        // Remove badge after 3 seconds
        setTimeout(() => {
            protectionBadge.style.animation = 'fadeOut 0.5s ease-out';
            setTimeout(() => protectionBadge.remove(), 500);
        }, 3000);
    }

    // Create confetti effect
    function createConfetti() {
        const colors = ['#6366F1', '#EC4899', '#14B8A6', '#F59E0B'];
        const confettiCount = 100;

        for (let i = 0; i < confettiCount; i++) {
            const confetti = document.createElement('div');
            confetti.style.cssText = `
            position: fixed;
            width: 10px;
            height: 10px;
            background: ${colors[Math.floor(Math.random() * colors.length)]};
            left: ${Math.random() * 100}%;
            top: -10px;
            opacity: 1;
            transform: rotate(${Math.random() * 360}deg);
            z-index: 9999;
            pointer-events: none;
        `;
            document.body.appendChild(confetti);

            // Animate confetti
            const animation = confetti.animate([
                {
                    transform: `translateY(0) rotate(0deg)`,
                    opacity: 1
                },
                {
                    transform: `translateY(${window.innerHeight + 10}px) rotate(${Math.random() * 720}deg)`,
                    opacity: 0
                }
            ], {
                duration: 3000 + Math.random() * 2000,
                easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
            });

            animation.onfinish = () => confetti.remove();
        }
    }

    // Add bounce animation
    const style = document.createElement('style');
    style.textContent = `
    @keyframes bounceIn {
        0% {
            opacity: 0;
            transform: translate(-50%, -50%) scale(0.3);
        }
        50% {
            transform: translate(-50%, -50%) scale(1.05);
        }
        70% {
            transform: translate(-50%, -50%) scale(0.9);
        }
        100% {
            opacity: 1;
            transform: translate(-50%, -50%) scale(1);
        }
    }

    @keyframes fadeOut {
        to {
            opacity: 0;
            transform: translate(-50%, -50%) scale(0.8);
        }
    }
`;
    document.head.appendChild(style);

    // Log easter egg hint
    console.log('💡 Hint: Type "SAVE" to activate protection mode!');
</script>
</body>
</html>
