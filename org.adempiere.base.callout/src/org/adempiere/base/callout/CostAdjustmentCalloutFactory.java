/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base.callout;

import java.math.BigDecimal;
import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.IColumnCalloutFactory;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_M_InventoryLine;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostElement;
import org.compiere.model.MDocType;
import org.compiere.model.MInventory;
import org.compiere.model.MProduct;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * @author hengsin
 *
 */
public class CostAdjustmentCalloutFactory implements IColumnCalloutFactory {

	/**
	 * 
	 */
	public CostAdjustmentCalloutFactory() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IColumnCalloutFactory#getColumnCallouts(java.lang.String, java.lang.String)
	 */
	@Override
	public IColumnCallout[] getColumnCallouts(String tableName,
			String columnName) {
		if (tableName.equalsIgnoreCase(I_M_InventoryLine.Table_Name)) { 
			if (columnName.equalsIgnoreCase(I_M_InventoryLine.COLUMNNAME_M_Product_ID))
				return new IColumnCallout[]{new CostAdjustmentLineProduct()};
			else if (columnName.equalsIgnoreCase(I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID))
				return new IColumnCallout[]{new CostAdjustmentLineASI()};
		}
		
		return null;
	}

	/**
	 * callout for m_product_id 
	 */
	private static class CostAdjustmentLineProduct implements IColumnCallout {
		@Override
		public String start(Properties ctx, int WindowNo, GridTab mTab,
				GridField mField, Object value, Object oldValue) {
			MInventory inventory = MInventory.get(ctx, (Integer) mTab.getValue("M_Inventory_ID"));
			if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(inventory.getC_DocType().getDocSubTypeInv())) {
				String costingMethod = inventory.getCostingMethod();
				if (value == null) {
					mTab.setValue(I_M_InventoryLine.COLUMNNAME_CurrentCostPrice, BigDecimal.ZERO);
					mTab.setValue(I_M_InventoryLine.COLUMNNAME_NewCostPrice, BigDecimal.ZERO);
				} else {
					MProduct product = MProduct.get(ctx, (Integer) value);
					MClient client = MClient.get(ctx);
					MAcctSchema as = client.getAcctSchema();
					Object asiValue = mTab.getValue(I_M_InventoryLine.COLUMNNAME_M_AttributeSetInstance_ID);
					int M_ASI_ID = asiValue != null ? (Integer)asiValue : 0;
					int AD_Org_ID = inventory.getAD_Org_ID();
					MCost cost = product.getCostingRecord(as, AD_Org_ID, M_ASI_ID, costingMethod);					
					if (cost == null) {
						if (!MCostElement.COSTINGMETHOD_StandardCosting.equals(costingMethod)) {
							mTab.setValue(mField, null);
							return Msg.getMsg(Env.getCtx(), "NoCostingRecord");
						}
					}
					mTab.setValue(I_M_InventoryLine.COLUMNNAME_CurrentCostPrice, cost.getCurrentCostPrice());
					mTab.setValue(I_M_InventoryLine.COLUMNNAME_NewCostPrice, cost.getCurrentCostPrice());								
				}
			}
			return null;
		}
	}
	
	/**
	 * callout for m_attributesetinstance_id 
	 */
	private class CostAdjustmentLineASI implements IColumnCallout {
		@Override
		public String start(Properties ctx, int WindowNo, GridTab mTab,
				GridField mField, Object value, Object oldValue) {
			MInventory inventory = MInventory.get(ctx, (Integer) mTab.getValue("M_Inventory_ID"));
			if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(inventory.getC_DocType().getDocSubTypeInv())) {
				String costingMethod = inventory.getCostingMethod();
				Object productValue = mTab.getValue(I_M_InventoryLine.COLUMNNAME_M_Product_ID);
				if (productValue == null || ((Integer)productValue).intValue() == 0) return null;
				
				MProduct product = MProduct.get(ctx, (Integer)productValue);
				int M_ASI_ID = value != null ? (Integer)value : 0;
				int AD_Org_ID = inventory.getAD_Org_ID();
				MClient client = MClient.get(ctx);
				MAcctSchema as = client.getAcctSchema();
				MCost cost = product.getCostingRecord(as, AD_Org_ID, M_ASI_ID, costingMethod);
				if (cost != null) {
					BigDecimal currentCost = (BigDecimal) mTab.getValue(I_M_InventoryLine.COLUMNNAME_CurrentCostPrice);
					if (currentCost == null || currentCost.compareTo(cost.getCurrentCostPrice())==0) return null;
					
					mTab.setValue(I_M_InventoryLine.COLUMNNAME_CurrentCostPrice, cost.getCurrentCostPrice());
					mTab.setValue(I_M_InventoryLine.COLUMNNAME_NewCostPrice, cost.getCurrentCostPrice());
				}
			}
			return null;
		}
		
	}
}
