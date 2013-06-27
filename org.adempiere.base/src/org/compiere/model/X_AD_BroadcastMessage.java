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

/** Generated Model for AD_BroadcastMessage
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_AD_BroadcastMessage extends PO implements I_AD_BroadcastMessage, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130626L;

    /** Standard Constructor */
    public X_AD_BroadcastMessage (Properties ctx, int AD_BroadcastMessage_ID, String trxName)
    {
      super (ctx, AD_BroadcastMessage_ID, trxName);
      /** if (AD_BroadcastMessage_ID == 0)
        {
			setAD_BroadcastMessage_ID (0);
			setBroadcastFrequency (null);
			setBroadcastMessage (null);
			setBroadcastType (null);
			setTarget (null);
        } */
    }

    /** Load Constructor */
    public X_AD_BroadcastMessage (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_BroadcastMessage[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Broadcast Message.
		@param AD_BroadcastMessage_ID 
		Broadcast Message
	  */
	public void setAD_BroadcastMessage_ID (int AD_BroadcastMessage_ID)
	{
		if (AD_BroadcastMessage_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_BroadcastMessage_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_BroadcastMessage_ID, Integer.valueOf(AD_BroadcastMessage_ID));
	}

	/** Get Broadcast Message.
		@return Broadcast Message
	  */
	public int getAD_BroadcastMessage_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_BroadcastMessage_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_BroadcastMessage_UU.
		@param AD_BroadcastMessage_UU AD_BroadcastMessage_UU	  */
	public void setAD_BroadcastMessage_UU (String AD_BroadcastMessage_UU)
	{
		set_Value (COLUMNNAME_AD_BroadcastMessage_UU, AD_BroadcastMessage_UU);
	}

	/** Get AD_BroadcastMessage_UU.
		@return AD_BroadcastMessage_UU	  */
	public String getAD_BroadcastMessage_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_BroadcastMessage_UU);
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

	/** BroadcastFrequency AD_Reference_ID=200020 */
	public static final int BROADCASTFREQUENCY_AD_Reference_ID=200020;
	/** Just Once = J */
	public static final String BROADCASTFREQUENCY_JustOnce = "J";
	/** Until Expiration = U */
	public static final String BROADCASTFREQUENCY_UntilExpiration = "U";
	/** Set Broadcast Frequency.
		@param BroadcastFrequency 
		How Many Times Message Should be Broadcasted
	  */
	public void setBroadcastFrequency (String BroadcastFrequency)
	{

		set_Value (COLUMNNAME_BroadcastFrequency, BroadcastFrequency);
	}

	/** Get Broadcast Frequency.
		@return How Many Times Message Should be Broadcasted
	  */
	public String getBroadcastFrequency () 
	{
		return (String)get_Value(COLUMNNAME_BroadcastFrequency);
	}

	/** Set Broadcast Message.
		@param BroadcastMessage 
		Broadcast Message
	  */
	public void setBroadcastMessage (String BroadcastMessage)
	{
		set_Value (COLUMNNAME_BroadcastMessage, BroadcastMessage);
	}

	/** Get Broadcast Message.
		@return Broadcast Message
	  */
	public String getBroadcastMessage () 
	{
		return (String)get_Value(COLUMNNAME_BroadcastMessage);
	}

	/** BroadcastType AD_Reference_ID=200021 */
	public static final int BROADCASTTYPE_AD_Reference_ID=200021;
	/** Immediate = I */
	public static final String BROADCASTTYPE_Immediate = "I";
	/** Immediate + Login = IL */
	public static final String BROADCASTTYPE_ImmediatePlusLogin = "IL";
	/** Login = L */
	public static final String BROADCASTTYPE_Login = "L";
	/** Set Broadcast Type.
		@param BroadcastType 
		Type of Broadcast
	  */
	public void setBroadcastType (String BroadcastType)
	{

		set_Value (COLUMNNAME_BroadcastType, BroadcastType);
	}

	/** Get Broadcast Type.
		@return Type of Broadcast
	  */
	public String getBroadcastType () 
	{
		return (String)get_Value(COLUMNNAME_BroadcastType);
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

	/** Set Expired.
		@param Expired Expired	  */
	public void setExpired (boolean Expired)
	{
		set_Value (COLUMNNAME_Expired, Boolean.valueOf(Expired));
	}

	/** Get Expired.
		@return Expired	  */
	public boolean isExpired () 
	{
		Object oo = get_Value(COLUMNNAME_Expired);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Expire Now.
		@param ExpireNow 
		Expire the broadcast message
	  */
	public void setExpireNow (String ExpireNow)
	{
		set_Value (COLUMNNAME_ExpireNow, ExpireNow);
	}

	/** Get Expire Now.
		@return Expire the broadcast message
	  */
	public String getExpireNow () 
	{
		return (String)get_Value(COLUMNNAME_ExpireNow);
	}

	/** Set Published.
		@param IsPublished 
		The Topic is published and can be viewed
	  */
	public void setIsPublished (boolean IsPublished)
	{
		set_Value (COLUMNNAME_IsPublished, Boolean.valueOf(IsPublished));
	}

	/** Get Published.
		@return The Topic is published and can be viewed
	  */
	public boolean isPublished () 
	{
		Object oo = get_Value(COLUMNNAME_IsPublished);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Log Acknowledge.
		@param LogAcknowledge 
		Want to Log the Acknowledgement of Message?
	  */
	public void setLogAcknowledge (boolean LogAcknowledge)
	{
		set_Value (COLUMNNAME_LogAcknowledge, Boolean.valueOf(LogAcknowledge));
	}

	/** Get Log Acknowledge.
		@return Want to Log the Acknowledgement of Message?
	  */
	public boolean isLogAcknowledge () 
	{
		Object oo = get_Value(COLUMNNAME_LogAcknowledge);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Notification Client.
		@param Notification_Client_ID 
		Notification Client
	  */
	public void setNotification_Client_ID (int Notification_Client_ID)
	{
		if (Notification_Client_ID < 1) 
			set_Value (COLUMNNAME_Notification_Client_ID, null);
		else 
			set_Value (COLUMNNAME_Notification_Client_ID, Integer.valueOf(Notification_Client_ID));
	}

	/** Get Notification Client.
		@return Notification Client
	  */
	public int getNotification_Client_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Notification_Client_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Processed.
		@param Processed 
		The document has been processed
	  */
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed () 
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Publish.
		@param Publish 
		Publish Broadcast Message
	  */
	public void setPublish (String Publish)
	{
		set_Value (COLUMNNAME_Publish, Publish);
	}

	/** Get Publish.
		@return Publish Broadcast Message
	  */
	public String getPublish () 
	{
		return (String)get_Value(COLUMNNAME_Publish);
	}

	/** Target AD_Reference_ID=200022 */
	public static final int TARGET_AD_Reference_ID=200022;
	/** Client = C */
	public static final String TARGET_Client = "C";
	/** Everybody = E */
	public static final String TARGET_Everybody = "E";
	/** Role = R */
	public static final String TARGET_Role = "R";
	/** User = U */
	public static final String TARGET_User = "U";
	/** Set Target.
		@param Target 
		Target client
	  */
	public void setTarget (String Target)
	{

		set_Value (COLUMNNAME_Target, Target);
	}

	/** Get Target.
		@return Target client
	  */
	public String getTarget () 
	{
		return (String)get_Value(COLUMNNAME_Target);
	}

	/** Set Test Message.
		@param TestMessage 
		Test broadcast message
	  */
	public void setTestMessage (String TestMessage)
	{
		set_Value (COLUMNNAME_TestMessage, TestMessage);
	}

	/** Get Test Message.
		@return Test broadcast message
	  */
	public String getTestMessage () 
	{
		return (String)get_Value(COLUMNNAME_TestMessage);
	}
}