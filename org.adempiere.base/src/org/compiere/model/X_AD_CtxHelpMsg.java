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

/** Generated Model for AD_CtxHelpMsg
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_AD_CtxHelpMsg extends PO implements I_AD_CtxHelpMsg, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130626L;

    /** Standard Constructor */
    public X_AD_CtxHelpMsg (Properties ctx, int AD_CtxHelpMsg_ID, String trxName)
    {
      super (ctx, AD_CtxHelpMsg_ID, trxName);
      /** if (AD_CtxHelpMsg_ID == 0)
        {
			setAD_CtxHelp_ID (0);
			setAD_CtxHelpMsg_ID (0);
			setMsgText (null);
        } */
    }

    /** Load Constructor */
    public X_AD_CtxHelpMsg (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_CtxHelpMsg[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_CtxHelp getAD_CtxHelp() throws RuntimeException
    {
		return (org.compiere.model.I_AD_CtxHelp)MTable.get(getCtx(), org.compiere.model.I_AD_CtxHelp.Table_Name)
			.getPO(getAD_CtxHelp_ID(), get_TrxName());	}

	/** Set Context Help.
		@param AD_CtxHelp_ID Context Help	  */
	public void setAD_CtxHelp_ID (int AD_CtxHelp_ID)
	{
		if (AD_CtxHelp_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelp_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelp_ID, Integer.valueOf(AD_CtxHelp_ID));
	}

	/** Get Context Help.
		@return Context Help	  */
	public int getAD_CtxHelp_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_CtxHelp_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Context Help Message.
		@param AD_CtxHelpMsg_ID Context Help Message	  */
	public void setAD_CtxHelpMsg_ID (int AD_CtxHelpMsg_ID)
	{
		if (AD_CtxHelpMsg_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelpMsg_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelpMsg_ID, Integer.valueOf(AD_CtxHelpMsg_ID));
	}

	/** Get Context Help Message.
		@return Context Help Message	  */
	public int getAD_CtxHelpMsg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_CtxHelpMsg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_CtxHelpMsg_UU.
		@param AD_CtxHelpMsg_UU AD_CtxHelpMsg_UU	  */
	public void setAD_CtxHelpMsg_UU (String AD_CtxHelpMsg_UU)
	{
		set_Value (COLUMNNAME_AD_CtxHelpMsg_UU, AD_CtxHelpMsg_UU);
	}

	/** Get AD_CtxHelpMsg_UU.
		@return AD_CtxHelpMsg_UU	  */
	public String getAD_CtxHelpMsg_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_CtxHelpMsg_UU);
	}

	/** Set Message Text.
		@param MsgText 
		Textual Informational, Menu or Error Message
	  */
	public void setMsgText (String MsgText)
	{
		set_Value (COLUMNNAME_MsgText, MsgText);
	}

	/** Get Message Text.
		@return Textual Informational, Menu or Error Message
	  */
	public String getMsgText () 
	{
		return (String)get_Value(COLUMNNAME_MsgText);
	}
}