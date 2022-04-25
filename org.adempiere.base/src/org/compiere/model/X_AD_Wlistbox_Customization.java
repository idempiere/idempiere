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

/** Generated Model for AD_Wlistbox_Customization
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_Wlistbox_Customization")
public class X_AD_Wlistbox_Customization extends PO implements I_AD_Wlistbox_Customization, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_Wlistbox_Customization (Properties ctx, int AD_Wlistbox_Customization_ID, String trxName)
    {
      super (ctx, AD_Wlistbox_Customization_ID, trxName);
      /** if (AD_Wlistbox_Customization_ID == 0)
        {
			setAD_User_ID (0);
			setAD_Wlistbox_Customization_ID (0);
			setCustom (null);
			setWlistboxName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_Wlistbox_Customization (Properties ctx, int AD_Wlistbox_Customization_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_Wlistbox_Customization_ID, trxName, virtualColumns);
      /** if (AD_Wlistbox_Customization_ID == 0)
        {
			setAD_User_ID (0);
			setAD_Wlistbox_Customization_ID (0);
			setCustom (null);
			setWlistboxName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Wlistbox_Customization (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_Wlistbox_Customization[")
        .append(get_ID()).append("]");
      return sb.toString();
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
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
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

	/** Set Customization of the Wlistbox.
		@param AD_Wlistbox_Customization_ID Customization of the Wlistbox
	*/
	public void setAD_Wlistbox_Customization_ID (int AD_Wlistbox_Customization_ID)
	{
		if (AD_Wlistbox_Customization_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Wlistbox_Customization_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Wlistbox_Customization_ID, Integer.valueOf(AD_Wlistbox_Customization_ID));
	}

	/** Get Customization of the Wlistbox.
		@return Customization of the Wlistbox	  */
	public int getAD_Wlistbox_Customization_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Wlistbox_Customization_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Wlistbox_Customization_UU.
		@param AD_Wlistbox_Customization_UU AD_Wlistbox_Customization_UU
	*/
	public void setAD_Wlistbox_Customization_UU (String AD_Wlistbox_Customization_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_Wlistbox_Customization_UU, AD_Wlistbox_Customization_UU);
	}

	/** Get AD_Wlistbox_Customization_UU.
		@return AD_Wlistbox_Customization_UU	  */
	public String getAD_Wlistbox_Customization_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_Wlistbox_Customization_UU);
	}

	/** Set Custom.
		@param Custom Custom
	*/
	public void setCustom (String Custom)
	{
		set_Value (COLUMNNAME_Custom, Custom);
	}

	/** Get Custom.
		@return Custom	  */
	public String getCustom()
	{
		return (String)get_Value(COLUMNNAME_Custom);
	}

	/** Set WlistboxName.
		@param WlistboxName WlistboxName
	*/
	public void setWlistboxName (String WlistboxName)
	{
		set_Value (COLUMNNAME_WlistboxName, WlistboxName);
	}

	/** Get WlistboxName.
		@return WlistboxName	  */
	public String getWlistboxName()
	{
		return (String)get_Value(COLUMNNAME_WlistboxName);
	}
}