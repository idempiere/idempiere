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

import org.adempiere.base.annotation.Parameter;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.SystemIDs;
import org.compiere.util.CacheMgt;
import org.compiere.util.SecureEngine;

/**
 *	Hash existing passwords
 *	
 */
@org.adempiere.base.annotation.Process
public class HashPasswords extends SvrProcess
{
	@Parameter(name = "PasswordHashAlgorithm")
	private String hashAlgorithm = null;
	
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
		
		if (hashAlgorithm == null || hashAlgorithm.trim().isEmpty()) {
			throw new AdempiereException("PasswordHashAlgorithm parameter is required");
		}
		
		// Validate that the algorithm is supported
		if (!SecureEngine.isSupportedPaswordHashAlgorithm(hashAlgorithm)) {
			throw new AdempiereException("Unsupported hash algorithm: " + hashAlgorithm);
		}
		
		String where = " Password IS NOT NULL AND Salt IS NULL ";
		
		// update the sysconfig key to Y out of trx and reset the cache
		MSysConfig conf = new MSysConfig(getCtx(), SystemIDs.SYSCONFIG_USER_HASH_PASSWORD, null);
		conf.setValue("Y");
		conf.saveEx();
		
		MSysConfig algorithmConfig = new MSysConfig(getCtx(), SystemIDs.SYSCONFIG_USER_HASH_PASSWORD_ALGORITHM, null);
		algorithmConfig.setValue(hashAlgorithm);
		algorithmConfig.saveEx();
		
		CacheMgt.get().reset(MSysConfig.Table_Name);

		int count = 0;
		try {
			List<MUser> users = MTable.get(getCtx(), MUser.Table_ID).createQuery( where, get_TrxName()).list();
			for ( MUser user : users )
			{
				user.setPasswordHashAlgorithm(hashAlgorithm);
				user.setSaltAlgorithm(SecureEngine.DEFAULT_SECURE_RANDOM_ALGORITHM);
				user.setPassword(user.getPassword());
				count++;
				user.set_Attribute(MUser.SAVING_MIGRATE_USER_PASSWORD_IF_NEEDED, "Y");
				try {
					user.saveEx();
				} finally {
					user.set_Attribute(MUser.SAVING_MIGRATE_USER_PASSWORD_IF_NEEDED, null);
				}
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
