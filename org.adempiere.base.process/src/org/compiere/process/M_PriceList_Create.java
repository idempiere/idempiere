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
 * Contributor(s): Layda Salas (globalqss)                                    *
 * Contributor(s): Carlos Ruiz (globalqss)                                    *
 *****************************************************************************/

package org.compiere.process;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MClientInfo;
import org.compiere.model.MDiscountSchema;
import org.compiere.model.MDiscountSchemaLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPO;
import org.compiere.model.MProductPrice;
import org.compiere.model.MSequence;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;

/**
 * Create PriceList by copying purchase prices (M_Product_PO) 
 *		and applying product category discounts (M_CategoryDiscount)
 * 
 * @author Layda Salas (globalqss)
 * @version $Id: M_PriceList_Create,v 1.0 2005/10/09 22:19:00
 *          globalqss Exp $
 * @author Carlos Ruiz (globalqss)
 *         Make T_Selection tables permanent
 */
@org.adempiere.base.annotation.Process
public class M_PriceList_Create extends SvrProcess {

	/** Price List Version			*/
	private int p_PriceList_Version_ID = 0;
	/** Delete Old Prices			*/
	private boolean 	p_DeleteOld = false;

	private int m_AD_PInstance_ID = 0; 

	/** Price List Version			*/
	private MPriceListVersion 	m_plv = null;

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if (para.getParameter() == null)
				;
			else if (name.equals("DeleteOld"))
				p_DeleteOld = para.getParameterAsBoolean();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_PriceList_Version_ID = getRecord_ID();
		m_AD_PInstance_ID = getAD_PInstance_ID();
	} //*prepare*/

	/**
	 * Process
	 * 
	 * @return message
	 * @throws Exception
	 */
	protected String doIt() throws Exception {
		log.info ("M_PriceList_Version_ID=" + p_PriceList_Version_ID 
				+ ", DeleteOld=" + p_DeleteOld);
		m_plv = new MPriceListVersion (getCtx(), p_PriceList_Version_ID, get_TrxName());
		if (m_plv.get_ID() == 0 || m_plv.get_ID() != p_PriceList_Version_ID)
			throw new AdempiereUserError("@NotFound@  @M_PriceList_Version_ID@=" + p_PriceList_Version_ID);
		//	
		String error = checkPrerequisites();
		if (error != null && error.length() > 0)
			throw new AdempiereUserError(error);
		return create();
	}	//	doIt

	/**
	 * 	Prepare Calculations
	 *	@return error message
	 */
	private String checkPrerequisites() {
		Object[] clientParam = new Object[] {m_plv.getAD_Client_ID()};
		//PO Prices must exists
		DB.executeUpdateEx(
				"UPDATE M_Product_PO SET PriceList = 0 WHERE PriceList IS NULL AND AD_Client_ID=?",
				clientParam, get_TrxName());
		DB.executeUpdateEx(
				"UPDATE M_Product_PO SET PriceLastPO = 0 WHERE PriceLastPO IS NULL AND AD_Client_ID=?",
				clientParam, get_TrxName());
		DB.executeUpdateEx(
				"UPDATE M_Product_PO SET PricePO = PriceLastPO WHERE (PricePO IS NULL OR PricePO = 0) AND PriceLastPO <> 0 AND AD_Client_ID=?",
				clientParam, get_TrxName());
		DB.executeUpdateEx(
				"UPDATE	M_Product_PO SET PricePO = 0 WHERE PricePO IS NULL AND AD_Client_ID=?",
				clientParam, get_TrxName());
		//  Set default current vendor
		DB.executeUpdateEx(
				"UPDATE M_Product_PO p SET IsCurrentVendor = 'Y' "
						+ "WHERE IsCurrentVendor = 'N'"
						+ " AND NOT EXISTS "
						+ "(SELECT pp.M_Product_ID FROM M_Product_PO pp "
						+ "WHERE pp.M_Product_ID=p.M_Product_ID "
						+ "GROUP BY pp.M_Product_ID HAVING COUNT(*) > 1) "
						+ "AND AD_Client_ID=?",
						clientParam, get_TrxName());

		/**
		 *	Make sure that we have only one active product vendor
		 */
		/* NOTE iDempiere 7.1 -> anyways the validation on MProductPO.beforeSave doesn't allow this wrong data */ 
		String whereClause = "IsCurrentVendor='Y' AND IsActive='Y'"
				+ " AND EXISTS (SELECT M_Product_ID FROM M_Product_PO x "
				+ "WHERE x.M_Product_ID=M_Product_PO.M_Product_ID"
				+ " AND IsCurrentVendor='Y' AND IsActive='Y' "
				+ "GROUP BY M_Product_ID HAVING COUNT(*) > 1)";
		String orderByClause = "M_Product_ID, Created";
		List<MProductPO> pos = new Query(getCtx(), MProductPO.Table_Name, whereClause, get_TrxName())
				.setClient_ID()
				.setOrderBy(orderByClause)
				.list();
		int success = 0;
		int errors = 0;
		int M_Product_ID = 0;
		for (MProductPO po : pos) {
			if (M_Product_ID != po.getM_Product_ID()) {
				M_Product_ID = po.getM_Product_ID();
				continue;
			}
			po.setIsCurrentVendor (false);
			if (po.save())
				success++;
			else {
				errors++;
				log.warning("Not updated " + po);
			}
		}
		log.info ("Current Vendor - Changes=" + success + ", Errors=" + errors);
		return null;

	}	//	checkPrerequisites

	/**
	 * 	Create Price List
	 *	@return info message
	 */
	private String create() throws Exception {
		StringBuffer info = new StringBuffer();

		/**	Delete Old Data	*/
		if (p_DeleteOld) {
			int no = DB.executeUpdateEx("DELETE FROM M_ProductPrice WHERE M_PriceList_Version_ID=?",
					new Object[] {p_PriceList_Version_ID}, get_TrxName());
			log.info("Deleted=" + no);
			info.append("@Deleted@=").append(no).append(" - ");
		}

		int M_Pricelist_Version_Base_ID = m_plv.getM_Pricelist_Version_Base_ID();
		MPriceList pl = m_plv.getPriceList();
		int curPrecision = pl.getStandardPrecision();

		/**
		 *	For All Discount Lines in Sequence
		 */
		MDiscountSchema ds = new MDiscountSchema(getCtx(), m_plv.getM_DiscountSchema_ID(), get_TrxName());
		MDiscountSchemaLine[] dsl = ds.getLines(false);
		for (MDiscountSchemaLine dsLine : dsl) {
			// ignore inactive discount schema lines
			if( !dsLine.isActive() )
				continue;

			String message = "#" + dsLine.getSeqNo();
			String dd = dsLine.getDescription();
			if (dd != null && dd.length() > 0)
				message += " " + dd;

			//	Clear Temporary Table
			int noDeleted = DB.executeUpdateEx("DELETE FROM T_Selection WHERE AD_PInstance_ID=?",
					new Object[] {m_AD_PInstance_ID}, get_TrxName());

			//	Create Selection in Temporary Table
			StringBuilder sqlb = new StringBuilder("INSERT INTO T_Selection (AD_PInstance_ID, T_Selection_ID) ");
			int M_DiscountSchemaLine_ID = dsLine.getM_DiscountSchemaLine_ID();
			int p2 = M_Pricelist_Version_Base_ID;
			if (p2 == 0) { //	Create from PO	**
				p2 = dsLine.getAD_Client_ID();
				sqlb.append(
						"SELECT DISTINCT ?, po.M_Product_ID "	//	#1
						+ "FROM M_Product_PO po "
						+ " INNER JOIN M_Product p ON (p.M_Product_ID=po.M_Product_ID)"
						+ " INNER JOIN M_DiscountSchemaLine dl ON (dl.M_DiscountSchemaLine_ID=?) "	//	#2
						+ "WHERE p.AD_Client_ID IN (?, 0)"		//	#3
						+ " AND p.IsActive='Y' AND po.IsActive='Y'"
						//	Optional Restrictions
						+ " AND (dl.Group1 IS NULL OR p.Group1=dl.Group1)"
						+ " AND (dl.Group2 IS NULL OR p.Group2=dl.Group2)"
						+ " AND (dl.C_BPartner_ID IS NULL OR po.C_BPartner_ID=dl.C_BPartner_ID)" 
						+ " AND (dl.VendorCategory IS NULL OR po.VendorCategory=dl.VendorCategory)"
						+ " AND (dl.IsIgnoreIsCurrentVendor='Y' OR po.IsCurrentVendor='Y')"
						+ " AND (dl.M_Product_ID IS NULL OR p.M_Product_ID=dl.M_Product_ID)");
				if (dsLine.getM_Product_Category_ID() > 0) {
					sqlb.append(" AND p.M_Product_Category_ID IN (")
						.append(getSubCategoryWhereClause(dsLine.getM_Product_Category_ID()))
						.append(")");
				}
			} else { //	Create from Price List **
				sqlb.append(
						"SELECT DISTINCT ?, p.M_Product_ID "	//	#1
						+ "FROM M_ProductPrice pp"
						+ " INNER JOIN M_Product p ON (p.M_Product_ID=pp.M_Product_ID)"
						+ " INNER JOIN M_DiscountSchemaLine dl ON (dl.M_DiscountSchemaLine_ID=?) "	//	#2
						+ "WHERE pp.M_PriceList_Version_ID=?"	//	#3 PriceList_Version_Base_ID
						+ " AND p.IsActive='Y' AND pp.IsActive='Y'"
						//	Optional Restrictions
						+ " AND (dl.Group1 IS NULL OR p.Group1=dl.Group1)"
						+ " AND (dl.Group2 IS NULL OR p.Group2=dl.Group2)"
						+ " AND ((dl.C_BPartner_ID IS NULL AND dl.VendorCategory IS NULL) OR EXISTS "
						+ "(SELECT * FROM M_Product_PO po"
						+ " WHERE po.M_Product_ID=p.M_Product_ID"
						+ "   AND (dl.C_BPartner_ID IS NULL OR po.C_BPartner_ID=dl.C_BPartner_ID)"
						+ "   AND (dl.VendorCategory IS NULL OR po.VendorCategory=dl.VendorCategory)))"
 						+ " AND (dl.M_Product_ID IS NULL OR p.M_Product_ID=dl.M_Product_ID)");
				if (dsLine.getM_Product_Category_ID() > 0) {
					sqlb.append(" AND p.M_Product_Category_ID IN (")
						.append(getSubCategoryWhereClause(dsLine.getM_Product_Category_ID()))
						.append(")");
				}
			}
			int noSelected = DB.executeUpdateEx(sqlb.toString(),
					new Object[] {m_AD_PInstance_ID, M_DiscountSchemaLine_ID, p2}, get_TrxName());
			message += ": @Selected@=" + noSelected;

			String sql;
			//	Delete Prices in Selection, so that we can insert
			if (   M_Pricelist_Version_Base_ID == 0
				|| M_Pricelist_Version_Base_ID != p_PriceList_Version_ID) {
				sql = "DELETE FROM M_ProductPrice pp WHERE pp.M_PriceList_Version_ID=?"
						+ " AND EXISTS (SELECT * FROM T_Selection s WHERE AD_PInstance_ID=? AND pp.M_Product_ID=s.T_Selection_ID)";
				noDeleted = DB.executeUpdateEx(sql,  new Object[] {p_PriceList_Version_ID, m_AD_PInstance_ID}, get_TrxName());
				message += ", @Deleted@=" + noDeleted;
			}

			//	Copy (Insert) Prices
			int noInserted = 0;
			sql = "INSERT INTO M_ProductPrice "
					+ "(M_PriceList_Version_ID, M_Product_ID,"
					+ " AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,"
					+ " PriceList, PriceStd, PriceLimit, M_ProductPrice_ID, M_ProductPrice_UU) ";
			//
			int seqproductpriceid = MSequence.get(getCtx(), "M_ProductPrice").get_ID();
			if (M_Pricelist_Version_Base_ID == p_PriceList_Version_ID)
				sql = null;	//	We have Prices already
			else if (M_Pricelist_Version_Base_ID == 0) {
				/**	Copy and Convert from Product_PO	*/
				sql	+= "SELECT plv.M_PriceList_Version_ID, po.M_Product_ID,"
						+ " plv.AD_Client_ID, plv.AD_Org_ID, 'Y', SysDate, plv.UpdatedBy, SysDate, plv.UpdatedBy,"
						//	Price List
						+ " COALESCE(currencyConvert(po.PriceList,"
						+ " po.C_Currency_ID, pl.C_Currency_ID, dl.ConversionDate, dl.C_ConversionType_ID, plv.AD_Client_ID, plv.AD_Org_ID), 0)," 
						//	Price Std
						+ " COALESCE(currencyConvert(po.PriceList,"
						+ "	po.C_Currency_ID, pl.C_Currency_ID, dl.ConversionDate, dl.C_ConversionType_ID, plv.AD_Client_ID, plv.AD_Org_ID), 0),"
						//	Price Limit
						+ " COALESCE(currencyConvert(po.PricePO,"
						+ " po.C_Currency_ID, pl.C_Currency_ID, dl.ConversionDate, dl.C_ConversionType_ID, plv.AD_Client_ID, plv.AD_Org_ID), 0), "
						//
						+ " nextidfunc(?,'N'), generate_uuid() "	//	#1
						+ "FROM M_Product_PO po"
						+ " INNER JOIN M_PriceList_Version plv ON (plv.M_PriceList_Version_ID=?)"	//	#2
						+ " INNER JOIN M_PriceList pl ON (pl.M_PriceList_ID=plv.M_PriceList_ID)"
						+ " INNER JOIN M_DiscountSchemaLine dl ON (dl.M_DiscountSchemaLine_ID=?) "	//	#3
						//
						+ "WHERE EXISTS (SELECT * FROM T_Selection s WHERE s.AD_PInstance_ID=? AND po.M_Product_ID=s.T_Selection_ID)"	//	#4
						+ " AND ((dl.C_BPartner_ID IS NULL AND po.IsCurrentVendor='Y')"
						+ "      OR (po.C_BPartner_ID=dl.C_BPartner_ID AND (dl.IsIgnoreIsCurrentVendor='Y' OR po.IsCurrentVendor='Y')))"
						+ " AND po.IsActive='Y'";
			} else {
				/**	Copy and Convert from other PriceList_Version	*/
				sql += "SELECT plv.M_PriceList_Version_ID, pp.M_Product_ID,"
						+ " plv.AD_Client_ID, plv.AD_Org_ID, 'Y', SysDate, plv.UpdatedBy, SysDate, plv.UpdatedBy,"
						//	Price List
						+ " COALESCE(currencyConvert(pp.PriceList,"
						+ " bpl.C_Currency_ID, pl.C_Currency_ID, dl.ConversionDate, dl.C_ConversionType_ID, plv.AD_Client_ID, plv.AD_Org_ID), 0)," 
						//	Price Std
						+ " COALESCE(currencyConvert(pp.PriceStd,"
						+ " bpl.C_Currency_ID, pl.C_Currency_ID, dl.ConversionDate, dl.C_ConversionType_ID, plv.AD_Client_ID, plv.AD_Org_ID), 0)," 
						//	Price Limit
						+ " COALESCE(currencyConvert(pp.PriceLimit,"
						+ " bpl.C_Currency_ID, pl.C_Currency_ID, dl.ConversionDate, dl.C_ConversionType_ID, plv.AD_Client_ID, plv.AD_Org_ID), 0), "
						//
						+ " nextidfunc(?,'N'), generate_uuid() "	//	#1
						+ "FROM M_ProductPrice pp"
						+ " INNER JOIN M_PriceList_Version plv ON (plv.M_PriceList_Version_ID=?)"	//	#2
						+ " INNER JOIN M_PriceList pl ON (pl.M_PriceList_ID=plv.M_PriceList_ID)"
						+ " INNER JOIN M_PriceList_Version bplv ON (pp.M_PriceList_Version_ID=bplv.M_PriceList_Version_ID)"
						+ " INNER JOIN M_PriceList bpl ON (bplv.M_PriceList_ID=bpl.M_PriceList_ID)"
						+ " INNER JOIN M_DiscountSchemaLine dl ON (dl.M_DiscountSchemaLine_ID=?) "	//	#3
						//
						+ "WHERE pp.M_PriceList_Version_ID=?"	//	#4 M_PriceList_Version_Base_ID
						+ " AND EXISTS (SELECT * FROM T_Selection s WHERE s.AD_PInstance_ID=? AND pp.M_Product_ID=s.T_Selection_ID)"	//	#5
						+ " AND pp.IsActive='Y'";
			}
			if (sql != null) {
				Object[] params;
				if (M_Pricelist_Version_Base_ID == 0) {
					params = new Object[] {seqproductpriceid, p_PriceList_Version_ID, M_DiscountSchemaLine_ID, m_AD_PInstance_ID};
				} else {
					params = new Object[] {seqproductpriceid, p_PriceList_Version_ID, M_DiscountSchemaLine_ID, M_Pricelist_Version_Base_ID, m_AD_PInstance_ID};
				}
				noInserted = DB.executeUpdateEx(sql,  params, get_TrxName());
				message += " @Inserted@=" + noInserted;
			}

			/** Calculations	**/
			MProductPrice[] pp = m_plv.getProductPrice(
					"AND EXISTS (SELECT * FROM T_Selection s "
							+ "WHERE s.AD_PInstance_ID = " + m_AD_PInstance_ID + " AND s.T_Selection_ID=M_ProductPrice.M_Product_ID)");
			for (MProductPrice price : pp) {
				BigDecimal priceList = price.getPriceList();
				BigDecimal priceStd = price.getPriceStd();
				BigDecimal priceLimit = price.getPriceLimit();
				//
				price.setPriceList(calculate (dsLine.getList_Base(),
						priceList, priceStd, priceLimit, dsLine.getList_Fixed(),
						dsLine.getList_AddAmt(), dsLine.getList_Discount(),
						dsLine.getList_Rounding(), curPrecision, price.getM_Product_ID()));
				price.setPriceStd (calculate (dsLine.getStd_Base(),
						priceList, priceStd, priceLimit, dsLine.getStd_Fixed(),
						dsLine.getStd_AddAmt(), dsLine.getStd_Discount(),
						dsLine.getStd_Rounding(), curPrecision, price.getM_Product_ID()));
				price.setPriceLimit(calculate (dsLine.getLimit_Base(),
						priceList, priceStd, priceLimit, dsLine.getLimit_Fixed(),
						dsLine.getLimit_AddAmt(), dsLine.getLimit_Discount(),
						dsLine.getLimit_Rounding(), curPrecision, price.getM_Product_ID()));
				price.saveEx();
			}	//	for all products

			addLog(message);
		}	//	for all lines

		//	Clear Temporary Table
		DB.executeUpdateEx("DELETE FROM T_Selection WHERE AD_PInstance_ID=?",
				new Object[] {m_AD_PInstance_ID}, get_TrxName());

		//
		MProductPrice[] pp = m_plv.getProductPrice(true);
		info.append(" - @Records@=").append(pp.length);
		return info.toString();
	}	//	create

	/**
	 * 	Calculate Price
	 *	@param base rule
	 *	@param list price
	 *	@param std price
	 *	@param limit price
	 *	@param fix amount
	 *	@param add amount
	 *	@param discount percent
	 *	@param round rule
	 *  @param M_Product_ID 
	 *	@return calculated price
	 */
	private BigDecimal calculate (String base, 
			BigDecimal list, BigDecimal std, BigDecimal limit, BigDecimal fix, 
			BigDecimal add, BigDecimal discount, String round, int curPrecision, int M_Product_ID) {
		BigDecimal calc = null;
		double dd = 0.0;
		if (MDiscountSchemaLine.LIST_BASE_ListPrice.equals(base))
			dd = list.doubleValue();
		else if (MDiscountSchemaLine.LIST_BASE_StandardPrice.equals(base))
			dd = std.doubleValue();
		else if (MDiscountSchemaLine.LIST_BASE_LimitPOPrice.equals(base))
			dd = limit.doubleValue();
		else if (MDiscountSchemaLine.LIST_BASE_FixedPrice.equals(base))
			calc = fix;
		else if (MDiscountSchemaLine.LIST_BASE_ProductCost.equals(base)) {
			MAcctSchema as = MClientInfo.get(getCtx(), m_plv.getAD_Client_ID()).getMAcctSchema1();
			ProductCost m_productCost = new ProductCost(getCtx(), M_Product_ID, 0, get_TrxName());
			m_productCost.setQty(BigDecimal.ONE);
			BigDecimal costs = m_productCost.getProductCosts(as, m_plv.getAD_Org_ID(), null, 0, false);	
			if (costs == null || costs.signum() == 0) { //	zero costs OK
				MProduct product = new MProduct(getCtx(), M_Product_ID, get_TrxName());
				if (product.isStocked())
					log.log(Level.WARNING, "No Costs for " + product.getName());
			}
			calc = costs;
		} else
			throw new IllegalArgumentException("Unknown Base=" + base);

		if (calc == null) {
			if (add.signum() != 0)
				dd += add.doubleValue();
			if (discount.signum() != 0)
				dd *= 1 - (discount.doubleValue()/100.0);
			calc = new BigDecimal(dd);
		}

		//	Rounding
		if (MDiscountSchemaLine.LIST_ROUNDING_CurrencyPrecision.equals(round))
			calc = calc.setScale(curPrecision, RoundingMode.HALF_UP);
		else if (MDiscountSchemaLine.LIST_ROUNDING_Dime102030.equals(round))
			calc = calc.setScale(1, RoundingMode.HALF_UP);
		else if (MDiscountSchemaLine.LIST_ROUNDING_Hundred.equals(round))
			calc = calc.setScale(-2, RoundingMode.HALF_UP);
		else if (MDiscountSchemaLine.LIST_ROUNDING_Nickel051015.equals(round)) {
			BigDecimal mm = new BigDecimal(20);
			calc = calc.multiply(mm); 
			calc = calc.setScale(0, RoundingMode.HALF_UP);
			calc = calc.divide(mm, 2, RoundingMode.HALF_UP);
		}
		else if (MDiscountSchemaLine.LIST_ROUNDING_NoRounding.equals(round))
			;
		else if (MDiscountSchemaLine.LIST_ROUNDING_Quarter255075.equals(round)) {
			BigDecimal mm = new BigDecimal(4);
			calc = calc.multiply(mm); 
			calc = calc.setScale(0, RoundingMode.HALF_UP);
			calc = calc.divide(mm, 2, RoundingMode.HALF_UP);
		}
		else if (MDiscountSchemaLine.LIST_ROUNDING_Ten10002000.equals(round))
			calc = calc.setScale(-1, RoundingMode.HALF_UP);
		else if (MDiscountSchemaLine.LIST_ROUNDING_Thousand.equals(round))
			calc = calc.setScale(-3, RoundingMode.HALF_UP);
		else if (MDiscountSchemaLine.LIST_ROUNDING_WholeNumber00.equals(round))
			calc = calc.setScale(0, RoundingMode.HALF_UP);

		return calc;
	}	//	calculate

	/**
	 * Returns a sql where string with the given category id and all of its subcategory ids.
	 * It is used as restriction in MQuery.
	 * @param productCategoryId
	 * @return
	 * @throws  
	 */
	private String getSubCategoryWhereClause(int productCategoryId) throws SQLException, AdempiereSystemError {
		//if a node with this id is found later in the search we have a loop in the tree
		int subTreeRootParentId = 0;
		StringBuilder retString = new StringBuilder();
		String sql = " SELECT M_Product_Category_ID, M_Product_Category_Parent_ID FROM M_Product_Category";
		final Vector<SimpleTreeNode> categories = new Vector<SimpleTreeNode>(100);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = DB.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if(rs.getInt(1)==productCategoryId) {
					subTreeRootParentId = rs.getInt(2);
				}
				categories.add(new SimpleTreeNode(rs.getInt(1), rs.getInt(2)));
			}
			retString.append(getSubCategoriesString(productCategoryId, categories, subTreeRootParentId));
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(rs, stmt);
			rs = null; stmt = null;
		}
		return retString.toString();
	}

	/**
	 * Recursive search for subcategories with loop detection.
	 * @param productCategoryId
	 * @param categories
	 * @param loopIndicatorId
	 * @return comma separated list of category ids
	 * @throws AdempiereSystemError if a loop is detected
	 */
	private String getSubCategoriesString(int productCategoryId, Vector<SimpleTreeNode> categories, int loopIndicatorId) throws AdempiereSystemError {
		StringBuilder ret = new StringBuilder();
		final Iterator<SimpleTreeNode> iter = categories.iterator();
		while (iter.hasNext()) {
			SimpleTreeNode node = iter.next();
			if (node.getParentId() == productCategoryId) {
				if (node.getNodeId() == loopIndicatorId) {
					throw new AdempiereSystemError("The product category tree contains a loop on categoryId: " + loopIndicatorId);
				}
				ret.append(getSubCategoriesString(node.getNodeId(), categories, loopIndicatorId));
				ret.append(",");
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine(ret.toString());
		return ret.toString() + productCategoryId;
	}

	/**
	 * Simple tree node class for product category tree search.
	 * @author Karsten Thiemann, kthiemann@adempiere.org
	 *
	 */
	private static class SimpleTreeNode {

		private int nodeId;

		private int parentId;

		public SimpleTreeNode(int nodeId, int parentId) {
			this.nodeId = nodeId;
			this.parentId = parentId;
		}

		public int getNodeId() {
			return nodeId;
		}

		public int getParentId() {
			return parentId;
		}
	}

} // M_PriceList_Create