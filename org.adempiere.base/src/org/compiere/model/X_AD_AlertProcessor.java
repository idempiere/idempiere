/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2007 ComPiere, Inc. All Rights Reserved.                *
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
import org.compiere.util.KeyNamePair;

/** Generated Model for AD_AlertProcessor
 *  @author Adempiere (generated) 
 *  @version Release 3.6.0LTS - $Id$ */
public class X_AD_AlertProcessor extends PO implements I_AD_AlertProcessor, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20120920L;

    /** Standard Constructor */
    public X_AD_AlertProcessor (Properties ctx, int AD_AlertProcessor_ID, String trxName)
    {
      super (ctx, AD_AlertProcessor_ID, trxName);
      /** if (AD_AlertProcessor_ID == 0)
        {
			setAD_AlertProcessor_ID (0);
			setKeepLogDays (0);
// 7
			setName (null);
			setSupervisor_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_AlertProcessor (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_AlertProcessor[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Alert Processor.
		@param AD_AlertProcessor_ID 
		Alert Processor/Server Parameter
	  */
	public void setAD_AlertProcessor_ID (int AD_AlertProcessor_ID)
	{
		if (AD_AlertProcessor_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_AlertProcessor_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_AlertProcessor_ID, Integer.valueOf(AD_AlertProcessor_ID));
	}

	/** Get Alert Processor.
		@return Alert Processor/Server Parameter
	  */
	public int getAD_AlertProcessor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AlertProcessor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_AlertProcessor_UU.
		@param AD_AlertProcessor_UU AD_AlertProcessor_UU	  */
	public void setAD_AlertProcessor_UU (String AD_AlertProcessor_UU)
	{
		set_Value (COLUMNNAME_AD_AlertProcessor_UU, AD_AlertProcessor_UU);
	}

	/** Get AD_AlertProcessor_UU.
		@return AD_AlertProcessor_UU	  */
	public String getAD_AlertProcessor_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_AlertProcessor_UU);
	}

	public org.compiere.model.I_AD_Schedule getAD_Schedule() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Schedule)MTable.get(getCtx(), org.compiere.model.I_AD_Schedule.Table_Name)
			.getPO(getAD_Schedule_ID(), get_TrxName());	}

	/** Set AD_Schedule_ID.
		@param AD_Schedule_ID AD_Schedule_ID	  */
	public void setAD_Schedule_ID (int AD_Schedule_ID)
	{
		if (AD_Schedule_ID < 1) 
			set_Value (COLUMNNAME_AD_Schedule_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Schedule_ID, Integer.valueOf(AD_Schedule_ID));
	}

	/** Get AD_Schedule_ID.
		@return AD_Schedule_ID	  */
	public int getAD_Schedule_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Schedule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Date last run.
		@param DateLastRun 
		Date the process was last run.
	  */
	public void setDateLastRun (Timestamp DateLastRun)
	{
		set_Value (COLUMNNAME_DateLastRun, DateLastRun);
	}

	/** Get Date last run.
		@return Date the process was last run.
	  */
	public Timestamp getDateLastRun () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DateLastRun);
	}

	/** Set Date next run.
		@param DateNextRun 
		Date the process will run next
	  */
	public void setDateNextRun (Timestamp DateNextRun)
	{
		set_Value (COLUMNNAME_DateNextRun, DateNextRun);
	}

	/** Get Date next run.
		@return Date the process will run next
	  */
	public Timestamp getDateNextRun () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DateNextRun);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Days to keep Log.
		@param KeepLogDays 
		Number of days to keep the log entries
	  */
	public void setKeepLogDays (int KeepLogDays)
	{
		set_Value (COLUMNNAME_KeepLogDays, Integer.valueOf(KeepLogDays));
	}

	/** Get Days to keep Log.
		@return Number of days to keep the log entries
	  */
	public int getKeepLogDays () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_KeepLogDays);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Process Now.
		@param Processing Process Now	  */
	public void setProcessing (boolean Processing)
	{
		set_Value (COLUMNNAME_Processing, Boolean.valueOf(Processing));
	}

	/** Get Process Now.
		@return Process Now	  */
	public boolean isProcessing () 
	{
		Object oo = get_Value(COLUMNNAME_Processing);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	public org.compiere.model.I_AD_User getSupervisor() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getSupervisor_ID(), get_TrxName());	}

	/** Set Supervisor.
		@param Supervisor_ID 
		Supervisor for this user/organization - used for escalation and approval
	  */
	public void setSupervisor_ID (int Supervisor_ID)
	{
		if (Supervisor_ID < 1) 
			set_Value (COLUMNNAME_Supervisor_ID, null);
		else 
			set_Value (COLUMNNAME_Supervisor_ID, Integer.valueOf(Supervisor_ID));
	}

	/** Get Supervisor.
		@return Supervisor for this user/organization - used for escalation and approval
	  */
	public int getSupervisor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Supervisor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}