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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.compiere.process;

import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MDocType;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProduction;
import org.compiere.model.MWarehouse;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
@org.adempiere.base.annotation.Process
public class OrderCreateProduction extends SvrProcess {
	/** Order */
	private int p_C_Order_ID = 0;

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		p_C_Order_ID = getRecord_ID();
	} // prepare

	/**
	 * Create Production for BOM products of an order
	 *
	 * @throws Exception
	 */
	protected String doIt() throws Exception {
		if (log.isLoggable(Level.INFO))
			log.info("C_Order_ID=" + p_C_Order_ID);
		if (p_C_Order_ID == 0)
			throw new IllegalArgumentException("No Order");
		//
		MOrder order = new MOrder(getCtx(), p_C_Order_ID, get_TrxName());
		if (order.get_ID() == 0)
			throw new IllegalArgumentException("Order not found");
		if (!MOrder.DOCSTATUS_Completed.equals(order.getDocStatus()))
			throw new IllegalArgumentException("Order not completed");

		final String where = "C_OrderLine.C_Order_ID=?"
				+ " AND C_OrderLine.Processed='Y'"
				+ " AND p.IsBOM='Y'"
				+ " AND p.IsVerified='Y'"
				+ " AND NOT EXISTS (SELECT 1 FROM M_Production pr WHERE pr.C_OrderLine_ID=C_OrderLine.C_OrderLine_ID)";
		List<MOrderLine> lines = new Query(getCtx(), MOrderLine.Table_Name, where, get_TrxName())
				.addJoinClause("JOIN M_Product p ON (C_OrderLine.M_Product_ID=p.M_Product_ID)")
				.setOnlyActiveRecords(true)
				.setParameters(p_C_Order_ID)
				.list();

		MDocType doc = new MDocType(getCtx(), order.getC_DocType_ID(), get_TrxName());
		int cnt = 0;
		for (MOrderLine line : lines) {
			if ((line.getQtyOrdered().subtract(line.getQtyDelivered())).compareTo(Env.ZERO) <= 0) {
				if (!doc.getDocSubTypeSO().equals("ON")) { // Consignment and stock orders both have subtype of ON
					continue;
				}
			}

			MProduction production = new MProduction(line);
			MProduct product = new MProduct(getCtx(), line.getM_Product_ID(), get_TrxName());

			production.setM_Product_ID(line.getM_Product_ID());
			production.setProductionQty(line.getQtyOrdered().subtract(line.getQtyDelivered()));
			production.setDatePromised(line.getDatePromised());
			production.setC_OrderLine_ID(line.getC_OrderLine_ID());

			int locator = product.getM_Locator_ID();
			if (locator == 0)
				locator = MWarehouse.get(getCtx(), line.getM_Warehouse_ID()).getDefaultLocator().get_ID();
			production.setM_Locator_ID(locator);

			if (line.getC_BPartner_ID() > 0) {
				production.setC_BPartner_ID(order.getC_BPartner_ID());
			}

			if (line.getC_Project_ID() > 0) {
				production.setC_Project_ID(line.getC_Project_ID());
			} else {
				production.setC_Project_ID(order.getC_Project_ID());
			}

			if (line.getC_Campaign_ID() > 0) {
				production.setC_Campaign_ID(line.getC_Campaign_ID());
			} else {
				production.setC_Campaign_ID(order.getC_Campaign_ID());
			}

			if (line.getC_Activity_ID() > 0) {
				production.setC_Activity_ID(line.getC_Activity_ID());
			} else {
				production.setC_Activity_ID(order.getC_Activity_ID());
			}

			if (line.getUser1_ID() > 0) {
				production.setUser1_ID(line.getUser1_ID());
			} else {
				production.setUser1_ID(order.getUser1_ID());
			}

			if (line.getUser2_ID() > 0) {
				production.setUser2_ID(line.getUser2_ID());
			} else {
				production.setUser2_ID(order.getUser2_ID());
			}

			if (line.getAD_OrgTrx_ID() > 0) {
				production.setAD_OrgTrx_ID(line.getAD_OrgTrx_ID());
			} else {
				production.setAD_OrgTrx_ID(order.getAD_OrgTrx_ID());
			}

			production.saveEx();

			production.createLines(false);
			production.setIsCreated("Y");
			production.saveEx();

			String msg = Msg.parseTranslation(getCtx(), "@M_Production_ID@ @Created@ " + production.getDocumentNo());
			addBufferLog(production.getM_Production_ID(), null, null, msg, MProduction.Table_ID, production.getM_Production_ID());
			cnt++;
		}

		return "@Created@ " + cnt;
	}

} // OrderCreateShipment
