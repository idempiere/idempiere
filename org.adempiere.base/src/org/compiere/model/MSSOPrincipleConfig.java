package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Env;

public class MSSOPrincipleConfig extends X_SSO_PrincipleConfig
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6330419996581130413L;

	public MSSOPrincipleConfig(Properties ctx, int MFA_SSOAuthentication_ID, String trxName)
	{
		super(ctx, MFA_SSOAuthentication_ID, trxName);
	}

	public MSSOPrincipleConfig(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	public static MSSOPrincipleConfig getDefaultSSOPrinciple()
	{
		return new Query(Env.getCtx(), Table_Name, COLUMNNAME_IsDefault + " = 'Y' ", null).setOnlyActiveRecords(true).firstOnly();
	}

	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		if (newRecord || is_ValueChanged(COLUMNNAME_IsDefault)|| is_ValueChanged(COLUMNNAME_IsActive))
		{
			if(!isActive())
			{
				setIsDefault(false);
			}

			if (isDefault() && getDefaultSSOPrinciple() != null)
			{
				throw new AdempiereException("Then can be only one default SSO Authenticattion");
			}

			if (newRecord && getDefaultSSOPrinciple() == null)
			{
				setIsDefault(true);
			}
			
		}
		return super.beforeSave(newRecord);
	}
}
