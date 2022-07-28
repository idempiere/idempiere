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

/** Generated Model for AD_UserPreference
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_UserPreference")
public class X_AD_UserPreference extends PO implements I_AD_UserPreference, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_UserPreference (Properties ctx, int AD_UserPreference_ID, String trxName)
    {
      super (ctx, AD_UserPreference_ID, trxName);
      /** if (AD_UserPreference_ID == 0)
        {
			setAD_User_ID (0);
			setAD_UserPreference_ID (0);
			setViewFindResult (null);
// 0
        } */
    }

    /** Standard Constructor */
    public X_AD_UserPreference (Properties ctx, int AD_UserPreference_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserPreference_ID, trxName, virtualColumns);
      /** if (AD_UserPreference_ID == 0)
        {
			setAD_User_ID (0);
			setAD_UserPreference_ID (0);
			setViewFindResult (null);
// 0
        } */
    }

    /** Load Constructor */
    public X_AD_UserPreference (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 7 - System - Client - Org 
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
      StringBuilder sb = new StringBuilder ("X_AD_UserPreference[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
	{
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_ID)
			.getPO(getAD_User_ID(), get_TrxName());
	}

	/** Set User/Contact.
		@param AD_User_ID User within the system - Internal or Business Partner Contact
	*/
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
	}

	/** Get User/Contact.
		@return User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserPreference_ID.
		@param AD_UserPreference_ID AD_UserPreference_ID
	*/
	public void setAD_UserPreference_ID (int AD_UserPreference_ID)
	{
		if (AD_UserPreference_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserPreference_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserPreference_ID, Integer.valueOf(AD_UserPreference_ID));
	}

	/** Get AD_UserPreference_ID.
		@return AD_UserPreference_ID	  */
	public int getAD_UserPreference_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserPreference_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserPreference_UU.
		@param AD_UserPreference_UU AD_UserPreference_UU
	*/
	public void setAD_UserPreference_UU (String AD_UserPreference_UU)
	{
		set_Value (COLUMNNAME_AD_UserPreference_UU, AD_UserPreference_UU);
	}

	/** Get AD_UserPreference_UU.
		@return AD_UserPreference_UU	  */
	public String getAD_UserPreference_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_UserPreference_UU);
	}

	/** Set Automatic Commit.
		@param AutoCommit Automatic Commit
	*/
	public void setAutoCommit (boolean AutoCommit)
	{
		set_Value (COLUMNNAME_AutoCommit, Boolean.valueOf(AutoCommit));
	}

	/** Get Automatic Commit.
		@return Automatic Commit	  */
	public boolean isAutoCommit()
	{
		Object oo = get_Value(COLUMNNAME_AutoCommit);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Automatic Decimal Places For Amounts.
		@param AutomaticDecimalPlacesForAmoun Automatically insert a decimal point
	*/
	public void setAutomaticDecimalPlacesForAmoun (int AutomaticDecimalPlacesForAmoun)
	{
		set_Value (COLUMNNAME_AutomaticDecimalPlacesForAmoun, Integer.valueOf(AutomaticDecimalPlacesForAmoun));
	}

	/** Get Automatic Decimal Places For Amounts.
		@return Automatically insert a decimal point
	  */
	public int getAutomaticDecimalPlacesForAmoun()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AutomaticDecimalPlacesForAmoun);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Automatic New Record.
		@param AutoNew Automatic New Record
	*/
	public void setAutoNew (boolean AutoNew)
	{
		set_Value (COLUMNNAME_AutoNew, Boolean.valueOf(AutoNew));
	}

	/** Get Automatic New Record.
		@return Automatic New Record	  */
	public boolean isAutoNew()
	{
		Object oo = get_Value(COLUMNNAME_AutoNew);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Threshold.
		@param GridAfterFindThreshold Force grid view when Find panel closes if number of records exceed threshold
	*/
	public void setGridAfterFindThreshold (int GridAfterFindThreshold)
	{
		set_Value (COLUMNNAME_GridAfterFindThreshold, Integer.valueOf(GridAfterFindThreshold));
	}

	/** Get Threshold.
		@return Force grid view when Find panel closes if number of records exceed threshold
	  */
	public int getGridAfterFindThreshold()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_GridAfterFindThreshold);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Detailed Zoom Across.
		@param IsDetailedZoomAcross Detailed Zoom Across
	*/
	public void setIsDetailedZoomAcross (boolean IsDetailedZoomAcross)
	{
		set_Value (COLUMNNAME_IsDetailedZoomAcross, Boolean.valueOf(IsDetailedZoomAcross));
	}

	/** Get Detailed Zoom Across.
		@return Detailed Zoom Across	  */
	public boolean isDetailedZoomAcross()
	{
		Object oo = get_Value(COLUMNNAME_IsDetailedZoomAcross);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Use Similar To.
		@param IsUseSimilarTo Use Similar To
	*/
	public void setIsUseSimilarTo (boolean IsUseSimilarTo)
	{
		set_Value (COLUMNNAME_IsUseSimilarTo, Boolean.valueOf(IsUseSimilarTo));
	}

	/** Get Use Similar To.
		@return Use Similar To	  */
	public boolean isUseSimilarTo()
	{
		Object oo = get_Value(COLUMNNAME_IsUseSimilarTo);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Migration Script Comment.
		@param MigrationScriptComment Migration Script Comment
	*/
	public void setMigrationScriptComment (String MigrationScriptComment)
	{
		set_Value (COLUMNNAME_MigrationScriptComment, MigrationScriptComment);
	}

	/** Get Migration Script Comment.
		@return Migration Script Comment	  */
	public String getMigrationScriptComment()
	{
		return (String)get_Value(COLUMNNAME_MigrationScriptComment);
	}

	/** Set Toggle on Double Click.
		@param ToggleOnDoubleClick Defines if double click in a field on grid mode switch to form view
	*/
	public void setToggleOnDoubleClick (boolean ToggleOnDoubleClick)
	{
		set_Value (COLUMNNAME_ToggleOnDoubleClick, Boolean.valueOf(ToggleOnDoubleClick));
	}

	/** Get Toggle on Double Click.
		@return Defines if double click in a field on grid mode switch to form view
	  */
	public boolean isToggleOnDoubleClick()
	{
		Object oo = get_Value(COLUMNNAME_ToggleOnDoubleClick);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** ViewFindResult AD_Reference_ID=200170 */
	public static final int VIEWFINDRESULT_AD_Reference_ID=200170;
	/** Default = 0 */
	public static final String VIEWFINDRESULT_Default = "0";
	/** Always in Grid View = 1 */
	public static final String VIEWFINDRESULT_AlwaysInGridView = "1";
	/** According to threshold = 2 */
	public static final String VIEWFINDRESULT_AccordingToThreshold = "2";
	/** Set View find result.
		@param ViewFindResult Does the system must switch to grid mode after the Find panel closes
	*/
	public void setViewFindResult (String ViewFindResult)
	{

		set_Value (COLUMNNAME_ViewFindResult, ViewFindResult);
	}

	/** Get View find result.
		@return Does the system must switch to grid mode after the Find panel closes
	  */
	public String getViewFindResult()
	{
		return (String)get_Value(COLUMNNAME_ViewFindResult);
	}
}