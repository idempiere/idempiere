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
import java.util.Base64;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * SSO Principal Service Configuration
 */
public class MSSOPrincipalConfig extends X_SSO_PrincipalConfig
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID =  -5318719820186470903L;
	
	private static final CCache<String, Object>	s_SSOPrincipalConfigCache		= new CCache<String, Object>(MSSOPrincipalConfig.class.getSimpleName(), 10, 0);

	private static final String					DEFAULT_SSO_PRINCIPAL_CACHEKEY	= "DEFAULT_SSO_PRINCIPAL";
	private static final String					ALL_SSO_CONFIG_CACHEKEY			= "ALL_SSO_CONFIG";
	
	private String								imageBase64Src					= null;

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

	public static MSSOPrincipalConfig getDefaultSSOPrincipalConfig()
	{
		MSSOPrincipalConfig defaultConfig = (MSSOPrincipalConfig) s_SSOPrincipalConfigCache.get(DEFAULT_SSO_PRINCIPAL_CACHEKEY);
		if (defaultConfig != null)
			return defaultConfig;

		defaultConfig = new Query(Env.getCtx(), Table_Name, COLUMNNAME_IsDefault + " = 'Y'", null).setOnlyActiveRecords(true).firstOnly();

		if (defaultConfig != null)
			s_SSOPrincipalConfigCache.put(DEFAULT_SSO_PRINCIPAL_CACHEKEY, defaultConfig);

		return defaultConfig;
	}

	public static MSSOPrincipalConfig getSSOPrincipalConfig(String uuID)
	{
		if (Util.isEmpty(uuID))
			return null;

		MSSOPrincipalConfig cachedConfig = (MSSOPrincipalConfig) s_SSOPrincipalConfigCache.get(uuID);
		if (cachedConfig != null)
			return cachedConfig;

		cachedConfig = new Query(Env.getCtx(), Table_Name, COLUMNNAME_SSO_PrincipalConfig_UU + " = ?", null).setOnlyActiveRecords(true).setParameters(uuID)
																											.firstOnly();

		if (cachedConfig != null)
			s_SSOPrincipalConfigCache.put(uuID, cachedConfig);

		return cachedConfig;
	}

	public static List<MSSOPrincipalConfig> getAllSSOPrincipalConfig()
	{
		@SuppressWarnings("unchecked")
		List<MSSOPrincipalConfig> allConfigs = (List<MSSOPrincipalConfig>) s_SSOPrincipalConfigCache.get(ALL_SSO_CONFIG_CACHEKEY);
		if (allConfigs != null)
			return allConfigs;

		allConfigs = new Query(Env.getCtx(), Table_Name, null, null).setOnlyActiveRecords(true).list();

		if (allConfigs != null && !allConfigs.isEmpty())
			s_SSOPrincipalConfigCache.put(ALL_SSO_CONFIG_CACHEKEY, allConfigs);

		return allConfigs;
	}
	
	/**
	 * Generates a Base64-encoded image source string or retrieves the image URL.
	 * If binary data is available, it is encoded in Base64 and prefixed for direct use in HTML
	 * image tags.
	 * If no binary data exists but an image URL is available, the URL is returned.
	 *
	 * @return a string containing a Base64-encoded image source or the image URL, or null if
	 *         neither is available
	 */
	public String getBase64Src()
	{
		if (!Util.isEmpty(imageBase64Src))
			return imageBase64Src;

		if (getSSO_LoginButtonImage_ID() > 0)
		{
			MImage image = MImage.get(getSSO_LoginButtonImage_ID());
			if (image.getBinaryData() != null)
				imageBase64Src = "data:image;base64," + Base64.getEncoder().encodeToString(image.getBinaryData());
			else if (!Util.isEmpty(image.getImageURL()))
				imageBase64Src = image.getImageURL();
		}

		return imageBase64Src;
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
