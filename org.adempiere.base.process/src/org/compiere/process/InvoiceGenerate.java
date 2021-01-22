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
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MCurrency;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MInvoicePaySchedule;
import org.compiere.model.MInvoiceSchedule;
import org.compiere.model.MLocation;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MOrderPaySchedule;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 *	Generate Invoices
 *	
 *  @author Jorg Janke
 *  @version $Id: InvoiceGenerate.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class InvoiceGenerate extends SvrProcess
{
	/**	Manual Selection		*/
	private boolean 	p_Selection = false;
	/**	Date Invoiced			*/
	private Timestamp	p_DateInvoiced = null;
	/**	Org						*/
	private int			p_AD_Org_ID = 0;
	/** BPartner				*/
	private int			p_C_BPartner_ID = 0;
	/** Order					*/
	private int			p_C_Order_ID = 0;
	/** Shipment				*/
	private int			p_M_InOut_ID = 0;
	/** Consolidate				*/
	private boolean		p_ConsolidateDocument = true;
	/** Invoice Document Action	*/
	private String		p_docAction = DocAction.ACTION_Complete;
	
	/**	The current Invoice	*/
	private MInvoice 	m_invoice = null;
	/**	The current Shipment	*/
	private MInOut	 	m_ship = null;
	/** Numner of Invoices		*/
	private int			m_created = 0;
	/**	Line Number				*/
	private int			m_line = 0;
	/**	Business Partner		*/
	private MBPartner	m_bp = null;
	/**	Minimum Amount to Invoice */
	private BigDecimal p_MinimumAmt = null;
	/**	Minimum Amount to Invoice according to Invoice Schedule */
	private BigDecimal p_MinimumAmtInvSched = null;
	/**	Per Invoice Savepoint */
	private Savepoint m_savepoint = null;

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
			else if (name.equals("Selection"))
				p_Selection = "Y".equals(para[i].getParameter());
			else if (name.equals("DateInvoiced"))
				p_DateInvoiced = (Timestamp)para[i].getParameter();
			else if (name.equals("AD_Org_ID"))
				p_AD_Org_ID = para[i].getParameterAsInt();
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = para[i].getParameterAsInt();
			else if (name.equals("C_Order_ID"))
				p_C_Order_ID = para[i].getParameterAsInt();
			else if (name.equals("M_InOut_ID"))
				p_M_InOut_ID = para[i].getParameterAsInt();
			else if (name.equals("ConsolidateDocument"))
				p_ConsolidateDocument = "Y".equals(para[i].getParameter());
			else if (name.equals("DocAction"))
				p_docAction = (String)para[i].getParameter();
			else if (name.equals("MinimumAmt"))
				p_MinimumAmt = para[i].getParameterAsBigDecimal();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}

		//	Login Date
		if (p_DateInvoiced == null)
			p_DateInvoiced = Env.getContextAsDate(getCtx(), Env.DATE);
		if (p_DateInvoiced == null)
			p_DateInvoiced = new Timestamp(System.currentTimeMillis());

		//	DocAction check
		if (!DocAction.ACTION_Complete.equals(p_docAction))
			p_docAction = DocAction.ACTION_Prepare;
	}	//	prepare

	/**
	 * 	Generate Invoices
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("Selection=" + p_Selection + ", DateInvoiced=" + p_DateInvoiced
			+ ", AD_Org_ID=" + p_AD_Org_ID + ", C_BPartner_ID=" + p_C_BPartner_ID
			+ ", C_Order_ID=" + p_C_Order_ID + ", DocAction=" + p_docAction 
			+ ", Consolidate=" + p_ConsolidateDocument);
		//
		StringBuilder sql = null;
		if (p_Selection)	//	VInvoiceGen
		{
			sql = new StringBuilder("SELECT C_Order.* FROM C_Order, T_Selection ")
				.append("WHERE C_Order.DocStatus='CO' AND C_Order.IsSOTrx='Y' ")
				.append("AND C_Order.C_Order_ID = T_Selection.T_Selection_ID ")
				.append("AND T_Selection.AD_PInstance_ID=? ")
				.append("ORDER BY C_Order.AD_Org_ID, C_Order.M_Warehouse_ID, C_Order.PriorityRule, C_Order.C_BPartner_ID, C_Order.Bill_Location_ID, C_Order.C_Order_ID");
		}
		else
		{
			sql = new StringBuilder("SELECT * FROM C_Order o ")
				.append("WHERE DocStatus IN('CO','CL') AND IsSOTrx='Y'");
			if (p_AD_Org_ID != 0)
				sql.append(" AND AD_Org_ID=?");
			if (p_C_BPartner_ID != 0)
				sql.append(" AND C_BPartner_ID=?");
			if (p_C_Order_ID != 0)
				sql.append(" AND C_Order_ID=?");
			//
			sql.append(" AND EXISTS (SELECT * FROM C_OrderLine ol ")
					.append("WHERE o.C_Order_ID=ol.C_Order_ID AND ol.QtyOrdered<>ol.QtyInvoiced ");
			//
			if (p_M_InOut_ID != 0)
				sql.append(" AND EXISTS (SELECT '1' FROM M_InOutLine iol WHERE iol.C_OrderLine_ID=ol.C_OrderLine_ID AND iol.M_InOut_ID=?) ");
			//
			sql.append(") AND o.C_DocType_ID IN (SELECT C_DocType_ID FROM C_DocType ")
					.append("WHERE DocBaseType='SOO' AND DocSubTypeSO NOT IN ('ON','OB','WR')) ")
				.append("ORDER BY AD_Org_ID, M_Warehouse_ID, PriorityRule, C_BPartner_ID, Bill_Location_ID, C_Order_ID");
		}
	//	sql += " FOR UPDATE";
		
		PreparedStatement pstmt = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), get_TrxName());
			int index = 1;
			if (p_Selection) 
			{
				pstmt.setInt(index, getAD_PInstance_ID());
			}
			else
			{
				if (p_AD_Org_ID != 0)
					pstmt.setInt(index++, p_AD_Org_ID);
				if (p_C_BPartner_ID != 0)
					pstmt.setInt(index++, p_C_BPartner_ID);
				if (p_C_Order_ID != 0)
					pstmt.setInt(index++, p_C_Order_ID);
				if (p_M_InOut_ID != 0)
					pstmt.setInt(index++, p_M_InOut_ID);
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
	 * 	@param pstmt order query 
	 *	@return info
	 */
	private String generate (PreparedStatement pstmt)
	{
		ResultSet rs = null;
		try
		{
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				p_MinimumAmtInvSched = null;
				MOrder order = new MOrder (getCtx(), rs, get_TrxName());
				StringBuilder msgsup = new StringBuilder(Msg.getMsg(getCtx(), "Processing")).append(" ").append(order.getDocumentInfo());
				statusUpdate(msgsup.toString());
				
				//	New Invoice Location
				if (!p_ConsolidateDocument 
					|| (m_invoice != null 
					&& m_invoice.getC_BPartner_Location_ID() != order.getBill_Location_ID()) )
					completeInvoice();
				boolean completeOrder = MOrder.INVOICERULE_AfterOrderDelivered.equals(order.getInvoiceRule());
				
				//	Schedule After Delivery
				boolean doInvoice = false;
				if (MOrder.INVOICERULE_CustomerScheduleAfterDelivery.equals(order.getInvoiceRule()))
				{
					m_bp = new MBPartner (getCtx(), order.getBill_BPartner_ID(), null);
					if (m_bp.getC_InvoiceSchedule_ID() == 0)
					{
						log.warning("BPartner has no Schedule - set to After Delivery");
						order.setInvoiceRule(MOrder.INVOICERULE_AfterDelivery);
						order.saveEx();
					}
					else
					{
						MInvoiceSchedule is = MInvoiceSchedule.get(getCtx(), m_bp.getC_InvoiceSchedule_ID(), get_TrxName());
						if (is.canInvoice(order.getDateOrdered())) {
							if (is.isAmount() && is.getAmt() != null)
							p_MinimumAmtInvSched = is.getAmt();
							doInvoice = true;
						} else {
							continue;
						}
					}
				}	//	Schedule
				
				//	After Delivery
				if (doInvoice || MOrder.INVOICERULE_AfterDelivery.equals(order.getInvoiceRule()))
				{
					MInOut[] shipments = order.getShipments();
					for (int i = 0; i < shipments.length; i++)
					{
						MInOut ship = shipments[i];
						if (!ship.isComplete()		//	ignore incomplete or reversals 
							|| ship.getDocStatus().equals(MInOut.DOCSTATUS_Reversed))
							continue;
						MInOutLine[] shipLines = ship.getLines(false);
						for (int j = 0; j < shipLines.length; j++)
						{
							MInOutLine shipLine = shipLines[j];
							if (!order.isOrderLine(shipLine.getC_OrderLine_ID()))
								continue;
							if (!shipLine.isInvoiced())
								createLine (order, ship, shipLine);
						}
						m_line += 1000;
					}
				}
				//	After Order Delivered, Immediate
				else
				{
					MOrderLine[] oLines = order.getLines(true, null);
					for (int i = 0; i < oLines.length; i++)
					{
						MOrderLine oLine = oLines[i];
						BigDecimal toInvoice = oLine.getQtyOrdered().subtract(oLine.getQtyInvoiced());
						if (toInvoice.compareTo(Env.ZERO) == 0 && oLine.getM_Product_ID() != 0)
							continue;
						@SuppressWarnings("unused")
						BigDecimal notInvoicedShipment = oLine.getQtyDelivered().subtract(oLine.getQtyInvoiced());
						//
						boolean fullyDelivered = oLine.getQtyOrdered().compareTo(oLine.getQtyDelivered()) == 0;
					
						//	Complete Order
						if (completeOrder && !fullyDelivered)
						{
							if (log.isLoggable(Level.FINE)) log.fine("Failed CompleteOrder - " + oLine);
							addBufferLog(0, null, null,"Failed CompleteOrder - " + oLine,oLine.get_Table_ID(),oLine.getC_OrderLine_ID()); // Elaine 2008/11/25
							completeOrder = false;
							break;
						}
						//	Immediate
						else if (MOrder.INVOICERULE_Immediate.equals(order.getInvoiceRule()))
						{
							if (log.isLoggable(Level.FINE)) log.fine("Immediate - ToInvoice=" + toInvoice + " - " + oLine);
							BigDecimal qtyEntered = toInvoice;
							//	Correct UOM for QtyEntered
							if (oLine.getQtyEntered().compareTo(oLine.getQtyOrdered()) != 0)
								qtyEntered = toInvoice
									.multiply(oLine.getQtyEntered())
									.divide(oLine.getQtyOrdered(), 12, RoundingMode.HALF_UP);
							createLine (order, oLine, toInvoice, qtyEntered);
						}
						else if (!completeOrder)
						{
							if (log.isLoggable(Level.FINE)) log.fine("Failed: " + order.getInvoiceRule() 
								+ " - ToInvoice=" + toInvoice + " - " + oLine);
							addBufferLog(0, null, null,"Failed: " + order.getInvoiceRule() 
								+ " - ToInvoice=" + toInvoice + " - " + oLine,oLine.get_Table_ID(),oLine.getC_OrderLine_ID());
						}
					}	//	for all order lines
					if (MOrder.INVOICERULE_Immediate.equals(order.getInvoiceRule()))
						m_line += 1000;
				}
				
				//	Complete Order successful
				if (completeOrder && MOrder.INVOICERULE_AfterOrderDelivered.equals(order.getInvoiceRule()))
				{
					MInOut[] shipments = order.getShipments();
					for (int i = 0; i < shipments.length; i++)
					{
						MInOut ship = shipments[i];
						if (!ship.isComplete()		//	ignore incomplete or reversals 
							|| ship.getDocStatus().equals(MInOut.DOCSTATUS_Reversed))
							continue;
						MInOutLine[] shipLines = ship.getLines(false);
						for (int j = 0; j < shipLines.length; j++)
						{
							MInOutLine shipLine = shipLines[j];
							if (!order.isOrderLine(shipLine.getC_OrderLine_ID()))
								continue;
							if (!shipLine.isInvoiced())
								createLine (order, ship, shipLine);
						}
						m_line += 1000;
					}
				}	//	complete Order
			}	//	for all orders
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
		completeInvoice();
		StringBuilder msgreturn = new StringBuilder("@Created@ = ").append(m_created);
		return msgreturn.toString();
	}	//	generate
	
	
	
	/**************************************************************************
	 * 	Create Invoice Line from Order Line
	 *	@param order order
	 *	@param orderLine line
	 *	@param qtyInvoiced qty
	 *	@param qtyEntered qty
	 */
	private void createLine (MOrder order, MOrderLine orderLine, 
		BigDecimal qtyInvoiced, BigDecimal qtyEntered)
	{
		if (m_invoice == null)
		{
			try {
				if (m_savepoint != null)
					Trx.get(get_TrxName(), false).releaseSavepoint(m_savepoint);
				m_savepoint = Trx.get(get_TrxName(), false).setSavepoint(null);
			} catch (SQLException e) {
				throw new AdempiereException(e);
			}
			m_invoice = new MInvoice (order, 0, p_DateInvoiced);
			if (!m_invoice.save())
				throw new IllegalStateException("Could not create Invoice (o)");
		}
		//	
		MInvoiceLine line = new MInvoiceLine (m_invoice);
		line.setOrderLine(orderLine);
		line.setQtyInvoiced(qtyInvoiced);
		line.setQtyEntered(qtyEntered);
		line.setLine(m_line + orderLine.getLine());
		if (!line.save())
			throw new IllegalStateException("Could not create Invoice Line (o)");
		if (log.isLoggable(Level.FINE)) log.fine(line.toString());
	}	//	createLine

	/**
	 * 	Create Invoice Line from Shipment
	 *	@param order order
	 *	@param ship shipment header
	 *	@param sLine shipment line
	 */
	private void createLine (MOrder order, MInOut ship, MInOutLine sLine)
	{
		if (m_invoice == null)
		{
			try {
				if (m_savepoint != null)
					Trx.get(get_TrxName(), false).releaseSavepoint(m_savepoint);
				m_savepoint = Trx.get(get_TrxName(), false).setSavepoint(null);
			} catch (SQLException e) {
				throw new AdempiereException(e);
			}
			m_invoice = new MInvoice (order, 0, p_DateInvoiced);
			if (!m_invoice.save())
				throw new IllegalStateException("Could not create Invoice (s)");
		}
		//	Create Shipment Comment Line
		if (m_ship == null 
			|| m_ship.getM_InOut_ID() != ship.getM_InOut_ID())
		{
			MDocType dt = MDocType.get(getCtx(), ship.getC_DocType_ID());
			if (m_bp == null || m_bp.getC_BPartner_ID() != ship.getC_BPartner_ID())
				m_bp = new MBPartner (getCtx(), ship.getC_BPartner_ID(), get_TrxName());
			
			//	Reference: Delivery: 12345 - 12.12.12
			MClient client = MClient.get(getCtx(), order.getAD_Client_ID ());
			String AD_Language = client.getAD_Language();
			if (client.isMultiLingualDocument() && m_bp.getAD_Language() != null)
				AD_Language = m_bp.getAD_Language();
			if (AD_Language == null)
				AD_Language = Language.getBaseAD_Language();
			java.text.SimpleDateFormat format = DisplayType.getDateFormat 
				(DisplayType.Date, Language.getLanguage(AD_Language));
			StringBuilder reference = new StringBuilder().append(dt.getPrintName(m_bp.getAD_Language()))
				.append(": ").append(ship.getDocumentNo()) 
				.append(" - ").append(format.format(ship.getMovementDate()));
			m_ship = ship;
			//
			MInvoiceLine line = new MInvoiceLine (m_invoice);
			line.setIsDescription(true);
			line.setDescription(reference.toString());
			line.setLine(m_line + sLine.getLine() - 2);
			if (!line.save())
				throw new IllegalStateException("Could not create Invoice Comment Line (sh)");
			//	Optional Ship Address if not Bill Address
			if (order.getBill_Location_ID() != ship.getC_BPartner_Location_ID())
			{
				MLocation addr = MLocation.getBPLocation(getCtx(), ship.getC_BPartner_Location_ID(), null);
				line = new MInvoiceLine (m_invoice);
				line.setIsDescription(true);
				line.setDescription(addr.toString());
				line.setLine(m_line + sLine.getLine() - 1);
				if (!line.save())
					throw new IllegalStateException("Could not create Invoice Comment Line 2 (sh)");
			}
		}
		//	
		MInvoiceLine line = new MInvoiceLine (m_invoice);
		line.setShipLine(sLine);
		if (sLine.sameOrderLineUOM())
			line.setQtyEntered(sLine.getQtyEntered());
		else
			line.setQtyEntered(sLine.getMovementQty());
		line.setQtyInvoiced(sLine.getMovementQty());
		line.setLine(m_line + sLine.getLine());
		if (!line.save())
			throw new IllegalStateException("Could not create Invoice Line (s)");
		//	Link
		sLine.setIsInvoiced(true);
		if (!sLine.save())
			throw new IllegalStateException("Could not update Shipment Line");
		
		if (log.isLoggable(Level.FINE)) log.fine(line.toString());
	}	//	createLine

	
	/**
	 * 	Complete Invoice
	 */
	private void completeInvoice()
	{
		if (m_invoice != null)
		{
			MOrder order = new MOrder(getCtx(), m_invoice.getC_Order_ID(), get_TrxName());
			if (order != null) {
				m_invoice.setPaymentRule(order.getPaymentRule());
				m_invoice.setC_PaymentTerm_ID(order.getC_PaymentTerm_ID());
				m_invoice.saveEx();
				m_invoice.load(m_invoice.get_TrxName()); // refresh from DB
				// copy payment schedule from order if invoice doesn't have a current payment schedule
				MOrderPaySchedule[] opss = MOrderPaySchedule.getOrderPaySchedule(getCtx(), order.getC_Order_ID(), 0, get_TrxName());
				MInvoicePaySchedule[] ipss = MInvoicePaySchedule.getInvoicePaySchedule(getCtx(), m_invoice.getC_Invoice_ID(), 0, get_TrxName());
				if (ipss.length == 0 && opss.length > 0) {
					BigDecimal ogt = order.getGrandTotal();
					BigDecimal igt = m_invoice.getGrandTotal();
					BigDecimal percent = Env.ONE;
					if (ogt.compareTo(igt) != 0)
						percent = igt.divide(ogt, 10, RoundingMode.HALF_UP);
					MCurrency cur = MCurrency.get(order.getCtx(), order.getC_Currency_ID());
					int scale = cur.getStdPrecision();
				
					for (MOrderPaySchedule ops : opss) {
						MInvoicePaySchedule ips = new MInvoicePaySchedule(getCtx(), 0, get_TrxName());
						PO.copyValues(ops, ips);
						if (percent != Env.ONE) {
							BigDecimal propDueAmt = ops.getDueAmt().multiply(percent);
							if (propDueAmt.scale() > scale)
								propDueAmt = propDueAmt.setScale(scale, RoundingMode.HALF_UP);
							ips.setDueAmt(propDueAmt);
						}
						ips.setC_Invoice_ID(m_invoice.getC_Invoice_ID());
						ips.setAD_Org_ID(ops.getAD_Org_ID());
						ips.setProcessing(ops.isProcessing());
						ips.setIsActive(ops.isActive());
						ips.saveEx();
					}
					m_invoice.validatePaySchedule();
					m_invoice.saveEx();
				}
			}

			if (     (p_MinimumAmt != null && p_MinimumAmt.signum() != 0
				   && m_invoice.getGrandTotal().compareTo(p_MinimumAmt) < 0)
			    ||   (p_MinimumAmtInvSched != null
				   && m_invoice.getGrandTotal().compareTo(p_MinimumAmtInvSched) < 0)) {

				// minimum amount not reached
				DecimalFormat format = DisplayType.getNumberFormat(DisplayType.Amount);
				String amt = format.format(m_invoice.getGrandTotal().doubleValue());
				String message = Msg.parseTranslation(getCtx(), "@NotInvoicedAmt@ " + amt + " - " + m_invoice.getC_BPartner().getName());
				addLog(message);
				if (m_savepoint != null) {
					try {
						Trx.get(get_TrxName(), false).rollback(m_savepoint);
					} catch (SQLException e) {
						throw new AdempiereException(e);
					}
				} else {
					throw new AdempiereException("No savepoint");
				}

			} else {

				if (!m_invoice.processIt(p_docAction))
				{
					log.warning("completeInvoice - failed: " + m_invoice);
					addBufferLog(0, null, null,"completeInvoice - failed: " + m_invoice,m_invoice.get_Table_ID(),m_invoice.getC_Invoice_ID()); // Elaine 2008/11/25
					throw new IllegalStateException("Invoice Process Failed: " + m_invoice + " - " + m_invoice.getProcessMsg());
					
				}
				m_invoice.saveEx();

				String message = Msg.parseTranslation(getCtx(), "@InvoiceProcessed@ " + m_invoice.getDocumentNo());
				addBufferLog(m_invoice.getC_Invoice_ID(), m_invoice.getDateInvoiced(), null, message, m_invoice.get_Table_ID(), m_invoice.getC_Invoice_ID());
				m_created++;
			}
		}
		m_invoice = null;
		m_ship = null;
		m_line = 0;
	}	//	completeInvoice
	
}	//	InvoiceGenerate
