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
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for M_StorageReservationLog
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="M_StorageReservationLog")
public class X_M_StorageReservationLog extends PO implements I_M_StorageReservationLog, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_M_StorageReservationLog (Properties ctx, int M_StorageReservationLog_ID, String trxName)
    {
      super (ctx, M_StorageReservationLog_ID, trxName);
      /** if (M_StorageReservationLog_ID == 0)
        {
			setAD_Table_ID (0);
			setDeltaQty (Env.ZERO);
			setIsSOTrx (false);
			setM_AttributeSetInstance_ID (0);
			setM_Product_ID (0);
			setM_StorageReservationLog_ID (0);
			setM_StorageReservationLog_UU (null);
			setM_Warehouse_ID (0);
			setNewQty (Env.ZERO);
			setOldQty (Env.ZERO);
			setRecord_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_M_StorageReservationLog (Properties ctx, int M_StorageReservationLog_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, M_StorageReservationLog_ID, trxName, virtualColumns);
      /** if (M_StorageReservationLog_ID == 0)
        {
			setAD_Table_ID (0);
			setDeltaQty (Env.ZERO);
			setIsSOTrx (false);
			setM_AttributeSetInstance_ID (0);
			setM_Product_ID (0);
			setM_StorageReservationLog_ID (0);
			setM_StorageReservationLog_UU (null);
			setM_Warehouse_ID (0);
			setNewQty (Env.ZERO);
			setOldQty (Env.ZERO);
			setRecord_ID (0);
        } */
    }

    /** Load Constructor */
    public X_M_StorageReservationLog (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_M_StorageReservationLog[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

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

	public org.compiere.model.I_C_DocType getC_DocType() throws RuntimeException
	{
		return (org.compiere.model.I_C_DocType)MTable.get(getCtx(), org.compiere.model.I_C_DocType.Table_ID)
			.getPO(getC_DocType_ID(), get_TrxName());
	}

	/** Set Document Type.
		@param C_DocType_ID Document type or rules
	*/
	public void setC_DocType_ID (int C_DocType_ID)
	{
		if (C_DocType_ID < 0)
			set_ValueNoCheck (COLUMNNAME_C_DocType_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_DocType_ID, Integer.valueOf(C_DocType_ID));
	}

	/** Get Document Type.
		@return Document type or rules
	  */
	public int getC_DocType_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_DocType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Delta Quantity.
		@param DeltaQty Quantity Difference
	*/
	public void setDeltaQty (BigDecimal DeltaQty)
	{
		set_ValueNoCheck (COLUMNNAME_DeltaQty, DeltaQty);
	}

	/** Get Delta Quantity.
		@return Quantity Difference
	  */
	public BigDecimal getDeltaQty()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_DeltaQty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Document No.
		@param DocumentNo Document sequence number of the document
	*/
	public void setDocumentNo (String DocumentNo)
	{
		set_ValueNoCheck (COLUMNNAME_DocumentNo, DocumentNo);
	}

	/** Get Document No.
		@return Document sequence number of the document
	  */
	public String getDocumentNo()
	{
		return (String)get_Value(COLUMNNAME_DocumentNo);
	}

	/** Set Sales Transaction.
		@param IsSOTrx This is a Sales Transaction
	*/
	public void setIsSOTrx (boolean IsSOTrx)
	{
		set_ValueNoCheck (COLUMNNAME_IsSOTrx, Boolean.valueOf(IsSOTrx));
	}

	/** Get Sales Transaction.
		@return This is a Sales Transaction
	  */
	public boolean isSOTrx()
	{
		Object oo = get_Value(COLUMNNAME_IsSOTrx);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Line.
		@param LineNo Line No
	*/
	public void setLineNo (int LineNo)
	{
		set_ValueNoCheck (COLUMNNAME_LineNo, Integer.valueOf(LineNo));
	}

	/** Get Line.
		@return Line No
	  */
	public int getLineNo()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_LineNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

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

	/** Set Storage Reservation Log.
		@param M_StorageReservationLog_ID Log for every storage reservation quantity change
	*/
	public void setM_StorageReservationLog_ID (int M_StorageReservationLog_ID)
	{
		if (M_StorageReservationLog_ID < 1)
			set_ValueNoCheck (COLUMNNAME_M_StorageReservationLog_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_StorageReservationLog_ID, Integer.valueOf(M_StorageReservationLog_ID));
	}

	/** Get Storage Reservation Log.
		@return Log for every storage reservation quantity change
	  */
	public int getM_StorageReservationLog_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_StorageReservationLog_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_StorageReservationLog_UU.
		@param M_StorageReservationLog_UU M_StorageReservationLog_UU
	*/
	public void setM_StorageReservationLog_UU (String M_StorageReservationLog_UU)
	{
		set_ValueNoCheck (COLUMNNAME_M_StorageReservationLog_UU, M_StorageReservationLog_UU);
	}

	/** Get M_StorageReservationLog_UU.
		@return M_StorageReservationLog_UU	  */
	public String getM_StorageReservationLog_UU()
	{
		return (String)get_Value(COLUMNNAME_M_StorageReservationLog_UU);
	}

	public org.compiere.model.I_M_Warehouse getM_Warehouse() throws RuntimeException
	{
		return (org.compiere.model.I_M_Warehouse)MTable.get(getCtx(), org.compiere.model.I_M_Warehouse.Table_ID)
			.getPO(getM_Warehouse_ID(), get_TrxName());
	}

	/** Set Warehouse.
		@param M_Warehouse_ID Storage Warehouse and Service Point
	*/
	public void setM_Warehouse_ID (int M_Warehouse_ID)
	{
		if (M_Warehouse_ID < 1)
			set_ValueNoCheck (COLUMNNAME_M_Warehouse_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_M_Warehouse_ID, Integer.valueOf(M_Warehouse_ID));
	}

	/** Get Warehouse.
		@return Storage Warehouse and Service Point
	  */
	public int getM_Warehouse_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Warehouse_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set New Current Quantity.
		@param NewQty New current quantity after processing of M_CostDetail
	*/
	public void setNewQty (BigDecimal NewQty)
	{
		set_ValueNoCheck (COLUMNNAME_NewQty, NewQty);
	}

	/** Get New Current Quantity.
		@return New current quantity after processing of M_CostDetail
	  */
	public BigDecimal getNewQty()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_NewQty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Old Current Quantity.
		@param OldQty Old current quantity before the processing of M_CostDetail
	*/
	public void setOldQty (BigDecimal OldQty)
	{
		set_ValueNoCheck (COLUMNNAME_OldQty, OldQty);
	}

	/** Get Old Current Quantity.
		@return Old current quantity before the processing of M_CostDetail
	  */
	public BigDecimal getOldQty()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_OldQty);
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