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

/** Generated Model for MFA_RegisteredDevice
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="MFA_RegisteredDevice")
public class X_MFA_RegisteredDevice extends PO implements I_MFA_RegisteredDevice, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_MFA_RegisteredDevice (Properties ctx, int MFA_RegisteredDevice_ID, String trxName)
    {
      super (ctx, MFA_RegisteredDevice_ID, trxName);
      /** if (MFA_RegisteredDevice_ID == 0)
        {
			setAD_User_ID (0);
			setMFADeviceIdentifier (null);
			setMFA_RegisteredDevice_ID (0);
        } */
    }

    /** Load Constructor */
    public X_MFA_RegisteredDevice (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_MFA_RegisteredDevice[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
	{
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_ID)
			.getPO(getAD_User_ID(), get_TrxName());
	}

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

	/** Set Expire On.
		@param Expiration 
		Expire On
	  */
	public void setExpiration (Timestamp Expiration)
	{
		set_Value (COLUMNNAME_Expiration, Expiration);
	}

	/** Get Expire On.
		@return Expire On
	  */
	public Timestamp getExpiration () 
	{
		return (Timestamp)get_Value(COLUMNNAME_Expiration);
	}

	/** Set Comment/Help.
		@param Help 
		Comment or Hint
	  */
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp () 
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** Set MFA Device Identifier.
		@param MFADeviceIdentifier 
		Multi-factor Authentication Device Identifier
	  */
	public void setMFADeviceIdentifier (String MFADeviceIdentifier)
	{
		set_Value (COLUMNNAME_MFADeviceIdentifier, MFADeviceIdentifier);
	}

	/** Get MFA Device Identifier.
		@return Multi-factor Authentication Device Identifier
	  */
	public String getMFADeviceIdentifier () 
	{
		return (String)get_Value(COLUMNNAME_MFADeviceIdentifier);
	}

	/** Set MFA Registered Device.
		@param MFA_RegisteredDevice_ID MFA Registered Device	  */
	public void setMFA_RegisteredDevice_ID (int MFA_RegisteredDevice_ID)
	{
		if (MFA_RegisteredDevice_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_MFA_RegisteredDevice_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_MFA_RegisteredDevice_ID, Integer.valueOf(MFA_RegisteredDevice_ID));
	}

	/** Get MFA Registered Device.
		@return MFA Registered Device	  */
	public int getMFA_RegisteredDevice_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MFA_RegisteredDevice_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set MFA_RegisteredDevice_UU.
		@param MFA_RegisteredDevice_UU MFA_RegisteredDevice_UU	  */
	public void setMFA_RegisteredDevice_UU (String MFA_RegisteredDevice_UU)
	{
		set_Value (COLUMNNAME_MFA_RegisteredDevice_UU, MFA_RegisteredDevice_UU);
	}

	/** Get MFA_RegisteredDevice_UU.
		@return MFA_RegisteredDevice_UU	  */
	public String getMFA_RegisteredDevice_UU () 
	{
		return (String)get_Value(COLUMNNAME_MFA_RegisteredDevice_UU);
	}
}