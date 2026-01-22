/**
 * 
 */
package org.idempiere.felix.webconsole;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.felix.webconsole.WebConsoleSecurityProvider3;
import org.compiere.util.CLogger;
import org.compiere.util.Util;
import org.idempiere.felix.webconsole.servlet.LoginServlet;

/**
 * @author hengsin
 *
 */
public class SecurityProviderImpl implements WebConsoleSecurityProvider3 {

	/**	Logger			*/
	private final static CLogger	log = CLogger.getCLogger(SecurityProviderImpl.class);
	
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
		try {
			response.sendRedirect(request.getContextPath() + "/login");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return false;
	}

	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.sendRedirect(request.getContextPath() + "/login");
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

}
