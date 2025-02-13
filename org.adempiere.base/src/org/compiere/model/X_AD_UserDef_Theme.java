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

/** Generated Model for AD_UserDef_Theme
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="AD_UserDef_Theme")
public class X_AD_UserDef_Theme extends PO implements I_AD_UserDef_Theme, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_AD_UserDef_Theme (Properties ctx, int AD_UserDef_Theme_ID, String trxName)
    {
      super (ctx, AD_UserDef_Theme_ID, trxName);
      /** if (AD_UserDef_Theme_ID == 0)
        {
			setAD_UserDef_Theme_ID (0);
			setName (null);
			setTheme (null);
// @SQL=SELECT get_sysconfig('ZK_THEME',null,0,0) FROM Dual
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Theme (Properties ctx, int AD_UserDef_Theme_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserDef_Theme_ID, trxName, virtualColumns);
      /** if (AD_UserDef_Theme_ID == 0)
        {
			setAD_UserDef_Theme_ID (0);
			setName (null);
			setTheme (null);
// @SQL=SELECT get_sysconfig('ZK_THEME',null,0,0) FROM Dual
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Theme (Properties ctx, String AD_UserDef_Theme_UU, String trxName)
    {
      super (ctx, AD_UserDef_Theme_UU, trxName);
      /** if (AD_UserDef_Theme_UU == null)
        {
			setAD_UserDef_Theme_ID (0);
			setName (null);
			setTheme (null);
// @SQL=SELECT get_sysconfig('ZK_THEME',null,0,0) FROM Dual
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Theme (Properties ctx, String AD_UserDef_Theme_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserDef_Theme_UU, trxName, virtualColumns);
      /** if (AD_UserDef_Theme_UU == null)
        {
			setAD_UserDef_Theme_ID (0);
			setName (null);
			setTheme (null);
// @SQL=SELECT get_sysconfig('ZK_THEME',null,0,0) FROM Dual
        } */
    }

    /** Load Constructor */
    public X_AD_UserDef_Theme (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_UserDef_Theme[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Role getAD_Role() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Role)MTable.get(getCtx(), org.compiere.model.I_AD_Role.Table_ID)
			.getPO(getAD_Role_ID(), get_TrxName());
	}

	/** Set Role.
		@param AD_Role_ID Responsibility Role
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
	public int getAD_Role_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Role_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Theme Customization.
		@param AD_UserDef_Theme_ID Theme Customization
	*/
	public void setAD_UserDef_Theme_ID (int AD_UserDef_Theme_ID)
	{
		if (AD_UserDef_Theme_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Theme_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Theme_ID, Integer.valueOf(AD_UserDef_Theme_ID));
	}

	/** Get Theme Customization.
		@return Theme Customization	  */
	public int getAD_UserDef_Theme_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Theme_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Theme_UU.
		@param AD_UserDef_Theme_UU AD_UserDef_Theme_UU
	*/
	public void setAD_UserDef_Theme_UU (String AD_UserDef_Theme_UU)
	{
		set_Value (COLUMNNAME_AD_UserDef_Theme_UU, AD_UserDef_Theme_UU);
	}

	/** Get AD_UserDef_Theme_UU.
		@return AD_UserDef_Theme_UU	  */
	public String getAD_UserDef_Theme_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Theme_UU);
	}

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
	{
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_ID)
			.getPO(getAD_User_ID(), get_TrxName());
	}

	/** Set User/Contact.
		@param AD_User_ID User within the system - Internal or Business Partner Contact
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
	public int getAD_User_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set Stylesheet.
		@param Stylesheet CSS (Stylesheet) used
	*/
	public void setStylesheet (String Stylesheet)
	{
		set_Value (COLUMNNAME_Stylesheet, Stylesheet);
	}

	/** Get Stylesheet.
		@return CSS (Stylesheet) used
	  */
	public String getStylesheet()
	{
		return (String)get_Value(COLUMNNAME_Stylesheet);
	}

	/** Set Theme.
		@param Theme Theme name
	*/
	public void setTheme (String Theme)
	{
		set_Value (COLUMNNAME_Theme, Theme);
	}

	/** Get Theme.
		@return Theme name
	  */
	public String getTheme()
	{
		return (String)get_Value(COLUMNNAME_Theme);
	}
}