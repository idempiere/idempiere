/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 * Address validation model
 * @author Elaine
 *
 */
public class MAddressValidation extends X_C_AddressValidation {	
	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8194097022422808757L;
	
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger(MAddressValidation.class);
	
	/**
	 * Get default address validation model
	 * @param ctx
	 * @param AD_Client_ID
	 * @param trxName
	 * @return address validation model
	 */
	public static MAddressValidation getDefaultAddressValidation(Properties ctx, int AD_Client_ID, String trxName) 
	{
		MAddressValidation[] validations = getAddressValidation(ctx, AD_Client_ID, trxName);
		if (validations.length == 0)
			return null;
		return validations[0];
	}
	
	/**
	 * Get address validation models
	 * @param ctx
	 * @param AD_Client_ID
	 * @param trxName
	 * @return array of address validation model
	 */
	public static MAddressValidation[] getAddressValidation(Properties ctx, int AD_Client_ID, String trxName) 
	{
		ArrayList<MAddressValidation> list = new ArrayList<MAddressValidation>();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT tp.* ");
		sql.append("FROM C_AddressValidation tp, C_AddressValidationCfg tpc ");
		sql.append("WHERE tp.C_AddressValidationCfg_ID = tpc.C_AddressValidationCfg_ID ");
		sql.append("AND tpc.IsActive = 'Y' ");
		sql.append("AND tp.IsActive = 'Y' ");
		sql.append("AND tp.AD_Client_ID = ? ");
		sql.append("ORDER BY tp.AD_Org_ID DESC, tp.SeqNo");
		//
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), trxName);
			pstmt.setInt(1, AD_Client_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MAddressValidation(ctx, rs, trxName));
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, "find - " + sql, e);
			return null;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}		
		//
		if (list.size() == 0)
			s_log.warning("find - not found - AD_Client_ID=" + AD_Client_ID);
		else
			if (s_log.isLoggable(Level.FINE)) s_log.fine("find - #" + list.size() + " - AD_Client_ID=" + AD_Client_ID);
		MAddressValidation[] retValue = new MAddressValidation[list.size()];
		list.toArray(retValue);
		return retValue;
	}

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_AddressValidation_UU  UUID key
     * @param trxName Transaction
     */
    public MAddressValidation(Properties ctx, String C_AddressValidation_UU, String trxName) {
        super(ctx, C_AddressValidation_UU, trxName);
    }

    /**
     * @param ctx
     * @param C_AddressValidation_ID
     * @param trxName
     */
	public MAddressValidation(Properties ctx, int C_AddressValidation_ID, String trxName) {
		super(ctx, C_AddressValidation_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MAddressValidation(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * @return Java class name of address validation service
	 */
	public String getAddressValidationClass()
	{
		return getC_AddressValidationCfg().getAddressValidationClass();
	}
	
	/**
	 * @return host address of address validation service
	 */
	public String getHostAddress()
	{
		return getC_AddressValidationCfg().getHostAddress();
	}
	
	/**
	 * @return host port of address validation service
	 */
	public int getHostPort()
	{
		return getC_AddressValidationCfg().getHostPort();
	}
	
	/**
	 * @return proxy address of address validation service
	 */
	public String getProxyAddress()
	{
		return getC_AddressValidationCfg().getProxyAddress();
	}
	
	/**
	 * @return proxy port of address validation service
	 */
	public int getProxyPort()
	{
		return getC_AddressValidationCfg().getProxyPort();
	}
	
	/**
	 * @return proxy logon of address validation service
	 */
	public String getProxyLogon()
	{
		return getC_AddressValidationCfg().getProxyLogon();
	}
	
	/**
	 * @return proxy password of of address validation service
	 */
	public String getProxyPassword()
	{
		return getC_AddressValidationCfg().getProxyPassword();
	}
	
	/**
	 * @return service path of address validation service
	 */
	public String getServicePath()
	{
		return getC_AddressValidationCfg().getServicePath();
	}
	
	public String toString()
	{
		return getName();
	}
}
