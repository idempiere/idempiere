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
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;


/**
 *	Shipment/Receipt Callouts
 *
 *  @author Jorg Janke
 *  @version $Id: CalloutInOut.java,v 1.7 2006/07/30 00:51:05 jjanke Exp $
 *  @author victor.perez@e-evolution.com www.e-evolution.com [ 1867464 ] https://sourceforge.net/p/adempiere/bugs/923/
 */
public class CalloutInOut extends CalloutEngine
{
	/**
	 * 	C_Order - Order Defaults.
	 *	@param ctx
	 *	@param WindowNo
	 *	@param mTab
	 *	@param mField
	 *	@param value
	 *	@return error message or ""
	 */
	public String order (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer C_Order_ID = (Integer)value;
		if (C_Order_ID == null || C_Order_ID.intValue() == 0)
			return "";
		//	No Callout Active to fire dependent values
		if (isCalloutActive())	//	prevent recursive
			return "";

		//	Get Details
		MOrder order = new MOrder (ctx, C_Order_ID.intValue(), null);
		if (order.get_ID() != 0)
		{
			mTab.setValue("DateOrdered", order.getDateOrdered());
			mTab.setValue("POReference", order.getPOReference());
			mTab.setValue("AD_Org_ID", Integer.valueOf(order.getAD_Org_ID()));
			mTab.setValue("AD_OrgTrx_ID", Integer.valueOf(order.getAD_OrgTrx_ID()));
			mTab.setValue("C_Activity_ID", Integer.valueOf(order.getC_Activity_ID()));
			mTab.setValue("C_Campaign_ID", Integer.valueOf(order.getC_Campaign_ID()));
			mTab.setValue("C_Project_ID", Integer.valueOf(order.getC_Project_ID()));
			mTab.setValue("User1_ID", Integer.valueOf(order.getUser1_ID()));
			mTab.setValue("User2_ID", Integer.valueOf(order.getUser2_ID()));
			mTab.setValue("M_Warehouse_ID", Integer.valueOf(order.getM_Warehouse_ID()));
			//
			mTab.setValue("DeliveryRule", order.getDeliveryRule());
			mTab.setValue("DeliveryViaRule", order.getDeliveryViaRule());
			mTab.setValue("M_Shipper_ID", Integer.valueOf(order.getM_Shipper_ID()));
			mTab.setValue("FreightCostRule", order.getFreightCostRule());
			mTab.setValue("FreightAmt", order.getFreightAmt());

			mTab.setValue("C_BPartner_ID", Integer.valueOf(order.getC_BPartner_ID()));

			//[ 1867464 ]
			mTab.setValue("C_BPartner_Location_ID", Integer.valueOf(order.getC_BPartner_Location_ID()));
			
			if (order.getAD_User_ID() > 0)
				mTab.setValue("AD_User_ID", Integer.valueOf(order.getAD_User_ID()));
			else
				mTab.setValue("AD_User_ID", null);

			if (order.isDropShip()) {
				mTab.setValue(MInOut.COLUMNNAME_IsDropShip, order.isDropShip());
				mTab.setValue(MInOut.COLUMNNAME_DropShip_BPartner_ID, order.getDropShip_BPartner_ID());
				mTab.setValue(MInOut.COLUMNNAME_DropShip_Location_ID, order.getDropShip_Location_ID());
				mTab.setValue(MInOut.COLUMNNAME_DropShip_User_ID, order.getDropShip_User_ID());
			}
		}
        /**
         * Modification: set corresponding document type
         */
        int docTypeId = order.getC_DocType_ID();
        int relatedDocTypeId = 0;
        
        if (docTypeId == 0)
        {
            docTypeId = order.getC_DocTypeTarget_ID();
        }
        
        relatedDocTypeId = MDocType.getShipmentReceiptDocType(docTypeId);
        
        mTab.setValue("C_DocType_ID", relatedDocTypeId);
		return "";
	}	//	order

	/**
	 * 	M_RMA - RMA Defaults.
	 *	@param ctx
	 *	@param WindowNo
	 *	@param mTab
	 *	@param mField
	 *	@param value
	 *	@return error message or ""
	 */
	public String rma (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer M_RMA_ID = (Integer)value;
		if (M_RMA_ID == null || M_RMA_ID.intValue() == 0)
			return "";
		//	No Callout Active to fire dependent values
		if (isCalloutActive())	//	prevent recursive
			return "";

		//	Get Details
		MRMA rma = new MRMA (ctx, M_RMA_ID.intValue(), null);
        MInOut originalReceipt = rma.getShipment();
		if (rma.get_ID() != 0)
		{
			mTab.setValue("DateOrdered", originalReceipt.getDateOrdered());
			mTab.setValue("POReference", originalReceipt.getPOReference());
			mTab.setValue("AD_Org_ID", Integer.valueOf(originalReceipt.getAD_Org_ID()));
			mTab.setValue("AD_OrgTrx_ID", Integer.valueOf(originalReceipt.getAD_OrgTrx_ID()));
			mTab.setValue("C_Activity_ID", Integer.valueOf(originalReceipt.getC_Activity_ID()));
			mTab.setValue("C_Campaign_ID", Integer.valueOf(originalReceipt.getC_Campaign_ID()));
			mTab.setValue("C_Project_ID", Integer.valueOf(originalReceipt.getC_Project_ID()));
			mTab.setValue("User1_ID", Integer.valueOf(originalReceipt.getUser1_ID()));
			mTab.setValue("User2_ID", Integer.valueOf(originalReceipt.getUser2_ID()));
			mTab.setValue("M_Warehouse_ID", Integer.valueOf(originalReceipt.getM_Warehouse_ID()));
			//
			mTab.setValue("DeliveryRule", originalReceipt.getDeliveryRule());
			mTab.setValue("DeliveryViaRule", originalReceipt.getDeliveryViaRule());
			mTab.setValue("M_Shipper_ID", Integer.valueOf(originalReceipt.getM_Shipper_ID()));
			mTab.setValue("FreightCostRule", originalReceipt.getFreightCostRule());
			mTab.setValue("FreightAmt", originalReceipt.getFreightAmt());

			mTab.setValue("C_BPartner_ID", Integer.valueOf(originalReceipt.getC_BPartner_ID()));

			//[ 1867464 ]
			mTab.setValue("C_BPartner_Location_ID", Integer.valueOf(originalReceipt.getC_BPartner_Location_ID()));

			if (originalReceipt.getAD_User_ID() > 0)
				mTab.setValue("AD_User_ID", Integer.valueOf(originalReceipt.getAD_User_ID()));
			else
				mTab.setValue("AD_User_ID", null);
		}
		return "";
	}	//	rma


	/**
	 *	InOut - DocType.
	 *			- sets MovementType
	 *			- gets DocNo
	 *	@param ctx
	 *	@param WindowNo
	 *	@param mTab
	 *	@param mField
	 *	@param value
	 *	@return error message or ""
	 */
	public String docType (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer C_DocType_ID = (Integer)value;
		if (C_DocType_ID == null || C_DocType_ID.intValue() == 0)
			return "";

		String sql = "SELECT d.DocBaseType, d.IsDocNoControlled, " //1..2
			+ "s.AD_Sequence_ID, d.IsSOTrx " //3..4
			+ "FROM C_DocType d "
			+ "LEFT OUTER JOIN AD_Sequence s ON (d.DocNoSequence_ID=s.AD_Sequence_ID) "
			+ "WHERE C_DocType_ID=?";		//	1
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			try
		{
			Env.setContext(ctx, WindowNo, "C_DocTypeTarget_ID", C_DocType_ID.intValue());
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, C_DocType_ID.intValue());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				//	Set Movement Type
				// BF [2708789] Read IsSOTrx from C_DocType
				String trxFlag = rs.getString("IsSOTrx");
				Object isSOTrxValue = mTab.getValue("IsSOTrx");
				String isSOTrxValueStr = null;
				boolean IsSOTrx = "Y".equals(trxFlag);
				if (isSOTrxValue != null)
				{
					if (isSOTrxValue instanceof Boolean)
						isSOTrxValueStr = (Boolean)isSOTrxValue ? "Y" : "N";
					else
						isSOTrxValueStr = (String)isSOTrxValue;
				}
				
				if (!(trxFlag.equals(isSOTrxValueStr)))
					mTab.setValue("IsSOTrx", trxFlag);
				
				mTab.setValue("MovementType", MInOut.getMovementType(ctx, C_DocType_ID, IsSOTrx, null));
				
				//	DocumentNo
				if (rs.getString("IsDocNoControlled").equals("Y"))
				{
					int AD_Sequence_ID = rs.getInt("AD_Sequence_ID");
					mTab.setValue("DocumentNo", MSequence.getPreliminaryNo(mTab, AD_Sequence_ID));
				}
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return e.getLocalizedMessage();
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return "";
	}	//	docType


	/**
	 *	M_InOut - Defaults for BPartner.
	 *			- Location
	 *			- Contact
	 *	@param ctx
	 *	@param WindowNo
	 *	@param mTab
	 *	@param mField
	 *	@param value
	 *	@return error message or ""
	 */
	public String bpartner (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer C_BPartner_ID = (Integer)value;
		if (C_BPartner_ID == null || C_BPartner_ID.intValue() == 0)
			return "";

		String sql = "SELECT p.AD_Language,p.C_PaymentTerm_ID,"
			+ "p.M_PriceList_ID,p.PaymentRule,p.POReference,"
			+ "p.SO_Description,p.IsDiscountPrinted,"
			+ "p.SO_CreditLimit-p.SO_CreditUsed AS CreditAvailable,"
			+ "(select max(l.C_BPartner_Location_ID) from C_BPartner_Location l where p.C_BPartner_ID=l.C_BPartner_ID AND l.IsActive='Y') as C_BPartner_Location_ID,"
			+ "(select max(c.AD_User_ID) from AD_User c where p.C_BPartner_ID=c.C_BPartner_ID AND c.IsActive='Y' AND IsShipTo='Y') as ShipTo_User_ID,"
			+ "(select max(c.AD_User_ID) from AD_User c where p.C_BPartner_ID=c.C_BPartner_ID AND c.IsActive='Y') as AD_User_ID "
			+ "FROM C_BPartner p "
			+ "WHERE p.C_BPartner_ID=?";		//	1

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, C_BPartner_ID.intValue());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				//[ 1867464 ]
				boolean IsSOTrx = "Y".equals(Env.getContext(ctx, WindowNo, "IsSOTrx"));
				if (!IsSOTrx)
				{
					//	Location
					Integer ii = Integer.valueOf(rs.getInt("C_BPartner_Location_ID"));
					if (rs.wasNull())
						mTab.setValue("C_BPartner_Location_ID", null);
					else
						mTab.setValue("C_BPartner_Location_ID", ii);
					//	Contact
					ii = Integer.valueOf(rs.getInt("AD_User_ID"));
					if (rs.wasNull())
						mTab.setValue("AD_User_ID", null);
					else {
						int ShipTo_User_ID = rs.getInt("ShipTo_User_ID");
						Integer userID = ShipTo_User_ID > 0 ? Integer.valueOf(ShipTo_User_ID) : ii;
						mTab.setValue("AD_User_ID", userID);
					}
				}

				//Bugs item #1679818: checking for SOTrx only
				if (IsSOTrx)
				{
					//	CreditAvailable
					double CreditAvailable = rs.getDouble("CreditAvailable");
					if (!rs.wasNull() && CreditAvailable < 0)
						mTab.fireDataStatusEEvent("CreditLimitOver",
								DisplayType.getNumberFormat(DisplayType.Amount).format(CreditAvailable),
								false);
				}//
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return e.getLocalizedMessage();
		}
		finally
		{
			DB.close(rs, pstmt);
		}

		return "";
	}	//	bpartner

	/**
	 *	M_Warehouse.
	 *		Set Organization and Default Locator
	 *	@param ctx
	 *	@param WindowNo
	 *	@param mTab
	 *	@param mField
	 *	@param value
	 *	@return error message or ""
	 */
	public String warehouse (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive())
			return "";
		Integer M_Warehouse_ID = (Integer)value;
		if (M_Warehouse_ID == null || M_Warehouse_ID.intValue() == 0)
			return "";

		String sql = "SELECT w.AD_Org_ID, l.M_Locator_ID, w.IsDisallowNegativeInv  "
			+ "FROM M_Warehouse w"
			+ " LEFT OUTER JOIN M_Locator l ON (l.M_Warehouse_ID=w.M_Warehouse_ID AND l.IsDefault='Y') "
			+ "WHERE w.M_Warehouse_ID=?";		//	1

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, M_Warehouse_ID.intValue());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				//	Org
				Integer ii = Integer.valueOf(rs.getInt(1));
				int AD_Org_ID = Env.getContextAsInt(ctx, WindowNo, "AD_Org_ID");
				if (AD_Org_ID != ii.intValue())
					mTab.setValue("AD_Org_ID", ii);
				//	Locator
				ii = Integer.valueOf(rs.getInt(2));
				if (rs.wasNull())
					Env.setContext(ctx, WindowNo, 0, "M_Locator_ID", null);
				else
				{
					if (log.isLoggable(Level.CONFIG)) log.config("M_Locator_ID=" + ii);
					Env.setContext(ctx, WindowNo, "M_Locator_ID", ii.intValue());
				}
			}

			Boolean disallowNegInv = rs.getString(3).equals("Y");
			String DeliveryRule = mTab.get_ValueAsString("DeliveryRule");
			if((disallowNegInv && DeliveryRule.equals(X_C_Order.DELIVERYRULE_Force)) ||
					(DeliveryRule == null || DeliveryRule.length()==0))
				mTab.setValue("DeliveryRule",X_C_Order.DELIVERYRULE_Availability);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return e.getLocalizedMessage();
		}
		finally
		{
			DB.close(rs, pstmt);
		}

		return "";
	}	//	warehouse


	/**************************************************************************
	 * 	OrderLine Callout
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab model
	 *	@param mField field model
	 *	@param value new value
	 *	@return error message or ""
	 */
	public String orderLine (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer C_OrderLine_ID = (Integer)value;
		if (C_OrderLine_ID == null || C_OrderLine_ID.intValue() == 0)
			return "";

		//	Get Details
		MOrderLine ol = new MOrderLine (ctx, C_OrderLine_ID.intValue(), null);
		if (ol.get_ID() != 0)
		{
			if (ol.getC_Charge_ID() > 0 && ol.getM_Product_ID() <= 0) {
				mTab.setValue("C_Charge_ID", Integer.valueOf(ol.getC_Charge_ID()));
				mTab.setValue("M_Product_ID", null);
				mTab.setValue("M_AttributeSetInstance_ID", null);
			}
			else {
				mTab.setValue("M_Product_ID", Integer.valueOf(ol.getM_Product_ID()));
				mTab.setValue("M_AttributeSetInstance_ID", Integer.valueOf(ol.getM_AttributeSetInstance_ID()));
				mTab.setValue("C_Charge_ID", null);
			}
			//
			mTab.setValue("C_UOM_ID", Integer.valueOf(ol.getC_UOM_ID()));
			BigDecimal MovementQty = ol.getQtyOrdered().subtract(ol.getQtyDelivered());
			BigDecimal runningqty = DB.getSQLValueBDEx(null, "SELECT SUM(MovementQty) FROM M_InOutLine WHERE M_InOut_ID=? AND M_InOutLine_ID!=? AND C_OrderLine_ID=?",
					Env.getContextAsInt(ctx, WindowNo, "M_InOut_ID"),
					Env.getContextAsInt(ctx, WindowNo, "M_InOutLine_ID"),
					ol.get_ID());
			if (runningqty != null) {
				MovementQty = MovementQty.subtract(runningqty); // IDEMPIERE-1140
			}
			mTab.setValue("MovementQty", MovementQty);
			BigDecimal QtyEntered = MovementQty;
			if (ol.getQtyEntered().compareTo(ol.getQtyOrdered()) != 0)
				QtyEntered = QtyEntered.multiply(ol.getQtyEntered())
					.divide(ol.getQtyOrdered(), 12, RoundingMode.HALF_UP);
			mTab.setValue("QtyEntered", QtyEntered);
			//
			mTab.setValue("C_Activity_ID", Integer.valueOf(ol.getC_Activity_ID()));
			mTab.setValue("C_Campaign_ID", Integer.valueOf(ol.getC_Campaign_ID()));
			mTab.setValue("C_Project_ID", Integer.valueOf(ol.getC_Project_ID()));
			mTab.setValue("C_ProjectPhase_ID", Integer.valueOf(ol.getC_ProjectPhase_ID()));
			mTab.setValue("C_ProjectTask_ID", Integer.valueOf(ol.getC_ProjectTask_ID()));
			mTab.setValue("AD_OrgTrx_ID", Integer.valueOf(ol.getAD_OrgTrx_ID()));
			mTab.setValue("User1_ID", Integer.valueOf(ol.getUser1_ID()));
			mTab.setValue("User2_ID", Integer.valueOf(ol.getUser2_ID()));
		}
		return "";
	}	//	orderLine

	/**************************************************************************
	 * 	RMALine Callout
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab model
	 *	@param mField field model
	 *	@param value new value
	 *	@return error message or ""
	 */
	public String rmaLine (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer M_RMALine_id = (Integer)value;
		if (M_RMALine_id == null || M_RMALine_id.intValue() == 0)
			return "";

		//	Get Details
		MRMALine rl = new MRMALine (ctx, M_RMALine_id.intValue(), null);
		if (rl.get_ID() != 0)
		{
			if (rl.getC_Charge_ID() > 0 && rl.getM_Product_ID() <= 0) {
				mTab.setValue("C_Charge_ID", Integer.valueOf(rl.getC_Charge_ID()));
				mTab.setValue("M_Product_ID", null);
				mTab.setValue("M_AttributeSetInstance_ID", null);
			}
			else {
				mTab.setValue("M_Product_ID", Integer.valueOf(rl.getM_Product_ID()));
				mTab.setValue("M_AttributeSetInstance_ID", Integer.valueOf(rl.getM_AttributeSetInstance_ID()));
				mTab.setValue("C_Charge_ID", null);
			}
			//
			mTab.setValue("C_UOM_ID", Integer.valueOf(rl.getC_UOM_ID()));
			BigDecimal MovementQty = rl.getQty().subtract(rl.getQtyDelivered());
			mTab.setValue("MovementQty", MovementQty);
			BigDecimal QtyEntered = MovementQty;
			mTab.setValue("QtyEntered", QtyEntered);
			//
			mTab.setValue("C_Activity_ID", Integer.valueOf(rl.getC_Activity_ID()));
			mTab.setValue("C_Campaign_ID", Integer.valueOf(rl.getC_Campaign_ID()));
			mTab.setValue("C_Project_ID", Integer.valueOf(rl.getC_Project_ID()));
			mTab.setValue("C_ProjectPhase_ID", Integer.valueOf(rl.getC_ProjectPhase_ID()));
			mTab.setValue("C_ProjectTask_ID", Integer.valueOf(rl.getC_ProjectTask_ID()));
			mTab.setValue("AD_OrgTrx_ID", Integer.valueOf(rl.getAD_OrgTrx_ID()));
			mTab.setValue("User1_ID", Integer.valueOf(rl.getUser1_ID()));
			mTab.setValue("User2_ID", Integer.valueOf(rl.getUser2_ID()));
		}
		return "";
	}	//	rmaLine

	/**
	 *	M_InOutLine - Default UOM/Locator for Product.
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab model
	 *	@param mField field model
	 *	@param value new value
	 *	@return error message or ""
	 */
	public String product (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive())
			return "";
		Integer M_Product_ID = (Integer)value;
		if (M_Product_ID == null || M_Product_ID.intValue() == 0)
			return "";

		//	Set Attribute & Locator
		int M_Locator_ID = 0;
		if (Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_Product_ID") == M_Product_ID.intValue()
			&& Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_AttributeSetInstance_ID") != 0)
		{
			mTab.setValue("M_AttributeSetInstance_ID",
				Integer.valueOf(Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_AttributeSetInstance_ID")));
			M_Locator_ID = Env.getContextAsInt(ctx, WindowNo, Env.TAB_INFO, "M_Locator_ID");
			if (M_Locator_ID != 0)
				mTab.setValue("M_Locator_ID", Integer.valueOf(M_Locator_ID));
		}
		else
			mTab.setValue("M_AttributeSetInstance_ID", null);
		//
		int M_Warehouse_ID = Env.getContextAsInt(ctx, WindowNo, "M_Warehouse_ID");
		boolean IsSOTrx = "Y".equals(Env.getContext(ctx, WindowNo, "IsSOTrx"));
		if (IsSOTrx)
		{
			return "";
		}

		//	Set UOM/Locator/Qty
		MProduct product = MProduct.get(ctx, M_Product_ID.intValue());
		mTab.setValue("C_UOM_ID", Integer.valueOf(product.getC_UOM_ID()));
		BigDecimal QtyEntered = (BigDecimal)mTab.getValue("QtyEntered");
		mTab.setValue("MovementQty", QtyEntered);
		if (M_Locator_ID != 0)
			;		//	already set
		else if (product.getM_Locator_ID() != 0)
		{
			MLocator loc = MLocator.get(ctx, product.getM_Locator_ID());
			if (M_Warehouse_ID == loc.getM_Warehouse_ID())
				mTab.setValue("M_Locator_ID", Integer.valueOf(product.getM_Locator_ID()));
			else
				if (log.isLoggable(Level.FINE)) log.fine("No Locator for M_Product_ID=" + M_Product_ID + " and M_Warehouse_ID=" + M_Warehouse_ID);
		}
		else
			if (log.isLoggable(Level.FINE)) log.fine("No Locator for M_Product_ID=" + M_Product_ID);
		return "";
	}	//	product

	/**
	 *	InOut Line - Quantity.
	 *		- called from C_UOM_ID, QtyEntered, MovementQty
	 *		- enforces qty UOM relationship
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab model
	 *	@param mField field model
	 *	@param value new value
	 *	@return error message or ""
	 */
	public String qty (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive() || value == null)
			return "";

		int M_Product_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "M_Product_ID");
		BigDecimal MovementQty, QtyEntered;

		//	No Product
		if (M_Product_ID == 0)
		{
			QtyEntered = (BigDecimal)mTab.getValue("QtyEntered");
			mTab.setValue("MovementQty", QtyEntered);
		}
		//	UOM Changed - convert from Entered -> Product
		else if (mField.getColumnName().equals("C_UOM_ID"))
		{
			int C_UOM_To_ID = ((Integer)value).intValue();
			QtyEntered = (BigDecimal)mTab.getValue("QtyEntered");
			BigDecimal QtyEntered1 = QtyEntered.setScale(MUOM.getPrecision(ctx, C_UOM_To_ID), RoundingMode.HALF_UP);
			if (QtyEntered.compareTo(QtyEntered1) != 0)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Corrected QtyEntered Scale UOM=" + C_UOM_To_ID
					+ "; QtyEntered=" + QtyEntered + "->" + QtyEntered1);
				QtyEntered = QtyEntered1;
				mTab.setValue("QtyEntered", QtyEntered);
			}
			MovementQty = MUOMConversion.convertProductFrom (ctx, M_Product_ID,
				C_UOM_To_ID, QtyEntered);
			if (MovementQty == null)
				MovementQty = QtyEntered;
			boolean conversion = QtyEntered.compareTo(MovementQty) != 0;
			if (log.isLoggable(Level.FINE)) log.fine("UOM=" + C_UOM_To_ID
				+ ", QtyEntered=" + QtyEntered
				+ " -> " + conversion
				+ " MovementQty=" + MovementQty);
			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");
			mTab.setValue("MovementQty", MovementQty);
		}
		//	No UOM defined
		else if (Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "C_UOM_ID") == 0)
		{
			QtyEntered = (BigDecimal)mTab.getValue("QtyEntered");
			mTab.setValue("MovementQty", QtyEntered);
		}
		//	QtyEntered changed - calculate MovementQty
		else if (mField.getColumnName().equals("QtyEntered"))
		{
			int C_UOM_To_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "C_UOM_ID");
			QtyEntered = (BigDecimal)value;
			BigDecimal QtyEntered1 = QtyEntered.setScale(MUOM.getPrecision(ctx, C_UOM_To_ID), RoundingMode.HALF_UP);
			if (QtyEntered.compareTo(QtyEntered1) != 0)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Corrected QtyEntered Scale UOM=" + C_UOM_To_ID
					+ "; QtyEntered=" + QtyEntered + "->" + QtyEntered1);
				QtyEntered = QtyEntered1;
				mTab.setValue("QtyEntered", QtyEntered);
			}
			MovementQty = MUOMConversion.convertProductFrom (ctx, M_Product_ID,
				C_UOM_To_ID, QtyEntered);
			if (MovementQty == null)
				MovementQty = QtyEntered;
			boolean conversion = QtyEntered.compareTo(MovementQty) != 0;
			if (log.isLoggable(Level.FINE)) log.fine("UOM=" + C_UOM_To_ID
				+ ", QtyEntered=" + QtyEntered
				+ " -> " + conversion
				+ " MovementQty=" + MovementQty);
			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");
			mTab.setValue("MovementQty", MovementQty);
		}
		//	MovementQty changed - calculate QtyEntered (should not happen)
		else if (mField.getColumnName().equals("MovementQty"))
		{
			int C_UOM_To_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "C_UOM_ID");
			MovementQty = (BigDecimal)value;
			int precision = MProduct.get(ctx, M_Product_ID).getUOMPrecision();
			BigDecimal MovementQty1 = MovementQty.setScale(precision, RoundingMode.HALF_UP);
			if (MovementQty.compareTo(MovementQty1) != 0)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Corrected MovementQty "
					+ MovementQty + "->" + MovementQty1);
				MovementQty = MovementQty1;
				mTab.setValue("MovementQty", MovementQty);
			}
			QtyEntered = MUOMConversion.convertProductTo (ctx, M_Product_ID,
				C_UOM_To_ID, MovementQty);
			if (QtyEntered == null)
				QtyEntered = MovementQty;
			boolean conversion = MovementQty.compareTo(QtyEntered) != 0;
			if (log.isLoggable(Level.FINE)) log.fine("UOM=" + C_UOM_To_ID
				+ ", MovementQty=" + MovementQty
				+ " -> " + conversion
				+ " QtyEntered=" + QtyEntered);
			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");
			mTab.setValue("QtyEntered", QtyEntered);
		}
		//
		return "";
	}	//	qty

	/**
	 *	M_InOutLine - ASI.
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab model
	 *	@param mField field model
	 *	@param value new value
	 *	@return error message or ""
	 */
	public String asi (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive())
			return "";
		Integer M_ASI_ID = (Integer)value;
		if (M_ASI_ID == null || M_ASI_ID.intValue() == 0)
			return "";
		//
		int M_Product_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "M_Product_ID");
		int M_Warehouse_ID = Env.getContextAsInt(ctx, WindowNo, "M_Warehouse_ID");
		int M_Locator_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "M_Locator_ID");
		if (log.isLoggable(Level.FINE)) log.fine("M_Product_ID=" + M_Product_ID
			+ ", M_ASI_ID=" + M_ASI_ID
			+ " - M_Warehouse_ID=" + M_Warehouse_ID
			+ ", M_Locator_ID=" + M_Locator_ID);
		//	Check Selection
		int M_AttributeSetInstance_ID =	Env.getContextAsInt(Env.getCtx(), WindowNo, Env.TAB_INFO, "M_AttributeSetInstance_ID");
		if (M_ASI_ID.intValue() == M_AttributeSetInstance_ID)
		{
			int selectedM_Locator_ID = Env.getContextAsInt(Env.getCtx(), WindowNo, Env.TAB_INFO, "M_Locator_ID");
			if (selectedM_Locator_ID != 0)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Selected M_Locator_ID=" + selectedM_Locator_ID);
				mTab.setValue("M_Locator_ID", Integer.valueOf(selectedM_Locator_ID));
			}
		}
		MAttributeSetInstance asi = MAttributeSetInstance.get(ctx, M_ASI_ID.intValue(), 0);
		if (asi.getSerNo() != null) {
			// serialized ASI - force qty yo 1 - IDEMPIERE-1140
			mTab.setValue("MovementQty", Env.ONE);
			mTab.setValue("QtyEntered", Env.ONE);
			MProduct product = MProduct.get(ctx, M_Product_ID);
			if (product != null)
				mTab.setValue("C_UOM_ID", product.getC_UOM_ID());
		}
		return "";
	}	//	asi

	public String navigateInOutLine(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if (isCalloutActive() || value == null)
			return "";

		int M_Product_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "M_Product_ID");
		//	No Product
		if (M_Product_ID != 0) {
			MProduct product = MProduct.get(ctx, M_Product_ID);
			int C_UOM_To_ID = Env.getContextAsInt(ctx, WindowNo, mTab.getTabNo(), "C_UOM_ID");
			boolean conversion = (C_UOM_To_ID != product.getC_UOM_ID());
			Env.setContext(ctx, WindowNo, "UOMConversion", conversion ? "Y" : "N");
		}
		return "";
	}	//	navigateInOutLine

	
}	//	CalloutInOut