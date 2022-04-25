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

/** Generated Model for AD_StatusLineUsedIn
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_StatusLineUsedIn")
public class X_AD_StatusLineUsedIn extends PO implements I_AD_StatusLineUsedIn, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_StatusLineUsedIn (Properties ctx, int AD_StatusLineUsedIn_ID, String trxName)
    {
      super (ctx, AD_StatusLineUsedIn_ID, trxName);
      /** if (AD_StatusLineUsedIn_ID == 0)
        {
			setAD_StatusLine_ID (0);
			setAD_StatusLineUsedIn_ID (0);
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setIsStatusLine (true);
// Y
        } */
    }

    /** Standard Constructor */
    public X_AD_StatusLineUsedIn (Properties ctx, int AD_StatusLineUsedIn_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_StatusLineUsedIn_ID, trxName, virtualColumns);
      /** if (AD_StatusLineUsedIn_ID == 0)
        {
			setAD_StatusLine_ID (0);
			setAD_StatusLineUsedIn_ID (0);
			setEntityType (null);
// @SQL=SELECT CASE WHEN '@P|AdempiereSys:N@'='Y' THEN 'D' ELSE get_sysconfig('DEFAULT_ENTITYTYPE','U',0,0) END FROM Dual
			setIsStatusLine (true);
// Y
        } */
    }

    /** Load Constructor */
    public X_AD_StatusLineUsedIn (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_StatusLineUsedIn[")
        .append(get_ID()).append("]");
      return sb.toString();
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
			set_ValueNoCheck (COLUMNNAME_AD_StatusLine_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_StatusLine_ID, Integer.valueOf(AD_StatusLine_ID));
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

	/** Set AD_StatusLineUsedIn.
		@param AD_StatusLineUsedIn_ID AD_StatusLineUsedIn
	*/
	public void setAD_StatusLineUsedIn_ID (int AD_StatusLineUsedIn_ID)
	{
		if (AD_StatusLineUsedIn_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_StatusLineUsedIn_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_StatusLineUsedIn_ID, Integer.valueOf(AD_StatusLineUsedIn_ID));
	}

	/** Get AD_StatusLineUsedIn.
		@return AD_StatusLineUsedIn	  */
	public int getAD_StatusLineUsedIn_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_StatusLineUsedIn_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_StatusLineUsedIn_UU.
		@param AD_StatusLineUsedIn_UU AD_StatusLineUsedIn_UU
	*/
	public void setAD_StatusLineUsedIn_UU (String AD_StatusLineUsedIn_UU)
	{
		set_Value (COLUMNNAME_AD_StatusLineUsedIn_UU, AD_StatusLineUsedIn_UU);
	}

	/** Get AD_StatusLineUsedIn_UU.
		@return AD_StatusLineUsedIn_UU	  */
	public String getAD_StatusLineUsedIn_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_StatusLineUsedIn_UU);
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
			set_Value (COLUMNNAME_AD_Tab_ID, null);
		else
			set_Value (COLUMNNAME_AD_Tab_ID, Integer.valueOf(AD_Tab_ID));
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

	/** EntityType AD_Reference_ID=389 */
	public static final int ENTITYTYPE_AD_Reference_ID=389;
	/** Set Entity Type.
		@param EntityType Dictionary Entity Type; Determines ownership and synchronization
	*/
	public void setEntityType (String EntityType)
	{

		set_Value (COLUMNNAME_EntityType, EntityType);
	}

	/** Get Entity Type.
		@return Dictionary Entity Type; Determines ownership and synchronization
	  */
	public String getEntityType()
	{
		return (String)get_Value(COLUMNNAME_EntityType);
	}

	/** Set Status Line.
		@param IsStatusLine Defines if this record refers to a status line or to a help widget
	*/
	public void setIsStatusLine (boolean IsStatusLine)
	{
		set_Value (COLUMNNAME_IsStatusLine, Boolean.valueOf(IsStatusLine));
	}

	/** Get Status Line.
		@return Defines if this record refers to a status line or to a help widget
	  */
	public boolean isStatusLine()
	{
		Object oo = get_Value(COLUMNNAME_IsStatusLine);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
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