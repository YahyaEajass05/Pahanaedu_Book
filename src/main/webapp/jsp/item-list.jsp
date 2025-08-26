<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pahanaedu.model.Item" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "Book Inventory"} - Pahana Edu </title>
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
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(99, 102, 241, 0.5);
        }

        .btn-secondary {
            background: var(--secondary-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(236, 72, 153, 0.4);
        }

        .btn-success {
            background: var(--success-gradient);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color) 0%, #FCD34D 100%);
            color: white;
        }

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-info {
            background: linear-gradient(135deg, var(--info-color) 0%, #60A5FA 100%);
            color: white;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
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

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .alert-warning {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
            border: 1px solid rgba(245, 158, 11, 0.2);
        }

        .alert-info {
            background: rgba(59, 130, 246, 0.1);
            color: var(--info-color);
            border: 1px solid rgba(59, 130, 246, 0.2);
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

        /* Quick Filters */
        .quick-filters {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            animation: slideUp 0.6s ease-out 0.3s both;
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

        /* Book Cell */
        .book-cell {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .book-icon {
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

        .book-icon::after {
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

        .book-cell:hover .book-icon::after {
            animation: shimmer 0.5s ease-out;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .book-info h4 {
            margin: 0;
            font-weight: 600;
            color: var(--text-primary);
        }

        .book-info p {
            margin: 0.25rem 0 0 0;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        /* Category Badge */
        .category-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.25rem 0.75rem;
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-color);
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        /* Price Display */
        .price-tag {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .price-original {
            text-decoration: line-through;
            color: var(--text-secondary);
            font-size: 0.875rem;
            font-weight: 400;
        }

        .price-discounted {
            color: var(--danger-color);
        }

        /* Stock Badge */
        .stock-badge {
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

        .stock-high {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
        }

        .stock-medium {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning-color);
        }

        .stock-low {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            animation: pulse 2s ease-in-out infinite;
        }

        .stock-out {
            background: rgba(107, 114, 128, 0.1);
            color: var(--text-secondary);
        }

        /* Discount Badge */
        .discount-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.375rem 0.75rem;
            background: var(--danger-gradient);
            color: white;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            animation: pulse 3s ease-in-out infinite;
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

        /* Table Footer */
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

<!-- Check if user is logged in -->
<%
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        @SuppressWarnings("unchecked")
        List<Item> items = (List<Item>) request.getAttribute("items");
        if (items == null) {
            items = new ArrayList<>();
        }

        @SuppressWarnings("unchecked")
        List<Item> lowStockItems = (List<Item>) request.getAttribute("lowStockItems");
        if (lowStockItems == null) {
            lowStockItems = new ArrayList<>();
        }

        @SuppressWarnings("unchecked")
        List<Item> outOfStockItems = (List<Item>) request.getAttribute("outOfStockItems");
        if (outOfStockItems == null) {
            outOfStockItems = new ArrayList<>();
        }

    @SuppressWarnings("unchecked")
    List<String> categories = (List<String>) request.getAttribute("categories");
    if (categories == null) {
        categories = new ArrayList<>();
    }

    Boolean isLowStockView = (Boolean) request.getAttribute("isLowStockView");
    Boolean isOutOfStockView = (Boolean) request.getAttribute("isOutOfStockView");
    Boolean isDiscountedView = (Boolean) request.getAttribute("isDiscountedView");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    String searchTerm = (String) request.getAttribute("searchTerm");
    String pageTitle = (String) request.getAttribute("pageTitle");
    if (pageTitle == null) pageTitle = "Book Inventory Management";
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
                <i class="fas fa-books"></i>
                <%= pageTitle %>
            </h1>
            <p class="page-subtitle">
                <% if (isLowStockView != null && isLowStockView) { %>
                Books with stock below 10 units that need immediate restocking
                <% } else if (isOutOfStockView != null && isOutOfStockView) { %>
                Books that are currently out of stock
                <% } else if (isDiscountedView != null && isDiscountedView) { %>
                Special offers and discounted books
                <% } else if (selectedCategory != null) { %>
                Browsing books in <%= selectedCategory %> category
                <% } else if (searchTerm != null) { %>
                Search results for "<%= searchTerm %>"
                <% } else { %>
                Manage your bookstore inventory, pricing, and stock levels
                <% } %>
            </p>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/item?action=add" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i>
                Add New Book
            </a>
            <a href="${pageContext.request.contextPath}/item?action=manageDiscount" class="btn btn-secondary">
                <i class="fas fa-tags"></i>
                Manage Discounts
            </a>
        </div>
    </div>

    <!-- Alert Messages -->
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <span><%= request.getParameter("success") %></span>
    </div>
    <% } %>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i>
        <span><%= request.getAttribute("errorMessage") %></span>
    </div>
    <% } %>

    <% String successMessage = (String) request.getAttribute("successMessage"); %>
    <% if (successMessage != null) { %>
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <span><%= successMessage %></span>
    </div>
    <% } %>

    <!-- Low Stock Warning -->
    <% if (lowStockItems.size() > 0 && !Boolean.TRUE.equals(isLowStockView)) { %>
    <div class="alert alert-warning">
        <i class="fas fa-exclamation-triangle"></i>
        <span>
                    <strong>Low Stock Alert!</strong> <%= lowStockItems.size() %> book(s) need restocking.
                    <a href="${pageContext.request.contextPath}/item?action=lowStock" style="color: inherit; font-weight: 600;">View Details →</a>
                </span>
    </div>
    <% } %>

    <!-- Search Section -->
    <div class="search-section">
        <form class="search-form" method="get" action="${pageContext.request.contextPath}/item">
            <input type="hidden" name="action" value="search">

            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-search"></i>
                    Search Books
                </label>
                <input type="text"
                       name="q"
                       class="form-input"
                       placeholder="Search by title, author, or ISBN..."
                       value="<%= searchTerm != null ? searchTerm : "" %>">
            </div>

            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-filter"></i>
                    Category
                </label>
                <select name="category" class="form-input form-select">
                    <option value="">All Categories</option>
                    <% for (String category : categories) { %>
                    <option value="<%= category %>" <%= category.equals(selectedCategory) ? "selected" : "" %>>
                        <%= category %>
                    </option>
                    <% } %>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i>
                Search
            </button>

            <a href="${pageContext.request.contextPath}/item" class="btn btn-info">
                <i class="fas fa-redo"></i>
                Reset
            </a>
        </form>
    </div>

    <!-- Quick Filters -->
    <div class="quick-filters">
        <a href="${pageContext.request.contextPath}/item"
           class="btn <%= (!Boolean.TRUE.equals(isLowStockView) && !Boolean.TRUE.equals(isOutOfStockView) && !Boolean.TRUE.equals(isDiscountedView)) ? "btn-primary" : "btn-secondary" %> btn-sm">
            <i class="fas fa-list"></i>
            All Books
        </a>
        <a href="${pageContext.request.contextPath}/item?action=lowStock"
           class="btn <%= Boolean.TRUE.equals(isLowStockView) ? "btn-primary" : "btn-secondary" %> btn-sm">
            <i class="fas fa-exclamation-triangle"></i>
            Low Stock (<%= lowStockItems.size() %>)
        </a>
        <a href="${pageContext.request.contextPath}/item?action=outOfStock"
           class="btn <%= Boolean.TRUE.equals(isOutOfStockView) ? "btn-primary" : "btn-secondary" %> btn-sm">
            <i class="fas fa-times-circle"></i>
            Out of Stock (<%= outOfStockItems.size() %>)
        </a>
        <a href="${pageContext.request.contextPath}/item?action=discounted"
           class="btn <%= Boolean.TRUE.equals(isDiscountedView) ? "btn-primary" : "btn-secondary" %> btn-sm">
            <i class="fas fa-percentage"></i>
            On Sale
        </a>
        <a href="${pageContext.request.contextPath}/item?action=inventory"
           class="btn btn-warning btn-sm">
            <i class="fas fa-chart-pie"></i>
            Inventory Report
        </a>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-books"></i>
            </div>
            <div class="stat-value" data-value="<%= items.size() %>">0</div>
            <div class="stat-label">Total Books</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-boxes"></i>
            </div>
            <div class="stat-value" data-value="<%
                    int totalStock = 0;
                    for (Item item : items) {
                        totalStock += item.getStock();
                    }
                %><%= totalStock %>">0</div>
            <div class="stat-label">Total Stock</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <div class="stat-value" data-value="<%= lowStockItems.size() %>">0</div>
            <div class="stat-label">Low Stock Items</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-dollar-sign"></i>
            </div>
            <%
                double totalValue = 0;
                for (Item item : items) {
                    totalValue += item.getPrice().doubleValue() * item.getStock();
                }
            %>
            <div class="stat-value" data-value="<%= totalValue %>" data-format="currency">0</div>
            <div class="stat-label">Total Value (LKR)</div>
        </div>
    </div>

    <!-- Books Table -->
    <div class="table-section">
        <div class="table-header">
            <h3 class="table-title">
                <i class="fas fa-books"></i>
                <%= Boolean.TRUE.equals(isLowStockView) ? "Low Stock Books" :
                        Boolean.TRUE.equals(isOutOfStockView) ? "Out of Stock Books" :
                                Boolean.TRUE.equals(isDiscountedView) ? "Books on Sale" :
                                        selectedCategory != null ? selectedCategory + " Books" :
                                                "Book Inventory" %>
            </h3>
            <div class="table-actions">
                <button class="btn-icon" onclick="exportData()" title="Export to CSV">
                    <i class="fas fa-file-export"></i>
                </button>
                <button class="btn-icon" onclick="window.print()" title="Print">
                    <i class="fas fa-print"></i>
                </button>
                <button class="btn-icon" onclick="refreshTable()" title="Refresh">
                    <i class="fas fa-sync-alt"></i>
                </button>
            </div>
        </div>

        <% if (items.size() > 0) { %>
        <table class="data-table" id="booksTable">
            <thead>
            <tr>
                <th>Book Details</th>
                <th>ISBN</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Discount</th>
                <th>Total Value</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < items.size(); i++) {
                Item item = items.get(i);
                double discountedPrice = item.getPrice().doubleValue();
                if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) {
                    discountedPrice = discountedPrice * (1 - item.getDiscountPercentage().doubleValue() / 100);
                }
            %>
            <tr style="animation-delay: <%= i * 0.05 %>s">
                <td>
                    <div class="book-cell">
                        <div class="book-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="book-info">
                            <h4><%= item.getItemName() %></h4>
                            <p>ID: <%= item.getItemId() %></p>
                        </div>
                    </div>
                </td>
                <td>
                                    <span style="font-family: monospace; font-weight: 500;">
                                        <%= item.getItemId() %>
                                    </span>
                </td>
                <td>
                                    <span class="category-badge">
                                        <i class="fas fa-tag"></i>
                                        <%= item.getCategory() != null ? item.getCategory() : "Uncategorized" %>
                                    </span>
                </td>
                <td>
                    <div class="price-tag">
                        <% if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) { %>
                        <div class="price-original">LKR <%= String.format("%,.2f", item.getPrice()) %></div>
                        <div class="price-discounted">LKR <%= String.format("%,.2f", discountedPrice) %></div>
                        <% } else { %>
                        LKR <%= String.format("%,.2f", item.getPrice()) %>
                        <% } %>
                    </div>
                </td>
                <td>
                                    <span class="stock-badge <%=
                                        item.getStock() == 0 ? "stock-out" :
                                        item.getStock() < 10 ? "stock-low" :
                                        item.getStock() < 50 ? "stock-medium" : "stock-high" %>">
                                        <i class="fas fa-<%=
                                            item.getStock() == 0 ? "times-circle" :
                                            item.getStock() < 10 ? "exclamation-triangle" :
                                            item.getStock() < 50 ? "minus-circle" : "check-circle" %>"></i>
                                        <%= item.getStock() %> units
                                    </span>
                </td>
                <td>
                    <% if (item.getDiscountPercentage() != null && item.getDiscountPercentage().doubleValue() > 0) { %>
                    <span class="discount-badge">
                                            <i class="fas fa-percentage"></i>
                                            <%= String.format("%.0f", item.getDiscountPercentage()) %>% OFF
                                        </span>
                    <% } else { %>
                    <span style="color: var(--text-secondary);">-</span>
                    <% } %>
                </td>
                <td>
                    <strong>LKR <%= String.format("%,.2f", discountedPrice * item.getStock()) %></strong>
                </td>
                <td>
                    <div class="actions-cell">
                        <a href="${pageContext.request.contextPath}/item?action=view&itemId=<%= item.getItemId() %>"
                           class="action-btn btn-view"
                           title="View Details">
                            <i class="fas fa-eye"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/item?action=edit&itemId=<%= item.getItemId() %>"
                           class="action-btn btn-edit"
                           title="Edit Book">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/item?action=delete&itemId=<%= item.getItemId() %>"
                           class="action-btn btn-delete"
                           title="Delete Book"
                           onclick="return confirmDelete('<%= item.getItemName() %>')">
                            <i class="fas fa-trash"></i>
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div class="table-footer">
            <div class="showing-info">
                Showing <%= items.size() %> book(s)
            </div>
        </div>
        <% } else { %>
        <div class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-book-open"></i>
            </div>
            <h3 class="empty-title">
                <% if (searchTerm != null) { %>
                No Results Found
                <% } else if (Boolean.TRUE.equals(isLowStockView)) { %>
                All Books Well Stocked!
                <% } else if (Boolean.TRUE.equals(isOutOfStockView)) { %>
                No Out of Stock Books!
                <% } else if (Boolean.TRUE.equals(isDiscountedView)) { %>
                No Books on Sale
                <% } else { %>
                No Books in Inventory
                <% } %>
            </h3>
            <p class="empty-text">
                <% if (searchTerm != null) { %>
                Try adjusting your search criteria or browse all books.
                <% } else if (Boolean.TRUE.equals(isLowStockView)) { %>
                Great! All your books are adequately stocked.
                <% } else if (Boolean.TRUE.equals(isOutOfStockView)) { %>
                Excellent! All books are currently in stock.
                <% } else if (Boolean.TRUE.equals(isDiscountedView)) { %>
                No discounts are currently active. Consider adding some to boost sales!
                <% } else { %>
                Start by adding your first book to the inventory.
                <% } %>
            </p>
            <% if (!Boolean.TRUE.equals(isLowStockView) && !Boolean.TRUE.equals(isOutOfStockView)) { %>
            <a href="${pageContext.request.contextPath}/item?action=add" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i>
                Add New Book
            </a>
            <% } else { %>
            <a href="${pageContext.request.contextPath}/item" class="btn btn-primary">
                <i class="fas fa-arrow-left"></i>
                View All Books
            </a>
            <% } %>
        </div>
        <% } %>
    </div>
</div>

<!-- Loading Overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loader"></div>
</div>

<script>
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
        content.innerHTML = '<h4>' + type.charAt(0).toUpperCase() + type.slice(1) + '</h4>' +
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

    // Confirm Delete with Modern Modal
    function confirmDelete(bookName) {
        const result = confirm('Are you sure you want to delete "' + bookName + '"?\n\nThis action cannot be undone.');
        if (result) {
            showLoading(true);
        }
        return result;
    }

    // Export Data
    function exportData() {
        showLoading(true);

        setTimeout(() => {
            showLoading(false);
            showNotification('Preparing export...', 'info');

            const table = document.getElementById('booksTable');
            if (!table) {
                showNotification('No data to export', 'error');
                return;
            }

            let csv = [];

            // Headers
            const headers = [];
            table.querySelectorAll('thead th').forEach((th, index) => {
                if (index < 7) { // Skip actions column
                    headers.push(th.textContent.trim());
                }
            });
            csv.push(headers.join(','));

            // Data rows
            table.querySelectorAll('tbody tr').forEach(tr => {
                const row = [];
                tr.querySelectorAll('td').forEach((td, index) => {
                    if (index < 7) { // Skip actions column
                        let text = td.textContent.trim().replace(/\s+/g, ' ');
                        // Remove currency symbols and format
                        text = text.replace(/LKR\s*/g, '');
                        // Wrap in quotes if contains comma
                        if (text.includes(',')) {
                            text = '"' + text + '"';
                        }
                        row.push(text);
                    }
                });
                csv.push(row.join(','));
            });

            // Download
            const blob = new Blob([csv.join('\n')], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            const date = new Date().toISOString().split('T')[0];
            a.download = 'bookstore_inventory_' + date + '.csv';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            window.URL.revokeObjectURL(url);

            showNotification('Export completed successfully!', 'success');
        }, 1000);
    }

    // Refresh Table
    function refreshTable() {
        showLoading(true);
        location.reload();
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

    // Fixed animate stats function for currency values
    function animateStats() {
        const stats = document.querySelectorAll('.stat-value');

        stats.forEach(stat => {
            const finalValue = parseFloat(stat.getAttribute('data-value'));
            const isCurrency = stat.getAttribute('data-format') === 'currency';
            const duration = 1500;
            const step = finalValue / (duration / 16);
            let current = 0;

            const timer = setInterval(() => {
                current += step;
                if (current >= finalValue) {
                    current = finalValue;
                    clearInterval(timer);
                }

                // Format the display value
                if (isCurrency) {
                    stat.textContent = Math.floor(current).toLocaleString();
                } else {
                    stat.textContent = Math.floor(current).toLocaleString();
                }
            }, 16);
        });
    }

    // Initialize on Load
    document.addEventListener('DOMContentLoaded', function() {
        // Animate stats
        animateStats();

        // Show notifications from server
        <% if (request.getParameter("success") != null) { %>
        showNotification('<%= request.getParameter("success") %>', 'success');
        <% } %>

        <% if (request.getAttribute("errorMessage") != null) { %>
        showNotification('<%= request.getAttribute("errorMessage") %>', 'error');
        <% } %>

        <% if (successMessage != null) { %>
        showNotification('<%= successMessage %>', 'success');
        <% } %>

        // Add table row hover effects
        const rows = document.querySelectorAll('.data-table tbody tr');
        rows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.01)';
            });
            row.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl/Cmd + A - Add new book
            if ((e.ctrlKey || e.metaKey) && e.key === 'a') {
                e.preventDefault();
                window.location.href = '${pageContext.request.contextPath}/item?action=add';
            }

            // Ctrl/Cmd + E - Export
            if ((e.ctrlKey || e.metaKey) && e.key === 'e') {
                e.preventDefault();
                exportData();
            }

            // Ctrl/Cmd + F - Focus search
            if ((e.ctrlKey || e.metaKey) && e.key === 'f') {
                e.preventDefault();
                const searchInput = document.querySelector('input[name="q"]');
                if (searchInput) {
                    searchInput.focus();
                    searchInput.select();
                }
            }
        });
    });

    // Print styles
    const printStyles = document.createElement('style');
    printStyles.innerHTML = '@media print {' +
        '.navbar, .header-actions, .search-section, .quick-filters, ' +
        '.table-actions, .actions-cell, .notification-container, ' +
        '.loading-overlay, .floating-elements, .bg-pattern { display: none !important; }' +
        '.page-header { margin-bottom: 1rem; padding: 1rem; }' +
        '.stats-container { page-break-after: avoid; }' +
        '.table-section { box-shadow: none; }' +
        '.data-table { font-size: 10pt; }' +
        '.data-table th, .data-table td { padding: 0.5rem; }' +
        '}';
    document.head.appendChild(printStyles);
</script>
</body>
</html>
