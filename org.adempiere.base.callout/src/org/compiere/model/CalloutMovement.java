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
 * Contributor(s): Armen Rizal (armen@goodwill.co.id) Bug Fix 1564496         *
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.Env;

/**
 *	Inventory Movement Callouts
 *	
 *  @author Jorg Janke
 *  @version $Id: CalloutMovement.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1879568 ] CalloutMouvement QtyAvailable issues
 */
public class CalloutMovement extends CalloutEngine
{
	/**
	 *  Product modified
	 * 		Set Attribute Set Instance
	 *		Set UOM
	 *  @param ctx      Context
	 *  @param WindowNo current Window No
	 *  @param mTab     Model Tab
	 *  @param mField   Model Field
	 *  @param value    The new value
	 *  @return Error message or ""
	 */
	public String product (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer M_Product_ID = (Integer)value;
		if (M_Product_ID == null || M_Product_ID.intValue() == 0)
			return "";
		//	Set Attribute
		if (Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_Product_ID") == M_Product_ID.intValue()
			&& Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_AttributeSetInstance_ID") != 0)
			mTab.setValue("M_AttributeSetInstance_ID", Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_AttributeSetInstance_ID"));
		else
			mTab.setValue("M_AttributeSetInstance_ID", 0);
		
		MProduct product = MProduct.get (ctx, M_Product_ID.intValue());
		mTab.setValue("C_UOM_ID", product.getC_UOM_ID());
		mTab.setValue("MovementQty", mTab.getValue("QtyEntered"));

		checkQtyAvailable(ctx, mTab, WindowNo, M_Product_ID, null);
		return "";
	}   //  product
	
	/**
	 *  Movement Line - Quantity
	 *                - enforces Qty UOM relationship
     *	              - called from C_UOM_ID, QtyEntered, MovementQty, M_AttributeSetInstance_ID
	 *  @param ctx      Context
	 *  @param WindowNo current Window No
	 *  @param mTab     Model Tab
	 *  @param mField   Model Field
	 *  @param value    The new value
	 *  @return Error message or ""
	 */
	public String qty(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) {
		if (isCalloutActive() || value == null || mTab.getValue(MMovementLine.COLUMNNAME_M_Product_ID) == null)
			return "";

		BigDecimal movementQty = Env.ZERO;
		BigDecimal qtyEntered = Env.ZERO;
		int C_UOM_To_ID = 0;
		
		int M_Product_ID = (Integer) mTab.getValue(MMovementLine.COLUMNNAME_M_Product_ID);
		if (mField.getColumnName().equals("C_UOM_ID") || mField.getColumnName().equals("QtyEntered")) // Change Movement Qty
		{
			if (mField.getColumnName().equals("C_UOM_ID")) {
				C_UOM_To_ID = ((Integer)value).intValue();
				qtyEntered = (BigDecimal)mTab.getValue("QtyEntered");
			} else if (mField.getColumnName().equals("QtyEntered")) {
				C_UOM_To_ID = (Integer) mTab.getValue(MMovementLine.COLUMNNAME_C_UOM_ID);
				qtyEntered = (BigDecimal)value;
			} 
			
			BigDecimal qtyEntered1 = qtyEntered.setScale(MUOM.getPrecision(ctx, C_UOM_To_ID), RoundingMode.HALF_UP);
			if (qtyEntered.compareTo(qtyEntered1) != 0) {
				if (log.isLoggable(Level.FINE)) log.fine("Corrected QtyEntered Scale UOM=" + C_UOM_To_ID
						+ "; QtyEntered=" + qtyEntered + "->" + qtyEntered1);
				qtyEntered = qtyEntered1;
				mTab.setValue("QtyEntered", qtyEntered);
			}
			movementQty = MUOMConversion.convertProductFrom (ctx, M_Product_ID,C_UOM_To_ID, qtyEntered);
			if (movementQty == null)
				movementQty = qtyEntered;
			
			boolean conversion = qtyEntered.compareTo(movementQty) != 0;
			if (log.isLoggable(Level.FINE))
			log.fine("UOM=" + C_UOM_To_ID + ", qtyEntered=" + qtyEntered + " -> " + conversion + " movementQty="
					+ movementQty);
			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");

			mTab.setValue("MovementQty", movementQty);
		} else if (mField.getColumnName().equals("MovementQty")) //MovementQty - triggered by a different callout, for example 
		{
			C_UOM_To_ID = (Integer) mTab.getValue(MMovementLine.COLUMNNAME_C_UOM_ID);
			movementQty = (BigDecimal)value;
			int precision = MProduct.get(ctx, M_Product_ID).getUOMPrecision();

			BigDecimal movementQty1 = movementQty.setScale(precision, RoundingMode.HALF_UP);
			if (movementQty.compareTo(movementQty1) != 0) {
				if (log.isLoggable(Level.FINE)) log.fine("Corrected MovementQty Scale "
					+ movementQty + "->" + movementQty1);
				movementQty = movementQty1;
				mTab.setValue("MovementQty", movementQty);
			}
			qtyEntered = MUOMConversion.convertProductTo (ctx, M_Product_ID, C_UOM_To_ID, movementQty);
			if (qtyEntered == null)
				qtyEntered = movementQty;
			boolean conversion = movementQty.compareTo(qtyEntered) != 0;
			if (log.isLoggable(Level.FINE)) log.fine("UOM=" + C_UOM_To_ID
				+ ", MovementQty=" + movementQty
				+ " -> " + conversion
				+ " QtyEntered=" + qtyEntered);
			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");
			mTab.setValue("QtyEntered", qtyEntered);
		} else { //ASI
			movementQty = (BigDecimal)mTab.getValue("MovementQty");
		}

		checkQtyAvailable(ctx, mTab, WindowNo, M_Product_ID, movementQty);
		return "";
	} //  qty
	
	/**
	 * Movement Line - Locator modified
	 * 
	 * @param ctx      Context
	 * @param WindowNo current Window No
	 * @param mTab     Model Tab
	 * @param mField   Model Field
	 * @param value    The new value
	 * @return Error message or ""
	 */
	public String locator(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) {
		if (value == null)
			return "";
		int M_Product_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "M_Product_ID");
		checkQtyAvailable(ctx, mTab, WindowNo, M_Product_ID, null);
		return "";
	}

	/**
	 * Check available qty
	 * 
	 * @param ctx context
	 * @param mTab Model Tab
	 * @param WindowNo current Window No
	 * @param M_Product_ID product ID
	 * @param MovementQty movement qty (if null will be get from context "MovementQty")
	 */
	private void checkQtyAvailable(Properties ctx, GridTab mTab, int WindowNo, int M_Product_ID, BigDecimal MovementQty) {
		// Begin Armen 2006/10/01
		if (M_Product_ID != 0) {
			MProduct product = MProduct.get(ctx, M_Product_ID);
			if (product.isStocked()) {
				if (MovementQty == null)
					MovementQty = (BigDecimal) mTab.getValue("MovementQty");
				int M_Locator_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "M_Locator_ID");
				// If no locator, don't check anything and assume is ok
				if (M_Locator_ID <= 0)
					return;
				int M_AttributeSetInstance_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "M_AttributeSetInstance_ID");
				BigDecimal available = MStorageOnHand.getQtyOnHandForLocator(M_Product_ID, M_Locator_ID, M_AttributeSetInstance_ID, null);
				
				if (available == null)
					available = Env.ZERO;
				if (available.signum() == 0)
					mTab.fireDataStatusEEvent("NoQtyAvailable", "0", false);
				else if (available.compareTo(MovementQty) < 0)
					mTab.fireDataStatusEEvent("InsufficientQtyAvailable", available.toString(), false);
			}
		}
		// End Armen
	}
}	//	CalloutMove