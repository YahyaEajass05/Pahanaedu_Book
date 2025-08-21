<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pahanaedu.model.Item" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Item Management - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

        * {
            font-family: 'Inter', sans-serif;
        }

        /* Animation Keyframes */
        @keyframes fadeInDown {
            0% { transform: translateY(-30px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        @keyframes fadeInUp {
            0% { transform: translateY(30px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        @keyframes slideInLeft {
            0% { transform: translateX(-50px); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideInRight {
            0% { transform: translateX(50px); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }

        @keyframes scaleIn {
            0% { transform: scale(0.8); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes glow {
            0%, 100% { box-shadow: 0 0 20px rgba(45, 212, 191, 0.4); }
            50% { box-shadow: 0 0 40px rgba(45, 212, 191, 0.8); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-8px); }
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-8px); }
            60% { transform: translateY(-4px); }
        }

        /* Main Styles */
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #2dd4bf 100%);
            min-height: 100vh;
            margin: 0;
        }

        .items-header {
            background: linear-gradient(145deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            color: white;
            padding: 3rem 2rem;
            border-radius: 25px;
            margin-bottom: 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.4);
            position: relative;
            overflow: hidden;
            animation: fadeInDown 0.8s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        .items-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(45, 212, 191, 0.2), transparent);
            animation: shimmer 3s infinite;
        }

        .items-header h1 {
            margin: 0;
            font-size: 3rem;
            font-weight: 800;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
            z-index: 2;
        }

        .items-header h1 i {
            color: #2dd4bf;
            animation: float 3s infinite;
        }

        .items-header p {
            margin: 0.5rem 0 0 0;
            opacity: 0.9;
            font-size: 1.2rem;
            font-weight: 300;
            position: relative;
            z-index: 2;
        }

        .header-actions {
            display: flex;
            gap: 1.5rem;
            align-items: center;
            position: relative;
            z-index: 2;
        }

        .search-container {
            background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            margin-bottom: 2.5rem;
            border: 1px solid rgba(45, 212, 191, 0.1);
            animation: slideInLeft 0.8s ease-out 0.2s both;
            position: relative;
            overflow: hidden;
        }

        .search-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #2dd4bf, #0891b2, #06b6d4);
            border-radius: 20px 20px 0 0;
        }

        .search-form {
            display: flex;
            gap: 1.5rem;
            align-items: end;
        }

        .search-group {
            flex: 1;
        }

        .search-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 700;
            color: #1e293b;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .search-input {
            width: 100%;
            padding: 1rem 1.2rem;
            border: 3px solid #e2e8f0;
            border-radius: 15px;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
        }

        .search-input:focus {
            outline: none;
            border-color: #2dd4bf;
            background: linear-gradient(145deg, #ffffff 0%, #f0fdfa 100%);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(45, 212, 191, 0.3);
            animation: glow 0.5s ease-out;
        }

        .items-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .stat-box {
            background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-top: 5px solid #2dd4bf;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            animation: scaleIn 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .stat-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(45, 212, 191, 0.1), transparent);
            transition: left 0.5s;
        }

        .stat-box:hover::before {
            left: 100%;
        }

        .stat-box:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .stat-box:nth-child(1) {
            border-top-color: #2dd4bf;
            animation-delay: 0.1s;
        }
        .stat-box.inventory {
            border-top-color: #3b82f6;
            animation-delay: 0.2s;
        }
        .stat-box.low-stock {
            border-top-color: #ef4444;
            animation-delay: 0.3s;
        }
        .stat-box.total-value {
            border-top-color: #10b981;
            animation-delay: 0.4s;
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 900;
            color: #2dd4bf;
            margin: 0;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            animation: pulse 2s infinite;
        }

        .stat-box.inventory .stat-number { color: #3b82f6; }
        .stat-box.low-stock .stat-number { color: #ef4444; }
        .stat-box.total-value .stat-number { color: #10b981; }

        .stat-label {
            color: #64748b;
            font-size: 1rem;
            font-weight: 600;
            margin: 8px 0 0 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table-container {
            background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
            border-radius: 25px;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 0.8s ease-out 0.4s both;
            border: 1px solid rgba(45, 212, 191, 0.1);
        }

        .table-header {
            background: linear-gradient(145deg, #0f172a 0%, #1e293b 100%);
            color: white;
            padding: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .table-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(45, 212, 191, 0.2), transparent);
            animation: shimmer 4s infinite;
        }

        .table-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
            position: relative;
            z-index: 2;
        }

        .table-title i {
            color: #2dd4bf;
            animation: bounce 2s infinite;
        }

        .table-filters {
            display: flex;
            gap: 1.5rem;
            align-items: center;
            position: relative;
            z-index: 2;
        }

        .filter-select {
            padding: 0.8rem 1.2rem;
            border: 2px solid #2dd4bf;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            background: linear-gradient(145deg, #ffffff 0%, #f0fdfa 100%);
            color: #1e293b;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: #0891b2;
            box-shadow: 0 0 20px rgba(45, 212, 191, 0.3);
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table th {
            background: linear-gradient(145deg, #1e293b 0%, #334155 100%);
            color: white;
            padding: 1.5rem 1rem;
            text-align: left;
            font-weight: 700;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
        }

        .items-table th::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #2dd4bf, #0891b2, #06b6d4);
        }

        .items-table td {
            padding: 1.5rem 1rem;
            border-bottom: 1px solid #e2e8f0;
            vertical-align: middle;
            transition: all 0.3s ease;
        }

        .items-table tbody tr {
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            animation: slideInRight 0.5s ease-out;
        }

        .items-table tbody tr:nth-child(odd) {
            background: rgba(45, 212, 191, 0.02);
        }

        .items-table tbody tr:hover {
            background: linear-gradient(145deg, #f0fdfa 0%, #ccfbf1 100%);
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(45, 212, 191, 0.2);
        }

        .item-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .item-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(145deg, #2dd4bf 0%, #0891b2 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            box-shadow: 0 5px 15px rgba(45, 212, 191, 0.3);
            transition: all 0.3s ease;
            animation: float 4s infinite;
        }

        .item-info:hover .item-icon {
            transform: rotate(360deg) scale(1.1);
            animation-play-state: paused;
        }

        .item-details h4 {
            margin: 0 0 4px 0;
            color: #1e293b;
            font-size: 1.1rem;
            font-weight: 700;
        }

        .item-details p {
            margin: 0;
            color: #64748b;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .price-display {
            font-size: 1.4rem;
            font-weight: 800;
            color: #10b981;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .price-display::before {
            content: '💰';
            animation: bounce 2s infinite;
        }

        .stock-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .stock-high {
            background: linear-gradient(145deg, #dcfce7 0%, #bbf7d0 100%);
            color: #166534;
            border: 2px solid #22c55e;
        }
        .stock-medium {
            background: linear-gradient(145deg, #fef3c7 0%, #fde68a 100%);
            color: #92400e;
            border: 2px solid #f59e0b;
        }
        .stock-low {
            background: linear-gradient(145deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
            border: 2px solid #ef4444;
            animation: pulse 2s infinite;
        }
        .stock-out {
            background: linear-gradient(145deg, #f1f5f9 0%, #e2e8f0 100%);
            color: #475569;
            border: 2px solid #94a3b8;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 0.8rem 1.2rem;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }

        .btn-action::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-action:hover::before {
            left: 100%;
        }

        .btn-view {
            background: linear-gradient(145deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.3);
        }
        .btn-edit {
            background: linear-gradient(145deg, #f59e0b 0%, #d97706 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(245, 158, 11, 0.3);
        }
        .btn-delete {
            background: linear-gradient(145deg, #ef4444 0%, #dc2626 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
        }

        .btn-action:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .btn-view:hover { box-shadow: 0 10px 25px rgba(59, 130, 246, 0.5); }
        .btn-edit:hover { box-shadow: 0 10px 25px rgba(245, 158, 11, 0.5); }
        .btn-delete:hover { box-shadow: 0 10px 25px rgba(239, 68, 68, 0.5); }

        .low-stock-alert {
            background: linear-gradient(145deg, #ef4444 0%, #dc2626 100%);
            color: white;
            padding: 2rem;
            border-radius: 20px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            box-shadow: 0 15px 35px rgba(239, 68, 68, 0.3);
            animation: slideInLeft 0.8s ease-out, pulse 3s infinite;
            position: relative;
            overflow: hidden;
        }

        .low-stock-alert::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: shimmer 2s infinite;
        }

        .alert-icon {
            font-size: 2rem;
            animation: bounce 1s infinite;
            position: relative;
            z-index: 2;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #64748b;
            animation: fadeInUp 0.8s ease-out;
        }

        .empty-state-icon {
            font-size: 5rem;
            margin-bottom: 2rem;
            opacity: 0.6;
            animation: float 4s infinite;
        }

        .empty-state h3 {
            margin: 0 0 1rem 0;
            color: #1e293b;
            font-size: 2rem;
            font-weight: 700;
        }

        .empty-state p {
            margin: 0 0 3rem 0;
            font-size: 1.2rem;
            line-height: 1.6;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 2rem;
            padding: 2.5rem;
            background: linear-gradient(145deg, #f8fafc 0%, #f1f5f9 100%);
            border-top: 1px solid #e2e8f0;
        }

        .page-info {
            color: #64748b;
            font-size: 1rem;
            font-weight: 500;
        }

        .page-info a {
            color: #2dd4bf;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.3s ease;
        }

        .page-info a:hover {
            color: #0891b2;
            text-decoration: underline;
        }

        /* Button Enhancements */
        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 15px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            transform: translateY(-3px) scale(1.05);
            text-decoration: none;
        }

        .btn-success {
            background: linear-gradient(145deg, #10b981 0%, #059669 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
        }

        .btn-success:hover {
            box-shadow: 0 15px 35px rgba(16, 185, 129, 0.5);
            color: white;
        }

        .btn-warning {
            background: linear-gradient(145deg, #f59e0b 0%, #d97706 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(245, 158, 11, 0.3);
            animation: pulse 2s infinite;
        }

        .btn-warning:hover {
            box-shadow: 0 15px 35px rgba(245, 158, 11, 0.5);
            color: white;
            animation-play-state: paused;
        }

        .btn-primary {
            background: linear-gradient(145deg, #2dd4bf 0%, #0891b2 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(45, 212, 191, 0.3);
        }

        .btn-primary:hover {
            box-shadow: 0 15px 35px rgba(45, 212, 191, 0.5);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(145deg, #64748b 0%, #475569 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(100, 116, 139, 0.3);
        }

        .btn-secondary:hover {
            box-shadow: 0 15px 35px rgba(100, 116, 139, 0.5);
            color: white;
        }

        .btn-info {
            background: linear-gradient(145deg, #06b6d4 0%, #0891b2 100%);
            color: white;
            box-shadow: 0 10px 25px rgba(6, 182, 212, 0.3);
        }

        .btn-info:hover {
            box-shadow: 0 15px 35px rgba(6, 182, 212, 0.5);
            color: white;
        }

        /* Badges */
        .badge {
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .badge-success {
            background: linear-gradient(145deg, #dcfce7 0%, #bbf7d0 100%);
            color: #166534;
            border: 2px solid #22c55e;
        }

        .badge-warning {
            background: linear-gradient(145deg, #fef3c7 0%, #fde68a 100%);
            color: #92400e;
            border: 2px solid #f59e0b;
            animation: pulse 2s infinite;
        }

        .badge-danger {
            background: linear-gradient(145deg, #fee2e2 0%, #fecaca 100%);
            color: #991b1b;
            border: 2px solid #ef4444;
            animation: bounce 2s infinite;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .items-header {
                flex-direction: column;
                text-align: center;
                gap: 2rem;
                padding: 2rem 1.5rem;
            }

            .items-header h1 {
                font-size: 2.5rem;
            }

            .search-form {
                flex-direction: column;
                gap: 1rem;
            }

            .items-table {
                font-size: 0.85rem;
            }

            .items-table th,
            .items-table td {
                padding: 1rem 0.75rem;
            }

            .action-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }

            .item-info {
                flex-direction: column;
                text-align: center;
                gap: 0.75rem;
            }

            .stat-box {
                padding: 1.5rem;
            }

            .stat-number {
                font-size: 2.5rem;
            }
        }

        /* Loading Animation for Table Rows */
        .items-table tbody tr {
            opacity: 0;
            animation: slideInRight 0.5s ease-out forwards;
        }

        .items-table tbody tr:nth-child(1) { animation-delay: 0.1s; }
        .items-table tbody tr:nth-child(2) { animation-delay: 0.2s; }
        .items-table tbody tr:nth-child(3) { animation-delay: 0.3s; }
        .items-table tbody tr:nth-child(4) { animation-delay: 0.4s; }
        .items-table tbody tr:nth-child(5) { animation-delay: 0.5s; }
        .items-table tbody tr:nth-child(n+6) { animation-delay: 0.6s; }
    </style>
</head>
<body>
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

    Boolean isLowStockView = (Boolean) request.getAttribute("isLowStockView");
    if (isLowStockView == null) isLowStockView = false;
%>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            Pahana Edu Management
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/dashboard" class="nav-link">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/customer" class="nav-link">Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/item" class="nav-link active">Items</a></li>
            <li><a href="${pageContext.request.contextPath}/bill" class="nav-link">Billing</a></li>
            <li><a href="${pageContext.request.contextPath}/jsp/help.jsp" class="nav-link">Help</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link logout">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- Page Header -->
    <div class="items-header">
        <div>
            <h1><i class="fas fa-cube"></i><%= isLowStockView ? "Low Stock Items" : "Item Management" %></h1>
            <p><%= isLowStockView ? "Items requiring immediate attention" : "Manage bookshop inventory and pricing" %></p>
        </div>
        <div class="header-actions">
            <% if (!isLowStockView) { %>
            <a href="${pageContext.request.contextPath}/item?action=add" class="btn btn-success btn-lg">
                <i class="fas fa-plus-circle"></i> Add New Item
            </a>
            <% } %>
            <% if (lowStockItems.size() > 0 && !isLowStockView) { %>
            <a href="${pageContext.request.contextPath}/item?action=lowStock" class="btn btn-warning btn-lg">
                <i class="fas fa-exclamation-triangle"></i> Low Stock (<%= lowStockItems.size() %>)
            </a>
            <% } %>
        </div>
    </div>

    <!-- Display Messages -->
        <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">
        <i class="icon-success">✓</i>
        <%= request.getParameter("success") %>
    </div>
        <% } %>

        <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-error">
        <i class="icon-error">✗</i>
        <%= request.getAttribute("errorMessage") %>
    </div>
        <% } %>

    <!-- Low Stock Alert -->
        <% if (lowStockItems.size() > 0 && !isLowStockView) { %>
    <div class="low-stock-alert">
        <span class="alert-icon"><i class="fas fa-exclamation-triangle"></i></span>
        <div>
            <strong>Low Stock Alert!</strong>
            <%= lowStockItems.size() %> item(s) are running low on stock and need restocking.
            <a href="${pageContext.request.contextPath}/item?action=lowStock"
               style="color: white; text-decoration: underline; margin-left: 1rem;">View Low Stock Items</a>
        </div>
    </div>
        <% } %>

    <!-- Search Container -->
        <% if (!isLowStockView) { %>
    <div class="search-container">
        <form class="search-form" method="get" action="${pageContext.request.contextPath}/item">
            <input type="hidden" name="action" value="list">
            <div class="search-group">
                <label for="searchName"><i class="fas fa-search"></i> Search by Name</label>
                <input type="text" id="searchName" name="searchName" class="search-input"
                       placeholder="Enter item name..."
                       value="<%= request.getParameter("searchName") != null ? request.getParameter("searchName") : "" %>">
            </div>
            <div class="search-group">
                <label for="searchId"><i class="fas fa-barcode"></i> Search by ID</label>
                <input type="text" id="searchId" name="searchId" class="search-input"
                       placeholder="Enter item ID..."
                       value="<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>">
            </div>
            <div>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Search
                </button>
                <a href="${pageContext.request.contextPath}/item?action=list" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Clear
                </a>
            </div>
        </form>
    </div>
        <% } %>

    <!-- Item Statistics -->
    <div class="items-stats">
        <div class="stat-box">
            <h2 class="stat-number"><%= items.size() %></h2>
            <p class="stat-label"><%= isLowStockView ? "Low Stock Items" : "Total Items" %></p>
        </div>
        <div class="stat-box inventory">
            <h2 class="stat-number">
                <%
                    int totalStock = 0;
                    for (Item item : items) {
                        totalStock += item.getStock();
                    }
                %>
                <%= totalStock %>
            </h2>
            <p class="stat-label">Total Stock Units</p>
        </div>
        <div class="stat-box low-stock">
            <h2 class="stat-number"><%= lowStockItems.size() %></h2>
            <p class="stat-label">Low Stock Items</p>
        </div>
        <div class="stat-box total-value">
            <h2 class="stat-number">
                <%
                    double totalValue = 0;
                    for (Item item : items) {
                        totalValue += item.getPrice().doubleValue() * item.getStock();
                    }
                %>
                <%= String.format("%.0f", totalValue) %>
            </h2>
            <p class="stat-label">Total Value (LKR)</p>
        </div>
    </div>

    <!-- Items Table -->
    <div class="table-container">
        <div class="table-header">
            <h3 class="table-title">
                <i class="fas fa-table"></i>
                <%= isLowStockView ? "Low Stock Items" : "Item Inventory" %>
            </h3>
            <div class="table-filters">
                <% if (!isLowStockView) { %>
                <select class="filter-select" onchange="filterTable(this.value)">
                    <option value="all">All Items</option>
                    <option value="in-stock">In Stock (> 0)</option>
                    <option value="low-stock">Low Stock (< 10)</option>
                    <option value="out-of-stock">Out of Stock (0)</option>
                    <option value="high-value">High Value (> LKR 1000)</option>
                </select>
                <% } %>
                <button onclick="exportToCSV()" class="btn btn-info btn-sm">
                    <i class="fas fa-file-csv"></i> Export CSV
                </button>
            </div>
        </div>

        <% if (items.size() > 0) { %>
        <table class="items-table" id="itemsTable">
            <thead>
            <tr>
                <th><i class="fas fa-info-circle"></i> Item</th>
                <th><i class="fas fa-barcode"></i> Item ID</th>
                <th><i class="fas fa-money-bill-wave"></i> Price (LKR)</th>
                <th><i class="fas fa-boxes"></i> Stock</th>
                <th><i class="fas fa-calculator"></i> Value (LKR)</th>
                <th><i class="fas fa-signal"></i> Status</th>
                <th><i class="fas fa-cogs"></i> Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Item item : items) { %>
            <tr data-stock="<%= item.getStock() %>" data-price="<%= item.getPrice().doubleValue() %>">
                <td>
                    <div class="item-info">
                        <div class="item-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="item-details">
                            <h4><%= item.getItemName() %></h4>
                            <p><i class="fas fa-graduation-cap"></i> Book/Educational Material</p>
                        </div>
                    </div>
                </td>
                <td>
                    <strong><i class="fas fa-tag"></i> <%= item.getItemId() %></strong>
                </td>
                <td>
                    <div class="price-display">
                        <%= String.format("%.2f", item.getPrice()) %>
                    </div>
                </td>
                <td>
                <span class="stock-badge <%=
                    item.getStock() == 0 ? "stock-out" :
                    item.getStock() < 10 ? "stock-low" :
                    item.getStock() < 50 ? "stock-medium" : "stock-high" %>">
                    <i class="fas fa-cube"></i> <%= item.getStock() %> units
                </span>
                </td>
                <td>
                    <strong><i class="fas fa-coins"></i> <%= String.format("%.2f", item.getPrice().doubleValue() * item.getStock()) %></strong>
                </td>
                <td>
                    <% if (item.getStock() == 0) { %>
                    <span class="badge badge-danger">
                    <i class="fas fa-times-circle"></i> Out of Stock
                </span>
                    <% } else if (item.getStock() < 10) { %>
                    <span class="badge badge-warning">
                    <i class="fas fa-exclamation-triangle"></i> Low Stock
                </span>
                    <% } else { %>
                    <span class="badge badge-success">
                    <i class="fas fa-check-circle"></i> In Stock
                </span>
                    <% } %>
                </td>
                <td>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/item?action=view&itemId=<%= item.getItemId() %>"
                           class="btn-action btn-view" title="View Details">
                            <i class="fas fa-eye"></i> View
                        </a>
                        <a href="${pageContext.request.contextPath}/item?action=edit&itemId=<%= item.getItemId() %>"
                           class="btn-action btn-edit" title="Edit Item">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="${pageContext.request.contextPath}/item?action=delete&itemId=<%= item.getItemId() %>"
                           class="btn-action btn-delete" title="Delete Item"
                           onclick="return confirm('Are you sure you want to delete this item? This action cannot be undone.')">
                            <i class="fas fa-trash-alt"></i> Delete
                        </a>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div class="pagination">
            <div class="page-info">
                <i class="fas fa-info-circle"></i> Showing <%= items.size() %> item(s)
                <% if (isLowStockView) { %>
                • <a href="${pageContext.request.contextPath}/item?action=list">
                <i class="fas fa-list"></i> View All Items
            </a>
                <% } %>
            </div>
        </div>
        <% } else { %>
        <div class="empty-state">
            <div class="empty-state-icon">
                <i class="fas fa-cube"></i>
            </div>
            <h3><%= isLowStockView ? "No Low Stock Items" : "No Items Found" %></h3>
            <p>
                <% if (isLowStockView) { %>
                <i class="fas fa-thumbs-up"></i> Excellent! All items are well stocked.
                <% } else { %>
                <i class="fas fa-rocket"></i> You haven't added any items yet. Start building your inventory!
                <% } %>
            </p>
            <% if (!isLowStockView) { %>
            <a href="${pageContext.request.contextPath}/item?action=add" class="btn btn-primary btn-lg">
                <i class="fas fa-plus-circle"></i> Add Your First Item
            </a>
            <% } else { %>
            <a href="${pageContext.request.contextPath}/item?action=list" class="btn btn-primary btn-lg">
                <i class="fas fa-list"></i> View All Items
            </a>
            <% } %>
        </div>
        <% } %>
    </div>
</div>

<script>
    // Enhanced filter table functionality with smooth animations
    function filterTable(filter) {
        const table = document.getElementById('itemsTable');
        if (!table) return;

        const tbody = table.getElementsByTagName('tbody')[0];
        const rows = tbody.getElementsByTagName('tr');
        let visibleCount = 0;
        const animationDuration = 300;

        // Add loading overlay
        showFilterLoading(true);

        // First, fade out all rows
        Array.from(rows).forEach((row, index) => {
            row.style.transition = 'all 0.3s ease-out';
            row.style.opacity = '0';
            row.style.transform = 'translateY(-20px)';
        });

        setTimeout(() => {
            Array.from(rows).forEach((row, index) => {
                const stock = parseInt(row.getAttribute('data-stock'));
                const price = parseFloat(row.getAttribute('data-price'));
                let show = true;

                switch(filter) {
                    case 'in-stock':
                        show = stock > 0;
                        break;
                    case 'low-stock':
                        show = stock < 10 && stock > 0;
                        break;
                    case 'out-of-stock':
                        show = stock === 0;
                        break;
                    case 'high-value':
                        show = price > 1000;
                        break;
                    case 'all':
                    default:
                        show = true;
                        break;
                }

                if (show) {
                    row.style.display = '';

                    // Animate in with delay
                    setTimeout(() => {
                        row.style.opacity = '1';
                        row.style.transform = 'translateY(0)';
                        row.style.animation = `slideInFromBottom 0.5s ease-out ${visibleCount * 0.1}s both`;
                    }, visibleCount * 50);

                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            // Remove loading overlay
            setTimeout(() => {
                showFilterLoading(false);
                showFilterNotification(visibleCount, filter);
            }, 500);

        }, animationDuration);

        // Animate filter select
        const filterSelect = document.querySelector('.filter-select');
        if (filterSelect) {
            filterSelect.style.animation = 'pulse 0.5s ease-out';
            filterSelect.style.borderColor = '#2dd4bf';

            setTimeout(() => {
                filterSelect.style.animation = '';
                filterSelect.style.borderColor = '';
            }, 500);
        }
    }

    // Show/hide filter loading overlay
    function showFilterLoading(show) {
        let overlay = document.querySelector('.filter-loading-overlay');

        if (show && !overlay) {
            overlay = document.createElement('div');
            overlay.className = 'filter-loading-overlay';
            overlay.style.cssText = `
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(45, 212, 191, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 100;
                animation: fadeIn 0.3s ease-out;
                backdrop-filter: blur(2px);
            `;

            overlay.innerHTML = `
                <div style="
                    background: linear-gradient(145deg, #2dd4bf 0%, #0891b2 100%);
                    color: white;
                    padding: 15px 25px;
                    border-radius: 15px;
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    box-shadow: 0 10px 25px rgba(45, 212, 191, 0.3);
                ">
                    <i class="fas fa-spinner fa-spin"></i>
                    Filtering items...
                </div>
            `;

            document.querySelector('.table-container').style.position = 'relative';
            document.querySelector('.table-container').appendChild(overlay);
        } else if (!show && overlay) {
            overlay.style.animation = 'fadeOut 0.3s ease-out';
            setTimeout(() => {
                if (overlay.parentNode) {
                    overlay.parentNode.removeChild(overlay);
                }
            }, 300);
        }
    }

    // Show filter notification with enhanced styling
    function showFilterNotification(count, filter) {
        const notification = document.createElement('div');
        notification.className = 'filter-notification';
        notification.style.cssText = `
            position: fixed;
            top: 120px;
            right: 20px;
            background: linear-gradient(145deg, #2dd4bf 0%, #0891b2 100%);
            color: white;
            padding: 18px 28px;
            border-radius: 20px;
            font-weight: 600;
            z-index: 9999;
            animation: slideInRightBounce 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            box-shadow: 0 15px 35px rgba(45, 212, 191, 0.4);
            max-width: 350px;
            min-width: 250px;
            border: 2px solid rgba(255, 255, 255, 0.2);
        `;

        const filterNames = {
            'all': 'All Items',
            'in-stock': 'In Stock Items',
            'low-stock': 'Low Stock Items',
            'out-of-stock': 'Out of Stock Items',
            'high-value': 'High Value Items'
        };

        const filterIcons = {
            'all': 'fas fa-list',
            'in-stock': 'fas fa-check-circle',
            'low-stock': 'fas fa-exclamation-triangle',
            'out-of-stock': 'fas fa-times-circle',
            'high-value': 'fas fa-gem'
        };

        notification.innerHTML = `
            <div style="display: flex; align-items: center; gap: 12px;">
                <i class="${filterIcons[filter] || 'fas fa-filter'}" style="font-size: 1.2em;"></i>
                <div>
                    <div style="font-size: 14px; font-weight: 700;">
                        ${filterNames[filter] || 'Filtered'}
                    </div>
                    <div style="font-size: 12px; opacity: 0.9; margin-top: 2px;">
                        ${count} item${count != 1 ? 's' : ''} found
                    </div>
                </div>
            </div>
        `;

        document.body.appendChild(notification);

        // Auto-remove after 4 seconds
        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.5s ease-out';
            setTimeout(() => {
                if (document.body.contains(notification)) {
                    document.body.removeChild(notification);
                }
            }, 500);
        }, 4000);
    }

    // Enhanced export to CSV functionality
    function exportToCSV() {
        const table = document.getElementById('itemsTable');
        if (!table) {
            showNotification('No table data to export', 'error');
            return;
        }

        const rows = table.getElementsByTagName('tr');
        let csv = [];

        // Show loading animation
        const exportBtn = document.querySelector('button[onclick="exportToCSV()"]');
        if (!exportBtn) return;

        const originalContent = exportBtn.innerHTML;
        exportBtn.innerHTML = `
            <i class="fas fa-spinner fa-spin"></i>
            <span style="margin-left: 5px;">Exporting...</span>
        `;
        exportBtn.disabled = true;
        exportBtn.style.animation = 'pulse 1.5s infinite';
        exportBtn.style.transform = 'scale(0.95)';

        // Simulate processing time for better UX
        setTimeout(() => {
            try {
                // Add header with metadata
                csv.push('"Pahana Edu Management System - Items Export"');
                csv.push("Export Date: " + new Date().toLocaleString());
                csv.push('""'); // Empty row

                let hasVisibleRows = false;

                for (let i = 0; i < rows.length; i++) {
                    const row = rows[i];
                    if (row.style.display !== 'none') {
                        const cols = row.getElementsByTagName(i === 0 ? 'th' : 'td');
                        let csvRow = [];

                        for (let j = 0; j < cols.length - 1; j++) { // Exclude actions column
                            let cellText = cols[j].innerText || cols[j].textContent || '';

                            // Clean up text
                            cellText = cellText
                                .replace(/[\r\n]+/g, ' ')
                                .replace(/\s+/g, ' ')
                                .replace(/"/g, '""')
                                .replace(/[^\w\s.,()-]/g, '')
                                .trim();

                            csvRow.push(`"${cellText}"`);
                        }

                        if (csvRow.length > 0) {
                            csv.push(csvRow.join(','));
                            if (i > 0) hasVisibleRows = true; // Don't count header
                        }
                    }
                }

                if (!hasVisibleRows) {
                    throw new Error('No visible items to export');
                }

                // Create and download file
                const csvContent = csv.join('\n');
                const BOM = '\uFEFF'; // UTF-8 BOM for Excel compatibility
                const blob = new Blob([BOM + csvContent], {
                    type: 'text/csv;charset=utf-8;'
                });

                const url = window.URL.createObjectURL(blob);
                const link = document.createElement('a');
                link.href = url;
                link.download = 'pahana_edu_items_' + new Date().toISOString().split('T')[0] + '_' + Date.now() + '.csv';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                window.URL.revokeObjectURL(url);

                showNotification('CSV file exported successfully! 📊', 'success');

            } catch (error) {
                console.error('Export error:', error);
                showNotification(`Export failed: ${error.message}`, 'error');
            } finally {
                // Reset button with delay for better UX
                setTimeout(() => {
                    exportBtn.innerHTML = originalContent;
                    exportBtn.disabled = false;
                    exportBtn.style.animation = '';
                    exportBtn.style.transform = '';
                }, 800);
            }
        }, 1200);
    }

    // Universal notification system
    function showNotification(message, type = 'info', duration = 4000) {
        const notification = document.createElement('div');

        const typeStyles = {
            success: {
                bg: 'linear-gradient(145deg, #10b981 0%, #059669 100%)',
                icon: 'fas fa-check-circle',
                shadow: 'rgba(16, 185, 129, 0.4)'
            },
            error: {
                bg: 'linear-gradient(145deg, #ef4444 0%, #dc2626 100%)',
                icon: 'fas fa-exclamation-circle',
                shadow: 'rgba(239, 68, 68, 0.4)'
            },
            warning: {
                bg: 'linear-gradient(145deg, #f59e0b 0%, #d97706 100%)',
                icon: 'fas fa-exclamation-triangle',
                shadow: 'rgba(245, 158, 11, 0.4)'
            },
            info: {
                bg: 'linear-gradient(145deg, #2dd4bf 0%, #0891b2 100%)',
                icon: 'fas fa-info-circle',
                shadow: 'rgba(45, 212, 191, 0.4)'
            }
        };

        const style = typeStyles[type] || typeStyles.info;

        notification.style.cssText = `
            position: fixed;
            top: 120px;
            right: 20px;
            background: ${style.bg};
            color: white;
            padding: 18px 25px;
            border-radius: 18px;
            font-weight: 600;
            font-size: 14px;
            z-index: 10000;
            animation: slideInRightBounce 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            box-shadow: 0 15px 35px ${style.shadow};
            max-width: 350px;
            min-width: 200px;
            border: 2px solid rgba(255, 255, 255, 0.2);
        `;

        notification.innerHTML = `
            <div style="display: flex; align-items: center; gap: 12px;">
                <i class="${style.icon}" style="font-size: 1.1em; flex-shrink: 0;"></i>
                <span style="line-height: 1.4;">${message}</span>
            </div>
        `;

        document.body.appendChild(notification);

        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.5s ease-out';
            setTimeout(() => {
                if (document.body.contains(notification)) {
                    document.body.removeChild(notification);
                }
            }, 500);
        }, duration);
    }

    // Enhanced search functionality
    function enhanceSearchFunctionality() {
        const searchInputs = document.querySelectorAll('.search-input');

        searchInputs.forEach(input => {
            let searchTimeout;

            input.addEventListener('focus', function() {
                this.style.transform = 'scale(1.02)';
                this.style.boxShadow = '0 0 25px rgba(45, 212, 191, 0.3)';
                this.parentElement.style.animation = 'glow 0.8s ease-out';
            });

            input.addEventListener('blur', function() {
                this.style.transform = 'scale(1)';
                this.style.boxShadow = '';
                this.parentElement.style.animation = '';
            });

            // Real-time search feedback
            input.addEventListener('input', function() {
                clearTimeout(searchTimeout);

                if (this.value.length > 2) {
                    this.style.borderColor = '#2dd4bf';
                    this.style.background = 'linear-gradient(145deg, #ffffff 0%, #f0fdfa 100%)';

                    // Add search suggestions (simulated)
                    searchTimeout = setTimeout(() => {
                        addSearchSuggestions(this);
                    }, 500);
                } else {
                    this.style.borderColor = '#e2e8f0';
                    this.style.background = 'linear-gradient(145deg, #ffffff 0%, #f8fafc 100%)';
                    removeSearchSuggestions();
                }
            });
        });
    }

    // Add search suggestions (placeholder for future enhancement)
    function addSearchSuggestions(input) {
        removeSearchSuggestions();

        const suggestions = document.createElement('div');
        suggestions.className = 'search-suggestions';
        suggestions.style.cssText = `
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 2px solid #2dd4bf;
            border-top: none;
            border-radius: 0 0 15px 15px;
            box-shadow: 0 10px 25px rgba(45, 212, 191, 0.2);
            z-index: 1000;
            font-size: 12px;
            color: #64748b;
            padding: 10px;
            animation: slideInDown 0.3s ease-out;
        `;

        suggestions.innerHTML = `
            <i class="fas fa-lightbulb"></i>
            Tip: Use specific item names or IDs for better results
        `;

        input.parentElement.style.position = 'relative';
        input.parentElement.appendChild(suggestions);

        setTimeout(removeSearchSuggestions, 3000);
    }

    // Remove search suggestions
    function removeSearchSuggestions() {
        const suggestions = document.querySelector('.search-suggestions');
        if (suggestions) {
            suggestions.style.animation = 'slideOutUp 0.3s ease-out';
            setTimeout(() => {
                if (suggestions.parentNode) {
                    suggestions.parentNode.removeChild(suggestions);
                }
            }, 300);
        }
    }

    // Add table interaction enhancements
    function enhanceTableInteractions() {
        const tableRows = document.querySelectorAll('.items-table tbody tr');

        tableRows.forEach((row, index) => {
            // Add hover effects
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.01)';
                this.style.zIndex = '10';
                this.style.boxShadow = '0 8px 25px rgba(45, 212, 191, 0.15)';
                this.style.borderRadius = '10px';
            });

            row.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
                this.style.zIndex = '1';
                this.style.boxShadow = 'none';
                this.style.borderRadius = '0';
            });

            // Add click-to-highlight effect
            row.addEventListener('click', function() {
                // Remove previous highlights
                document.querySelectorAll('.items-table tbody tr').forEach(r => {
                    r.classList.remove('row-highlighted');
                });

                // Add highlight to current row
                this.classList.add('row-highlighted');
                this.style.animation = 'highlightPulse 0.6s ease-out';

                setTimeout(() => {
                    this.style.animation = '';
                }, 600);
            });

            // Set initial animation delay
            row.style.animationDelay = `${index * 0.1}s`;
        });
    }

    // Add keyboard shortcuts
    function addKeyboardShortcuts() {
        let shortcutsEnabled = true;

        document.addEventListener('keydown', function(e) {
            // Disable shortcuts when typing in inputs
            if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA' || e.target.tagName === 'SELECT') {
                return;
            }

            if (!shortcutsEnabled) return;

            switch(e.key.toLowerCase()) {
                case 'n':
                    if (e.ctrlKey || e.metaKey) {
                        e.preventDefault();
                        const addButton = document.querySelector('a[href*="action=add"]');
                        if (addButton) {
                            addButton.style.animation = 'pulse 0.3s ease-out';
                            addButton.click();
                        }
                    }
                    break;

                case 'f':
                    if (e.ctrlKey || e.metaKey) {
                        e.preventDefault();
                        const searchInput = document.querySelector('#searchName');
                        if (searchInput) {
                            searchInput.focus();
                            searchInput.select();
                            searchInput.style.animation = 'glow 0.5s ease-out';
                        }
                    }
                    break;

                case 'e':
                    if (e.ctrlKey || e.metaKey) {
                        e.preventDefault();
                        exportToCSV();
                    }
                    break;

                case 'r':
                    if (!e.ctrlKey && !e.metaKey) {
                        e.preventDefault();
                        refreshPage();
                    }
                    break;

                case 'escape':
                    // Clear all filters
                    const filterSelect = document.querySelector('.filter-select');
                    if (filterSelect) {
                        filterSelect.value = 'all';
                        filterTable('all');
                    }
                    break;
            }
        });
    }

    // Refresh page with smooth transition
    function refreshPage() {
        const refreshOverlay = document.createElement('div');
        refreshOverlay.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(145deg, rgba(45, 212, 191, 0.1) 0%, rgba(8, 145, 178, 0.1) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            animation: fadeIn 0.5s ease-out;
            backdrop-filter: blur(3px);
        `;

        refreshOverlay.innerHTML = `
            <div style="
                background: linear-gradient(145deg, #2dd4bf 0%, #0891b2 100%);
                color: white;
                padding: 25px 40px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 16px;
                display: flex;
                align-items: center;
                gap: 15px;
                box-shadow: 0 20px 40px rgba(45, 212, 191, 0.4);
                animation: scaleInBounce 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            ">
                <i class="fas fa-sync fa-spin" style="font-size: 1.2em;"></i>
                Refreshing page...
            </div>
        `;

        document.body.appendChild(refreshOverlay);
        document.body.style.transition = 'opacity 0.3s ease';
        document.body.style.opacity = '0.8';

        setTimeout(() => {
            window.location.reload();
        }, 1000);
    }

    // Stats counter animation
    function animateStats() {
        const statNumbers = document.querySelectorAll('.stat-number');

        statNumbers.forEach((stat, index) => {
            const finalValue = parseFloat(stat.textContent.replace(/[^\d.]/g, '')) || 0;
            let currentValue = 0;
            const duration = 2000;
            const startTime = Date.now();

            setTimeout(() => {
                function updateCounter() {
                    const elapsed = Date.now() - startTime;
                    const progress = Math.min(elapsed / duration, 1);

                    // Easing function for smooth animation
                    const easeOutCubic = 1 - Math.pow(1 - progress, 3);
                    currentValue = finalValue * easeOutCubic;

                    // Update display
                    if (stat.textContent.includes('.')) {
                        stat.textContent = currentValue.toFixed(2);
                    } else {
                        stat.textContent = Math.floor(currentValue);
                    }

                    if (progress < 1) {
                        requestAnimationFrame(updateCounter);
                    } else {
                        stat.style.animation = 'bounceIn 0.5s ease-out';
                    }
                }

                requestAnimationFrame(updateCounter);
            }, index * 300);
        });
    }

    // Enhanced action button interactions
    function enhanceActionButtons() {
        const actionButtons = document.querySelectorAll('.btn-action');

        actionButtons.forEach(btn => {
            btn.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-3px) scale(1.05)';
            });

            btn.addEventListener('mouseleave', function() {
                this.style.transform = '';
            });

            btn.addEventListener('click', function(e) {
                if (this.classList.contains('btn-delete')) {
                    // Enhanced delete confirmation
                    this.style.animation = 'shake 0.5s ease-out';
                    return;
                }

                // Add loading state
                const originalContent = this.innerHTML;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                this.style.pointerEvents = 'none';
                this.style.opacity = '0.8';
            });
        });
    }

    // Initialize all enhancements
    document.addEventListener('DOMContentLoaded', function() {
        // Add custom CSS animations
        const customStyles = document.createElement('style');
        customStyles.textContent = `
            @keyframes slideInFromBottom {
                from {
                    transform: translateY(30px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            @keyframes slideInRightBounce {
                0% {
                    transform: translateX(100%);
                    opacity: 0;
                }
                60% {
                    transform: translateX(-10px);
                    opacity: 1;
                }
                100% {
                    transform: translateX(0);
                }
            }

            @keyframes slideInDown {
                from {
                    transform: translateY(-20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            @keyframes slideOutUp {
                from {
                    transform: translateY(0);
                    opacity: 1;
                }
                to {
                    transform: translateY(-20px);
                    opacity: 0;
                }
            }

            @keyframes slideOutRight {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(100%);
                    opacity: 0;
                }
            }

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            @keyframes fadeOut {
                from { opacity: 1; }
                to { opacity: 0; }
            }

            @keyframes scaleInBounce {
                0% {
                    transform: translate(-50%, -50%) scale(0.3);
                    opacity: 0;
                }
                50% {
                    transform: translate(-50%, -50%) scale(1.05);
                }
                70% {
                    transform: translate(-50%, -50%) scale(0.9);
                }
                100% {
                    transform: translate(-50%, -50%) scale(1);
                    opacity: 1;
                }
            }

            @keyframes highlightPulse {
                0%, 100% {
                    background: rgba(45, 212, 191, 0.1);
                }
                50% {
                    background: rgba(45, 212, 191, 0.2);
                }
            }

            @keyframes bounceIn {
                0%, 20%, 40%, 60%, 80% {
                    transform: scale(1);
                }
                10%, 30%, 50%, 70%, 90% {
                    transform: scale(1.1);
                }
            }

            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                10%, 30%, 50%, 70%, 90% { transform: translateX(-2px); }
                20%, 40%, 60%, 80% { transform: translateX(2px); }
            }

            .row-highlighted {
                background: linear-gradient(145deg, rgba(45, 212, 191, 0.1) 0%, rgba(8, 145, 178, 0.1) 100%) !important;
                border-left: 4px solid #2dd4bf !important;
            }

            .btn-action:active {
                transform: scale(0.95) !important;
            }
        `;
        document.head.appendChild(customStyles);

        // Initialize all features
        enhanceSearchFunctionality();
        enhanceTableInteractions();
        addKeyboardShortcuts();
        enhanceActionButtons();

        // Start stats animation after a delay
        setTimeout(animateStats, 1000);

        // Show keyboard shortcuts hint on first visit
        if (!localStorage.getItem('itemsShortcutsShown')) {
            setTimeout(showKeyboardShortcuts, 2000);
        }

        console.log('🚀 Enhanced item management system fully initialized!');
    });

    // Show keyboard shortcuts guide
    function showKeyboardShortcuts() {
        const shortcutsModal = document.createElement('div');
        shortcutsModal.style.cssText = `
            position: fixed;
            bottom: 20px;
            left: 20px;
            background: linear-gradient(145deg, #1e293b 0%, #334155 100%);
            color: white;
            padding: 20px 25px;
            border-radius: 20px;
            font-size: 13px;
            z-index: 9999;
            animation: slideInLeftBounce 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            box-shadow: 0 15px 35px rgba(30, 41, 59, 0.4);
            max-width: 320px;
            cursor: pointer;
            border: 2px solid rgba(45, 212, 191, 0.3);
        `;

        shortcutsModal.innerHTML = `
            <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 15px;">
                <i class="fas fa-keyboard" style="color: #2dd4bf; font-size: 1.2em;"></i>
                <span style="font-weight: 700; font-size: 14px;">Keyboard Shortcuts</span>
            </div>
            <div style="line-height: 1.6; font-size: 12px;">
                <div><code style="background: rgba(45,212,191,0.2); padding: 2px 6px; border-radius: 4px;">Ctrl+N</code> Add new item</div>
                <div><code style="background: rgba(45,212,191,0.2); padding: 2px 6px; border-radius: 4px;">Ctrl+F</code> Focus search</div>
                <div><code style="background: rgba(45,212,191,0.2); padding: 2px 6px; border-radius: 4px;">Ctrl+E</code> Export CSV</div>
                <div><code style="background: rgba(45,212,191,0.2); padding: 2px 6px; border-radius: 4px;">R</code> Refresh page</div>
                <div><code style="background: rgba(45,212,191,0.2); padding: 2px 6px; border-radius: 4px;">ESC</code> Clear filters</div>
            </div>
            <div style="margin-top: 15px; padding-top: 12px; border-top: 1px solid rgba(45,212,191,0.3); font-size: 11px; opacity: 0.8; text-align: center;">
                Click to dismiss
            </div>
        `;

        shortcutsModal.onclick = function() {
            this.style.animation = 'slideOutLeftBounce 0.5s ease-out';
            setTimeout(() => {
                if (document.body.contains(this)) {
                    document.body.removeChild(this);
                }
            }, 500);
            localStorage.setItem('itemsShortcutsShown', 'true');
        };

        document.body.appendChild(shortcutsModal);

        // Auto-hide after 8 seconds
        setTimeout(() => {
            if (document.body.contains(shortcutsModal)) {
                shortcutsModal.style.animation = 'slideOutLeftBounce 0.5s ease-out';
                setTimeout(() => {
                    if (document.body.contains(shortcutsModal)) {
                        document.body.removeChild(shortcutsModal);
                    }
                }, 500);
            }
            localStorage.setItem('itemsShortcutsShown', 'true');
        }, 8000);
    }

    // Add slideInLeftBounce animation to the existing styles
    const additionalStyles = document.createElement('style');
    additionalStyles.textContent = `
        @keyframes slideInLeftBounce {
            0% {
                transform: translateX(-100%);
                opacity: 0;
            }
            60% {
                transform: translateX(10px);
                opacity: 1;
            }
            100% {
                transform: translateX(0);
            }
        }

        @keyframes slideOutLeftBounce {
            0% {
                transform: translateX(0);
                opacity: 1;
            }
            100% {
                transform: translateX(-100%);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(additionalStyles);

    // Advanced table sorting functionality
    function addTableSorting() {
        const headers = document.querySelectorAll('.items-table th');
        let currentSort = { column: null, direction: 'asc' };

        headers.forEach((header, index) => {
            // Skip actions column
            if (index === headers.length - 1) return;

            header.style.cursor = 'pointer';
            header.style.position = 'relative';
            header.style.userSelect = 'none';

            // Add sort indicator
            const sortIndicator = document.createElement('span');
            sortIndicator.className = 'sort-indicator';
            sortIndicator.style.cssText = `
                position: absolute;
                right: 8px;
                top: 50%;
                transform: translateY(-50%);
                opacity: 0.5;
                font-size: 0.8em;
                transition: all 0.3s ease;
            `;
            sortIndicator.innerHTML = '<i class="fas fa-sort"></i>';
            header.appendChild(sortIndicator);

            header.addEventListener('click', () => sortTable(index));
            header.addEventListener('mouseenter', function() {
                this.style.backgroundColor = 'rgba(45, 212, 191, 0.1)';
                sortIndicator.style.opacity = '0.8';
            });

            header.addEventListener('mouseleave', function() {
                this.style.backgroundColor = '';
                if (currentSort.column !== index) {
                    sortIndicator.style.opacity = '0.5';
                }
            });
        });

        function sortTable(columnIndex) {
            const table = document.getElementById('itemsTable');
            const tbody = table.getElementsByTagName('tbody')[0];
            const rows = Array.from(tbody.getElementsByTagName('tr'));

            // Determine sort direction
            if (currentSort.column === columnIndex) {
                currentSort.direction = currentSort.direction === 'asc' ? 'desc' : 'asc';
            } else {
                currentSort.direction = 'asc';
            }
            currentSort.column = columnIndex;

            // Update sort indicators
            headers.forEach((header, index) => {
                const indicator = header.querySelector('.sort-indicator');
                if (indicator) {
                    if (index === columnIndex) {
                        indicator.innerHTML = currentSort.direction === 'asc'
                            ? '<i class="fas fa-sort-up"></i>'
                            : '<i class="fas fa-sort-down"></i>';
                        indicator.style.opacity = '1';
                        indicator.style.color = '#2dd4bf';
                    } else {
                        indicator.innerHTML = '<i class="fas fa-sort"></i>';
                        indicator.style.opacity = '0.5';
                        indicator.style.color = '';
                    }
                }
            });

            // Sort rows
            rows.sort((a, b) => {
                const cellA = a.getElementsByTagName('td')[columnIndex];
                const cellB = b.getElementsByTagName('td')[columnIndex];

                let valueA = cellA.textContent.trim();
                let valueB = cellB.textContent.trim();

                // Handle numeric columns
                if (columnIndex === 2 || columnIndex === 3 || columnIndex === 4) { // Price, Stock, Value
                    valueA = parseFloat(valueA.replace(/[^\d.-]/g, '')) || 0;
                    valueB = parseFloat(valueB.replace(/[^\d.-]/g, '')) || 0;
                }

                let comparison = 0;
                if (valueA > valueB) comparison = 1;
                if (valueA < valueB) comparison = -1;

                return currentSort.direction === 'desc' ? comparison * -1 : comparison;
            });

            // Add sorting animation
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(20px)';
                tbody.appendChild(row);

                setTimeout(() => {
                    row.style.transition = 'all 0.4s ease-out';
                    row.style.opacity = '1';
                    row.style.transform = 'translateY(0)';
                }, index * 50);
            });

            // Show sort notification
            showNotification('Sorted by ' + headers[columnIndex].textContent.replace(/[^\w\s]/g, '').trim() + ' (' + currentSort.direction + ')', 'info', 2000);

        }
    }

    // Advanced search with filters
    function addAdvancedSearch() {
        const searchContainer = document.querySelector('.search-container');
        if (!searchContainer) return;

        // Add advanced search toggle
        const advancedToggle = document.createElement('button');
        advancedToggle.type = 'button';
        advancedToggle.className = 'btn btn-info btn-sm';
        advancedToggle.style.cssText = `
            margin-left: 10px;
            transition: all 0.3s ease;
        `;
        advancedToggle.innerHTML = '<i class="fas fa-sliders-h"></i> Advanced';

        const searchForm = searchContainer.querySelector('.search-form');
        const lastDiv = searchForm.querySelector('div:last-child');
        lastDiv.appendChild(advancedToggle);

        // Create advanced options panel
        const advancedPanel = document.createElement('div');
        advancedPanel.className = 'advanced-search-panel';
        advancedPanel.style.cssText = `
            margin-top: 20px;
            padding: 20px;
            background: linear-gradient(145deg, #f8fafc 0%, #e2e8f0 100%);
            border-radius: 15px;
            border: 2px solid #2dd4bf;
            display: none;
            animation-fill-mode: both;
        `;

        advancedPanel.innerHTML = `
            <h4 style="margin: 0 0 15px 0; color: #1e293b; font-size: 1.1rem;">
                <i class="fas fa-filter"></i> Advanced Search Options
            </h4>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;">
                <div>
                    <label style="display: block; margin-bottom: 5px; font-weight: 600; color: #334155;">Price Range</label>
                    <div style="display: flex; gap: 10px; align-items: center;">
                        <input type="number" placeholder="Min" id="priceMin" style="width: 80px; padding: 5px; border: 1px solid #cbd5e1; border-radius: 5px;">
                        <span style="color: #64748b;">to</span>
                        <input type="number" placeholder="Max" id="priceMax" style="width: 80px; padding: 5px; border: 1px solid #cbd5e1; border-radius: 5px;">
                    </div>
                </div>
                <div>
                    <label style="display: block; margin-bottom: 5px; font-weight: 600; color: #334155;">Stock Range</label>
                    <div style="display: flex; gap: 10px; align-items: center;">
                        <input type="number" placeholder="Min" id="stockMin" style="width: 80px; padding: 5px; border: 1px solid #cbd5e1; border-radius: 5px;">
                        <span style="color: #64748b;">to</span>
                        <input type="number" placeholder="Max" id="stockMax" style="width: 80px; padding: 5px; border: 1px solid #cbd5e1; border-radius: 5px;">
                    </div>
                </div>
                <div>
                    <label style="display: block; margin-bottom: 5px; font-weight: 600; color: #334155;">Status</label>
                    <select id="statusFilter" style="width: 100%; padding: 5px; border: 1px solid #cbd5e1; border-radius: 5px;">
                        <option value="">All Statuses</option>
                        <option value="in-stock">In Stock</option>
                        <option value="low-stock">Low Stock</option>
                        <option value="out-of-stock">Out of Stock</option>
                    </select>
                </div>
            </div>
            <div style="margin-top: 15px; display: flex; gap: 10px; justify-content: center;">
                <button type="button" onclick="applyAdvancedSearch()" class="btn btn-primary btn-sm">
                    <i class="fas fa-search"></i> Apply Filters
                </button>
                <button type="button" onclick="clearAdvancedSearch()" class="btn btn-secondary btn-sm">
                    <i class="fas fa-times"></i> Clear
                </button>
            </div>
        `;

        searchContainer.appendChild(advancedPanel);

        // Toggle advanced panel
        let advancedVisible = false;
        advancedToggle.addEventListener('click', function() {
            advancedVisible = !advancedVisible;

            if (advancedVisible) {
                advancedPanel.style.display = 'block';
                advancedPanel.style.animation = 'slideInDown 0.4s ease-out';
                this.innerHTML = '<i class="fas fa-chevron-up"></i> Hide Advanced';
                this.style.backgroundColor = '#ef4444';
            } else {
                advancedPanel.style.animation = 'slideOutUp 0.4s ease-out';
                this.innerHTML = '<i class="fas fa-sliders-h"></i> Advanced';
                this.style.backgroundColor = '';

                setTimeout(() => {
                    advancedPanel.style.display = 'none';
                }, 400);
            }
        });
    }

    // Apply advanced search filters
    window.applyAdvancedSearch = function() {
        const table = document.getElementById('itemsTable');
        if (!table) return;

        const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
        const priceMin = parseFloat(document.getElementById('priceMin').value) || 0;
        const priceMax = parseFloat(document.getElementById('priceMax').value) || Infinity;
        const stockMin = parseInt(document.getElementById('stockMin').value) || 0;
        const stockMax = parseInt(document.getElementById('stockMax').value) || Infinity;
        const statusFilter = document.getElementById('statusFilter').value;

        let visibleCount = 0;

        Array.from(rows).forEach((row, index) => {
            const price = parseFloat(row.getAttribute('data-price'));
            const stock = parseInt(row.getAttribute('data-stock'));

            let show = true;

            // Price filter
            if (price < priceMin || price > priceMax) show = false;

            // Stock filter
            if (stock < stockMin || stock > stockMax) show = false;

            // Status filter
            if (statusFilter) {
                switch(statusFilter) {
                    case 'in-stock':
                        if (stock === 0) show = false;
                        break;
                    case 'low-stock':
                        if (stock >= 10 || stock === 0) show = false;
                        break;
                    case 'out-of-stock':
                        if (stock > 0) show = false;
                        break;
                }
            }

            if (show) {
                row.style.display = '';
                row.style.animation = `fadeInScale 0.5s ease-out ${visibleCount * 0.1}s both`;
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });

        showNotification(`Advanced search applied: ${visibleCount} items match criteria`, 'success');
    };

    // Clear advanced search
    window.clearAdvancedSearch = function() {
        document.getElementById('priceMin').value = '';
        document.getElementById('priceMax').value = '';
        document.getElementById('stockMin').value = '';
        document.getElementById('stockMax').value = '';
        document.getElementById('statusFilter').value = '';

        // Show all rows
        const table = document.getElementById('itemsTable');
        if (table) {
            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
            Array.from(rows).forEach(row => {
                row.style.display = '';
                row.style.animation = 'fadeInScale 0.3s ease-out';
            });
        }

        showNotification('Advanced search filters cleared', 'info');
    };

    // Add fadeInScale animation
    const fadeInScaleStyle = document.createElement('style');
    fadeInScaleStyle.textContent = `
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
    `;
    document.head.appendChild(fadeInScaleStyle);

    // Add print functionality
    function addPrintFunctionality() {
        const tableHeader = document.querySelector('.table-header .table-filters');
        if (!tableHeader) return;

        const printBtn = document.createElement('button');
        printBtn.className = 'btn btn-info btn-sm';
        printBtn.innerHTML = '<i class="fas fa-print"></i> Print';
        printBtn.onclick = printTable;
        printBtn.style.marginLeft = '10px';

        tableHeader.appendChild(printBtn);
    }

    // Print table function
    function printTable() {
        const table = document.getElementById('itemsTable');
        if (!table) return;

        const printWindow = window.open('', '_blank');
        const currentDate = new Date().toLocaleDateString();

        printWindow.document.write(`
            <!DOCTYPE html>
            <html>
            <head>
                <title>Pahana Edu Management - Items Report</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                        color: #333;
                    }
                    h1 {
                        color: #2dd4bf;
                        text-align: center;
                        margin-bottom: 10px;
                    }
                    .report-info {
                        text-align: center;
                        margin-bottom: 30px;
                        font-size: 14px;
                        color: #666;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 20px;
                        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                    }
                    th, td {
                        border: 1px solid #ddd;
                        padding: 12px 8px;
                        text-align: left;
                    }
                    th {
                        background-color: #2dd4bf;
                        color: white;
                        font-weight: bold;
                    }
                    tr:nth-child(even) {
                        background-color: #f8f9fa;
                    }
                    tr:hover {
                        background-color: #e6fffa;
                    }
                    .price {
                        font-weight: bold;
                        color: #10b981;
                    }
                    .stock-low {
                        color: #ef4444;
                        font-weight: bold;
                    }
                    .stock-out {
                        color: #6b7280;
                        font-style: italic;
                    }
                    @media print {
                        body { margin: 0; }
                        table { page-break-inside: avoid; }
                    }
                </style>
            </head>
            <body>
                <h1>📚 Pahana Edu Management System</h1>
                <div class="report-info">
                    <strong>Items Inventory Report</strong><br>
                    Generated on: ${currentDate}<br>
                    Total Items: ${table.getElementsByTagName('tbody')[0].getElementsByTagName('tr').length}
                </div>
        `);

        // Clone and modify table for printing
        const printTable = table.cloneNode(true);
        const actionColumns = printTable.querySelectorAll('th:last-child, td:last-child');
        actionColumns.forEach(col => col.remove());

        // Add classes for styling
        const priceColumns = printTable.querySelectorAll('td:nth-child(3)');
        priceColumns.forEach(col => col.classList.add('price'));

        const stockBadges = printTable.querySelectorAll('.stock-badge');
        stockBadges.forEach(badge => {
            if (badge.classList.contains('stock-low')) {
                badge.classList.add('stock-low');
            } else if (badge.classList.contains('stock-out')) {
                badge.classList.add('stock-out');
            }
        });

        printWindow.document.write(printTable.outerHTML);
        printWindow.document.write('</body></html>');
        printWindow.document.close();

        setTimeout(() => {
            printWindow.print();
            printWindow.close();
        }, 500);

        showNotification('Print dialog opened', 'info');
    }

    // Add bulk operations
    function addBulkOperations() {
        const tableHeader = document.querySelector('.table-header');
        if (!tableHeader) return;

        // Add bulk actions container
        const bulkContainer = document.createElement('div');
        bulkContainer.className = 'bulk-actions-container';
        bulkContainer.style.cssText = `
            margin-top: 15px;
            padding: 15px;
            background: rgba(45, 212, 191, 0.1);
            border-radius: 10px;
            border: 1px solid rgba(45, 212, 191, 0.2);
            display: none;
            animation-fill-mode: both;
        `;

        bulkContainer.innerHTML = `
            <div style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap;">
                <span style="font-weight: 600; color: #1e293b;">
                    <i class="fas fa-check-square"></i>
                    <span id="selectedCount">0</span> selected
                </span>
                <button class="btn btn-warning btn-sm" onclick="bulkUpdateStock()">
                    <i class="fas fa-boxes"></i> Update Stock
                </button>
                <button class="btn btn-info btn-sm" onclick="bulkExport()">
                    <i class="fas fa-download"></i> Export Selected
                </button>
                <button class="btn btn-secondary btn-sm" onclick="clearSelection()">
                    <i class="fas fa-times"></i> Clear Selection
                </button>
            </div>
        `;

        tableHeader.appendChild(bulkContainer);

        // Add checkboxes to table
        addCheckboxesToTable();
    }

    // Add checkboxes to table rows
    function addCheckboxesToTable() {
        const table = document.getElementById('itemsTable');
        if (!table) return;

        // Add header checkbox
        const headerRow = table.querySelector('thead tr');
        const headerCheckbox = document.createElement('th');
        headerCheckbox.innerHTML = '<input type="checkbox" id="selectAll" style="transform: scale(1.2);">';
        headerRow.insertBefore(headerCheckbox, headerRow.firstChild);

        // Add row checkboxes
        const bodyRows = table.querySelectorAll('tbody tr');
        bodyRows.forEach(row => {
            const checkbox = document.createElement('td');
            checkbox.innerHTML = '<input type="checkbox" class="row-select" style="transform: scale(1.2);">';
            row.insertBefore(checkbox, row.firstChild);
        });

        // Handle select all
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.row-select');
            checkboxes.forEach(cb => {
                cb.checked = this.checked;
                cb.dispatchEvent(new Event('change'));
            });
        });

        // Handle individual selections
        document.querySelectorAll('.row-select').forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                const row = this.closest('tr');
                if (this.checked) {
                    row.style.backgroundColor = 'rgba(45, 212, 191, 0.1)';
                    row.style.borderLeft = '4px solid #2dd4bf';
                } else {
                    row.style.backgroundColor = '';
                    row.style.borderLeft = '';
                }

                updateBulkActions();
            });
        });
    }

    // Update bulk actions visibility
    function updateBulkActions() {
        const selected = document.querySelectorAll('.row-select:checked');
        const bulkContainer = document.querySelector('.bulk-actions-container');
        const selectedCount = document.getElementById('selectedCount');

        if (selected.length > 0) {
            bulkContainer.style.display = 'block';
            bulkContainer.style.animation = 'slideInDown 0.3s ease-out';
            selectedCount.textContent = selected.length;
        } else {
            bulkContainer.style.animation = 'slideOutUp 0.3s ease-out';
            setTimeout(() => {
                bulkContainer.style.display = 'none';
            }, 300);
        }
    }

    // Bulk operations functions
    window.bulkUpdateStock = function() {
        const selected = document.querySelectorAll('.row-select:checked');
        if (selected.length === 0) return;

        const stockValue = prompt(`Enter new stock value for ${selected.length} selected items:`);
        if (stockValue && !isNaN(stockValue)) {
            showNotification(`Stock updated for ${selected.length} items (simulation)`, 'success');
        }
    };

    window.bulkExport = function() {
        const selected = document.querySelectorAll('.row-select:checked');
        if (selected.length === 0) return;

        showNotification(`Exporting ${selected.length} selected items...`, 'info');
        // Implementation would filter table for selected rows and export
    };

    window.clearSelection = function() {
        document.querySelectorAll('.row-select:checked').forEach(cb => {
            cb.checked = false;
            cb.dispatchEvent(new Event('change'));
        });
        document.getElementById('selectAll').checked = false;
    };

    // Initialize everything when DOM loads
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize all advanced features
        addTableSorting();
        addAdvancedSearch();
        addPrintFunctionality();
        addBulkOperations();

        console.log('🎯 All advanced features initialized successfully!');
    });

    console.log('✨ Complete enhanced item management system loaded!');
</script>
</body>
</html>
