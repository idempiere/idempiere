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

/** Generated Model for AD_Process_DrillRule
 *  @author iDempiere (generated)
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="AD_Process_DrillRule")
public class X_AD_Process_DrillRule extends PO implements I_AD_Process_DrillRule, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220628L;

    /** Standard Constructor */
    public X_AD_Process_DrillRule (Properties ctx, int AD_Process_DrillRule_ID, String trxName)
    {
      super (ctx, AD_Process_DrillRule_ID, trxName);
      /** if (AD_Process_DrillRule_ID == 0)
        {
			setAD_Process_DrillRule_ID (0);
			setAD_Process_ID (0);
			setAD_Process_Para_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_Process_DrillRule (Properties ctx, int AD_Process_DrillRule_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_Process_DrillRule_ID, trxName, virtualColumns);
      /** if (AD_Process_DrillRule_ID == 0)
        {
			setAD_Process_DrillRule_ID (0);
			setAD_Process_ID (0);
			setAD_Process_Para_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Process_DrillRule (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_Process_DrillRule[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_PrintFormat getAD_PrintFormat() throws RuntimeException
	{
		return (org.compiere.model.I_AD_PrintFormat)MTable.get(getCtx(), org.compiere.model.I_AD_PrintFormat.Table_ID)
			.getPO(getAD_PrintFormat_ID(), get_TrxName());
	}

	/** Set Print Format.
		@param AD_PrintFormat_ID Data Print Format
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
	public int getAD_PrintFormat_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PrintFormat_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Drill Rule.
		@param AD_Process_DrillRule_ID Drill Rule
	*/
	public void setAD_Process_DrillRule_ID (int AD_Process_DrillRule_ID)
	{
		if (AD_Process_DrillRule_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Process_DrillRule_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Process_DrillRule_ID, Integer.valueOf(AD_Process_DrillRule_ID));
	}

	/** Get Drill Rule.
		@return Drill Rule	  */
	public int getAD_Process_DrillRule_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Process_DrillRule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Process_DrillRule_UU.
		@param AD_Process_DrillRule_UU AD_Process_DrillRule_UU
	*/
	public void setAD_Process_DrillRule_UU (String AD_Process_DrillRule_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_Process_DrillRule_UU, AD_Process_DrillRule_UU);
	}

	/** Get AD_Process_DrillRule_UU.
		@return AD_Process_DrillRule_UU	  */
	public String getAD_Process_DrillRule_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_Process_DrillRule_UU);
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

	public org.compiere.model.I_AD_Process_Para getAD_Process_Para() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Process_Para)MTable.get(getCtx(), org.compiere.model.I_AD_Process_Para.Table_ID)
			.getPO(getAD_Process_Para_ID(), get_TrxName());
	}

	/** Set Process Parameter.
		@param AD_Process_Para_ID Process Parameter
	*/
	public void setAD_Process_Para_ID (int AD_Process_Para_ID)
	{
		if (AD_Process_Para_ID < 1)
			set_Value (COLUMNNAME_AD_Process_Para_ID, null);
		else
			set_Value (COLUMNNAME_AD_Process_Para_ID, Integer.valueOf(AD_Process_Para_ID));
	}

	/** Get Process Parameter.
		@return Process Parameter	  */
	public int getAD_Process_Para_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Process_Para_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_ReportView getAD_ReportView() throws RuntimeException
	{
		return (org.compiere.model.I_AD_ReportView)MTable.get(getCtx(), org.compiere.model.I_AD_ReportView.Table_ID)
			.getPO(getAD_ReportView_ID(), get_TrxName());
	}

	/** Set Report View.
		@param AD_ReportView_ID View used to generate this report
	*/
	public void setAD_ReportView_ID (int AD_ReportView_ID)
	{
		if (AD_ReportView_ID < 1)
			set_Value (COLUMNNAME_AD_ReportView_ID, null);
		else
			set_Value (COLUMNNAME_AD_ReportView_ID, Integer.valueOf(AD_ReportView_ID));
	}

	/** Get Report View.
		@return View used to generate this report
	  */
	public int getAD_ReportView_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_ReportView_ID);
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

	/** ShowHelp AD_Reference_ID=50007 */
	public static final int SHOWHELP_AD_Reference_ID=50007;
	/** Ask user (for future use) = A */
	public static final String SHOWHELP_AskUserForFutureUse = "A";
	/** Don&#039;t show help = N */
	public static final String SHOWHELP_DonTShowHelp = "N";
	/** Run silently - Take Defaults = S */
	public static final String SHOWHELP_RunSilently_TakeDefaults = "S";
	/** Show Help = Y */
	public static final String SHOWHELP_ShowHelp = "Y";
	/** Set Show Help.
		@param ShowHelp Show Help
	*/
	public void setShowHelp (String ShowHelp)
	{

		set_Value (COLUMNNAME_ShowHelp, ShowHelp);
	}

	/** Get Show Help.
		@return Show Help	  */
	public String getShowHelp()
	{
		return (String)get_Value(COLUMNNAME_ShowHelp);
	}
}