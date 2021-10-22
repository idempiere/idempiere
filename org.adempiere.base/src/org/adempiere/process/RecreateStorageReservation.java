/******************************************************************************
 * Project: Trek Global ERP                                                   *
 * Copyright (C) 2009-2018 Trek Global Corporation                			  *
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
package org.adempiere.process;

import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;

@org.adempiere.base.annotation.Process
public class RecreateStorageReservation extends SvrProcess {

	private int m_AD_Client_ID = 0;

	@Override
	protected void prepare() {
		m_AD_Client_ID = Env.getAD_Client_ID(getCtx());
	}

	@Override
	protected String doIt() throws Exception {

		final String sql = ""
				+ "SELECT COUNT(*) "
				+ "FROM "
				+ "( "
				+ "SELECT SUM(ol.QtyReserved) AS OrderQtyReserved, "
				+ "       ol.M_Warehouse_ID, "
				+ "       ol.M_Product_ID, "
				+ "       COALESCE(M_AttributeSetInstance_ID, 0) AS M_AttributeSetInstance_ID, "
				+ "       o.IsSOTrx, "
				+ "       w.AD_Client_ID, "
				+ "       w.AD_Org_ID "
				+ "FROM   C_OrderLine ol "
				+ "       JOIN C_Order o ON ( ol.C_Order_ID = o.C_Order_ID ) "
				+ "       JOIN M_Warehouse w ON ( w.M_Warehouse_ID = o.M_Warehouse_ID ) "
				+ "WHERE  ol.m_product_ID > 0 "
				+ "       AND ol.ad_client_ID = ? "
				+ "       AND ol.qtyreserved != 0 "
				+ "       AND o.docstatus NOT IN ( 'VO', 'RE' ) "
				+ "GROUP  BY ol.M_Warehouse_ID, "
				+ "          ol.M_Product_ID, "
				+ "          COALESCE(M_AttributeSetInstance_ID, 0), "
				+ "          o.IsSOTrx, "
				+ "          w.AD_Client_ID, "
				+ "          w.AD_Org_ID "
				+ ") y "
				+ "FULL OUTER JOIN "
				+ "( "
				+ "SELECT Qty AS StorageQtyreserved, "
				+ "       M_Warehouse_ID, "
				+ "       M_Product_ID, "
				+ "       M_AttributeSetInstance_ID, "
				+ "       IsSOTrx, "
				+ "       AD_Client_ID "
				+ "FROM   M_StorageReservation "
				+ "WHERE  AD_Client_ID = ? "
				+ "       AND Qty != 0 "
				+ ") x "
				+ "    ON y.M_Warehouse_ID = x.M_Warehouse_ID "
				+ "       AND x.M_Product_ID = y.M_Product_ID "
				+ "       AND x.M_AttributeSetInstance_ID = y.M_AttributeSetInstance_ID "
				+ "       AND x.IsSOTrx = y.IsSOTrx "
				+ "WHERE  COALESCE(x.StorageQtyReserved, 0) <> COALESCE(y.OrderQtyReserved, 0)";

		int wrongReservations = DB.getSQLValueEx(get_TrxName(), sql, m_AD_Client_ID, m_AD_Client_ID);
		
		int noInserted = 0;
		if (wrongReservations > 0) {
			
			log.warning(wrongReservations + " wrong reservation records found");
			
			final String deleteSql = "DELETE FROM M_StorageReservation WHERE AD_Client_ID=?";
			int no = DB.executeUpdateEx(deleteSql, new Object[]{m_AD_Client_ID}, get_TrxName());
			log.warning(no + " reservation records deleted");
			
			final String ins = ""
					+ "INSERT INTO M_StorageReservation "
					+ "            (Qty, "
					+ "             M_Warehouse_ID, "
					+ "             M_Product_ID, "
					+ "             M_AttributeSetInstance_ID, "
					+ "             IsSOTrx, "
					+ "             AD_Client_ID, "
					+ "             AD_Org_ID, "
					+ "             Created, "
					+ "             CreatedBy, "
					+ "             Updated, "
					+ "             UpdatedBy, "
					+ "             IsActive, "
					+ "             M_StorageReservation_UU) "
					+ "SELECT SUM(ol.QtyReserved) AS OrderQtyReserved, "
					+ "       ol.M_Warehouse_ID, "
					+ "       ol.M_Product_ID, "
					+ "       COALESCE(M_AttributeSetInstance_ID, 0), "
					+ "       o.IsSOTrx, "
					+ "       w.AD_Client_ID, "
					+ "       w.AD_Org_ID, "
					+ "       getDate(), "
					+ "       ?, "
					+ "       getDate(), "
					+ "       ?, " 
					+ "       'Y', "
					+ "       generate_uuid() "
					+ "FROM   C_OrderLine ol "
					+ "       JOIN C_Order o ON ( ol.C_Order_ID = o.C_Order_ID ) "
					+ "       JOIN M_Warehouse w ON ( w.M_Warehouse_ID = o.M_Warehouse_ID ) "
					+ "WHERE  ol.M_Product_ID > 0 "
					+ "       AND ol.QtyReserved != 0 "
					+ "       AND o.DocStatus NOT IN ( 'VO', 'RE' ) "
					+ "       AND o.AD_Client_ID = ? "
					+ "GROUP  BY ol.M_Warehouse_ID, "
					+ "       ol.M_Product_ID, "
					+ "       COALESCE(M_AttributeSetInstance_ID, 0), "
					+ "       o.IsSOTrx, "
					+ "       w.AD_Client_ID, "
					+ "       w.AD_Org_ID";
			
			noInserted = DB.executeUpdateEx(ins, new Object[]{Env.getAD_User_ID(getCtx()), Env.getAD_User_ID(getCtx()), m_AD_Client_ID}, get_TrxName());
			log.warning(noInserted + " reservation records inserted");
		}

		return noInserted + " @Inserted@";
	}

}
