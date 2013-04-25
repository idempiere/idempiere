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

/** Generated Model for AD_Schedule
 *  @author iDempiere (generated) 
 *  @version Release 1.0b - $Id$ */
public class X_AD_Schedule extends PO implements I_AD_Schedule, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130425L;

    /** Standard Constructor */
    public X_AD_Schedule (Properties ctx, int AD_Schedule_ID, String trxName)
    {
      super (ctx, AD_Schedule_ID, trxName);
      /** if (AD_Schedule_ID == 0)
        {
			setIsIgnoreProcessingTime (false);
// N
			setIsSystemSchedule (false);
// N
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Schedule (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 4 - System 
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
      StringBuffer sb = new StringBuffer ("X_AD_Schedule[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Schedule.
		@param AD_Schedule_ID Schedule	  */
	public void setAD_Schedule_ID (int AD_Schedule_ID)
	{
		if (AD_Schedule_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Schedule_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Schedule_ID, Integer.valueOf(AD_Schedule_ID));
	}

	/** Get Schedule.
		@return Schedule	  */
	public int getAD_Schedule_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Schedule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Schedule_UU.
		@param AD_Schedule_UU AD_Schedule_UU	  */
	public void setAD_Schedule_UU (String AD_Schedule_UU)
	{
		set_Value (COLUMNNAME_AD_Schedule_UU, AD_Schedule_UU);
	}

	/** Get AD_Schedule_UU.
		@return AD_Schedule_UU	  */
	public String getAD_Schedule_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_Schedule_UU);
	}

	/** Set Cron Scheduling Pattern.
		@param CronPattern 
		Cron pattern to define when the process should be invoked.
	  */
	public void setCronPattern (String CronPattern)
	{
		set_Value (COLUMNNAME_CronPattern, CronPattern);
	}

	/** Get Cron Scheduling Pattern.
		@return Cron pattern to define when the process should be invoked.
	  */
	public String getCronPattern () 
	{
		return (String)get_Value(COLUMNNAME_CronPattern);
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

	/** Set Frequency.
		@param Frequency 
		Frequency of events
	  */
	public void setFrequency (int Frequency)
	{
		set_Value (COLUMNNAME_Frequency, Integer.valueOf(Frequency));
	}

	/** Get Frequency.
		@return Frequency of events
	  */
	public int getFrequency () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Frequency);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** FrequencyType AD_Reference_ID=221 */
	public static final int FREQUENCYTYPE_AD_Reference_ID=221;
	/** Minute = M */
	public static final String FREQUENCYTYPE_Minute = "M";
	/** Hour = H */
	public static final String FREQUENCYTYPE_Hour = "H";
	/** Day = D */
	public static final String FREQUENCYTYPE_Day = "D";
	/** Set Frequency Type.
		@param FrequencyType 
		Frequency of event
	  */
	public void setFrequencyType (String FrequencyType)
	{

		set_Value (COLUMNNAME_FrequencyType, FrequencyType);
	}

	/** Get Frequency Type.
		@return Frequency of event
	  */
	public String getFrequencyType () 
	{
		return (String)get_Value(COLUMNNAME_FrequencyType);
	}

	/** Set Ignore Processing Time.
		@param IsIgnoreProcessingTime 
		Do not include processing time for the DateNextRun calculation
	  */
	public void setIsIgnoreProcessingTime (boolean IsIgnoreProcessingTime)
	{
		set_Value (COLUMNNAME_IsIgnoreProcessingTime, Boolean.valueOf(IsIgnoreProcessingTime));
	}

	/** Get Ignore Processing Time.
		@return Do not include processing time for the DateNextRun calculation
	  */
	public boolean isIgnoreProcessingTime () 
	{
		Object oo = get_Value(COLUMNNAME_IsIgnoreProcessingTime);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set System Schedule.
		@param IsSystemSchedule 
		Schedule Just For System
	  */
	public void setIsSystemSchedule (boolean IsSystemSchedule)
	{
		set_Value (COLUMNNAME_IsSystemSchedule, Boolean.valueOf(IsSystemSchedule));
	}

	/** Get System Schedule.
		@return Schedule Just For System
	  */
	public boolean isSystemSchedule () 
	{
		Object oo = get_Value(COLUMNNAME_IsSystemSchedule);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Day of the Month.
		@param MonthDay 
		Day of the month 1 to 28/29/30/31
	  */
	public void setMonthDay (int MonthDay)
	{
		set_Value (COLUMNNAME_MonthDay, Integer.valueOf(MonthDay));
	}

	/** Get Day of the Month.
		@return Day of the month 1 to 28/29/30/31
	  */
	public int getMonthDay () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MonthDay);
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

	/** Set Run only on IP.
		@param RunOnlyOnIP Run only on IP	  */
	public void setRunOnlyOnIP (String RunOnlyOnIP)
	{
		set_Value (COLUMNNAME_RunOnlyOnIP, RunOnlyOnIP);
	}

	/** Get Run only on IP.
		@return Run only on IP	  */
	public String getRunOnlyOnIP () 
	{
		return (String)get_Value(COLUMNNAME_RunOnlyOnIP);
	}

	/** ScheduleType AD_Reference_ID=318 */
	public static final int SCHEDULETYPE_AD_Reference_ID=318;
	/** Frequency = F */
	public static final String SCHEDULETYPE_Frequency = "F";
	/** Week Day = W */
	public static final String SCHEDULETYPE_WeekDay = "W";
	/** Month Day = M */
	public static final String SCHEDULETYPE_MonthDay = "M";
	/** Cron Scheduling Pattern = C */
	public static final String SCHEDULETYPE_CronSchedulingPattern = "C";
	/** Set Schedule Type.
		@param ScheduleType 
		Type of schedule
	  */
	public void setScheduleType (String ScheduleType)
	{

		set_Value (COLUMNNAME_ScheduleType, ScheduleType);
	}

	/** Get Schedule Type.
		@return Type of schedule
	  */
	public String getScheduleType () 
	{
		return (String)get_Value(COLUMNNAME_ScheduleType);
	}

	/** WeekDay AD_Reference_ID=167 */
	public static final int WEEKDAY_AD_Reference_ID=167;
	/** Sunday = 7 */
	public static final String WEEKDAY_Sunday = "7";
	/** Monday = 1 */
	public static final String WEEKDAY_Monday = "1";
	/** Tuesday = 2 */
	public static final String WEEKDAY_Tuesday = "2";
	/** Wednesday = 3 */
	public static final String WEEKDAY_Wednesday = "3";
	/** Thursday = 4 */
	public static final String WEEKDAY_Thursday = "4";
	/** Friday = 5 */
	public static final String WEEKDAY_Friday = "5";
	/** Saturday = 6 */
	public static final String WEEKDAY_Saturday = "6";
	/** Set Day of the Week.
		@param WeekDay 
		Day of the Week
	  */
	public void setWeekDay (String WeekDay)
	{

		set_Value (COLUMNNAME_WeekDay, WeekDay);
	}

	/** Get Day of the Week.
		@return Day of the Week
	  */
	public String getWeekDay () 
	{
		return (String)get_Value(COLUMNNAME_WeekDay);
	}
}