/******************************************************************************
 * Copyright (C) 2010 Low Heng Sin  All Rights Reserved.                      *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.web.server;

import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.MSession;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.restlet.security.SecretVerifier;

/**
 * Http basic authentication implementation. Support authentication using session token or 
 * userid+password
 * @author hengsin
 */
public class BasicVerifier extends SecretVerifier {

	private final static CLogger log = CLogger.getCLogger(BasicVerifier.class);
	
	/* (non-Javadoc)
	 * @see org.restlet.security.SecretVerifier#verify(java.lang.String, char[])
	 */
	@Override
	public int verify(String identity, char[] password)
			throws IllegalArgumentException {
		//authenticate with session token
		if (identity.startsWith("AD_Session_ID#"))
		{
			String sessionId = identity.substring("AD_Session_ID#".length());
			int AD_Session_ID = 0;
			try 
			{
				AD_Session_ID = Integer.parseInt(sessionId);
			} 
			catch (Exception e)
			{
				log.log(Level.WARNING, "Invalid session token: " + identity);
				return RESULT_INVALID;
			}
			MSession session = new MSession(Env.getCtx(), AD_Session_ID, null);
			if (session.getAD_Session_ID() != AD_Session_ID)
			{
				log.log(Level.WARNING, "Session not exists in database: " + identity);
				return RESULT_INVALID;
			}
			if (session.isProcessed())
			{
				log.log(Level.WARNING, "Session have logout: " + identity);
				return RESULT_INVALID;
			}
			if (!session.isActive())
			{
				log.log(Level.WARNING, "Session isActive=false: " + identity);
				return RESULT_INVALID;
			}
			if (!session.getWebSession().equals(new String(password)))
			{
				log.log(Level.WARNING, "Session token doesn't match. identity=" + identity + ", token="+new String(password));
			}
			return RESULT_VALID;
		}
		
		//authenticate with userid+password
		Login login = new Login(new Properties());
		KeyNamePair[] roles = login.getRoles(identity, new String(password));
		return (roles != null && roles.length > 0) ? RESULT_VALID : RESULT_INVALID;
	}

}
