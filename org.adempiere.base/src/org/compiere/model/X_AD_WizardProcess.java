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

/** Generated Model for AD_WizardProcess
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_AD_WizardProcess extends PO implements I_AD_WizardProcess, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_AD_WizardProcess (Properties ctx, int AD_WizardProcess_ID, String trxName)
    {
      super (ctx, AD_WizardProcess_ID, trxName);
      /** if (AD_WizardProcess_ID == 0)
        {
			setAD_WF_Node_ID (0);
			setAD_WizardProcess_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_WizardProcess (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 2 - Client 
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
      StringBuffer sb = new StringBuffer ("X_AD_WizardProcess[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getAD_User_ID(), get_TrxName());	}

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

	public org.compiere.model.I_AD_WF_Node getAD_WF_Node() throws RuntimeException
    {
		return (org.compiere.model.I_AD_WF_Node)MTable.get(getCtx(), org.compiere.model.I_AD_WF_Node.Table_Name)
			.getPO(getAD_WF_Node_ID(), get_TrxName());	}

	/** Set Node.
		@param AD_WF_Node_ID 
		Workflow Node (activity), step or process
	  */
	public void setAD_WF_Node_ID (int AD_WF_Node_ID)
	{
		if (AD_WF_Node_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_WF_Node_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_WF_Node_ID, Integer.valueOf(AD_WF_Node_ID));
	}

	/** Get Node.
		@return Workflow Node (activity), step or process
	  */
	public int getAD_WF_Node_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_WF_Node_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Wizard Process.
		@param AD_WizardProcess_ID Wizard Process	  */
	public void setAD_WizardProcess_ID (int AD_WizardProcess_ID)
	{
		if (AD_WizardProcess_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_WizardProcess_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_WizardProcess_ID, Integer.valueOf(AD_WizardProcess_ID));
	}

	/** Get Wizard Process.
		@return Wizard Process	  */
	public int getAD_WizardProcess_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_WizardProcess_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_WizardProcess_UU.
		@param AD_WizardProcess_UU AD_WizardProcess_UU	  */
	public void setAD_WizardProcess_UU (String AD_WizardProcess_UU)
	{
		set_Value (COLUMNNAME_AD_WizardProcess_UU, AD_WizardProcess_UU);
	}

	/** Get AD_WizardProcess_UU.
		@return AD_WizardProcess_UU	  */
	public String getAD_WizardProcess_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_WizardProcess_UU);
	}

	/** Set Note.
		@param Note 
		Optional additional user defined information
	  */
	public void setNote (String Note)
	{
		set_Value (COLUMNNAME_Note, Note);
	}

	/** Get Note.
		@return Optional additional user defined information
	  */
	public String getNote () 
	{
		return (String)get_Value(COLUMNNAME_Note);
	}

	/** WizardStatus AD_Reference_ID=200003 */
	public static final int WIZARDSTATUS_AD_Reference_ID=200003;
	/** New = N */
	public static final String WIZARDSTATUS_New = "N";
	/** Pending = P */
	public static final String WIZARDSTATUS_Pending = "P";
	/** Finished = F */
	public static final String WIZARDSTATUS_Finished = "F";
	/** In-Progress = I */
	public static final String WIZARDSTATUS_In_Progress = "I";
	/** Skipped = S */
	public static final String WIZARDSTATUS_Skipped = "S";
	/** Delayed = D */
	public static final String WIZARDSTATUS_Delayed = "D";
	/** Set Wizard Status.
		@param WizardStatus Wizard Status	  */
	public void setWizardStatus (String WizardStatus)
	{

		set_Value (COLUMNNAME_WizardStatus, WizardStatus);
	}

	/** Get Wizard Status.
		@return Wizard Status	  */
	public String getWizardStatus () 
	{
		return (String)get_Value(COLUMNNAME_WizardStatus);
	}
}