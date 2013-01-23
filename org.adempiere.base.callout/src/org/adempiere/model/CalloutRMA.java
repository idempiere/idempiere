/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/

package org.adempiere.model;

import java.math.BigDecimal;
import java.util.Properties;

import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_C_InvoiceLine;
import org.compiere.model.MCharge;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProductPricing;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.Query;
import org.compiere.model.Tax;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 
 * @author Ashley G Ramdass
 */
public class CalloutRMA extends CalloutEngine {

	/**
	 * docType - set document properties based on document type.
	 * 
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return error message or ""
	 */
	public String docType(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) 
	{
		Integer C_DocType_ID = (Integer) value;
		if (C_DocType_ID == null || C_DocType_ID.intValue() == 0)
			return "";

		String sql = "SELECT d.IsSoTrx FROM C_DocType d WHERE C_DocType_ID=?";
		String docSOTrx = DB.getSQLValueString(null, sql, C_DocType_ID);
		boolean isSOTrx = "Y".equals(docSOTrx);
		mTab.setValue(MRMA.COLUMNNAME_IsSOTrx, isSOTrx);

		return "";
	}

	public String inoutline(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) 
	{
		Integer M_InOutLine_ID = (Integer) value;
		if (M_InOutLine_ID == null || M_InOutLine_ID.intValue() == 0)
			return "";

		MInOutLine iol = new MInOutLine(ctx, M_InOutLine_ID, null);

		int invoiceLine_ID = new Query(ctx, I_C_InvoiceLine.Table_Name,
				"M_InOutLine_ID=?", null).setParameters(M_InOutLine_ID)
				.firstId();
		if (invoiceLine_ID <= 0)
			invoiceLine_ID = 0;

		if (invoiceLine_ID != 0) 
		{
			MInvoiceLine invoiceLine = new MInvoiceLine(ctx, invoiceLine_ID, null);
			if (invoiceLine.getM_Product_ID() != 0)
				mTab.setValue(MRMALine.COLUMNNAME_M_Product_ID, invoiceLine.getM_Product_ID());
			if (invoiceLine.getC_Charge_ID() != 0)
				mTab.setValue(MRMALine.COLUMNNAME_C_Charge_ID, invoiceLine.getC_Charge_ID());
			mTab.setValue(MRMALine.COLUMNNAME_Qty, invoiceLine.getQtyEntered());
			mTab.setValue(MRMALine.COLUMNNAME_Amt, invoiceLine.getPriceEntered());
			mTab.setValue(MRMALine.COLUMNNAME_C_Tax_ID, invoiceLine.getC_Tax_ID());
			
			BigDecimal lineNetAmt = invoiceLine.getQtyEntered().multiply(invoiceLine.getPriceEntered());
			int precision = invoiceLine.getPrecision();
			if (lineNetAmt.scale() > precision)
				lineNetAmt = lineNetAmt.setScale(precision, BigDecimal.ROUND_HALF_UP);
			mTab.setValue(MRMALine.COLUMNNAME_LineNetAmt, lineNetAmt);
		} 
		else if (iol.getC_OrderLine_ID() != 0) 
		{
			MOrderLine orderLine = new MOrderLine(ctx, iol.getC_OrderLine_ID(), null);
			if (orderLine.getM_Product_ID() != 0)
				mTab.setValue(MRMALine.COLUMNNAME_M_Product_ID, orderLine.getM_Product_ID());
			if (orderLine.getC_Charge_ID() != 0)
				mTab.setValue(MRMALine.COLUMNNAME_C_Charge_ID, orderLine.getC_Charge_ID());
			mTab.setValue(MRMALine.COLUMNNAME_Qty, orderLine.getQtyEntered());
			mTab.setValue(MRMALine.COLUMNNAME_Amt, orderLine.getPriceEntered());
			mTab.setValue(MRMALine.COLUMNNAME_C_Tax_ID, orderLine.getC_Tax_ID());
			
			BigDecimal lineNetAmt = orderLine.getQtyEntered().multiply(orderLine.getPriceEntered());
			int precision = orderLine.getPrecision();
			if (lineNetAmt.scale() > precision)
				lineNetAmt = lineNetAmt.setScale(precision, BigDecimal.ROUND_HALF_UP);
			mTab.setValue(MRMALine.COLUMNNAME_LineNetAmt, lineNetAmt);
		}

		return "";
	}

	public String product(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) 
	{
		if (isCalloutActive() || value == null)
			return "";
		
		Integer M_Product_ID = (Integer) value;
		if (M_Product_ID == null || M_Product_ID.intValue() == 0)
			return "";

		Integer M_RMA_ID = (Integer) mTab.getValue(MRMALine.COLUMNNAME_M_RMA_ID);
		if (M_RMA_ID == null || M_RMA_ID.intValue() == 0)
			return "";
		
		Integer AD_Org_ID = (Integer) mTab.getValue(MRMALine.COLUMNNAME_AD_Org_ID);
		if (AD_Org_ID == null || AD_Org_ID.intValue() == 0)
			return "";

		MRMA rma = new MRMA(ctx, M_RMA_ID, null);
		MProductPricing pp = new MProductPricing(M_Product_ID, rma.getC_BPartner_ID(), Env.ONE, rma.isSOTrx());
		int taxId = 0;
		int precision = 0;

		MInvoice invoice = rma.getOriginalInvoice();
		if (invoice != null) 
		{
			pp.setM_PriceList_ID(invoice.getM_PriceList_ID());
			pp.setPriceDate(invoice.getDateInvoiced());

			precision = invoice.getPrecision();
			taxId = Tax.get(ctx, M_Product_ID, 0,
					invoice.getDateInvoiced(), invoice.getDateInvoiced(),
					AD_Org_ID, rma.getShipment().getM_Warehouse_ID(), 
					invoice.getC_BPartner_Location_ID(), // should be bill to
					invoice.getC_BPartner_Location_ID(), rma.isSOTrx());
		} 
		else 
		{
			MOrder order = rma.getOriginalOrder();
			if (order != null) 
			{
				pp.setM_PriceList_ID(order.getM_PriceList_ID());
				pp.setPriceDate(order.getDateOrdered());

				precision = order.getPrecision();
				taxId = Tax.get(ctx, M_Product_ID, 0,
						order.getDateOrdered(), order.getDateOrdered(),
						AD_Org_ID, order.getM_Warehouse_ID(), 
						order.getC_BPartner_Location_ID(), // should be bill to
						order.getC_BPartner_Location_ID(), rma.isSOTrx());
			} 
			else
				return "No Invoice/Order found the Shipment/Receipt associated";
		}

		pp.calculatePrice();
		
		mTab.setValue(MRMALine.COLUMNNAME_Qty, Env.ONE);
		mTab.setValue(MRMALine.COLUMNNAME_Amt, pp.getPriceStd());		
		if (taxId != 0)
			mTab.setValue(MRMALine.COLUMNNAME_C_Tax_ID, taxId);
		
		BigDecimal lineNetAmt = Env.ONE.multiply(pp.getPriceStd());
		if (lineNetAmt.scale() > precision)
			lineNetAmt = lineNetAmt.setScale(precision, BigDecimal.ROUND_HALF_UP);
		mTab.setValue(MRMALine.COLUMNNAME_LineNetAmt, lineNetAmt);

		return "";
	}
	
	public String charge(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) 
	{
		if (isCalloutActive() || value == null)
			return "";
		
		Integer C_Charge_ID = (Integer) value;
		if (C_Charge_ID == null || C_Charge_ID.intValue() == 0)
			return "";

		Integer M_RMA_ID = (Integer) mTab.getValue(MRMALine.COLUMNNAME_M_RMA_ID);
		if (M_RMA_ID == null || M_RMA_ID.intValue() == 0)
			return "";
		
		Integer AD_Org_ID = (Integer) mTab.getValue(MRMALine.COLUMNNAME_AD_Org_ID);
		if (AD_Org_ID == null || AD_Org_ID.intValue() == 0)
			return "";
		
		MCharge charge = MCharge.get(ctx, C_Charge_ID);
        
        // Retrieve tax Exempt
        String sql = "SELECT C_Tax_ID FROM C_Tax WHERE AD_Client_ID=? AND IsActive='Y' "
            + "AND IsTaxExempt='Y' AND ValidFrom < SYSDATE ORDER BY IsDefault DESC";        
        // Set tax for charge as exempt        
        int taxId = DB.getSQLValueEx(null, sql, Env.getAD_Client_ID(ctx));
        
        mTab.setValue(MRMALine.COLUMNNAME_Qty, Env.ONE);
		mTab.setValue(MRMALine.COLUMNNAME_Amt, charge.getChargeAmt());		
		if (taxId != 0)
			mTab.setValue(MRMALine.COLUMNNAME_C_Tax_ID, taxId);
		
		MRMA rma = new MRMA(ctx, M_RMA_ID, null);
		int precision = 0;

		MInvoice invoice = rma.getOriginalInvoice();
		if (invoice != null) 
			precision = invoice.getPrecision();
		else 
		{
			MOrder order = rma.getOriginalOrder();
			if (order != null) 
				precision = order.getPrecision();
			else
				return "No Invoice/Order found the Shipment/Receipt associated";
		}
		
		BigDecimal lineNetAmt = Env.ONE.multiply(charge.getChargeAmt());
		if (lineNetAmt.scale() > precision)
			lineNetAmt = lineNetAmt.setScale(precision, BigDecimal.ROUND_HALF_UP);
		mTab.setValue(MRMALine.COLUMNNAME_LineNetAmt, lineNetAmt);		

		return "";
	}
}
