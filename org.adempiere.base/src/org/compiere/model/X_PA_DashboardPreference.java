/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for PA_DashboardPreference
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_PA_DashboardPreference extends PO implements I_PA_DashboardPreference, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130626L;

    /** Standard Constructor */
    public X_PA_DashboardPreference (Properties ctx, int PA_DashboardPreference_ID, String trxName)
    {
      super (ctx, PA_DashboardPreference_ID, trxName);
      /** if (PA_DashboardPreference_ID == 0)
        {
			setAD_Role_ID (0);
// 0
			setAD_User_ID (0);
// 0
			setIsCollapsedByDefault (false);
// N
			setIsShowInDashboard (true);
// 'Y'
			setPA_DashboardContent_ID (0);
			setPA_DashboardPreference_ID (0);
        } */
    }

    /** Load Constructor */
    public X_PA_DashboardPreference (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 6 - System - Client 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuffer sb = new StringBuffer ("X_PA_DashboardPreference[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Role getAD_Role() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Role)MTable.get(getCtx(), org.compiere.model.I_AD_Role.Table_Name)
			.getPO(getAD_Role_ID(), get_TrxName());	}

	/** Set Role.
		@param AD_Role_ID 
		Responsibility Role
	  */
	public void setAD_Role_ID (int AD_Role_ID)
	{
		if (AD_Role_ID < 0) 
			set_Value (COLUMNNAME_AD_Role_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Role_ID, Integer.valueOf(AD_Role_ID));
	}

	/** Get Role.
		@return Responsibility Role
	  */
	public int getAD_Role_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Role_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getAD_User_ID(), get_TrxName());	}

	/** Set User/Contact.
		@param AD_User_ID 
		User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1) 
			set_Value (COLUMNNAME_AD_User_ID, null);
		else 
			set_Value (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
	}

	/** Get User/Contact.
		@return User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Column No.
		@param ColumnNo 
		Dashboard content column number
	  */
	public void setColumnNo (int ColumnNo)
	{
		set_Value (COLUMNNAME_ColumnNo, Integer.valueOf(ColumnNo));
	}

	/** Get Column No.
		@return Dashboard content column number
	  */
	public int getColumnNo () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ColumnNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Collapsed By Default.
		@param IsCollapsedByDefault 
		Flag to set the initial state of collapsible field group.
	  */
	public void setIsCollapsedByDefault (boolean IsCollapsedByDefault)
	{
		set_Value (COLUMNNAME_IsCollapsedByDefault, Boolean.valueOf(IsCollapsedByDefault));
	}

	/** Get Collapsed By Default.
		@return Flag to set the initial state of collapsible field group.
	  */
	public boolean isCollapsedByDefault () 
	{
		Object oo = get_Value(COLUMNNAME_IsCollapsedByDefault);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Show in Dashboard.
		@param IsShowInDashboard 
		Show the dashlet in the dashboard
	  */
	public void setIsShowInDashboard (boolean IsShowInDashboard)
	{
		set_Value (COLUMNNAME_IsShowInDashboard, Boolean.valueOf(IsShowInDashboard));
	}

	/** Get Show in Dashboard.
		@return Show the dashlet in the dashboard
	  */
	public boolean isShowInDashboard () 
	{
		Object oo = get_Value(COLUMNNAME_IsShowInDashboard);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Line No.
		@param Line 
		Unique line for this document
	  */
	public void setLine (BigDecimal Line)
	{
		set_Value (COLUMNNAME_Line, Line);
	}

	/** Get Line No.
		@return Unique line for this document
	  */
	public BigDecimal getLine () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Line);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_PA_DashboardContent getPA_DashboardContent() throws RuntimeException
    {
		return (org.compiere.model.I_PA_DashboardContent)MTable.get(getCtx(), org.compiere.model.I_PA_DashboardContent.Table_Name)
			.getPO(getPA_DashboardContent_ID(), get_TrxName());	}

	/** Set Dashboard Content.
		@param PA_DashboardContent_ID Dashboard Content	  */
	public void setPA_DashboardContent_ID (int PA_DashboardContent_ID)
	{
		if (PA_DashboardContent_ID < 1) 
			set_Value (COLUMNNAME_PA_DashboardContent_ID, null);
		else 
			set_Value (COLUMNNAME_PA_DashboardContent_ID, Integer.valueOf(PA_DashboardContent_ID));
	}

	/** Get Dashboard Content.
		@return Dashboard Content	  */
	public int getPA_DashboardContent_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PA_DashboardContent_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Dashboard Preference.
		@param PA_DashboardPreference_ID Dashboard Preference	  */
	public void setPA_DashboardPreference_ID (int PA_DashboardPreference_ID)
	{
		if (PA_DashboardPreference_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_PA_DashboardPreference_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_PA_DashboardPreference_ID, Integer.valueOf(PA_DashboardPreference_ID));
	}

	/** Get Dashboard Preference.
		@return Dashboard Preference	  */
	public int getPA_DashboardPreference_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PA_DashboardPreference_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set PA_DashboardPreference_UU.
		@param PA_DashboardPreference_UU PA_DashboardPreference_UU	  */
	public void setPA_DashboardPreference_UU (String PA_DashboardPreference_UU)
	{
		set_Value (COLUMNNAME_PA_DashboardPreference_UU, PA_DashboardPreference_UU);
	}

	/** Get PA_DashboardPreference_UU.
		@return PA_DashboardPreference_UU	  */
	public String getPA_DashboardPreference_UU () 
	{
		return (String)get_Value(COLUMNNAME_PA_DashboardPreference_UU);
	}
}