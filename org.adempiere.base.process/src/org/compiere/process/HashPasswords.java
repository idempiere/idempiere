/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.process;

import java.util.List;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.SystemIDs;

/**
 *	Hash existing passwords
 *	
 */
public class HashPasswords extends SvrProcess
{
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message 
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		boolean hash_password = MSysConfig.getBooleanValue(MSysConfig.USER_PASSWORD_HASH, false);
		if (hash_password)
			throw new AdempiereException("Passwords already hashed");
		
		String where = " Password IS NOT NULL AND Salt IS NULL ";
		
		// update the sysconfig key to Y out of trx and reset the cache
		MSysConfig conf = new MSysConfig(getCtx(), SystemIDs.SYSCONFIG_USER_HASH_PASSWORD, null);
		conf.setValue("Y");
		conf.saveEx();
		MSysConfig.resetCache();

		int count = 0;
		try {
			List<MUser> users = MTable.get(getCtx(), MUser.Table_ID).createQuery( where, get_TrxName()).list();
			for ( MUser user : users )
			{
				user.setPassword(user.getPassword());
				count++;
				user.saveEx();
			}
		} catch (Exception e) {
			// reset to N on exception
			conf.setValue("N");
			conf.saveEx();
			throw e;
		}
		
		return "@Updated@ " + count;
	}	//	doIt

}	//	HashPasswords
