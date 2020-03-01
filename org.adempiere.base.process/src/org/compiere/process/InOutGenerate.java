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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MClient;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MLocator;
import org.compiere.model.MLocatorType;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *	Generate Shipments.
 *	Manual or Automatic
 *	
 *  @author Jorg Janke
 *  @version $Id: InOutGenerate.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class InOutGenerate extends SvrProcess
{
	/**	Manual Selection		*/
	private boolean 	p_Selection = false;
	/** Warehouse				*/
	private int			p_M_Warehouse_ID = 0;
	/** BPartner				*/
	private int			p_C_BPartner_ID = 0;
	/** Promise Date			*/
	private Timestamp	p_DatePromised = null;
	/** Include Orders w. unconfirmed Shipments	*/
	private boolean		p_IsUnconfirmedInOut = false;
	/** DocAction				*/
	private String		p_docAction = DocAction.ACTION_None;
	/** Consolidate				*/
	private boolean		p_ConsolidateDocument = true;
    /** Shipment Date                       */
	private Timestamp       p_DateShipped = null;
	
	/**	The current Shipment	*/
	private MInOut 		m_shipment = null;
	/** Number of Shipments	being created	*/
	private int			m_created = 0;
	/**	Line Number				*/
	private int			m_line = 0;
	/** Movement Date			*/
	private Timestamp	m_movementDate = null;
	/**	Last BP Location		*/
	private int			m_lastC_BPartner_Location_ID = -1;

	/** The Query sql			*/
	private StringBuffer 		m_sql = null;

	
	/** Storages temp space				*/
	private HashMap<SParameter,MStorageOnHand[]> m_map = new HashMap<SParameter,MStorageOnHand[]>();
	/** Last Parameter					*/
	private SParameter		m_lastPP = null;
	/** Last Storage					*/
	private MStorageOnHand[]		m_lastStorages = null;

	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_Warehouse_ID"))
				p_M_Warehouse_ID = para[i].getParameterAsInt();
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = para[i].getParameterAsInt();
			else if (name.equals("DatePromised"))
				p_DatePromised = (Timestamp)para[i].getParameter();
			else if (name.equals("Selection"))
				p_Selection = "Y".equals(para[i].getParameter());
			else if (name.equals("IsUnconfirmedInOut"))
				p_IsUnconfirmedInOut = "Y".equals(para[i].getParameter());
			else if (name.equals("ConsolidateDocument"))
				p_ConsolidateDocument = "Y".equals(para[i].getParameter());
			else if (name.equals("DocAction"))
				p_docAction = (String)para[i].getParameter();
			else if (name.equals("MovementDate"))
                p_DateShipped = (Timestamp)para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
			
			//  juddm - added ability to specify a shipment date from Generate Shipments
			if (p_DateShipped == null) {
				m_movementDate = Env.getContextAsDate(getCtx(), "#Date");
				if (m_movementDate == null)
					m_movementDate = new Timestamp(System.currentTimeMillis());
			} else
				m_movementDate = p_DateShipped;
		}
	}	//	prepare

	/**
	 * 	Generate Shipments
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("Selection=" + p_Selection
			+ ", M_Warehouse_ID=" + p_M_Warehouse_ID 
			+ ", C_BPartner_ID=" + p_C_BPartner_ID 
			+ ", Consolidate=" + p_ConsolidateDocument
			+ ", IsUnconfirmed=" + p_IsUnconfirmedInOut
			+ ", Movement=" + m_movementDate);
		
		if (p_M_Warehouse_ID == 0)
			throw new AdempiereUserError("@NotFound@ @M_Warehouse_ID@");
		
		if (p_Selection)	//	VInOutGen
		{
			m_sql = new StringBuffer("SELECT C_Order.* FROM C_Order, T_Selection ")
				.append("WHERE C_Order.DocStatus='CO' AND C_Order.IsSOTrx='Y' AND C_Order.AD_Client_ID=? ")
				.append("AND C_Order.C_Order_ID = T_Selection.T_Selection_ID ") 
				.append("AND T_Selection.AD_PInstance_ID=? ");
		}
		else
		{
			m_sql = new StringBuffer("SELECT * FROM C_Order o ")
				.append("WHERE DocStatus='CO' AND IsSOTrx='Y'")
				//	No Offer,POS
				.append(" AND o.C_DocType_ID IN (SELECT C_DocType_ID FROM C_DocType ")
					.append("WHERE DocBaseType='SOO' AND DocSubTypeSO NOT IN ('ON','OB','WR'))")
				.append("	AND o.IsDropShip='N'")
				//	No Manual
				.append(" AND o.DeliveryRule<>'M'")
				//	Open Order Lines with Warehouse
				.append(" AND EXISTS (SELECT * FROM C_OrderLine ol ")
					.append("WHERE ol.M_Warehouse_ID=?");					//	#1
			if (p_DatePromised != null)
				m_sql.append(" AND TRUNC(ol.DatePromised)<=?");		//	#2
			m_sql.append(" AND o.C_Order_ID=ol.C_Order_ID AND ol.QtyOrdered<>ol.QtyDelivered)");
			//
			if (p_C_BPartner_ID != 0)
				m_sql.append(" AND o.C_BPartner_ID=?");					//	#3
		}
		m_sql.append(" ORDER BY M_Warehouse_ID, PriorityRule, M_Shipper_ID, C_BPartner_ID, C_BPartner_Location_ID, C_Order_ID");
	//	m_sql += " FOR UPDATE";

		PreparedStatement pstmt = null;
		try
		{
			pstmt = DB.prepareStatement (m_sql.toString(), get_TrxName());
			int index = 1;
			if (p_Selection)
			{
				pstmt.setInt(index++, Env.getAD_Client_ID(getCtx()));
				pstmt.setInt(index++, getAD_PInstance_ID());
			}
			else	
			{
				pstmt.setInt(index++, p_M_Warehouse_ID);
				if (p_DatePromised != null)
					pstmt.setTimestamp(index++, p_DatePromised);
				if (p_C_BPartner_ID != 0)
					pstmt.setInt(index++, p_C_BPartner_ID);
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		return generate(pstmt);
	}	//	doIt
	
	/**
	 * 	Generate Shipments
	 * 	@param pstmt Order Query
	 *	@return info
	 */
	private String generate (PreparedStatement pstmt)
	{

		ResultSet rs = null;
		try
		{
			rs = pstmt.executeQuery ();
			while (rs.next ())		//	Order
			{
				MOrder order = new MOrder (getCtx(), rs, get_TrxName());
				statusUpdate(Msg.getMsg(getCtx(), "Processing") + " " + order.getDocumentInfo());
				
				//	New Header different Shipper, Shipment Location
				if (!p_ConsolidateDocument 
					|| (m_shipment != null 
					&& (m_shipment.getC_BPartner_Location_ID() != order.getC_BPartner_Location_ID()
						|| m_shipment.getM_Shipper_ID() != order.getM_Shipper_ID() )))
					completeShipment();
				if (log.isLoggable(Level.FINE)) log.fine("check: " + order + " - DeliveryRule=" + order.getDeliveryRule());
				//
				Timestamp minGuaranteeDate = m_movementDate;
				boolean completeOrder = MOrder.DELIVERYRULE_CompleteOrder.equals(order.getDeliveryRule());
				//	OrderLine WHERE
				StringBuilder where = new StringBuilder(" AND M_Warehouse_ID=").append(p_M_Warehouse_ID);
				if (p_DatePromised != null)
					where.append(" AND (TRUNC(DatePromised)<=").append(DB.TO_DATE(p_DatePromised, true))
						.append(" OR DatePromised IS NULL)");		
				//	Exclude Auto Delivery if not Force
				if (!MOrder.DELIVERYRULE_Force.equals(order.getDeliveryRule()))
					where.append(" AND (C_OrderLine.M_Product_ID IS NULL")
						.append(" OR EXISTS (SELECT * FROM M_Product p ")
						.append("WHERE C_OrderLine.M_Product_ID=p.M_Product_ID")
						.append(" AND IsExcludeAutoDelivery='N'))");
				//	Exclude Unconfirmed
				if (!p_IsUnconfirmedInOut)
					where.append(" AND NOT EXISTS (SELECT * FROM M_InOutLine iol")
							.append(" INNER JOIN M_InOut io ON (iol.M_InOut_ID=io.M_InOut_ID) ")
								.append("WHERE iol.C_OrderLine_ID=C_OrderLine.C_OrderLine_ID AND io.DocStatus IN ('DR','IN','IP','WC'))");
				//	Deadlock Prevention - Order by M_Product_ID
				MOrderLine[] lines = order.getLines (where.toString(), "C_BPartner_Location_ID, M_Product_ID, Line");
				for (int i = 0; i < lines.length; i++)
				{
					MOrderLine line = lines[i];
					if (line.getM_Warehouse_ID() != p_M_Warehouse_ID)
						continue;
					if (log.isLoggable(Level.FINE)) log.fine("check: " + line);
					BigDecimal onHand = Env.ZERO;
					BigDecimal toDeliver = line.getQtyOrdered()
						.subtract(line.getQtyDelivered());
					MProduct product = line.getProduct();
					//	Nothing to Deliver
					if (product != null && toDeliver.signum() == 0)
						continue;
					
					// or it's a charge - Bug#: 1603966 
					if (line.getC_Charge_ID()!=0 && toDeliver.signum() == 0)
						continue;
					
					//	Check / adjust for confirmations
					BigDecimal unconfirmedShippedQty = Env.ZERO;
					if (p_IsUnconfirmedInOut && product != null && toDeliver.signum() != 0)
					{
						String where2 = "EXISTS (SELECT * FROM M_InOut io WHERE io.M_InOut_ID=M_InOutLine.M_InOut_ID AND io.DocStatus IN ('DR','IN','IP','WC'))";
						MInOutLine[] iols = MInOutLine.getOfOrderLine(getCtx(), 
							line.getC_OrderLine_ID(), where2, null);
						for (int j = 0; j < iols.length; j++) 
							unconfirmedShippedQty = unconfirmedShippedQty.add(iols[j].getMovementQty());
						StringBuilder logInfo = new StringBuilder("Unconfirmed Qty=").append(unconfirmedShippedQty) 
							.append(" - ToDeliver=").append(toDeliver).append("->");					
						toDeliver = toDeliver.subtract(unconfirmedShippedQty);
						logInfo.append(toDeliver);
						if (toDeliver.signum() < 0)
						{
							toDeliver = Env.ZERO;
							logInfo.append(" (set to 0)");
						}
						//	Adjust On Hand
						onHand = onHand.subtract(unconfirmedShippedQty);
						if (log.isLoggable(Level.FINE)) log.fine(logInfo.toString());
					}
					
					//	Comments & lines w/o product & services
					if ((product == null || !product.isStocked())
						&& (line.getQtyOrdered().signum() == 0 	//	comments
							|| toDeliver.signum() != 0))		//	lines w/o product
					{
						if (!MOrder.DELIVERYRULE_CompleteOrder.equals(order.getDeliveryRule()))	//	printed later
							createLine (order, line, toDeliver, null, false);
						continue;
					}
					if (product == null)
					{
						continue;
					}

					//	Stored Product
					String MMPolicy = product.getMMPolicy();

					MStorageOnHand[] storages = getStorages(line.getM_Warehouse_ID(),
							 line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							 minGuaranteeDate, MClient.MMPOLICY_FiFo.equals(MMPolicy));
					
					for (int j = 0; j < storages.length; j++)
					{
						MStorageOnHand storage = storages[j];
						onHand = onHand.add(storage.getQtyOnHand());
					}
					boolean fullLine = onHand.compareTo(toDeliver) >= 0
						|| toDeliver.signum() < 0;
					
					//	Complete Order
					if (completeOrder && !fullLine)
					{
						if (log.isLoggable(Level.FINE)) log.fine("Failed CompleteOrder - OnHand=" + onHand 
							+ " (Unconfirmed=" + unconfirmedShippedQty
							+ "), ToDeliver=" + toDeliver + " - " + line);
						completeOrder = false;
						break;
					}
					//	Complete Line
					else if (fullLine && MOrder.DELIVERYRULE_CompleteLine.equals(order.getDeliveryRule()))
					{
						if (log.isLoggable(Level.FINE)) log.fine("CompleteLine - OnHand=" + onHand 
							+ " (Unconfirmed=" + unconfirmedShippedQty
							+ ", ToDeliver=" + toDeliver + " - " + line);
						//	
						createLine (order, line, toDeliver, storages, false);
					}
					//	Availability
					else if (MOrder.DELIVERYRULE_Availability.equals(order.getDeliveryRule())
						&& (onHand.signum() > 0
							|| toDeliver.signum() < 0))
					{
						BigDecimal deliver = toDeliver;
						if (deliver.compareTo(onHand) > 0)
							deliver = onHand;
						if (log.isLoggable(Level.FINE)) log.fine("Available - OnHand=" + onHand 
							+ " (Unconfirmed=" + unconfirmedShippedQty
							+ "), ToDeliver=" + toDeliver 
							+ ", Delivering=" + deliver + " - " + line);
						//	
						createLine (order, line, deliver, storages, false);
					}
					//	Force
					else if (MOrder.DELIVERYRULE_Force.equals(order.getDeliveryRule()))
					{
						BigDecimal deliver = toDeliver;
						if (log.isLoggable(Level.FINE)) log.fine("Force - OnHand=" + onHand 
							+ " (Unconfirmed=" + unconfirmedShippedQty
							+ "), ToDeliver=" + toDeliver 
							+ ", Delivering=" + deliver + " - " + line);
						//	
						createLine (order, line, deliver, storages, true);
					}
					//	Manual
					else if (MOrder.DELIVERYRULE_Manual.equals(order.getDeliveryRule())) {
						if (log.isLoggable(Level.FINE)) log.fine("Manual - OnHand=" + onHand 
							+ " (Unconfirmed=" + unconfirmedShippedQty
							+ ") - " + line);
					} else {
						if (log.isLoggable(Level.FINE)) log.fine("Failed: " + order.getDeliveryRule() + " - OnHand=" + onHand 
								+ " (Unconfirmed=" + unconfirmedShippedQty
								+ "), ToDeliver=" + toDeliver + " - " + line);
					}
				}	//	for all order lines
				
				//	Complete Order successful
				if (completeOrder && MOrder.DELIVERYRULE_CompleteOrder.equals(order.getDeliveryRule()))
				{
					for (int i = 0; i < lines.length; i++)
					{
						MOrderLine line = lines[i];
						if (line.getM_Warehouse_ID() != p_M_Warehouse_ID)
							continue;
						MProduct product = line.getProduct();
						BigDecimal toDeliver = line.getQtyOrdered().subtract(line.getQtyDelivered());
						//
						MStorageOnHand[] storages = null;
						if (product != null && product.isStocked())
						{
							String MMPolicy = product.getMMPolicy();
							storages = getStorages(line.getM_Warehouse_ID(), 
								line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								minGuaranteeDate, MClient.MMPOLICY_FiFo.equals(MMPolicy));
						}
						//	
						createLine (order, line, toDeliver, storages, false);
					}
				}
				m_line += 1000;
			}	//	while order
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		completeShipment();
		StringBuilder msgreturn = new StringBuilder("@Created@ = ").append(m_created);
		return msgreturn.toString();
	}	//	generate
	
	
	
	/**************************************************************************
	 * 	Create Line
	 *	@param order order
	 *	@param orderLine line
	 *	@param qty qty
	 *	@param storages storage info
	 *	@param force force delivery
	 */
	private void createLine (MOrder order, MOrderLine orderLine, BigDecimal qty, 
		MStorageOnHand[] storages, boolean force)
	{
		//	Complete last Shipment - can have multiple shipments
		if (m_lastC_BPartner_Location_ID != orderLine.getC_BPartner_Location_ID() )
			completeShipment();
		m_lastC_BPartner_Location_ID = orderLine.getC_BPartner_Location_ID();
		//	Create New Shipment
		if (m_shipment == null)
		{
			m_shipment = new MInOut (order, 0, m_movementDate);
			m_shipment.setM_Warehouse_ID(orderLine.getM_Warehouse_ID());	//	sets Org too
			if (order.getC_BPartner_ID() != orderLine.getC_BPartner_ID())
				m_shipment.setC_BPartner_ID(orderLine.getC_BPartner_ID());
			if (order.getC_BPartner_Location_ID() != orderLine.getC_BPartner_Location_ID())
				m_shipment.setC_BPartner_Location_ID(orderLine.getC_BPartner_Location_ID());
			if (!m_shipment.save())
				throw new IllegalStateException("Could not create Shipment");
		}
		//	Non Inventory Lines
		if (storages == null)
		{
			MInOutLine line = new MInOutLine (m_shipment);
			line.setOrderLine(orderLine, 0, Env.ZERO);
			line.setQty(qty);	//	Correct UOM
			if (orderLine.getQtyEntered().compareTo(orderLine.getQtyOrdered()) != 0)
				line.setQtyEntered(qty
					.multiply(orderLine.getQtyEntered())
					.divide(orderLine.getQtyOrdered(), 12, RoundingMode.HALF_UP));
			line.setLine(m_line + orderLine.getLine());
			if (!line.save())
				throw new IllegalStateException("Could not create Shipment Line");
			if (log.isLoggable(Level.FINE)) log.fine(line.toString());
			return;
		}
		
	
		//	Inventory Lines
		ArrayList<MInOutLine> list = new ArrayList<MInOutLine>();
		BigDecimal toDeliver = qty;
		for (int i = 0; i < storages.length; i++)
		{
			MStorageOnHand storage = storages[i];
			BigDecimal deliver = toDeliver;
			//skip negative storage record
			if (storage.getQtyOnHand().signum() < 0) 
				continue;
			
			//	Not enough On Hand
			if (deliver.compareTo(storage.getQtyOnHand()) > 0 
				&& storage.getQtyOnHand().signum() >= 0)		//	positive storage
			{
				if (!force	//	Adjust to OnHand Qty  
					|| (force && i+1 != storages.length))	//	if force not on last location
					deliver = storage.getQtyOnHand();
			}
			if (deliver.signum() == 0)	//	zero deliver
				continue;
			int M_Locator_ID = storage.getM_Locator_ID();
			//
			MInOutLine line = null;
			if (orderLine.getM_AttributeSetInstance_ID() == 0)      //      find line with Locator
			{
				for (int ll = 0; ll < list.size(); ll++)
				{
					MInOutLine test = (MInOutLine)list.get(ll);
					if (test.getM_Locator_ID() == M_Locator_ID && test.getM_AttributeSetInstance_ID() == 0)
					{
						line = test;
						break;
					}
				}
			}
			if (line == null)	//	new line
			{
				line = new MInOutLine (m_shipment);
				line.setOrderLine(orderLine, M_Locator_ID, order.isSOTrx() ? deliver : Env.ZERO);
				line.setQty(deliver);
				list.add(line);
			}
			else				//	existing line
				line.setQty(line.getMovementQty().add(deliver));
			if (orderLine.getQtyEntered().compareTo(orderLine.getQtyOrdered()) != 0)
				line.setQtyEntered(line.getMovementQty().multiply(orderLine.getQtyEntered())
					.divide(orderLine.getQtyOrdered(), 12, RoundingMode.HALF_UP));
			line.setLine(m_line + orderLine.getLine());
			if (!line.save())
				throw new IllegalStateException("Could not create Shipment Line");
			if (log.isLoggable(Level.FINE)) log.fine("ToDeliver=" + qty + "/" + deliver + " - " + line);
			toDeliver = toDeliver.subtract(deliver);
			//      Temp adjustment, actual update happen in MInOut.completeIt - just in memory - not saved
			storage.setQtyOnHand(storage.getQtyOnHand().subtract(deliver));
			//
			if (toDeliver.signum() == 0)
				break;
		}		
		if (toDeliver.signum() != 0)
		{	 
			if (!force)
			{
				throw new IllegalStateException("Not All Delivered - Remainder=" + toDeliver);
			}
			else 
			{
				
				 MInOutLine line = new MInOutLine (m_shipment);
				 line.setOrderLine(orderLine, 0, order.isSOTrx() ? toDeliver : Env.ZERO);
				 line.setQty(toDeliver);
				 if (orderLine.getQtyEntered().compareTo(orderLine.getQtyOrdered()) != 0)
					 line.setQtyEntered(line.getMovementQty().multiply(orderLine.getQtyEntered())
						 .divide(orderLine.getQtyOrdered(), 12, RoundingMode.HALF_UP));
				 line.setLine(m_line + orderLine.getLine());
			     if (!line.save())
					 throw new IllegalStateException("Could not create Shipment Line");
					 

			}
		}	
	}	//	createLine

	
	/**
	 * 	Get Storages
	 *	@param M_Warehouse_ID
	 *	@param M_Product_ID
	 *	@param M_AttributeSetInstance_ID
	 *	@param minGuaranteeDate
	 *	@param FiFo
	 *	@return storages
	 */
	private MStorageOnHand[] getStorages(int M_Warehouse_ID, 
			 int M_Product_ID, int M_AttributeSetInstance_ID,
			  Timestamp minGuaranteeDate, boolean FiFo)
	{
		m_lastPP = new SParameter(M_Warehouse_ID, 
		M_Product_ID, M_AttributeSetInstance_ID,
			minGuaranteeDate, FiFo);
		//
		m_lastStorages = m_map.get(m_lastPP); 
		
		if (m_lastStorages == null)
		{
			MStorageOnHand[] tmpStorages = MStorageOnHand.getWarehouse(getCtx(), 
				M_Warehouse_ID, M_Product_ID, M_AttributeSetInstance_ID,
				minGuaranteeDate, FiFo,false, 0, get_TrxName());

			/* IDEMPIERE-2668 - filter just locators enabled for shipping */
			List<MStorageOnHand> m_storagesForShipping = new ArrayList<MStorageOnHand>();
			for (MStorageOnHand soh : tmpStorages) {
				MLocator loc = MLocator.get(getCtx(), soh.getM_Locator_ID());
				MLocatorType lt = null;
				if (loc.getM_LocatorType_ID() > 0)
					lt = MLocatorType.get(getCtx(), loc.getM_LocatorType_ID());
				if (lt == null || lt.isAvailableForShipping())
					m_storagesForShipping.add(soh);
			}
			m_lastStorages = new MStorageOnHand[m_storagesForShipping.size()];
			m_storagesForShipping.toArray(m_lastStorages);

			m_map.put(m_lastPP, m_lastStorages);
		}
		return m_lastStorages;
	}	//	getStorages
	
	
	/**
	 * 	Complete Shipment
	 */
	private void completeShipment()
	{
		if (m_shipment != null)
		{
			if (!DocAction.ACTION_None.equals(p_docAction))
			{
				//	Fails if there is a confirmation
				if (!m_shipment.processIt(p_docAction)) {
					log.warning("Failed: " + m_shipment);
					throw new IllegalStateException("Shipment Process Failed: " + m_shipment + " - " + m_shipment.getProcessMsg());
				}
			}
			m_shipment.saveEx();
			String message = Msg.parseTranslation(getCtx(), "@ShipmentProcessed@ " + m_shipment.getDocumentNo());
			addBufferLog(m_shipment.getM_InOut_ID(), m_shipment.getMovementDate(), null, message, m_shipment.get_Table_ID(),m_shipment.getM_InOut_ID());
			m_created++;
			
			//reset storage cache as MInOut.completeIt will update m_storage
			m_map = new HashMap<SParameter,MStorageOnHand[]>();
			m_lastPP = null;
			m_lastStorages = null;
		}
		m_shipment = null;
		m_line = 0;
	}	//	completeOrder
	
	/**
	 * 	InOutGenerate Parameter
	 */
	static class SParameter
	{
		/**
		 * 	Parameter
		 *	@param p_Warehouse_ID warehouse
		 *	@param p_Product_ID 
		 *	@param p_AttributeSetInstance_ID 
		 *	@param p_minGuaranteeDate
		 *	@param p_FiFo
		 */
		protected SParameter (int p_Warehouse_ID, 
			int p_Product_ID, int p_AttributeSetInstance_ID, 
			Timestamp p_minGuaranteeDate,boolean p_FiFo)
		{
			this.M_Warehouse_ID = p_Warehouse_ID;
			this.M_Product_ID = p_Product_ID;
			this.M_AttributeSetInstance_ID = p_AttributeSetInstance_ID; 
			this.minGuaranteeDate = p_minGuaranteeDate;
			this.FiFo = p_FiFo;	
		}
		/** Warehouse		*/
		public int M_Warehouse_ID;
		/** Product			*/
		public int M_Product_ID;
		/** ASI				*/
		public int M_AttributeSetInstance_ID;
		/** AS				*/
		public int M_AttributeSet_ID;
		/** All instances	*/
		public boolean allAttributeInstances;
		/** Mon Guarantee Date	*/
		public Timestamp minGuaranteeDate;
		/** FiFo			*/
		public boolean FiFo;

		/**
		 * 	Equals
		 *	@param obj
		 *	@return true if equal
		 */
		public boolean equals (Object obj)
		{
			if (obj != null && obj instanceof SParameter)
			{
				SParameter cmp = (SParameter)obj;
				boolean eq = cmp.M_Warehouse_ID == M_Warehouse_ID
					&& cmp.M_Product_ID == M_Product_ID
					&& cmp.M_AttributeSetInstance_ID == M_AttributeSetInstance_ID
					&& cmp.M_AttributeSet_ID == M_AttributeSet_ID
					&& cmp.allAttributeInstances == allAttributeInstances
					&& cmp.FiFo == FiFo;
				if (eq)
				{
					if (cmp.minGuaranteeDate == null && minGuaranteeDate == null)
						;
					else if (cmp.minGuaranteeDate != null && minGuaranteeDate != null
						&& cmp.minGuaranteeDate.equals(minGuaranteeDate))
						;
					else
						eq = false;
				}
				return eq;
			}
			return false;
		}	//	equals
		
		/**
		 * 	hashCode
		 *	@return hash code
		 */
		public int hashCode ()
		{
			long hash = M_Warehouse_ID
				+ (M_Product_ID * 2)
				+ (M_AttributeSetInstance_ID * 3)
				+ (M_AttributeSet_ID * 4);

			if (allAttributeInstances)
				hash *= -1;
			if (FiFo)	
				hash *= -2;
			if (hash < 0)
				hash = -hash + 7;
			while (hash > Integer.MAX_VALUE)
				hash -= Integer.MAX_VALUE;
			//
			if (minGuaranteeDate != null)
			{
				hash += minGuaranteeDate.hashCode();
				while (hash > Integer.MAX_VALUE)
					hash -= Integer.MAX_VALUE;
			}
				
			return (int)hash;
		}	//	hashCode
		
	}	//	Parameter
	
}	//	InOutGenerate
