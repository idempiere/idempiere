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

/** Generated Model for AD_VerifyMigration
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="AD_VerifyMigration")
public class X_AD_VerifyMigration extends PO implements I_AD_VerifyMigration, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_AD_VerifyMigration (Properties ctx, int AD_VerifyMigration_ID, String trxName)
    {
      super (ctx, AD_VerifyMigration_ID, trxName);
      /** if (AD_VerifyMigration_ID == 0)
        {
			setAD_PInstance_ID (0);
			setAD_Table_ID (0);
			setAD_VerifyMigration_ID (0);
			setIsIgnore (false);
// N
        } */
    }

    /** Standard Constructor */
    public X_AD_VerifyMigration (Properties ctx, int AD_VerifyMigration_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_VerifyMigration_ID, trxName, virtualColumns);
      /** if (AD_VerifyMigration_ID == 0)
        {
			setAD_PInstance_ID (0);
			setAD_Table_ID (0);
			setAD_VerifyMigration_ID (0);
			setIsIgnore (false);
// N
        } */
    }

    /** Standard Constructor */
    public X_AD_VerifyMigration (Properties ctx, String AD_VerifyMigration_UU, String trxName)
    {
      super (ctx, AD_VerifyMigration_UU, trxName);
      /** if (AD_VerifyMigration_UU == null)
        {
			setAD_PInstance_ID (0);
			setAD_Table_ID (0);
			setAD_VerifyMigration_ID (0);
			setIsIgnore (false);
// N
        } */
    }

    /** Standard Constructor */
    public X_AD_VerifyMigration (Properties ctx, String AD_VerifyMigration_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_VerifyMigration_UU, trxName, virtualColumns);
      /** if (AD_VerifyMigration_UU == null)
        {
			setAD_PInstance_ID (0);
			setAD_Table_ID (0);
			setAD_VerifyMigration_ID (0);
			setIsIgnore (false);
// N
        } */
    }

    /** Load Constructor */
    public X_AD_VerifyMigration (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_VerifyMigration[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_ChangeLog getAD_ChangeLog() throws RuntimeException
	{
		return (org.compiere.model.I_AD_ChangeLog)MTable.get(getCtx(), org.compiere.model.I_AD_ChangeLog.Table_ID)
			.getPO(getAD_ChangeLog_ID(), get_TrxName());
	}

	/** Set Change Log.
		@param AD_ChangeLog_ID Log of data changes
	*/
	public void setAD_ChangeLog_ID (int AD_ChangeLog_ID)
	{
		if (AD_ChangeLog_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_ChangeLog_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_ChangeLog_ID, Integer.valueOf(AD_ChangeLog_ID));
	}

	/** Get Change Log.
		@return Log of data changes
	  */
	public int getAD_ChangeLog_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_ChangeLog_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Column getAD_Column() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Column)MTable.get(getCtx(), org.compiere.model.I_AD_Column.Table_ID)
			.getPO(getAD_Column_ID(), get_TrxName());
	}

	/** Set Column.
		@param AD_Column_ID Column in the table
	*/
	public void setAD_Column_ID (int AD_Column_ID)
	{
		if (AD_Column_ID < 1)
			set_Value (COLUMNNAME_AD_Column_ID, null);
		else
			set_Value (COLUMNNAME_AD_Column_ID, Integer.valueOf(AD_Column_ID));
	}

	/** Get Column.
		@return Column in the table
	  */
	public int getAD_Column_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Column_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_PInstance getAD_PInstance() throws RuntimeException
	{
		return (org.compiere.model.I_AD_PInstance)MTable.get(getCtx(), org.compiere.model.I_AD_PInstance.Table_ID)
			.getPO(getAD_PInstance_ID(), get_TrxName());
	}

	/** Set Process Instance.
		@param AD_PInstance_ID Instance of the process
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
	public int getAD_PInstance_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PInstance_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Table)MTable.get(getCtx(), org.compiere.model.I_AD_Table.Table_ID)
			.getPO(getAD_Table_ID(), get_TrxName());
	}

	/** Set Table.
		@param AD_Table_ID Database Table information
	*/
	public void setAD_Table_ID (int AD_Table_ID)
	{
		if (AD_Table_ID < 1)
			set_Value (COLUMNNAME_AD_Table_ID, null);
		else
			set_Value (COLUMNNAME_AD_Table_ID, Integer.valueOf(AD_Table_ID));
	}

	/** Get Table.
		@return Database Table information
	  */
	public int getAD_Table_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Table_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Verify Migration.
		@param AD_VerifyMigration_ID Verify Migration Helper
	*/
	public void setAD_VerifyMigration_ID (int AD_VerifyMigration_ID)
	{
		if (AD_VerifyMigration_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_VerifyMigration_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_VerifyMigration_ID, Integer.valueOf(AD_VerifyMigration_ID));
	}

	/** Get Verify Migration.
		@return Verify Migration Helper
	  */
	public int getAD_VerifyMigration_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_VerifyMigration_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_VerifyMigration_UU.
		@param AD_VerifyMigration_UU AD_VerifyMigration_UU
	*/
	public void setAD_VerifyMigration_UU (String AD_VerifyMigration_UU)
	{
		set_Value (COLUMNNAME_AD_VerifyMigration_UU, AD_VerifyMigration_UU);
	}

	/** Get AD_VerifyMigration_UU.
		@return AD_VerifyMigration_UU	  */
	public String getAD_VerifyMigration_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_VerifyMigration_UU);
	}

	/** Set Current Value.
		@param CurrentValue Current Value
	*/
	public void setCurrentValue (String CurrentValue)
	{
		set_ValueNoCheck (COLUMNNAME_CurrentValue, CurrentValue);
	}

	/** Get Current Value.
		@return Current Value	  */
	public String getCurrentValue()
	{
		return (String)get_Value(COLUMNNAME_CurrentValue);
	}

	/** Set Expected Value.
		@param ExpectedValue Expected Value
	*/
	public void setExpectedValue (String ExpectedValue)
	{
		set_ValueNoCheck (COLUMNNAME_ExpectedValue, ExpectedValue);
	}

	/** Get Expected Value.
		@return Expected Value	  */
	public String getExpectedValue()
	{
		return (String)get_Value(COLUMNNAME_ExpectedValue);
	}

	/** Set Comment/Help.
		@param Help Comment or Hint
	*/
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp()
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** Set Ignore.
		@param IsIgnore Ignore
	*/
	public void setIsIgnore (boolean IsIgnore)
	{
		set_Value (COLUMNNAME_IsIgnore, Boolean.valueOf(IsIgnore));
	}

	/** Get Ignore.
		@return Ignore	  */
	public boolean isIgnore()
	{
		Object oo = get_Value(COLUMNNAME_IsIgnore);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Note.
		@param ManualNote Note for manual entry
	*/
	public void setManualNote (String ManualNote)
	{
		set_Value (COLUMNNAME_ManualNote, ManualNote);
	}

	/** Get Note.
		@return Note for manual entry
	  */
	public String getManualNote()
	{
		return (String)get_Value(COLUMNNAME_ManualNote);
	}

	/** PriorityRule AD_Reference_ID=154 */
	public static final int PRIORITYRULE_AD_Reference_ID=154;
	/** Urgent = 1 */
	public static final String PRIORITYRULE_Urgent = "1";
	/** High = 3 */
	public static final String PRIORITYRULE_High = "3";
	/** Medium = 5 */
	public static final String PRIORITYRULE_Medium = "5";
	/** Low = 7 */
	public static final String PRIORITYRULE_Low = "7";
	/** Minor = 9 */
	public static final String PRIORITYRULE_Minor = "9";
	/** Set Priority.
		@param PriorityRule Priority of a document
	*/
	public void setPriorityRule (String PriorityRule)
	{

		set_ValueNoCheck (COLUMNNAME_PriorityRule, PriorityRule);
	}

	/** Get Priority.
		@return Priority of a document
	  */
	public String getPriorityRule()
	{
		return (String)get_Value(COLUMNNAME_PriorityRule);
	}

	/** Set Record ID.
		@param Record_ID Direct internal record ID
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
	public int getRecord_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Record_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
}