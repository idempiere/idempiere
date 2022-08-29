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

/** Generated Model for AD_Process_DrillRule_Para
 *  @author iDempiere (generated)
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="AD_Process_DrillRule_Para")
public class X_AD_Process_DrillRule_Para extends PO implements I_AD_Process_DrillRule_Para, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220526L;

    /** Standard Constructor */
    public X_AD_Process_DrillRule_Para (Properties ctx, int AD_Process_DrillRule_Para_ID, String trxName)
    {
      super (ctx, AD_Process_DrillRule_Para_ID, trxName);
      /** if (AD_Process_DrillRule_Para_ID == 0)
        {
			setAD_Process_DrillRule_ID (0);
			setAD_Process_Para_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_Process_DrillRule_Para (Properties ctx, int AD_Process_DrillRule_Para_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_Process_DrillRule_Para_ID, trxName, virtualColumns);
      /** if (AD_Process_DrillRule_Para_ID == 0)
        {
			setAD_Process_DrillRule_ID (0);
			setAD_Process_Para_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_Process_DrillRule_Para (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_Process_DrillRule_Para[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Process_DrillRule getAD_Process_DrillRule() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Process_DrillRule)MTable.get(getCtx(), org.compiere.model.I_AD_Process_DrillRule.Table_ID)
			.getPO(getAD_Process_DrillRule_ID(), get_TrxName());
	}

	/** Set Process Drill Rule.
		@param AD_Process_DrillRule_ID Process Drill Rule
	*/
	public void setAD_Process_DrillRule_ID (int AD_Process_DrillRule_ID)
	{
		if (AD_Process_DrillRule_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Process_DrillRule_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Process_DrillRule_ID, Integer.valueOf(AD_Process_DrillRule_ID));
	}

	/** Get Process Drill Rule.
		@return Process Drill Rule	  */
	public int getAD_Process_DrillRule_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Process_DrillRule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Process_DrillRule_Para_UU.
		@param AD_Process_DrillRule_Para_UU AD_Process_DrillRule_Para_UU
	*/
	public void setAD_Process_DrillRule_Para_UU (String AD_Process_DrillRule_Para_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_Process_DrillRule_Para_UU, AD_Process_DrillRule_Para_UU);
	}

	/** Get AD_Process_DrillRule_Para_UU.
		@return AD_Process_DrillRule_Para_UU	  */
	public String getAD_Process_DrillRule_Para_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_Process_DrillRule_Para_UU);
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
			set_ValueNoCheck (COLUMNNAME_AD_Process_Para_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Process_Para_ID, Integer.valueOf(AD_Process_Para_ID));
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

	/** Set Default Parameter.
		@param ParameterDefault Default value of the parameter
	*/
	public void setParameterDefault (String ParameterDefault)
	{
		set_Value (COLUMNNAME_ParameterDefault, ParameterDefault);
	}

	/** Get Default Parameter.
		@return Default value of the parameter
	  */
	public String getParameterDefault()
	{
		return (String)get_Value(COLUMNNAME_ParameterDefault);
	}

	/** Set Default To Parameter.
		@param ParameterToDefault Default value of the to parameter
	*/
	public void setParameterToDefault (String ParameterToDefault)
	{
		set_Value (COLUMNNAME_ParameterToDefault, ParameterToDefault);
	}

	/** Get Default To Parameter.
		@return Default value of the to parameter
	  */
	public String getParameterToDefault()
	{
		return (String)get_Value(COLUMNNAME_ParameterToDefault);
	}
}