/***********************************************************************
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
 **********************************************************************/
package org.idempiere.fa.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MAsset;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Callout for MAsset
 */
public class CalloutAsset extends CalloutEngine {
	
	public String location (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue)
	{
		Integer locator = (Integer)value;
		if (locator == null || locator <= 0)
			return "";
		if (isCalloutActive())
			return "";
		//
		//TODO - found missing but MAsset table is asking for this in 3 location fields.
		//
		return "";
	}
	public String locator (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue)
	
	{
		Integer locator = (Integer)value;
		if (locator == null || locator <= 0)
			return "";
		if (isCalloutActive())
			return "";
		//
		//TODO - found missing but MAsset table is asking for this in 3 location fields.
		//
		return "";
	}
	
	public String asset(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (value != null && MAsset.COLUMNNAME_A_Asset_ID.equals(mField.getColumnName()))
		{
			MAsset asset = new MAsset(ctx, (Integer) value, null);
			if (asset != null)
			mTab.setValue(MAsset.COLUMNNAME_M_Product_ID, asset.getM_Product_ID());
		}
		
		return "";
		
	}
		
	/**
	 *	Table_Period.  Used to set the Manual Period Field.  This allows
	 *	the Spread Field to be displayed when there is a code that
	 *  has been setup as Yearly. 
	 *  The string in the Callout field is: 
	 *  <code>com.compiere.custom.CalloutEngine.Table_Period</code> 
	 *
	 *  @param ctx      Context
	 *  @param WindowNo current Window No
	 *  @param mTab     Model Tab
	 *  @param mField   Model Field
	 *  @param value    The new value
	 *  @param oldValue The old value
	 *	@return error message or "" if OK
	 */
	public String Table_Period (Properties ctx, int WindowNo,
			GridTab mTab, GridField mField, Object value, Object oldValue)
	{
		Integer A_Depreciation_Table_Header_ID = (Integer)value;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
			  if (A_Depreciation_Table_Header_ID != null){
				String SQL = "SELECT A_Term "
					+ "FROM A_Depreciation_Table_Header "
					+ "WHERE A_Depreciation_Table_Header_ID='"
					+A_Depreciation_Table_Header_ID
					+"'";
				
				pstmt = DB.prepareStatement(SQL, null);				// arhipac: compatibility
				rs = pstmt.executeQuery();
				if (rs.next())
				{
//					Charges - Set Context
						Env.setContext(ctx, WindowNo, "A_DEPRECIATION_MANUAL_PERIOD", rs.getString("A_Term"));					
						mTab.setValue ("A_DEPRECIATION_MANUAL_PERIOD", rs.getString("A_Term"));
		
				}
			  }
			}
			catch (SQLException e)
			{
				if (log.isLoggable(Level.INFO)) log.info("PeriodType "+ e);
				return e.getLocalizedMessage();
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
			return "";
	}	//	Period Type
	
	/**
	 *	Field_Clear.  Used to set the Manual Period Field.  This allows
	 *	the Spread Field to be displayed when there is a code that
	 *  has been setup as Yearly. 
	 *  The string in the Callout field is: 
	 *  <code>com.compiere.custom.CalloutEngine.Table_Period</code> 
	 *
	 *  @param ctx      Context
	 *  @param WindowNo current Window No
	 *  @param mTab     Model Tab
	 *  @param mField   Model Field
	 *  @param value    The new value
	 *  @param oldValue The old value
	 *	@return error message or "" if OK
	 */
	public String Field_Clear (Properties ctx, int WindowNo,
			GridTab mTab, GridField mField, Object value, Object oldValue)
	{
		Object A_Depreciation_ID = value;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				String SQL = "SELECT DepreciationType "
					+ "FROM A_Depreciation "
					+ "WHERE A_Depreciation_ID="
					+ A_Depreciation_ID;
				
				pstmt = DB.prepareStatement(SQL, null);				// arhipac: compatibility
				rs = pstmt.executeQuery();
				if (rs.next())
				{
//					Charges - Set Context
					String depType = rs.getString("DepreciationType");
					if ("TAB".equals(depType) || "MAN".equals(depType))
					{
						Env.setContext(ctx, WindowNo, "A_DEPRECIATION_MANUAL_PERIOD", "");					
						mTab.setValue ("A_Depreciation_Manual_Period", null);
						mTab.setValue ("A_Depreciation_Manual_Amount", null);
						mTab.setValue ("A_Depreciation_Table_Header_ID", null);
					}
					if (rs.getString("DepreciationType")== "TAB")
					{						
						mTab.setValue ("A_Depreciation_Manual_Amount", null);
					}
					if (rs.getString("DepreciationType")== "MAN")
					{
						mTab.setValue ("A_Depreciation_Table_Header_ID", null);
					}	
				}
			}
			catch (SQLException e)
			{
				if (log.isLoggable(Level.INFO)) log.info("PeriodType "+ e);
				return e.getLocalizedMessage();
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
			return "";
	}	//	Period Type	

}
