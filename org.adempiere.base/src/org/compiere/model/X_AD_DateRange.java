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


/** Generated Model for AD_DateRange
 *  @author iDempiere (generated) 
 *  @version Release 14 - $Id$ */
@org.adempiere.base.Model(table="AD_DateRange")
public class X_AD_DateRange extends PO implements I_AD_DateRange, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20261009L;

    /** Standard Constructor */
    public X_AD_DateRange (Properties ctx, int AD_DateRange_ID, String trxName)
    {
      super (ctx, AD_DateRange_ID, trxName);
      /** if (AD_DateRange_ID == 0)
        {
			setAD_DateRange_ID (0);
			setName (null);
			setRangeComparisonType (null);
// S
			setRangeType (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_DateRange (Properties ctx, int AD_DateRange_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_DateRange_ID, trxName, virtualColumns);
      /** if (AD_DateRange_ID == 0)
        {
			setAD_DateRange_ID (0);
			setName (null);
			setRangeComparisonType (null);
// S
			setRangeType (null);
        } */
    }

    /** Load Constructor */
    public X_AD_DateRange (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_DateRange[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Date Range.
		@param AD_DateRange_ID Date Range
	*/
	public void setAD_DateRange_ID (int AD_DateRange_ID)
	{
		if (AD_DateRange_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_DateRange_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_DateRange_ID, Integer.valueOf(AD_DateRange_ID));
	}

	/** Get Date Range.
		@return Date Range	  */
	public int getAD_DateRange_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_DateRange_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_DateRange_UU.
		@param AD_DateRange_UU AD_DateRange_UU
	*/
	public void setAD_DateRange_UU (String AD_DateRange_UU)
	{
		set_Value (COLUMNNAME_AD_DateRange_UU, AD_DateRange_UU);
	}

	/** Get AD_DateRange_UU.
		@return AD_DateRange_UU	  */
	public String getAD_DateRange_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_DateRange_UU);
	}

	public I_AD_DateRangeGroup getAD_DateRangeGroup() throws RuntimeException
	{
		return (I_AD_DateRangeGroup)MTable.get(getCtx(), I_AD_DateRangeGroup.Table_ID)
			.getPO(getAD_DateRangeGroup_ID(), get_TrxName());
	}

	/** Set Date Range Group.
		@param AD_DateRangeGroup_ID Group of date ranges
	*/
	public void setAD_DateRangeGroup_ID (int AD_DateRangeGroup_ID)
	{
		if (AD_DateRangeGroup_ID < 1)
			set_Value (COLUMNNAME_AD_DateRangeGroup_ID, null);
		else
			set_Value (COLUMNNAME_AD_DateRangeGroup_ID, Integer.valueOf(AD_DateRangeGroup_ID));
	}

	/** Get Date Range Group.
		@return Group of date ranges
	  */
	public int getAD_DateRangeGroup_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_DateRangeGroup_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Date From.
		@param DateFrom Starting date for a range
	*/
	public void setDateFrom (Timestamp DateFrom)
	{
		set_Value (COLUMNNAME_DateFrom, DateFrom);
	}

	/** Get Date From.
		@return Starting date for a range
	  */
	public Timestamp getDateFrom()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateFrom);
	}

	/** Set Date To.
		@param DateTo End date of a date range
	*/
	public void setDateTo (Timestamp DateTo)
	{
		set_Value (COLUMNNAME_DateTo, DateTo);
	}

	/** Get Date To.
		@return End date of a date range
	  */
	public Timestamp getDateTo()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateTo);
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

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** RangeComparisonType AD_Reference_ID=800103 */
	public static final int RANGECOMPARISONTYPE_AD_Reference_ID=800103;
	/** Comparison Range = C */
	public static final String RANGECOMPARISONTYPE_ComparisonRange = "C";
	/** Standard Range = S */
	public static final String RANGECOMPARISONTYPE_StandardRange = "S";
	/** Standard and Comparison Range = SC */
	public static final String RANGECOMPARISONTYPE_StandardAndComparisonRange = "SC";
	/** Set Range Comparison Type.
		@param RangeComparisonType Comparison type of the date range, e.g. comparison or standard range.
	*/
	public void setRangeComparisonType (String RangeComparisonType)
	{

		set_Value (COLUMNNAME_RangeComparisonType, RangeComparisonType);
	}

	/** Get Range Comparison Type.
		@return Comparison type of the date range, e.g. comparison or standard range.
	  */
	public String getRangeComparisonType()
	{
		return (String)get_Value(COLUMNNAME_RangeComparisonType);
	}

	/** RangeType AD_Reference_ID=800102 */
	public static final int RANGETYPE_AD_Reference_ID=800102;
	/** Absolute = A */
	public static final String RANGETYPE_Absolute = "A";
	/** Previous Period with Offset = O */
	public static final String RANGETYPE_PreviousPeriodWithOffset = "O";
	/** Previous Period = P */
	public static final String RANGETYPE_PreviousPeriod = "P";
	/** Relative = R */
	public static final String RANGETYPE_Relative = "R";
	/** Set Range Type.
		@param RangeType Type of the date range, e.g. relative or absolute
	*/
	public void setRangeType (String RangeType)
	{

		set_Value (COLUMNNAME_RangeType, RangeType);
	}

	/** Get Range Type.
		@return Type of the date range, e.g. relative or absolute
	  */
	public String getRangeType()
	{
		return (String)get_Value(COLUMNNAME_RangeType);
	}

	/** Set Sequence.
		@param SeqNo Method of ordering records; lowest number comes first
	*/
	public void setSeqNo (int SeqNo)
	{
		set_Value (COLUMNNAME_SeqNo, Integer.valueOf(SeqNo));
	}

	/** Get Sequence.
		@return Method of ordering records; lowest number comes first
	  */
	public int getSeqNo()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Time Offset.
		@param TimeOffset Number of time units to offset displayed chart data from the current date.
	*/
	public void setTimeOffset (int TimeOffset)
	{
		set_Value (COLUMNNAME_TimeOffset, Integer.valueOf(TimeOffset));
	}

	/** Get Time Offset.
		@return Number of time units to offset displayed chart data from the current date.
	  */
	public int getTimeOffset()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_TimeOffset);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Time Scope.
		@param TimeScope The number of time units to include the chart result.
	*/
	public void setTimeScope (int TimeScope)
	{
		set_Value (COLUMNNAME_TimeScope, Integer.valueOf(TimeScope));
	}

	/** Get Time Scope.
		@return The number of time units to include the chart result.
	  */
	public int getTimeScope()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_TimeScope);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** TimeUnit AD_Reference_ID=53376 */
	public static final int TIMEUNIT_AD_Reference_ID=53376;
	/** Day = D */
	public static final String TIMEUNIT_Day = "D";
	/** Hour = H */
	public static final String TIMEUNIT_Hour = "H";
	/** Month = M */
	public static final String TIMEUNIT_Month = "M";
	/** Quarter = Q */
	public static final String TIMEUNIT_Quarter = "Q";
	/** Week = W */
	public static final String TIMEUNIT_Week = "W";
	/** Year = Y */
	public static final String TIMEUNIT_Year = "Y";
	/** Set Time Unit.
		@param TimeUnit The unit of time for grouping chart data.
	*/
	public void setTimeUnit (String TimeUnit)
	{

		set_Value (COLUMNNAME_TimeUnit, TimeUnit);
	}

	/** Get Time Unit.
		@return The unit of time for grouping chart data.
	  */
	public String getTimeUnit()
	{
		return (String)get_Value(COLUMNNAME_TimeUnit);
	}
}