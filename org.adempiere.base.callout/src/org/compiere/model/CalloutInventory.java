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
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.Env;

/**
 *	Physical Inventory Callouts
 *	
 *  @author Jorg Janke
 *  @version $Id: CalloutInventory.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class CalloutInventory extends CalloutEngine
{
	/**
	 *  Product/Locator/ASI modified.
	 * 		Set Attribute Set Instance
	 *
	 *  @param ctx      Context
	 *  @param WindowNo current Window No
	 *  @param mTab     Model Tab
	 *  @param mField   Model Field
	 *  @param value    The new value
	 *  @return Error message or ""
	 */
	public String product (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive())
			return "";

		// set docSubTypeInv
		int doctypeid = Env.getContextAsInt(ctx, WindowNo, "C_DocType_ID");
		String docSubTypeInv = null;
		if (doctypeid > 0) {
			MDocType dt = MDocType.get(ctx, doctypeid);
			docSubTypeInv = dt.getDocSubTypeInv();
		}

		if ("M_Product_ID".equals(mField.getColumnName())) {
			// product changed - remove old ASI
			mTab.setValue("M_AttributeSetInstance_ID", 0);
		}

		//	Get Book Value
		int M_Product_ID = 0;
		Integer Product = (Integer)mTab.getValue("M_Product_ID");
		if (Product != null)
			M_Product_ID = Product.intValue();
		if (M_Product_ID == 0)
			return "";
		int M_Locator_ID = 0;
		Integer Locator = (Integer)mTab.getValue("M_Locator_ID");
		if (Locator != null)
			M_Locator_ID = Locator.intValue();
		if (M_Locator_ID == 0)
			return "";
		
		//	Set Attribute
		int M_AttributeSetInstance_ID = 0; 
		Integer ASI = (Integer)mTab.getValue("M_AttributeSetInstance_ID");
		if (ASI != null)
			M_AttributeSetInstance_ID = ASI.intValue();
		//	Product Selection
		if (MInventoryLine.COLUMNNAME_M_Product_ID.equals(mField.getColumnName()))
		{
			if (Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_Product_ID") == M_Product_ID)
			{
				M_AttributeSetInstance_ID = Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_AttributeSetInstance_ID");
			}
			else
			{
				M_AttributeSetInstance_ID = 0;
			}
			if (M_AttributeSetInstance_ID != 0)
				mTab.setValue(MInventoryLine.COLUMNNAME_M_AttributeSetInstance_ID, M_AttributeSetInstance_ID);
			else
				mTab.setValue(MInventoryLine.COLUMNNAME_M_AttributeSetInstance_ID, 0);

			// Set UOM from product and reset QtyEntered
			MProduct product = MProduct.get(ctx, M_Product_ID);
			if (product != null) {
				mTab.setValue("C_UOM_ID", product.getC_UOM_ID());
				mTab.setValue("QtyEntered", Env.ZERO);
				mTab.setValue("QtyCount", Env.ZERO);
				mTab.setValue("QtyInternalUse", Env.ZERO);
			}
		}
			
		// Set QtyBook from first storage location
		// kviiksaar: Call's now the extracted function
		BigDecimal bd = null;
		if (MDocType.DOCSUBTYPEINV_PhysicalInventory.equals(docSubTypeInv)) {
			try {
				String trxName = null;
				if (   mTab != null
					&& mTab.getTableModel() != null) {
					GridTable gt = mTab.getTableModel();
					if (gt.isImporting()) {
						trxName = gt.get_TrxName();
					}
				}
				if (mTab.getValue("M_Inventory_ID") == null)
					return null;
				MInventory inventory = new MInventory(ctx, (Integer) mTab.getValue("M_Inventory_ID"), trxName);
				bd = MStorageOnHand.getQtyOnHandForLocatorWithASIMovementDate(M_Product_ID, M_Locator_ID, 
						M_AttributeSetInstance_ID, inventory.getMovementDate(), trxName);
				mTab.setValue("QtyBook", bd);
			} catch (Exception e) {
				return e.getLocalizedMessage();
			}
		}
		
		//
		if (log.isLoggable(Level.INFO)) log.info("M_Product_ID=" + M_Product_ID 
			+ ", M_Locator_ID=" + M_Locator_ID
			+ ", M_AttributeSetInstance_ID=" + M_AttributeSetInstance_ID
			+ " - QtyBook=" + bd);
		return "";
	}   //  product

	/**
	 *	Inventory Line - Quantity / UOM.
	 *		- called from C_UOM_ID, QtyEntered
	 *		- converts QtyEntered to product UOM and stores in QtyCount (Physical) or QtyInternalUse (Internal Use)
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab model
	 *	@param mField field model
	 *	@param value new value
	 *	@return error message or ""
	 */
	public String qty (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive() || value == null)
			return "";

		int M_Product_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "M_Product_ID");
		if (M_Product_ID == 0)
			return "";

		int doctypeid = Env.getContextAsInt(ctx, WindowNo, "C_DocType_ID");
		String docSubTypeInv = null;
		if (doctypeid > 0) {
			MDocType dt = MDocType.get(ctx, doctypeid);
			docSubTypeInv = dt.getDocSubTypeInv();
		}
		// CostAdjustment lines don't use QtyEntered
		if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(docSubTypeInv))
			return "";

		int C_UOM_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "C_UOM_ID");
		if (C_UOM_ID == 0)
			return "";

		BigDecimal QtyEntered;

		// UOM changed - re-scale QtyEntered to new UOM precision and reconvert
		if (mField.getColumnName().equals("C_UOM_ID")) {
			int C_UOM_To_ID = ((Integer) value).intValue();
			QtyEntered = (BigDecimal) mTab.getValue("QtyEntered");
			if (QtyEntered == null)
				QtyEntered = Env.ZERO;
			BigDecimal QtyEntered1 = QtyEntered.setScale(MUOM.getPrecision(ctx, C_UOM_To_ID), RoundingMode.HALF_UP);
			if (QtyEntered.compareTo(QtyEntered1) != 0) {
				QtyEntered = QtyEntered1;
				mTab.setValue("QtyEntered", QtyEntered);
			}
		} else {
			// QtyEntered changed
			QtyEntered = (BigDecimal) value;
			BigDecimal QtyEntered1 = QtyEntered.setScale(MUOM.getPrecision(ctx, C_UOM_ID), RoundingMode.HALF_UP);
			if (QtyEntered.compareTo(QtyEntered1) != 0) {
				QtyEntered = QtyEntered1;
				mTab.setValue("QtyEntered", QtyEntered);
			}
		}

		// Convert QtyEntered (entered UOM) -> stock UOM
		BigDecimal qtyConverted = MUOMConversion.convertProductFrom(ctx, M_Product_ID, C_UOM_ID, QtyEntered);
		if (qtyConverted == null)
			qtyConverted = QtyEntered;

		if (MDocType.DOCSUBTYPEINV_InternalUseInventory.equals(docSubTypeInv))
			mTab.setValue("QtyInternalUse", qtyConverted);
		else if (MDocType.DOCSUBTYPEINV_PhysicalInventory.equals(docSubTypeInv))
			mTab.setValue("QtyCount", qtyConverted);

		return "";
	}	//	qty

}	//	CalloutInventory
