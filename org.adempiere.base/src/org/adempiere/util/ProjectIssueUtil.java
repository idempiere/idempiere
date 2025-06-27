/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.adempiere.util;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MInOutLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProject;
import org.compiere.model.MProjectIssue;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;


public class ProjectIssueUtil
{
	protected transient static CLogger			log = CLogger.getCLogger(ProjectIssueUtil.class);
	
	/**
	 * 	Get PO Costs in Currency of AcctSchema
	 *	@param as Account Schema
	 *	@return Unit PO Cost
	 */
	public static BigDecimal getPOCost(MAcctSchema as, int inOutLineID, BigDecimal lineQty)
	{
		BigDecimal retValue = null;
		//	Uses PO Date
		String sql = "SELECT currencyConvert(ol.PriceActual, o.C_Currency_ID, ?, o.DateOrdered, o.C_ConversionType_ID, ?, ?) "
				+ "FROM C_OrderLine ol"
				+ " INNER JOIN M_InOutLine iol ON (iol.C_OrderLine_ID=ol.C_OrderLine_ID)"
				+ " INNER JOIN C_Order o ON (o.C_Order_ID=ol.C_Order_ID) "
				+ "WHERE iol.M_InOutLine_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, as.get_TrxName());
			pstmt.setInt(1, as.getC_Currency_ID());
			pstmt.setInt(2, as.getAD_Client_ID());
			pstmt.setInt(3, as.getAD_Org_ID());
			pstmt.setInt(4, inOutLineID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = rs.getBigDecimal(1);
				if (log.isLoggable(Level.FINE)) log.fine("POCost = " + retValue);
			}
			else
				log.warning("Not found for M_InOutLine_ID=" + inOutLineID);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			pstmt = null; rs = null;
		}
		if (retValue != null)
			retValue = retValue.multiply(lineQty);
		return retValue;
	}	//	getPOCost();
	
	/**
	 * 	Get Labor Cost from Expense Report
	 *	@param as Account Schema
	 *	@return Unit Labor Cost
	 */
	public static BigDecimal getLaborCost(MAcctSchema as, int timeExpLineID)
	{
		// Todor Lulov 30.01.2008
		BigDecimal retValue = Env.ZERO;
		BigDecimal qty = Env.ZERO;

		String sql = "SELECT ConvertedAmt, Qty FROM S_TimeExpenseLine " +
				" WHERE S_TimeExpenseLine.S_TimeExpenseLine_ID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, as.get_TrxName());
			pstmt.setInt(1, timeExpLineID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = rs.getBigDecimal(1);
				qty = rs.getBigDecimal(2);
				retValue = retValue.multiply(qty);
				if (log.isLoggable(Level.FINE)) log.fine("ExpLineCost = " + retValue);
			}
			else
				log.warning("Not found for S_TimeExpenseLine_ID=" + timeExpLineID);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			pstmt = null; rs = null;
		}
		return retValue;
	}	//	getLaborCost
	
	/**
	 * Get Total Product Costs
	 * 
	 * @param  as          accounting schema
	 * @param  AD_Org_ID   trx org
	 * @param  zeroCostsOK zero/no costs are OK
	 * @return             costs
	 */
	public static BigDecimal getProductCosts(MAcctSchema as, MProduct product, int asiID, int AD_Org_ID, BigDecimal qty,boolean zeroCostsOK)
	{
		String costingMethod = as.getCostingMethod();
		BigDecimal costs = MCost.getCurrentCost(product, asiID, as, AD_Org_ID, costingMethod, qty, 0, zeroCostsOK, as.get_TrxName());
		if (costs != null)
			return costs;
		return Env.ZERO;
	} // getProductCosts
	
	/**
	 * Get Product Standard Cost
	 * 
	 * @param  as        Accounting Schema
	 * @param  AD_Org_ID
	 * @param  productID
	 * @param  asiID
	 * @param  trxName
	 * @return           Product Standard Price
	 */
	public static BigDecimal getProductStdCost(MAcctSchema as, int AD_Org_ID, int productID, int asiID, String trxName, BigDecimal qty)
	{
		ProductCost pc = new ProductCost(Env.getCtx(), productID, asiID, trxName);
		String costingMethod = null;
		pc.setQty(qty);
		BigDecimal costs = pc.getProductCosts(as, AD_Org_ID, costingMethod, 0, true);
		if (costs != null)
			return costs;
		return Env.ZERO;
	} // getProductStdCost

	/**
	 * Get Cost Details of Product based on present ID
	 *
	 * @param  projectIssue Project Issue
	 * @param  acctSchema   Accounting Schema of Project
	 * @return
	 */
	public static BigDecimal getCostDetailCost(MProjectIssue projectIssue, MAcctSchema acctSchema)
	{
		MCostDetail costDetail = MCostDetail.get(	acctSchema.getCtx(), " C_ProjectIssue_ID = ? ", projectIssue.get_ID(),
													projectIssue.getM_AttributeSetInstance_ID(), acctSchema.get_ID(), acctSchema.get_TrxName());
		if (costDetail == null)
		{
			// Get Amt from Cost Details
			if (projectIssue.getM_InOutLine_ID() != 0)
				costDetail = MCostDetail.get(	acctSchema.getCtx(), " M_InOutLine_ID = ? ", projectIssue.getM_InOutLine_ID(),
												projectIssue.getM_AttributeSetInstance_ID(), acctSchema.get_ID(), acctSchema.get_TrxName());
			else if (projectIssue.getS_TimeExpenseLine_ID() != 0)
				costDetail = MCostDetail.get(	acctSchema.getCtx(), " S_TimeExpenseLine_ID = ? ", projectIssue.getS_TimeExpenseLine_ID(),
												projectIssue.getM_AttributeSetInstance_ID(), acctSchema.get_ID(), acctSchema.get_TrxName());
		}
		if (costDetail == null)
			return Env.ZERO;
		return costDetail.getAmt().divide(costDetail.getQty());
	} // getCostDetialCost

	/**
	 * Check Storage On Hand Qty and Return
	 *
	 * @param  inOutLine
	 * @param  requiredQty
	 * @param  asiID
	 * @return
	 */
	public static BigDecimal getInOutLineQTY(MInOutLine inOutLine, BigDecimal requiredQty, int asiID)
	{
		MStorageOnHand storageOnHand = MStorageOnHand.get(	inOutLine.getCtx(), inOutLine.getM_Locator_ID(), inOutLine.getM_Product_ID(), asiID, null,
															inOutLine.get_TrxName());

		if (storageOnHand != null)
		{
			if (requiredQty.compareTo(storageOnHand.getQtyOnHand()) > 0)
				return storageOnHand.getQtyOnHand();
			else
				return requiredQty;
		}
		return Env.ZERO;
	} // getInOutLineQTY

	/**
	 * Project issue Creation for In-Out Line for customized Locator and Attribute Set Instance
	 *
	 * @param locatorID    Locator ID
	 * @param projectIssue Reference Project Issue
	 * @param asiID        Product Attribute Set Instance
	 * @param qty          Quantity of Project Issue
	 * @param trxName      Transaction Name
	 */
	public static void createProjetIssue(int locatorID, MProjectIssue projectIssue, int asiID, BigDecimal qty, String trxName)
	{
		String desc = projectIssue.getM_InOutLine().toString();
		if (!Util.isEmpty(projectIssue.getDescription(), true))
			desc += projectIssue.getDescription();

		MProjectIssue pi = new MProjectIssue((MProject) projectIssue.getC_Project());
		pi.setMandatory(locatorID, projectIssue.getM_Product_ID(), qty);
		pi.setM_InOutLine_ID(projectIssue.getM_InOutLine_ID());
		pi.setMovementDate(projectIssue.getMovementDate());
		pi.setM_AttributeSetInstance_ID(asiID);
		pi.setDescription(desc);
		pi.saveEx(trxName);
	} // createProjetIssue

	/**
	 * Check In-Out Line Remain Quantity present in other Storage
	 * If present than create a new Project Issue
	 *
	 * @param  inOutLine             Parent Material Receipt
	 * @param  projectIssue          Project Issue
	 * @param  costingLevel          Costing Level
	 * @param  currLocatorStorageQty Current Locator Storage Quantity
	 * @param  asiID                 Attribute Set Instance ID
	 * @return                       Current Project Issue Product Qty
	 */
	public static void checkRemainInOutLineQty(MInOutLine inOutLine, MProjectIssue projectIssue, String costingLevel, BigDecimal currLocatorStorageQty, int asiID)
	{
		BigDecimal requireQty = inOutLine.getMovementQty().subtract(currLocatorStorageQty);

		// Where clause for Storage On Hand
		String sqlWhere = " M_Product_ID = ? AND M_Locator_ID != ? ";
		if (asiID == 0)
		{
			sqlWhere += " AND (M_AttributeSetInstance_ID = ? OR M_AttributeSetInstance_ID IS NULL)";
		}
		else
		{
			sqlWhere += " AND M_AttributeSetInstance_ID = ? ";
		}

		if (!MAcctSchema.COSTINGLEVEL_Client.equals(costingLevel))
		{
			sqlWhere += " AND  AD_Org_ID = ? ";
		}

		// Fetch Storage detail of other locators
		Query query = new Query(inOutLine.getCtx(), MStorageOnHand.Table_Name, sqlWhere, inOutLine.get_TrxName());
		if (!MAcctSchema.COSTINGLEVEL_Client.equals(costingLevel))
		{
			query.setParameters(inOutLine.getM_Product_ID(), inOutLine.getM_Locator_ID(), inOutLine.getM_AttributeSetInstance_ID(), inOutLine.getAD_Org_ID());
		}
		else
		{
			query.setParameters(inOutLine.getM_Product_ID(), inOutLine.getM_Locator_ID(), inOutLine.getM_AttributeSetInstance_ID());
		}

		query.setOrderBy(MStorageOnHand.COLUMNNAME_QtyOnHand + " DESC");

		List<MStorageOnHand> storages = query.list();
		for (MStorageOnHand storage : storages)
		{
			// Verify that the Project Issue Storage On-Hand quantity is non-zero. Otherwise, set
			// the locator and quantity on the Project Issue from the current storage.
			if (currLocatorStorageQty.signum() == 0)
			{
				projectIssue.setM_Locator_ID(storage.getM_Locator_ID());
				if (inOutLine.getMovementQty().compareTo(storage.getQtyOnHand()) > 0)
				{
					currLocatorStorageQty = storage.getQtyOnHand();
					projectIssue.setMovementQty(currLocatorStorageQty);
					requireQty = requireQty.subtract(currLocatorStorageQty);
					if (requireQty.signum() <= 0)
					{
						break;
					}
					continue;
				}
				else
				{
					projectIssue.setMovementQty(inOutLine.getMovementQty());
					return;
				}
			}

			// Check When Storage On Hand is same as current Storage
			if (inOutLine.getM_Locator_ID() == storage.getM_Locator_ID())
				continue;

			// Check required Qty is more or not
			createProjetIssue(	storage.getM_Locator_ID(), projectIssue, storage.getM_AttributeSetInstance_ID(),
								requireQty.compareTo(storage.getQtyOnHand()) <= 0 ? requireQty : storage.getQtyOnHand(), inOutLine.get_TrxName());

			if (requireQty.compareTo(storage.getQtyOnHand()) <= 0)
			{
				break;
			}
			requireQty = requireQty.subtract(storage.getQtyOnHand());
		}
		// Check Required Qty is not sufficient show Error
		if (currLocatorStorageQty.signum() <= 0)
		{
			projectIssue.setMovementQty(new BigDecimal(-1));
		}
		return;
	} // checkRemainInOutLineQty
}
