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
import org.compiere.util.KeyNamePair;

/** Generated Model for AD_PInstance
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_PInstance")
public class X_AD_PInstance extends PO implements I_AD_PInstance, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_PInstance (Properties ctx, int AD_PInstance_ID, String trxName)
    {
      super (ctx, AD_PInstance_ID, trxName);
      /** if (AD_PInstance_ID == 0)
        {
			setAD_PInstance_ID (0);
			setAD_Process_ID (0);
			setIsProcessing (false);
			setIsRunAsJob (false);
// N
			setRecord_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_PInstance (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_PInstance[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Language getAD_Language() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Language)MTable.get(getCtx(), org.compiere.model.I_AD_Language.Table_ID)
			.getPO(getAD_Language_ID(), get_TrxName());
	}

	/** Set Language ID.
		@param AD_Language_ID Language ID	  */
	public void setAD_Language_ID (int AD_Language_ID)
	{
		if (AD_Language_ID < 1) 
			set_Value (COLUMNNAME_AD_Language_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Language_ID, Integer.valueOf(AD_Language_ID));
	}

	/** Get Language ID.
		@return Language ID	  */
	public int getAD_Language_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Language_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Process Instance.
		@param AD_PInstance_ID 
		Instance of the process
	  */
	public void setAD_PInstance_ID (int AD_PInstance_ID)
	{
		if (AD_PInstance_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_PInstance_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_PInstance_ID, Integer.valueOf(AD_PInstance_ID));
	}

	/** Get Process Instance.
		@return Instance of the process
	  */
	public int getAD_PInstance_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PInstance_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getAD_PInstance_ID()));
    }

	/** Set AD_PInstance_UU.
		@param AD_PInstance_UU AD_PInstance_UU	  */
	public void setAD_PInstance_UU (String AD_PInstance_UU)
	{
		set_Value (COLUMNNAME_AD_PInstance_UU, AD_PInstance_UU);
	}

	/** Get AD_PInstance_UU.
		@return AD_PInstance_UU	  */
	public String getAD_PInstance_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_PInstance_UU);
	}

	public org.compiere.model.I_AD_PrintFormat getAD_PrintFormat() throws RuntimeException
	{
		return (org.compiere.model.I_AD_PrintFormat)MTable.get(getCtx(), org.compiere.model.I_AD_PrintFormat.Table_ID)
			.getPO(getAD_PrintFormat_ID(), get_TrxName());
	}

	/** Set Print Format.
		@param AD_PrintFormat_ID 
		Data Print Format
	  */
	public void setAD_PrintFormat_ID (int AD_PrintFormat_ID)
	{
		if (AD_PrintFormat_ID < 1) 
			set_Value (COLUMNNAME_AD_PrintFormat_ID, null);
		else 
			set_Value (COLUMNNAME_AD_PrintFormat_ID, Integer.valueOf(AD_PrintFormat_ID));
	}

	/** Get Print Format.
		@return Data Print Format
	  */
	public int getAD_PrintFormat_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PrintFormat_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Process getAD_Process() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Process)MTable.get(getCtx(), org.compiere.model.I_AD_Process.Table_ID)
			.getPO(getAD_Process_ID(), get_TrxName());
	}

	/** Set Process.
		@param AD_Process_ID 
		Process or Report
	  */
	public void setAD_Process_ID (int AD_Process_ID)
	{
		if (AD_Process_ID < 1) 
			set_Value (COLUMNNAME_AD_Process_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Process_ID, Integer.valueOf(AD_Process_ID));
	}

	/** Get Process.
		@return Process or Report
	  */
	public int getAD_Process_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Process_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set Error Msg.
		@param ErrorMsg Error Msg	  */
	public void setErrorMsg (String ErrorMsg)
	{
		set_Value (COLUMNNAME_ErrorMsg, ErrorMsg);
	}

	/** Get Error Msg.
		@return Error Msg	  */
	public String getErrorMsg () 
	{
		return (String)get_Value(COLUMNNAME_ErrorMsg);
	}

	/** Set Processing.
		@param IsProcessing Processing	  */
	public void setIsProcessing (boolean IsProcessing)
	{
		set_Value (COLUMNNAME_IsProcessing, Boolean.valueOf(IsProcessing));
	}

	/** Get Processing.
		@return Processing	  */
	public boolean isProcessing () 
	{
		Object oo = get_Value(COLUMNNAME_IsProcessing);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Run as Job.
		@param IsRunAsJob Run as Job	  */
	public void setIsRunAsJob (boolean IsRunAsJob)
	{
		set_Value (COLUMNNAME_IsRunAsJob, Boolean.valueOf(IsRunAsJob));
	}

	/** Get Run as Job.
		@return Run as Job	  */
	public boolean isRunAsJob () 
	{
		Object oo = get_Value(COLUMNNAME_IsRunAsJob);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Summary Level.
		@param IsSummary 
		This is a summary entity
	  */
	public void setIsSummary (boolean IsSummary)
	{
		set_Value (COLUMNNAME_IsSummary, Boolean.valueOf(IsSummary));
	}

	/** Get Summary Level.
		@return This is a summary entity
	  */
	public boolean isSummary () 
	{
		Object oo = get_Value(COLUMNNAME_IsSummary);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** NotificationType AD_Reference_ID=344 */
	public static final int NOTIFICATIONTYPE_AD_Reference_ID=344;
	/** EMail+Notice = B */
	public static final String NOTIFICATIONTYPE_EMailPlusNotice = "B";
	/** EMail = E */
	public static final String NOTIFICATIONTYPE_EMail = "E";
	/** Notice = N */
	public static final String NOTIFICATIONTYPE_Notice = "N";
	/** None = X */
	public static final String NOTIFICATIONTYPE_None = "X";
	/** Set Notification Type.
		@param NotificationType 
		Type of Notifications
	  */
	public void setNotificationType (String NotificationType)
	{

		set_Value (COLUMNNAME_NotificationType, NotificationType);
	}

	/** Get Notification Type.
		@return Type of Notifications
	  */
	public String getNotificationType () 
	{
		return (String)get_Value(COLUMNNAME_NotificationType);
	}

	/** Set Record ID.
		@param Record_ID 
		Direct internal record ID
	  */
	public void setRecord_ID (int Record_ID)
	{
		if (Record_ID < 0) 
			set_ValueNoCheck (COLUMNNAME_Record_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_Record_ID, Integer.valueOf(Record_ID));
	}

	/** Get Record ID.
		@return Direct internal record ID
	  */
	public int getRecord_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Record_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Report Type.
		@param ReportType Report Type	  */
	public void setReportType (String ReportType)
	{
		set_Value (COLUMNNAME_ReportType, ReportType);
	}

	/** Get Report Type.
		@return Report Type	  */
	public String getReportType () 
	{
		return (String)get_Value(COLUMNNAME_ReportType);
	}

	/** Set Result.
		@param Result 
		Result of the action taken
	  */
	public void setResult (int Result)
	{
		set_Value (COLUMNNAME_Result, Integer.valueOf(Result));
	}

	/** Get Result.
		@return Result of the action taken
	  */
	public int getResult () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Result);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}