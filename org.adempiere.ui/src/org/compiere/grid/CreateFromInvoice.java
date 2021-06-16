/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.compiere.grid;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.apps.IStatusBar;
import org.compiere.grid.CreateFrom.DocumentType;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.GridTab;
import org.compiere.model.MCurrency;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MInvoicePaySchedule;
import org.compiere.model.MMatchInv;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MOrderPaySchedule;
import org.compiere.model.MProduct;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.MUOMConversion;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.minigrid.ColumnInfo;

/**
 *  Create Invoice Transactions from PO Orders or Receipt
 *
 *  @author Jorg Janke
 *  @version  $Id: VCreateFromInvoice.java,v 1.4 2006/07/30 00:51:28 jjanke Exp $
 *
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1896947 ] Generate invoice from Order error
 * 			<li>BF [ 2007837 ] VCreateFrom.save() should run in trx
 */
public abstract class CreateFromInvoice extends CreateFrom
{
	/**
	 *  Protected Constructor
	 *  @param mTab MTab
	 */
	public CreateFromInvoice(GridTab mTab)
	{
		super(mTab);
		if (log.isLoggable(Level.INFO)) log.info(mTab.toString());
	}   //  VCreateFromInvoice

	/**
	 *  Dynamic Init
	 *  @return true if initialized
	 */
	public boolean dynInit() throws Exception
	{
		log.config("");
		setTitle(Msg.getElement(Env.getCtx(), "C_Invoice_ID", false) + " .. " + Msg.translate(Env.getCtx(), "CreateFrom"));

		return true;
	}   //  dynInit

	/**
	 * Load PBartner dependent Order/Invoice/Shipment Field.
	 * @param C_BPartner_ID
	 */
	protected ArrayList<KeyNamePair> loadShipmentData (int C_BPartner_ID)
	{
		String isSOTrxParam = isSOTrx ? "Y":"N";
		ArrayList<KeyNamePair> list = new ArrayList<KeyNamePair>();

		//	Display
		StringBuffer display = new StringBuffer("s.DocumentNo||' - '||")
			.append(DB.TO_CHAR("s.MovementDate", DisplayType.Date, Env.getAD_Language(Env.getCtx())));
		//
		StringBuffer sql = new StringBuffer("SELECT s.M_InOut_ID,").append(display)
			.append(" FROM M_InOut s "
			+ "WHERE s.C_BPartner_ID=? AND s.IsSOTrx=? AND s.DocStatus IN ('CL','CO')"
			+ " AND s.M_InOut_ID IN "
				+ "(SELECT sl.M_InOut_ID FROM M_InOutLine sl");
			if(!isSOTrx)
				sql.append(" LEFT OUTER JOIN M_MatchInv mi ON (sl.M_InOutLine_ID=mi.M_InOutLine_ID) "
					+ " JOIN M_InOut s2 ON (sl.M_InOut_ID=s2.M_InOut_ID) "
					+ " WHERE s2.C_BPartner_ID=? AND s2.IsSOTrx=? AND s2.DocStatus IN ('CL','CO') "
					+ " GROUP BY sl.M_InOut_ID,sl.MovementQty,mi.M_InOutLine_ID"
					+ " HAVING (sl.MovementQty<>SUM(mi.Qty) AND mi.M_InOutLine_ID IS NOT NULL)"
					+ " OR mi.M_InOutLine_ID IS NULL ");
			else
				sql.append(" INNER JOIN M_InOut s2 ON (sl.M_InOut_ID=s2.M_InOut_ID)"
					+ " LEFT JOIN C_InvoiceLine il ON sl.M_InOutLine_ID = il.M_InOutLine_ID"
					+ " WHERE s2.C_BPartner_ID=? AND s2.IsSOTrx=? AND s2.DocStatus IN ('CL','CO')"
					+ " GROUP BY sl.M_InOutLine_ID"
					+ " HAVING sl.MovementQty - sum(COALESCE(il.QtyInvoiced,0)) > 0");
			sql.append(") ORDER BY s.MovementDate");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, C_BPartner_ID);
			pstmt.setString(2, isSOTrxParam);
			pstmt.setInt(3, C_BPartner_ID);
			pstmt.setString(4, isSOTrxParam);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				list.add(new KeyNamePair(rs.getInt(1), rs.getString(2)));
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		return list;
	}

	/**
	 *  Load PBartner dependent Order/Invoice/Shipment Field.
	 *  @param C_BPartner_ID BPartner
	 */
	protected ArrayList<KeyNamePair> loadRMAData(int C_BPartner_ID) {
		ArrayList<KeyNamePair> list = new ArrayList<KeyNamePair>();

		String sqlStmt = "SELECT r.M_RMA_ID, r.DocumentNo || '-' || r.Amt from M_RMA r ";
				if (isSOTrx) {
					sqlStmt += "WHERE ISSOTRX='Y' ";
				} else {
					sqlStmt += "WHERE ISSOTRX='N' ";
				}
				sqlStmt += "AND r.DocStatus in ('CO', 'CL')  ";
				sqlStmt += "AND r.C_BPartner_ID=?  ";
				sqlStmt += "AND NOT EXISTS (SELECT * FROM C_Invoice inv  ";
				sqlStmt += "WHERE inv.M_RMA_ID=r.M_RMA_ID AND inv.DocStatus IN ('CO', 'CL')) ";
				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sqlStmt, null);
			pstmt.setInt(1, C_BPartner_ID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(new KeyNamePair(rs.getInt(1), rs.getString(2)));
			}
		} catch (SQLException e) {
			log.log(Level.SEVERE, sqlStmt.toString(), e);
		} finally{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		return list;
	}

	/**
	 *  Load Data - Shipment not invoiced
	 *  @param M_InOut_ID InOut
	 */
	protected Vector<Vector<Object>> getShipmentData(int M_InOut_ID)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("M_InOut_ID=" + M_InOut_ID);
		MInOut inout = new MInOut(Env.getCtx(), M_InOut_ID, null);
		p_order = null;
		if (inout.getC_Order_ID() != 0)
			p_order = new MOrder (Env.getCtx(), inout.getC_Order_ID(), null);

		m_rma = null;
		if (inout.getM_RMA_ID() != 0)
			m_rma = new MRMA (Env.getCtx(), inout.getM_RMA_ID(), null);

		//
		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		StringBuilder sql = new StringBuilder("SELECT ");	//	QtyEntered
		sql.append(" l.movementqty -  COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il where il.C_OrderLine_ID = l.C_OrderLine_ID) ,0),");
		sql.append(" CASE WHEN l.movementqty=0 THEN 0 ELSE l.movementqty/l.movementqty END, ");
		sql.append(" COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il where il.processed = 'N' and il.C_OrderLine_ID = l.C_OrderLine_ID) ,0) , ");
		sql.append(" COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il where il.processed = 'Y' and il.C_OrderLine_ID = l.C_OrderLine_ID) ,0) , ");
		sql.append(" l.MovementQty,");
		sql.append(" l.C_UOM_ID,");
		sql.append(" COALESCE(uom.UOMSymbol, uom.Name), loc.m_locator_id, loc.value, ");
		sql.append(" l.M_Product_ID, p.Name, po.VendorProductNo, l.M_InOutLine_ID, io.documentno, l.Line, l.C_OrderLine_ID ");
		sql.append(" FROM M_InOutLine l ");
		if (Env.isBaseLanguage(Env.getCtx(), "C_UOM"))
			sql.append(" LEFT OUTER JOIN C_UOM uom ON (l.C_UOM_ID=uom.C_UOM_ID)");
		else
			sql.append(" LEFT OUTER JOIN C_UOM_Trl uom ON (l.C_UOM_ID=uom.C_UOM_ID AND uom.AD_Language='")
				.append(Env.getAD_Language(Env.getCtx())).append("')");
		sql.append(" LEFT OUTER JOIN M_Locator loc ON (loc.m_locator_id = l.m_locator_id AND loc.ad_client_id = l.ad_client_id)");
		sql.append(" LEFT OUTER JOIN M_Product p ON (l.M_Product_ID=p.M_Product_ID)")
			.append(" INNER JOIN M_InOut io ON (l.M_InOut_ID=io.M_InOut_ID)");
		if(!isSOTrx)
			sql.append(" LEFT OUTER JOIN M_MatchInv mi ON (l.M_InOutLine_ID=mi.M_InOutLine_ID)");
		else
			sql.append(" LEFT JOIN C_InvoiceLine il ON l.M_InOutLine_ID = il.M_InOutLine_ID");
		sql.append(" LEFT OUTER JOIN M_Product_PO po ON (l.M_Product_ID = po.M_Product_ID AND io.C_BPartner_ID = po.C_BPartner_ID)")

			.append(" WHERE l.M_InOut_ID=? AND l.MovementQty<>0 ")
			.append("GROUP BY l.MovementQty, l.QtyEntered/l.MovementQty, "
					+ "l.C_UOM_ID, COALESCE(uom.UOMSymbol, uom.Name), loc.m_locator_id, loc.value, "
					+ "l.M_Product_ID, p.Name, po.VendorProductNo, l.M_InOutLine_ID, io.documentno, l.Line, l.C_OrderLine_ID ");
		if(!isSOTrx)
			sql.append(" HAVING l.MovementQty-SUM(COALESCE(mi.Qty, 0)) <>0");
		else
			sql.append(" HAVING l.MovementQty-SUM(COALESCE(il.QtyInvoiced,0)) <>0");
		sql.append("ORDER BY l.Line");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, M_InOut_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>(7);
				line.add(Boolean.FALSE);           //  0-Selection

				BigDecimal multiplier = rs.getBigDecimal(2);
				line.add(rs.getBigDecimal(1).multiply(multiplier));    						// Qty
				line.add(rs.getBigDecimal(3));
				line.add(rs.getBigDecimal(4));
				line.add(rs.getBigDecimal(5));
				KeyNamePair pp = new KeyNamePair(rs.getInt(6), rs.getString(7).trim());
				line.add(pp); 																// UOM
				pp = new KeyNamePair(rs.getInt(8), rs.getString(9));
				line.add(pp);                           									// Locator
	
				pp = new KeyNamePair(rs.getInt(10), rs.getString(11));
				line.add(pp);                           									// Product
				line.add(rs.getString(12));													// VendorProductNo
				
				pp = new KeyNamePair(InOut, rs.getString(13));
				line.add(pp);																// document no

				pp = new KeyNamePair(rs.getInt(14), rs.getString(15));						// Line no
				line.add(pp);
				data.add(line);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		return data;
	}   //  loadShipment

	/**
	 * Load RMA details
	 * @param M_RMA_ID RMA
	 */
	protected Vector<Vector<Object>> getRMAData(int M_RMA_ID)
	{
	    p_order = null;

//	    MRMA m_rma = new MRMA(Env.getCtx(), M_RMA_ID, null);

	    Vector<Vector<Object>> data = new Vector<Vector<Object>>();
	    StringBuilder sqlStmt = new StringBuilder();
	    sqlStmt.append("SELECT ");
	    sqlStmt.append(" rl.Qty - COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il where il.m_rmaline_id = rl.m_rmaline_id) ,0),");
	    sqlStmt.append(" CASE WHEN rl.Qty=0 THEN 0 ELSE rl.Qty/rl.Qty END, ");
	    sqlStmt.append(" COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il where il.processed = 'N' and il.m_rmaline_id = rl.m_rmaline_id) ,0) , ");
	    sqlStmt.append(" COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il where il.processed = 'Y' and il.m_rmaline_id = rl.m_rmaline_id) ,0) , ");
	    sqlStmt.append(" rl.Qty,");
	    sqlStmt.append(" uom.C_UOM_ID,");
	    sqlStmt.append(" COALESCE(uom.UOMSymbol,uom.Name),");
	    sqlStmt.append(" iol.M_Product_ID, p.Name, rl.M_RMALine_ID, rl.line, r.documentno ");
	    sqlStmt.append("FROM M_RMALine rl INNER JOIN M_InOutLine iol ON rl.M_InOutLine_ID=iol.M_InOutLine_ID ");
	    sqlStmt.append(" INNER JOIN M_RMA r ON (r.M_RMA_ID=rl.M_RMA_ID) ");
	    if (Env.isBaseLanguage(Env.getCtx(), "C_UOM"))
        {
	        sqlStmt.append("LEFT OUTER JOIN C_UOM uom ON (uom.C_UOM_ID=iol.C_UOM_ID) ");
        }
	    else
        {
	        sqlStmt.append("LEFT OUTER JOIN C_UOM_Trl uom ON (uom.C_UOM_ID=iol.C_UOM_ID AND uom.AD_Language='");
	        sqlStmt.append(Env.getAD_Language(Env.getCtx())).append("') ");
        }
	    sqlStmt.append(" LEFT OUTER JOIN M_Product_PO po ON (rl.M_Product_ID = po.M_Product_ID AND r.C_BPartner_ID = po.C_BPartner_ID) ");
	    sqlStmt.append("LEFT OUTER JOIN M_Product p ON p.M_Product_ID=iol.M_Product_ID ");
	    sqlStmt.append("WHERE rl.M_RMA_ID=? ");
	    sqlStmt.append("AND rl.M_INOUTLINE_ID IS NOT NULL");

	    sqlStmt.append(" UNION ");

	    sqlStmt.append("SELECT ");
	    sqlStmt.append(" rl.Qty - COALESCE(rl.QtyInvoiced, 0),");
	    sqlStmt.append(" CASE WHEN rl.Qty=0 THEN 0 ELSE rl.Qty/rl.Qty END, ");
	    sqlStmt.append(" COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il where il.processed = 'N' and il.m_rmaline_id = rl.m_rmaline_id) ,0) , ");
	    sqlStmt.append(" COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il where il.processed = 'Y' and il.m_rmaline_id = rl.m_rmaline_id) ,0) , ");
	    sqlStmt.append(" rl.Qty,");
	    sqlStmt.append(" uom.C_UOM_ID,");
	    sqlStmt.append(" COALESCE(uom.UOMSymbol, uom.Name ), ");
	    sqlStmt.append(" 0, c.Name, rl.M_RMALine_ID, rl.line, r.documentno  ");
	    sqlStmt.append("FROM M_RMALine rl INNER JOIN C_Charge c ON c.C_Charge_ID = rl.C_Charge_ID ");
	    sqlStmt.append(" INNER JOIN M_RMA r ON (r.M_RMA_ID=rl.M_RMA_ID) ");
	    if (Env.isBaseLanguage(Env.getCtx(), "C_UOM"))
        {
	        sqlStmt.append("LEFT OUTER JOIN C_UOM uom ON (uom.C_UOM_ID=100) ");
        }
	    else
        {
	        sqlStmt.append("LEFT OUTER JOIN C_UOM_Trl uom ON (uom.C_UOM_ID=100 AND uom.AD_Language='");
	        sqlStmt.append(Env.getAD_Language(Env.getCtx())).append("') ");
        }
	    sqlStmt.append(" LEFT OUTER JOIN M_Product_PO po ON (rl.M_Product_ID = po.M_Product_ID AND r.C_BPartner_ID = po.C_BPartner_ID) ");
	    sqlStmt.append("WHERE rl.M_RMA_ID=? ");
	    sqlStmt.append("AND rl.C_Charge_ID IS NOT NULL");

	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try
	    {
	        pstmt = DB.prepareStatement(sqlStmt.toString(), null);
	        pstmt.setInt(1, M_RMA_ID);
	        pstmt.setInt(2, M_RMA_ID);
	        rs = pstmt.executeQuery();

	        while (rs.next())
            {
	            Vector<Object> line = new Vector<Object>(7);
	            line.add(Boolean.FALSE);   // 0-Selection
	            line.add(rs.getBigDecimal(1));  // 1-Qty
	            line.add(rs.getBigDecimal(3));  // 1-Qty
	            line.add(rs.getBigDecimal(4));  // 1-Qty
	            line.add(rs.getBigDecimal(5));  // 1-Qty
	            KeyNamePair pp = new KeyNamePair(rs.getInt(6), rs.getString(7));
	            line.add(pp); // 2-UOM
	            pp = new KeyNamePair(rs.getInt(8), rs.getString(9));
	            line.add(pp); // 3-Product
//	            line.add(null); //4-Vendor Product No
	            pp = new KeyNamePair(RMAReceipt, rs.getString(12));
	            line.add(pp); 								//Document No
	            pp = new KeyNamePair(rs.getInt(10), rs.getString(11));
	            line.add(pp); // line no
	            data.add(line);
            }
	    }
	    catch (Exception ex)
	    {
	        log.log(Level.SEVERE, sqlStmt.toString(), ex);
	    }
	    finally
	    {
	    	DB.close(rs, pstmt);
	    	rs = null; pstmt = null;
	    }

	    return data;
	}

	/**
	 *  List number of rows selected
	 */
	public void info(IMiniTable miniTable, IStatusBar statusBar)
	{

	}   //  infoInvoice

	protected void configureMiniTable (IMiniTable miniTable)
	{
		miniTable.setColumnClass(0, Boolean.class, false);      //  0-Selection
		miniTable.setColumnClass(1, BigDecimal.class, false);   //  1-Qty
		miniTable.setColumnClass(2, BigDecimal.class, true);   	//  Qty
		miniTable.setColumnClass(3, BigDecimal.class, true);   	//  Qty
		miniTable.setColumnClass(4, BigDecimal.class, true);   	//  Qty
		miniTable.setColumnClass(5, String.class, true);        //  2-UOM
		miniTable.setColumnClass(6, String.class, true);        //  3-Product
		miniTable.setColumnClass(7, String.class, true);        //  4-VendorProductNo
		miniTable.setColumnClass(8, String.class, true);        //  5-Order
		miniTable.setColumnClass(9, String.class, true);        //  6-Ship
		miniTable.setColumnClass(10, String.class, true);        //  7-Invoice
		//  Table UI
		miniTable.autoSize();
	}

	/**
	 *  Save - Create Invoice Lines
	 *  @return true if saved
	 */
	public boolean save(IMiniTable miniTable, String trxName)
	{
		//  Invoice
		int C_Invoice_ID = ((Integer)getGridTab().getValue("C_Invoice_ID")).intValue();
		MInvoice invoice = new MInvoice (Env.getCtx(), C_Invoice_ID, trxName);
		if (log.isLoggable(Level.CONFIG)) log.config(invoice.toString());

		if (p_order != null)
		{
			invoice.setOrder(p_order);	//	overwrite header values
			invoice.saveEx();
		}

		if (m_rma != null)
		{
			invoice.setM_RMA_ID(m_rma.getM_RMA_ID());
			invoice.saveEx();
		}

//		MInOut inout = null;
//		if (m_M_InOut_ID > 0)
//		{
//			inout = new MInOut(Env.getCtx(), m_M_InOut_ID, trxName);
//		}
//		if (inout != null && inout.getM_InOut_ID() != 0
//			&& inout.getC_Invoice_ID() == 0)	//	only first time
//		{
//			inout.setC_Invoice_ID(C_Invoice_ID);
//			inout.saveEx();
//		}

		//  Lines
		for (int i = 0; i < miniTable.getRowCount(); i++)
		{
			if (((Boolean)miniTable.getValueAt(i, 0)).booleanValue())
			{
				MProduct product = null;
				//  variable values
				BigDecimal QtyEntered = (BigDecimal)miniTable.getValueAt(i, 1);              //  1-Qty

				KeyNamePair pp = (KeyNamePair)miniTable.getValueAt(i, 5);   //  5-UOM
				int C_UOM_ID = pp.getKey();
				//
				pp = (KeyNamePair)miniTable.getValueAt(i, 6);               //  6-Product
				int M_Product_ID = 0;
				if (pp != null)
					M_Product_ID = pp.getKey();
				//
				int C_OrderLine_ID = 0;
				int M_InOutLine_ID = 0;
				int M_RMALine_ID = 0;

				pp =  (KeyNamePair) miniTable.getValueAt(i, 8);  // get the document type
				int docType = pp.getKey();
				pp = (KeyNamePair) miniTable.getValueAt(i, 9); // get the ID 

				switch (docType) {
				case Sales:	    
					C_OrderLine_ID = pp.getKey();
					break;
				case RMAReceipt:	
					M_RMALine_ID = pp.getKey();
					break;
				case InOut:
					M_InOutLine_ID = pp.getKey();
					break;
				}	
				
				//	Precision of Qty UOM
				int precision = 2;
				if (M_Product_ID != 0)
				{
					product = MProduct.get(Env.getCtx(), M_Product_ID);
					precision = product.getUOMPrecision();
				}
				QtyEntered = QtyEntered.setScale(precision, RoundingMode.HALF_DOWN);
				//
				if (log.isLoggable(Level.FINE)) log.fine("Line QtyEntered=" + QtyEntered
					+ ", Product_ID=" + M_Product_ID
					+ ", OrderLine_ID=" + C_OrderLine_ID + ", InOutLine_ID=" + M_InOutLine_ID);

				//	Create new Invoice Line
				MInvoiceLine invoiceLine = new MInvoiceLine (invoice);
				invoiceLine.setM_Product_ID(M_Product_ID, C_UOM_ID);	//	Line UOM
				invoiceLine.setQty(QtyEntered);							//	Invoiced/Entered
				BigDecimal QtyInvoiced = null;
				if (M_Product_ID > 0 && product.getC_UOM_ID() != C_UOM_ID) {
					QtyInvoiced = MUOMConversion.convertProductFrom(Env.getCtx(), M_Product_ID, C_UOM_ID, QtyEntered);
				}
				if (QtyInvoiced == null)
					QtyInvoiced = QtyEntered;
				invoiceLine.setQtyInvoiced(QtyInvoiced);

				//  Info
				MOrderLine orderLine = null;
				if (C_OrderLine_ID != 0)
					orderLine = new MOrderLine (Env.getCtx(), C_OrderLine_ID, trxName);
				//
				MRMALine rmaLine = null;
				if (M_RMALine_ID > 0)
					rmaLine = new MRMALine (Env.getCtx(), M_RMALine_ID, null);
				//
				MInOutLine inoutLine = null;
				if (M_InOutLine_ID != 0)
				{
					inoutLine = new MInOutLine (Env.getCtx(), M_InOutLine_ID, trxName);
					if (orderLine == null && inoutLine.getC_OrderLine_ID() != 0)
					{
						C_OrderLine_ID = inoutLine.getC_OrderLine_ID();
						orderLine = new MOrderLine (Env.getCtx(), C_OrderLine_ID, trxName);
					}
				}
				else if (C_OrderLine_ID > 0)
				{
					String whereClause = "EXISTS (SELECT 1 FROM M_InOut io WHERE io.M_InOut_ID=M_InOutLine.M_InOut_ID AND io.DocStatus IN ('CO','CL'))";
					MInOutLine[] lines = MInOutLine.getOfOrderLine(Env.getCtx(),
						C_OrderLine_ID, whereClause, trxName);
					if (log.isLoggable(Level.FINE)) log.fine ("Receipt Lines with OrderLine = #" + lines.length);
					if (lines.length > 0)
					{
						for (int j = 0; j < lines.length; j++)
						{
							MInOutLine line = lines[j];
							// qty matched
							BigDecimal qtyMatched = Env.ZERO;
							for (MMatchInv match : MMatchInv.getInOutLine(Env.getCtx(), line.getM_InOutLine_ID(), trxName)) {
								qtyMatched = qtyMatched.add(match.getQty());
							}
							if (line.getQtyEntered().subtract(qtyMatched).compareTo(QtyEntered) == 0)
							{
								inoutLine = line;
								M_InOutLine_ID = inoutLine.getM_InOutLine_ID();
								break;
							}
						}
//						if (inoutLine == null)
//						{
//							inoutLine = lines[0];	//	first as default
//							M_InOutLine_ID = inoutLine.getM_InOutLine_ID();
//						}
					}
				}
				else if (M_RMALine_ID != 0)
				{
					String whereClause = "EXISTS (SELECT 1 FROM M_InOut io WHERE io.M_InOut_ID=M_InOutLine.M_InOut_ID AND io.DocStatus IN ('CO','CL'))";
					MInOutLine[] lines = MInOutLine.getOfRMALine(Env.getCtx(), M_RMALine_ID, whereClause, null);
					if (log.isLoggable(Level.FINE)) log.fine ("Receipt Lines with RMALine = #" + lines.length);
					if (lines.length > 0)
					{
						for (int j = 0; j < lines.length; j++)
						{
							MInOutLine line = lines[j];
							if (rmaLine.getQty().compareTo(QtyEntered) == 0)
							{
								inoutLine = line;
								M_InOutLine_ID = inoutLine.getM_InOutLine_ID();
								break;
							}
						}
						if (rmaLine == null)
						{
							inoutLine = lines[0];	//	first as default
							M_InOutLine_ID = inoutLine.getM_InOutLine_ID();
						}
					}

				}
				//	get Ship info
				
				//	Shipment Info
				if (inoutLine != null)
				{
					invoiceLine.setShipLine(inoutLine);		//	overwrites
				}
				else {
					log.fine("No Receipt Line");
					//	Order Info
					if (orderLine != null)
					{
						invoiceLine.setOrderLine(orderLine);	//	overwrites
					}
					else
					{
						log.fine("No Order Line");
						invoiceLine.setPrice();
						invoiceLine.setTax();
					}

					//RMA Info
					if (rmaLine != null)
					{
						invoiceLine.setRMALine(rmaLine, QtyEntered);		//	overwrites
					}
					else
						log.fine("No RMA Line");
				}
				invoiceLine.saveEx();
			}   //   if selected
		}   //  for all rows

		if (p_order != null) {
			invoice.setPaymentRule(p_order.getPaymentRule());
			invoice.setC_PaymentTerm_ID(p_order.getC_PaymentTerm_ID());
			invoice.saveEx();
			invoice.load(invoice.get_TrxName()); // refresh from DB
			// copy payment schedule from order if invoice doesn't have a current payment schedule
			MOrderPaySchedule[] opss = MOrderPaySchedule.getOrderPaySchedule(invoice.getCtx(), p_order.getC_Order_ID(), 0, invoice.get_TrxName());
			MInvoicePaySchedule[] ipss = MInvoicePaySchedule.getInvoicePaySchedule(invoice.getCtx(), invoice.getC_Invoice_ID(), 0, invoice.get_TrxName());
			if (ipss.length == 0 && opss.length > 0) {
				BigDecimal ogt = p_order.getGrandTotal();
				BigDecimal igt = invoice.getGrandTotal();
				BigDecimal percent = Env.ONE;
				if (ogt.compareTo(igt) != 0)
					percent = igt.divide(ogt, 10, RoundingMode.HALF_UP);
				MCurrency cur = MCurrency.get(p_order.getCtx(), p_order.getC_Currency_ID());
				int scale = cur.getStdPrecision();
			
				for (MOrderPaySchedule ops : opss) {
					MInvoicePaySchedule ips = new MInvoicePaySchedule(invoice.getCtx(), 0, invoice.get_TrxName());
					PO.copyValues(ops, ips);
					if (percent != Env.ONE) {
						BigDecimal propDueAmt = ops.getDueAmt().multiply(percent);
						if (propDueAmt.scale() > scale)
							propDueAmt = propDueAmt.setScale(scale, RoundingMode.HALF_UP);
						ips.setDueAmt(propDueAmt);
					}
					ips.setC_Invoice_ID(invoice.getC_Invoice_ID());
					ips.setAD_Org_ID(ops.getAD_Org_ID());
					ips.setProcessing(ops.isProcessing());
					ips.setIsActive(ops.isActive());
					ips.saveEx();
				}
				invoice.validatePaySchedule();
				invoice.saveEx();
			}
		}

		return true;
	}   //  saveInvoice

/*	
	protected Vector<String> getOISColumnNames( DocumentType docType, Boolean withLocation)
	{
		//  Header Info
		ColumnInfo[] columns = getlayout(docType, withLocation);
		Vector<String> columnNames = new Vector<String>(columns.length);
		
		for (int i = 0; i < columns.length; i++)
		{
			columnNames.add(columns[i].getColHeader());
		}
	    return columnNames;
	}
*/
}
