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

/** Generated Model for AD_SchedulerLog
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="AD_SchedulerLog")
public class X_AD_SchedulerLog extends PO implements I_AD_SchedulerLog, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_AD_SchedulerLog (Properties ctx, int AD_SchedulerLog_ID, String trxName)
    {
      super (ctx, AD_SchedulerLog_ID, trxName);
      /** if (AD_SchedulerLog_ID == 0)
        {
			setAD_SchedulerLog_ID (0);
			setAD_Scheduler_ID (0);
			setIsError (false);
        } */
    }

    /** Standard Constructor */
    public X_AD_SchedulerLog (Properties ctx, int AD_SchedulerLog_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_SchedulerLog_ID, trxName, virtualColumns);
      /** if (AD_SchedulerLog_ID == 0)
        {
			setAD_SchedulerLog_ID (0);
			setAD_Scheduler_ID (0);
			setIsError (false);
        } */
    }

    /** Standard Constructor */
    public X_AD_SchedulerLog (Properties ctx, String AD_SchedulerLog_UU, String trxName)
    {
      super (ctx, AD_SchedulerLog_UU, trxName);
      /** if (AD_SchedulerLog_UU == null)
        {
			setAD_SchedulerLog_ID (0);
			setAD_Scheduler_ID (0);
			setIsError (false);
        } */
    }

    /** Standard Constructor */
    public X_AD_SchedulerLog (Properties ctx, String AD_SchedulerLog_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_SchedulerLog_UU, trxName, virtualColumns);
      /** if (AD_SchedulerLog_UU == null)
        {
			setAD_SchedulerLog_ID (0);
			setAD_Scheduler_ID (0);
			setIsError (false);
        } */
    }

    /** Load Constructor */
    public X_AD_SchedulerLog (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_SchedulerLog[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Scheduler Log.
		@param AD_SchedulerLog_ID Result of the execution of the Scheduler
	*/
	public void setAD_SchedulerLog_ID (int AD_SchedulerLog_ID)
	{
		if (AD_SchedulerLog_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_SchedulerLog_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_SchedulerLog_ID, Integer.valueOf(AD_SchedulerLog_ID));
	}

	/** Get Scheduler Log.
		@return Result of the execution of the Scheduler
	  */
	public int getAD_SchedulerLog_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_SchedulerLog_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_SchedulerLog_UU.
		@param AD_SchedulerLog_UU AD_SchedulerLog_UU
	*/
	public void setAD_SchedulerLog_UU (String AD_SchedulerLog_UU)
	{
		set_Value (COLUMNNAME_AD_SchedulerLog_UU, AD_SchedulerLog_UU);
	}

	/** Get AD_SchedulerLog_UU.
		@return AD_SchedulerLog_UU	  */
	public String getAD_SchedulerLog_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_SchedulerLog_UU);
	}

	public org.compiere.model.I_AD_Scheduler getAD_Scheduler() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Scheduler)MTable.get(getCtx(), org.compiere.model.I_AD_Scheduler.Table_ID)
			.getPO(getAD_Scheduler_ID(), get_TrxName());
	}

	/** Set Scheduler.
		@param AD_Scheduler_ID Schedule Processes
	*/
	public void setAD_Scheduler_ID (int AD_Scheduler_ID)
	{
		if (AD_Scheduler_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Scheduler_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Scheduler_ID, Integer.valueOf(AD_Scheduler_ID));
	}

	/** Get Scheduler.
		@return Schedule Processes
	  */
	public int getAD_Scheduler_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Scheduler_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Binary Data.
		@param BinaryData Binary Data
	*/
	public void setBinaryData (byte[] BinaryData)
	{
		set_Value (COLUMNNAME_BinaryData, BinaryData);
	}

	/** Get Binary Data.
		@return Binary Data
	  */
	public byte[] getBinaryData()
	{
		return (byte[])get_Value(COLUMNNAME_BinaryData);
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

	/** Set Error.
		@param IsError An Error occurred in the execution
	*/
	public void setIsError (boolean IsError)
	{
		set_Value (COLUMNNAME_IsError, Boolean.valueOf(IsError));
	}

	/** Get Error.
		@return An Error occurred in the execution
	  */
	public boolean isError()
	{
		Object oo = get_Value(COLUMNNAME_IsError);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Reference.
		@param Reference Reference for this record
	*/
	public void setReference (String Reference)
	{
		set_Value (COLUMNNAME_Reference, Reference);
	}

	/** Get Reference.
		@return Reference for this record
	  */
	public String getReference()
	{
		return (String)get_Value(COLUMNNAME_Reference);
	}

	/** Set Summary.
		@param Summary Textual summary of this request
	*/
	public void setSummary (String Summary)
	{
		set_Value (COLUMNNAME_Summary, Summary);
	}

	/** Get Summary.
		@return Textual summary of this request
	  */
	public String getSummary()
	{
		return (String)get_Value(COLUMNNAME_Summary);
	}

	/** Set Text Message.
		@param TextMsg Text Message
	*/
	public void setTextMsg (String TextMsg)
	{
		set_Value (COLUMNNAME_TextMsg, TextMsg);
	}

	/** Get Text Message.
		@return Text Message
	  */
	public String getTextMsg()
	{
		return (String)get_Value(COLUMNNAME_TextMsg);
	}
}