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
import org.compiere.util.CacheMgt;
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
	
	/**
	 * UUID:MSSOPrincipalConfig
	 */
	private static final CCache<String, MSSOPrincipalConfig>	s_SSOPrincipalConfigCache		= new CCache<>(MSSOPrincipalConfig.Table_Name, 10, 0);

	/**
	 * AD_Client_ID:List<MSSOPrincipalConfig>
	 */
	private static final CCache<Integer, List<MSSOPrincipalConfig>> s_SSOPrincipalConfigCacheByClient	
		= new CCache<>(MSSOPrincipalConfig.class.getSimpleName() + "ByClient", 10, 0);
	
	private String								imageBase64Src					= null;

	/**
	 * Ending for well-known openid configuration URL
	 */
	public static final String WELL_KNOWN_OPENID_CONFIGURATION_SUFFIX = "/.well-known/openid-configuration";

	/**
	 * @param ctx
	 * @param SSO_PrincipalConfig_ID
	 * @param trxName
	 */
	public MSSOPrincipalConfig(Properties ctx, int SSO_PrincipalConfig_ID, String trxName)
	{
		super(ctx, SSO_PrincipalConfig_ID, trxName);
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

	@Deprecated
	public static MSSOPrincipalConfig getDefaultSSOPrincipalConfig()
	{
		return getDefaultSSOPrincipalConfig(0);
	}

	/**
	 * Get default SSO Principal Configuration by client
	 * @param AD_Client_ID
	 * @return
	 */
	public static MSSOPrincipalConfig getDefaultSSOPrincipalConfig(int AD_Client_ID)
	{
		var list = getSSOPrincipalConfigByClient(AD_Client_ID);
		for (var config : list)
		{
			if (config.isDefault())
				return config;
		}
		
		return null;
	}

	/**
	 * Get SSO Principal Configuration by UUID
	 * @param uuID
	 * @return
	 */
	public static MSSOPrincipalConfig getSSOPrincipalConfig(String uuID)
	{
		if (Util.isEmpty(uuID))
			return null;

		MSSOPrincipalConfig cachedConfig = s_SSOPrincipalConfigCache.get(uuID);
		if (cachedConfig != null)
			return cachedConfig;

		cachedConfig = new Query(Env.getCtx(), Table_Name, COLUMNNAME_SSO_PrincipalConfig_UU + " = ?", null)
								.setOnlyActiveRecords(true)
								.setParameters(uuID)
								.firstOnly();

		if (cachedConfig != null)
			s_SSOPrincipalConfigCache.put(uuID, cachedConfig);

		return cachedConfig;
	}

	@Deprecated
	public static List<MSSOPrincipalConfig> getAllSSOPrincipalConfig()
	{
		return getSSOPrincipalConfigByClient(0);
	}

	/**
	 * Get SSO Principal Configurations by client
	 * @param AD_Client_ID
	 * @return list of SSO Principal Configurations
	 */
	public static List<MSSOPrincipalConfig> getSSOPrincipalConfigByClient(int AD_Client_ID)
	{
		List<MSSOPrincipalConfig> list = s_SSOPrincipalConfigCacheByClient.get(AD_Client_ID);
		if (list != null)
			return list;
		list = new Query(Env.getCtx(), Table_Name, COLUMNNAME_AD_Client_ID + " = ?", null)
				.setOnlyActiveRecords(true)
				.setParameters(AD_Client_ID)
				.list();
		s_SSOPrincipalConfigCacheByClient.put(AD_Client_ID, list);
		return list;
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
			MImage image = (MImage) getSSO_LoginButtonImage();
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

			if (isDefault() && getDefaultSSOPrincipalConfig(getAD_Client_ID()) != null)
			{
				throw new AdempiereException("There can be only one default SSO Principal Configuration");
			}

			if (newRecord && getDefaultSSOPrincipalConfig(getAD_Client_ID()) == null)
			{
				setIsDefault(true);
			}
			
		}

		// Validate well-known configuration url for OIDC provider
		if (newRecord 
			|| is_ValueChanged(COLUMNNAME_SSO_ApplicationDiscoveryURI)
			|| is_ValueChanged(COLUMNNAME_SSO_Provider))
		{
			if ("OIDC".equals(getSSO_Provider()))
			{
				String discoveryURI = getSSO_ApplicationDiscoveryURI();
				if (discoveryURI == null || !discoveryURI.trim().endsWith(WELL_KNOWN_OPENID_CONFIGURATION_SUFFIX)) 
				{
					log.saveError("DiscoveryURIMustEndWith", "");
					return false;
				}			
			}
		}
		return super.beforeSave(newRecord);
	}

	@Override
	protected boolean afterDelete(boolean success) {
		if (success) {
			CacheMgt.scheduleCacheReset(MSSOPrincipalConfig.Table_Name, getSSO_PrincipalConfig_UU(), false, get_TrxName());
			CacheMgt.scheduleCacheReset(s_SSOPrincipalConfigCacheByClient.getName(), getAD_Client_ID(), false, get_TrxName());
		}
		return super.afterDelete(success);
	}

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (success) {
			CacheMgt.scheduleCacheReset(MSSOPrincipalConfig.Table_Name, getSSO_PrincipalConfig_UU(), newRecord, get_TrxName());
			CacheMgt.scheduleCacheReset(s_SSOPrincipalConfigCacheByClient.getName(), getAD_Client_ID(), false, get_TrxName());
		}
		return super.afterSave(newRecord, success);
	}
}
