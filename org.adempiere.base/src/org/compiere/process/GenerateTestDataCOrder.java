/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2011 Adaxa Pty Ltd. All Rights Reserved.               	  *
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
 * or via info@compiere.org or http://www.compiere.org/license.html 	      *
 *****************************************************************************/

package org.compiere.process;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MOpportunity;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProcessPara;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.Query;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.Util;


/**
 *	Generate randomized data for tests/demos
 *	
 *  @author Paul Bowden
 *  @author refactored by Peter Takacs, Cloudempiere
 * 
 */
public class GenerateTestDataCOrder extends SvrProcess
{	
	public static final int MAX_NO_OF_TRIES = 100;
	
	private int			p_C_DocTypeTarget_ID = 0;
	private int			p_M_PriceList_Version_ID = 0;
	private int 		p_M_Product_Category_ID = 0;
	private Timestamp	p_Date_From = null;
	private Timestamp	p_Date_To = null;
	private ArrayList<Integer> bps = new ArrayList<Integer>();
	private Random random = new Random();
	private Calendar cal = Calendar.getInstance();
	private long duration = 0;
	private ArrayList<Integer> products = new ArrayList<Integer>();
	private ArrayList<Integer> productQtys = new ArrayList<Integer>();
	private ArrayList<Integer> salesReps = new ArrayList<Integer>();
	private int p_GenMaxNoOfDocument = 10;
	private int p_SalesRep_ID = 0;
	private int p_AD_Org_ID = 0;
	private int p_M_Warehouse_ID = 0;
	private String p_DocAction = MOrder.DOCACTION_Complete;
	private BigDecimal p_MaxValue = new BigDecimal(1000);
	private boolean p_isUseProductWithQtyAvailable = false;
	private int p_GenMaxNoOfDocumentLines = 10;
	private MPriceListVersion priceListVersion;
	private MDocType dt = null;
	private String description = null;
	MBPartner bp = null;

	/**
	 * 	Prepare
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equalsIgnoreCase("C_DocTypeTarget_ID"))
				p_C_DocTypeTarget_ID = para[i].getParameterAsInt();
			else if (name.equalsIgnoreCase("DateTrx"))
			{
				p_Date_From = (Timestamp)para[i].getParameter();
				p_Date_To = (Timestamp)para[i].getParameter_To();
			} 
			else if (name.equalsIgnoreCase("M_PriceList_Version_ID")) {
				p_M_PriceList_Version_ID = para[i].getParameterAsInt();
			}
			else if (name.equalsIgnoreCase("M_Product_Category_ID")) {
				p_M_Product_Category_ID = para[i].getParameterAsInt();
			}
			else if (name.equalsIgnoreCase("SalesRep_ID")) {
				p_SalesRep_ID = para[i].getParameterAsInt();
			}
			else if (name.equalsIgnoreCase("AD_Org_ID")) {
				p_AD_Org_ID = para[i].getParameterAsInt();
			}
			else if (name.equalsIgnoreCase("M_Warehouse_ID")) {
				p_M_Warehouse_ID = para[i].getParameterAsInt();
			}
			else if (name.equalsIgnoreCase("GenMaxNoOfDocument"))
			{
				p_GenMaxNoOfDocument = para[i].getParameterAsInt();
			}
			else if (name.equalsIgnoreCase("MaxValue"))
			{
				p_MaxValue = para[i].getParameterAsBigDecimal();
			}
			else if (name.equalsIgnoreCase("GenMaxNoOfDocumentLines"))
			{
				p_GenMaxNoOfDocumentLines = para[i].getParameterAsInt();
			}
			else if (name.equalsIgnoreCase("isUseProductWithQtyAvailable")) {
				p_isUseProductWithQtyAvailable = para[i].getParameterAsBoolean();
			}
			else if (name.equalsIgnoreCase("IsSOTrx"))
				;
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
			
			description = "Test Data (" + new MPInstance(getCtx(), getAD_PInstance_ID(), null).getCreated() + ")";
		}		
	}	//	prepare

	/**
	 * 	Process
	 *	@return msg
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		log.info("C_DocTypeTarget_ID=" + p_C_DocTypeTarget_ID 
			+ ", Date=" + p_Date_From + "->" + p_Date_To
			+ ", M_PriceList_Version_ID=" + p_M_PriceList_Version_ID);
		
		dt = MDocType.get(getCtx(), p_C_DocTypeTarget_ID);
		
		getAllBPartners();
		if(bps.size() <= 0)
			throw new AdempiereUserError("@NotFound@: @C_BPartner_ID@");
		
		getAllSalesReps();
		if(p_SalesRep_ID > 0)
			validateSalesRep();
		
		//validations
		if (p_C_DocTypeTarget_ID == 0)
			throw new AdempiereUserError("@NotFound@: @C_DocTypeTarget_ID@");
		
		if(p_M_PriceList_Version_ID > 0) {
			priceListVersion = new MPriceListVersion(getCtx(), p_M_PriceList_Version_ID, get_TrxName());
			if ( priceListVersion.getValidFrom().after(p_Date_From) )
				throw new AdempiereUserError("Price List Version not valid for Date From");
		}
		
		if (!(dt.getDocBaseType().equals(MDocType.DOCBASETYPE_SalesOrder) || (dt.getDocBaseType().equals(MDocType.DOCBASETYPE_PurchaseOrder))))
			throw new AdempiereException("Only Sales Order and Purchase Order document types supported");
		
		if(p_M_PriceList_Version_ID > 0) {
			MPriceList priceList = new MPriceList(getCtx(), priceListVersion.getM_PriceList_ID(), get_TrxName());
			boolean priceListSO = priceList.isSOPriceList();
			if((!priceListSO && dt.getDocBaseType().equals(MDocType.DOCBASETYPE_SalesOrder))
					|| (priceListSO && dt.getDocBaseType().equals(MDocType.DOCBASETYPE_PurchaseOrder)))
				throw new AdempiereException("Incorrect @C_DocTypeTarget_ID@ - @M_PriceList_Version_ID@ combination");
		}
		//
		
		getData();
		
		//generate orders
		int noOfGeneratedOrders = 0;
		if(dt.getDocBaseType().equals(MDocType.DOCBASETYPE_SalesOrder)) {
			for ( int i = 0; i < p_GenMaxNoOfDocument; i++ )
			{
				createRandomSalesOrder();
				// Update the user about what is going on
				if (processUI != null) {
					String status = "Created " + (i+1) + "/" + p_GenMaxNoOfDocument;
					processUI.statusUpdate(status);
				}
				noOfGeneratedOrders++;
			}
		}
		else if(dt.getDocBaseType().equals(MDocType.DOCBASETYPE_PurchaseOrder)) {
			// check qty available only when generating SO
			p_isUseProductWithQtyAvailable = false;
			for ( int i = 0; i < p_GenMaxNoOfDocument; i++ )
			{
				createRandomPurchaseOrder();
				// Update the user about what is going on
				if (processUI != null) {
					String status = "Created " + (i+1) + "/" + p_GenMaxNoOfDocument;
					processUI.statusUpdate(status);
				}
				noOfGeneratedOrders++;
			}
		}
		return "Number Of Generated Orders: " + noOfGeneratedOrders;
	}	//	doIt
	
	/**
	 * Gets BPartners depending on DocBaseType
	 */
	private void getAllBPartners() {
		String sql = "";
		if(dt.getDocBaseType().equals(MDocType.DOCBASETYPE_PurchaseOrder)) {
			sql = "SELECT DISTINCT ppo.C_BPartner_ID "
					+ " FROM M_Product_PO ppo "
					+ " JOIN M_Product p ON p.M_Product_ID = ppo.M_Product_ID AND p.IsActive='Y' "
					+ " JOIN C_BPartner bp ON bp.C_BPartner_ID = ppo.C_BPartner_ID "
					+ " WHERE ppo.IsActive='Y' "
//					+ " AND bp.C_TaxGroup_ID IS NOT NULL "
					+ " AND ppo.AD_Client_ID=? ";
		}
		else if(dt.getDocBaseType().equals(MDocType.DOCBASETYPE_SalesOrder)) {
			sql = "SELECT DISTINCT bp.C_BPartner_ID "
					+ " FROM C_BPartner bp "
					+ " JOIN C_BPartner_Location l ON l.C_BPartner_ID = bp.C_BPartner_ID "
					+ " WHERE bp.IsActive='Y' "
					+ " AND bp.AD_Client_ID=? "
					+ " AND (l.IsShipTo = 'Y' OR l.IsBillTo = 'Y') "
//					+ " AND bp.C_TaxGroup_ID IS NOT NULL "
					+ " AND bp.SOCreditStatus != 'S' ";
		}
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, getAD_Client_ID());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bps.add(rs.getInt(1));
			}
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	} //getAllBPartners
	
	/**
	 * Gets Sales Reps depending on DocBaseType
	 */
	private void getAllSalesReps() {
		//aduser join partner where issalesrep yes
		String sql;
		sql = "SELECT DISTINCT u.AD_User_ID "
				+ "FROM AD_User u "
				+ "JOIN C_BPartner bp using(C_BPartner_ID) "
				+ "WHERE bp.IsActive = 'Y' "
				+ "	AND bp.AD_Client_ID = ? "
				+ "	AND bp.IsSalesRep = 'Y' ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, getAD_Client_ID());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				salesReps.add(rs.getInt(1));
			}
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	} //getAllSalesReps
	
	/**
	 * If the given SalesRep_ID is not valid, get random
	 */
	private void validateSalesRep() {
		for (int id : salesReps) {
			if(id == p_SalesRep_ID)
				return;
		}
		p_SalesRep_ID = getRandomSalesRepID();
	}
	
	/**
	 * Get Products
	 */
	private void getAllProducts() {
		products.clear();
		String sql = "SELECT p.M_Product_ID ";
				if(p_isUseProductWithQtyAvailable)
					sql += ", ps.QtyAvailable ";
				sql += " FROM M_Product p ";
//				if(dt.getDocBaseType().equals(MDocType.DOCBASETYPE_PurchaseOrder))
//					sql += " JOIN M_Product_PO ppo on ppo.M_Product_ID = p.M_Product_ID ";
				if(p_isUseProductWithQtyAvailable)
					sql += " JOIN M_Product_Stock_V ps ON ps.M_Product_ID = p.M_Product_ID ";
				sql += " WHERE p.IsActive='Y' AND EXISTS (SELECT 1 FROM "
					+ " M_ProductPrice pp "
					+ " WHERE pp.M_Product_ID=p.M_Product_ID AND pp.IsActive = 'Y' ";
					if(p_M_PriceList_Version_ID > 0)
						sql += "AND pp.M_PriceList_Version_ID=" + p_M_PriceList_Version_ID;
					sql += ")"
				+ " AND p.AD_Client_ID=" + getAD_Client_ID()
				+ " AND p.C_TaxCategory_ID IS NOT NULL ";
				if(p_M_Product_Category_ID > 0)		
					sql += " AND p.M_Product_Category_ID=" + p_M_Product_Category_ID;
//				if(dt.getDocBaseType().equals(MDocType.DOCBASETYPE_PurchaseOrder))
//					sql += " AND ppo.C_BPartner_ID =" + bp.getC_BPartner_ID(); 		
				if(p_isUseProductWithQtyAvailable)
					sql += " AND M_Warehouse_ID = ? AND ps.QtyAvailable > 0 ";
				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			if(p_isUseProductWithQtyAvailable)
				pstmt.setInt(1, p_M_Warehouse_ID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				products.add(rs.getInt(1));
				if(p_isUseProductWithQtyAvailable)
					productQtys.add(rs.getInt(2));
			}
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		if((products != null) && (products.size() <= 0))
			throw new AdempiereUserError("No @M_Product_ID@ was found");
	} //getAllProducts
	
	/**
	 * Gets products and dates
	 */
	private void getData() {
		
		//Dates
		if (p_Date_To == null || p_Date_To.getTime() < p_Date_From.getTime())
			p_Date_To = new Timestamp(cal.getTimeInMillis());
		
		if (p_Date_From == null || p_Date_To.getTime() < p_Date_From.getTime())
		{
			cal.add(Calendar.YEAR, -1);
			p_Date_From = new Timestamp(cal.getTimeInMillis());
		}
		else
		{
			cal.setTime(p_Date_From);
		}
		
		duration  = p_Date_To.getTime() - p_Date_From.getTime();
	} //getData
	
	/*
	 * Create a random document
	 */
	private void createRandomSalesOrder() {
		bp = getRandomCustomer();
		getAllProducts();
		
		MOrder order = new MOrder(getCtx(), 0, get_TrxName());
		
		order.setBPartner(bp);
		
		order.setAD_Org_ID(p_AD_Org_ID);
		if(priceListVersion != null)
			order.setM_PriceList_ID(priceListVersion.getM_PriceList_ID());
		long addTime = Math.abs(random.nextLong()) % duration;
		
		Timestamp date = new Timestamp(p_Date_From.getTime() + addTime);
		order.setDateOrdered(date);
		order.setDateAcct(date);
		order.setDatePromised(date);
		order.setM_Warehouse_ID(p_M_Warehouse_ID);
		int salesRep_ID = p_SalesRep_ID;
		if (salesRep_ID <= 0)
			salesRep_ID = getRandomSalesRepID();
		order.setSalesRep_ID(salesRep_ID);
		order.setC_DocTypeTarget_ID(p_C_DocTypeTarget_ID);
		order.setC_DocType_ID(p_C_DocTypeTarget_ID);
		order.setDescription(description);
		if(Util.isEmpty(bp.getDeliveryViaRule())) {
			order.setDeliveryViaRule(MOrder.DELIVERYVIARULE_Pickup);
		}
		else {
			order.setDeliveryViaRule(bp.getDeliveryViaRule());
		}
		if(!order.save()) {
			log.info("Could not save Order");
			return;
		}
		
		int noOfLines = random.nextInt(p_GenMaxNoOfDocumentLines) + 1;
		BigDecimal maxValueOfLine = p_MaxValue.divide(new BigDecimal(noOfLines), 2, RoundingMode.HALF_UP);
		for ( int i = 0; i < noOfLines; i++)
		{
			MOrderLine ol = new MOrderLine(order);
			MProduct product = null;
			int maxQty = 1;
			
			int tries = 0;
			while(tries < MAX_NO_OF_TRIES) {
				product = getRandomProduct(0);
				if(products.size() < noOfLines)
					noOfLines = products.size();
				maxQty = calculateMaxQty(product, maxValueOfLine);
				tries++;
				if(maxQty > 0) {
					break;
				}
			}
			if(maxQty <= 0)
				continue;
			if(product != null) {
				ol.setProduct(product);
			}
			ol.setQty(new BigDecimal(random.nextInt(maxQty)+1));
			if(!ol.save())
				log.info("Could not save OrderLine");
		}

		MDocType dt = MDocType.get(getCtx(), p_C_DocTypeTarget_ID);
		
		if ( MDocType.DOCSUBTYPESO_Proposal.equals(dt.getDocSubTypeSO()) || MDocType.DOCSUBTYPESO_Quotation.equals(dt.getDocSubTypeSO()) )
				p_DocAction = MOrder.DOCACTION_Prepare;
		
		order.setDocAction(p_DocAction);
		order.processIt(p_DocAction);
		if(!order.save())
			log.info("Could not save Order");
		
		if (MDocType.DOCSUBTYPESO_Proposal.equals(dt.getDocSubTypeSO()) || MDocType.DOCSUBTYPESO_Quotation.equals(dt.getDocSubTypeSO()) )
		{
			MOpportunity op = new MOpportunity(getCtx(), 0, get_TrxName());
			op.setAD_Org_ID(order.getAD_Org_ID());
			op.setAD_User_ID(order.getAD_User_ID());
			op.setC_BPartner_ID(order.getC_BPartner_ID());
			op.setC_Campaign_ID(order.getC_Campaign_ID());
			op.setC_Currency_ID(order.getC_Currency_ID());
			op.setC_Order_ID(order.getC_Order_ID());
			op.setExpectedCloseDate(order.getDatePromised());
			op.setOpportunityAmt(order.getGrandTotal());
			op.setSalesRep_ID(order.getSalesRep_ID());
			if(!op.save())
				log.info("Could not save Opportunity");
			order.set_ValueOfColumn("C_Opportunity_ID", op.getC_Opportunity_ID());
			if(!order.save())
				log.info("Could not save Order");
		}
		try {
			commitEx();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		addLog(0, null, null, "Order: " + order.getDocumentNo(), MOrder.Table_ID, order.getC_Order_ID());
		
	}//createRandomSalesOrder

	/*
	 * Create a random document
	 */
	private void createRandomPurchaseOrder() {
		bp = getRandomCustomer();
		getAllProducts();
		
		MOrder po = new MOrder (getCtx(), 0, get_TrxName());		
		
		po.setAD_Org_ID(p_AD_Org_ID);
		po.setIsSOTrx(false);
		if(priceListVersion != null)
			po.setM_PriceList_ID(priceListVersion.getM_PriceList_ID());
		po.setC_DocTypeTarget_ID(p_C_DocTypeTarget_ID);
		po.setC_DocType_ID(p_C_DocTypeTarget_ID);
		po.setBPartner(bp);
		po.setPriorityRule("5");
		int salesRep_ID = p_SalesRep_ID;
		if (salesRep_ID <= 0)
			salesRep_ID = getRandomSalesRepID();
		po.setSalesRep_ID(salesRep_ID);
		po.setM_Warehouse_ID(p_M_Warehouse_ID);
		
		long addTime = Math.abs(random.nextLong()) % duration;
		Timestamp date = new Timestamp(p_Date_From.getTime() + addTime);
		po.setDateOrdered(date);
		po.setDatePromised(date);
		po.setDescription(description);
		if(Util.isEmpty(bp.getDeliveryViaRule())) {
			po.setDeliveryViaRule(MOrder.DELIVERYVIARULE_Pickup);
		}
		else {
			po.setDeliveryViaRule(bp.getDeliveryViaRule());
		}
		
		if(!po.save()) {
			log.info("Could not save Order");
			return;
		}
		
		int noOfLines = random.nextInt(p_GenMaxNoOfDocumentLines) + 1;
		BigDecimal maxValueOfLine = p_MaxValue.divide(new BigDecimal(noOfLines), 2, RoundingMode.HALF_UP);
		for ( int i = 0; i < noOfLines; i++)
		{
			MOrderLine poLine = new MOrderLine(po);
			MProduct product = null;
			int maxQty = 1;
			
			int tries = 0;
			while(tries < MAX_NO_OF_TRIES) {
				product = getRandomProduct(0);
				if(products.size() < noOfLines)
					noOfLines = products.size();
				maxQty = calculateMaxQty(product, maxValueOfLine);
				tries++;
				if(maxQty > 0) {
					break;
				}
			}
			if(product != null) {
				poLine.setProduct(product);
			}
			poLine.setQty(new BigDecimal(random.nextInt(maxQty)+1));
			if(!poLine.save())
				log.info("Could not save OrderLine");
		}
		po.setDocAction(p_DocAction);
		po.processIt(p_DocAction);
		if(!po.save())
			log.info("Could not save Order");
		
		try {
			commitEx();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		addLog(0, null, null, "Order: " + po.getDocumentNo(), MOrder.Table_ID, po.getC_Order_ID());
	}//createRandomPurchaseOrder
	
	/**
	 * returns random Product
	 * @param tries
	 * @return MProduct
	 */
	private MProduct getRandomProduct(int tries) {
		
		Integer productId = products.get(random.nextInt(products.size()));
		MProduct product = MProduct.get(getCtx(), productId);
		if ( !product.isASIMandatoryFor(null, true)) {
			int index = products.indexOf(productId);
			products.remove(productId);
			if((p_isUseProductWithQtyAvailable) && (index >= 0) && (index < productQtys.size()))
				productQtys.remove(index);
			return product;
		}
		else
			return getRandomProduct(tries + 1);
	}

	/**
	 * returns random BPartner
	 * @return MBPartner
	 */
	private MBPartner getRandomCustomer() {
		
		int bpId = bps.get(random.nextInt(bps.size()));
		return new MBPartner(getCtx(), bpId, get_TrxName());
		
	}	
	
	/**
	 * Returns random SalesRep_ID
	 * @return
	 */
	private int getRandomSalesRepID() {
		return salesReps.get(random.nextInt(salesReps.size()));
	}
	
	/**
	 * Calculates the max Qty that can be set on Order Line
	 * @param product
	 * @param maxValueOfLine
	 * @return int
	 */
	private int calculateMaxQty(MProduct product, BigDecimal maxValueOfLine) {
		int maxQty = 1;
		String where = "M_Product_ID="+product.getM_Product_ID() + " AND AD_Client_ID=" + getAD_Client_ID();
		if(p_M_PriceList_Version_ID > 0)
			where += " AND M_PriceList_Version_ID="+p_M_PriceList_Version_ID;
		MProductPrice pp = new Query(getCtx(), "M_ProductPrice", where, get_TrxName()).first();
		BigDecimal priceStd = BigDecimal.ZERO;
		
		if(pp != null)
			priceStd = pp.getPriceStd();
		if(priceStd.compareTo(BigDecimal.ZERO) > 0)
			maxQty = (maxValueOfLine.divide(priceStd, 2, RoundingMode.HALF_UP)).intValue();
		
		if(p_isUseProductWithQtyAvailable) {
			int qtyAvailable = getQtyAvailable(product);
			if(qtyAvailable < maxQty)
				maxQty = qtyAvailable;
		}
		if(maxQty < 0)
			maxQty = 0;
		if(maxQty > 1)
			maxQty--;
		return maxQty;
	}//calculateMaxQty
	
	/**
	 * Returns QtyAvailable from M_Product_Stock_V
	 * @param product
	 * @return int
	 */
	private int getQtyAvailable(MProduct product){
		int qtyAvailable = 0;
		Integer productID = product.getM_Product_ID();
		int index = products.indexOf(productID);
		if((index < products.size()) && (index >= 0))
			qtyAvailable = productQtys.get(index);
		return qtyAvailable;
	}//getQtyAvailable
}