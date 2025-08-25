<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management - Pahana Edu </title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
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
            --dark-gradient: linear-gradient(135deg, #1F2937 0%, #374151 100%);

            /* Membership Tiers */
            --bronze-gradient: linear-gradient(135deg, #92400E 0%, #B45309 100%);
            --silver-gradient: linear-gradient(135deg, #6B7280 0%, #9CA3AF 100%);
            --gold-gradient: linear-gradient(135deg, #F59E0B 0%, #FCD34D 100%);

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
            max-width: 1400px;
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

        .header-actions {
            position: absolute;
            right: 3rem;
            top: 50%;
            transform: translateY(-50%);
            z-index: 2;
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
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.5);
        }

        .btn-primary::after {
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

        .btn-primary:active::after {
            width: 300px;
            height: 300px;
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

        /* Search Section */
        .search-section {
            background: var(--bg-secondary);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            animation: slideUp 0.6s ease-out 0.2s both;
        }

        .search-form {
            display: grid;
            grid-template-columns: 1fr 1fr auto auto;
            gap: 1rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-input {
            padding: 0.875rem 1.25rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--bg-primary);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            background: white;
        }

        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%236B7280'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 1.5rem;
            padding-right: 3rem;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
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
            cursor: pointer;
            animation: fadeIn 0.6s ease-out;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .stat-card:hover::before {
            transform: scaleX(1);
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
            margin-bottom: 1rem;
        }

        .stat-card:nth-child(1) .stat-icon {
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-color);
        }

        .stat-card:nth-child(2) .stat-icon {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .stat-card:nth-child(3) .stat-icon {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .stat-card:nth-child(4) .stat-icon {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
            transition: all 0.3s ease;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 600;
        }

        /* Table Section */
        .table-section {
            background: var(--bg-secondary);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            animation: slideUp 0.6s ease-out 0.4s both;
        }

        .table-header {
            background: var(--primary-gradient);
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            color: white;
            font-size: 1.25rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .table-actions {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-icon:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.1);
        }

        /* Table Styles */
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table thead {
            background: var(--bg-primary);
        }

        .data-table th {
            padding: 1.25rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid var(--border-color);
        }

        .data-table td {
            padding: 1.25rem;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }

        .data-table tbody tr {
            transition: all 0.3s ease;
            animation: tableRowFade 0.5s ease-out;
        }

        @keyframes tableRowFade {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .data-table tbody tr:hover {
            background: var(--bg-primary);
            transform: scale(1.01);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        /* Customer Cell */
        .customer-cell {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .customer-avatar {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: var(--primary-gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.125rem;
            flex-shrink: 0;
            position: relative;
            overflow: hidden;
        }

        .customer-avatar::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transform: rotate(45deg);
            transition: all 0.5s;
        }

        .customer-cell:hover .customer-avatar::after {
            animation: shimmer 0.5s ease-out;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .customer-info h4 {
            margin: 0;
            font-weight: 600;
            color: var(--text-primary);
        }

        .customer-info p {
            margin: 0.25rem 0 0 0;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        /* Contact Cell */
        .contact-cell {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .contact-item i {
            color: var(--primary-color);
            width: 16px;
        }

        .contact-item a {
            color: var(--primary-color);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .contact-item a:hover {
            color: var(--primary-dark);
        }

        /* Membership Badge */
        .membership-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }

        .badge-regular {
            background: var(--silver-gradient);
            color: white;
        }

        .badge-premium {
            background: var(--gold-gradient);
            color: white;
            box-shadow: 0 2px 8px rgba(245, 158, 11, 0.3);
        }

        .badge-vip {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 2px 8px rgba(99, 102, 241, 0.3);
            animation: glow 2s ease-in-out infinite;
        }

        @keyframes glow {
            0%, 100% { box-shadow: 0 2px 8px rgba(99, 102, 241, 0.3); }
            50% { box-shadow: 0 2px 16px rgba(99, 102, 241, 0.5); }
        }

        /* Purchase Info */
        .purchase-info {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .purchase-amount {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--success-color);
        }

        .loyalty-points {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--warning-color);
            font-size: 0.875rem;
            font-weight: 600;
        }

        /* Action Buttons */
        .actions-cell {
            display: flex;
            gap: 0.5rem;
        }

        .action-btn {
            width: 36px;
            height: 36px;
            border: none;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.5s, height 0.5s;
        }

        .action-btn:active::before {
            width: 40px;
            height: 40px;
        }

        .btn-view {
            background: rgba(59, 130, 246, 0.1);
            color: var(--info-color);
        }

        .btn-view:hover {
            background: var(--info-color);
            color: white;
            transform: scale(1.1);
        }

        .btn-edit {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .btn-edit:hover {
            background: var(--warning-color);
            color: white;
            transform: scale(1.1);
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .btn-delete:hover {
            background: var(--danger-color);
            color: white;
            transform: scale(1.1);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
        }

        .empty-icon {
            font-size: 5rem;
            color: var(--primary-light);
            margin-bottom: 1.5rem;
            animation: emptyBounce 2s ease-in-out infinite;
        }

        @keyframes emptyBounce {
            0%, 100% { transform: translateY(0) scale(1); }
            50% { transform: translateY(-10px) scale(1.1); }
        }

        .empty-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .empty-text {
            color: var(--text-secondary);
            font-size: 1.125rem;
            margin-bottom: 2rem;
        }

        /* Pagination */
        .table-footer {
            padding: 1.5rem 2rem;
            background: var(--bg-primary);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .showing-info {
            color: var(--text-secondary);
            font-size: 0.875rem;
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

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
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
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .search-form {
                grid-template-columns: 1fr 1fr;
            }

            .stats-container {
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

            .page-header {
                padding: 2rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .header-actions {
                position: static;
                margin-top: 1.5rem;
            }

            .search-form {
                grid-template-columns: 1fr;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            .table-section {
                border-radius: 0;
            }

            .data-table {
                font-size: 0.875rem;
            }

            .actions-cell {
                flex-direction: column;
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
    <div class="float-element">📖</div>
    <div class="float-element">📕</div>
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

        @SuppressWarnings("unchecked")
        List<Customer> customers = (List<Customer>) request.getAttribute("customers");
        if (customers == null) {
            customers = new ArrayList<>();
        }

        Integer totalCustomers = (Integer) request.getAttribute("totalCustomers");
        Integer regularCount = (Integer) request.getAttribute("regularCount");
        Integer premiumCount = (Integer) request.getAttribute("premiumCount");
        Integer vipCount = (Integer) request.getAttribute("vipCount");

        if (totalCustomers == null) totalCustomers = customers.size();
        if (regularCount == null) regularCount = 0;
        if (premiumCount == null) premiumCount = 0;
        if (vipCount == null) vipCount = 0;
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
                <a href="${pageContext.request.contextPath}/customer" class="nav-link active">
                    <i class="fas fa-user-friends"></i>
                    Customers
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/item" class="nav-link">
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
<div class="notification-container" id="notificationContainer">
    <% if (request.getParameter("success") != null) { %>
    <div class="notification notification-success" id="successNotification">
        <i class="fas fa-check-circle notification-icon"></i>
        <div class="notification-content">
            <h4>Success!</h4>
            <p><%= request.getParameter("success") %></p>
        </div>
        <button class="notification-close" onclick="closeNotification('successNotification')">
            <i class="fas fa-times"></i>
        </button>
        <div class="notification-progress"></div>
    </div>
    <% } %>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="notification notification-error" id="errorNotification">
        <i class="fas fa-exclamation-triangle notification-icon"></i>
        <div class="notification-content">
            <h4>Error!</h4>
            <p><%= request.getAttribute("errorMessage") %></p>
        </div>
        <button class="notification-close" onclick="closeNotification('errorNotification')">
            <i class="fas fa-times"></i>
        </button>
        <div class="notification-progress"></div>
    </div>
    <% } %>
</div>

<!-- Main Container -->
<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <div class="header-content">
            <h1 class="page-title">
                <i class="fas fa-user-friends"></i>
                Customer Management
            </h1>
            <p class="page-subtitle">Manage your customers, track purchases, and monitor loyalty programs</p>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/customer?action=add" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i>
                Add New Customer
            </a>
        </div>
    </div>

    <!-- Search Section -->
    <div class="search-section">
        <form class="search-form" method="get" action="${pageContext.request.contextPath}/customer" id="searchForm">
            <input type="hidden" name="action" value="search">

            <div class="form-group">
                <label class="form-label" for="searchTerm">
                    <i class="fas fa-search"></i>
                    Search Customers
                </label>
                <input type="text"
                       id="searchTerm"
                       name="searchTerm"
                       class="form-input"
                       placeholder="Search by name, email, or phone..."
                       value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>">
            </div>

            <div class="form-group">
                <label class="form-label" for="membershipFilter">
                    <i class="fas fa-medal"></i>
                    Membership Type
                </label>
                <select id="membershipFilter" name="membershipFilter" class="form-input form-select">
                    <option value="ALL">All Memberships</option>
                    <option value="REGULAR" <%= "REGULAR".equals(request.getAttribute("membershipFilter")) ? "selected" : "" %>>Regular</option>
                    <option value="PREMIUM" <%= "PREMIUM".equals(request.getAttribute("membershipFilter")) ? "selected" : "" %>>Premium</option>
                    <option value="VIP" <%= "VIP".equals(request.getAttribute("membershipFilter")) ? "selected" : "" %>>VIP</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i>
                Search
            </button>

            <a href="${pageContext.request.contextPath}/customer?action=list" class="btn" style="background: #E5E7EB; color: #6B7280;">
                <i class="fas fa-times"></i>
                Clear
            </a>
        </form>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-users"></i>
            </div>
            <div class="stat-value" data-target="<%= totalCustomers %>">0</div>
            <div class="stat-label">Total Customers</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-user"></i>
            </div>
            <div class="stat-value" data-target="<%= regularCount %>">0</div>
            <div class="stat-label">Regular Members</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-star"></i>
            </div>
            <div class="stat-value" data-target="<%= premiumCount %>">0</div>
            <div class="stat-label">Premium Members</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-crown"></i>
            </div>
            <div class="stat-value" data-target="<%= vipCount %>">0</div>
            <div class="stat-label">VIP Members</div>
        </div>
    </div>

    <!-- Table Section -->
    <div class="table-section">
        <div class="table-header">
            <h3 class="table-title">
                <i class="fas fa-list-alt"></i>
                Customer List
            </h3>
            <div class="table-actions">
                <button class="btn-icon" onclick="refreshTable()" title="Refresh">
                    <i class="fas fa-sync-alt"></i>
                </button>
                <button class="btn-icon" onclick="exportData()" title="Export">
                    <i class="fas fa-download"></i>
                </button>
                <button class="btn-icon" onclick="toggleView()" title="Toggle View">
                    <i class="fas fa-th-large"></i>
                </button>
            </div>
        </div>

        <% if (customers.size() > 0) { %>
        <table class="data-table" id="customersTable">
            <thead>
            <tr>
                <th>Customer</th>
                <th>Contact</th>
                <th>Membership</th>
                <th>Purchases</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                int index = 0;
                for (Customer customer : customers) {
                    index++;
            %>
            <tr style="animation-delay: <%= index * 0.05 %>s;">
                <td>
                    <div class="customer-cell">
                        <div class="customer-avatar">
                            <%= customer.getName().substring(0, Math.min(2, customer.getName().length())).toUpperCase() %>
                        </div>
                        <div class="customer-info">
                            <h4><%= customer.getName() %></h4>
                            <p>
                                <i class="fas fa-map-marker-alt"></i>
                                <%= customer.getAddress().length() > 30 ?
                                        customer.getAddress().substring(0, 30) + "..." :
                                        customer.getAddress() %>
                            </p>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="contact-cell">
                        <div class="contact-item">
                            <i class="fas fa-envelope"></i>
                            <a href="mailto:<%= customer.getEmail() %>"><%= customer.getEmail() %></a>
                        </div>
                        <div class="contact-item">
                            <i class="fas fa-phone"></i>
                            <span><%= customer.getPhone() %></span>
                        </div>
                    </div>
                </td>
                <td>
                        <span class="membership-badge badge-<%= customer.getMembershipType().toLowerCase() %>">
                            <% if ("VIP".equals(customer.getMembershipType())) { %>
                                <i class="fas fa-crown"></i>
                            <% } else if ("PREMIUM".equals(customer.getMembershipType())) { %>
                                <i class="fas fa-star"></i>
                            <% } else { %>
                                <i class="fas fa-user"></i>
                            <% } %>
                            <%= customer.getMembershipType() %>
                        </span>
                </td>
                <td>
                    <div class="purchase-info">
                        <span class="purchase-amount">$<%= String.format("%.2f", customer.getTotalPurchases()) %></span>
                        <span class="loyalty-points">
                                <i class="fas fa-coins"></i>
                                <%= customer.getLoyaltyPoints() %> points
                            </span>
                    </div>
                </td>
                <td>
                    <div class="actions-cell">
                        <a href="${pageContext.request.contextPath}/customer?action=view&customerId=<%= customer.getCustomerId() %>"
                           class="action-btn btn-view"
                           title="View Details">
                            <i class="fas fa-eye"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/customer?action=edit&customerId=<%= customer.getCustomerId() %>"
                           class="action-btn btn-edit"
                           title="Edit Customer">
                            <i class="fas fa-pen"></i>
                        </a>
                        <a href="#"
                           class="action-btn btn-delete"
                           title="Delete Customer"
                           onclick="confirmDelete(<%= customer.getCustomerId() %>, '<%= customer.getName() %>')">
                            <i class="fas fa-trash-alt"></i>
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div class="table-footer">
            <div class="showing-info">
                Showing <%= customers.size() %> of <%= totalCustomers %> customers
                <% if (request.getAttribute("searchTerm") != null) { %>
                for "<%= request.getAttribute("searchTerm") %>"
                <% } %>
            </div>
        </div>

        <% } else { %>
        <div class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-user-slash"></i>
            </div>
            <h3 class="empty-title">No Customers Found</h3>
            <% if (request.getAttribute("searchTerm") != null) { %>
            <p class="empty-text">No customers match your search criteria. Try different keywords.</p>
            <a href="${pageContext.request.contextPath}/customer?action=list" class="btn btn-primary">
                <i class="fas fa-arrow-left"></i>
                View All Customers
            </a>
            <% } else { %>
            <p class="empty-text">Start building your customer base by adding your first customer!</p>
            <a href="${pageContext.request.contextPath}/customer?action=add" class="btn btn-primary">
                <i class="fas fa-user-plus"></i>
                Add First Customer
            </a>
            <% } %>
        </div>
        <% } %>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999; align-items: center; justify-content: center;">
    <div style="background: white; padding: 2rem; border-radius: 20px; max-width: 400px; margin: 2rem; animation: fadeInScale 0.3s ease-out;">
        <h3 style="margin-bottom: 1rem; color: var(--text-primary);">
            <i class="fas fa-exclamation-triangle" style="color: var(--danger-color);"></i>
            Confirm Delete
        </h3>
        <p id="deleteMessage" style="color: var(--text-secondary); margin-bottom: 2rem;"></p>
        <div style="display: flex; gap: 1rem; justify-content: flex-end;">
            <button class="btn" style="background: #E5E7EB; color: #6B7280;" onclick="closeDeleteModal()">
                Cancel
            </button>
            <button class="btn" style="background: var(--danger-gradient); color: white;" onclick="executeDelete()">
                <i class="fas fa-trash"></i>
                Delete
            </button>
        </div>
    </div>
</div>

<script>
    // Global variables
    let deleteCustomerId = null;
    let currentView = 'table';

    // Initialize page
    document.addEventListener('DOMContentLoaded', function() {
        animateCounters();
        setupNotifications();
        setupKeyboardShortcuts();
        setupLiveSearch();
        console.log('✨ Pahana Edu  Customer Management initialized');
    });

    // Animate statistics counters
    function animateCounters() {
        const counters = document.querySelectorAll('.stat-value');
        const duration = 2000;

        counters.forEach(counter => {
            const target = parseInt(counter.getAttribute('data-target'));
            const increment = target / (duration / 16);
            let current = 0;

            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    current = target;
                    clearInterval(timer);
                }
                counter.textContent = Math.floor(current);
            }, 16);
        });
    }

    // Setup notifications
    function setupNotifications() {
        const notifications = document.querySelectorAll('.notification');

        notifications.forEach(notification => {
            // Auto close after 5 seconds
            setTimeout(() => {
                closeNotification(notification.id);
            }, 5000);
        });
    }

    // Close notification
    function closeNotification(id) {
        const notification = document.getElementById(id);
        if (notification) {
            notification.classList.add('hide');
            setTimeout(() => {
                notification.remove();
            }, 500);
        }
    }

    // Show notification
    function showNotification(type, title, message) {
        const container = document.getElementById('notificationContainer');
        const id = 'notification-' + Date.now();

        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.id = id;

        const iconMap = {
            success: 'check-circle',
            error: 'exclamation-triangle',
            warning: 'exclamation-circle',
            info: 'info-circle'
        };

        notification.innerHTML = `
        <i class="fas fa-${iconMap[type]} notification-icon"></i>
        <div class="notification-content">
            <h4>${title}</h4>
            <p>${message}</p>
        </div>
        <button class="notification-close" onclick="closeNotification('${id}')">
            <i class="fas fa-times"></i>
        </button>
        <div class="notification-progress"></div>
    `;

        container.appendChild(notification);

        // Auto close after 5 seconds
        setTimeout(() => {
            closeNotification(id);
        }, 5000);
    }

    // Refresh table
    function refreshTable() {
        showLoading();
        location.reload();
    }

    // Show loading overlay
    function showLoading() {
        const overlay = document.getElementById('loadingOverlay');
        overlay.classList.add('show');
    }

    // Hide loading overlay
    function hideLoading() {
        const overlay = document.getElementById('loadingOverlay');
        overlay.classList.remove('show');
    }

    // Export data
    function exportData() {
        const table = document.getElementById('customersTable');
        if (!table) {
            showNotification('warning', 'No Data', 'No customer data to export');
            return;
        }

        showNotification('info', 'Exporting', 'Preparing your data...');

        // Create CSV content
        let csv = 'Name,Email,Phone,Address,Membership,Total Purchases,Loyalty Points\n';

        const rows = table.querySelectorAll('tbody tr');
        rows.forEach(row => {
            const name = row.querySelector('.customer-info h4').textContent;
            const email = row.querySelector('.contact-item a').textContent;
            const phone = row.querySelectorAll('.contact-item span')[0].textContent;
            const address = row.querySelector('.customer-info p').textContent.trim();
            const membership = row.querySelector('.membership-badge').textContent.trim();
            const purchases = row.querySelector('.purchase-amount').textContent;
            const points = row.querySelector('.loyalty-points').textContent.replace(' points', '');

            csv += `"${name}","${email}","${phone}","${address}","${membership}","${purchases}","${points}"\n`;
        });

        // Download file
        const blob = new Blob([csv], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'customers_' + new Date().toISOString().split('T')[0] + '.csv';
        a.click();
        window.URL.revokeObjectURL(url);

        showNotification('success', 'Success', 'Customer data exported successfully');
    }

    // Toggle view
    function toggleView() {
        // This could toggle between table and card view
        showNotification('info', 'View Changed', 'Feature coming soon!');
    }

    // Confirm delete
    function confirmDelete(customerId, customerName) {
        deleteCustomerId = customerId;
        const modal = document.getElementById('deleteModal');
        const message = document.getElementById('deleteMessage');

        message.textContent = `Are you sure you want to delete customer "${customerName}"? This action cannot be undone.`;
        modal.style.display = 'flex';
    }

    // Close delete modal
    function closeDeleteModal() {
        const modal = document.getElementById('deleteModal');
        modal.style.display = 'none';
        deleteCustomerId = null;
    }

    // Execute delete
    function executeDelete() {
        if (deleteCustomerId) {
            showLoading();
            window.location.href = '${pageContext.request.contextPath}/customer?action=delete&customerId=' + deleteCustomerId;
        }
    }

    // Setup keyboard shortcuts
    function setupKeyboardShortcuts() {
        document.addEventListener('keydown', function(e) {
            // Ctrl/Cmd + N: Add new customer
            if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
                e.preventDefault();
                window.location.href = '${pageContext.request.contextPath}/customer?action=add';
            }

            // Ctrl/Cmd + F: Focus search
            if ((e.ctrlKey || e.metaKey) && e.key === 'f') {
                e.preventDefault();
                document.getElementById('searchTerm').focus();
            }

            // Ctrl/Cmd + E: Export
            if ((e.ctrlKey || e.metaKey) && e.key === 'e') {
                e.preventDefault();
                exportData();
            }

            // ESC: Close modals
            if (e.key === 'Escape') {
                closeDeleteModal();
            }
        });
    }

    // Setup live search
    function setupLiveSearch() {
        const searchInput = document.getElementById('searchTerm');
        let searchTimeout;

        searchInput.addEventListener('input', function(e) {
            clearTimeout(searchTimeout);
            const value = e.target.value.trim();

            // Only search if empty or 3+ characters
            if (value.length === 0 || value.length >= 3) {
                searchTimeout = setTimeout(() => {
                    const form = document.getElementById('searchForm');
                    showLoading();
                    form.submit();
                }, 800);
            }
        });
    }

    // Add row click handler
    document.querySelectorAll('.data-table tbody tr').forEach(row => {
        row.addEventListener('click', function(e) {
            // Don't trigger if clicking on action buttons
            if (e.target.closest('.actions-cell')) return;

            // Create ripple effect
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.cssText = `
            position: absolute;
            width: ${size}px;
            height: ${size}px;
            border-radius: 50%;
            background: rgba(99, 102, 241, 0.3);
            pointer-events: none;
            transform: scale(0);
            animation: ripple 0.6s ease-out;
            left: ${x}px;
            top: ${y}px;
        `;

            this.style.position = 'relative';
            this.style.overflow = 'hidden';
            this.appendChild(ripple);

            setTimeout(() => ripple.remove(), 600);
        });
    });

    // Add ripple animation
    const style = document.createElement('style');
    style.textContent = `
    @keyframes ripple {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }
`;
    document.head.appendChild(style);

    // Handle errors
    window.addEventListener('error', function(e) {
        console.error('Error:', e);
        showNotification('error', 'Error', 'An unexpected error occurred');
    });

    // Page visibility change
    document.addEventListener('visibilitychange', function() {
        if (!document.hidden) {
            // Could refresh data when page becomes visible again
            console.log('Page is visible again');
        }
    });

    // Initialize tooltips
    document.querySelectorAll('[title]').forEach(element => {
        element.addEventListener('mouseenter', function() {
            const tooltip = document.createElement('div');
            tooltip.className = 'custom-tooltip';
            tooltip.textContent = this.title;
            tooltip.style.cssText = `
            position: absolute;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 0.5rem;
            border-radius: 6px;
            font-size: 0.75rem;
            z-index: 9999;
            pointer-events: none;
        `;

            document.body.appendChild(tooltip);

            const rect = this.getBoundingClientRect();
            tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
            tooltip.style.top = rect.top - tooltip.offsetHeight - 5 + 'px';

            this.dataset.originalTitle = this.title;
            this.removeAttribute('title');

            this.addEventListener('mouseleave', function() {
                tooltip.remove();
                this.title = this.dataset.originalTitle;
            }, { once: true });
        });
    });

    // Performance monitoring
    if ('PerformanceObserver' in window) {
        const observer = new PerformanceObserver((list) => {
            for (const entry of list.getEntries()) {
                console.log('Performance:', entry.name, entry.duration + 'ms');
            }
        });
        observer.observe({ entryTypes: ['measure'] });
    }

    // Mark page load complete
    performance.mark('page-load-complete');
    performance.measure('page-load', 'navigationStart', 'page-load-complete');
</script>
</body>
</html>
