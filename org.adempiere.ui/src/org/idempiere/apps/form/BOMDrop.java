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
package org.idempiere.apps.form;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.Callback;
import org.compiere.model.MClient;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProject;
import org.compiere.model.MProjectLine;
import org.compiere.model.MRole;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;

/**
 * 
 * @author hengsin
 *
 */
public class BOMDrop {

	/**
	 * default constructor
	 */
	public BOMDrop() {
	}

	/**
	 * 
	 * @param product
	 * @return
	 */
	public int getMaxBOMDeep(MProduct product) {
		return getBOMDeep(product, 0);
	}
	
	private int getBOMDeep (MProduct product, int curentBomDeep) {
		int bomDeep = curentBomDeep;
		if (product.isBOM()) {
			MPPProductBOM bom = MPPProductBOM.getDefault(product, (String)null);
			if (bom != null) {
				for (MPPProductBOMLine bomLine : bom.getLines()) {
					int testBomDeep = getBOMDeep(bomLine.getProduct(), curentBomDeep + 1);
					if (testBomDeep > bomDeep) {
						bomDeep = testBomDeep;
					}
				}
			}
		}
		return bomDeep;
	}
	
	/**
	 * 	Get Array of draft orders (C_Order_ID, DocumentNo_GrandTotal)
	 *  @param trxName optional trx name
	 *	@return array of draft orders
	 */	
	public KeyNamePair[] getDraftOrders(String trxName) {
		String sql = "SELECT C_Order_ID, DocumentNo || '_' || GrandTotal "
			+ "FROM C_Order "
			+ "WHERE Processed='N' AND DocStatus='DR' "
			+ "ORDER BY DocumentNo";
	
		return DB.getKeyNamePairs(trxName, MRole.getDefault().addAccessSQL(
			sql, "C_Order", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO), true);
	}
	
	/**
	 * 	Get Array of open non service Projects (C_Project_ID, Name)
	 *  @param trxName optional trx name
	 *	@return array of non service projects
	 */	
	public KeyNamePair[] getNonServiceProjects(String trxName) {
		String sql = "SELECT C_Project_ID, Name "
			+ "FROM C_Project "
			+ "WHERE Processed='N' AND IsSummary='N' AND IsActive='Y'"
			+ " AND ProjectCategory<>'S' "
			+ "ORDER BY Name";
	
		return DB.getKeyNamePairs(trxName, MRole.getDefault().addAccessSQL(
			sql, "C_Project", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO), true);
	}
	
	/**
	 * 	Get Array of draft Invoices (C_Invoice_ID, DocumentNo_GrandTotal)
	 *  @param trxName optional trx name
	 *	@return array of draft invoices
	 */	
	public KeyNamePair[] getDraftInvoices(String trxName) {
		String sql = "SELECT C_Invoice_ID, DocumentNo || '_' || GrandTotal "
			+ "FROM C_Invoice "
			+ "WHERE Processed='N' AND DocStatus='DR' "
			+ "ORDER BY DocumentNo";
	
		return DB.getKeyNamePairs(trxName, MRole.getDefault().addAccessSQL(
			sql, "C_Invoice", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO), true);
	}
	
	/**
	 * Get BOM lines from default BOM of product, sorted by component type and line number
	 * 
	 * @param product
	 * @return MPPProductBOMLine[]
	 */
	public MPPProductBOMLine[] getBOMLine(MProduct product) {
		MPPProductBOM bom = MPPProductBOM.getDefault(product, (String)null);
		MPPProductBOMLine[] bomLines = bom.getLines();
		//sort by feature
		Arrays.sort(bomLines, new Comparator<MPPProductBOMLine>() {
			@Override
			public int compare(MPPProductBOMLine arg0, MPPProductBOMLine arg1) {
				String feature1 = arg0.getFeature() != null ? arg0.getFeature() : "";
				String feature2 = arg1.getFeature() != null ? arg1.getFeature() : ""; 
				return feature1.compareTo(feature2);
			}
		});
		
		//sort by component type
		Arrays.sort(bomLines, new Comparator<MPPProductBOMLine>() {
			@Override
			public int compare(MPPProductBOMLine arg0, MPPProductBOMLine arg1) {
				return arg0.getComponentType().compareTo(arg1.getComponentType());
			}
		});

        // 2nd sort by Line Number in order to correspond with BOM Structure, patch 2015-03-31
        Arrays.sort(bomLines, new Comparator<MPPProductBOMLine>() {
                @Override
                public int compare(MPPProductBOMLine arg0, MPPProductBOMLine arg1) {
                        String t1 = String.valueOf(arg0.getLine()+100000);
                        String t2 = String.valueOf(arg1.getLine()+100000);
                        return t1.compareTo(t2);
                		}
		});
        
        return bomLines;
	}
	
	/**
	 * 
	 * @param C_Order_ID
	 * @param selectedItems
	 * @param trxName
	 * @return {@link MOrder}
	 */
	public MOrder saveOrderLines(int C_Order_ID, List<SelectedItem> selectedItems, String trxName) {
		MOrder order = new MOrder (Env.getCtx(), C_Order_ID, trxName);
		
		if (order.get_ID() == 0) {
			throw new AdempiereException("Not found - C_Order_ID=" + C_Order_ID);
		}
		
		for (SelectedItem selectedItem : selectedItems) {
			addOrderLine(order, selectedItem.M_Product_ID, selectedItem.qty);
		}
		return order;
	}
	
	/**
	 * 
	 * @param order
	 * @param M_Product_ID
	 * @param qty
	 * @return {@link MOrderLine}
	 */
	private MOrderLine addOrderLine(MOrder order, int M_Product_ID, BigDecimal qty) {
		// Create Line
		MOrderLine ol = new MOrderLine(order);
		ol.setM_Product_ID(M_Product_ID, true);
		ol.setQty(qty);
		ol.setPrice();
		ol.setTax();
		ol.saveEx();
		
		return ol;
	}
	
	/**
	 * 
	 * @param C_Invoice_ID
	 * @param selectedItems
	 * @param trxName
	 * @return {@link MInvoice}
	 */
	public MInvoice saveInvoiceLines(int C_Invoice_ID, List<SelectedItem> selectedItems, String trxName) {
		MInvoice invoice = new MInvoice (Env.getCtx(), C_Invoice_ID, trxName);
		if (invoice.get_ID() == 0) {
			throw new AdempiereException("Not found - C_Invoice_ID=" + C_Invoice_ID);
		}
		
		for(SelectedItem selectedItem : selectedItems) {
			addInvoiceLine(invoice, selectedItem.M_Product_ID, selectedItem.qty);
		}
		return invoice;
	}
	
	/**
	 * 
	 * @param invoice
	 * @param M_Product_ID
	 * @param qty
	 * @return {@link MInvoiceLine}
	 */
	private MInvoiceLine addInvoiceLine(MInvoice invoice, int M_Product_ID, BigDecimal qty) {
		MInvoiceLine il = new MInvoiceLine (invoice);
		il.setM_Product_ID(M_Product_ID, true);
		il.setQty(qty);
		il.setPrice();
		il.setTax();
		il.saveEx();
		return il;
	}
	
	/**
	 * 
	 * @param C_Project_ID
	 * @param selectedItems
	 * @param trxName
	 * @return {@link MProject}
	 */
	public MProject saveProjectLines(int C_Project_ID, List<SelectedItem> selectedItems, String trxName) {
		MProject project = new MProject (Env.getCtx(), C_Project_ID, trxName);
		if (project.get_ID() == 0) {
			throw new AdempiereException("Not found - C_Project_ID=" + C_Project_ID);
		}
		
		for(SelectedItem selectedItem : selectedItems) {
			addProjectLine(project, selectedItem.M_Product_ID, selectedItem.qty);
		}
		
		return project;
	}
	
	/**
	 * 
	 * @param project
	 * @param M_Product_ID
	 * @param qty
	 * @return {@link MProjectLine}
	 */
	private MProjectLine addProjectLine(MProject project, int M_Product_ID, BigDecimal qty) {
		MProjectLine pl = new MProjectLine (project);
		pl.setM_Product_ID(M_Product_ID);
		pl.setPlannedQty(qty);
		pl.saveEx();
		
		return pl;
	}
	
	/**
	 * @param product
	 * @param qty
	 * @param callback
	 */
	public void addBOMLines(MProduct product, BigDecimal qty, Callback<BOMLine> callback) {
		addBOMLines(product, qty, callback, 0);
	}
	
	private void addBOMLines(MProduct product, BigDecimal qty, Callback<BOMLine> callback, int bomLevel) {
		MPPProductBOMLine[] bomLines = getBOMLine(product);
		for (int i = 0; i < bomLines.length; i++)
			addBOMLines(bomLines[i], qty, callback, bomLevel);
	}
	
	private void addBOMLines(MPPProductBOMLine productBOMLine, BigDecimal qty, Callback<BOMLine> callback, int bomLevel) {
		MProduct product = productBOMLine.getProduct();
		
		if (product == null)
			return;
		
		BOMLine bomLine = new BOMLine(productBOMLine, qty, bomLevel);
		callback.onCallback(bomLine);
		
		if (product.isBOM() && product.isVerified()) {
			addBOMLines(product, bomLine.getLineQty(), callback, bomLevel + 1);		//	recursive
		}
	}

	/**
	 * selected bom item
	 */
	public static class SelectedItem {
		private int M_Product_ID;
		private BigDecimal qty;
		
		/**
		 * 
		 * @param M_Product_ID
		 * @param qty
		 */
		public SelectedItem(int M_Product_ID, BigDecimal qty) {
			this.M_Product_ID = M_Product_ID;
			this.qty = qty;
		}
		
		/**
		 * 
		 * @return M_Product_ID
		 */
		public int getM_Product_ID() {
			return M_Product_ID;
		}
		
		/**
		 * 
		 * @return qty
		 */
		public BigDecimal getQty() {
			return qty;
		}
	}
	
	/**
	 * bom line 
	 */
	public static class BOMLine {
		private MPPProductBOMLine bomLine;
		private BigDecimal lineQty;
		private String bomType;
		private int bomLevel;
		private String feature;
		
		/**
		 * 
		 * @param bomLine
		 * @param qty
		 * @param level
		 */
		public BOMLine(MPPProductBOMLine bomLine, BigDecimal qty, int level) {
			this.bomLine = bomLine;
			lineQty = bomLine.getQtyBOM().multiply(qty).setScale(MClient.get(Env.getCtx()).getAcctSchema().getStdPrecision(), RoundingMode.HALF_UP);
			bomType = bomLine.getComponentType();			
			if (bomType == null)
				bomType = MPPProductBOMLine.COMPONENTTYPE_Component;
			bomLevel = level;
			feature = bomLine.getFeature();
			if (feature == null)
				feature = "";
		}

		/**
		 * 
		 * @return {@link MPPProductBOMLine}
		 */
		public MPPProductBOMLine getProductBOMLine() {
			return bomLine;
		}

		/**
		 * 
		 * @return qty require
		 */
		public BigDecimal getLineQty() {
			return lineQty;
		}

		/**
		 * 
		 * @return type of bom (component, variant, phantom, etc)
		 */
		public String getBOMType() {
			return bomType;
		}
		
		/**
		 * 
		 * @return bom level (start from 0)
		 */
		public int getBOMLevel() {
			return bomLevel;
		}
		
		/**
		 * 
		 * @return feature of bom line
		 */
		public String getFeature() {
			return feature;
		}
		
		/**
		 * 
		 * @return parent product
		 */
		public MProduct getParentProduct() {
			MPPProductBOM parent = bomLine.getParent();
			return MProduct.get(parent.getM_Product_ID());
		}
	}
}


