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

/** Generated Model for AD_WF_ActivityApprover
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_WF_ActivityApprover")
public class X_AD_WF_ActivityApprover extends PO implements I_AD_WF_ActivityApprover, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_WF_ActivityApprover (Properties ctx, int AD_WF_ActivityApprover_ID, String trxName)
    {
      super (ctx, AD_WF_ActivityApprover_ID, trxName);
      /** if (AD_WF_ActivityApprover_ID == 0)
        {
			setAD_User_ID (0);
			setAD_WF_ActivityApprover_ID (0);
			setAD_WF_Activity_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_WF_ActivityApprover (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_WF_ActivityApprover[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
	{
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_ID)
			.getPO(getAD_User_ID(), get_TrxName());
	}

	/** Set User/Contact.
		@param AD_User_ID 
		User within the system - Internal or Business Partner Contact
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
	public int getAD_User_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Workflow Activity Approver.
		@param AD_WF_ActivityApprover_ID Workflow Activity Approver	  */
	public void setAD_WF_ActivityApprover_ID (int AD_WF_ActivityApprover_ID)
	{
		if (AD_WF_ActivityApprover_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_WF_ActivityApprover_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_WF_ActivityApprover_ID, Integer.valueOf(AD_WF_ActivityApprover_ID));
	}

	/** Get Workflow Activity Approver.
		@return Workflow Activity Approver	  */
	public int getAD_WF_ActivityApprover_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_WF_ActivityApprover_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_WF_ActivityApprover_UU.
		@param AD_WF_ActivityApprover_UU AD_WF_ActivityApprover_UU	  */
	public void setAD_WF_ActivityApprover_UU (String AD_WF_ActivityApprover_UU)
	{
		set_Value (COLUMNNAME_AD_WF_ActivityApprover_UU, AD_WF_ActivityApprover_UU);
	}

	/** Get AD_WF_ActivityApprover_UU.
		@return AD_WF_ActivityApprover_UU	  */
	public String getAD_WF_ActivityApprover_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_WF_ActivityApprover_UU);
	}

	public org.compiere.model.I_AD_WF_Activity getAD_WF_Activity() throws RuntimeException
	{
		return (org.compiere.model.I_AD_WF_Activity)MTable.get(getCtx(), org.compiere.model.I_AD_WF_Activity.Table_ID)
			.getPO(getAD_WF_Activity_ID(), get_TrxName());
	}

	/** Set Workflow Activity.
		@param AD_WF_Activity_ID 
		Workflow Activity
	  */
	public void setAD_WF_Activity_ID (int AD_WF_Activity_ID)
	{
		if (AD_WF_Activity_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_WF_Activity_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_WF_Activity_ID, Integer.valueOf(AD_WF_Activity_ID));
	}

	/** Get Workflow Activity.
		@return Workflow Activity
	  */
	public int getAD_WF_Activity_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_WF_Activity_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}