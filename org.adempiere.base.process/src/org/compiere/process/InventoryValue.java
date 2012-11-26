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
package org.compiere.process;

import java.sql.Timestamp;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MWarehouse;
import org.compiere.util.DB;


/**
 *  Inventory Valuation.
 *  Process to fill T_InventoryValue
 *
 *  @author     Jorg Janke
 *  @version    $Id: InventoryValue.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 *  @author 	Michael Judd (mjudd) Akuna Ltd - BF [ 2685127 ]
 *  
 */
public class InventoryValue extends SvrProcess
{
	/** Price List Used         */
	private int         p_M_PriceList_Version_ID;
	/** Valuation Date          */
	private Timestamp   p_DateValue;
	/** Warehouse               */
	private int         p_M_Warehouse_ID;
	/** Currency                */
	private int         p_C_Currency_ID;
	/** Optional Cost Element	*/
	private int			p_M_CostElement_ID;

	/**
	 *  Prepare - get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_PriceList_Version_ID"))
				p_M_PriceList_Version_ID = para[i].getParameterAsInt();
			else if (name.equals("DateValue"))
				p_DateValue = (Timestamp)para[i].getParameter();
			else if (name.equals("M_Warehouse_ID"))
				p_M_Warehouse_ID = para[i].getParameterAsInt();
			else if (name.equals("C_Currency_ID"))
				p_C_Currency_ID = para[i].getParameterAsInt();
			else if (name.equals("M_CostElement_ID"))
				p_M_CostElement_ID = para[i].getParameterAsInt();
		}
		if (p_DateValue == null)
			p_DateValue = new Timestamp (System.currentTimeMillis());
	}   //  prepare

	/**
	 *  Perform process.
	 *  <pre>
	 *  - Fill Table with QtyOnHand for Warehouse and Valuation Date
	 *  - Perform Price Calculations
	 *  </pre>
	 * @return Message
	 * @throws Exception
	 */
	protected String doIt() throws Exception
	{
		log.info("M_Warehouse_ID=" + p_M_Warehouse_ID
			+ ",C_Currency_ID=" + p_C_Currency_ID
			+ ",DateValue=" + p_DateValue
			+ ",M_PriceList_Version_ID=" + p_M_PriceList_Version_ID
			+ ",M_CostElement_ID=" + p_M_CostElement_ID);
		
		MWarehouse wh = MWarehouse.get(getCtx(), p_M_Warehouse_ID);
		MClient c = MClient.get(getCtx(), wh.getAD_Client_ID());
		MAcctSchema as = c.getAcctSchema();
		
		//  Delete (just to be sure)
		StringBuilder sql = new StringBuilder ("DELETE T_InventoryValue WHERE AD_PInstance_ID=");
		sql.append(getAD_PInstance_ID());
		int no = DB.executeUpdateEx(sql.toString(), get_TrxName());

		//	Insert Standard Costs
		sql = new StringBuilder ("INSERT INTO T_InventoryValue ")
			.append("(AD_PInstance_ID, M_Warehouse_ID, M_Product_ID, M_AttributeSetInstance_ID,")
			.append(" AD_Client_ID, AD_Org_ID, CostStandard) ")
			.append("SELECT ").append(getAD_PInstance_ID())
			.append(", w.M_Warehouse_ID, c.M_Product_ID, c.M_AttributeSetInstance_ID,")
			.append(" w.AD_Client_ID, w.AD_Org_ID, c.CurrentCostPrice ")
			.append("FROM M_Warehouse w")
			.append(" INNER JOIN AD_ClientInfo ci ON (w.AD_Client_ID=ci.AD_Client_ID)")
			.append(" INNER JOIN C_AcctSchema acs ON (ci.C_AcctSchema1_ID=acs.C_AcctSchema_ID)")
			.append(" INNER JOIN M_Cost c ON (acs.C_AcctSchema_ID=c.C_AcctSchema_ID AND acs.M_CostType_ID=c.M_CostType_ID AND c.AD_Org_ID IN (0, w.AD_Org_ID))")
			.append(" INNER JOIN M_CostElement ce ON (c.M_CostElement_ID=ce.M_CostElement_ID AND ce.CostingMethod='S' AND ce.CostElementType='M') ")
			.append("WHERE w.M_Warehouse_ID=").append(p_M_Warehouse_ID);
		int noInsertStd = DB.executeUpdateEx(sql.toString(), get_TrxName());
		log.fine("Inserted Std=" + noInsertStd);
		if (noInsertStd == 0)
			return "No Standard Costs found";

		//	Insert addl Costs
		int noInsertCost = 0;
		if (p_M_CostElement_ID != 0)
		{
			sql = new StringBuilder ("INSERT INTO T_InventoryValue ")
				.append("(AD_PInstance_ID, M_Warehouse_ID, M_Product_ID, M_AttributeSetInstance_ID,")
				.append(" AD_Client_ID, AD_Org_ID, CostStandard, Cost, M_CostElement_ID) ")
				.append("SELECT ").append(getAD_PInstance_ID())
				.append(", w.M_Warehouse_ID, c.M_Product_ID, c.M_AttributeSetInstance_ID,")
				.append(" w.AD_Client_ID, w.AD_Org_ID, 0, c.CurrentCostPrice, c.M_CostElement_ID ")
				.append("FROM M_Warehouse w")
				.append(" INNER JOIN AD_ClientInfo ci ON (w.AD_Client_ID=ci.AD_Client_ID)")
				.append(" INNER JOIN C_AcctSchema acs ON (ci.C_AcctSchema1_ID=acs.C_AcctSchema_ID)")
				.append(" INNER JOIN M_Cost c ON (acs.C_AcctSchema_ID=c.C_AcctSchema_ID AND acs.M_CostType_ID=c.M_CostType_ID AND c.AD_Org_ID IN (0, w.AD_Org_ID)) ")
				.append("WHERE w.M_Warehouse_ID=").append(p_M_Warehouse_ID)
				.append(" AND c.M_CostElement_ID=").append(p_M_CostElement_ID)
				.append(" AND NOT EXISTS (SELECT * FROM T_InventoryValue iv ")
					.append("WHERE iv.AD_PInstance_ID=").append(getAD_PInstance_ID())
					.append(" AND iv.M_Warehouse_ID=w.M_Warehouse_ID")
					.append(" AND iv.M_Product_ID=c.M_Product_ID")
					.append(" AND iv.M_AttributeSetInstance_ID=c.M_AttributeSetInstance_ID)");
			noInsertCost = DB.executeUpdateEx(sql.toString(), get_TrxName());
			log.fine("Inserted Cost=" + noInsertCost);
			//	Update Std Cost Records
			sql = new StringBuilder ("UPDATE T_InventoryValue iv ")
				.append("SET (Cost, M_CostElement_ID)=")
					.append("(SELECT c.CurrentCostPrice, c.M_CostElement_ID ")
					.append("FROM M_Warehouse w")
					.append(" INNER JOIN AD_ClientInfo ci ON (w.AD_Client_ID=ci.AD_Client_ID)")
					.append(" INNER JOIN C_AcctSchema acs ON (ci.C_AcctSchema1_ID=acs.C_AcctSchema_ID)")
					.append(" INNER JOIN M_Cost c ON (acs.C_AcctSchema_ID=c.C_AcctSchema_ID")
						.append(" AND acs.M_CostType_ID=c.M_CostType_ID AND c.AD_Org_ID IN (0, w.AD_Org_ID)) ")
					.append("WHERE c.M_CostElement_ID=").append(p_M_CostElement_ID)
					.append(" AND iv.M_Warehouse_ID=w.M_Warehouse_ID")
					.append(" AND iv.M_Product_ID=c.M_Product_ID")
					.append(" AND iv.M_AttributeSetInstance_ID=c.M_AttributeSetInstance_ID) ")
				.append("WHERE EXISTS (SELECT * FROM T_InventoryValue ivv ")
					.append("WHERE ivv.AD_PInstance_ID=").append(getAD_PInstance_ID())
					.append(" AND ivv.M_CostElement_ID IS NULL)");
			int noUpdatedCost = DB.executeUpdateEx(sql.toString(), get_TrxName());
			log.fine("Updated Cost=" + noUpdatedCost);
		}		
		if ((noInsertStd+noInsertCost) == 0)
			return "No Costs found";
		
		//  Update Constants
		//  YYYY-MM-DD HH24:MI:SS.mmmm  JDBC Timestamp format
		String myDate = p_DateValue.toString();
		sql = new StringBuilder ("UPDATE T_InventoryValue SET ")
			.append("DateValue=TO_DATE('").append(myDate.substring(0,10))
			.append(" 23:59:59','YYYY-MM-DD HH24:MI:SS'),")
			.append("M_PriceList_Version_ID=").append(p_M_PriceList_Version_ID).append(",")
			.append("C_Currency_ID=").append(p_C_Currency_ID)
			.append(" WHERE AD_PInstance_ID=").append(getAD_PInstance_ID());
		no = DB.executeUpdateEx(sql.toString(), get_TrxName());
		log.fine("Constants=" + no);

		//  Get current QtyOnHand with ASI
		sql = new StringBuilder ("UPDATE T_InventoryValue iv SET QtyOnHand = ")
				.append("(SELECT SUM(QtyOnHand) FROM M_StorageOnHand s")
				.append(" INNER JOIN M_Locator l ON (l.M_Locator_ID=s.M_Locator_ID) ")
				.append("WHERE iv.M_Product_ID=s.M_Product_ID")
				.append(" AND iv.M_Warehouse_ID=l.M_Warehouse_ID")
				.append(" AND iv.M_AttributeSetInstance_ID=s.M_AttributeSetInstance_ID) ")
			.append("WHERE AD_PInstance_ID=").append(getAD_PInstance_ID())
			.append(" AND iv.M_AttributeSetInstance_ID<>0");
		no = DB.executeUpdateEx(sql.toString(), get_TrxName());
		log.fine("QtHand with ASI=" + no);
		//  Get current QtyOnHand without ASI
		sql = new StringBuilder ("UPDATE T_InventoryValue iv SET QtyOnHand = ")
				.append("(SELECT SUM(QtyOnHand) FROM M_StorageOnHand s")
				.append(" INNER JOIN M_Locator l ON (l.M_Locator_ID=s.M_Locator_ID) ")
				.append("WHERE iv.M_Product_ID=s.M_Product_ID")
				.append(" AND iv.M_Warehouse_ID=l.M_Warehouse_ID) ")
			.append("WHERE iv.AD_PInstance_ID=").append(getAD_PInstance_ID())
			.append(" AND iv.M_AttributeSetInstance_ID=0");
		no = DB.executeUpdateEx(sql.toString(), get_TrxName());
		log.fine("QtHand w/o ASI=" + no);
		
		//  Adjust for Valuation Date
		sql = new StringBuilder("UPDATE T_InventoryValue iv ")
			.append("SET QtyOnHand=")
				.append("(SELECT iv.QtyOnHand - NVL(SUM(t.MovementQty), 0) ")
				.append("FROM M_Transaction t")
				.append(" INNER JOIN M_Locator l ON (t.M_Locator_ID=l.M_Locator_ID) ")
				.append("WHERE t.M_Product_ID=iv.M_Product_ID")
				.append(" AND t.M_AttributeSetInstance_ID=iv.M_AttributeSetInstance_ID")
				.append(" AND t.MovementDate > iv.DateValue")
				.append(" AND l.M_Warehouse_ID=iv.M_Warehouse_ID) ")
			.append("WHERE iv.M_AttributeSetInstance_ID<>0" )
			.append(" AND iv.AD_PInstance_ID=").append(getAD_PInstance_ID());
		no = DB.executeUpdateEx(sql.toString(), get_TrxName());
		log.fine("Update with ASI=" + no);
		//
		sql = new StringBuilder("UPDATE T_InventoryValue iv ")
			.append("SET QtyOnHand=")
				.append("(SELECT iv.QtyOnHand - NVL(SUM(t.MovementQty), 0) ")
				.append("FROM M_Transaction t")
				.append(" INNER JOIN M_Locator l ON (t.M_Locator_ID=l.M_Locator_ID) ")
				.append("WHERE t.M_Product_ID=iv.M_Product_ID")
				.append(" AND t.MovementDate > iv.DateValue")
				.append(" AND l.M_Warehouse_ID=iv.M_Warehouse_ID) ")
			.append("WHERE iv.M_AttributeSetInstance_ID=0 ")
			.append("AND iv.AD_PInstance_ID=").append(getAD_PInstance_ID());

		no = DB.executeUpdateEx(sql.toString(), get_TrxName());
		log.fine("Update w/o ASI=" + no);
		
		//  Delete Records w/o OnHand Qty
		sql = new StringBuilder("DELETE T_InventoryValue ")
			.append("WHERE (QtyOnHand=0 OR QtyOnHand IS NULL) AND AD_PInstance_ID=").append(getAD_PInstance_ID());
		int noQty = DB.executeUpdateEx (sql.toString(), get_TrxName());
		log.fine("NoQty Deleted=" + noQty);

		//  Update Prices
		sql = new StringBuilder("UPDATE T_InventoryValue iv ")
			.append("SET PricePO = ")
				.append("(SELECT MAX(currencyConvert (po.PriceList,po.C_Currency_ID,iv.C_Currency_ID,iv.DateValue,null, po.AD_Client_ID,po.AD_Org_ID))")
				.append(" FROM M_Product_PO po WHERE po.M_Product_ID=iv.M_Product_ID")
				.append(" AND po.IsCurrentVendor='Y'), ")
			.append("PriceList = ")
				.append("(SELECT currencyConvert(pp.PriceList,pl.C_Currency_ID,iv.C_Currency_ID,iv.DateValue,null, pl.AD_Client_ID,pl.AD_Org_ID)")
				.append(" FROM M_PriceList pl, M_PriceList_Version plv, M_ProductPrice pp")
				.append(" WHERE pp.M_Product_ID=iv.M_Product_ID AND pp.M_PriceList_Version_ID=iv.M_PriceList_Version_ID")
				.append(" AND pp.M_PriceList_Version_ID=plv.M_PriceList_Version_ID")
				.append(" AND plv.M_PriceList_ID=pl.M_PriceList_ID), ")
			.append("PriceStd = ")
				.append("(SELECT currencyConvert(pp.PriceStd,pl.C_Currency_ID,iv.C_Currency_ID,iv.DateValue,null, pl.AD_Client_ID,pl.AD_Org_ID)")
				.append(" FROM M_PriceList pl, M_PriceList_Version plv, M_ProductPrice pp")
				.append(" WHERE pp.M_Product_ID=iv.M_Product_ID AND pp.M_PriceList_Version_ID=iv.M_PriceList_Version_ID")
				.append(" AND pp.M_PriceList_Version_ID=plv.M_PriceList_Version_ID")
				.append(" AND plv.M_PriceList_ID=pl.M_PriceList_ID), ")
			.append("PriceLimit = ")
				.append("(SELECT currencyConvert(pp.PriceLimit,pl.C_Currency_ID,iv.C_Currency_ID,iv.DateValue,null, pl.AD_Client_ID,pl.AD_Org_ID)")
				.append(" FROM M_PriceList pl, M_PriceList_Version plv, M_ProductPrice pp")
				.append(" WHERE pp.M_Product_ID=iv.M_Product_ID AND pp.M_PriceList_Version_ID=iv.M_PriceList_Version_ID")
				.append(" AND pp.M_PriceList_Version_ID=plv.M_PriceList_Version_ID")
				.append(" AND plv.M_PriceList_ID=pl.M_PriceList_ID)")
				.append(" WHERE iv.AD_PInstance_ID=").append(getAD_PInstance_ID());

		no = DB.executeUpdateEx (sql.toString(), get_TrxName());
		String msg = "";
		if (no == 0)
			msg = "No Prices";

		//	Convert if different Currency
		if (as.getC_Currency_ID() != p_C_Currency_ID)
		{
			sql = new StringBuilder ("UPDATE T_InventoryValue iv ")
				.append("SET CostStandard= ")
					.append("(SELECT currencyConvert(iv.CostStandard,acs.C_Currency_ID,iv.C_Currency_ID,iv.DateValue,null, iv.AD_Client_ID,iv.AD_Org_ID) ")
					.append("FROM C_AcctSchema acs WHERE acs.C_AcctSchema_ID=").append(as.getC_AcctSchema_ID()).append("),")
				.append("	Cost= ")
					.append("(SELECT currencyConvert(iv.Cost,acs.C_Currency_ID,iv.C_Currency_ID,iv.DateValue,null, iv.AD_Client_ID,iv.AD_Org_ID) ")
					.append("FROM C_AcctSchema acs WHERE acs.C_AcctSchema_ID=").append(as.getC_AcctSchema_ID()).append(") ")
				.append("WHERE iv.AD_PInstance_ID=").append(getAD_PInstance_ID());
			no = DB.executeUpdateEx (sql.toString(), get_TrxName());
			log.fine("Converted=" + no);
		}
		
		//  Update Values
		StringBuilder dbeux = new StringBuilder("UPDATE T_InventoryValue SET ")
				.append("PricePOAmt = QtyOnHand * PricePO, ")
				.append("PriceListAmt = QtyOnHand * PriceList, ")
				.append("PriceStdAmt = QtyOnHand * PriceStd, ")
				.append("PriceLimitAmt = QtyOnHand * PriceLimit, ")
				.append("CostStandardAmt = QtyOnHand * CostStandard, ")
				.append("CostAmt = QtyOnHand * Cost ")
				.append("WHERE AD_PInstance_ID=").append(getAD_PInstance_ID()
				);
		no = DB.executeUpdateEx(dbeux.toString(), get_TrxName());
		log.fine("Calculation=" + no);
		//
		return msg;
	}   //  doIt

}   //  InventoryValue
