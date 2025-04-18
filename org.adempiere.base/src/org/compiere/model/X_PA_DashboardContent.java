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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

/** Generated Model for PA_DashboardContent
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="PA_DashboardContent")
public class X_PA_DashboardContent extends PO implements I_PA_DashboardContent, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_PA_DashboardContent (Properties ctx, int PA_DashboardContent_ID, String trxName)
    {
      super (ctx, PA_DashboardContent_ID, trxName);
      /** if (PA_DashboardContent_ID == 0)
        {
			setIsCollapsedByDefault (false);
// N
			setIsCollapsible (true);
// Y
			setIsEmbedReportContent (false);
// N
			setIsMaximizable (true);
// Y
			setIsShowInDashboard (true);
// 'Y'
			setIsShowTitle (true);
// Y
			setName (null);
			setPA_DashboardContent_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_PA_DashboardContent (Properties ctx, int PA_DashboardContent_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, PA_DashboardContent_ID, trxName, virtualColumns);
      /** if (PA_DashboardContent_ID == 0)
        {
			setIsCollapsedByDefault (false);
// N
			setIsCollapsible (true);
// Y
			setIsEmbedReportContent (false);
// N
			setIsMaximizable (true);
// Y
			setIsShowInDashboard (true);
// 'Y'
			setIsShowTitle (true);
// Y
			setName (null);
			setPA_DashboardContent_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_PA_DashboardContent (Properties ctx, String PA_DashboardContent_UU, String trxName)
    {
      super (ctx, PA_DashboardContent_UU, trxName);
      /** if (PA_DashboardContent_UU == null)
        {
			setIsCollapsedByDefault (false);
// N
			setIsCollapsible (true);
// Y
			setIsEmbedReportContent (false);
// N
			setIsMaximizable (true);
// Y
			setIsShowInDashboard (true);
// 'Y'
			setIsShowTitle (true);
// Y
			setName (null);
			setPA_DashboardContent_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_PA_DashboardContent (Properties ctx, String PA_DashboardContent_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, PA_DashboardContent_UU, trxName, virtualColumns);
      /** if (PA_DashboardContent_UU == null)
        {
			setIsCollapsedByDefault (false);
// N
			setIsCollapsible (true);
// Y
			setIsEmbedReportContent (false);
// N
			setIsMaximizable (true);
// Y
			setIsShowInDashboard (true);
// 'Y'
			setIsShowTitle (true);
// Y
			setName (null);
			setPA_DashboardContent_ID (0);
        } */
    }

    /** Load Constructor */
    public X_PA_DashboardContent (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_PA_DashboardContent[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Chart getAD_Chart() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Chart)MTable.get(getCtx(), org.compiere.model.I_AD_Chart.Table_ID)
			.getPO(getAD_Chart_ID(), get_TrxName());
	}

	/** Set Chart.
		@param AD_Chart_ID Chart
	*/
	public void setAD_Chart_ID (int AD_Chart_ID)
	{
		if (AD_Chart_ID < 1)
			set_Value (COLUMNNAME_AD_Chart_ID, null);
		else
			set_Value (COLUMNNAME_AD_Chart_ID, Integer.valueOf(AD_Chart_ID));
	}

	/** Get Chart.
		@return Chart	  */
	public int getAD_Chart_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Chart_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	public org.compiere.model.I_AD_Role getAD_Role() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Role)MTable.get(getCtx(), org.compiere.model.I_AD_Role.Table_ID)
			.getPO(getAD_Role_ID(), get_TrxName());
	}

	/** Set Role.
		@param AD_Role_ID Responsibility Role
	*/
	public void setAD_Role_ID (int AD_Role_ID)
	{
		if (AD_Role_ID < 0)
			set_Value (COLUMNNAME_AD_Role_ID, null);
		else
			set_Value (COLUMNNAME_AD_Role_ID, Integer.valueOf(AD_Role_ID));
	}

	/** Get Role.
		@return Responsibility Role
	  */
	public int getAD_Role_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Role_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_StatusLine getAD_StatusLine() throws RuntimeException
	{
		return (org.compiere.model.I_AD_StatusLine)MTable.get(getCtx(), org.compiere.model.I_AD_StatusLine.Table_ID)
			.getPO(getAD_StatusLine_ID(), get_TrxName());
	}

	/** Set Status Line.
		@param AD_StatusLine_ID Status Line
	*/
	public void setAD_StatusLine_ID (int AD_StatusLine_ID)
	{
		if (AD_StatusLine_ID < 1)
			set_Value (COLUMNNAME_AD_StatusLine_ID, null);
		else
			set_Value (COLUMNNAME_AD_StatusLine_ID, Integer.valueOf(AD_StatusLine_ID));
	}

	/** Get Status Line.
		@return Status Line	  */
	public int getAD_StatusLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_StatusLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
			set_Value (COLUMNNAME_AD_User_ID, null);
		else
			set_Value (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
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

	public org.compiere.model.I_AD_Window getAD_Window() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Window)MTable.get(getCtx(), org.compiere.model.I_AD_Window.Table_ID)
			.getPO(getAD_Window_ID(), get_TrxName());
	}

	/** Set Window.
		@param AD_Window_ID Data entry or display window
	*/
	public void setAD_Window_ID (int AD_Window_ID)
	{
		if (AD_Window_ID < 1)
			set_Value (COLUMNNAME_AD_Window_ID, null);
		else
			set_Value (COLUMNNAME_AD_Window_ID, Integer.valueOf(AD_Window_ID));
	}

	/** Get Window.
		@return Data entry or display window
	  */
	public int getAD_Window_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Window_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Column No.
		@param ColumnNo Dashboard content column number
	*/
	public void setColumnNo (int ColumnNo)
	{
		set_Value (COLUMNNAME_ColumnNo, Integer.valueOf(ColumnNo));
	}

	/** Get Column No.
		@return Dashboard content column number
	  */
	public int getColumnNo()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ColumnNo);
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

	/** GoalDisplay AD_Reference_ID=53316 */
	public static final int GOALDISPLAY_AD_Reference_ID=53316;
	/** Chart = C */
	public static final String GOALDISPLAY_Chart = "C";
	/** Gauge Indicator = G */
	public static final String GOALDISPLAY_GaugeIndicator = "G";
	/** HTML Table = T */
	public static final String GOALDISPLAY_HTMLTable = "T";
	/** Set Goal Display.
		@param GoalDisplay Type of goal display on dashboard
	*/
	public void setGoalDisplay (String GoalDisplay)
	{

		set_Value (COLUMNNAME_GoalDisplay, GoalDisplay);
	}

	/** Get Goal Display.
		@return Type of goal display on dashboard
	  */
	public String getGoalDisplay()
	{
		return (String)get_Value(COLUMNNAME_GoalDisplay);
	}

	/** Set HTML.
		@param HTML HTML
	*/
	public void setHTML (String HTML)
	{
		set_Value (COLUMNNAME_HTML, HTML);
	}

	/** Get HTML.
		@return HTML	  */
	public String getHTML()
	{
		return (String)get_Value(COLUMNNAME_HTML);
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

	/** Set Collapsed By Default.
		@param IsCollapsedByDefault Flag to set the initial state of collapsible field group.
	*/
	public void setIsCollapsedByDefault (boolean IsCollapsedByDefault)
	{
		set_Value (COLUMNNAME_IsCollapsedByDefault, Boolean.valueOf(IsCollapsedByDefault));
	}

	/** Get Collapsed By Default.
		@return Flag to set the initial state of collapsible field group.
	  */
	public boolean isCollapsedByDefault()
	{
		Object oo = get_Value(COLUMNNAME_IsCollapsedByDefault);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Collapsible.
		@param IsCollapsible Flag to indicate the state of the dashboard panel
	*/
	public void setIsCollapsible (boolean IsCollapsible)
	{
		set_Value (COLUMNNAME_IsCollapsible, Boolean.valueOf(IsCollapsible));
	}

	/** Get Collapsible.
		@return Flag to indicate the state of the dashboard panel
	  */
	public boolean isCollapsible()
	{
		Object oo = get_Value(COLUMNNAME_IsCollapsible);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Embed Report Content.
		@param IsEmbedReportContent Embed report content into dashboard
	*/
	public void setIsEmbedReportContent (boolean IsEmbedReportContent)
	{
		set_Value (COLUMNNAME_IsEmbedReportContent, Boolean.valueOf(IsEmbedReportContent));
	}

	/** Get Embed Report Content.
		@return Embed report content into dashboard
	  */
	public boolean isEmbedReportContent()
	{
		Object oo = get_Value(COLUMNNAME_IsEmbedReportContent);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Maximizable.
		@param IsMaximizable Maximizable
	*/
	public void setIsMaximizable (boolean IsMaximizable)
	{
		set_Value (COLUMNNAME_IsMaximizable, Boolean.valueOf(IsMaximizable));
	}

	/** Get Maximizable.
		@return Maximizable	  */
	public boolean isMaximizable()
	{
		Object oo = get_Value(COLUMNNAME_IsMaximizable);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Show in Dashboard.
		@param IsShowInDashboard Show the dashlet in the dashboard
	*/
	public void setIsShowInDashboard (boolean IsShowInDashboard)
	{
		set_Value (COLUMNNAME_IsShowInDashboard, Boolean.valueOf(IsShowInDashboard));
	}

	/** Get Show in Dashboard.
		@return Show the dashlet in the dashboard
	  */
	public boolean isShowInDashboard()
	{
		Object oo = get_Value(COLUMNNAME_IsShowInDashboard);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Show Title.
		@param IsShowTitle Show Title
	*/
	public void setIsShowTitle (boolean IsShowTitle)
	{
		set_Value (COLUMNNAME_IsShowTitle, Boolean.valueOf(IsShowTitle));
	}

	/** Get Show Title.
		@return Show Title	  */
	public boolean isShowTitle()
	{
		Object oo = get_Value(COLUMNNAME_IsShowTitle);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Show on Login.
		@param IsShowinLogin Show on Login
	*/
	public void setIsShowinLogin (boolean IsShowinLogin)
	{
		set_Value (COLUMNNAME_IsShowinLogin, Boolean.valueOf(IsShowinLogin));
	}

	/** Get Show on Login.
		@return Show on Login	  */
	public boolean isShowinLogin()
	{
		Object oo = get_Value(COLUMNNAME_IsShowinLogin);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Line No.
		@param Line Unique line for this document
	*/
	public void setLine (BigDecimal Line)
	{
		set_Value (COLUMNNAME_Line, Line);
	}

	/** Get Line No.
		@return Unique line for this document
	  */
	public BigDecimal getLine()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Line);
		if (bd == null)
			 return Env.ZERO;
		return bd;
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair()
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Dashboard Content.
		@param PA_DashboardContent_ID Dashboard Content
	*/
	public void setPA_DashboardContent_ID (int PA_DashboardContent_ID)
	{
		if (PA_DashboardContent_ID < 1)
			set_ValueNoCheck (COLUMNNAME_PA_DashboardContent_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_PA_DashboardContent_ID, Integer.valueOf(PA_DashboardContent_ID));
	}

	/** Get Dashboard Content.
		@return Dashboard Content	  */
	public int getPA_DashboardContent_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PA_DashboardContent_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set PA_DashboardContent_UU.
		@param PA_DashboardContent_UU PA_DashboardContent_UU
	*/
	public void setPA_DashboardContent_UU (String PA_DashboardContent_UU)
	{
		set_Value (COLUMNNAME_PA_DashboardContent_UU, PA_DashboardContent_UU);
	}

	/** Get PA_DashboardContent_UU.
		@return PA_DashboardContent_UU	  */
	public String getPA_DashboardContent_UU()
	{
		return (String)get_Value(COLUMNNAME_PA_DashboardContent_UU);
	}

	public org.compiere.model.I_PA_Goal getPA_Goal() throws RuntimeException
	{
		return (org.compiere.model.I_PA_Goal)MTable.get(getCtx(), org.compiere.model.I_PA_Goal.Table_ID)
			.getPO(getPA_Goal_ID(), get_TrxName());
	}

	/** Set Goal.
		@param PA_Goal_ID Performance Goal
	*/
	public void setPA_Goal_ID (int PA_Goal_ID)
	{
		if (PA_Goal_ID < 1)
			set_Value (COLUMNNAME_PA_Goal_ID, null);
		else
			set_Value (COLUMNNAME_PA_Goal_ID, Integer.valueOf(PA_Goal_ID));
	}

	/** Get Goal.
		@return Performance Goal
	  */
	public int getPA_Goal_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PA_Goal_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Process Parameters.
		@param ProcessParameters Comma separated process parameter list
	*/
	public void setProcessParameters (String ProcessParameters)
	{
		set_Value (COLUMNNAME_ProcessParameters, ProcessParameters);
	}

	/** Get Process Parameters.
		@return Comma separated process parameter list
	  */
	public String getProcessParameters()
	{
		return (String)get_Value(COLUMNNAME_ProcessParameters);
	}

	/** Set Gadget URI.
		@param ZulFilePath URI for Dashboard Gadget
	*/
	public void setZulFilePath (String ZulFilePath)
	{
		set_Value (COLUMNNAME_ZulFilePath, ZulFilePath);
	}

	/** Get Gadget URI.
		@return URI for Dashboard Gadget
	  */
	public String getZulFilePath()
	{
		return (String)get_Value(COLUMNNAME_ZulFilePath);
	}
}