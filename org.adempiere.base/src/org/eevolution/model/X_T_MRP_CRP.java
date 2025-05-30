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
package org.eevolution.model;

import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.model.*;

/** Generated Model for T_MRP_CRP
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="T_MRP_CRP")
public class X_T_MRP_CRP extends PO implements I_T_MRP_CRP, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_T_MRP_CRP (Properties ctx, int T_MRP_CRP_ID, String trxName)
    {
      super (ctx, T_MRP_CRP_ID, trxName);
      /** if (T_MRP_CRP_ID == 0)
        {
			setT_MRP_CRP_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_T_MRP_CRP (Properties ctx, int T_MRP_CRP_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, T_MRP_CRP_ID, trxName, virtualColumns);
      /** if (T_MRP_CRP_ID == 0)
        {
			setT_MRP_CRP_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_T_MRP_CRP (Properties ctx, String T_MRP_CRP_UU, String trxName)
    {
      super (ctx, T_MRP_CRP_UU, trxName);
      /** if (T_MRP_CRP_UU == null)
        {
			setT_MRP_CRP_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_T_MRP_CRP (Properties ctx, String T_MRP_CRP_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, T_MRP_CRP_UU, trxName, virtualColumns);
      /** if (T_MRP_CRP_UU == null)
        {
			setT_MRP_CRP_ID (0);
        } */
    }

    /** Load Constructor */
    public X_T_MRP_CRP (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_T_MRP_CRP[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_PInstance getAD_PInstance() throws RuntimeException
	{
		return (org.compiere.model.I_AD_PInstance)MTable.get(getCtx(), org.compiere.model.I_AD_PInstance.Table_ID)
			.getPO(getAD_PInstance_ID(), get_TrxName());
	}

	/** Set Process Instance.
		@param AD_PInstance_ID Instance of the process
	*/
	public void setAD_PInstance_ID (int AD_PInstance_ID)
	{
		if (AD_PInstance_ID < 1)
			set_Value (COLUMNNAME_AD_PInstance_ID, null);
		else
			set_Value (COLUMNNAME_AD_PInstance_ID, Integer.valueOf(AD_PInstance_ID));
	}

	/** Get Process Instance.
		@return Instance of the process
	  */
	public int getAD_PInstance_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PInstance_ID);
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

	/** Set Temporal MRP &amp; CRP.
		@param T_MRP_CRP_ID Temporal MRP &amp; CRP
	*/
	public void setT_MRP_CRP_ID (int T_MRP_CRP_ID)
	{
		if (T_MRP_CRP_ID < 1)
			set_ValueNoCheck (COLUMNNAME_T_MRP_CRP_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_T_MRP_CRP_ID, Integer.valueOf(T_MRP_CRP_ID));
	}

	/** Get Temporal MRP &amp; CRP.
		@return Temporal MRP &amp; CRP	  */
	public int getT_MRP_CRP_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_T_MRP_CRP_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set T_MRP_CRP_UU.
		@param T_MRP_CRP_UU T_MRP_CRP_UU
	*/
	public void setT_MRP_CRP_UU (String T_MRP_CRP_UU)
	{
		set_Value (COLUMNNAME_T_MRP_CRP_UU, T_MRP_CRP_UU);
	}

	/** Get T_MRP_CRP_UU.
		@return T_MRP_CRP_UU	  */
	public String getT_MRP_CRP_UU()
	{
		return (String)get_Value(COLUMNNAME_T_MRP_CRP_UU);
	}
}