<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Error - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .error-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            text-align: center;
            padding: 2rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }

        .error-card {
            background: white;
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            max-width: 600px;
            width: 100%;
        }

        .error-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
            color: #f39c12;
        }

        .error-title {
            font-size: 1.8rem;
            color: #2c3e50;
            margin: 1rem 0;
        }

        .error-message {
            color: #7f8c8d;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 2rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #229954 0%, #27ae60 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.3);
        }

        .btn-secondary {
            background: #ecf0f1;
            color: #2c3e50;
        }

        .btn-secondary:hover {
            background: #d5dbdb;
        }

        .btn-warning {
            background: #f39c12;
            color: white;
        }

        .btn-warning:hover {
            background: #e67e22;
        }

        .error-details {
            text-align: left;
            padding: 1rem;
            background: #f8f9fa;
            border-radius: 8px;
            font-size: 0.9rem;
            color: #6c757d;
            margin-top: 2rem;
        }

        .error-technical {
            background: #e8f4f8;
            border: 1px solid #bee5eb;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
            text-align: left;
            max-height: 300px;
            overflow-y: auto;
        }

        .error-technical h4 {
            margin: 0 0 0.5rem 0;
            color: #0c5460;
        }

        .error-technical pre {
            margin: 0;
            font-size: 0.8rem;
            white-space: pre-wrap;
            word-break: break-all;
            background: #f1f3f4;
            padding: 0.5rem;
            border-radius: 4px;
        }

        .troubleshooting {
            background: #d1ecf1;
            border: 1px solid #b6d4d9;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
            text-align: left;
        }

        .troubleshooting h4 {
            margin: 0 0 0.5rem 0;
            color: #0c5460;
        }

        .troubleshooting ul {
            margin: 0.5rem 0;
            padding-left: 1.2rem;
        }

        .troubleshooting li {
            margin-bottom: 0.25rem;
        }

        @media (max-width: 768px) {
            .error-card {
                padding: 2rem;
                margin: 1rem;
            }

            .error-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-card">
        <div class="error-icon">🛠️</div>
        <h2 class="error-title">System Error</h2>
        <p class="error-message">
            An unexpected error has occurred while processing your request.
            Don't worry - this has been logged and our team will investigate the issue.
        </p>

        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">
                🏠 Go to Dashboard
            </a>
            <a href="javascript:history.back()" class="btn btn-secondary">
                ← Go Back
            </a>
            <a href="javascript:location.reload()" class="btn btn-warning">
                🔄 Retry
            </a>
        </div>

        <div class="error-details">
            <strong>Error ID:</strong> ERR-<%= System.currentTimeMillis() %><br>
            <strong>Timestamp:</strong> <%= new java.util.Date() %><br>
            <strong>Session:</strong> <%= session != null && session.getAttribute("adminUser") != null ? "Active" : "Inactive" %><br>
            <strong>Request:</strong> <%= request.getMethod() %> <%= request.getRequestURI() %>
            <% if (request.getQueryString() != null) { %>?<%= request.getQueryString() %><% } %>
        </div>

        <!-- Exception Details -->
        <% if (exception != null) { %>
        <div class="error-technical">
            <h4>🔍 Exception Information</h4>
            <strong>Type:</strong> <%= exception.getClass().getName() %><br>
            <strong>Message:</strong> <%= exception.getMessage() != null ? exception.getMessage() : "No detailed message available" %><br>

            <% if (exception.getCause() != null) { %>
            <strong>Root Cause:</strong> <%= exception.getCause().getClass().getSimpleName() %><br>
            <strong>Cause Message:</strong> <%= exception.getCause().getMessage() %><br>
            <% } %>

            <!-- Stack trace (first few lines) -->
            <%
                java.io.StringWriter sw = new java.io.StringWriter();
                java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                exception.printStackTrace(pw);
                String stackTrace = sw.toString();
                String[] lines = stackTrace.split("\n");
                int maxLines = Math.min(10, lines.length);
            %>
            <strong>Stack Trace (first <%= maxLines %> lines):</strong>
            <pre><% for (int i = 0; i < maxLines; i++) { %><%= lines[i] %>
<% } %><% if (lines.length > maxLines) { %>... and <%= lines.length - maxLines %> more lines<% } %></pre>
        </div>
        <% } %>

        <!-- Troubleshooting Guide -->
        <div class="troubleshooting">
            <h4>🚀 Troubleshooting Steps</h4>
            <ul>
                <li><strong>Check your session:</strong> Make sure you're still logged in</li>
                <li><strong>Verify your input:</strong> Ensure all required fields are filled correctly</li>
                <li><strong>Try again:</strong> Sometimes temporary issues resolve themselves</li>
                <li><strong>Clear browser cache:</strong> Refresh the page or clear your browser cache</li>
                <li><strong>Different approach:</strong> Try accessing the feature through a different menu</li>
            </ul>
        </div>

        <!-- Common Solutions -->
        <div class="troubleshooting">
            <h4>🔧 Common Solutions</h4>
            <ul>
                <li><strong>Database Issues:</strong> Check if database connection is available</li>
                <li><strong>Form Errors:</strong> Verify all required fields are completed</li>
                <li><strong>Session Timeout:</strong> <a href="${pageContext.request.contextPath}/login">Please login again</a></li>
                <li><strong>Permissions:</strong> Ensure you have access to this feature</li>
            </ul>
        </div>
    </div>
</div>

<script>
    // Log comprehensive error information
    console.group('🚨 System Error Details');
    console.error('Error occurred at:', new Date().toISOString());
    console.error('URL:', window.location.href);
    console.error('User Agent:', navigator.userAgent);

    <% if (exception != null) { %>
    console.error('Exception Type:', '<%= exception.getClass().getSimpleName() %>');
    console.error('Exception Message:', '<%= exception.getMessage() != null ? exception.getMessage().replace("'", "\\'").replace("\n", "\\n") : "No message" %>');
    <% } %>

    console.error('Request Method:', '<%= request.getMethod() %>');
    console.error('Request URI:', '<%= request.getRequestURI() %>');
    console.error('Session Active:', <%= session != null && session.getAttribute("adminUser") != null %>);
    console.groupEnd();

    // Offer auto-redirect after some time
    setTimeout(() => {
        if (confirm('This error has persisted. Would you like to return to the dashboard?')) {
            window.location.href = '${pageContext.request.contextPath}/dashboard';
        }
    }, 15000);

    // Auto-retry for specific types of errors
    let retryCount = 0;
    function autoRetry() {
        if (retryCount < 2) {
            retryCount++;
            console.log('Auto-retry attempt:', retryCount);
            setTimeout(() => {
                location.reload();
            }, 5000);
        }
    }

    // Detect if this might be a temporary error
    <% if (exception != null && exception.getMessage() != null &&
          (exception.getMessage().contains("Connection") ||
           exception.getMessage().contains("timeout") ||
           exception.getMessage().contains("Timeout"))) { %>
    console.log('Detected potential connection issue - will auto-retry');
    autoRetry();
    <% } %>
</script>
</body>
</html>