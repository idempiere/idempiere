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
 **********************************************************************/
package org.idempiere.acct.doc;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MProduct;
import org.compiere.model.MSysConfig;
import org.compiere.util.DB;
import org.compiere.util.TimeUtil;

/**
 * Helper methods for zero-cost accounting checks shared by {@link Doc} implementations.
 */
public final class DocCostHelper
{
	private DocCostHelper()
	{
	}

	/**
	 * Check if product has active effective purchase price list(s) with zero price and no active effective purchase price list with positive price
	 * as of the document accounting date.
	 * @param doc accounting document
	 * @param M_Product_ID product ID
	 * @return true if product is only on active effective purchase price list(s) with zero PriceStd and PriceList
	 */
	public static boolean isWithFreePurchasePriceList(Doc doc, int M_Product_ID)
	{
		if (doc == null)
			return false;
		return isWithFreePurchasePriceList(doc.getAD_Client_ID(), M_Product_ID, doc.getDateAcct(), doc.getTrxName());
	}

	/**
	 * Check if product has active effective purchase price list(s) with zero price and no active effective purchase price list with positive price
	 * as of the given accounting date.
	 * @param AD_Client_ID tenant ID
	 * @param M_Product_ID product ID
	 * @param dateAcct accounting date
	 * @param trxName transaction name
	 * @return true if product is only on active effective purchase price list(s) with zero PriceStd and PriceList
	 */
	public static boolean isWithFreePurchasePriceList(int AD_Client_ID, int M_Product_ID, Timestamp dateAcct, String trxName)
	{
		if (dateAcct == null)
			return false;
		Timestamp date = TimeUtil.getDay(dateAcct);
		String effectiveVersionFilter = "AND TRUNC(b.ValidFrom) <= ? "
				+ "AND NOT EXISTS (SELECT 1 FROM M_PriceList_Version b2 "
				+ "WHERE b2.M_PriceList_ID=b.M_PriceList_ID AND b2.IsActive='Y' "
				+ "AND TRUNC(b2.ValidFrom) <= ? "
				+ "AND (TRUNC(b2.ValidFrom) > TRUNC(b.ValidFrom) "
				+ "OR (TRUNC(b2.ValidFrom) = TRUNC(b.ValidFrom) AND b2.M_PriceList_Version_ID > b.M_PriceList_Version_ID))) ";
		String zeroSql = "SELECT CASE WHEN EXISTS (SELECT 1 FROM M_PriceList a "
				+ "JOIN M_PriceList_Version b ON a.M_PriceList_ID=b.M_PriceList_ID "
				+ "JOIN M_ProductPrice c ON b.M_PriceList_Version_ID=c.M_PriceList_Version_ID "
				+ "WHERE a.AD_Client_ID=? AND a.IsSOPriceList='N' AND c.M_Product_ID=? "
				+ "AND c.PriceStd=0 AND c.PriceList=0 AND a.IsActive='Y' AND b.IsActive='Y' AND c.IsActive='Y' "
				+ effectiveVersionFilter
				+ ") THEN 1 ELSE 0 END FROM DUAL";
		if (DB.getSQLValueEx(trxName, zeroSql, AD_Client_ID, M_Product_ID, date, date) == 1)
		{
			String positiveSql = "SELECT CASE WHEN EXISTS (SELECT 1 FROM M_PriceList a "
					+ "JOIN M_PriceList_Version b ON a.M_PriceList_ID=b.M_PriceList_ID "
					+ "JOIN M_ProductPrice c ON b.M_PriceList_Version_ID=c.M_PriceList_Version_ID "
					+ "WHERE a.AD_Client_ID=? AND a.IsSOPriceList='N' AND c.M_Product_ID=? "
					+ "AND (c.PriceStd > 0 OR c.PriceList > 0) AND a.IsActive='Y' AND b.IsActive='Y' AND c.IsActive='Y' "
					+ effectiveVersionFilter
					+ ") THEN 1 ELSE 0 END FROM DUAL";
			return DB.getSQLValueEx(trxName, positiveSql, AD_Client_ID, M_Product_ID, date, date) == 0;
		}
		return false;
	}

	/**
	 * Check if zero cost posting is allowed for a product based on configured SysConfig checks
	 * (zero-cost PO/invoice cost detail, zero-cost production cost detail, or free purchase price list).
	 * @param doc accounting document
	 * @param product product
	 * @return true if zero cost posting is allowed
	 */
	public static boolean isWithZeroCost(Doc doc, MProduct product)
	{
		if (doc == null)
			return false;
		return isWithZeroCost(doc, product, doc.getAcctSchema(), doc.getAD_Org_ID());
	}

	/**
	 * Check if zero cost posting is allowed for a product based on configured SysConfig checks
	 * (zero-cost PO/invoice cost detail, zero-cost production cost detail, or free purchase price list).
	 * @param doc accounting document
	 * @param product product
	 * @param as accounting schema (optional; when provided, scopes M_CostDetail queries to C_AcctSchema_ID and organization costing level)
	 * @return true if zero cost posting is allowed
	 */
	public static boolean isWithZeroCost(Doc doc, MProduct product, MAcctSchema as)
	{
		if (doc == null)
			return false;
		return isWithZeroCost(doc, product, as, doc.getAD_Org_ID());
	}

	/**
	 * Check if zero cost posting is allowed for a product based on configured SysConfig checks
	 * (zero-cost PO/invoice cost detail, zero-cost production cost detail, or free purchase price list).
	 * @param doc accounting document
	 * @param product product
	 * @param as accounting schema (optional; when provided, scopes M_CostDetail queries to C_AcctSchema_ID and organization costing level)
	 * @param AD_Org_ID organization ID (used when product costing level is Organization)
	 * @return true if zero cost posting is allowed
	 */
	public static boolean isWithZeroCost(Doc doc, MProduct product, MAcctSchema as, int AD_Org_ID)
	{
		if (doc == null || product == null)
			return false;

		MAcctSchema acctSchema = as != null ? as : doc.getAcctSchema();
		StringBuilder scopeClause = new StringBuilder();
		List<Object> baseParams = new ArrayList<>();
		baseParams.add(product.getM_Product_ID());
		if (acctSchema != null)
		{
			scopeClause.append(" AND C_AcctSchema_ID=?");
			baseParams.add(acctSchema.getC_AcctSchema_ID());
			if (AD_Org_ID > 0 && MAcctSchema.COSTINGLEVEL_Organization.equals(product.getCostingLevel(acctSchema)))
			{
				scopeClause.append(" AND AD_Org_ID=?");
				baseParams.add(AD_Org_ID);
			}
		}

		boolean checkOrder = MSysConfig.getBooleanValue(MSysConfig.CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING, true, doc.getAD_Client_ID());
		if (checkOrder)
		{
			//ok if we have purchased zero cost item from vendor before
			String sql = "SELECT CASE WHEN EXISTS (SELECT 1 FROM M_CostDetail WHERE M_Product_ID=?"
					+ scopeClause
					+ " AND Processed='Y' AND Amt=0.00 AND Qty > 0 AND (C_OrderLine_ID > 0 OR C_InvoiceLine_ID > 0)) THEN 1 ELSE 0 END FROM DUAL";
			if (DB.getSQLValueEx(doc.getTrxName(), sql, baseParams) == 1)
			{
				return true;
			}
		}

		boolean checkProduction = MSysConfig.getBooleanValue(MSysConfig.CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING, false, doc.getAD_Client_ID());
		if (checkProduction)
		{
			//ok if we have production with zero cost
			String sql = "SELECT CASE WHEN EXISTS (SELECT 1 FROM M_CostDetail WHERE M_Product_ID=?"
					+ scopeClause
					+ " AND Processed='Y' AND Amt=0.00 AND Qty > 0 AND M_ProductionLine_ID > 0) THEN 1 ELSE 0 END FROM DUAL";
			if (DB.getSQLValueEx(doc.getTrxName(), sql, baseParams) == 1)
			{
				return true;
			}
		}

		boolean checkPriceList = MSysConfig.getBooleanValue(MSysConfig.CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING, false, doc.getAD_Client_ID());
		if (checkPriceList && isWithFreePurchasePriceList(doc, product.getM_Product_ID()))
		{
			return true;
		}

		return false;
	}
}
