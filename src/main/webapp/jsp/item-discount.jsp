<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.pahanaedu.service.ItemService" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Discounts - Pahana Edu </title>
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
            --discount-gradient: linear-gradient(135deg, #EC4899 0%, #8B5CF6 100%);

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
            --shadow-discount: 0 0 30px rgba(236, 72, 153, 0.3);
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
                    repeating-linear-gradient(45deg, #EC4899 25%, transparent 25%, transparent 75%, #EC4899 75%, #EC4899),
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
            color: var(--secondary-color);
        }

        .float-element:nth-child(2) {
            top: 60%;
            right: 10%;
            font-size: 80px;
            animation-delay: 5s;
            color: var(--primary-color);
        }

        .float-element:nth-child(3) {
            bottom: 20%;
            left: 50%;
            font-size: 70px;
            animation-delay: 10s;
            color: var(--warning-color);
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
            background: var(--discount-gradient);
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

        /* Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
            animation: slideUp 0.6s ease-out 0.1s both;
        }

        .stat-card {
            background: var(--bg-secondary);
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--discount-gradient);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            background: var(--discount-gradient);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin-bottom: 1rem;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        /* Tabs */
        .tabs-container {
            background: var(--bg-secondary);
            border-radius: 20px;
            padding: 1rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            animation: slideUp 0.6s ease-out 0.2s both;
        }

        .tabs {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .tab-btn {
            padding: 0.875rem 1.75rem;
            background: transparent;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .tab-btn:hover {
            border-color: var(--secondary-color);
            color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .tab-btn.active {
            background: var(--discount-gradient);
            color: white;
            border-color: transparent;
            box-shadow: var(--shadow-discount);
        }

        .tab-content {
            display: none;
            animation: fadeIn 0.5s ease-out;
        }

        .tab-content.active {
            display: block;
        }

        /* Form Styles */
        .discount-form {
            background: var(--bg-secondary);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            animation: slideUp 0.6s ease-out 0.3s both;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
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

        .form-input, .form-select {
            padding: 0.875rem 1.25rem;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(236, 72, 153, 0.1);
        }

        /* Search Dropdown */
        .search-dropdown {
            position: relative;
        }

        .search-input {
            width: 100%;
            padding-right: 3rem;
        }

        .search-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }

        .search-results {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            margin-top: 0.5rem;
            max-height: 300px;
            overflow-y: auto;
            box-shadow: var(--shadow-lg);
            display: none;
            z-index: 100;
        }

        .search-results.show {
            display: block;
            animation: slideDown 0.3s ease-out;
        }

        .search-result-item {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-result-item:hover {
            background: var(--bg-primary);
            padding-left: 1.5rem;
        }

        .search-result-item:last-child {
            border-bottom: none;
        }

        .item-info {
            flex: 1;
        }

        .item-name {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .item-details {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .item-price {
            font-weight: 600;
            color: var(--primary-color);
        }

        /* Percentage Slider */
        .percentage-slider {
            position: relative;
            margin-top: 1rem;
        }

        .slider {
            width: 100%;
            height: 8px;
            border-radius: 4px;
            background: var(--border-color);
            outline: none;
            -webkit-appearance: none;
            cursor: pointer;
        }

        .slider::-webkit-slider-thumb {
            -webkit-appearance: none;
            appearance: none;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: var(--discount-gradient);
            cursor: pointer;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .slider::-webkit-slider-thumb:hover {
            transform: scale(1.2);
            box-shadow: var(--shadow-lg);
        }

        .slider::-moz-range-thumb {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: var(--discount-gradient);
            cursor: pointer;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .slider-value {
            position: absolute;
            top: -35px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--discount-gradient);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 1.125rem;
            box-shadow: var(--shadow-md);
            animation: bounce 0.5s ease-out;
        }

        @keyframes bounce {
            0% { transform: translateX(-50%) translateY(10px); opacity: 0; }
            50% { transform: translateX(-50%) translateY(-5px); }
            100% { transform: translateX(-50%) translateY(0); opacity: 1; }
        }

        /* Discount Preview Card */
        .discount-preview {
            margin-top: 2rem;
        }

        .preview-card {
            background: var(--bg-secondary);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            border: 2px solid var(--border-color);
        }

        .preview-header {
            background: var(--discount-gradient);
            padding: 1.5rem;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .preview-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .preview-header h3 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            position: relative;
            z-index: 1;
        }

        .preview-body {
            padding: 1.5rem;
        }

        .price-comparison {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .price-box {
            text-align: center;
            padding: 1rem;
            border-radius: 12px;
            background: var(--bg-primary);
        }

        .price-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .price-value {
            font-size: 1.75rem;
            font-weight: 700;
        }

        .original-price {
            color: var(--text-secondary);
            text-decoration: line-through;
        }

        .sale-price {
            color: var(--danger-color);
        }

        .savings-info {
            background: var(--success-gradient);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            font-weight: 600;
        }

        /* Category Cards */
        .category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .category-card {
            background: var(--bg-secondary);
            border: 2px solid var(--border-color);
            border-radius: 16px;
            padding: 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .category-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--discount-gradient);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
        }

        .category-card:hover {
            border-color: var(--secondary-color);
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .category-card.selected {
            background: var(--discount-gradient);
            color: white;
            border-color: transparent;
            box-shadow: var(--shadow-discount);
        }

        .category-card.selected::before {
            opacity: 1;
        }

        .category-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
            opacity: 0.8;
        }

        .category-name {
            font-size: 1.125rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .category-count {
            font-size: 0.875rem;
            opacity: 0.8;
        }

        /* Active Discounts Table */
        .discounts-table {
            background: var(--bg-secondary);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            animation: slideUp 0.6s ease-out 0.4s both;
        }

        .table-header {
            background: var(--discount-gradient);
            padding: 1.5rem 2rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            font-size: 1.25rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .table-controls {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border-radius: 20px;
            width: 250px;
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }

        .search-box input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .search-box input:focus {
            outline: none;
            border-color: white;
            background: rgba(255, 255, 255, 0.3);
        }

        .search-box i {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: white;
            opacity: 0.7;
        }

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
        }

        .data-table tbody tr:hover {
            background: var(--bg-primary);
            transform: scale(1.01);
        }

        /* Discount Badge */
        .discount-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.375rem 0.75rem;
            background: var(--discount-gradient);
            color: white;
            border-radius: 12px;
            font-size: 0.875rem;
            font-weight: 600;
            animation: pulse 3s ease-in-out infinite;
        }

        /* Quick Actions */
        .quick-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .quick-action-btn {
            padding: 0.75rem 1.5rem;
            background: var(--bg-secondary);
            border: 2px solid var(--border-color);
            border-radius: 12px;
            color: var(--text-primary);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .quick-action-btn:hover {
            background: var(--primary-gradient);
            color: white;
            border-color: transparent;
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        /* Action Buttons */
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
            background: var(--discount-gradient);
            color: white;
            box-shadow: 0 4px 14px rgba(236, 72, 153, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(236, 72, 153, 0.5);
        }

        .btn-secondary {
            background: var(--dark-gradient);
            color: white;
        }

        .btn-danger {
            background: var(--danger-gradient);
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

        /* Loading State */
        .loading {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem;
            color: var(--text-secondary);
        }

        .loading i {
            font-size: 2rem;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 4rem;
            opacity: 0.3;
            margin-bottom: 1rem;
        }

        /* Toast Notifications */
        .toast {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            padding: 1rem 1.5rem;
            background: var(--bg-secondary);
            border-radius: 12px;
            box-shadow: var(--shadow-xl);
            display: flex;
            align-items: center;
            gap: 1rem;
            transform: translateX(400px);
            transition: transform 0.3s ease;
            z-index: 9999;
        }

        .toast.show {
            transform: translateX(0);
        }

        .toast-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .toast-success .toast-icon {
            background: var(--success-gradient);
        }

        .toast-error .toast-icon {
            background: var(--danger-gradient);
        }

        .toast-content h4 {
            margin: 0 0 0.25rem 0;
            font-size: 1rem;
            color: var(--text-primary);
        }

        .toast-content p {
            margin: 0;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .category-grid {
                grid-template-columns: 1fr;
            }

            .price-comparison {
                grid-template-columns: 1fr;
            }

            .table-controls {
                flex-direction: column;
                gap: 0.5rem;
            }

            .search-box input {
                width: 100%;
            }

            .data-table {
                font-size: 0.875rem;
            }

            .data-table th,
            .data-table td {
                padding: 0.75rem;
            }

            .quick-actions {
                flex-direction: column;
            }

            .quick-action-btn {
                width: 100%;
                justify-content: center;
            }
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
            from { opacity: 0; }
            to { opacity: 1; }
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
    </style>
</head>
<body>
<!-- Background Pattern -->
<div class="bg-pattern"></div>

<!-- Floating Elements -->
<div class="floating-elements">
    <div class="float-element">%</div>
    <div class="float-element">🏷️</div>
    <div class="float-element">💰</div>
</div>

    <%
    // Check if user is logged in
    if (session == null || session.getAttribute("adminUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    // Get data from servlet
    Item selectedItem = (Item) request.getAttribute("item");
    @SuppressWarnings("unchecked")
    List<String> categories = (List<String>) request.getAttribute("categories");
    @SuppressWarnings("unchecked")
    List<Item> allItems = (List<Item>) request.getAttribute("allItems");
    @SuppressWarnings("unchecked")
    List<Item> discountedItems = (List<Item>) request.getAttribute("discountedItems");
    @SuppressWarnings("unchecked")
    Map<String, Integer> categoryCounts = (Map<String, Integer>) request.getAttribute("categoryCounts");

    // Calculate statistics
    int totalItems = allItems != null ? allItems.size() : 0;
    int totalDiscounted = discountedItems != null ? discountedItems.size() : 0;
    BigDecimal totalSavings = BigDecimal.ZERO;
    BigDecimal avgDiscount = BigDecimal.ZERO;

    if (discountedItems != null && !discountedItems.isEmpty()) {
        BigDecimal sumDiscount = BigDecimal.ZERO;
        for (Item item : discountedItems) {
            sumDiscount = sumDiscount.add(item.getDiscountPercentage());
            BigDecimal saving = item.getPrice().multiply(item.getDiscountPercentage())
                .divide(new BigDecimal(100), 2, BigDecimal.ROUND_HALF_UP)
                .multiply(new BigDecimal(item.getStock()));
            totalSavings = totalSavings.add(saving);
        }
        avgDiscount = sumDiscount.divide(new BigDecimal(totalDiscounted), 2, BigDecimal.ROUND_HALF_UP);
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
    <!-- Page Header -->
    <div class="page-header">
        <div class="header-content">
            <h1 class="page-title">
                <i class="fas fa-percentage"></i>
                Discount Management
            </h1>
            <p class="page-subtitle">Create and manage special offers, sales, and discounts for your books</p>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-tags"></i>
            </div>
            <div class="stat-value"><%= totalDiscounted %></div>
            <div class="stat-label">Active Discounts</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-percentage"></i>
            </div>
            <div class="stat-value"><%= avgDiscount %>%</div>
            <div class="stat-label">Average Discount</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-piggy-bank"></i>
            </div>
            <div class="stat-value">LKR <%= String.format("%,.0f", totalSavings) %></div>
            <div class="stat-label">Total Customer Savings</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-books"></i>
            </div>
            <div class="stat-value"><%= totalItems %></div>
            <div class="stat-label">Total Items</div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <button class="quick-action-btn" onclick="applyQuickDiscount(10)">
            <i class="fas fa-bolt"></i> Quick 10% Off
        </button>
        <button class="quick-action-btn" onclick="applyQuickDiscount(15)">
            <i class="fas fa-fire"></i> Quick 15% Off
        </button>
        <button class="quick-action-btn" onclick="applyQuickDiscount(20)">
            <i class="fas fa-star"></i> Quick 20% Off
        </button>
        <button class="quick-action-btn" onclick="removeAllDiscounts()">
            <i class="fas fa-times-circle"></i> Clear All Discounts
        </button>
        <button class="quick-action-btn" onclick="exportDiscountReport()">
            <i class="fas fa-download"></i> Export Report
        </button>
    </div>

    <!-- Success/Error Messages -->
    <% if (request.getParameter("success") != null) { %>
    <div class="toast toast-success show" id="successToast">
        <div class="toast-icon">
            <i class="fas fa-check"></i>
        </div>
        <div class="toast-content">
            <h4>Success!</h4>
            <p><%= request.getParameter("success") %></p>
        </div>
    </div>
    <% } %>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="toast toast-error show" id="errorToast">
        <div class="toast-icon">
            <i class="fas fa-times"></i>
        </div>
        <div class="toast-content">
            <h4>Error!</h4>
            <p><%= request.getAttribute("errorMessage") %></p>
        </div>
    </div>
    <% } %>

    <!-- Tabs -->
    <div class="tabs-container">
        <div class="tabs">
            <button class="tab-btn active" onclick="switchTab('individual')">
                <i class="fas fa-book"></i>
                Individual Book
            </button>
            <button class="tab-btn" onclick="switchTab('bulk')">
                <i class="fas fa-layer-group"></i>
                Bulk Discount
            </button>
            <button class="tab-btn" onclick="switchTab('active')">
                <i class="fas fa-tags"></i>
                Active Discounts
            </button>
            <button class="tab-btn" onclick="switchTab('schedule')">
                <i class="fas fa-calendar-alt"></i>
                Schedule Discounts
            </button>
        </div>
    </div>

    <!-- Individual Book Discount Tab -->
    <div id="individual-tab" class="tab-content active">
        <div class="discount-form">
            <form action="${pageContext.request.contextPath}/item" method="post" id="individualDiscountForm">
                <input type="hidden" name="action" value="updateDiscount">

                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-book"></i>
                            Select Book
                        </label>
                        <div class="search-dropdown">
                            <input type="text"
                                   id="bookSearch"
                                   class="form-input search-input"
                                   placeholder="Search by title or ISBN..."
                                   autocomplete="off"
                                   onkeyup="searchBooks(this.value)">
                            <i class="fas fa-search search-icon"></i>
                            <div id="searchResults" class="search-results"></div>
                        </div>
                        <input type="hidden" id="selectedBookId" name="itemId">
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-percentage"></i>
                            Discount Percentage
                        </label>
                        <div class="percentage-slider">
                            <input type="range"
                                   id="discountSlider"
                                   name="discountPercentage"
                                   class="slider"
                                   min="0"
                                   max="100"
                                   step="5"
                                   value="0"
                                   oninput="updateSliderValue()">
                            <div class="slider-value" id="sliderValue">0%</div>
                        </div>
                        <input type="number"
                               id="discountInput"
                               class="form-input"
                               min="0"
                               max="100"
                               step="0.01"
                               placeholder="Or enter manually"
                               oninput="updateFromInput()">
                    </div>
                </div>

                <div class="discount-preview" id="discountPreview" style="display: none;">
                    <div class="preview-card">
                        <div class="preview-header">
                            <h3>Discount Preview</h3>
                        </div>
                        <div class="preview-body">
                            <h4 id="previewBookName" style="margin-bottom: 1rem;">-</h4>
                            <div class="price-comparison">
                                <div class="price-box">
                                    <div class="price-label">Original Price</div>
                                    <div class="price-value original-price" id="originalPrice">LKR 0.00</div>
                                </div>
                                <div class="price-box">
                                    <div class="price-label">Sale Price</div>
                                    <div class="price-value sale-price" id="salePrice">LKR 0.00</div>
                                </div>
                            </div>
                            <div class="savings-info">
                                <i class="fas fa-piggy-bank"></i>
                                Customer saves: <span id="savingsAmount">LKR 0.00</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="margin-top: 2rem; text-align: center;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Apply Discount
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bulk Discount Tab -->
    <div id="bulk-tab" class="tab-content">
        <div class="discount-form">
            <form action="${pageContext.request.contextPath}/item" method="post" id="bulkDiscountForm">
                <input type="hidden" name="action" value="applyBulkDiscount">

                <h3 style="margin-bottom: 1.5rem; color: var(--text-primary);">
                    <i class="fas fa-layer-group"></i>
                    Apply Discount by Category
                </h3>

                <div class="category-grid">
                    <% if (categories != null) {
                        for (String category : categories) {
                            int count = categoryCounts != null ? categoryCounts.getOrDefault(category, 0) : 0;
                    %>
                    <div class="category-card" onclick="selectCategory(this, '<%= category %>')">
                        <i class="fas fa-folder category-icon"></i>
                        <div class="category-name"><%= category %></div>
                        <div class="category-count"><%= count %> books</div>
                    </div>
                    <% }
                    } %>
                </div>

                <input type="hidden" id="selectedCategory" name="category">

                <div class="form-group" style="margin-top: 2rem;">
                    <label class="form-label">
                        <i class="fas fa-percentage"></i>
                        Bulk Discount Percentage (Max 50%)
                    </label>
                    <div class="percentage-slider">
                        <input type="range"
                               id="bulkDiscountSlider"
                               name="discountPercentage"
                               class="slider"
                               min="0"
                               max="50"
                               step="5"
                               value="0"
                               oninput="updateBulkSliderValue()">
                        <div class="slider-value" id="bulkSliderValue">0%</div>
                    </div>
                </div>

                <div class="discount-preview" id="bulkDiscountPreview" style="display: none;">
                    <div class="preview-card">
                        <div class="preview-header">
                            <h3>Bulk Discount Preview</h3>
                        </div>
                        <div class="preview-body">
                            <p style="font-size: 1.125rem;">
                                <i class="fas fa-info-circle"></i>
                                This will apply <span id="bulkDiscountPercent">0%</span> discount to
                                <span id="affectedBooks">0</span> books in the
                                <strong id="selectedCategoryName">-</strong> category.
                            </p>
                        </div>
                    </div>
                </div>

                <div style="margin-top: 2rem; text-align: center;">
                    <button type="submit" class="btn btn-primary" disabled id="applyBulkBtn">
                        <i class="fas fa-tags"></i>
                        Apply Bulk Discount
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Active Discounts Tab -->
    <div id="active-tab" class="tab-content">
        <div class="discounts-table">
            <div class="table-header">
                <h3 class="table-title">
                    <i class="fas fa-tags"></i>
                    Currently Active Discounts
                </h3>
                <div class="table-controls">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text"
                               placeholder="Search discounts..."
                               id="discountSearch"
                               onkeyup="filterDiscounts(this.value)">
                    </div>
                    <button class="btn btn-sm btn-secondary" onclick="refreshDiscounts()">
                        <i class="fas fa-sync-alt"></i>
                        Refresh
                    </button>
                </div>
            </div>
            <table class="data-table">
                <thead>
                <tr>
                    <th>ISBN</th>
                    <th>Book Title</th>
                    <th>Category</th>
                    <th>Original Price</th>
                    <th>Discount</th>
                    <th>Sale Price</th>
                    <th>Savings</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="discountedItemsTable">
                <% if (discountedItems != null && !discountedItems.isEmpty()) {
                    for (Item item : discountedItems) {
                        BigDecimal discountAmount = item.getPrice().multiply(item.getDiscountPercentage())
                                .divide(new BigDecimal(100), 2, BigDecimal.ROUND_HALF_UP);
                        BigDecimal salePrice = item.getPrice().subtract(discountAmount);
                %>
                <tr class="discount-row">
                    <td><%= item.getItemId() %></td>
                    <td><%= item.getItemName() %></td>
                    <td><%= item.getCategory() != null ? item.getCategory() : "N/A" %></td>
                    <td>LKR <%= String.format("%.2f", item.getPrice()) %></td>
                    <td>
                            <span class="discount-badge">
                                <i class="fas fa-tag"></i> <%= item.getDiscountPercentage() %>%
                            </span>
                    </td>
                    <td style="color: var(--danger-color); font-weight: 600;">
                        LKR <%= String.format("%.2f", salePrice) %>
                    </td>
                    <td style="color: var(--success-color); font-weight: 600;">
                        LKR <%= String.format("%.2f", discountAmount) %>
                    </td>
                    <td>
                        <div style="display: flex; gap: 0.5rem;">
                            <button class="btn btn-sm btn-secondary"
                                    onclick="editDiscount('<%= item.getItemId() %>', <%= item.getDiscountPercentage() %>)">
                                <i class="fas fa-edit"></i>
                            </button>
                            <form action="${pageContext.request.contextPath}/item" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="updateDiscount">
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                <input type="hidden" name="discountPercentage" value="0">
                                <button type="submit" class="btn btn-sm btn-danger"
                                        onclick="return confirm('Remove discount from <%= item.getItemName() %>?')">
                                    <i class="fas fa-times"></i>
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <% }
                } else { %>
                <tr>
                    <td colspan="8" class="empty-state">
                        <i class="fas fa-tag"></i>
                        <p>No active discounts found</p>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Schedule Discounts Tab -->
    <div id="schedule-tab" class="tab-content">
        <div class="discount-form">
            <h3 style="margin-bottom: 1.5rem; color: var(--text-primary);">
                <i class="fas fa-calendar-alt"></i>
                Schedule Future Discounts
            </h3>

            <div class="empty-state">
                <i class="fas fa-clock"></i>
                <h3>Coming Soon!</h3>
                <p>Schedule discounts to start and end automatically</p>
            </div>
        </div>
    </div>
</div>

<!-- Edit Discount Modal -->
<div id="editModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999;">
    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 2rem; border-radius: 20px; width: 90%; max-width: 400px;">
        <h3 style="margin-bottom: 1.5rem;">Edit Discount</h3>
        <form action="${pageContext.request.contextPath}/item" method="post">
            <input type="hidden" name="action" value="updateDiscount">
            <input type="hidden" id="editItemId" name="itemId">
            <div class="form-group">
                <label class="form-label">New Discount Percentage</label>
                <input type="number"
                       id="editDiscountValue"
                       name="discountPercentage"
                       class="form-input"
                       min="0"
                       max="100"
                       step="0.01"
                       required>
            </div>
            <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
                <button type="submit" class="btn btn-primary">Update</button>
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Initialize
    document.addEventListener('DOMContentLoaded', function() {
        updateSliderValue();
        updateBulkSliderValue();

        // Auto-hide toasts
        setTimeout(() => {
            const toasts = document.querySelectorAll('.toast');
            toasts.forEach(toast => toast.classList.remove('show'));
        }, 5000);

        // Load items for search
        loadItemsForSearch();
    });

    // Store all items for search
    let allItemsData = [];

    function loadItemsForSearch() {
        // Convert JSP data to JavaScript
        <% if (allItems != null) { %>
        allItemsData = [
            <% for (int i = 0; i < allItems.size(); i++) {
                Item item = allItems.get(i);
            %>
            {
                itemId: '<%= item.getItemId() %>',
                itemName: '<%= item.getItemName().replace("'", "\\'") %>',
                price: <%= item.getPrice() %>,
                category: '<%= item.getCategory() != null ? item.getCategory() : "" %>',
                discount: <%= item.getDiscountPercentage() %>
            }<%= i < allItems.size() - 1 ? "," : "" %>
            <% } %>
        ];
        <% } %>
    }

    // Tab switching
    function switchTab(tabName) {
        // Hide all tabs
        document.querySelectorAll('.tab-content').forEach(tab => {
            tab.classList.remove('active');
        });

        // Remove active class from all buttons
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.remove('active');
        });

        // Show selected tab
        document.getElementById(tabName + '-tab').classList.add('active');

        // Add active class to clicked button
        event.target.closest('.tab-btn').classList.add('active');
    }

    // Book search functionality
    function searchBooks(query) {
        const searchResults = document.getElementById('searchResults');

        if (query.length < 2) {
            searchResults.classList.remove('show');
            return;
        }

        const filteredItems = allItemsData.filter(item =>
            item.itemId.toLowerCase().includes(query.toLowerCase()) ||
            item.itemName.toLowerCase().includes(query.toLowerCase())
        );

        if (filteredItems.length > 0) {
            let html = '';
            filteredItems.slice(0, 10).forEach(item => {
                html += `
        <div class="search-result-item"
             onclick="selectBook('\${item.itemId}', '\${item.itemName.replace(/\'/g, "\\'")}', \${item.price}, \${item.discount})">
            <div class="item-info">
                <div class="item-name">\${item.itemName}</div>
                <div class="item-details">ISBN: \${item.itemId} | \${item.category || 'No Category'}</div>
            </div>
            <div class="item-price">LKR \${item.price.toFixed(2)}</div>
        </div>
    `;
            });
            searchResults.innerHTML = html;
            searchResults.classList.add('show');
        } else {
            searchResults.innerHTML = '<div class="search-result-item">No books found</div>';
            searchResults.classList.add('show');
        }
    }

    // Select book from search
    function selectBook(itemId, itemName, price, currentDiscount) {
        document.getElementById('bookSearch').value = itemName;
        document.getElementById('selectedBookId').value = itemId;
        document.getElementById('searchResults').classList.remove('show');

        // Update discount slider to current discount
        document.getElementById('discountSlider').value = currentDiscount;
        updateSliderValue();

        // Show preview
        document.getElementById('discountPreview').style.display = 'block';
        document.getElementById('previewBookName').textContent = itemName;
        updateDiscountPreview(price);
    }

    // Hide search results when clicking outside
    document.addEventListener('click', function(e) {
        const searchDropdown = document.querySelector('.search-dropdown');
        if (!searchDropdown.contains(e.target)) {
            document.getElementById('searchResults').classList.remove('show');
        }
    });

    // Update slider value display
    function updateSliderValue() {
        const slider = document.getElementById('discountSlider');
        const value = slider.value;
        const sliderValue = document.getElementById('sliderValue');

        sliderValue.textContent = value + '%';
        sliderValue.style.left = (value / 100 * (slider.offsetWidth - 24) + 12) + 'px';

        // Update input field
        document.getElementById('discountInput').value = value;

        // Change color based on discount amount
        if (value >= 50) {
            slider.style.background = `linear-gradient(to right, #EF4444 0%, #EF4444 ${value}%, #E5E7EB ${value}%, #E5E7EB 100%)`;
        } else if (value >= 25) {
            slider.style.background = `linear-gradient(to right, #F59E0B 0%, #F59E0B ${value}%, #E5E7EB ${value}%, #E5E7EB 100%)`;
        } else {
            slider.style.background = `linear-gradient(to right, #10B981 0%, #10B981 ${value}%, #E5E7EB ${value}%, #E5E7EB 100%)`;
        }

        // Update preview if book is selected
        if (document.getElementById('selectedBookId').value) {
            const selectedItem = allItemsData.find(item => item.itemId === document.getElementById('selectedBookId').value);
            if (selectedItem) {
                updateDiscountPreview(selectedItem.price);
            }
        }
    }

    // Update from manual input
    function updateFromInput() {
        const input = document.getElementById('discountInput');
        const value = Math.min(100, Math.max(0, parseFloat(input.value) || 0));
        document.getElementById('discountSlider').value = value;
        updateSliderValue();
    }

    // Update discount preview
    function updateDiscountPreview(price) {
        const discountPercent = parseFloat(document.getElementById('discountSlider').value) || 0;
        const discountAmount = price * (discountPercent / 100);
        const salePrice = price - discountAmount;

        document.getElementById('originalPrice').textContent = 'LKR ' + price.toFixed(2);
        document.getElementById('salePrice').textContent = 'LKR ' + salePrice.toFixed(2);
        document.getElementById('savingsAmount').textContent = 'LKR ' + discountAmount.toFixed(2);
    }

    // Bulk discount slider
    function updateBulkSliderValue() {
        const slider = document.getElementById('bulkDiscountSlider');
        const value = slider.value;
        const sliderValue = document.getElementById('bulkSliderValue');

        sliderValue.textContent = value + '%';
        sliderValue.style.left = (value / 50 * (slider.offsetWidth - 24) + 12) + 'px';

        // Update slider color
        if (value >= 30) {
            slider.style.background = `linear-gradient(to right, #EF4444 0%, #EF4444 ${value * 2}%, #E5E7EB ${value * 2}%, #E5E7EB 100%)`;
        } else if (value >= 15) {
            slider.style.background = `linear-gradient(to right, #F59E0B 0%, #F59E0B ${value * 2}%, #E5E7EB ${value * 2}%, #E5E7EB 100%)`;
        } else {
            slider.style.background = `linear-gradient(to right, #10B981 0%, #10B981 ${value * 2}%, #E5E7EB ${value * 2}%, #E5E7EB 100%)`;
        }

        updateBulkPreview();
    }

    // Category selection
    let selectedCategoryData = null;

    function selectCategory(element, category) {
        // Remove selected class from all
        document.querySelectorAll('.category-card').forEach(card => {
            card.classList.remove('selected');
        });

        // Add selected class
        element.classList.add('selected');

        // Update hidden input
        document.getElementById('selectedCategory').value = category;

        // Store category data
        selectedCategoryData = {
            name: category,
            count: parseInt(element.querySelector('.category-count').textContent)
        };

        // Enable apply button
        document.getElementById('applyBulkBtn').disabled = false;

        // Show preview
        document.getElementById('bulkDiscountPreview').style.display = 'block';
        updateBulkPreview();
    }

    // Update bulk preview
    function updateBulkPreview() {
        if (selectedCategoryData) {
            const discount = document.getElementById('bulkDiscountSlider').value;
            document.getElementById('bulkDiscountPercent').textContent = discount + '%';
            document.getElementById('selectedCategoryName').textContent = selectedCategoryData.name;
            document.getElementById('affectedBooks').textContent = selectedCategoryData.count;
        }
    }

    // Filter active discounts
    function filterDiscounts(query) {
        const rows = document.querySelectorAll('.discount-row');
        const lowerQuery = query.toLowerCase();

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(lowerQuery) ? '' : 'none';
        });
    }

    // Refresh discounts
    function refreshDiscounts() {
        location.reload();
    }

    // Edit discount
    function editDiscount(itemId, currentDiscount) {
        document.getElementById('editItemId').value = itemId;
        document.getElementById('editDiscountValue').value = currentDiscount;
        document.getElementById('editModal').style.display = 'block';
    }

    // Close edit modal
    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }

    // Quick discount actions
    function applyQuickDiscount(percentage) {
        if (confirm(`Apply ${percentage}% discount to selected items?`)) {
            // This would need implementation to select multiple items
            alert('Please select items first. This feature is coming soon!');
        }
    }

    // Remove all discounts
    function removeAllDiscounts() {
        if (confirm('Remove ALL active discounts? This action cannot be undone.')) {
            // This would need a server endpoint to remove all discounts
            alert('This feature requires additional server implementation.');
        }
    }

    // Export discount report
    function exportDiscountReport() {
        // This would generate a CSV/PDF report
        alert('Export feature coming soon!');
    }

    // Form validation
    document.getElementById('individualDiscountForm').addEventListener('submit', function(e) {
        const bookId = document.getElementById('selectedBookId').value;
        if (!bookId) {
            e.preventDefault();
            alert('Please select a book first');
        }
    });

    document.getElementById('bulkDiscountForm').addEventListener('submit', function(e) {
        const category = document.getElementById('selectedCategory').value;
        if (!category) {
            e.preventDefault();
            alert('Please select a category first');
        } else {
            const discount = document.getElementById('bulkDiscountSlider').value;
            if (!confirm(`Apply ${discount}% discount to all books in ${category} category?`)) {
                e.preventDefault();
            }
        }
    });
</script>

</body>
</html>
