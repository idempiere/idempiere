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

import java.sql.ResultSet;
import java.util.Properties;

/** Generated Model for PA_DashboardContent_Access
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_PA_DashboardContent_Access extends PO implements I_PA_DashboardContent_Access, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131004L;

    /** Standard Constructor */
    public X_PA_DashboardContent_Access (Properties ctx, int PA_DashboardContent_Access_ID, String trxName)
    {
      super (ctx, PA_DashboardContent_Access_ID, trxName);
      /** if (PA_DashboardContent_Access_ID == 0)
        {
			setPA_DashboardContent_Access_ID (0);
        } */
    }

    /** Load Constructor */
    public X_PA_DashboardContent_Access (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org 
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
      StringBuffer sb = new StringBuffer ("X_PA_DashboardContent_Access[")
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
			set_ValueNoCheck (COLUMNNAME_AD_Role_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Role_ID, Integer.valueOf(AD_Role_ID));
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
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
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

	/** Set PA_DashboardContent_Access_ID.
		@param PA_DashboardContent_Access_ID PA_DashboardContent_Access_ID	  */
	public void setPA_DashboardContent_Access_ID (int PA_DashboardContent_Access_ID)
	{
		if (PA_DashboardContent_Access_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_PA_DashboardContent_Access_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_PA_DashboardContent_Access_ID, Integer.valueOf(PA_DashboardContent_Access_ID));
	}

	/** Get PA_DashboardContent_Access_ID.
		@return PA_DashboardContent_Access_ID	  */
	public int getPA_DashboardContent_Access_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PA_DashboardContent_Access_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set PA_DashboardContent_Access_UU.
		@param PA_DashboardContent_Access_UU PA_DashboardContent_Access_UU	  */
	public void setPA_DashboardContent_Access_UU (String PA_DashboardContent_Access_UU)
	{
		set_ValueNoCheck (COLUMNNAME_PA_DashboardContent_Access_UU, PA_DashboardContent_Access_UU);
	}

	/** Get PA_DashboardContent_Access_UU.
		@return PA_DashboardContent_Access_UU	  */
	public String getPA_DashboardContent_Access_UU () 
	{
		return (String)get_Value(COLUMNNAME_PA_DashboardContent_Access_UU);
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
			set_ValueNoCheck (COLUMNNAME_PA_DashboardContent_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_PA_DashboardContent_ID, Integer.valueOf(PA_DashboardContent_ID));
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
}