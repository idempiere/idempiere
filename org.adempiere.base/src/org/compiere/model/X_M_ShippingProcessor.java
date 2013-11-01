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

/** Generated Model for M_ShippingProcessor
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_M_ShippingProcessor extends PO implements I_M_ShippingProcessor, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_M_ShippingProcessor (Properties ctx, int M_ShippingProcessor_ID, String trxName)
    {
      super (ctx, M_ShippingProcessor_ID, trxName);
      /** if (M_ShippingProcessor_ID == 0)
        {
			setConnectionPassword (null);
			setM_ShippingProcessorCfg_ID (0);
			setM_ShippingProcessor_ID (0);
			setName (null);
			setUserID (null);
        } */
    }

    /** Load Constructor */
    public X_M_ShippingProcessor (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_ShippingProcessor[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Connection Key.
		@param ConnectionKey Connection Key	  */
	public void setConnectionKey (String ConnectionKey)
	{
		set_Value (COLUMNNAME_ConnectionKey, ConnectionKey);
	}

	/** Get Connection Key.
		@return Connection Key	  */
	public String getConnectionKey () 
	{
		return (String)get_Value(COLUMNNAME_ConnectionKey);
	}

	/** Set Connection Password.
		@param ConnectionPassword Connection Password	  */
	public void setConnectionPassword (String ConnectionPassword)
	{
		set_Value (COLUMNNAME_ConnectionPassword, ConnectionPassword);
	}

	/** Get Connection Password.
		@return Connection Password	  */
	public String getConnectionPassword () 
	{
		return (String)get_Value(COLUMNNAME_ConnectionPassword);
	}

	public org.compiere.model.I_M_ShippingProcessorCfg getM_ShippingProcessorCfg() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShippingProcessorCfg)MTable.get(getCtx(), org.compiere.model.I_M_ShippingProcessorCfg.Table_Name)
			.getPO(getM_ShippingProcessorCfg_ID(), get_TrxName());	}

	/** Set Shipping Processor Configuration.
		@param M_ShippingProcessorCfg_ID Shipping Processor Configuration	  */
	public void setM_ShippingProcessorCfg_ID (int M_ShippingProcessorCfg_ID)
	{
		if (M_ShippingProcessorCfg_ID < 1) 
			set_Value (COLUMNNAME_M_ShippingProcessorCfg_ID, null);
		else 
			set_Value (COLUMNNAME_M_ShippingProcessorCfg_ID, Integer.valueOf(M_ShippingProcessorCfg_ID));
	}

	/** Get Shipping Processor Configuration.
		@return Shipping Processor Configuration	  */
	public int getM_ShippingProcessorCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShippingProcessorCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Shipping Processor.
		@param M_ShippingProcessor_ID Shipping Processor	  */
	public void setM_ShippingProcessor_ID (int M_ShippingProcessor_ID)
	{
		if (M_ShippingProcessor_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShippingProcessor_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShippingProcessor_ID, Integer.valueOf(M_ShippingProcessor_ID));
	}

	/** Get Shipping Processor.
		@return Shipping Processor	  */
	public int getM_ShippingProcessor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShippingProcessor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_ShippingProcessor_UU.
		@param M_ShippingProcessor_UU M_ShippingProcessor_UU	  */
	public void setM_ShippingProcessor_UU (String M_ShippingProcessor_UU)
	{
		set_Value (COLUMNNAME_M_ShippingProcessor_UU, M_ShippingProcessor_UU);
	}

	/** Get M_ShippingProcessor_UU.
		@return M_ShippingProcessor_UU	  */
	public String getM_ShippingProcessor_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_ShippingProcessor_UU);
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set User ID.
		@param UserID 
		User ID or account number
	  */
	public void setUserID (String UserID)
	{
		set_Value (COLUMNNAME_UserID, UserID);
	}

	/** Get User ID.
		@return User ID or account number
	  */
	public String getUserID () 
	{
		return (String)get_Value(COLUMNNAME_UserID);
	}
}