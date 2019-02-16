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
package org.adempiere.process;

import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;

public class RecreateStorageReservation extends SvrProcess {

	private int m_AD_Client_ID = 0;

	@Override
	protected void prepare() {
		m_AD_Client_ID = Env.getAD_Client_ID(getCtx());
	}

	@Override
	protected String doIt() throws Exception {
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT count(*) FROM ");
		sql.append(" (");
		sql.append(" SELECT SUM(ol.qtyreserved) AS orderqtyreserved, ol.m_warehouse_id,");
		sql.append(" ol.m_product_id, coalesce(m_attributesetinstance_id,0) AS m_attributesetinstance_id,");
		sql.append(" o.issotrx, w.ad_client_id,w.ad_org_id");
		sql.append(" FROM   c_orderline ol ");
		sql.append(" JOIN c_order o ON ( ol.c_order_id = o.c_order_id ) ");
		sql.append(" JOIN m_warehouse w ON (w.m_warehouse_id = o.m_warehouse_id)");
		sql.append(" WHERE  ol.m_product_id > 0 AND ol.qtyreserved!=0 AND o.docstatus NOT IN ('VO','RE') ");
		sql.append(" GROUP  BY 2,3,4,5,6,7 ");
		sql.append(" ) AS y ");
		sql.append(" FULL OUTER JOIN ");
		sql.append(" ( ");
		sql.append(" SELECT qty AS storageqtyReserved,");
		sql.append(" m_warehouse_id, m_product_id, m_attributesetinstance_id,issotrx,ad_client_id");
		sql.append(" FROM   m_storagereservation");
		sql.append(" WHERE  qty!=0");
		sql.append(" ) AS x");
		sql.append(" ON y.m_warehouse_id = x.m_warehouse_id");
		sql.append(" AND x.m_product_id = y.m_product_id");
		sql.append(" AND x.m_attributesetinstance_id = y.m_attributesetinstance_id");
		sql.append(" AND x.issotrx = y.issotrx");
		sql.append(" WHERE  COALESCE(x.storageqtyreserved, 0) <> COALESCE(y.orderqtyreserved, 0)");
		sql.append(" AND (x.ad_client_id = ? OR y.ad_client_id = ?)");
		
		int wrongReservations = DB.getSQLValue(get_TrxName(), sql.toString(), m_AD_Client_ID, m_AD_Client_ID);
		
		int noInserted = 0;
		if (wrongReservations > 0) {
			
			log.warning(wrongReservations + " wrong reservation records found");
			
			final String deleteSql = "DELETE FROM M_StorageReservation WHERE AD_Client_ID=?";
			int no = DB.executeUpdateEx(deleteSql, new Object[]{m_AD_Client_ID}, get_TrxName());
			log.warning(no + " reservation records deleted");
			
			sql = new StringBuilder();
			sql.append("INSERT INTO M_StorageReservation ");
			sql.append(" (qty, m_warehouse_id,");
			sql.append(" m_product_id,m_attributesetinstance_id,");
			sql.append(" issotrx, ad_client_id, ad_org_id,");
			sql.append(" created, createdby,");
			sql.append(" updated, updatedby,");
			sql.append(" isactive)");
			sql.append(" SELECT SUM(ol.qtyreserved) AS orderqtyreserved,");
			sql.append(" ol.m_warehouse_id, ");
			sql.append(" ol.m_product_id,");
			sql.append(" COALESCE(m_attributesetinstance_id,0),");
			sql.append(" o.issotrx, w.ad_client_id, w.ad_org_id,");
			sql.append(" SYSDATE,");
			sql.append(Env.getAD_User_ID(getCtx()));
			sql.append(" ,SYSDATE,");
			sql.append(Env.getAD_User_ID(getCtx()));			
			sql.append(" ,'Y' ");
			sql.append(" FROM c_orderline ol");
			sql.append(" JOIN c_order o ON ( ol.c_order_id = o.c_order_id )");
			sql.append(" JOIN m_warehouse w ON (w.m_warehouse_id = o.m_warehouse_id)");
			sql.append(" WHERE ol.m_product_id > 0");
			sql.append(" AND ol.qtyreserved != 0");
			sql.append(" AND o.docstatus NOT IN ('VO', 'RE')");
			sql.append(" AND o.ad_client_id = ?");
			sql.append(" GROUP BY 2, 3, 4, 5, 6,7,8,9,10,11,12");
			
			noInserted = DB.executeUpdateEx(sql.toString(), new Object[]{m_AD_Client_ID}, get_TrxName());
			log.warning(noInserted + " reservation records inserted");
		}

		return noInserted + " @Inserted@";
	}

}
