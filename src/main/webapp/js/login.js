// Simple Login JavaScript - Pahana Edu
// Clean, functional, and reliable login form handling

document.addEventListener('DOMContentLoaded', function() {
    console.log('✅ Simple login system initialized');

    // Get form elements
    const loginForm = document.getElementById('loginForm');
    const usernameField = document.getElementById('username');
    const passwordField = document.getElementById('password');
    const loginBtn = document.getElementById('loginBtn');
    const togglePassword = document.getElementById('togglePassword');
    const loadingOverlay = document.getElementById('loadingOverlay');

    // Password toggle functionality
    if (togglePassword && passwordField) {
        togglePassword.addEventListener('click', function() {
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                togglePassword.textContent = '🙈';
            } else {
                passwordField.type = 'password';
                togglePassword.textContent = '👁';
            }
        });
    }

    // Clear error messages when user starts typing
    if (usernameField) {
        usernameField.addEventListener('input', function() {
            clearErrorMessage('usernameError');
            clearFieldError(usernameField);
        });
    }

    if (passwordField) {
        passwordField.addEventListener('input', function() {
            clearErrorMessage('passwordError');
            clearFieldError(passwordField);
        });
    }

    // Auto-focus functionality
    if (usernameField && !usernameField.value) {
        usernameField.focus();
    } else if (passwordField && !passwordField.value) {
        passwordField.focus();
    }

    // Handle Enter key in username field
    if (usernameField && passwordField) {
        usernameField.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                passwordField.focus();
            }
        });
    }

    // Main form submission handler
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            console.log('🔍 Form submission started');

            // Get field values
            const username = usernameField.value.trim();
            const password = passwordField.value.trim();

            console.log('📝 Username:', '"' + username + '"', 'Length:', username.length);
            console.log('📝 Password length:', password.length);

            // Clear previous errors
            clearAllErrors();

            // Simple validation
            let hasErrors = false;

            if (!username) {
                showFieldError('username', 'Username is required');
                hasErrors = true;
            }

            if (!password) {
                showFieldError('password', 'Password is required');
                hasErrors = true;
            }

            // Basic length checks
            if (username && username.length < 3) {
                showFieldError('username', 'Username must be at least 3 characters');
                hasErrors = true;
            }

            if (password && password.length < 4) {
                showFieldError('password', 'Password must be at least 4 characters');
                hasErrors = true;
            }

            if (hasErrors) {
                console.log('❌ Validation failed - preventing submission');
                e.preventDefault();

                // Focus on first error field
                const firstErrorField = document.querySelector('.error');
                if (firstErrorField) {
                    firstErrorField.focus();
                }
                return false;
            }

            console.log('✅ Validation passed - submitting to servlet');

            // Show loading state
            showLoadingState();

            // Allow form to submit normally to servlet
            return true;
        });
    }

    // Utility functions
    function clearErrorMessage(errorId) {
        const errorElement = document.getElementById(errorId);
        if (errorElement) {
            errorElement.textContent = '';
        }
    }

    function clearFieldError(field) {
        if (field) {
            field.classList.remove('error');
        }
    }

    function clearAllErrors() {
        // Clear error messages
        clearErrorMessage('usernameError');
        clearErrorMessage('passwordError');

        // Clear field error styles
        clearFieldError(usernameField);
        clearFieldError(passwordField);
    }

    function showFieldError(fieldName, message) {
        const field = document.getElementById(fieldName);
        const errorElement = document.getElementById(fieldName + 'Error');

        if (field) {
            field.classList.add('error');
        }

        if (errorElement) {
            errorElement.textContent = message;
        }
    }

    function showLoadingState() {
        if (loginBtn) {
            const btnText = loginBtn.querySelector('.btn-text');
            const btnLoading = loginBtn.querySelector('.btn-loading');

            if (btnText && btnLoading) {
                btnText.style.display = 'none';
                btnLoading.style.display = 'inline-flex';
            }

            loginBtn.disabled = true;
        }

        if (loadingOverlay) {
            loadingOverlay.style.display = 'flex';
        }

        // Disable form fields during submission
        if (usernameField) usernameField.disabled = true;
        if (passwordField) passwordField.disabled = true;
    }

    function hideLoadingState() {
        if (loginBtn) {
            const btnText = loginBtn.querySelector('.btn-text');
            const btnLoading = loginBtn.querySelector('.btn-loading');

            if (btnText && btnLoading) {
                btnText.style.display = 'inline';
                btnLoading.style.display = 'none';
            }

            loginBtn.disabled = false;
        }

        if (loadingOverlay) {
            loadingOverlay.style.display = 'none';
        }

        // Re-enable form fields
        if (usernameField) usernameField.disabled = false;
        if (passwordField) passwordField.disabled = false;
    }

    // Auto-hide alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(alert) {
        setTimeout(function() {
            if (alert.parentNode) {
                alert.style.opacity = '0';
                setTimeout(function() {
                    if (alert.parentNode) {
                        alert.style.display = 'none';
                    }
                }, 300);
            }
        }, 5000);
    });

    // Handle browser back/forward
    window.addEventListener('pageshow', function(e) {
        if (e.persisted) {
            hideLoadingState();
        }
    });

    // Reset form if stuck in loading state
    document.addEventListener('visibilitychange', function() {
        if (!document.hidden && loginBtn && loginBtn.disabled) {
            setTimeout(hideLoadingState, 2000);
        }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Escape key to clear form
        if (e.key === 'Escape') {
            if (usernameField) usernameField.value = '';
            if (passwordField) passwordField.value = '';
            clearAllErrors();
            if (usernameField) usernameField.focus();
        }

        // Ctrl+L to focus username
        if (e.ctrlKey && e.key === 'l') {
            e.preventDefault();
            if (usernameField) {
                usernameField.focus();
                usernameField.select();
            }
        }
    });

    console.log('🚀 Login form ready for use');
});

// Global utility functions for other pages
window.PahanaEdu = {
    // Show simple toast notification
    showToast: function(message, type = 'info') {
        const toast = document.createElement('div');
        toast.className = `alert alert-${type}`;
        toast.style.position = 'fixed';
        toast.style.top = '20px';
        toast.style.right = '20px';
        toast.style.zIndex = '9999';
        toast.style.minWidth = '300px';
        toast.innerHTML = `<i class="icon-${type}">ℹ️</i> ${message}`;

        document.body.appendChild(toast);

        setTimeout(() => {
            toast.style.opacity = '0';
            setTimeout(() => {
                if (toast.parentNode) {
                    toast.remove();
                }
            }, 300);
        }, 3000);
    },

    // Format currency for display
    formatCurrency: function(amount) {
        return 'LKR ' + parseFloat(amount).toFixed(2);
    },

    // Simple loading state for buttons
    showButtonLoading: function(button, loadingText = 'Loading...') {
        if (button) {
            button.dataset.originalText = button.innerHTML;
            button.innerHTML = `<span class="spinner"></span> ${loadingText}`;
            button.disabled = true;
        }
    },

    hideButtonLoading: function(button) {
        if (button && button.dataset.originalText) {
            button.innerHTML = button.dataset.originalText;
            button.disabled = false;
        }
    }
};