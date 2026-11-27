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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for M_ManualCostDetail
 *  @author iDempiere (generated)
 *  @version Release 14 - $Id$ */
@org.adempiere.base.Model(table="M_ManualCostDetail")
public class X_M_ManualCostDetail extends PO implements I_M_ManualCostDetail, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20261127L;

    /** Standard Constructor */
    public X_M_ManualCostDetail (Properties ctx, int M_ManualCostDetail_ID, String trxName)
    {
      super (ctx, M_ManualCostDetail_ID, trxName);
      /** if (M_ManualCostDetail_ID == 0)
        {
			setAD_Table_ID (0);
			setAmt (Env.ZERO);
			setC_AcctSchema_ID (0);
			setC_Charge_ID (0);
			setC_ValidCombination_ID (0);
			setDateAcct (new Timestamp( System.currentTimeMillis() ));
			setM_CostElement_ID (0);
			setM_ManualCostDetail_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_M_ManualCostDetail (Properties ctx, int M_ManualCostDetail_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, M_ManualCostDetail_ID, trxName, virtualColumns);
      /** if (M_ManualCostDetail_ID == 0)
        {
			setAD_Table_ID (0);
			setAmt (Env.ZERO);
			setC_AcctSchema_ID (0);
			setC_Charge_ID (0);
			setC_ValidCombination_ID (0);
			setDateAcct (new Timestamp( System.currentTimeMillis() ));
			setM_CostElement_ID (0);
			setM_ManualCostDetail_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_M_ManualCostDetail (Properties ctx, String M_ManualCostDetail_UU, String trxName)
    {
      super (ctx, M_ManualCostDetail_UU, trxName);
      /** if (M_ManualCostDetail_UU == null)
        {
			setAD_Table_ID (0);
			setAmt (Env.ZERO);
			setC_AcctSchema_ID (0);
			setC_Charge_ID (0);
			setC_ValidCombination_ID (0);
			setDateAcct (new Timestamp( System.currentTimeMillis() ));
			setM_CostElement_ID (0);
			setM_ManualCostDetail_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_M_ManualCostDetail (Properties ctx, String M_ManualCostDetail_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, M_ManualCostDetail_UU, trxName, virtualColumns);
      /** if (M_ManualCostDetail_UU == null)
        {
			setAD_Table_ID (0);
			setAmt (Env.ZERO);
			setC_AcctSchema_ID (0);
			setC_Charge_ID (0);
			setC_ValidCombination_ID (0);
			setDateAcct (new Timestamp( System.currentTimeMillis() ));
			setM_CostElement_ID (0);
			setM_ManualCostDetail_ID (0);
			setRecord_ID (0);
        } */
    }

    /** Load Constructor */
    public X_M_ManualCostDetail (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_M_ManualCostDetail[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	@Deprecated(since="13") // use better methods with cache
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
			set_ValueNoCheck (COLUMNNAME_AD_Table_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Table_ID, Integer.valueOf(AD_Table_ID));
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

	/** Set Amount.
		@param Amt Amount
	*/
	public void setAmt (BigDecimal Amt)
	{
		set_ValueNoCheck (COLUMNNAME_Amt, Amt);
	}

	/** Get Amount.
		@return Amount
	  */
	public BigDecimal getAmt()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Amt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_C_AcctSchema getC_AcctSchema() throws RuntimeException
	{
		return (org.compiere.model.I_C_AcctSchema)MTable.get(getCtx(), org.compiere.model.I_C_AcctSchema.Table_ID)
			.getPO(getC_AcctSchema_ID(), get_TrxName());
	}

	/** Set Accounting Schema.
		@param C_AcctSchema_ID Rules for accounting
	*/
	public void setC_AcctSchema_ID (int C_AcctSchema_ID)
	{
		if (C_AcctSchema_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_AcctSchema_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_AcctSchema_ID, Integer.valueOf(C_AcctSchema_ID));
	}

	/** Get Accounting Schema.
		@return Rules for accounting
	  */
	public int getC_AcctSchema_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_AcctSchema_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_C_Charge getC_Charge() throws RuntimeException
	{
		return (org.compiere.model.I_C_Charge)MTable.get(getCtx(), org.compiere.model.I_C_Charge.Table_ID)
			.getPO(getC_Charge_ID(), get_TrxName());
	}

	/** Set Charge.
		@param C_Charge_ID Additional document charges
	*/
	public void setC_Charge_ID (int C_Charge_ID)
	{
		if (C_Charge_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_Charge_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_Charge_ID, Integer.valueOf(C_Charge_ID));
	}

	/** Get Charge.
		@return Additional document charges
	  */
	public int getC_Charge_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Charge_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public I_C_ValidCombination getC_ValidCombination() throws RuntimeException
	{
		return (I_C_ValidCombination)MTable.get(getCtx(), I_C_ValidCombination.Table_ID)
			.getPO(getC_ValidCombination_ID(), get_TrxName());
	}

	/** Set Combination.
		@param C_ValidCombination_ID Valid Account Combination
	*/
	public void setC_ValidCombination_ID (int C_ValidCombination_ID)
	{
		if (C_ValidCombination_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_ValidCombination_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_ValidCombination_ID, Integer.valueOf(C_ValidCombination_ID));
	}

	/** Get Combination.
		@return Valid Account Combination
	  */
	public int getC_ValidCombination_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ValidCombination_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Account Date.
		@param DateAcct Accounting Date
	*/
	public void setDateAcct (Timestamp DateAcct)
	{
		set_ValueNoCheck (COLUMNNAME_DateAcct, DateAcct);
	}

	/** Get Account Date.
		@return Accounting Date
	  */
	public Timestamp getDateAcct()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateAcct);
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

	/** Set Line ID.
		@param Line_ID Transaction line ID (internal)
	*/
	public void setLine_ID (int Line_ID)
	{
		if (Line_ID < 1)
			set_ValueNoCheck (COLUMNNAME_Line_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_Line_ID, Integer.valueOf(Line_ID));
	}

	/** Get Line ID.
		@return Transaction line ID (internal)
	  */
	public int getLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Line_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public I_M_AttributeSetInstance getM_AttributeSetInstance() throws RuntimeException
	{
		return (I_M_AttributeSetInstance)MTable.get(getCtx(), I_M_AttributeSetInstance.Table_ID)
			.getPO(getM_AttributeSetInstance_ID(), get_TrxName());
	}

	/** Set Attribute Set Instance.
		@param M_AttributeSetInstance_ID Product Attribute Set Instance
	*/
	public void setM_AttributeSetInstance_ID (int M_AttributeSetInstance_ID)
	{
		if (M_AttributeSetInstance_ID < 0)
			set_ValueNoCheck (COLUMNNAME_M_AttributeSetInstance_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_AttributeSetInstance_ID, Integer.valueOf(M_AttributeSetInstance_ID));
	}

	/** Get Attribute Set Instance.
		@return Product Attribute Set Instance
	  */
	public int getM_AttributeSetInstance_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_AttributeSetInstance_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_M_CostElement getM_CostElement() throws RuntimeException
	{
		return (org.compiere.model.I_M_CostElement)MTable.get(getCtx(), org.compiere.model.I_M_CostElement.Table_ID)
			.getPO(getM_CostElement_ID(), get_TrxName());
	}

	/** Set Cost Element.
		@param M_CostElement_ID Product Cost Element
	*/
	public void setM_CostElement_ID (int M_CostElement_ID)
	{
		if (M_CostElement_ID < 1)
			set_ValueNoCheck (COLUMNNAME_M_CostElement_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_CostElement_ID, Integer.valueOf(M_CostElement_ID));
	}

	/** Get Cost Element.
		@return Product Cost Element
	  */
	public int getM_CostElement_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_CostElement_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Manual Cost Detail.
		@param M_ManualCostDetail_ID Manual Cost Element Charge Posting
	*/
	public void setM_ManualCostDetail_ID (int M_ManualCostDetail_ID)
	{
		if (M_ManualCostDetail_ID < 1)
			set_ValueNoCheck (COLUMNNAME_M_ManualCostDetail_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_ManualCostDetail_ID, Integer.valueOf(M_ManualCostDetail_ID));
	}

	/** Get Manual Cost Detail.
		@return Manual Cost Element Charge Posting
	  */
	public int getM_ManualCostDetail_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ManualCostDetail_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_ManualCostDetail_UU.
		@param M_ManualCostDetail_UU M_ManualCostDetail_UU
	*/
	public void setM_ManualCostDetail_UU (String M_ManualCostDetail_UU)
	{
		set_Value (COLUMNNAME_M_ManualCostDetail_UU, M_ManualCostDetail_UU);
	}

	/** Get M_ManualCostDetail_UU.
		@return M_ManualCostDetail_UU	  */
	public String getM_ManualCostDetail_UU()
	{
		return (String)get_Value(COLUMNNAME_M_ManualCostDetail_UU);
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException
	{
		return (org.compiere.model.I_M_Product)MTable.get(getCtx(), org.compiere.model.I_M_Product.Table_ID)
			.getPO(getM_Product_ID(), get_TrxName());
	}

	/** Set Product.
		@param M_Product_ID Product, Service, Item
	*/
	public void setM_Product_ID (int M_Product_ID)
	{
		if (M_Product_ID < 1)
			set_ValueNoCheck (COLUMNNAME_M_Product_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_Product_ID, Integer.valueOf(M_Product_ID));
	}

	/** Get Product.
		@return Product, Service, Item
	  */
	public int getM_Product_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Product_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Quantity.
		@param Qty Quantity
	*/
	public void setQty (BigDecimal Qty)
	{
		set_ValueNoCheck (COLUMNNAME_Qty, Qty);
	}

	/** Get Quantity.
		@return Quantity
	  */
	public BigDecimal getQty()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Qty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Record ID.
		@param Record_ID Direct internal record ID
	*/
	public void setRecord_ID (int Record_ID)
	{
		if (Record_ID < 0)
			set_ValueNoCheck (COLUMNNAME_Record_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_Record_ID, Integer.valueOf(Record_ID));
	}

	/** Get Record ID.
		@return Direct internal record ID
	  */
	public int getRecord_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Record_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}