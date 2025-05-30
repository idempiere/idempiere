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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import org.compiere.util.KeyNamePair;

/** Generated Interface for AD_Schedule
 *  @author iDempiere (generated) 
 *  @version Release 12
 */
public interface I_AD_Schedule 
{

    /** TableName=AD_Schedule */
    public static final String Table_Name = "AD_Schedule";

    /** AD_Table_ID=200020 */
    public static final int Table_ID = 200020;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 4 - System 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(4);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within tenant
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
	  */
	public int getAD_Org_ID();

    /** Column name AD_Schedule_ID */
    public static final String COLUMNNAME_AD_Schedule_ID = "AD_Schedule_ID";

	/** Set Schedule	  */
	public void setAD_Schedule_ID (int AD_Schedule_ID);

	/** Get Schedule	  */
	public int getAD_Schedule_ID();

    /** Column name AD_Schedule_UU */
    public static final String COLUMNNAME_AD_Schedule_UU = "AD_Schedule_UU";

	/** Set AD_Schedule_UU	  */
	public void setAD_Schedule_UU (String AD_Schedule_UU);

	/** Get AD_Schedule_UU	  */
	public String getAD_Schedule_UU();

    /** Column name Created */
    public static final String COLUMNNAME_Created = "Created";

	/** Get Created.
	  * Date this record was created
	  */
	public Timestamp getCreated();

    /** Column name CreatedBy */
    public static final String COLUMNNAME_CreatedBy = "CreatedBy";

	/** Get Created By.
	  * User who created this records
	  */
	public int getCreatedBy();

    /** Column name CronPattern */
    public static final String COLUMNNAME_CronPattern = "CronPattern";

	/** Set Cron Scheduling Pattern.
	  * Cron pattern to define when the process should be invoked.
	  */
	public void setCronPattern (String CronPattern);

	/** Get Cron Scheduling Pattern.
	  * Cron pattern to define when the process should be invoked.
	  */
	public String getCronPattern();

    /** Column name Description */
    public static final String COLUMNNAME_Description = "Description";

	/** Set Description.
	  * Optional short description of the record
	  */
	public void setDescription (String Description);

	/** Get Description.
	  * Optional short description of the record
	  */
	public String getDescription();

    /** Column name Frequency */
    public static final String COLUMNNAME_Frequency = "Frequency";

	/** Set Frequency.
	  * Frequency of events
	  */
	public void setFrequency (int Frequency);

	/** Get Frequency.
	  * Frequency of events
	  */
	public int getFrequency();

    /** Column name FrequencyType */
    public static final String COLUMNNAME_FrequencyType = "FrequencyType";

	/** Set Frequency Type.
	  * Frequency of event
	  */
	public void setFrequencyType (String FrequencyType);

	/** Get Frequency Type.
	  * Frequency of event
	  */
	public String getFrequencyType();

    /** Column name IsActive */
    public static final String COLUMNNAME_IsActive = "IsActive";

	/** Set Active.
	  * The record is active in the system
	  */
	public void setIsActive (boolean IsActive);

	/** Get Active.
	  * The record is active in the system
	  */
	public boolean isActive();

    /** Column name IsIgnoreProcessingTime */
    public static final String COLUMNNAME_IsIgnoreProcessingTime = "IsIgnoreProcessingTime";

	/** Set Ignore Processing Time.
	  * Do not include processing time for the DateNextRun calculation
	  */
	public void setIsIgnoreProcessingTime (boolean IsIgnoreProcessingTime);

	/** Get Ignore Processing Time.
	  * Do not include processing time for the DateNextRun calculation
	  */
	public boolean isIgnoreProcessingTime();

    /** Column name IsSystemSchedule */
    public static final String COLUMNNAME_IsSystemSchedule = "IsSystemSchedule";

	/** Set System Schedule.
	  * Schedule Just For System
	  */
	public void setIsSystemSchedule (boolean IsSystemSchedule);

	/** Get System Schedule.
	  * Schedule Just For System
	  */
	public boolean isSystemSchedule();

    /** Column name MonthDay */
    public static final String COLUMNNAME_MonthDay = "MonthDay";

	/** Set Day of the Month.
	  * Day of the month 1 to 28/29/30/31
	  */
	public void setMonthDay (int MonthDay);

	/** Get Day of the Month.
	  * Day of the month 1 to 28/29/30/31
	  */
	public int getMonthDay();

    /** Column name Name */
    public static final String COLUMNNAME_Name = "Name";

	/** Set Name.
	  * Alphanumeric identifier of the entity
	  */
	public void setName (String Name);

	/** Get Name.
	  * Alphanumeric identifier of the entity
	  */
	public String getName();

    /** Column name RunOnlyOnIP */
    public static final String COLUMNNAME_RunOnlyOnIP = "RunOnlyOnIP";

	/** Set Run only on IP	  */
	public void setRunOnlyOnIP (String RunOnlyOnIP);

	/** Get Run only on IP	  */
	public String getRunOnlyOnIP();

    /** Column name ScheduleType */
    public static final String COLUMNNAME_ScheduleType = "ScheduleType";

	/** Set Schedule Type.
	  * Type of schedule
	  */
	public void setScheduleType (String ScheduleType);

	/** Get Schedule Type.
	  * Type of schedule
	  */
	public String getScheduleType();

    /** Column name Updated */
    public static final String COLUMNNAME_Updated = "Updated";

	/** Get Updated.
	  * Date this record was updated
	  */
	public Timestamp getUpdated();

    /** Column name UpdatedBy */
    public static final String COLUMNNAME_UpdatedBy = "UpdatedBy";

	/** Get Updated By.
	  * User who updated this records
	  */
	public int getUpdatedBy();

    /** Column name WeekDay */
    public static final String COLUMNNAME_WeekDay = "WeekDay";

	/** Set Day of the Week.
	  * Day of the Week
	  */
	public void setWeekDay (String WeekDay);

	/** Get Day of the Week.
	  * Day of the Week
	  */
	public String getWeekDay();
}
