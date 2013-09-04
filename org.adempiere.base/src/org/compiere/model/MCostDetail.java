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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.acct.Doc;
import org.compiere.model.X_M_CostHistory;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 	Cost Detail Model
 *	
 *  @author Jorg Janke
 *  @author Armen Rizal, Goodwill Consulting
 *  	<li>BF: 2431123 Return Trx changes weighted average cost
 *  	<li>BF: 1568752 Average invoice costing: landed costs incorrectly applied
 *  @author Armen Rizal & Bayu Cahya
 *  	<li>BF [ 2129781 ] Cost Detail not created properly for multi acc schema
 *  @author Teo Sarca
 *  	<li>BF [ 2847648 ] Manufacture & shipment cost errors
 *  		https://sourceforge.net/tracker/?func=detail&aid=2847648&group_id=176962&atid=934929
 * 	@author red1 FR: [ 2214883 ] Remove SQL code and Replace for Query
 *  @version $Id: MCostDetail.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 *  
 */
public class MCostDetail extends X_M_CostDetail
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -448632684360931078L;

	private static final String INOUTLINE_DOCBASETYPE_SQL =
		    "SELECT c.DocBaseType From M_InOut io " +
			"INNER JOIN M_InOutLine iol ON io.M_InOut_ID=iol.M_InOut_ID " +
			"INNER JOIN C_DocType c ON io.C_DocType_ID=c.C_DocType_ID " +
			"WHERE iol.M_InOutLine_ID=?";
			
	/**
	 * 	Create New Order Cost Detail for Purchase Orders.
	 * 	Called from Doc_MatchPO
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param C_OrderLine_ID order
	 *	@param M_CostElement_ID optional cost element for Freight
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param trxName transaction
	 *	@return true if created
	 */
	public static boolean createOrder (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int C_OrderLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		MCostDetail cd = get (as.getCtx(), "C_OrderLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
			C_OrderLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, trxName);
			cd.setC_OrderLine_ID (C_OrderLine_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
				// MZ Goodwill
				// set deltaAmt=Amt, deltaQty=qty, and set Cost Detail for Amt and Qty	 
				cd.setDeltaAmt(Amt.subtract(cd.getAmt()));
				cd.setDeltaQty(Qty.subtract(cd.getQty()));
			}
			else
			{
				cd.setDeltaAmt(BigDecimal.ZERO);
				cd.setDeltaQty(BigDecimal.ZERO);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			if (cd.isDelta())
			{
				cd.setProcessed(false);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			// end MZ
			else if (cd.isProcessed())
				return true;	//	nothing to do
		}
		boolean ok = cd.save();
		if (ok && !cd.isProcessed())
		{
			ok = cd.process();
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("(" + ok + ") " + cd);
		return ok;
	}	//	createOrder

	
	/**
	 * 	Create New Invoice Cost Detail for AP Invoices.
	 * 	Called from Doc_Invoice - for Invoice Adjustments
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param C_InvoiceLine_ID invoice
	 *	@param M_CostElement_ID optional cost element for Freight
	 *	@param Amt amt
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param trxName transaction
	 *	@return true if created
	 */
	public static boolean createInvoice (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int C_InvoiceLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		MCostDetail cd = get (as.getCtx(), "C_InvoiceLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
			C_InvoiceLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, trxName);
			cd.setC_InvoiceLine_ID (C_InvoiceLine_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
				// MZ Goodwill
				// set deltaAmt=Amt, deltaQty=qty, and set Cost Detail for Amt and Qty	 
				cd.setDeltaAmt(Amt.subtract(cd.getAmt()));
				cd.setDeltaQty(Qty.subtract(cd.getQty()));
			}
			else
			{
				cd.setDeltaAmt(BigDecimal.ZERO);
				cd.setDeltaQty(BigDecimal.ZERO);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			if (cd.isDelta())
			{
				cd.setProcessed(false);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			// end MZ
			else if (cd.isProcessed())
				return true;	//	nothing to do
		}
		boolean ok = cd.save();
		if (ok && !cd.isProcessed())
		{
			ok = cd.process();
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("(" + ok + ") " + cd);
		return ok;
	}	//	createInvoice
	
	/**
	 * 	Create New Shipment Cost Detail for SO Shipments.
	 * 	Called from Doc_MInOut - for SO Shipments  
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param M_InOutLine_ID shipment
	 *	@param M_CostElement_ID optional cost element for Freight
	 *	@param Amt amt
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param IsSOTrx sales order
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createShipment (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_InOutLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, boolean IsSOTrx, String trxName)
	{
		MCostDetail cd = get (as.getCtx(), "M_InOutLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
			M_InOutLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, trxName);
			cd.setM_InOutLine_ID(M_InOutLine_ID);
			cd.setIsSOTrx(IsSOTrx);
		}
		else
		{
			if (cd.isProcessed())
			{
				// MZ Goodwill
			    // set deltaAmt=Amt, deltaQty=qty, and set Cost Detail for Amt and Qty	 
				cd.setDeltaAmt(Amt.subtract(cd.getAmt()));
				cd.setDeltaQty(Qty.subtract(cd.getQty()));
			}
			else
			{
				cd.setDeltaAmt(BigDecimal.ZERO);
				cd.setDeltaQty(BigDecimal.ZERO);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			if (cd.isDelta())
			{
				cd.setProcessed(false);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			// end MZ
			else if (cd.isProcessed())
				return true;	//	nothing to do
		}
		boolean ok = cd.save();
		if (ok && !cd.isProcessed())
		{
			ok = cd.process();
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("(" + ok + ") " + cd);
		return ok;
	}	//	createShipment

	/**
	 * 	Create New Order Cost Detail for Physical Inventory.
	 * 	Called from Doc_Inventory
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param M_InventoryLine_ID order
	 *	@param M_CostElement_ID optional cost element
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createInventory (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_InventoryLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		MCostDetail cd = get (as.getCtx(), "M_InventoryLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
			M_InventoryLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, trxName);
			cd.setM_InventoryLine_ID(M_InventoryLine_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
				// MZ Goodwill
				// set deltaAmt=Amt, deltaQty=qty, and set Cost Detail for Amt and Qty	
				cd.setDeltaAmt(Amt.subtract(cd.getAmt()));
				cd.setDeltaQty(Qty.subtract(cd.getQty()));
			}
			else
			{
				cd.setDeltaAmt(BigDecimal.ZERO);
				cd.setDeltaQty(BigDecimal.ZERO);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			if (cd.isDelta())
			{
				cd.setProcessed(false);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			// end MZ
			else if (cd.isProcessed())
				return true;	//	nothing to do
		}
		boolean ok = cd.save();
		if (ok && !cd.isProcessed())
		{
			ok = cd.process();
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("(" + ok + ") " + cd);
		return ok;
	}	//	createInventory
	
	/**
	 * 	Create New Order Cost Detail for Movements.
	 * 	Called from Doc_Movement
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param M_MovementLine_ID movement
	 *	@param M_CostElement_ID optional cost element for Freight
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param from if true the from (reduction)
	 *	@param Description optional description
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createMovement (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_MovementLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty, boolean from,
		String Description, String trxName)
	{
		StringBuilder msget = new StringBuilder( "M_MovementLine_ID=? AND IsSOTrx=") 
				.append((from ? "'Y'" : "'N'")).append(" AND Coalesce(M_CostElement_ID,0)=").append(M_CostElement_ID);
		MCostDetail cd = get (as.getCtx(),msget.toString(), 
			M_MovementLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, trxName);
			cd.setM_MovementLine_ID (M_MovementLine_ID);
			cd.setIsSOTrx(from);
		}
		else
		{
			if (cd.isProcessed())
			{
				// MZ Goodwill
				// set deltaAmt=Amt, deltaQty=qty, and set Cost Detail for Amt and Qty	
				cd.setDeltaAmt(Amt.subtract(cd.getAmt()));
				cd.setDeltaQty(Qty.subtract(cd.getQty()));
			}
			else
			{
				cd.setDeltaAmt(BigDecimal.ZERO);
				cd.setDeltaQty(BigDecimal.ZERO);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			if (cd.isDelta())
			{
				cd.setProcessed(false);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			// end MZ
			else if (cd.isProcessed())
				return true;	//	nothing to do
		}
		boolean ok = cd.save();
		if (ok && !cd.isProcessed())
		{
			ok = cd.process();
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("(" + ok + ") " + cd);
		return ok;
	}	//	createMovement

	/**
	 * 	Create New Order Cost Detail for Production.
	 * 	Called from Doc_Production
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param M_ProductionLine_ID production line
	 *	@param M_CostElement_ID optional cost element
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createProduction (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_ProductionLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		MCostDetail cd = get (as.getCtx(), "M_ProductionLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
			M_ProductionLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, trxName);
			cd.setM_ProductionLine_ID(M_ProductionLine_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
				// MZ Goodwill
				// set deltaAmt=Amt, deltaQty=qty, and set Cost Detail for Amt and Qty	 
				cd.setDeltaAmt(Amt.subtract(cd.getAmt()));
				cd.setDeltaQty(Qty.subtract(cd.getQty()));
			}
			else
			{
				cd.setDeltaAmt(BigDecimal.ZERO);
				cd.setDeltaQty(BigDecimal.ZERO);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			if (cd.isDelta())
			{
				cd.setProcessed(false);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			// end MZ
			else if (cd.isProcessed())
				return true;	//	nothing to do
		}
		boolean ok = cd.save();
		if (ok && !cd.isProcessed())
		{
			ok = cd.process();
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("(" + ok + ") " + cd);
		return ok;
	}	//	createProduction
	
	/**
	 * @param as
	 * @param AD_Org_ID
	 * @param M_Product_ID
	 * @param M_AttributeSetInstance_ID
	 * @param M_MatchInv_ID
	 * @param M_CostElement_ID
	 * @param Amt
	 * @param Qty
	 * @param Description
	 * @param trxName
	 * @return true if no error
	 */
	public static boolean createMatchInvoice (MAcctSchema as, int AD_Org_ID, 
			int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_MatchInv_ID, int M_CostElement_ID, 
			BigDecimal Amt, BigDecimal Qty,
			String Description, String trxName)
	{
		MCostDetail cd = get (as.getCtx(), "M_MatchInv_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
				M_MatchInv_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, trxName);
			cd.setM_MatchInv_ID(M_MatchInv_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
				cd.setDeltaAmt(Amt.subtract(cd.getAmt()));
				cd.setDeltaQty(Qty.subtract(cd.getQty()));
			}
			else
			{
				cd.setDeltaAmt(BigDecimal.ZERO);
				cd.setDeltaQty(BigDecimal.ZERO);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			if (cd.isDelta())
			{
				cd.setProcessed(false);
				cd.setAmt(Amt);
				cd.setQty(Qty);
			}
			else if (cd.isProcessed())
				return true;	//	nothing to do
		}
		boolean ok = cd.save();
		if (ok && !cd.isProcessed())
		{
			ok = cd.process();
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("(" + ok + ") " + cd);
		return ok;
	}	//	createMatchInvoice
	
	/**************************************************************************
	 * 	Get Cost Detail
	 *	@param ctx context
	 *	@param whereClause where clause
	 *	@param ID 1st parameter
	 *  @param M_AttributeSetInstance_ID ASI
	 *	@param trxName trx
	 *	@return cost detail
	 *  @deprecated
	 */
	public static MCostDetail get (Properties ctx, String whereClause,
		int ID, int M_AttributeSetInstance_ID, String trxName)
	{
		StringBuilder sql = new StringBuilder("SELECT * FROM M_CostDetail WHERE ").append(whereClause);

		MClientInfo clientInfo = MClientInfo.get(ctx);
		MAcctSchema primary = clientInfo.getMAcctSchema1();
		int C_AcctSchema_ID = primary != null ? primary.getC_AcctSchema_ID() : 0;
		if (C_AcctSchema_ID > 0)
		{
			sql.append(" AND C_AcctSchema_ID=?");
		}
		MCostDetail retValue = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), null);
			pstmt.setInt (1, ID);
			pstmt.setInt (2, M_AttributeSetInstance_ID);
			if (C_AcctSchema_ID > 0)
			{
				pstmt.setInt (3, C_AcctSchema_ID);
			}
			rs = pstmt.executeQuery ();
			if (rs.next ())
				retValue = new MCostDetail (ctx, rs, trxName);
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql + " - " + ID, e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		return retValue;
	}
	
	/**************************************************************************
	 * 	Get Cost Detail
	 *	@param ctx context
	 *	@param whereClause where clause
	 *	@param ID 1st parameter
	 *  @param M_AttributeSetInstance_ID ASI
	 *	@param trxName trx
	 *	@return cost detail
	 */
	public static MCostDetail get (Properties ctx, String whereClause, 
		int ID, int M_AttributeSetInstance_ID, int C_AcctSchema_ID, String trxName)
	{
		StringBuilder localWhereClause = new StringBuilder(whereClause)
			.append(" AND M_AttributeSetInstance_ID=?")
			.append(" AND C_AcctSchema_ID=?");
		MCostDetail retValue = new Query(ctx,I_M_CostDetail.Table_Name,localWhereClause.toString(),trxName)
		.setParameters(ID,M_AttributeSetInstance_ID,C_AcctSchema_ID)
		.first();
		return retValue;
	}	//	get
	
	/**
	 * 	Process Cost Details for product
	 *	@param product product
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean processProduct (MProduct product, String trxName)
	{
		final String whereClause = I_M_CostDetail.COLUMNNAME_M_Product_ID+"=?"
			+ " AND "+I_M_CostDetail.COLUMNNAME_Processed+"=?";
		int counterOK = 0;
		int counterError = 0;
		List<MCostDetail> list = new Query(product.getCtx(),I_M_CostDetail.Table_Name,whereClause,trxName)
		.setParameters(product.getM_Product_ID(),false)
		.setOrderBy("C_AcctSchema_ID, M_CostElement_ID, AD_Org_ID, M_AttributeSetInstance_ID, Created")
		.list();
		for (MCostDetail cd : list) {
			if (cd.process())	//	saves
				counterOK++;
			else
				counterError++;
		}
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("OK=" + counterOK + ", Errors=" + counterError);
		return counterError == 0;
	}	//	processProduct
	
	/**	Logger	*/
	private static CLogger 	s_log = CLogger.getCLogger (MCostDetail.class);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_CostDetail_ID id
	 *	@param trxName trx
	 */
	public MCostDetail (Properties ctx, int M_CostDetail_ID, String trxName)
	{
		super (ctx, M_CostDetail_ID, trxName);
		if (M_CostDetail_ID == 0)
		{
		//	setC_AcctSchema_ID (0);
		//	setM_Product_ID (0);
			setM_AttributeSetInstance_ID (0);
		//	setC_OrderLine_ID (0);
		//	setM_InOutLine_ID(0);
		//	setC_InvoiceLine_ID (0);
			setProcessed (false);
			setAmt (Env.ZERO);
			setQty (Env.ZERO);
			setIsSOTrx (false);
			setDeltaAmt (Env.ZERO);
			setDeltaQty (Env.ZERO);
		}	
	}	//	MCostDetail

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MCostDetail (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MCostDetail

	/**
	 * 	New Constructor
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param M_CostElement_ID optional cost element for Freight
	 *	@param Amt amt
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param trxName transaction
	 */
	public MCostDetail (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_CostElement_ID, BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		this (as.getCtx(), 0, trxName);
		setClientOrg(as.getAD_Client_ID(), AD_Org_ID);
		setC_AcctSchema_ID (as.getC_AcctSchema_ID());
		setM_Product_ID (M_Product_ID);
		setM_AttributeSetInstance_ID (M_AttributeSetInstance_ID);
		//
		setM_CostElement_ID(M_CostElement_ID);
		//
		setAmt (Amt);
		setQty (Qty);
		setDescription(Description);
	}	//	MCostDetail
	
	/**
	 * 	Set Amt
	 *	@param Amt amt
	 */
	public void setAmt (BigDecimal Amt)
	{
		if (isProcessed())
			throw new IllegalStateException("Cannot change Amt - processed");
		if (Amt == null)
			super.setAmt (Env.ZERO);
		else
			super.setAmt (Amt);
	}	//	setAmt
	
	/**
	 * 	Set Qty
	 *	@param Qty qty
	 */
	public void setQty (BigDecimal Qty)
	{
		if (isProcessed())
			throw new IllegalStateException("Cannot change Qty - processed");
		if (Qty == null)
			super.setQty (Env.ZERO);
		else
			super.setQty (Qty);
	}	//	setQty

	/**
	 * 	Is Order
	 *	@return true if order line
	 */
	public boolean isOrder()
	{
		return getC_OrderLine_ID() != 0;
	}	//	isOrder

	/**
	 * 	Is Invoice
	 *	@return true if invoice line
	 */
	public boolean isInvoice()
	{
		return getC_InvoiceLine_ID() != 0;
	}	//	isInvoice

	/**
	 * 	Is Shipment
	 *	@return true if sales order shipment
	 */
	public boolean isShipment()
	{
		return isSOTrx() && getM_InOutLine_ID() != 0;
	}	//	isShipment
	
	/**
	 * @return true if return to vendor
	 */
	public boolean isVendorRMA()
	{
		if (!isSOTrx() && getM_InOutLine_ID() > 0)
		{
			String docBaseType = DB.getSQLValueString((String)null, 
					INOUTLINE_DOCBASETYPE_SQL, getM_InOutLine_ID());
			return Doc.DOCTYPE_MatShipment.equals(docBaseType);
		}
		return false;
	}
	
	/**
	 * 	Is this a Delta Record (previously processed)?
	 *	@return true if delta is not null
	 */
	public boolean isDelta()
	{
		return !(getDeltaAmt().signum() == 0 
			&& getDeltaQty().signum() == 0);
	}	//	isDelta

	/**
	 * 	Before Delete
	 *	@return false if processed
	 */
	protected boolean beforeDelete ()
	{
		return !isProcessed();
	}	//	beforeDelete
	
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MCostDetail[");
		sb.append (get_ID());
		if (getC_OrderLine_ID() != 0)
			sb.append (",C_OrderLine_ID=").append (getC_OrderLine_ID());
		if (getM_InOutLine_ID() != 0)
			sb.append (",M_InOutLine_ID=").append (getM_InOutLine_ID());
		if (getC_InvoiceLine_ID() != 0)
			sb.append (",C_InvoiceLine_ID=").append (getC_InvoiceLine_ID());
		if (getC_ProjectIssue_ID() != 0)
			sb.append (",C_ProjectIssue_ID=").append (getC_ProjectIssue_ID());
		if (getM_MovementLine_ID() != 0)
			sb.append (",M_MovementLine_ID=").append (getM_MovementLine_ID());
		if (getM_InventoryLine_ID() != 0)
			sb.append (",M_InventoryLine_ID=").append (getM_InventoryLine_ID());
		if (getM_ProductionLine_ID() != 0)
			sb.append (",M_ProductionLine_ID=").append (getM_ProductionLine_ID());
		sb.append(",Amt=").append(getAmt())
			.append(",Qty=").append(getQty());
		if (isDelta())
			sb.append(",DeltaAmt=").append(getDeltaAmt())
				.append(",DeltaQty=").append(getDeltaQty());
		sb.append ("]");
		return sb.toString ();
	}	//	toString
	
	
	/**************************************************************************
	 * 	Process Cost Detail Record.
	 * 	The record is saved if processed.
	 *	@return true if processed
	 */
	public synchronized boolean process()
	{
		if (isProcessed())
		{
			log.info("Already processed");
			return true;
		}
		boolean ok = false;

		//	get costing level for product
		MAcctSchema as = MAcctSchema.get(getCtx(), getC_AcctSchema_ID());
		MProduct product = MProduct.get(getCtx(), getM_Product_ID());
		String CostingLevel = product.getCostingLevel(as);
		//	Org Element
		int Org_ID = getAD_Org_ID();
		int M_ASI_ID = getM_AttributeSetInstance_ID();
		if (MAcctSchema.COSTINGLEVEL_Client.equals(CostingLevel))
		{
			Org_ID = 0;
			M_ASI_ID = 0;
		}
		else if (MAcctSchema.COSTINGLEVEL_Organization.equals(CostingLevel))
			M_ASI_ID = 0;
		else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel))
			Org_ID = 0;

		//	Create Material Cost elements
		if (getM_CostElement_ID() == 0)
		{
			MCostElement[] ces = MCostElement.getCostingMethods(this);
			for (int i = 0; i < ces.length; i++)
			{
				MCostElement ce = ces[i];
				if (ce.isAverageInvoice() || ce.isAveragePO() || ce.isLifo() || ce.isFifo())
				{
					if (!product.isStocked())
						continue;
				}
				ok = process (as, product, ce, Org_ID, M_ASI_ID);
				if (!ok)
					break;
			}
		}	//	Material Cost elements
		else
		{
			MCostElement ce = MCostElement.get(getCtx(), getM_CostElement_ID());
			if (ce.getCostingMethod() == null) 
			{
				MCostElement[] ces = MCostElement.getCostingMethods(this);
				for (MCostElement costingElement : ces)
				{
					if (costingElement.isAverageInvoice() || costingElement.isAveragePO() || costingElement.isLifo() || costingElement.isFifo())
					{
						if (!product.isStocked())
							continue;
					}					
					ok = process (as, product, costingElement, Org_ID, M_ASI_ID);
					if (!ok)
						break;
				}
			}
			else
			{
				if (ce.isAverageInvoice() || ce.isAveragePO() || ce.isLifo() || ce.isFifo())
				{
					if (product.isStocked())
						ok = process (as, product, ce, Org_ID, M_ASI_ID);
				}
				else
				{
					ok = process (as, product, ce, Org_ID, M_ASI_ID);
				}
			}
		}
		
		//	Save it
		if (ok)
		{
			setDeltaAmt(null);
			setDeltaQty(null);
			setProcessed(true);
			ok = save();
		}
		if (log.isLoggable(Level.INFO)) log.info(ok + " - " + toString());
		return ok;
	}	//	process
	
	/**
	 * 	Process cost detail for cost record
	 *	@param as accounting schema
	 *	@param product product
	 *	@param ce cost element
	 *	@param Org_ID org - corrected for costing level
	 *	@param M_ASI_ID - asi corrected for costing level
	 *	@return true if cost ok
	 */
	private boolean process (MAcctSchema as, MProduct product, MCostElement ce, 
		int Org_ID, int M_ASI_ID)
	{
		MCost cost = MCost.get(product, M_ASI_ID, as, 
			Org_ID, ce.getM_CostElement_ID(), get_TrxName());
		
		DB.getDatabase().forUpdate(cost, 120);
		
	//	if (cost == null)
	//		cost = new MCost(product, M_ASI_ID, 
	//			as, Org_ID, ce.getM_CostElement_ID());
		
		//save history for m_cost
		X_M_CostHistory history = new X_M_CostHistory(getCtx(), 0, get_TrxName());
		history.setM_AttributeSetInstance_ID(cost.getM_AttributeSetInstance_ID());
		history.setM_CostDetail_ID(this.getM_CostDetail_ID());
		history.setM_CostElement_ID(ce.getM_CostElement_ID());
		history.setM_CostType_ID(cost.getM_CostType_ID());
		history.setClientOrg(cost.getAD_Client_ID(), cost.getAD_Org_ID());
		history.setOldQty(cost.getCurrentQty());
		history.setOldCostPrice(cost.getCurrentCostPrice());
		history.setOldCAmt(cost.getCumulatedAmt());
		history.setOldCQty(cost.getCumulatedQty());
		
		// MZ Goodwill
		// used deltaQty and deltaAmt if exist 
		BigDecimal qty = Env.ZERO;
		BigDecimal amt = Env.ZERO;
		if (isDelta())
		{
			qty = getDeltaQty();
			amt = getDeltaAmt();
		}
		else
		{
			qty = getQty();
			amt = getAmt();
		}
		// end MZ

		//determine whether this is cost only adjustment entry
		boolean costAdjustment = false;
		if (this.getM_CostElement_ID() > 0 && this.getM_CostElement_ID() != ce.getM_CostElement_ID())
		{
			MCostElement thisCostElement = MCostElement.get(getCtx(), getM_CostElement_ID());
			if (thisCostElement.getCostingMethod() == null && ce.getCostingMethod() != null)
			{
				qty = BigDecimal.ZERO;
				costAdjustment = true;
			}
		}
		
		int precision = as.getCostingPrecision();
		BigDecimal price = amt;
		if (qty.signum() != 0)
			price = amt.divide(qty, precision, BigDecimal.ROUND_HALF_UP);
		
		/** All Costing Methods
		if (ce.isAverageInvoice())
		else if (ce.isAveragePO())
		else if (ce.isFifo())
		else if (ce.isLifo())
		else if (ce.isLastInvoice())
		else if (ce.isLastPOPrice())
		else if (ce.isStandardCosting())
		else if (ce.isUserDefined())
		else if (!ce.isCostingMethod())
		**/
		
		//	*** Purchase Order Detail Record ***
		if (getC_OrderLine_ID() != 0)
		{		
			boolean isReturnTrx = qty.signum() < 0;
			
			if (ce.isAveragePO())
			{
				cost.setWeightedAverage(amt, qty);
				if (log.isLoggable(Level.FINER)) log.finer("PO - AveragePO - " + cost);
			}
			else if (ce.isLastPOPrice() && !costAdjustment)
			{
				if(!isReturnTrx)
				{
					if (qty.signum() != 0)
						cost.setCurrentCostPrice(price);
					else
					{
						BigDecimal cCosts = cost.getCurrentCostPrice().add(amt);
						cost.setCurrentCostPrice(cCosts);
					}
				}
				cost.add(amt, qty);
				if (log.isLoggable(Level.FINER)) log.finer("PO - LastPO - " + cost);
			}
			else if (ce.isStandardCosting() && !costAdjustment)
			{								
				// Update cost record only if it is zero
				if (cost.getCurrentCostPrice().signum() == 0
						&& cost.getCurrentCostPriceLL().signum() == 0)
				{
					cost.setCurrentCostPrice(price);
					if (cost.getCurrentCostPrice().signum() == 0)
					{
						cost.setCurrentCostPrice(MCost.getSeedCosts(product, M_ASI_ID, 
								as, Org_ID, ce.getCostingMethod(), getC_OrderLine_ID()));
					}
					if (log.isLoggable(Level.FINEST)) log.finest("PO - Standard - CurrentCostPrice(seed)="+cost.getCurrentCostPrice()+", price="+price);
				}
				cost.add(amt, qty);
				if (log.isLoggable(Level.FINER)) log.finer("PO - Standard - " + cost);
			}
			else if (ce.isUserDefined())
			{
				//	Interface
				if (log.isLoggable(Level.FINER)) log.finer("PO - UserDef - " + cost);
			}
			else if (!ce.isCostingMethod())
			{
				if (log.isLoggable(Level.FINER)) log.finer("PO - " + ce + " - " + cost);
			}
		//	else
		//		log.warning("PO - " + ce + " - " + cost);
		}
		
		//	*** AP Invoice Detail Record ***
		else if (getC_InvoiceLine_ID() != 0)
		{
			boolean isReturnTrx = qty.signum() < 0;
			
			if (ce.isAverageInvoice())
			{
				cost.setWeightedAverage(amt, qty);
				if (log.isLoggable(Level.FINER)) log.finer("Inv - AverageInv - " + cost);
			}
			else if (ce.isAveragePO() && costAdjustment)
			{
				cost.setWeightedAverage(amt, qty);
			}
			else if (ce.isFifo()
				|| ce.isLifo())
			{
				//	Real ASI - costing level Org
				MCostQueue cq = MCostQueue.get(product, getM_AttributeSetInstance_ID(), 
					as, Org_ID, ce.getM_CostElement_ID(), get_TrxName());
				cq.setCosts(amt, qty, precision);
				cq.saveEx();
				//	Get Costs - costing level Org/ASI
				MCostQueue[] cQueue = MCostQueue.getQueue(product, M_ASI_ID, 
					as, Org_ID, ce, get_TrxName());
				if (cQueue != null && cQueue.length > 0)
					cost.setCurrentCostPrice(cQueue[0].getCurrentCostPrice());
				cost.add(amt, qty);
				if (log.isLoggable(Level.FINER)) log.finer("Inv - FiFo/LiFo - " + cost);
			}
			else if (ce.isLastInvoice() && !costAdjustment)
			{
				if (!isReturnTrx)
				{
					if (qty.signum() != 0)
						cost.setCurrentCostPrice(price);
					else
					{
						BigDecimal cCosts = cost.getCurrentCostPrice().add(amt);
						cost.setCurrentCostPrice(cCosts);
					}
				}
				cost.add(amt, qty);
				if (log.isLoggable(Level.FINER)) log.finer("Inv - LastInv - " + cost);
			}
			else if (ce.isStandardCosting() && !costAdjustment)
			{
				// Update cost record only if it is zero
				if (cost.getCurrentCostPrice().signum() == 0
						&& cost.getCurrentCostPriceLL().signum() == 0)
				{
					cost.setCurrentCostPrice(price);
					//	seed initial price
					if (cost.getCurrentCostPrice().signum() == 0)
					{
						cost.setCurrentCostPrice(MCost.getSeedCosts(product, M_ASI_ID, 
								as, Org_ID, ce.getCostingMethod(), getC_OrderLine_ID()));
						if (log.isLoggable(Level.FINEST)) log.finest("Inv - Standard - CurrentCostPrice(seed)="+cost.getCurrentCostPrice()+", price="+price);
					}
					cost.add(amt, qty);
				}				
				if (log.isLoggable(Level.FINER)) log.finer("Inv - Standard - " + cost);
			}
			else if (ce.isUserDefined())
			{
				//	Interface
				cost.add(amt, qty);
				if (log.isLoggable(Level.FINER)) log.finer("Inv - UserDef - " + cost);
			}			
		//	else
		//		log.warning("Inv - " + ce + " - " + cost);
		}
		else if (getM_InOutLine_ID() != 0 && costAdjustment)
		{
			if (ce.isAverageInvoice())
			{
				cost.setWeightedAverage(amt, qty);
			}
		}
		//	*** Qty Adjustment Detail Record ***
		else if (getM_InOutLine_ID() != 0 		//	AR Shipment Detail Record  
			|| getM_MovementLine_ID() != 0 
			|| getM_InventoryLine_ID() != 0
			|| getM_ProductionLine_ID() != 0
			|| getC_ProjectIssue_ID() != 0
			|| getPP_Cost_Collector_ID() != 0)
		{
			boolean addition = qty.signum() > 0;
			boolean adjustment = getM_InventoryLine_ID() > 0 && qty.signum() == 0 && amt.signum() != 0;
			boolean isVendorRMA = isVendorRMA();
			//
			if (ce.isAverageInvoice())
			{
				if (!isVendorRMA)
				{
					if (adjustment)
					{
						String costingMethod = getM_InventoryLine().getM_Inventory().getCostingMethod();
						if (MCostElement.COSTINGMETHOD_AverageInvoice.equals(costingMethod))
						{
							cost.setWeightedAverage(amt.multiply(cost.getCurrentQty()), qty);
						}
					}
					else if (addition)
					{
						cost.setWeightedAverage(amt, qty);
						//shouldn't accumulate reversal of customer shipment qty and amt
						if (isShipment())
						{
							cost.setCumulatedQty(history.getOldCQty());
							cost.setCumulatedAmt(history.getOldCAmt());
						}
					}
					else
						cost.setCurrentQty(cost.getCurrentQty().add(qty));
					if (log.isLoggable(Level.FINER)) log.finer("QtyAdjust - AverageInv - " + cost);
				}
			}
			else if (ce.isAveragePO())
			{
				if (adjustment)
				{
					String costingMethod = getM_InventoryLine().getM_Inventory().getCostingMethod();
					if (MCostElement.COSTINGMETHOD_AveragePO.equals(costingMethod))
					{
						cost.setWeightedAverage(amt.multiply(cost.getCurrentQty()), qty);
					}
				}
				else if (addition)
				{					
					cost.setWeightedAverage(amt, qty);
					//shouldn't accumulate reversal of customer shipment qty and amt
					if (isShipment() && !isVendorRMA())
					{
						cost.setCumulatedQty(history.getOldCQty());
						cost.setCumulatedAmt(history.getOldCAmt());
					}
				}
				else
				{
					if (isVendorRMA)
					{
						cost.setWeightedAverage(amt, qty);
					}
					else
					{
						cost.setCurrentQty(cost.getCurrentQty().add(qty));
					}
				}
				if (log.isLoggable(Level.FINER)) log.finer("QtyAdjust - AveragePO - " + cost);
			}
			else if (ce.isFifo() || ce.isLifo())
			{
				if (!isVendorRMA && !adjustment)
				{
					if (addition)
					{
						//	Real ASI - costing level Org
						MCostQueue cq = MCostQueue.get(product, getM_AttributeSetInstance_ID(), 
							as, Org_ID, ce.getM_CostElement_ID(), get_TrxName());
						cq.setCosts(amt, qty, precision);
						cq.saveEx();
					}
					else
					{
						//	Adjust Queue - costing level Org/ASI
						MCostQueue.adjustQty(product, M_ASI_ID, 
							as, Org_ID, ce, qty.negate(), get_TrxName());
					}
					//	Get Costs - costing level Org/ASI
					MCostQueue[] cQueue = MCostQueue.getQueue(product, M_ASI_ID, 
						as, Org_ID, ce, get_TrxName());
					if (cQueue != null && cQueue.length > 0)
						cost.setCurrentCostPrice(cQueue[0].getCurrentCostPrice());
					cost.setCurrentQty(cost.getCurrentQty().add(qty));
					if (log.isLoggable(Level.FINER)) log.finer("QtyAdjust - FiFo/Lifo - " + cost);
				}
			}
			else if (ce.isLastInvoice() && !isVendorRMA && !adjustment)
			{
				cost.setCurrentQty(cost.getCurrentQty().add(qty));
				if (log.isLoggable(Level.FINER)) log.finer("QtyAdjust - LastInv - " + cost);
			}
			else if (ce.isLastPOPrice() && !isVendorRMA && !adjustment)
			{
				cost.setCurrentQty(cost.getCurrentQty().add(qty));
				if (log.isLoggable(Level.FINER)) log.finer("QtyAdjust - LastPO - " + cost);
			}
			else if (ce.isStandardCosting() && !isVendorRMA)
			{
				if (adjustment)
				{
					String costingMethod = getM_InventoryLine().getM_Inventory().getCostingMethod();
					if (MCostElement.COSTINGMETHOD_StandardCosting.equals(costingMethod))
					{
						cost.add(amt.multiply(cost.getCurrentQty()), qty);					
						cost.setCurrentCostPrice(cost.getCurrentCostPrice().add(amt));
					}
				}
				else if (addition)
				{
					cost.add(amt, qty);
					//	Initial
					if (cost.getCurrentCostPrice().signum() == 0
						&& cost.getCurrentCostPriceLL().signum() == 0
						&& cost.is_new())
					{
						cost.setCurrentCostPrice(price);
						if (log.isLoggable(Level.FINEST)) log.finest("QtyAdjust - Standard - CurrentCostPrice="+price);
					}
				}
				else
				{
					cost.setCurrentQty(cost.getCurrentQty().add(qty));
				}
				if (log.isLoggable(Level.FINER)) log.finer("QtyAdjust - Standard - " + cost);
			}
			else if (ce.isUserDefined() && !isVendorRMA && !adjustment)
			{
				//	Interface
				if (addition)
					cost.add(amt, qty);
				else
					cost.setCurrentQty(cost.getCurrentQty().add(qty));
				if (log.isLoggable(Level.FINER)) log.finer("QtyAdjust - UserDef - " + cost);
			}
			else if (!ce.isCostingMethod())
			{
				//Should not happen
				if (log.isLoggable(Level.FINER)) log.finer("QtyAdjust - ?none? - " + cost);
			}
			else
				log.warning("QtyAdjust - " + ce + " - " + cost);
			
		}
		else if (getM_MatchInv_ID() > 0)
		{
			if (ce.isAveragePO())
			{
				cost.setWeightedAverage(amt, qty);
			}			
		}
		else	//	unknown or no id
		{
			log.warning("Unknown Type: " + toString());
			return false;
		}
		setCurrentCostPrice(cost.getCurrentCostPrice());
		setCurrentQty(cost.getCurrentQty());
		setCumulatedAmt(cost.getCumulatedAmt());
		setCumulatedQty(cost.getCumulatedQty());
		
		//update history
		history.setNewQty(cost.getCurrentQty());
		history.setNewCostPrice(cost.getCurrentCostPrice());
		history.setNewCAmt(cost.getCumulatedAmt());
		history.setNewCQty(cost.getCumulatedQty());
		if (!history.save())
			return false;
		
		return cost.save();
	}	//	process
	
	// Elaine 2008/6/20	
	protected boolean afterDelete (boolean success)
	{
		if(success)
		{
			// recalculate MCost			
			boolean ok = false;
			//	get costing level for product
			MAcctSchema as = new MAcctSchema (getCtx(), getC_AcctSchema_ID(), null);
			MProduct product = MProduct.get(getCtx(), getM_Product_ID());
			String CostingLevel = product.getCostingLevel(as);
			//	Org Element
			int Org_ID = getAD_Org_ID();
			int M_ASI_ID = getM_AttributeSetInstance_ID();
			if (MAcctSchema.COSTINGLEVEL_Client.equals(CostingLevel))
			{
				Org_ID = 0;
				M_ASI_ID = 0;
			}
			else if (MAcctSchema.COSTINGLEVEL_Organization.equals(CostingLevel))
				M_ASI_ID = 0;
			else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel))
				Org_ID = 0;

			//	Create Material Cost elements
			if (getM_CostElement_ID() == 0)
			{
				MCostElement[] ces = MCostElement.getCostingMethods(this);
				for (int i = 0; i < ces.length; i++)
				{
					MCostElement ce = ces[i];
					ok = process (as, product, ce, Org_ID, M_ASI_ID);
					if (!ok)
						break;
				}
			}	//	Material Cost elements
			else
			{
				MCostElement ce = MCostElement.get(getCtx(), getM_CostElement_ID());
				ok = process (as, product, ce, Org_ID, M_ASI_ID);
			}
			
			return ok;
		}
		
		return super.afterDelete(success);
	}
	//
	
}	//	MCostDetail
