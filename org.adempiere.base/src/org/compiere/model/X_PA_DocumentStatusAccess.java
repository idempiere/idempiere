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

/** Generated Model for PA_DocumentStatusAccess
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="PA_DocumentStatusAccess")
public class X_PA_DocumentStatusAccess extends PO implements I_PA_DocumentStatusAccess, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_PA_DocumentStatusAccess (Properties ctx, int PA_DocumentStatusAccess_ID, String trxName)
    {
      super (ctx, PA_DocumentStatusAccess_ID, trxName);
      /** if (PA_DocumentStatusAccess_ID == 0)
        {
			setPA_DocumentStatusAccess_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_PA_DocumentStatusAccess (Properties ctx, int PA_DocumentStatusAccess_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, PA_DocumentStatusAccess_ID, trxName, virtualColumns);
      /** if (PA_DocumentStatusAccess_ID == 0)
        {
			setPA_DocumentStatusAccess_ID (0);
        } */
    }

    /** Load Constructor */
    public X_PA_DocumentStatusAccess (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_PA_DocumentStatusAccess[")
        .append(get_ID()).append("]");
      return sb.toString();
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

	/** Set Document Status Access.
		@param PA_DocumentStatusAccess_ID Document Status Access
	*/
	public void setPA_DocumentStatusAccess_ID (int PA_DocumentStatusAccess_ID)
	{
		if (PA_DocumentStatusAccess_ID < 1)
			set_ValueNoCheck (COLUMNNAME_PA_DocumentStatusAccess_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_PA_DocumentStatusAccess_ID, Integer.valueOf(PA_DocumentStatusAccess_ID));
	}

	/** Get Document Status Access.
		@return Document Status Access	  */
	public int getPA_DocumentStatusAccess_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PA_DocumentStatusAccess_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set PA_DocumentStatusAccess_UU.
		@param PA_DocumentStatusAccess_UU PA_DocumentStatusAccess_UU
	*/
	public void setPA_DocumentStatusAccess_UU (String PA_DocumentStatusAccess_UU)
	{
		set_Value (COLUMNNAME_PA_DocumentStatusAccess_UU, PA_DocumentStatusAccess_UU);
	}

	/** Get PA_DocumentStatusAccess_UU.
		@return PA_DocumentStatusAccess_UU	  */
	public String getPA_DocumentStatusAccess_UU()
	{
		return (String)get_Value(COLUMNNAME_PA_DocumentStatusAccess_UU);
	}

	public org.compiere.model.I_PA_DocumentStatus getPA_DocumentStatus() throws RuntimeException
	{
		return (org.compiere.model.I_PA_DocumentStatus)MTable.get(getCtx(), org.compiere.model.I_PA_DocumentStatus.Table_ID)
			.getPO(getPA_DocumentStatus_ID(), get_TrxName());
	}

	/** Set Document Status.
		@param PA_DocumentStatus_ID Document Status
	*/
	public void setPA_DocumentStatus_ID (int PA_DocumentStatus_ID)
	{
		if (PA_DocumentStatus_ID < 1)
			set_ValueNoCheck (COLUMNNAME_PA_DocumentStatus_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_PA_DocumentStatus_ID, Integer.valueOf(PA_DocumentStatus_ID));
	}

	/** Get Document Status.
		@return Document Status	  */
	public int getPA_DocumentStatus_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PA_DocumentStatus_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}