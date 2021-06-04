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

/** Generated Model for MFA_Rule
 *  @author iDempiere (generated) 
 *  @version Release 8.2 - $Id$ */
public class X_MFA_Rule extends PO implements I_MFA_Rule, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210605L;

    /** Standard Constructor */
    public X_MFA_Rule (Properties ctx, int MFA_Rule_ID, String trxName)
    {
      super (ctx, MFA_Rule_ID, trxName);
      /** if (MFA_Rule_ID == 0)
        {
			setMFA_Method_ID (0);
			setMFA_Rule_ID (0);
        } */
    }

    /** Load Constructor */
    public X_MFA_Rule (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_MFA_Rule[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Comment/Help.
		@param Help 
		Comment or Hint
	  */
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp () 
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	public org.compiere.model.I_MFA_Method getMFA_Method() throws RuntimeException
    {
		return (org.compiere.model.I_MFA_Method)MTable.get(getCtx(), org.compiere.model.I_MFA_Method.Table_Name)
			.getPO(getMFA_Method_ID(), get_TrxName());	}

	/** Set MFA Method.
		@param MFA_Method_ID 
		Multi-factor Authentication Method
	  */
	public void setMFA_Method_ID (int MFA_Method_ID)
	{
		if (MFA_Method_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_MFA_Method_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_MFA_Method_ID, Integer.valueOf(MFA_Method_ID));
	}

	/** Get MFA Method.
		@return Multi-factor Authentication Method
	  */
	public int getMFA_Method_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MFA_Method_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set MFA Rule.
		@param MFA_Rule_ID 
		Multi-factor Authentication Rule
	  */
	public void setMFA_Rule_ID (int MFA_Rule_ID)
	{
		if (MFA_Rule_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_MFA_Rule_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_MFA_Rule_ID, Integer.valueOf(MFA_Rule_ID));
	}

	/** Get MFA Rule.
		@return Multi-factor Authentication Rule
	  */
	public int getMFA_Rule_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MFA_Rule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set MFA_Rule_UU.
		@param MFA_Rule_UU MFA_Rule_UU	  */
	public void setMFA_Rule_UU (String MFA_Rule_UU)
	{
		set_Value (COLUMNNAME_MFA_Rule_UU, MFA_Rule_UU);
	}

	/** Get MFA_Rule_UU.
		@return MFA_Rule_UU	  */
	public String getMFA_Rule_UU () 
	{
		return (String)get_Value(COLUMNNAME_MFA_Rule_UU);
	}
}