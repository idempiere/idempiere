/**
 * 
 */
package org.idempiere.felix.webconsole;

import org.apache.felix.webconsole.WebConsoleSecurityProvider;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class SecurityProviderImpl implements WebConsoleSecurityProvider {

	/**	Logger			*/
	protected CLogger	log = CLogger.getCLogger(getClass());
	
	/* (non-Javadoc)
	 * @see org.apache.felix.webconsole.WebConsoleSecurityProvider#authenticate(java.lang.String, java.lang.String)
	 */
	@Override
	public Object authenticate(String username, String password) {
		MUser user = MUser.get(Env.getCtx(), username, password);
		if (user == null)
		{
			log.warning ("User not found: '" + username);
			return null;
		}
		if (!user.isAdministrator())
		{
			log.warning ("Not a Sys Admin = " + username);
			return null;
		}
		log.info ("Name=" + username);
		return Boolean.TRUE;
	}

	/* (non-Javadoc)
	 * @see org.apache.felix.webconsole.WebConsoleSecurityProvider#authorize(java.lang.Object, java.lang.String)
	 */
	@Override
	public boolean authorize(Object resource, String role) {
		return true;
	}

}
