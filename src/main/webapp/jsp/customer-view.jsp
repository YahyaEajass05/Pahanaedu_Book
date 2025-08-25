<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Profile - Pahana Edu </title>
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
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Profile Header */
        .profile-header {
            background: var(--bg-secondary);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
            margin-bottom: 2rem;
            animation: fadeInScale 0.6s ease-out;
        }

        .profile-header::before {
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

        .profile-content {
            display: flex;
            align-items: center;
            gap: 3rem;
            position: relative;
            z-index: 1;
        }

        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 24px;
            background: var(--primary-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
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

        .profile-avatar::after {
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

        .profile-info h1 {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            animation: slideInLeft 0.8s ease-out;
        }

        .profile-meta {
            display: flex;
            gap: 2rem;
            margin-top: 1rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            animation: fadeInUp 0.8s ease-out;
        }

        .meta-item i {
            color: var(--primary-color);
        }

        .membership-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 1.5rem;
            animation: bounceIn 0.8s ease-out;
        }

        .badge-regular {
            background: var(--regular-gradient);
            color: white;
        }

        .badge-premium {
            background: var(--premium-gradient);
            color: white;
            box-shadow: 0 4px 15px rgba(245, 158, 11, 0.3);
        }

        .badge-vip {
            background: var(--vip-gradient);
            color: white;
            box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3);
            animation: glow 2s ease-in-out infinite;
        }

        @keyframes glow {
            0%, 100% { box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3); }
            50% { box-shadow: 0 4px 25px rgba(139, 92, 246, 0.5); }
        }

        /* Quick Actions */
        .quick-actions {
            position: absolute;
            right: 3rem;
            top: 50%;
            transform: translateY(-50%);
            display: flex;
            gap: 1rem;
        }

        .action-btn {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1.25rem;
        }

        .action-btn:hover {
            transform: translateY(-2px) scale(1.1);
        }

        .btn-edit {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .btn-edit:hover {
            background: var(--warning-color);
            color: white;
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .btn-delete:hover {
            background: var(--danger-color);
            color: white;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--bg-secondary);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
        }

        .stat-card:nth-child(1)::before { background: var(--success-gradient); }
        .stat-card:nth-child(2)::before { background: var(--warning-gradient); }
        .stat-card:nth-child(3)::before { background: var(--info-gradient); }
        .stat-card:nth-child(4)::before { background: var(--primary-gradient); }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .stat-card:nth-child(1) .stat-icon {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .stat-card:nth-child(2) .stat-icon {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .stat-card:nth-child(3) .stat-icon {
            background: rgba(59, 130, 246, 0.1);
            color: var(--info-color);
        }

        .stat-card:nth-child(4) .stat-icon {
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-color);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 600;
        }

        .stat-trend {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            font-size: 0.875rem;
            font-weight: 600;
            margin-top: 0.5rem;
        }

        .trend-up {
            color: var(--success-color);
        }

        .trend-down {
            color: var(--danger-color);
        }

        /* Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        /* Information Panel */
        .info-panel {
            background: var(--bg-secondary);
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            animation: slideInLeft 0.8s ease-out;
        }

        .panel-header {
            background: var(--primary-gradient);
            color: white;
            padding: 1.5rem 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .panel-title {
            font-size: 1.25rem;
            font-weight: 700;
        }

        .panel-body {
            padding: 2rem;
        }

        .info-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: 1rem;
            background: var(--bg-primary);
            border-radius: 12px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .info-item:hover {
            background: rgba(99, 102, 241, 0.05);
            transform: translateX(5px);
        }

        .info-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 0.875rem;
            color: var(--text-secondary);
            margin-bottom: 0.25rem;
            font-weight: 600;
        }

        .info-value {
            font-size: 1rem;
            color: var(--text-primary);
            font-weight: 600;
        }

        .info-value a {
            color: var(--primary-color);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .info-value a:hover {
            color: var(--primary-dark);
        }

        /* Activity Timeline */
        .activity-panel {
            background: var(--bg-secondary);
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
            animation: slideInRight 0.8s ease-out;
        }

        .timeline {
            padding: 1.5rem;
            max-height: 600px;
            overflow-y: auto;
        }

        .timeline-item {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            position: relative;
            animation: fadeInUp 0.6s ease-out;
        }

        .timeline-item:not(:last-child)::after {
            content: '';
            position: absolute;
            left: 19px;
            top: 40px;
            bottom: -20px;
            width: 2px;
            background: var(--border-color);
        }

        .timeline-marker {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 1rem;
            position: relative;
            z-index: 1;
        }

        .timeline-item:nth-child(1) .timeline-marker {
            background: var(--success-gradient);
            color: white;
        }

        .timeline-item:nth-child(2) .timeline-marker {
            background: var(--info-gradient);
            color: white;
        }

        .timeline-item:nth-child(3) .timeline-marker {
            background: var(--warning-gradient);
            color: white;
        }

        .timeline-content {
            flex: 1;
            background: var(--bg-primary);
            padding: 1rem;
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .timeline-content:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .timeline-title {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .timeline-desc {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .timeline-time {
            color: var(--text-secondary);
            font-size: 0.75rem;
            margin-top: 0.5rem;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            justify-content: center;
            animation: slideUp 0.8s ease-out;
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

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.5);
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

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(239, 68, 68, 0.4);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.5);
        }

        .btn-secondary {
            background: #E5E7EB;
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: #D1D5DB;
            transform: translateY(-2px);
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
            background: rgba(239, 68, 68, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: var(--danger-color);
            animation: modalIconPulse 2s ease-in-out infinite;
        }

        @keyframes modalIconPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
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

        /* Loading State */
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
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .navbar-container {
                padding: 1rem;
            }

            .nav-menu {
                display: none;
            }

            .profile-content {
                flex-direction: column;
                text-align: center;
            }

            .profile-meta {
                flex-direction: column;
                gap: 1rem;
            }

            .quick-actions {
                position: static;
                margin-top: 2rem;
                transform: none;
                justify-content: center;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-wrap: wrap;
            }

            .btn {
                flex: 1;
                min-width: 150px;
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

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loader"></div>
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
        SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
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
    <% if (request.getParameter("success") != null) { %>
    <div class="toast toast-success" id="successToast">
        <i class="fas fa-check-circle toast-icon"></i>
        <div class="toast-content">
            <div class="toast-title">Success!</div>
            <div class="toast-message"><%= request.getParameter("success") %></div>
        </div>
        <button class="toast-close" onclick="closeToast(this)">
            <i class="fas fa-times"></i>
        </button>
        <div class="toast-progress"></div>
    </div>
    <% } %>
</div>

<!-- Main Container -->
<div class="container">
    <!-- Profile Header -->
    <div class="profile-header">
        <div class="profile-content">
            <div class="profile-avatar">
                <%= customer.getName().substring(0, Math.min(2, customer.getName().length())).toUpperCase() %>
            </div>
            <div class="profile-info">
                <h1><%= customer.getName() %></h1>
                <div class="profile-meta">
                    <div class="meta-item">
                        <i class="fas fa-envelope"></i>
                        <span><%= customer.getEmail() %></span>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-phone"></i>
                        <span><%= customer.getPhone() %></span>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-calendar-alt"></i>
                        <span>Member since <%= customer.getCreatedAt() != null ? dateFormat.format(customer.getCreatedAt()) : "N/A" %></span>
                    </div>
                </div>
                <div class="membership-badge badge-<%= customer.getMembershipType().toLowerCase() %>">
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
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/customer?action=edit&customerId=<%= customer.getCustomerId() %>"
                   class="action-btn btn-edit" title="Edit Customer">
                    <i class="fas fa-pen"></i>
                </a>
                <button class="action-btn btn-delete" title="Delete Customer"
                        onclick="showDeleteModal('<%= customer.getName() %>', <%= customer.getCustomerId() %>)">
                    <i class="fas fa-trash-alt"></i>
                </button>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    <span>12%</span>
                </div>
            </div>
            <div class="stat-value" data-value="<%= customer.getTotalPurchases() %>">$0.00</div>
            <div class="stat-label">Total Purchases</div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-coins"></i>
                </div>
                <div class="stat-trend trend-up">
                    <i class="fas fa-arrow-up"></i>
                    <span>+<%= customer.getLoyaltyPoints() %></span>
                </div>
            </div>
            <div class="stat-value" data-value="<%= customer.getLoyaltyPoints() %>">0</div>
            <div class="stat-label">Loyalty Points</div>
            <div class="stat-trend" style="color: var(--text-secondary); font-size: 0.75rem;">
                Worth $<%= String.format("%.2f", customer.getLoyaltyPoints() * 0.01) %>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-percent"></i>
                </div>
            </div>
            <div class="stat-value">
                <%= customer.getMembershipType().equals("VIP") ? "20%" :
                        customer.getMembershipType().equals("PREMIUM") ? "10%" : "5%" %>
            </div>
            <div class="stat-label">Discount Rate</div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
            </div>
            <div class="stat-value">
                <%= customer.getLoyaltyPoints() >= 500 ? "VIP Ready" :
                        customer.getLoyaltyPoints() >= 200 ? "Premium Ready" : "Growing" %>
            </div>
            <div class="stat-label">Status Progress</div>
        </div>
    </div>

    <!-- Content Grid -->
    <div class="content-grid">
        <!-- Customer Information Panel -->
        <div class="info-panel">
            <div class="panel-header">
                <i class="fas fa-info-circle"></i>
                <h3 class="panel-title">Customer Information</h3>
            </div>
            <div class="panel-body">
                <div class="info-list">
                    <div class="info-item" onclick="copyToClipboard('<%= customer.getCustomerId() %>')">
                        <div class="info-icon">
                            <i class="fas fa-hashtag"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Customer ID</div>
                            <div class="info-value">#<%= customer.getCustomerId() %></div>
                        </div>
                    </div>

                    <div class="info-item" onclick="copyToClipboard('<%= customer.getName() %>')">
                        <div class="info-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Full Name</div>
                            <div class="info-value"><%= customer.getName() %></div>
                        </div>
                    </div>

                    <div class="info-item" onclick="copyToClipboard('<%= customer.getEmail() %>')">
                        <div class="info-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Email Address</div>
                            <div class="info-value">
                                <a href="mailto:<%= customer.getEmail() %>"><%= customer.getEmail() %></a>
                            </div>
                        </div>
                    </div>

                    <div class="info-item" onclick="copyToClipboard('<%= customer.getPhone() %>')">
                        <div class="info-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Phone Number</div>
                            <div class="info-value">
                                <a href="tel:<%= customer.getPhone() %>"><%= customer.getPhone() %></a>
                            </div>
                        </div>
                    </div>

                    <div class="info-item" onclick="copyToClipboard('<%= customer.getAddress() %>')">
                        <div class="info-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Delivery Address</div>
                            <div class="info-value"><%= customer.getAddress() %></div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-medal"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Membership Type</div>
                            <div class="info-value"><%= customer.getMembershipType() %></div>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="info-content">
                            <div class="info-label">Last Updated</div>
                            <div class="info-value">
                                <%= customer.getUpdatedAt() != null ?
                                        dateFormat.format(customer.getUpdatedAt()) + " at " + timeFormat.format(customer.getUpdatedAt()) :
                                        "Never updated" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Activity Timeline -->
        <div class="activity-panel">
            <div class="panel-header">
                <i class="fas fa-history"></i>
                <h3 class="panel-title">Activity Timeline</h3>
            </div>
            <div class="timeline">
                <!-- Registration -->
                <div class="timeline-item">
                    <div class="timeline-marker">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">Account Created</div>
                        <div class="timeline-desc">Customer joined Pahana Edu </div>
                        <div class="timeline-time">
                            <%= customer.getCreatedAt() != null ?
                                    dateFormat.format(customer.getCreatedAt()) + " at " + timeFormat.format(customer.getCreatedAt()) :
                                    "Date not available" %>
                        </div>
                    </div>
                </div>

                <!-- Membership Status -->
                <div class="timeline-item">
                    <div class="timeline-marker">
                        <i class="fas fa-medal"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">Membership Status</div>
                        <div class="timeline-desc">
                            <%= customer.getMembershipType() %> member with
                            <%= customer.getMembershipType().equals("VIP") ? "20%" :
                                    customer.getMembershipType().equals("PREMIUM") ? "10%" : "5%" %> discount
                        </div>
                        <div class="timeline-time">Current benefits active</div>
                    </div>
                </div>

                <!-- Loyalty Points -->
                <% if (customer.getLoyaltyPoints() > 0) { %>
                <div class="timeline-item">
                    <div class="timeline-marker">
                        <i class="fas fa-coins"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">Loyalty Points Earned</div>
                        <div class="timeline-desc">
                            <%= customer.getLoyaltyPoints() %> points available for redemption
                        </div>
                        <div class="timeline-time">Can save $<%= String.format("%.2f", customer.getLoyaltyPoints() * 0.01) %></div>
                    </div>
                </div>
                <% } %>

                <!-- Next Tier Progress -->
                <% if (!customer.getMembershipType().equals("VIP")) { %>
                <div class="timeline-item">
                    <div class="timeline-marker">
                        <i class="fas fa-arrow-up"></i>
                    </div>
                    <div class="timeline-content">
                        <div class="timeline-title">Next Membership Tier</div>
                        <div class="timeline-desc">
                            <% if (customer.getMembershipType().equals("REGULAR")) { %>
                            <%= Math.max(0, 200 - customer.getLoyaltyPoints()) %> points to Premium
                            <% } else { %>
                            <%= Math.max(0, 500 - customer.getLoyaltyPoints()) %> points to VIP
                            <% } %>
                        </div>
                        <div class="timeline-time">Keep earning to upgrade!</div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/customer?action=edit&customerId=<%= customer.getCustomerId() %>"
           class="btn btn-primary">
            <i class="fas fa-edit"></i>
            Edit Customer
        </a>

        <a href="${pageContext.request.contextPath}/bill?action=new&customerId=<%= customer.getCustomerId() %>"
           class="btn btn-success">
            <i class="fas fa-cash-register"></i>
            Create Bill
        </a>

        <button class="btn btn-danger" onclick="showDeleteModal('<%= customer.getName() %>', <%= customer.getCustomerId() %>)">
            <i class="fas fa-trash"></i>
            Delete Customer
        </button>

        <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            Back to List
        </a>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal-overlay" id="deleteModal">
    <div class="modal">
        <div class="modal-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h3 style="margin: 0 0 1rem 0; color: var(--text-primary); font-size: 1.5rem;">Delete Customer?</h3>
        <p style="color: var(--text-secondary); margin-bottom: 2rem; line-height: 1.6;">
            Are you sure you want to delete <strong id="deleteCustomerName"></strong>?<br>
            This action cannot be undone and will remove all associated data.
        </p>
        <div style="display: flex; gap: 1rem; justify-content: center;">
            <button class="btn btn-secondary" onclick="closeDeleteModal()">
                Cancel
            </button>
            <button class="btn btn-danger" id="confirmDeleteBtn">
                <i class="fas fa-trash"></i>
                Delete
            </button>
        </div>
    </div>
</div>

<script>
    // Global variables
    let deleteCustomerId = null;

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        // Animate counters
        animateCounters();

        // Initialize tooltips
        initializeTooltips();

        // Setup keyboard shortcuts
        setupKeyboardShortcuts();

        // Auto-hide toasts
        autoHideToasts();

        // Add hover effects
        addHoverEffects();

        console.log('✨ Pahana Edu Customer View initialized');
    });

    // Animate counters
    function animateCounters() {
        const counters = document.querySelectorAll('.stat-value[data-value]');

        counters.forEach(counter => {
            const target = parseFloat(counter.getAttribute('data-value'));
            const isCurrency = counter.textContent.includes('$');
            const duration = 2000;
            const increment = target / (duration / 16);
            let current = 0;

            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    current = target;
                    clearInterval(timer);
                }

                if (isCurrency) {
                    counter.textContent = '$' + current.toFixed(2);
                } else {
                    counter.textContent = Math.floor(current);
                }
            }, 16);
        });
    }

    // Show delete modal
    function showDeleteModal(customerName, customerId) {
        deleteCustomerId = customerId;
        document.getElementById('deleteCustomerName').textContent = customerName;
        document.getElementById('deleteModal').classList.add('show');

        // Set delete action
        document.getElementById('confirmDeleteBtn').onclick = function() {
            deleteCustomer();
        };
    }

    // Close delete modal
    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.remove('show');
        deleteCustomerId = null;
    }

    // Delete customer
    function deleteCustomer() {
        if (!deleteCustomerId) return;

        showLoading();
        window.location.href = '${pageContext.request.contextPath}/customer?action=delete&customerId=' + deleteCustomerId;
    }

    // Copy to clipboard
    function copyToClipboard(text) {
        navigator.clipboard.writeText(text).then(() => {
            showToast('success', 'Copied!', 'Text copied to clipboard');
        }).catch(err => {
            showToast('error', 'Error', 'Failed to copy text');
        });
    }

    // Show toast notification
    function showToast(type, title, message) {
        const toastContainer = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        toast.className = 'toast toast-' + type;

        const icons = {
            success: 'check-circle',
            error: 'exclamation-circle',
            warning: 'exclamation-triangle',
            info: 'info-circle'
        };

        toast.innerHTML =
            '<i class="fas fa-' + icons[type] + ' toast-icon"></i>' +
            '<div class="toast-content">' +
            '<div class="toast-title">' + title + '</div>' +
            '<div class="toast-message">' + message + '</div>' +
            '</div>' +
            '<button class="toast-close" onclick="closeToast(this)">' +
            '<i class="fas fa-times"></i>' +
            '</button>' +
            '<div class="toast-progress"></div>';

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

    // Auto hide toasts
    function autoHideToasts() {
        const toasts = document.querySelectorAll('.toast');
        toasts.forEach(toast => {
            setTimeout(() => {
                closeToast(toast.querySelector('.toast-close'));
            }, 5000);
        });
    }

    // Show loading
    function showLoading() {
        document.getElementById('loadingOverlay').classList.add('show');
    }

    // Hide loading
    function hideLoading() {
        document.getElementById('loadingOverlay').classList.remove('show');
    }

    // Initialize tooltips
    function initializeTooltips() {
        const elements = document.querySelectorAll('[title]');

        elements.forEach(element => {
            const title = element.getAttribute('title');
            element.removeAttribute('title');

            element.addEventListener('mouseenter', function(e) {
                const tooltip = document.createElement('div');
                tooltip.className = 'custom-tooltip';
                tooltip.textContent = title;
                tooltip.style.cssText =
                    'position: absolute;' +
                    'background: rgba(0,0,0,0.8);' +
                    'color: white;' +
                    'padding: 0.5rem 0.75rem;' +
                    'border-radius: 6px;' +
                    'font-size: 0.75rem;' +
                    'z-index: 9999;' +
                    'pointer-events: none;' +
                    'white-space: nowrap;' +
                    'opacity: 0;' +
                    'transition: opacity 0.3s ease;';

                document.body.appendChild(tooltip);

                const rect = this.getBoundingClientRect();
                const tooltipRect = tooltip.getBoundingClientRect();

                tooltip.style.left = rect.left + (rect.width / 2) - (tooltipRect.width / 2) + 'px';
                tooltip.style.top = rect.top - tooltipRect.height - 5 + 'px';

                // Check if tooltip goes off-screen
                if (tooltip.offsetLeft < 0) {
                    tooltip.style.left = '5px';
                } else if (tooltip.offsetLeft + tooltipRect.width > window.innerWidth) {
                    tooltip.style.left = (window.innerWidth - tooltipRect.width - 5) + 'px';
                }

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
            // Ctrl/Cmd + E: Edit
            if ((e.ctrlKey || e.metaKey) && e.key === 'e') {
                e.preventDefault();
                window.location.href = '${pageContext.request.contextPath}/customer?action=edit&customerId=<%= customer.getCustomerId() %>';
            }

            // Ctrl/Cmd + B: Create Bill
            if ((e.ctrlKey || e.metaKey) && e.key === 'b') {
                e.preventDefault();
                window.location.href = '${pageContext.request.contextPath}/bill?action=new&customerId=<%= customer.getCustomerId() %>';
            }

            // Ctrl/Cmd + D: Delete
            if ((e.ctrlKey || e.metaKey) && e.key === 'd') {
                e.preventDefault();
                showDeleteModal('<%= customer.getName() %>', <%= customer.getCustomerId() %>);
            }

            // Escape: Go back
            if (e.key === 'Escape') {
                const modal = document.querySelector('.modal-overlay.show');
                if (modal) {
                    closeDeleteModal();
                } else {
                    window.location.href = '${pageContext.request.contextPath}/customer';
                }
            }
        });
    }

    // Add hover effects
    function addHoverEffects() {
        // Info items click-to-copy effect
        const infoItems = document.querySelectorAll('.info-item');
        infoItems.forEach(item => {
            item.addEventListener('click', function() {
                // Visual feedback
                this.style.background = 'rgba(99, 102, 241, 0.1)';
                setTimeout(() => {
                    this.style.background = '';
                }, 200);
            });
        });

        // Add copy hint on hover
        const style = document.createElement('style');
        style.textContent =
            '.info-item { position: relative; }' +
            '.info-item::after {' +
            'content: "Click to copy";' +
            'position: absolute;' +
            'right: 1rem;' +
            'top: 50%;' +
            'transform: translateY(-50%);' +
            'font-size: 0.75rem;' +
            'color: var(--primary-color);' +
            'opacity: 0;' +
            'transition: opacity 0.3s ease;' +
            'pointer-events: none;' +
            '}' +
            '.info-item:hover::after { opacity: 1; }';
        document.head.appendChild(style);
    }

    // Print customer details
    function printCustomerDetails() {
        window.print();
    }

    // Add print styles
    const printStyles = document.createElement('style');
    printStyles.textContent =
        '@media print {' +
        '.navbar, .action-buttons, .toast-container, .modal-overlay, .quick-actions {' +
        'display: none !important;' +
        '}' +
        'body { background: white !important; }' +
        '.profile-header, .info-panel, .activity-panel, .stat-card {' +
        'box-shadow: none !important;' +
        'break-inside: avoid;' +
        '}' +
        '.container { max-width: 100%; }' +
        '.content-grid { grid-template-columns: 1fr; }' +
        '}';
    document.head.appendChild(printStyles);

    // Show tip after page load
    setTimeout(() => {
        showToast('info', 'Tip', 'Use keyboard shortcuts: Ctrl+E to edit, Ctrl+B for billing');
    }, 3000);

    // Progress indicator for next membership tier
    function showMembershipProgress() {
        const membershipType = '<%= customer.getMembershipType() %>';
        const loyaltyPoints = <%= customer.getLoyaltyPoints() %>;

        if (membershipType !== 'VIP') {
            const targetPoints = membershipType === 'REGULAR' ? 200 : 500;
            const progress = (loyaltyPoints / targetPoints) * 100;

            const progressBar = document.createElement('div');
            progressBar.style.cssText =
                'position: fixed;' +
                'bottom: 2rem;' +
                'left: 50%;' +
                'transform: translateX(-50%);' +
                'background: white;' +
                'padding: 1rem 2rem;' +
                'border-radius: 50px;' +
                'box-shadow: var(--shadow-lg);' +
                'display: flex;' +
                'align-items: center;' +
                'gap: 1rem;' +
                'animation: slideUp 0.5s ease-out;';

            const progressHTML =
                '<div style="width: 200px; height: 8px; background: var(--border-color); border-radius: 4px; overflow: hidden;">' +
                '<div style="width: ' + progress + '%; height: 100%; background: var(--primary-gradient); transition: width 1s ease;"></div>' +
                '</div>' +
                '<span style="color: var(--text-secondary); font-size: 0.875rem; font-weight: 600;">' +
                Math.round(progress) + '% to ' + (membershipType === 'REGULAR' ? 'Premium' : 'VIP') +
                '</span>';

            progressBar.innerHTML = progressHTML;
            document.body.appendChild(progressBar);

            setTimeout(() => {
                progressBar.style.animation = 'slideDown 0.5s ease-out forwards';
                setTimeout(() => progressBar.remove(), 500);
            }, 5000);
        }
    }

    // Show progress on load
    setTimeout(showMembershipProgress, 1000);

    // Handle errors
    window.addEventListener('error', function(e) {
        console.error('Error:', e);
        showToast('error', 'Error', 'An unexpected error occurred');
    });

    // Page visibility change
    document.addEventListener('visibilitychange', function() {
        if (!document.hidden) {
            console.log('Page is visible again');
        }
    });
</script>
</body>
</html>
