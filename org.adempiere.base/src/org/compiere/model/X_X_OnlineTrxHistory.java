/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2007 ComPiere, Inc. All Rights Reserved.                *
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

/** Generated Model for X_OnlineTrxHistory
 *  @author Adempiere (generated) 
 *  @version Release 3.6.0LTS - $Id$ */
public class X_X_OnlineTrxHistory extends PO implements I_X_OnlineTrxHistory, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121031L;

    /** Standard Constructor */
    public X_X_OnlineTrxHistory (Properties ctx, int X_OnlineTrxHistory_ID, String trxName)
    {
      super (ctx, X_OnlineTrxHistory_ID, trxName);
      /** if (X_OnlineTrxHistory_ID == 0)
        {
			setAD_Table_ID (0);
			setIsError (false);
// N
			setProcessed (false);
// N
			setRecord_ID (0);
			setX_OnlineTrxHistory_ID (0);
        } */
    }

    /** Load Constructor */
    public X_X_OnlineTrxHistory (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org 
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
      StringBuffer sb = new StringBuffer ("X_X_OnlineTrxHistory[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Table)MTable.get(getCtx(), org.compiere.model.I_AD_Table.Table_Name)
			.getPO(getAD_Table_ID(), get_TrxName());	}

	/** Set Table.
		@param AD_Table_ID 
		Database Table information
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
	public int getAD_Table_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Table_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Error.
		@param IsError 
		An Error occurred in the execution
	  */
	public void setIsError (boolean IsError)
	{
		set_Value (COLUMNNAME_IsError, Boolean.valueOf(IsError));
	}

	/** Get Error.
		@return An Error occurred in the execution
	  */
	public boolean isError () 
	{
		Object oo = get_Value(COLUMNNAME_IsError);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Processed.
		@param Processed 
		The document has been processed
	  */
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed () 
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Record ID.
		@param Record_ID 
		Direct internal record ID
	  */
	public void setRecord_ID (int Record_ID)
	{
		if (Record_ID < 0) 
			set_Value (COLUMNNAME_Record_ID, null);
		else 
			set_Value (COLUMNNAME_Record_ID, Integer.valueOf(Record_ID));
	}

	/** Get Record ID.
		@return Direct internal record ID
	  */
	public int getRecord_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Record_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Text Message.
		@param TextMsg 
		Text Message
	  */
	public void setTextMsg (String TextMsg)
	{
		set_Value (COLUMNNAME_TextMsg, TextMsg);
	}

	/** Get Text Message.
		@return Text Message
	  */
	public String getTextMsg () 
	{
		return (String)get_Value(COLUMNNAME_TextMsg);
	}

	/** Set Online Transaction History.
		@param X_OnlineTrxHistory_ID Online Transaction History	  */
	public void setX_OnlineTrxHistory_ID (int X_OnlineTrxHistory_ID)
	{
		if (X_OnlineTrxHistory_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_X_OnlineTrxHistory_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_X_OnlineTrxHistory_ID, Integer.valueOf(X_OnlineTrxHistory_ID));
	}

	/** Get Online Transaction History.
		@return Online Transaction History	  */
	public int getX_OnlineTrxHistory_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_X_OnlineTrxHistory_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set X_OnlineTrxHistory_UU.
		@param X_OnlineTrxHistory_UU X_OnlineTrxHistory_UU	  */
	public void setX_OnlineTrxHistory_UU (String X_OnlineTrxHistory_UU)
	{
		set_Value (COLUMNNAME_X_OnlineTrxHistory_UU, X_OnlineTrxHistory_UU);
	}

	/** Get X_OnlineTrxHistory_UU.
		@return X_OnlineTrxHistory_UU	  */
	public String getX_OnlineTrxHistory_UU () 
	{
		return (String)get_Value(COLUMNNAME_X_OnlineTrxHistory_UU);
	}
}