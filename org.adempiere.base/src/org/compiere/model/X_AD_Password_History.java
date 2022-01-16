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
import java.sql.Timestamp;
import java.util.Properties;

/** Generated Model for AD_Password_History
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_Password_History")
public class X_AD_Password_History extends PO implements I_AD_Password_History, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_Password_History (Properties ctx, int AD_Password_History_ID, String trxName)
    {
      super (ctx, AD_Password_History_ID, trxName);
      /** if (AD_Password_History_ID == 0)
        {
			setAD_Password_History_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_Password_History (Properties ctx, int AD_Password_History_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_Password_History_ID, trxName, virtualColumns);
      /** if (AD_Password_History_ID == 0)
        {
			setAD_Password_History_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_Password_History (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 7 - System - Client - Org 
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
      StringBuilder sb = new StringBuilder ("X_AD_Password_History[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Password History ID.
		@param AD_Password_History_ID Password History ID
	*/
	public void setAD_Password_History_ID (int AD_Password_History_ID)
	{
		if (AD_Password_History_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Password_History_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Password_History_ID, Integer.valueOf(AD_Password_History_ID));
	}

	/** Get Password History ID.
		@return Password History ID	  */
	public int getAD_Password_History_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Password_History_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Password_History_UU.
		@param AD_Password_History_UU AD_Password_History_UU
	*/
	public void setAD_Password_History_UU (String AD_Password_History_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_Password_History_UU, AD_Password_History_UU);
	}

	/** Get AD_Password_History_UU.
		@return AD_Password_History_UU	  */
	public String getAD_Password_History_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_Password_History_UU);
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

	/** Set Date Password Changed.
		@param DatePasswordChanged Date Password Changed
	*/
	public void setDatePasswordChanged (Timestamp DatePasswordChanged)
	{
		set_Value (COLUMNNAME_DatePasswordChanged, DatePasswordChanged);
	}

	/** Get Date Password Changed.
		@return Date Password Changed	  */
	public Timestamp getDatePasswordChanged()
	{
		return (Timestamp)get_Value(COLUMNNAME_DatePasswordChanged);
	}

	/** Set Password.
		@param Password Password of any length (case sensitive)
	*/
	public void setPassword (String Password)
	{
		set_Value (COLUMNNAME_Password, Password);
	}

	/** Get Password.
		@return Password of any length (case sensitive)
	  */
	public String getPassword()
	{
		return (String)get_Value(COLUMNNAME_Password);
	}

	/** Set Salt.
		@param Salt Random data added to improve password hash effectiveness
	*/
	public void setSalt (String Salt)
	{
		set_ValueNoCheck (COLUMNNAME_Salt, Salt);
	}

	/** Get Salt.
		@return Random data added to improve password hash effectiveness
	  */
	public String getSalt()
	{
		return (String)get_Value(COLUMNNAME_Salt);
	}
}