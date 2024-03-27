/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Env;

/**
 * SSO Principal Service Configuration
 */
public class MSSOPrincipalConfig extends X_SSO_PrincipalConfig
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6330419996581130413L;

	/**
	 * @param ctx
	 * @param MFA_SSOAuthentication_ID
	 * @param trxName
	 */
	public MSSOPrincipalConfig(Properties ctx, int MFA_SSOAuthentication_ID, String trxName)
	{
		super(ctx, MFA_SSOAuthentication_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MSSOPrincipalConfig(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	/**
	 * @return Default MSSOPrincipalConfig
	 */
	public static MSSOPrincipalConfig getDefaultSSOPrincipalConfig()
	{
		return new Query(Env.getCtx(), Table_Name, COLUMNNAME_IsDefault + " = 'Y' ", null).setOnlyActiveRecords(true).firstOnly();
	}

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		// Validate only one default SSO Principal Configuration
		if (newRecord || is_ValueChanged(COLUMNNAME_IsDefault)|| is_ValueChanged(COLUMNNAME_IsActive))
		{
			if(!isActive())
			{
				setIsDefault(false);
			}

			if (isDefault() && getDefaultSSOPrincipalConfig() != null)
			{
				throw new AdempiereException("There can be only one default SSO Principal Configuration");
			}

			if (newRecord && getDefaultSSOPrincipalConfig() == null)
			{
				setIsDefault(true);
			}
			
		}
		return super.beforeSave(newRecord);
	}
}
