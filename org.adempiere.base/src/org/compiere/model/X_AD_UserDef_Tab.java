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

/** Generated Model for AD_UserDef_Tab
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="AD_UserDef_Tab")
public class X_AD_UserDef_Tab extends PO implements I_AD_UserDef_Tab, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220617L;

    /** Standard Constructor */
    public X_AD_UserDef_Tab (Properties ctx, int AD_UserDef_Tab_ID, String trxName)
    {
      super (ctx, AD_UserDef_Tab_ID, trxName);
      /** if (AD_UserDef_Tab_ID == 0)
        {
			setAD_Tab_ID (0);
			setAD_UserDef_Tab_ID (0);
			setAD_UserDef_Win_ID (0);
			setIsMultiRowOnly (false);
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Tab (Properties ctx, int AD_UserDef_Tab_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserDef_Tab_ID, trxName, virtualColumns);
      /** if (AD_UserDef_Tab_ID == 0)
        {
			setAD_Tab_ID (0);
			setAD_UserDef_Tab_ID (0);
			setAD_UserDef_Win_ID (0);
			setIsMultiRowOnly (false);
        } */
    }

    /** Load Constructor */
    public X_AD_UserDef_Tab (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_UserDef_Tab[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Process getAD_Process() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Process)MTable.get(getCtx(), org.compiere.model.I_AD_Process.Table_ID)
			.getPO(getAD_Process_ID(), get_TrxName());
	}

	/** Set Process.
		@param AD_Process_ID Process or Report
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
	public int getAD_Process_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Process_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Tab getAD_Tab() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Tab)MTable.get(getCtx(), org.compiere.model.I_AD_Tab.Table_ID)
			.getPO(getAD_Tab_ID(), get_TrxName());
	}

	/** Set Tab.
		@param AD_Tab_ID Tab within a Window
	*/
	public void setAD_Tab_ID (int AD_Tab_ID)
	{
		if (AD_Tab_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Tab_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Tab_ID, Integer.valueOf(AD_Tab_ID));
	}

	/** Get Tab.
		@return Tab within a Window
	  */
	public int getAD_Tab_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Tab_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getAD_Tab_ID()));
    }

	/** Set User defined Tab.
		@param AD_UserDef_Tab_ID User defined Tab
	*/
	public void setAD_UserDef_Tab_ID (int AD_UserDef_Tab_ID)
	{
		if (AD_UserDef_Tab_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Tab_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Tab_ID, Integer.valueOf(AD_UserDef_Tab_ID));
	}

	/** Get User defined Tab.
		@return User defined Tab	  */
	public int getAD_UserDef_Tab_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Tab_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Tab_UU.
		@param AD_UserDef_Tab_UU AD_UserDef_Tab_UU
	*/
	public void setAD_UserDef_Tab_UU (String AD_UserDef_Tab_UU)
	{
		set_Value (COLUMNNAME_AD_UserDef_Tab_UU, AD_UserDef_Tab_UU);
	}

	/** Get AD_UserDef_Tab_UU.
		@return AD_UserDef_Tab_UU	  */
	public String getAD_UserDef_Tab_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Tab_UU);
	}

	public org.compiere.model.I_AD_UserDef_Win getAD_UserDef_Win() throws RuntimeException
	{
		return (org.compiere.model.I_AD_UserDef_Win)MTable.get(getCtx(), org.compiere.model.I_AD_UserDef_Win.Table_ID)
			.getPO(getAD_UserDef_Win_ID(), get_TrxName());
	}

	/** Set User defined Window.
		@param AD_UserDef_Win_ID User defined Window
	*/
	public void setAD_UserDef_Win_ID (int AD_UserDef_Win_ID)
	{
		if (AD_UserDef_Win_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Win_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Win_ID, Integer.valueOf(AD_UserDef_Win_ID));
	}

	/** Get User defined Window.
		@return User defined Window	  */
	public int getAD_UserDef_Win_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Win_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Delete Confirmation Logic.
		@param DeleteConfirmationLogic Delete Confirmation Logic
	*/
	public void setDeleteConfirmationLogic (String DeleteConfirmationLogic)
	{
		set_Value (COLUMNNAME_DeleteConfirmationLogic, DeleteConfirmationLogic);
	}

	/** Get Delete Confirmation Logic.
		@return Delete Confirmation Logic	  */
	public String getDeleteConfirmationLogic()
	{
		return (String)get_Value(COLUMNNAME_DeleteConfirmationLogic);
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

	/** Set Display Logic.
		@param DisplayLogic If the Field is displayed, the result determines if the field is actually displayed
	*/
	public void setDisplayLogic (String DisplayLogic)
	{
		set_Value (COLUMNNAME_DisplayLogic, DisplayLogic);
	}

	/** Get Display Logic.
		@return If the Field is displayed, the result determines if the field is actually displayed
	  */
	public String getDisplayLogic()
	{
		return (String)get_Value(COLUMNNAME_DisplayLogic);
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

	/** IsAllowAdvancedLookup AD_Reference_ID=319 */
	public static final int ISALLOWADVANCEDLOOKUP_AD_Reference_ID=319;
	/** No = N */
	public static final String ISALLOWADVANCEDLOOKUP_No = "N";
	/** Yes = Y */
	public static final String ISALLOWADVANCEDLOOKUP_Yes = "Y";
	/** Set Allow Advanced Lookup.
		@param IsAllowAdvancedLookup Allow Advanced Lookup
	*/
	public void setIsAllowAdvancedLookup (String IsAllowAdvancedLookup)
	{

		set_Value (COLUMNNAME_IsAllowAdvancedLookup, IsAllowAdvancedLookup);
	}

	/** Get Allow Advanced Lookup.
		@return Allow Advanced Lookup	  */
	public String getIsAllowAdvancedLookup()
	{
		return (String)get_Value(COLUMNNAME_IsAllowAdvancedLookup);
	}

	/** IsHighVolume AD_Reference_ID=319 */
	public static final int ISHIGHVOLUME_AD_Reference_ID=319;
	/** No = N */
	public static final String ISHIGHVOLUME_No = "N";
	/** Yes = Y */
	public static final String ISHIGHVOLUME_Yes = "Y";
	/** Set High Volume.
		@param IsHighVolume Use Search instead of Pick list
	*/
	public void setIsHighVolume (String IsHighVolume)
	{

		set_Value (COLUMNNAME_IsHighVolume, IsHighVolume);
	}

	/** Get High Volume.
		@return Use Search instead of Pick list
	  */
	public String getIsHighVolume()
	{
		return (String)get_Value(COLUMNNAME_IsHighVolume);
	}

	/** IsLookupOnlySelection AD_Reference_ID=319 */
	public static final int ISLOOKUPONLYSELECTION_AD_Reference_ID=319;
	/** No = N */
	public static final String ISLOOKUPONLYSELECTION_No = "N";
	/** Yes = Y */
	public static final String ISLOOKUPONLYSELECTION_Yes = "Y";
	/** Set Lookup Only Selection Columns.
		@param IsLookupOnlySelection When defined to true Lookup panel will display only selection columns. Default to false.
	*/
	public void setIsLookupOnlySelection (String IsLookupOnlySelection)
	{

		set_Value (COLUMNNAME_IsLookupOnlySelection, IsLookupOnlySelection);
	}

	/** Get Lookup Only Selection Columns.
		@return When defined to true Lookup panel will display only selection columns. Default to false.
	  */
	public String getIsLookupOnlySelection()
	{
		return (String)get_Value(COLUMNNAME_IsLookupOnlySelection);
	}

	/** Set Multi Row Only.
		@param IsMultiRowOnly This applies to Multi-Row view only
	*/
	public void setIsMultiRowOnly (boolean IsMultiRowOnly)
	{
		set_Value (COLUMNNAME_IsMultiRowOnly, Boolean.valueOf(IsMultiRowOnly));
	}

	/** Get Multi Row Only.
		@return This applies to Multi-Row view only
	  */
	public boolean isMultiRowOnly()
	{
		Object oo = get_Value(COLUMNNAME_IsMultiRowOnly);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** IsReadOnly AD_Reference_ID=319 */
	public static final int ISREADONLY_AD_Reference_ID=319;
	/** No = N */
	public static final String ISREADONLY_No = "N";
	/** Yes = Y */
	public static final String ISREADONLY_Yes = "Y";
	/** Set Read Only.
		@param IsReadOnly Field is read only
	*/
	public void setIsReadOnly (String IsReadOnly)
	{

		set_Value (COLUMNNAME_IsReadOnly, IsReadOnly);
	}

	/** Get Read Only.
		@return Field is read only
	  */
	public String getIsReadOnly()
	{
		return (String)get_Value(COLUMNNAME_IsReadOnly);
	}

	/** IsSingleRow AD_Reference_ID=319 */
	public static final int ISSINGLEROW_AD_Reference_ID=319;
	/** No = N */
	public static final String ISSINGLEROW_No = "N";
	/** Yes = Y */
	public static final String ISSINGLEROW_Yes = "Y";
	/** Set Single Row Layout.
		@param IsSingleRow Default for toggle between Single- and Multi-Row (Grid) Layout
	*/
	public void setIsSingleRow (String IsSingleRow)
	{

		set_Value (COLUMNNAME_IsSingleRow, IsSingleRow);
	}

	/** Get Single Row Layout.
		@return Default for toggle between Single- and Multi-Row (Grid) Layout
	  */
	public String getIsSingleRow()
	{
		return (String)get_Value(COLUMNNAME_IsSingleRow);
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

	/** Set Sql ORDER BY.
		@param OrderByClause Fully qualified ORDER BY clause
	*/
	public void setOrderByClause (String OrderByClause)
	{
		set_Value (COLUMNNAME_OrderByClause, OrderByClause);
	}

	/** Get Sql ORDER BY.
		@return Fully qualified ORDER BY clause
	  */
	public String getOrderByClause()
	{
		return (String)get_Value(COLUMNNAME_OrderByClause);
	}

	/** Set Read Only Logic.
		@param ReadOnlyLogic Logic to determine if field is read only (applies only when field is read-write)
	*/
	public void setReadOnlyLogic (String ReadOnlyLogic)
	{
		set_Value (COLUMNNAME_ReadOnlyLogic, ReadOnlyLogic);
	}

	/** Get Read Only Logic.
		@return Logic to determine if field is read only (applies only when field is read-write)
	  */
	public String getReadOnlyLogic()
	{
		return (String)get_Value(COLUMNNAME_ReadOnlyLogic);
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

	/** Set Sql WHERE.
		@param WhereClause Fully qualified SQL WHERE clause
	*/
	public void setWhereClause (String WhereClause)
	{
		set_Value (COLUMNNAME_WhereClause, WhereClause);
	}

	/** Get Sql WHERE.
		@return Fully qualified SQL WHERE clause
	  */
	public String getWhereClause()
	{
		return (String)get_Value(COLUMNNAME_WhereClause);
	}
}