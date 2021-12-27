/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base.event.delegate;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import org.adempiere.base.annotation.ModelEventTopic;
import org.adempiere.base.annotation.EventTopicDelegate;
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.adempiere.base.event.annotations.doc.BeforeComplete;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLine;
import org.compiere.model.MStorageOnHand;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.osgi.service.event.Event;

/**
 * 
 * @author hengsin
 *
 */
@EventTopicDelegate
@ModelEventTopic(modelClass = MInOut.class)
public class AutoProduceEventDelegate extends ModelEventDelegate<MInOut> {
	/**
	 * 
	 * @param po
	 * @param event
	 */
	public AutoProduceEventDelegate(MInOut po, Event event) {	
		super(po, event);
	}

	@BeforeComplete
	public void onBeforeComplete() {
	   MInOut mInOut = getModel();
	   if (mInOut.isSOTrx()) {
		   String msg = processShipment(mInOut);
		   if (msg != null)
			   throw new RuntimeException (msg);
	   }
	}

	private String processShipment(MInOut mInOut) {
		// Auto produce if on hand is not sufficient to fulfill order
		Map<String, BigDecimal> qtyUsedMap = new HashMap<String, BigDecimal>();
		for (MInOutLine line : mInOut.getLines(false)) {
			 
			 MProduct product = new MProduct(mInOut.getCtx(),line.getM_Product_ID(), mInOut.get_TrxName());
			 if (!product.isBOM() || !product.isVerified() || !product.isAutoProduce() || !product.isStocked())
		 		 continue;			 
			 
			 // Find on Hand of product
			 BigDecimal qtyOnHand = MStorageOnHand.getQtyOnHand(line.getM_Product_ID(),line.getM_Warehouse_ID(), line.getM_AttributeSetInstance_ID(), mInOut.get_TrxName());
			 
			 String key = mInOut.getM_InOut_ID() + "_" + line.getM_Product_ID();
			 BigDecimal qty = qtyUsedMap.get(key);
			 if (qty == null) {
				 qty = line.getQtyEntered();
			 } else {
				 qtyOnHand = qtyOnHand.subtract(qty);
				 qty = qty.add(line.getQtyEntered());
			 }
			 qtyUsedMap.put(key, qty);
			 
			 if (qtyOnHand.signum() < 0)
				 qtyOnHand = BigDecimal.ZERO;
			 
			 if (qtyOnHand != null && qtyOnHand.compareTo(line.getQtyEntered()) >= 0) {
			 	 continue;
			 } else {
				 String msg = createProduction(mInOut,line,line.getQtyEntered(),qtyOnHand,line.getM_Product_ID(),new int[]{0},qtyUsedMap);
				 if( msg!=null )
					 return msg;
				 else {					 
					 line.setIsAutoProduce(true);
					 line.saveEx();
				 }
			}
		}
		return null;
	}
	
	private String createProduction(MInOut mInOut, MInOutLine mInOutLine, BigDecimal qtyEntered, BigDecimal qtyOnHand, int endProductID, 
			int[] productionCount, Map<String, BigDecimal> qtyUsedMap) {
		String description=Msg.getElement(Env.getCtx(), "M_InOut_ID", true) +  " " + mInOut.getDocumentNo();

		int M_Locator_ID=0;
		if (endProductID == mInOutLine.getM_Product_ID()) {
			M_Locator_ID = mInOutLine.getM_Locator_ID();
		} else {
			MProduct endProduct = MProduct.get(Env.getCtx(), endProductID);
			M_Locator_ID = endProduct.getM_Locator_ID() > 0 ? endProduct.getM_Locator_ID() : mInOutLine.getM_Locator_ID();
		}
		
		BigDecimal productionQty = qtyOnHand.signum() > 0 ? qtyEntered.subtract(qtyOnHand) : qtyEntered;
		
		// Create production
		MProduction production = new MProduction(mInOut.getCtx(),0, mInOut.get_TrxName());
		production.setDescription(description);
		production.setAD_Org_ID(mInOut.getAD_Org_ID());		
				
		String productionName = Msg.getElement(Env.getCtx(), "M_InOut_ID", true) +  " " +  mInOut.getDocumentNo();
		if (productionCount[0] > 0) {
			productionName = productionName + " #"+(productionCount[0]+1);
		} else {
			productionName = productionName + " #1";
		}
		production.setName(productionName);
		production.setMovementDate(mInOut.getMovementDate());
		production.setPosted(false);
		production.setProcessed(false);
		production.setM_Product_ID(endProductID);
		production.setM_Locator_ID(M_Locator_ID);
		production.setProductionQty(productionQty);
		production.setIsCreated(MProduction.ISCREATED_No);
		production.setIsUseProductionPlan(false);
		if (endProductID == mInOutLine.getM_Product_ID()) {
			production.setM_InOutLine_ID(mInOutLine.getM_InOutLine_ID());
		}
		production.saveEx();
				
		// Create line for end product
		MProductionLine productionline = new MProductionLine(mInOut.getCtx(),0, mInOut.get_TrxName());
		productionline.setM_Production_ID(production.getM_Production_ID());
		productionline.setLine(10);
		productionline.setAD_Org_ID(mInOut.getAD_Org_ID());
		productionline.setM_Product_ID(endProductID);
		productionline.setMovementQty(productionQty);
		productionline.setQtyUsed(BigDecimal.ZERO);
		productionline.setM_Locator_ID(M_Locator_ID);
		productionline.setDescription(Msg.getElement(Env.getCtx(), "M_InOutLine_ID", true) + " #" + mInOutLine.getLine());
		productionline.setIsEndProduct(true);
		productionline.saveEx();
	
		MPPProductBOM bom = MPPProductBOM.getDefault(MProduct.get(Env.getCtx(), endProductID), mInOut.get_TrxName());
		if (bom == null)
			return "Shipment: "+ mInOut.getDocumentNo() + " Line: " + mInOutLine.getLine() +" doesn't contain a valid BOM";
		
		MPPProductBOMLine[] bomLines = bom.getLines();
	    int lineNo = 10; 
		for (MPPProductBOMLine bomLine : bomLines) {
			BigDecimal bomQty = bomLine.getQtyBOM(); 
				 
			MProduct component = new MProduct(mInOut.getCtx(), bomLine.getM_Product_ID(), mInOut.get_TrxName());
			lineNo = lineNo + 10;
			// Create  Line
			productionline = new MProductionLine(mInOut.getCtx(), 0, mInOut.get_TrxName());
			productionline.setM_Production_ID(production.getM_Production_ID());
			productionline.setLine(lineNo);
			productionline.setM_Product_ID(bomLine.getM_Product_ID());
			productionline.setAD_Org_ID(mInOut.getAD_Org_ID());
			productionline.setQtyUsed(productionQty.multiply(bomQty));
			M_Locator_ID = MStorageOnHand.getM_Locator_ID(mInOut.getM_Warehouse_ID(),
					bomLine.getM_Product_ID(), -1,
					productionQty.multiply(bomQty), mInOut.get_TrxName());
			M_Locator_ID = M_Locator_ID > 0 ? M_Locator_ID : (component.getM_Locator_ID() > 0 ? component.getM_Locator_ID() : production.getM_Locator_ID());
			productionline.setM_Locator_ID(M_Locator_ID);
			productionline.setIsEndProduct(false);
			productionline.saveEx();

			if (component.isBOM() && component.isVerified()) {
				BigDecimal onHandComponent = MStorageOnHand.getQtyOnHand(bomLine.getM_Product_ID(),mInOutLine.getM_Warehouse_ID(),0, mInOut.get_TrxName());
				String key = mInOut.getM_InOut_ID() + "_" + bomLine.getM_Product_ID();
				BigDecimal qty = qtyUsedMap.get(key);
				if (qty != null)
					onHandComponent = onHandComponent.subtract(qty);
					 
				// insufficient on hand for component
				if (onHandComponent.compareTo(productionQty.multiply(bomQty)) < 0) {
					boolean produceNestedBOM = component.isBOM() && component.isVerified() && component.isAutoProduce();
					if (produceNestedBOM) {
						productionCount[0] = productionCount[0]+1;
						String error = createProduction(mInOut,mInOutLine,productionQty.multiply(bomQty),onHandComponent,bomLine.getM_Product_ID(),productionCount,qtyUsedMap);
						if (!Util.isEmpty(error)) {
							return error;
						}
					}
				}
			}  
		}

		// Indicate that lines have been created
		production.setIsCreated(MProduction.ISCREATED_Yes);
		production.saveEx();

		//complete the production
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(production, "CO");
		if (pi.isError()) {
			return pi.getSummary();
		}
		return null;
	}
}