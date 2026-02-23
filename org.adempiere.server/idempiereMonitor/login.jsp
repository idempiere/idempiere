<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.UUID" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// Generate CSRF token
	String csrfToken = UUID.randomUUID().toString();
	session.setAttribute("CSRF_TOKEN", csrfToken);
	
	// Get error message if any
	String error = request.getParameter("error");
	String returnUrl = request.getParameter("returnUrl");
	if (returnUrl == null || returnUrl.isEmpty()) {
		returnUrl = request.getContextPath() + "/idempiereMonitor";
	}
	request.setAttribute("returnUrl", returnUrl);
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>iDempiere Monitor - Login</title>
	<style>
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}
		
		body {
			font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			min-height: 100vh;
			display: flex;
			align-items: center;
			justify-content: center;
			padding: 20px;
		}
		
		.login-container {
			background: white;
			border-radius: 12px;
			box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
			width: 100%;
			max-width: 420px;
			padding: 40px;
			animation: slideUp 0.4s ease-out;
		}
		
		@keyframes slideUp {
			from {
				opacity: 0;
				transform: translateY(30px);
			}
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}
		
		.logo {
			text-align: center;
			margin-bottom: 30px;
		}
		
		.logo h1 {
			color: #333;
			font-size: 28px;
			font-weight: 600;
			margin-bottom: 8px;
		}
		
		.logo p {
			color: #666;
			font-size: 14px;
		}
		
		.error-message {
			background: #fee;
			border: 1px solid #fcc;
			border-radius: 6px;
			color: #c33;
			padding: 12px 16px;
			margin-bottom: 20px;
			font-size: 14px;
			display: flex;
			align-items: center;
			gap: 8px;
		}
		
		.error-message::before {
			content: "⚠";
			font-size: 18px;
		}
		
		.form-group {
			margin-bottom: 20px;
		}
		
		.form-group label {
			display: block;
			color: #333;
			font-size: 14px;
			font-weight: 500;
			margin-bottom: 8px;
		}
		
		.form-group input {
			width: 100%;
			padding: 12px 16px;
			border: 2px solid #e0e0e0;
			border-radius: 8px;
			font-size: 15px;
			transition: all 0.3s ease;
			background: #fafafa;
		}
		
		.form-group input:focus {
			outline: none;
			border-color: #667eea;
			background: white;
			box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
		}
		
		.form-group input:hover {
			border-color: #ccc;
		}
		
		.submit-btn {
			width: 100%;
			padding: 14px;
			background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
			color: white;
			border: none;
			border-radius: 8px;
			font-size: 16px;
			font-weight: 600;
			cursor: pointer;
			transition: all 0.3s ease;
			margin-top: 10px;
		}
		
		.submit-btn:hover {
			transform: translateY(-2px);
			box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
		}
		
		.submit-btn:active {
			transform: translateY(0);
		}
		
		.footer {
			text-align: center;
			margin-top: 30px;
			padding-top: 20px;
			border-top: 1px solid #e0e0e0;
			color: #666;
			font-size: 13px;
		}
		
		.footer a {
			color: #667eea;
			text-decoration: none;
		}
		
		.footer a:hover {
			text-decoration: underline;
		}
	</style>
	<script>
		window.onload = function() {
			if (window.location.hash) {				
				// Find your hidden returnUrl input
				const returnUrlInput = document.getElementsByName('returnUrl')[0];
				
				// Append the fragment if it's not already there
				if (returnUrlInput && !returnUrlInput.value.includes('#')) {
					returnUrlInput.value += window.location.hash;
				}
			}
		};
	</script>
</head>
<body>
	<div class="login-container">
		<div class="logo">
			<h1>iDempiere Monitor</h1>
			<p>Server Administration</p>
		</div>
		
		<% if ("invalid".equals(error)) { %>
		<div class="error-message">
			Invalid username or password. Please try again.
		</div>
		<% } else if ("access".equals(error)) { %>
		<div class="error-message">
			You don't have permission to access the monitor.
		</div>
		<% } else if ("session".equals(error)) { %>
		<div class="error-message">
			Your session has expired. Please log in again.
		</div>
		<% } else if ("locked".equals(error)) { %>
		<div class="error-message">
			Too many failed login attempts. Please try again later.
		</div>
 		<% } %>
		
		<form method="POST" action="<%= request.getContextPath() %>/idempiereMonitor/login">
			<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
			<input type="hidden" name="returnUrl" value="<c:out value='${returnUrl}'/>">
			
			<div class="form-group">
				<label for="username">Username</label>
				<input type="text" id="username" name="username" required autofocus autocomplete="username">
			</div>
			
			<div class="form-group">
				<label for="password">Password</label>
				<input type="password" id="password" name="password" required autocomplete="current-password">
			</div>
			
			<button type="submit" class="submit-btn">Sign In</button>
		</form>
		
		<div class="footer">
			<p>&copy; 2026 iDempiere. <a href="https://www.idempiere.org" target="_blank">Learn more</a></p>
		</div>
	</div>
</body>
</html>
