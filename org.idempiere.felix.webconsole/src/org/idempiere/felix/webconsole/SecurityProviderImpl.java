/**
 * 
 */
package org.idempiere.felix.webconsole;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.felix.webconsole.WebConsoleSecurityProvider3;
import org.compiere.util.Util;
import org.idempiere.felix.webconsole.servlet.LoginServlet;

/**
 * @author hengsin
 *
 */
public class SecurityProviderImpl implements WebConsoleSecurityProvider3 {

	/* (non-Javadoc)
	 * @see org.apache.felix.webconsole.WebConsoleSecurityProvider#authenticate(java.lang.String, java.lang.String)
	 */
	@Override
	public Object authenticate(String username, String password) {
		return null;
	}

	/* (non-Javadoc)
	 * @see org.apache.felix.webconsole.WebConsoleSecurityProvider#authorize(java.lang.Object, java.lang.String)
	 */
	@Override
	public boolean authorize(Object resource, String role) {
		return true;
	}

	@Override
	public boolean authenticate(HttpServletRequest request, HttpServletResponse response) {
		var session = request.getSession(false);
		if (session != null) {
			String authUser = (String) session.getAttribute(LoginServlet.AUTHENTICATED_USER);
			if (!Util.isEmpty(authUser, true)) {
				return true;
			}
		}

		// Not authenticated, redirect to login page
		String returnUrl = request.getRequestURI();
		if (request.getQueryString() != null) {
			returnUrl += "?" + request.getQueryString();
		}
		
		try {
			response.sendRedirect(request.getContextPath() + "/login.jsp?returnUrl=" + 
						java.net.URLEncoder.encode(returnUrl, "UTF-8"));
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return false;
	}

	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		var session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		try {
			response.sendRedirect(request.getContextPath() + "/login");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

}
