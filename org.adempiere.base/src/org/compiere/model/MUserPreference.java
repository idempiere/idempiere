/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Diego Ruiz - BX Service GmbH                                      *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.CacheMgt;
import org.compiere.util.Env;

/**
 * Extended model class for AD_UserPreference
 */
public class MUserPreference extends X_AD_UserPreference {
    /**
	 * generated serial id
	 */
	private static final long serialVersionUID = 4313636387666521703L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_UserPreference_UU  UUID key
     * @param trxName Transaction
     */
    public MUserPreference(Properties ctx, String AD_UserPreference_UU, String trxName) {
        super(ctx, AD_UserPreference_UU, trxName);
    }

    /**
     * @param ctx
     * @param AD_UserPreference_ID
     * @param trxName
     */
	public MUserPreference(Properties ctx, int AD_UserPreference_ID, String trxName) {
		super(ctx, AD_UserPreference_ID, trxName);

	} //MUserPreference
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MUserPreference(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	} //MUserPreference

	/**
	 * Create and save user preference record
	 * @param AD_User_ID
	 * @param AD_Client_ID
	 * @param trxName
	 * @return new MUserPreference record
	 */
	private static MUserPreference createUserPreferences(int AD_User_ID, int AD_Client_ID, String trxName){
		MUserPreference preferences = new MUserPreference(Env.getCtx(), 0, trxName);
		preferences.setAD_User_ID(AD_User_ID);
		preferences.setAD_Client_ID(AD_Client_ID);
		preferences.saveEx();
		
		return preferences;
	} //createUserPreferences

	/**
	 * Get user preference for user and tenant
	 * @param AD_User_ID
	 * @param AD_Client_ID
	 * @return MUserPreference or null
	 */
	public static MUserPreference getUserPreference(int AD_User_ID, int AD_Client_ID){
		return getUserPreference(AD_User_ID, AD_Client_ID, null);
	}

	/**
	 * Get user preference for user and tenant
	 * @param AD_User_ID
	 * @param AD_Client_ID
	 * @param trxName
	 * @return MUserPreference or null
	 */
	public static MUserPreference getUserPreference(int AD_User_ID, int AD_Client_ID, String trxName){
		Query query = new Query(Env.getCtx(), MUserPreference.Table_Name, "AD_User_ID=? AND AD_Client_ID=?", trxName);
		MUserPreference preferences = query.setParameters(new Object[]{AD_User_ID, AD_Client_ID}).firstOnly();
		
		if(preferences==null){
			preferences = createUserPreferences(AD_User_ID, AD_Client_ID, trxName);
		}
		
		return preferences;
	}
	
	/**
	 * Convert boolean value to "Y" or "N"
	 * @param value
	 * @return "Y" or "N"
	 */
	private static String convert(boolean value) {
		return value ? "Y" : "N";
	}
	
	/**
	 * Get preference value for key
	 * @param key preference key
	 * @return preference value
	 */
	public String getPreference(String key){
		Object value = get_Value(key);
		if( value!=null ){
			if(value instanceof Boolean)
				value = convert((boolean) value);
			
			return value.toString();
		}

		return "";
	}

	/**
	 * Fill environment/session context with values from this user preference record
	 */
	public void fillPreferences(){
		for (int i=0; i < get_ColumnCount(); i++) {
			String colName = get_ColumnName(i);
			if (! (    "AD_Client_ID".equals(colName)
					|| "AD_Org_ID".equals(colName)
					|| "AD_User_ID".equals(colName)
					|| "AD_UserPreference_ID".equals(colName)
					|| "AD_UserPreference_UU".equals(colName)
					|| "Created".equals(colName)
					|| "CreatedBy".equals(colName)
					|| "Updated".equals(colName)
					|| "UpdatedBy".equals(colName)
					|| "IsActive".equals(colName))) {
				Env.setContext(getCtx(), colName, getPreference(colName));
				Env.setContext(getCtx(), "P|" + colName, getPreference(colName));
			}
		}
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (getAD_Org_ID() != 0)
			setAD_Org_ID(0);
		return true;
	}

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (success) {
			fillPreferences();
			if (is_ValueChanged(COLUMNNAME_IsReadOnlySession)) {
				// Cache reset in same thread
				CacheMgt.get().reset(MRole.Table_Name);
				// reset cache to re-read the ReadOnly logic
				CacheMgt.get().reset(MWindow.Table_Name);
				CacheMgt.get().reset(MTab.Table_Name);
				CacheMgt.get().reset(MField.Table_Name);
			}
		}
		return success;
	}

}
