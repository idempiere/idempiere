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
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.adempiere.exceptions.PeriodClosedException;
import org.compiere.acct.Doc;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;

/**
 * 	Cost Detail Model
 *	
 *  @author Jorg Janke
 *  @author Armen Rizal, Goodwill Consulting
 *  	<li>BF: 2431123 Return Trx changes weighted average cost
 *  	<li>BF: 1568752 Average invoice costing: landed costs incorrectly applied
 *  @author Armen Rizal and Bayu Cahya
 *  	<li>BF [ 2129781 ] Cost Detail not created properly for multi acc schema
 *  @author Teo Sarca
 *  	<li>BF [ 2847648 ] Manufacture and shipment cost errors
 *  		https://sourceforge.net/p/adempiere/libero/237/
 * 	@author red1 FR: [ 2214883 ] Remove SQL code and Replace for Query
 *  @version $Id: MCostDetail.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 *  
 */
public class MCostDetail extends X_M_CostDetail
{	
	private static final long serialVersionUID = -7909571771846993407L;
	
	protected static final String INOUTLINE_DOCBASETYPE_SQL =
		    "SELECT c.DocBaseType From M_InOut io " +
			"INNER JOIN M_InOutLine iol ON io.M_InOut_ID=iol.M_InOut_ID " +
			"INNER JOIN C_DocType c ON io.C_DocType_ID=c.C_DocType_ID " +
			"WHERE iol.M_InOutLine_ID=?";
			
	/**
	 * 	Create New Cost Detail record for Purchase Orders.
	 * 	Called from Doc_MatchPO.
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
	 *	@deprecated
	 */
	@Deprecated
	public static boolean createOrder (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int C_OrderLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		return createOrder (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, C_OrderLine_ID, M_CostElement_ID, 
				Amt, Qty, Description, null, 0, trxName);
	}
	
	/**
	 * 	Create New Cost Detail record for Purchase Orders.
	 * 	Called from Doc_MatchPO.
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param C_OrderLine_ID order
	 *	@param M_CostElement_ID optional cost element for Freight
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param DateAcct account date
	 *	@param Ref_CostDetail_ID reference cost detail
	 *	@param trxName transaction
	 *	@return true if created
	 */
	public static boolean createOrder (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int C_OrderLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, Timestamp DateAcct, int Ref_CostDetail_ID, String trxName)
	{
		MCostDetail cd = getOrder (as, M_Product_ID, M_AttributeSetInstance_ID, C_OrderLine_ID, M_CostElement_ID, DateAcct, trxName);
		if (cd != null && !cd.isDelta() && Ref_CostDetail_ID > 0)
			cd.setIsBackDate(true);
		//
		if (cd == null)		//	createNew 
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, DateAcct, Ref_CostDetail_ID, trxName);
			cd.setC_OrderLine_ID (C_OrderLine_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
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
	 * 	Create New Cost Detail record for AP Invoices.
	 * 	Called from Doc_Invoice - for Invoice Adjustments.
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
	 *	@deprecated
	 */
	@Deprecated
	public static boolean createInvoice (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int C_InvoiceLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		return createInvoice (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, C_InvoiceLine_ID, M_CostElement_ID, 
				Amt, Qty, Description, null, 0, trxName);
	}
	
	/**
	 * 	Create New Cost Detail record for AP Invoices.
	 * 	Called from Doc_Invoice - for Invoice Adjustments.
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param C_InvoiceLine_ID invoice
	 *	@param M_CostElement_ID optional cost element for Freight
	 *	@param Amt amt
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param DateAcct account date
	 *	@param Ref_CostDetail_ID reference cost detail
	 *	@param trxName transaction
	 *	@return true if created
	 */
	public static boolean createInvoice (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int C_InvoiceLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, Timestamp DateAcct, int Ref_CostDetail_ID, String trxName)
	{
		MCostDetail cd = getInvoice (as, M_Product_ID, M_AttributeSetInstance_ID, C_InvoiceLine_ID, M_CostElement_ID, DateAcct, trxName);
		if (cd != null && !cd.isDelta() && Ref_CostDetail_ID > 0)
			cd.setIsBackDate(true);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, DateAcct, Ref_CostDetail_ID, trxName);
			cd.setC_InvoiceLine_ID (C_InvoiceLine_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
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
	 * 	Create New Cost Detail record for SO Shipments.
	 * 	Called from Doc_MInOut - for SO Shipments.  
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
	 *	@deprecated
	 */
	@Deprecated
	public static boolean createShipment (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_InOutLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, boolean IsSOTrx, String trxName)
	{
		return createShipment (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, M_InOutLine_ID, M_CostElement_ID, 
				Amt, Qty, Description, IsSOTrx, null, 0, trxName);
	}
	
	/**
	 * 	Create New Cost Detail record for SO Shipments.
	 * 	Called from Doc_MInOut - for SO Shipments.  
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
	 *	@param DateAcct account date
	 *	@param Ref_CostDetail_ID reference cost detail
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createShipment (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_InOutLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, boolean IsSOTrx, Timestamp DateAcct, int Ref_CostDetail_ID, String trxName)
	{
		MCostDetail cd = getShipment (as, M_Product_ID, M_AttributeSetInstance_ID, M_InOutLine_ID, M_CostElement_ID, trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, DateAcct, Ref_CostDetail_ID, trxName);
			cd.setM_InOutLine_ID(M_InOutLine_ID);
			cd.setIsSOTrx(IsSOTrx);
		}
		else
		{
			if (cd.isProcessed())
			{
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
	 * 	Create New Cost Detail record for Physical Inventory.
	 * 	Called from Doc_Inventory.
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
	 *	@deprecated
	 */
	@Deprecated
	public static boolean createInventory (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_InventoryLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		return createInventory (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, M_InventoryLine_ID, M_CostElement_ID, 
				Amt, Qty, Description, null, 0, trxName);
	}
	
	/**
	 * 	Create New Cost Detail record for Physical Inventory.
	 * 	Called from Doc_Inventory.
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param M_InventoryLine_ID order
	 *	@param M_CostElement_ID optional cost element
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param DateAcct account date
	 *	@param Ref_CostDetail_ID reference cost detail
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createInventory (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_InventoryLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, Timestamp DateAcct, int Ref_CostDetail_ID, String trxName)
	{
		MCostDetail cd = getInventory (as, M_Product_ID, M_AttributeSetInstance_ID, M_InventoryLine_ID, M_CostElement_ID, trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, DateAcct, Ref_CostDetail_ID, trxName);
			cd.setM_InventoryLine_ID(M_InventoryLine_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
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
	 * 	Create New Cost Detail record for Inventory Movements.
	 * 	Called from Doc_Movement.
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
	 *	@deprecated
	 */
	@Deprecated
	public static boolean createMovement (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_MovementLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty, boolean from,
		String Description, String trxName)
	{
		return createMovement (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, M_MovementLine_ID, M_CostElement_ID, 
				Amt, Qty, from, Description, null, 0, trxName);
	}
	
	/**
	 * 	Create New Cost Detail record for Inventory Movements.
	 * 	Called from Doc_Movement.
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
	 *	@param DateAcct account date
	 *	@param Ref_CostDetail_ID reference cost detail
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createMovement (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_MovementLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty, boolean from,
		String Description, Timestamp DateAcct, int Ref_CostDetail_ID, String trxName)
	{
		MCostDetail cd = getMovement (as, M_Product_ID, M_AttributeSetInstance_ID, M_MovementLine_ID, M_CostElement_ID, from, trxName);

		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, DateAcct, Ref_CostDetail_ID, trxName);
			cd.setM_MovementLine_ID (M_MovementLine_ID);
			cd.setIsSOTrx(from);
		}
		else
		{
			if (cd.isProcessed())
			{
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
	 * 	Create New Cost Detail record for Production.
	 * 	Called from Doc_Production.
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
	 *	@deprecated
	 */
	@Deprecated
	public static boolean createProduction (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_ProductionLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		return createProduction (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, M_ProductionLine_ID, M_CostElement_ID,
				Amt, Qty, Description, null, 0, trxName);
	}
	
	/**
	 * 	Create New Cost Detail record for Production.
	 * 	Called from Doc_Production.
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param M_ProductionLine_ID production line
	 *	@param M_CostElement_ID optional cost element
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param DateAcct account date
	 *	@param Ref_CostDetail_ID reference cost detail
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createProduction (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_ProductionLine_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, Timestamp DateAcct, int Ref_CostDetail_ID, String trxName)
	{
		MCostDetail cd = getProduction (as, M_Product_ID, M_AttributeSetInstance_ID, M_ProductionLine_ID, M_CostElement_ID, trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, DateAcct, Ref_CostDetail_ID, trxName);
			cd.setM_ProductionLine_ID(M_ProductionLine_ID);
		}
		else
		{
			if (cd.isProcessed())
			{
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
	 *	Create cost detail record for Match Invoice (M_MatchInv).
	 *	@param as
	 *	@param AD_Org_ID
	 *	@param M_Product_ID
	 *	@param M_AttributeSetInstance_ID
	 *	@param M_MatchInv_ID
	 *	@param M_CostElement_ID
	 *	@param Amt
	 *	@param Qty
	 *	@param Description
	 *	@param trxName
	 *	@return true if no error
	 *	@deprecated
	 */
	@Deprecated
	public static boolean createMatchInvoice (MAcctSchema as, int AD_Org_ID, 
			int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_MatchInv_ID, int M_CostElement_ID, 
			BigDecimal Amt, BigDecimal Qty,
			String Description, String trxName)
	{
		return createMatchInvoice (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, M_MatchInv_ID, M_CostElement_ID,
				Amt, Qty, Description, null, 0, trxName);
	}
	
	/**
	 *	Create cost detail record for Match Invoice (M_MatchInv).
	 *	@param as
	 *	@param AD_Org_ID
	 *	@param M_Product_ID
	 *	@param M_AttributeSetInstance_ID
	 *	@param M_MatchInv_ID
	 *	@param M_CostElement_ID
	 *	@param Amt
	 *	@param Qty
	 *	@param Description
	 *	@param DateAcct account date
	 *	@param Ref_CostDetail_ID reference cost detail
	 *	@param trxName
	 *	@return true if no error
	 */
	public static boolean createMatchInvoice (MAcctSchema as, int AD_Org_ID, 
			int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_MatchInv_ID, int M_CostElement_ID, 
			BigDecimal Amt, BigDecimal Qty,
			String Description, Timestamp DateAcct, int Ref_CostDetail_ID, String trxName)
	{
		MCostDetail cd = getMatchInvoice (as, M_Product_ID, M_AttributeSetInstance_ID, M_MatchInv_ID, M_CostElement_ID, trxName);

		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, DateAcct, Ref_CostDetail_ID, trxName);
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
	
	/**
	 * 	Create Cost Detail for Project Issue (C_ProjectIssue).
	 * 	Called from Doc_ProjectIssue
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param C_ProjectIssue_ID project issue line
	 *	@param M_CostElement_ID optional cost element
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param trxName transaction
	 *	@return true if no error
	 *	@deprecated
	 */
	@Deprecated
	public static boolean createProjectIssue (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int C_ProjectIssue_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, String trxName)
	{
		return createProjectIssue (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, C_ProjectIssue_ID, M_CostElement_ID,
				Amt, Qty, Description, null, 0, trxName);
	}
	
	/**
	 * 	Create Cost Detail for Project Issue (C_ProjectIssue).
	 * 	Called from Doc_ProjectIssue
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param C_ProjectIssue_ID project issue line
	 *	@param M_CostElement_ID optional cost element
	 *	@param Amt amt total amount
	 *	@param Qty qty
	 *	@param Description optional description
	 *	@param DateAcct account date
	 *	@param Ref_CostDetail_ID reference cost detail
	 *	@param trxName transaction
	 *	@return true if no error
	 */
	public static boolean createProjectIssue (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int C_ProjectIssue_ID, int M_CostElement_ID, 
		BigDecimal Amt, BigDecimal Qty,
		String Description, Timestamp DateAcct, int Ref_CostDetail_ID, String trxName)
	{
		MCostDetail cd = getProjectIssue (as, M_Product_ID, M_AttributeSetInstance_ID, C_ProjectIssue_ID, M_CostElement_ID, trxName);
		//
		if (cd == null)		//	createNew
		{
			cd = new MCostDetail (as, AD_Org_ID, 
				M_Product_ID, M_AttributeSetInstance_ID, 
				M_CostElement_ID, 
				Amt, Qty, Description, DateAcct, Ref_CostDetail_ID, trxName);
			cd.setC_ProjectIssue_ID(C_ProjectIssue_ID);
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
	}	//	createProjectIssue
	
	public static MCostDetail getOrder (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int C_OrderLine_ID, int M_CostElement_ID, Timestamp DateAcct, String trxName) {
		MCostDetail cd = get (as.getCtx(), "C_OrderLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID
				+" AND TRUNC(DateAcct)="+DB.TO_DATE(DateAcct, true), 
			C_OrderLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		if (cd == null) {
			cd = get (as.getCtx(), "C_OrderLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID,
					C_OrderLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
			if (cd != null && !cd.isDelta())
				cd = null;
		}
		return cd;
	}
	
	public static MCostDetail getInvoice (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int C_InvoiceLine_ID, int M_CostElement_ID, Timestamp DateAcct, String trxName) {
		MCostDetail cd = get (as.getCtx(), "C_InvoiceLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID+" AND M_Product_ID="+M_Product_ID
				+" AND TRUNC(DateAcct)="+DB.TO_DATE(DateAcct, true), 
				C_InvoiceLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
		if (cd == null) {
			cd = get (as.getCtx(), "C_InvoiceLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID+" AND M_Product_ID="+M_Product_ID, 
					C_InvoiceLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
			if (cd != null && !cd.isDelta())
				cd = null;
		}
		return cd;
	}
	
	public static MCostDetail getShipment (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_InOutLine_ID, int M_CostElement_ID, String trxName) {
		return get (as.getCtx(), "M_InOutLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
				M_InOutLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
	}
	
	public static MCostDetail getInventory (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_InventoryLine_ID, int M_CostElement_ID, String trxName) {
		return get (as.getCtx(), "M_InventoryLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID+" AND M_Product_ID="+M_Product_ID, 
				M_InventoryLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
	}
	
	public static MCostDetail getMovement (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_MovementLine_ID, int M_CostElement_ID, boolean from, String trxName) {
		StringBuilder msget = new StringBuilder( "M_MovementLine_ID=? AND IsSOTrx=") 
				.append((from ? "'Y'" : "'N'")).append(" AND Coalesce(M_CostElement_ID,0)=").append(M_CostElement_ID);
		return get (as.getCtx(),msget.toString(), 
			M_MovementLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
	}
	
	public static MCostDetail getProduction (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_ProductionLine_ID, String trxName) {
		return get (as.getCtx(), "M_ProductionLine_ID=?", 
				M_ProductionLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
	}
	
	public static MCostDetail getProduction (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_ProductionLine_ID, int M_CostElement_ID, String trxName) {
		return get (as.getCtx(), "M_ProductionLine_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
				M_ProductionLine_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
	}
	
	public static MCostDetail getMatchInvoice (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int M_MatchInv_ID, int M_CostElement_ID, String trxName) {
		return get (as.getCtx(), "M_MatchInv_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
				M_MatchInv_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
	}
	
	public static MCostDetail getProjectIssue (MAcctSchema as, int M_Product_ID, int M_AttributeSetInstance_ID,
			int C_ProjectIssue_ID, int M_CostElement_ID, String trxName) {
		return get (as.getCtx(), "C_ProjectIssue_ID=? AND Coalesce(M_CostElement_ID,0)="+M_CostElement_ID, 
				C_ProjectIssue_ID, M_AttributeSetInstance_ID, as.getC_AcctSchema_ID(), trxName);
	}
	
	
	/**
	 * 	Get Cost Detail
	 *	@param ctx context
	 *	@param whereClause where clause
	 *	@param ID 1st parameter
	 *  @param M_AttributeSetInstance_ID ASI
	 *	@param trxName trx
	 *	@return cost detail
	 *  @deprecated
	 */
	@Deprecated
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
	
	/**
	 * 	Get Cost Detail
	 *	@param ctx context
	 *	@param whereClause where clause for record id (1st parameter)
	 *	@param ID record id (1st parameter)
	 *  @param M_AttributeSetInstance_ID ASI (2nd parameter)
	 *  @param C_AcctSchema_ID accounting schema (3rd parameter)
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
	 * 	Get Cost Detail Records
	 *	@param ctx context
	 *	@param whereClause where clause for record id (1st parameter)
	 *	@param ID record id (1st parameter)
	 *  @param M_AttributeSetInstance_ID ASI (2nd parameter)
	 *  @param C_AcctSchema_ID accounting schema (3rd parameter)
	 *	@param trxName trx
	 *	@return list of cost detail record
	 */
	public static List<MCostDetail> list (Properties ctx, String whereClause, 
		int ID, int M_AttributeSetInstance_ID, int C_AcctSchema_ID, String trxName)
	{
		StringBuilder localWhereClause = new StringBuilder(whereClause)
			.append(" AND M_AttributeSetInstance_ID=?")
			.append(" AND C_AcctSchema_ID=?");
		List<MCostDetail> retValue = new Query(ctx,I_M_CostDetail.Table_Name,localWhereClause.toString(),trxName)
		.setParameters(ID,M_AttributeSetInstance_ID,C_AcctSchema_ID)
		.list();
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
		final String whereClause = I_M_CostDetail.Table_Name + "." + I_M_CostDetail.COLUMNNAME_M_Product_ID + "=?"
			+ " AND " + I_M_CostDetail.Table_Name + "." + I_M_CostDetail.COLUMNNAME_Processed + "=?";
		int counterOK = 0;
		int counterError = 0;
		List<MCostDetail> list = new Query(product.getCtx(),I_M_CostDetail.Table_Name,whereClause,trxName)
		.addJoinClause(" LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=M_CostDetail.Ref_CostDetail_ID) ")
		.setParameters(product.getM_Product_ID(),false)
		.setOrderBy("M_CostDetail.C_AcctSchema_ID, M_CostDetail.M_CostElement_ID, M_CostDetail.AD_Org_ID, M_CostDetail.M_AttributeSetInstance_ID, M_CostDetail.DateAcct, "
				+ "CASE WHEN COALESCE(refcd.DateAcct,M_CostDetail.DateAcct) = M_CostDetail.DateAcct THEN COALESCE(M_CostDetail.Ref_CostDetail_ID,M_CostDetail.M_CostDetail_ID) ELSE M_CostDetail.M_CostDetail_ID END, "
				+ "M_CostDetail.M_CostDetail_ID")
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
	
	/**
	 * Process Cost Details for product
	 * @param as accounting schema
	 * @param product product
	 * @param dateAcct account date
	 * @param trxName transaction
	 * @return true if no error
	 */
	public static boolean processProduct(MAcctSchema as, MProduct product, Timestamp dateAcct, String trxName)
	{
		if (dateAcct == null)
			dateAcct = TimeUtil.getDay(System.currentTimeMillis());
		
		final String whereClause = I_M_CostDetail.Table_Name + "." + I_M_CostDetail.COLUMNNAME_C_AcctSchema_ID + "=?"
				+ " AND " + I_M_CostDetail.Table_Name + "." + I_M_CostDetail.COLUMNNAME_M_Product_ID + "=?"
				+ " AND " + I_M_CostDetail.Table_Name + "." + I_M_CostDetail.COLUMNNAME_DateAcct + "<=?"
				+ " AND " + I_M_CostDetail.Table_Name + "." + I_M_CostDetail.COLUMNNAME_Processed + "=?";
		int counterOK = 0;
		int counterError = 0;
		List<MCostDetail> list = new Query(product.getCtx(),I_M_CostDetail.Table_Name,whereClause,trxName)
		.addJoinClause(" LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=M_CostDetail.Ref_CostDetail_ID) ")
		.setParameters(as.getC_AcctSchema_ID(), product.getM_Product_ID(), dateAcct, false)
		.setOrderBy("M_CostDetail.M_CostElement_ID, M_CostDetail.AD_Org_ID, M_CostDetail.M_AttributeSetInstance_ID, M_CostDetail.DateAcct, "
				+ "CASE WHEN COALESCE(refcd.DateAcct,M_CostDetail.DateAcct) = M_CostDetail.DateAcct THEN COALESCE(M_CostDetail.Ref_CostDetail_ID,M_CostDetail.M_CostDetail_ID) ELSE M_CostDetail.M_CostDetail_ID END, "
				+ "M_CostDetail.M_CostDetail_ID")
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
		
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_CostDetail_UU  UUID key
     * @param trxName Transaction
     */
    public MCostDetail(Properties ctx, String M_CostDetail_UU, String trxName) {
        super(ctx, M_CostDetail_UU, trxName);
		if (Util.isEmpty(M_CostDetail_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_CostDetail_ID id
	 *	@param trxName trx
	 */
	public MCostDetail (Properties ctx, int M_CostDetail_ID, String trxName)
	{
		super (ctx, M_CostDetail_ID, trxName);
		if (M_CostDetail_ID == 0)
			setInitialDefaults();
	}	//	MCostDetail

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setM_AttributeSetInstance_ID (0);
		setProcessed (false);
		setAmt (Env.ZERO);
		setQty (Env.ZERO);
		setIsSOTrx (false);
		setDeltaAmt (Env.ZERO);
		setDeltaQty (Env.ZERO);
	}

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
	 *	@param amt Amount
	 *	@param qty Quantity
	 *	@param description optional description
	 *	@param trxName transaction
	 *	@deprecated
	 */
	@Deprecated
	public MCostDetail (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_CostElement_ID, BigDecimal amt, BigDecimal qty,
		String description, String trxName)
	{
		this (as, AD_Org_ID, M_Product_ID, M_AttributeSetInstance_ID, M_CostElement_ID, amt, qty, description, null, 0, trxName);
	}
	
	/**
	 * 	New Constructor
	 *	@param as accounting schema
	 *	@param AD_Org_ID org
	 *	@param M_Product_ID product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param M_CostElement_ID optional cost element for Freight
	 *	@param amt Amount
	 *	@param qty Quantity
	 *	@param description optional description
	 *	@param dateAcct account date
	 *	@param Ref_CostDetail_ID referenced cost detail
	 *	@param trxName transaction
	 */
	public MCostDetail (MAcctSchema as, int AD_Org_ID, 
		int M_Product_ID, int M_AttributeSetInstance_ID,
		int M_CostElement_ID, BigDecimal amt, BigDecimal qty,
		String description, Timestamp dateAcct, int Ref_CostDetail_ID, String trxName)
	{
		this (as.getCtx(), 0, trxName);
		setClientOrg(as.getAD_Client_ID(), AD_Org_ID);
		setC_AcctSchema_ID (as.getC_AcctSchema_ID());
		setM_Product_ID (M_Product_ID);
		setM_AttributeSetInstance_ID (M_AttributeSetInstance_ID);
		//
		setM_CostElement_ID(M_CostElement_ID);		
		setAmt (amt);
		setQty (qty);
		setDescription(description);
		
		setDateAcct(dateAcct);		
		if (Ref_CostDetail_ID > 0)
			setRef_CostDetail_ID(Ref_CostDetail_ID);
	}	//	MCostDetail
	
	/**
	 * 	Set Amt
	 *	@param Amt amt
	 */
	@Override
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
	@Override
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
	 *	@return true if has order line
	 */
	public boolean isOrder()
	{
		return getC_OrderLine_ID() != 0;
	}	//	isOrder

	/**
	 * 	Is Invoice
	 *	@return true if has invoice line
	 */
	public boolean isInvoice()
	{
		return getC_InvoiceLine_ID() != 0;
	}	//	isInvoice

	/**
	 * 	Is Shipment
	 *	@return true if has sales order shipment line
	 */
	public boolean isShipment()
	{
		return isSOTrx() && getM_InOutLine_ID() != 0;
	}	//	isShipment
	
	/**
	 * @return true if shipment line belongs to return to vendor (vendor RMA)
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

	
	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (newRecord) {
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			Timestamp dateAcct = getDateAcct();
			if (dateAcct == null)
			{
				setDateAcct(today);
				setIsBackDate(false);
			}
			else
			{
				int Ref_CostDetail_ID = getRef_CostDetail_ID();
				if (Ref_CostDetail_ID > 0)
				{
					setDateAcct(dateAcct);
					setIsBackDate(true);
				}
				else
				{
					final String sql = "SELECT MAX(DateAcct) FROM M_CostDetail WHERE M_Product_ID=? AND Processed='Y'";
					Timestamp MaxDateAcct = DB.getSQLValueTS(get_TrxName(), sql, getM_Product_ID());
					if (MaxDateAcct != null && MaxDateAcct.after(today))
						today = MaxDateAcct;
					setDateAcct(dateAcct);
					setIsBackDate(dateAcct.before(today));
				}
			}
		} else {
			if (is_ValueChanged(COLUMNNAME_DateAcct))
			{
				log.saveError("Error", Msg.getMsg(getCtx(), "CannotChangeAccountDate"));
				return false;
			}
		}
		
		return super.beforeSave(newRecord);
	}

	@Override
	protected boolean beforeDelete ()
	{
		return !isProcessed();
	}	//	beforeDelete
	
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
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
		
	/**
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
		MProduct product = new MProduct(getCtx(), getM_Product_ID(), get_TrxName());
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
	 * 	Process cost detail record
	 *	@param as accounting schema
	 *	@param product product
	 *	@param ce cost element
	 *	@param Org_ID org - corrected for costing level
	 *	@param M_ASI_ID - asi corrected for costing level
	 *	@return true if cost ok
	 */
	protected boolean process (MAcctSchema as, MProduct product, MCostElement ce, 
		int Org_ID, int M_ASI_ID)
	{
		//handle compatibility issue between average invoice and average po
		String costingMethod = product.getCostingMethod(as);
		if (X_M_Cost.COSTINGMETHOD_AverageInvoice.equals(costingMethod)) {
			if (ce.isAveragePO())
				return true;
		} else if (X_M_Cost.COSTINGMETHOD_AveragePO.equals(costingMethod)) {
			if (ce.isAverageInvoice())
				return true;
		}

		MCost cost = MCost.get(product, M_ASI_ID, as, Org_ID, ce.getM_CostElement_ID(), get_TrxName());
		
		ICostInfo costInfo = MCost.getCostInfo(product.getCtx(), product.getAD_Client_ID(), Org_ID, product.getM_Product_ID(), 
				as.getM_CostType_ID(), as.getC_AcctSchema_ID(), ce.getM_CostElement_ID(), M_ASI_ID, getDateAcct(), this, get_TrxName());
		if (costInfo != null)
		{
			cost.setCurrentQty(costInfo.getCurrentQty());
			cost.setCurrentCostPrice(costInfo.getCurrentCostPrice());
			cost.setCumulatedQty(costInfo.getCumulatedQty());
			cost.setCumulatedAmt(costInfo.getCumulatedAmt());
		}
		
		DB.getDatabase().forUpdate(cost, 120);
		
		//save history for m_cost
		MCostHistory history = new MCostHistory(this, cost, ce);
		
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
			price = amt.divide(qty, precision, RoundingMode.HALF_UP);
		
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
						costingMethod = getM_InventoryLine().getM_Inventory().getCostingMethod();
						if (MCostElement.COSTINGMETHOD_AverageInvoice.equals(costingMethod))
						{
							if (cost.getCurrentQty().signum() == 0 && qty.signum() == 0) {
								// IDEMPIERE-2057 - this is a cost adjustment when there is no qty - setting the initial cost								
								cost.setWeightedAverageInitial(amt);
							} else {
								cost.setWeightedAverage(amt.multiply(cost.getCurrentQty()), qty);
							}
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
					costingMethod = getM_InventoryLine().getM_Inventory().getCostingMethod();
					if (MCostElement.COSTINGMETHOD_AveragePO.equals(costingMethod))
					{
						if (cost.getCurrentQty().signum() == 0 && qty.signum() == 0) {
							// IDEMPIERE-2057 - this is a cost adjustment when there is no qty - setting the initial cost								
							cost.setWeightedAverageInitial(amt);
						} else {
							cost.setWeightedAverage(amt.multiply(cost.getCurrentQty()), qty);
						}
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
					costingMethod = getM_InventoryLine().getM_Inventory().getCostingMethod();
					if (MCostElement.COSTINGMETHOD_StandardCosting.equals(costingMethod))
					{
						cost.add(amt.multiply(cost.getCurrentQty()), qty);					
						cost.setCurrentCostPrice(cost.getCurrentCostPrice().add(amt));
					}
				}
				else if (addition)
				{
					MProductionLine productionLine = getM_ProductionLine_ID() > 0 ? new MProductionLine(getCtx(), getM_ProductionLine_ID(), get_TrxName()) : null;
					if (productionLine != null && productionLine.getProductionReversalId() > 0)
						cost.setCurrentQty(cost.getCurrentQty().add(qty));						
					else
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
			else if (ce.isStandardCosting() && isVendorRMA)
			{
				cost.add(amt, qty);

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
		
		//Should only update cost detail with value from as costing method
		if(as.getCostingMethod().equals(ce.getCostingMethod())) {
			setCurrentCostPrice(cost.getCurrentCostPrice());
			setCurrentQty(cost.getCurrentQty());
			setCumulatedAmt(cost.getCumulatedAmt());
			setCumulatedQty(cost.getCumulatedQty());
		}
		
		//update history
		history.setNewQty(cost.getCurrentQty());
		history.setNewCostPrice(cost.getCurrentCostPrice());
		history.setNewCAmt(cost.getCumulatedAmt());
		history.setNewCQty(cost.getCumulatedQty());
		//save history if there are movement of qty or costprice
		//save history if the costing method is average po or average invoice
		if (history.getNewQty().compareTo(history.getOldQty()) != 0 
				|| history.getNewCostPrice().compareTo(history.getOldCostPrice()) != 0
				|| (ce.isAveragePO() || ce.isAverageInvoice()))
		{
			if (!history.save())
				return false;
		}
		
		return cost.save();
	}	//	process
	
	/**
	 * Period Closed Check for Documents after the Back-Date Transaction
	 * @param AD_Client_ID		Client of the back-date transaction
	 * @param C_AcctSchema_ID	Accounting schema of the back-date transaction
	 * @param M_Product_ID		Product of the back-date transaction
	 * @param M_CostDetail_ID	Cost detail of the back-date transaction
	 * @param DateAcct			Account date of the back-date transaction
	 * @param trxName			Transaction name
	 */
	public static void periodClosedCheckForDocsAfterBackDateTrx(int AD_Client_ID, int C_AcctSchema_ID, int M_Product_ID, 
			int M_CostDetail_ID, Timestamp DateAcct, String trxName) {
		List<String> repostedRecordIds = new ArrayList<String>();
		
		StringBuilder selectSql = new StringBuilder();
		selectSql.append("SELECT mpo.M_MatchPO_ID, il.C_Invoice_ID, iol.M_InOut_ID, mi.M_MatchInv_ID, invl.M_Inventory_ID, ");
		selectSql.append("ml.M_Movement_ID, pl.M_Production_ID, pi.C_ProjectIssue_ID ");
		selectSql.append("FROM M_CostDetail cd ");
		selectSql.append("LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=cd.Ref_CostDetail_ID) ");
		selectSql.append("LEFT JOIN M_MatchPO mpo ON (mpo.C_OrderLine_ID = cd.C_OrderLine_ID) ");
		selectSql.append("LEFT JOIN C_InvoiceLine il ON (il.C_InvoiceLine_ID = cd.C_InvoiceLine_ID) ");
		selectSql.append("LEFT JOIN M_InOutLine iol ON (iol.M_InOutLine_ID = cd.M_InOutLine_ID) ");
		selectSql.append("LEFT JOIN M_MatchInv mi ON (mi.M_MatchInv_ID = cd.M_MatchInv_ID) ");
		selectSql.append("LEFT JOIN M_InventoryLine invl ON (invl.M_InventoryLine_ID = cd.M_InventoryLine_ID) ");
		selectSql.append("LEFT JOIN M_MovementLine ml ON (ml.M_MovementLine_ID = cd.M_MovementLine_ID) ");
		selectSql.append("LEFT JOIN M_ProductionLine pl ON (pl.M_ProductionLine_ID = cd.M_ProductionLine_ID) ");
		selectSql.append("LEFT JOIN C_ProjectIssue pi ON (pi.C_ProjectIssue_ID = cd.C_ProjectIssue_ID) ");
		selectSql.append("WHERE cd.AD_Client_ID=? ");
		selectSql.append("AND cd.C_AcctSchema_ID=? ");
		selectSql.append("AND cd.M_Product_ID=? ");
		selectSql.append("AND (cd.DateAcct, COALESCE(cd.Ref_CostDetail_ID,cd.M_CostDetail_ID), cd.M_CostDetail_ID) > ("); 
		selectSql.append(" SELECT cd.DateAcct, ");
		selectSql.append(" CASE WHEN COALESCE(refcd.DateAcct,cd.DateAcct) = cd.DateAcct ");
		selectSql.append(" THEN COALESCE(cd.Ref_CostDetail_ID,cd.M_CostDetail_ID) ELSE cd.M_CostDetail_ID END, ");
		selectSql.append(" cd.M_CostDetail_ID ");
		selectSql.append(" FROM M_CostDetail cd ");
		selectSql.append(" LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=cd.Ref_CostDetail_ID) ");
		selectSql.append(" WHERE cd.M_CostDetail_ID=? ");
		selectSql.append(") ");
		selectSql.append("AND cd.DateAcct >= ? "); 
		selectSql.append("AND cd.Processed='Y' ");
		selectSql.append("ORDER BY cd.DateAcct, ");
		selectSql.append("CASE WHEN COALESCE(refcd.DateAcct,cd.DateAcct) = cd.DateAcct ");
		selectSql.append("THEN COALESCE(cd.Ref_CostDetail_ID,cd.M_CostDetail_ID) ELSE cd.M_CostDetail_ID END, ");
		selectSql.append("cd.M_CostDetail_ID ");
		
		PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	try
    	{
    		pstmt = DB.prepareStatement(selectSql.toString(), trxName);
    		DB.setParameters(pstmt, new Object[] {AD_Client_ID, C_AcctSchema_ID, M_Product_ID, M_CostDetail_ID, DateAcct});
    		rs = pstmt.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
    		while (rs.next()) {
				int tableID = 0;
				int recordID = 0;
    			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
    				String key = rsmd.getColumnName(i);
    				Object value = rs.getObject(i);
					if (value == null || !(value instanceof Number))
						continue;
					MTable docTable = MTable.get(Env.getCtx(), key.substring(0, key.length()-3));
					if (docTable == null)
						continue;
					tableID = docTable.getAD_Table_ID();
					recordID = ((Number) value).intValue();
					break;
    			}
    			if (tableID == 0 || recordID == 0)
    				continue;
    			
    			Timestamp dateAcct = MCostDetail.getDateAcct(tableID, recordID, trxName);
				if (dateAcct == null)
					continue;
				
				MTable table = MTable.get(Env.getCtx(), tableID);
				PO po = table.getPO(recordID, trxName);
				int index = po.get_ColumnIndex("C_DocType_ID");
				String docBaseType = null;
				if (index < 0) {
					if (tableID == MMatchInv.Table_ID) {
						docBaseType = MDocType.DOCBASETYPE_MatchInvoice;
					} else if (tableID == MMatchPO.Table_ID) {
						docBaseType = MDocType.DOCBASETYPE_MatchPO;
					} else if (tableID == MProjectIssue.Table_ID) {
						docBaseType = MDocType.DOCBASETYPE_ProjectIssue;
					} else {
						continue;
					}
				} else {
					int C_DocType_ID = 0;
					Object objts = po.get_Value(index);
					if (objts != null && objts instanceof Number) {
						C_DocType_ID = ((Number) objts).intValue();
					}
					MDocType dt = MDocType.get(Env.getCtx(), C_DocType_ID);
					docBaseType = dt.getDocBaseType();
				}
				if (docBaseType == null)
					continue;
				
				String repostedRecordId = tableID + "_" + recordID;
				if (repostedRecordIds.contains(repostedRecordId))
					continue;
				repostedRecordIds.add(repostedRecordId);
				if (!MPeriod.isOpen(Env.getCtx(), dateAcct, docBaseType, po.getAD_Org_ID(), true)) {
					throw new PeriodClosedException(dateAcct, docBaseType);
				}
				
				if (tableID == MInvoice.Table_ID) {
					MMatchInv[] miList = MMatchInv.getInvoice(Env.getCtx(), recordID, trxName);
					for (MMatchInv mi : miList) {
						repostedRecordId = MMatchInv.Table_ID + "_" + mi.get_ID();
						if (repostedRecordIds.contains(repostedRecordId))
							continue;
						repostedRecordIds.add(repostedRecordId);
						
						dateAcct = mi.getDateAcct();
						docBaseType = MDocType.DOCBASETYPE_MatchInvoice;
						if (!MPeriod.isOpen(Env.getCtx(), dateAcct, docBaseType, mi.getAD_Org_ID(), true)) {
							throw new PeriodClosedException(dateAcct, docBaseType);
						}
					}
				}
    		}
    	}
    	catch (SQLException e)
    	{
    		throw new DBException(e, selectSql.toString());
    	}
    	finally
    	{
    		DB.close(rs, pstmt);
    		rs = null; pstmt = null;
    	}
	}
	
	/**
	 * Get Account Date
	 * @param tableID	Transaction table
	 * @param recordID	Record ID of this document
	 * @param trxName	Transaction name
	 * @return accounting date
	 */
	public static Timestamp getDateAcct(int tableID, int recordID, String trxName) {
		MTable table = MTable.get(Env.getCtx(), tableID);
		PO po = table.getPO(recordID, trxName);
		
		int index = -1;
		if (tableID == MInventory.Table_ID
				|| tableID == MMovement.Table_ID
				|| tableID == MProduction.Table_ID
				|| tableID == MProjectIssue.Table_ID) {
			index = po.get_ColumnIndex("MovementDate");
		} else if (tableID == MMatchPO.Table_ID
				|| tableID == MInvoice.Table_ID
				|| tableID == MInOut.Table_ID
				|| tableID == MMatchInv.Table_ID) {
			index = po.get_ColumnIndex("DateAcct");
		}
		if (index < 0)
			return null;
		Timestamp dateAcct = null;
		Object objts = po.get_Value(index);
		if (objts != null && objts instanceof Timestamp) {
			dateAcct = (Timestamp) objts;
		}
		
		return dateAcct;
	}
}	//	MCostDetail
