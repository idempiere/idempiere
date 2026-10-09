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

/** Generated Interface for AD_DateRange
 *  @author iDempiere (generated) 
 *  @version Release 14
 */
public interface I_AD_DateRange 
{

    /** TableName=AD_DateRange */
    public static final String Table_Name = "AD_DateRange";

    /** AD_Table_ID=800173 */
    public static final int Table_ID = 800173;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

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

    /** Column name AD_DateRange_ID */
    public static final String COLUMNNAME_AD_DateRange_ID = "AD_DateRange_ID";

	/** Set Date Range	  */
	public void setAD_DateRange_ID (int AD_DateRange_ID);

	/** Get Date Range	  */
	public int getAD_DateRange_ID();

    /** Column name AD_DateRange_UU */
    public static final String COLUMNNAME_AD_DateRange_UU = "AD_DateRange_UU";

	/** Set AD_DateRange_UU	  */
	public void setAD_DateRange_UU (String AD_DateRange_UU);

	/** Get AD_DateRange_UU	  */
	public String getAD_DateRange_UU();

    /** Column name AD_DateRangeGroup_ID */
    public static final String COLUMNNAME_AD_DateRangeGroup_ID = "AD_DateRangeGroup_ID";

	/** Set Date Range Group.
	  * Group of date ranges
	  */
	public void setAD_DateRangeGroup_ID (int AD_DateRangeGroup_ID);

	/** Get Date Range Group.
	  * Group of date ranges
	  */
	public int getAD_DateRangeGroup_ID();

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

    /** Column name DateFrom */
    public static final String COLUMNNAME_DateFrom = "DateFrom";

	/** Set Date From.
	  * Starting date for a range
	  */
	public void setDateFrom (Timestamp DateFrom);

	/** Get Date From.
	  * Starting date for a range
	  */
	public Timestamp getDateFrom();

    /** Column name DateTo */
    public static final String COLUMNNAME_DateTo = "DateTo";

	/** Set Date To.
	  * End date of a date range
	  */
	public void setDateTo (Timestamp DateTo);

	/** Get Date To.
	  * End date of a date range
	  */
	public Timestamp getDateTo();

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

    /** Column name RangeComparisonType */
    public static final String COLUMNNAME_RangeComparisonType = "RangeComparisonType";

	/** Set Range Comparison Type.
	  * Comparison type of the date range, e.g. comparison or standard range.
	  */
	public void setRangeComparisonType (String RangeComparisonType);

	/** Get Range Comparison Type.
	  * Comparison type of the date range, e.g. comparison or standard range.
	  */
	public String getRangeComparisonType();

    /** Column name RangeType */
    public static final String COLUMNNAME_RangeType = "RangeType";

	/** Set Range Type.
	  * Type of the date range, e.g. relative or absolute
	  */
	public void setRangeType (String RangeType);

	/** Get Range Type.
	  * Type of the date range, e.g. relative or absolute
	  */
	public String getRangeType();

    /** Column name SeqNo */
    public static final String COLUMNNAME_SeqNo = "SeqNo";

	/** Set Sequence.
	  * Method of ordering records;
 lowest number comes first
	  */
	public void setSeqNo (int SeqNo);

	/** Get Sequence.
	  * Method of ordering records;
 lowest number comes first
	  */
	public int getSeqNo();

    /** Column name TimeOffset */
    public static final String COLUMNNAME_TimeOffset = "TimeOffset";

	/** Set Time Offset.
	  * Number of time units to offset displayed chart data from the current date.
	  */
	public void setTimeOffset (int TimeOffset);

	/** Get Time Offset.
	  * Number of time units to offset displayed chart data from the current date.
	  */
	public int getTimeOffset();

    /** Column name TimeScope */
    public static final String COLUMNNAME_TimeScope = "TimeScope";

	/** Set Time Scope.
	  * The number of time units to include the chart result.
	  */
	public void setTimeScope (int TimeScope);

	/** Get Time Scope.
	  * The number of time units to include the chart result.
	  */
	public int getTimeScope();

    /** Column name TimeUnit */
    public static final String COLUMNNAME_TimeUnit = "TimeUnit";

	/** Set Time Unit.
	  * The unit of time for grouping chart data.
	  */
	public void setTimeUnit (String TimeUnit);

	/** Get Time Unit.
	  * The unit of time for grouping chart data.
	  */
	public String getTimeUnit();

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
}
