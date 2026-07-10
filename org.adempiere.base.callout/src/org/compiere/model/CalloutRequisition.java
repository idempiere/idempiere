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
package org.compiere.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.IProductPricing;
import org.adempiere.model.GridTabWrapper;
import org.compiere.util.Env;

/**
 *	Requisition Callouts
 *  @author Jorg Janke
 *  @version $Id: CalloutRequisition.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class CalloutRequisition extends CalloutEngine
{
	/**
	 *	Requisition Line - Product.
	 *		- PriceStd
	 *  @param ctx context
	 *  @param WindowNo current Window No
	 *  @param mTab Grid Tab
	 *  @param mField Grid Field
	 *  @param value New Value
	 *  @return null or error message
	 */
	public String product (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer M_Product_ID = (Integer)value;
		if (M_Product_ID == null || M_Product_ID.intValue() == 0)
			return "";
		final I_M_Requisition req = GridTabWrapper.create(mTab.getParentTab(), I_M_Requisition.class);
		final I_M_RequisitionLine line = GridTabWrapper.create(mTab, I_M_RequisitionLine.class);
		setPrice(ctx, WindowNo, req, line, mTab);
		MProduct product = MProduct.get(ctx, M_Product_ID);
		line.setC_UOM_ID(product.getC_UOM_ID());
		line.setQtyOrdered(line.getQty());

		return amt(ctx, WindowNo, mTab, mField, value);
	}	//	product

	/**
	 * Requisition line - Qty
	 * 	- Price, LineNetAmt
	 *  @param ctx context
	 *  @param WindowNo current Window No
	 *  @param mTab Grid Tab
	 *  @param mField Grid Field
	 *  @param value New Value
	 *  @return null or error message
	 */
	public String amt (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive() || value == null)
			return "";
		
		final I_M_Requisition req = GridTabWrapper.create(mTab.getParentTab(), I_M_Requisition.class);
		final I_M_RequisitionLine line = GridTabWrapper.create(mTab, I_M_RequisitionLine.class);

		int C_UOM_To_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), I_M_RequisitionLine.COLUMNNAME_C_UOM_ID);
		int M_Product_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), I_M_RequisitionLine.COLUMNNAME_M_Product_ID);
		int M_PriceList_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), I_M_Requisition.COLUMNNAME_M_PriceList_ID);
		int StdPrecision = MPriceList.getStandardPrecision(ctx, M_PriceList_ID);

		BigDecimal Qty, QtyOrdered, PriceEntered, PriceActual;
		// get values
		Qty = (BigDecimal) mTab.getValue(I_M_RequisitionLine.COLUMNNAME_Qty);
		QtyOrdered = (BigDecimal) mTab.getValue(I_M_RequisitionLine.COLUMNNAME_QtyOrdered);
		if (log.isLoggable(Level.FINE))
			log.fine("Qty=" + Qty + ", Ordered=" + QtyOrdered + ", UOM=" + C_UOM_To_ID);
		//
		PriceEntered = (BigDecimal) mTab.getValue(I_M_RequisitionLine.COLUMNNAME_PriceEntered);
		PriceActual = (BigDecimal) mTab.getValue(I_M_RequisitionLine.COLUMNNAME_PriceActual);
		if (log.isLoggable(Level.FINE))
		{
			log.fine("PriceEntered=" + PriceEntered + ", Actual=" + PriceActual);
		}

		// Qty changed - recalc price
		if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_Qty)
				&& "Y".equals(Env.getContext(ctx, WindowNo, "DiscountSchema")))
		{
			setPrice(ctx, WindowNo, req, line, mTab);
		}

		// No Product
		if (M_Product_ID == 0)
		{
			// if price change sync price actual and entered
			// else ignore
			if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_PriceActual))
			{
				PriceEntered = (BigDecimal) value;
				mTab.setValue(I_M_RequisitionLine.COLUMNNAME_PriceEntered, value);
			}
			else if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_PriceEntered))
			{
				PriceActual = (BigDecimal) value;
				mTab.setValue(I_M_RequisitionLine.COLUMNNAME_PriceActual, value);
			}
		}
		// Product Qty changed - recalc price
		else if ((mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_QtyOrdered)
				|| mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_Qty)
				|| mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_C_UOM_ID) 
				|| mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_M_Product_ID))
				&& !"N".equals(Env.getContext(ctx, WindowNo, "DiscountSchema")))
		{
			int C_BPartner_ID = Env.getContextAsInt(ctx, WindowNo, I_M_RequisitionLine.COLUMNNAME_C_BPartner_ID);
			if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_Qty))
				QtyOrdered = MUOMConversion.convertProductFrom(ctx, M_Product_ID, C_UOM_To_ID, Qty);
			if (QtyOrdered == null)
				QtyOrdered = Qty;
			boolean isSOTrx = false;
			MProductPricing pp = new MProductPricing(M_Product_ID, C_BPartner_ID, QtyOrdered, isSOTrx);
			//
			pp.setM_PriceList_ID(M_PriceList_ID);
			int M_PriceList_Version_ID = Env.getContextAsInt(ctx, WindowNo, "M_PriceList_Version_ID");
			pp.setM_PriceList_Version_ID(M_PriceList_Version_ID);
			Timestamp orderDate = req.getDateRequired();
			pp.setPriceDate(orderDate);
			//
			PriceEntered = MUOMConversion.convertProductFrom(ctx, M_Product_ID, C_UOM_To_ID, pp.getPriceStd());
			if (PriceEntered == null)
				PriceEntered = pp.getPriceStd();
			//
			if (log.isLoggable(Level.FINE))
				log.fine("QtyChanged -> PriceActual=" + pp.getPriceStd() + ", PriceEntered=" + PriceEntered);
			PriceActual = pp.getPriceStd();
			PriceEntered = pp.getPriceStd();
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_PriceActual, PriceEntered);
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_PriceEntered, PriceActual);
			Env.setContext(ctx, WindowNo, "DiscountSchema", pp.isDiscountSchema() ? "Y" : "N");
		}
		else if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_PriceActual))
		{
			PriceActual = (BigDecimal) value;
			PriceEntered = MUOMConversion.convertProductFrom(ctx, M_Product_ID, C_UOM_To_ID, PriceActual);
			if (PriceEntered == null)
				PriceEntered = PriceActual;
			//
			if (log.isLoggable(Level.FINE))
				log.fine("PriceActual=" + PriceActual + " -> PriceEntered=" + PriceEntered);
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_PriceEntered, PriceEntered);
		}
		else if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_PriceEntered))
		{
			PriceEntered = (BigDecimal) value;
			PriceActual = MUOMConversion.convertProductTo(ctx, M_Product_ID, C_UOM_To_ID, PriceEntered);
			if (PriceActual == null)
				PriceActual = PriceEntered;
			//
			if (log.isLoggable(Level.FINE))
				log.fine("PriceEntered=" + PriceEntered + " -> PriceActual=" + PriceActual);
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_PriceActual, PriceActual);
		}

		if (log.isLoggable(Level.FINE))
			log.fine("PriceEntered=" + PriceEntered + ", Actual=" + PriceActual);

		// Line Net Amt
		BigDecimal LineNetAmt = QtyOrdered.multiply(PriceActual);
		if (LineNetAmt.scale() > StdPrecision)
			LineNetAmt = LineNetAmt.setScale(StdPrecision, RoundingMode.HALF_UP);
		line.setLineNetAmt(LineNetAmt);
		if (log.isLoggable(Level.INFO)) log.info("amt - LineNetAmt=" + LineNetAmt);
		//
		return "";
	}	//	amt

	private void setPrice(Properties ctx, int WindowNo, I_M_Requisition req, I_M_RequisitionLine line, GridTab mTab)
	{
		int C_BPartner_ID = line.getC_BPartner_ID();
		BigDecimal Qty = line.getQty();
		boolean isSOTrx = false;
		IProductPricing pp = Core.getProductPricing();
		pp.setInitialValues(line.getM_Product_ID(), C_BPartner_ID, Qty, isSOTrx, null);
		//
		int M_PriceList_ID = Env.getContextAsInt(ctx, WindowNo, "M_PriceList_ID");
		pp.setM_PriceList_ID(M_PriceList_ID);
		int M_PriceList_Version_ID = Env.getContextAsInt(ctx, WindowNo, "M_PriceList_Version_ID");
		pp.setM_PriceList_Version_ID(M_PriceList_Version_ID);
		Timestamp orderDate = req.getDateRequired();
		pp.setPriceDate(orderDate);
		//
		line.setPriceActual(pp.getPriceStd());
		line.setPriceEntered(pp.getPriceStd());
		Env.setContext(ctx, WindowNo, "EnforcePriceLimit", pp.isEnforcePriceLimit() ? "Y" : "N");	//	not used
		Env.setContext(ctx, WindowNo, "DiscountSchema", pp.isDiscountSchema() ? "Y" : "N");
	}

	/**
	 * Requisition Line - Quantity. - called from C_UOM_ID, Qty, QtyOrdered -
	 * enforces qty UOM relationship
	 * 
	 * @param ctx context
	 * @param WindowNo current Window No
	 * @param mTab Grid Tab
	 * @param mField Grid Field
	 * @param value New Value
	 * @return null or error message
	 */
	public String qty(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive() || value == null)
			return "";

		int M_Product_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(),
				I_M_RequisitionLine.COLUMNNAME_M_Product_ID);

		BigDecimal QtyOrdered = Env.ZERO;
		BigDecimal Qty, PriceActual, PriceEntered;

		// No Product
		if (M_Product_ID == 0)
		{
			Qty = (BigDecimal) mTab.getValue(I_M_RequisitionLine.COLUMNNAME_Qty);
			QtyOrdered = Qty;
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_QtyOrdered, QtyOrdered);
		}
		// UOM Changed - convert from Entered -> Product
		else if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_C_UOM_ID))
		{
			int C_UOM_To_ID = ((Integer) value).intValue();
			Qty = (BigDecimal) mTab.getValue(I_M_RequisitionLine.COLUMNNAME_Qty);
			BigDecimal Qty1 = Qty.setScale(MUOM.getPrecision(ctx, C_UOM_To_ID), BigDecimal.ROUND_HALF_UP);

			if (Qty.compareTo(Qty1) != 0)
			{
				if (log.isLoggable(Level.FINE))
					log.fine("Corrected Qty Scale UOM=" + C_UOM_To_ID + "; Qty=" + Qty + "->" + Qty1);
				Qty = Qty1;
				mTab.setValue("Qty", Qty);
			}

			QtyOrdered = MUOMConversion.convertProductFrom(ctx, M_Product_ID, C_UOM_To_ID, Qty);
			if (QtyOrdered == null)
				QtyOrdered = Qty;

			boolean conversion = Qty.compareTo(QtyOrdered) != 0;
			PriceActual = (BigDecimal) mTab.getValue(I_M_RequisitionLine.COLUMNNAME_PriceActual);
			PriceEntered = MUOMConversion.convertProductFrom(ctx, M_Product_ID, C_UOM_To_ID, PriceActual);
			if (PriceEntered == null)
				PriceEntered = PriceActual;
			if (log.isLoggable(Level.FINE))
				log.fine("UOM=" + C_UOM_To_ID + ", Qty/PriceActual=" + Qty + "/" + PriceActual + " -> " + conversion
						+ " QtyOrdered/PriceEntered=" + QtyOrdered + "/" + PriceEntered);
			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_QtyOrdered, QtyOrdered);
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_PriceEntered, PriceEntered);
		}
		// Qty changed - calculate QtyOrdered
		else if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_Qty))
		{
			int C_UOM_To_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(),
					I_M_RequisitionLine.COLUMNNAME_C_UOM_ID);
			Qty = (BigDecimal) value;
			BigDecimal Qty1 = Qty.setScale(MUOM.getPrecision(ctx, C_UOM_To_ID), BigDecimal.ROUND_HALF_UP);

			if (Qty.compareTo(Qty1) != 0)
			{
				if (log.isLoggable(Level.FINE))
					log.fine("Corrected Qty Scale UOM=" + C_UOM_To_ID + "; Qty=" + Qty + "->" + Qty1);
				Qty = Qty1;
				mTab.setValue(I_M_RequisitionLine.COLUMNNAME_Qty, Qty);
			}
			QtyOrdered = MUOMConversion.convertProductFrom(ctx, M_Product_ID, C_UOM_To_ID, Qty);
			if (QtyOrdered == null)
				QtyOrdered = Qty;
			boolean conversion = Qty.compareTo(QtyOrdered) != 0;

			if (log.isLoggable(Level.FINE))
				log.fine("UOM=" + C_UOM_To_ID + ", Qty=" + Qty + " -> " + conversion + " QtyOrdered=" + QtyOrdered);

			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_QtyOrdered, QtyOrdered);
		}
		// QtyOrdered changed - calculate Qty (should not happen)
		else if (mField.getColumnName().equals(I_M_RequisitionLine.COLUMNNAME_QtyOrdered))
		{
			int C_UOM_To_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(),
					I_M_RequisitionLine.COLUMNNAME_C_UOM_ID);
			QtyOrdered = (BigDecimal) value;
			int precision = MProduct.get(ctx, M_Product_ID).getUOMPrecision();
			BigDecimal QtyOrdered1 = QtyOrdered.setScale(precision, BigDecimal.ROUND_HALF_UP);

			if (QtyOrdered.compareTo(QtyOrdered1) != 0)
			{
				if (log.isLoggable(Level.FINE))
					log.fine("Corrected QtyOrdered Scale " + QtyOrdered + "->" + QtyOrdered1);
				QtyOrdered = QtyOrdered1;
				mTab.setValue(I_M_RequisitionLine.COLUMNNAME_QtyOrdered, QtyOrdered);
			}
			Qty = MUOMConversion.convertProductTo(ctx, M_Product_ID, C_UOM_To_ID, QtyOrdered);
			if (Qty == null)
				Qty = QtyOrdered;
			boolean conversion = QtyOrdered.compareTo(Qty) != 0;
			if (log.isLoggable(Level.FINE))
				log.fine("UOM=" + C_UOM_To_ID + ", QtyOrdered=" + QtyOrdered + " -> " + conversion + " Qty=" + Qty);
			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");
			mTab.setValue(I_M_RequisitionLine.COLUMNNAME_Qty, Qty);
		}
		else
		{
			QtyOrdered = (BigDecimal) mTab.getValue(I_M_RequisitionLine.COLUMNNAME_QtyOrdered);
		}

		return "";
	} // qty

} // CalloutRequisition
