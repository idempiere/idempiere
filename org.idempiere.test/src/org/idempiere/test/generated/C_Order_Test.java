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
package org.idempiere.test.generated;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.*;
import org.compiere.model.GridTab;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.compiere.util.Util;

/** Generated accessor for C_Order, EntityType IN ('D') AND c.ColumnName IN ('C_BPartner_ID','C_Order_ID','C_DocType_ID','IsSOTrx','Description','DocumentNo','GrandTotal','DateOrdered','DeliveryRule')
 *  Usage: C_Order_Test.of(po).get...() / set...(...), then po.saveEx(); in a callout C_Order_Test.of(mTab)
 *  @author iDempiere (generated) 
 *  @version Release 14
 */
public final class C_Order_Test
{
    /** TableName=C_Order */
    public static final String Table_Name = "C_Order";

    /** Column name C_BPartner_ID */
    public static final String COLUMNNAME_C_BPartner_ID = "C_BPartner_ID";
    /** Column name C_DocType_ID */
    public static final String COLUMNNAME_C_DocType_ID = "C_DocType_ID";
    /** Column name C_Order_ID */
    public static final String COLUMNNAME_C_Order_ID = "C_Order_ID";
    /** Column name DateOrdered */
    public static final String COLUMNNAME_DateOrdered = "DateOrdered";
    /** Column name DeliveryRule */
    public static final String COLUMNNAME_DeliveryRule = "DeliveryRule";
    /** Column name Description */
    public static final String COLUMNNAME_Description = "Description";
    /** Column name DocumentNo */
    public static final String COLUMNNAME_DocumentNo = "DocumentNo";
    /** Column name GrandTotal */
    public static final String COLUMNNAME_GrandTotal = "GrandTotal";
    /** Column name IsSOTrx */
    public static final String COLUMNNAME_IsSOTrx = "IsSOTrx";

	/** DeliveryRule AD_Reference_ID=151 */
	public static final int DELIVERYRULE_AD_Reference_ID=151;
	/** Availability = A */
	public static final String DELIVERYRULE_Availability = "A";
	/** Custom = C */
	public static final String DELIVERYRULE_Custom = "C";
	/** Force = F */
	public static final String DELIVERYRULE_Force = "F";
	/** Complete Line = L */
	public static final String DELIVERYRULE_CompleteLine = "L";
	/** Manual = M */
	public static final String DELIVERYRULE_Manual = "M";
	/** Complete Order = O */
	public static final String DELIVERYRULE_CompleteOrder = "O";
	/** After Payment = R */
	public static final String DELIVERYRULE_AfterPayment = "R";

	/** model object, or null when the accessor works on a grid tab */
	private final PO po;
	/** grid tab of a callout, or null when the accessor works on a model object */
	private final GridTab tab;

	private C_Order_Test (PO po, GridTab tab)
	{
		this.po = po;
		this.tab = tab;
	}

	/**
	 * @param po a model object of C_Order
	 * @return accessor of the given object
	 */
	public static C_Order_Test of (PO po)
	{
		if (po == null || !Table_Name.equalsIgnoreCase(po.get_TableName()))
			throw new IllegalArgumentException("Not a " + Table_Name + " object - " + po);
		return new C_Order_Test(po, null);
	}

	/**
	 * @param tab a grid tab of C_Order, for example the mTab of a callout
	 * @return accessor of the current row of the tab
	 */
	public static C_Order_Test of (GridTab tab)
	{
		if (tab == null || !Table_Name.equalsIgnoreCase(tab.getTableName()))
			throw new IllegalArgumentException("Not a " + Table_Name + " tab - " + tab);
		return new C_Order_Test(null, tab);
	}

	/** @return the wrapped model object, null for a grid tab */
	public PO getPO()
	{
		return po;
	}

	/** @return the wrapped grid tab, null for a model object */
	public GridTab getGridTab()
	{
		return tab;
	}

	private Object get_Value (String columnName)
	{
		return po != null ? po.get_Value(columnName) : tab.getValue(columnName);
	}

	private void set_Value (String columnName, Object value)
	{
		if (po != null)
			po.set_Value(columnName, value);
		else
			setTabValue(columnName, value);
	}

	private void set_ValueNoCheck (String columnName, Object value)
	{
		if (po != null)
			po.set_ValueNoCheck(columnName, value);
		else
			setTabValue(columnName, value);
	}

	private void setTabValue (String columnName, Object value)
	{
		if (tab.getField(columnName) == null)
			throw new AdempiereException("Column not found - " + Table_Name + "." + columnName);
		String error = tab.setValue(columnName, value);
		if (!Util.isEmpty(error, true))
			throw new AdempiereException(error);
	}

	private Properties getCtx()
	{
		return po != null ? po.getCtx() : Env.getCtx();
	}

	private String get_TrxName()
	{
		return po != null ? po.get_TrxName() : tab.getTableModel().get_TrxName();
	}

	/** Set Business Partner */
	public void setC_BPartner_ID (int C_BPartner_ID)
	{
		if (C_BPartner_ID < 1)
			set_Value (COLUMNNAME_C_BPartner_ID, null);
		else
			set_Value (COLUMNNAME_C_BPartner_ID, Integer.valueOf(C_BPartner_ID));
	}

	/** Get Business Partner */
	public int getC_BPartner_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException
	{
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_ID)
			.getPO(getC_BPartner_ID(), get_TrxName());
	}

	/** Set Document Type */
	public void setC_DocType_ID (int C_DocType_ID)
	{
		if (C_DocType_ID < 0)
			set_ValueNoCheck (COLUMNNAME_C_DocType_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_DocType_ID, Integer.valueOf(C_DocType_ID));
	}

	/** Get Document Type */
	public int getC_DocType_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_DocType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_C_DocType getC_DocType() throws RuntimeException
	{
		return (org.compiere.model.I_C_DocType)MTable.get(getCtx(), org.compiere.model.I_C_DocType.Table_ID)
			.getPO(getC_DocType_ID(), get_TrxName());
	}

	/** Set Order */
	public void setC_Order_ID (int C_Order_ID)
	{
		if (C_Order_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_Order_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_Order_ID, Integer.valueOf(C_Order_ID));
	}

	/** Get Order */
	public int getC_Order_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Order_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Date Ordered */
	public void setDateOrdered (Timestamp DateOrdered)
	{
		set_Value (COLUMNNAME_DateOrdered, DateOrdered);
	}

	/** Get Date Ordered */
	public Timestamp getDateOrdered()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateOrdered);
	}

	/** Set Delivery Rule */
	public void setDeliveryRule (String DeliveryRule)
	{
		set_Value (COLUMNNAME_DeliveryRule, DeliveryRule);
	}

	/** Get Delivery Rule */
	public String getDeliveryRule()
	{
		return (String)get_Value(COLUMNNAME_DeliveryRule);
	}

	/** Set Description */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Document No */
	public void setDocumentNo (String DocumentNo)
	{
		set_ValueNoCheck (COLUMNNAME_DocumentNo, DocumentNo);
	}

	/** Get Document No */
	public String getDocumentNo()
	{
		return (String)get_Value(COLUMNNAME_DocumentNo);
	}

	/** Set Grand Total */
	public void setGrandTotal (BigDecimal GrandTotal)
	{
		set_ValueNoCheck (COLUMNNAME_GrandTotal, GrandTotal);
	}

	/** Get Grand Total */
	public BigDecimal getGrandTotal()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_GrandTotal);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Sales Transaction */
	public void setIsSOTrx (boolean IsSOTrx)
	{
		set_Value (COLUMNNAME_IsSOTrx, Boolean.valueOf(IsSOTrx));
	}

	/** Get Sales Transaction */
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
}
