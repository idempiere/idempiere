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
package org.compiere.apps.form;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.IReservationTracer;
import org.adempiere.util.IReservationTracerFactory;
import org.compiere.acct.Doc;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.MClient;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrderLine;
import org.compiere.model.MRole;
import org.compiere.model.MStorageReservation;
import org.compiere.model.Query;
import org.compiere.process.DocumentEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;

public class Match
{

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(Match.class);

	/** Match Options           */
	private String[] m_matchOptions = new String[] {
		Msg.getElement(Env.getCtx(), "C_Invoice_ID", false),
		Msg.getElement(Env.getCtx(), "M_InOut_ID", false),
		Msg.getElement(Env.getCtx(), "C_Order_ID", false) };
	
	public static final int		MATCH_INVOICE = 0;
	public static final int		MATCH_SHIPMENT = 1;
	public static final int		MATCH_ORDER = 2;

	public static final int		MODE_NOTMATCHED = 0;
	//private static final int		MODE_MATCHED = 1;

	/**	Indexes in Table			*/
	public static final int		I_ID = 0;
	public static final int		I_DocumentNo = 1;
	public static final int		I_DocumentDate = 2;
	public static final int		I_BPartner = 3;
	public static final int		I_Line = 4;
	public static final int		I_Product = 5;
	public static final int		I_QTY = 6;
	public static final int		I_MATCHED = 7;
	
	private StringBuffer    m_sql = null;
	private String          m_dateColumn = "";
	private String          m_qtyColumn = "";
	private String          m_groupBy = "";
	private StringBuffer	m_linetype = null;
	private String 			m_trxName = null;
	
	/**
	 *  Match From Changed - Fill Match To
	 */
	protected Vector<String> cmd_matchFrom(String selection)
	{
		Vector<String> vector = new Vector<String>(2);
		if (selection.equals(m_matchOptions[MATCH_INVOICE]))
			vector.add(m_matchOptions[MATCH_SHIPMENT]);
		else if (selection.equals(m_matchOptions[MATCH_ORDER]))
			vector.add(m_matchOptions[MATCH_SHIPMENT]);
		else    //  shipment
		{
			vector.add(m_matchOptions[MATCH_INVOICE]);
			vector.add(m_matchOptions[MATCH_ORDER]);
		}
		return vector;
	}   //  cmd_matchFrom

	
	/**
	 *  Search Button Pressed - Fill match from
	 */
	public IMiniTable cmd_search(IMiniTable xMatchedTable, int display, String matchToString, Integer Product, Integer Vendor, Timestamp from, Timestamp to, boolean matched)
	{
		//  ** Create SQL **
		int matchToType = MATCH_INVOICE;
		if (matchToString.equals(m_matchOptions[MATCH_SHIPMENT]))
			matchToType = MATCH_SHIPMENT;
		else if (matchToString.equals(m_matchOptions[MATCH_ORDER]))
			matchToType = MATCH_ORDER;
		//
		tableInit(display, matchToType, matched,null);	//	sets m_sql

		//  ** Add Where Clause **
		//  Product
		if (Product != null)
		{
			//Integer Product = (Integer)onlyProduct.getValue();
			m_sql.append(" AND lin.M_Product_ID=").append(Product);
		}
		//  BPartner
		if (Vendor != null)
		{
			//Integer Vendor = (Integer)onlyVendor.getValue();
			m_sql.append(" AND hdr.C_BPartner_ID=").append(Vendor);
		}
		//  Date
		if (from != null && to != null)
			m_sql.append(" AND ").append(m_dateColumn).append(" BETWEEN ")
				.append(DB.TO_DATE(from)).append(" AND ").append(DB.TO_DATE(to));
		else if (from != null)
			m_sql.append(" AND ").append(m_dateColumn).append(" >= ").append(DB.TO_DATE(from));
		else if (to != null)
			m_sql.append(" AND ").append(m_dateColumn).append(" <= ").append(DB.TO_DATE(to));
		
		//  ** Load Table **
		tableLoad (xMatchedTable);
		return xMatchedTable;

	}   //  cmd_search


	/**
	 *  Process Button Pressed - Process Matching
	 */
	public void cmd_process(IMiniTable xMatchedTable, IMiniTable xMatchedToTable, int matchMode, int matchFrom, String matchTo, BigDecimal m_xMatched)
	{
		//  Matched From
		int matchedRow = xMatchedTable.getSelectedRow();
		if (matchedRow < 0)
			return;
		KeyNamePair lineMatched = (KeyNamePair)xMatchedTable.getValueAt(matchedRow, I_Line);
		KeyNamePair Product = (KeyNamePair)xMatchedTable.getValueAt(matchedRow, I_Product);

		double totalQty = m_xMatched.doubleValue();

		//  Matched To
		for (int row = 0; row < xMatchedToTable.getRowCount(); row++)
		{
			IDColumn id = (IDColumn)xMatchedToTable.getValueAt(row, 0);
			if (id != null && id.isSelected())
			{
				//  need to be the same product
				KeyNamePair ProductCompare = (KeyNamePair)xMatchedToTable.getValueAt(row, I_Product);
				if (Product.getKey() != ProductCompare.getKey())
					continue;

				KeyNamePair lineMatchedTo = (KeyNamePair)xMatchedToTable.getValueAt(row, I_Line);

				//	Qty
				double qty = 0.0;
				if (matchMode == MODE_NOTMATCHED)
					qty = ((Double)xMatchedToTable.getValueAt(row, I_QTY)).doubleValue();	//  doc
				qty -= ((Double)xMatchedToTable.getValueAt(row, I_MATCHED)).doubleValue();  //  matched
				if (qty > totalQty)
					qty = totalQty;
				totalQty -= qty;

				//  Invoice or PO
				boolean invoice = true;
				if (matchFrom == MATCH_ORDER ||
						matchTo.equals(m_matchOptions[MATCH_ORDER]))
					invoice = false;
				//  Get Shipment_ID
				int M_InOutLine_ID = 0;
				int Line_ID = 0;
				if (matchFrom == MATCH_SHIPMENT)
				{
					M_InOutLine_ID = lineMatched.getKey();      //  upper table
					Line_ID = lineMatchedTo.getKey();
				}
				else
				{
					M_InOutLine_ID = lineMatchedTo.getKey();    //  lower table
					Line_ID = lineMatched.getKey();
				}

				//  Create it
				String innerTrxName = m_trxName == null ? Trx.createTrxName("Match") : null;
				Trx innerTrx = innerTrxName != null ? Trx.get(innerTrxName, true) : null;
				if (innerTrx != null)
					innerTrx.setDisplayName(getClass().getName()+"_cmd_process");
				
				try {
					if (createMatchRecord(invoice, M_InOutLine_ID, Line_ID, BigDecimal.valueOf(qty),  m_trxName != null ? m_trxName : innerTrxName)) {
						if (innerTrx != null)
							innerTrx.commit();
					} else {
						if (innerTrx != null)
							innerTrx.rollback();
						else
							Trx.get(m_trxName, false).rollback();
					}
				} catch(Exception ex) {
					if (innerTrx != null)
						innerTrx.rollback();
					throw new AdempiereException(ex);
				} finally {
					if (innerTrx != null) {
						innerTrx.close();
						innerTrx = null;
					}
				}
			}
		}
	}   //  cmd_process
	

	/**
	 *  Fill match to
	 */
	public IMiniTable cmd_searchTo(IMiniTable xMatchedTable, IMiniTable xMatchedToTable, String displayString, int matchToType, boolean sameBPartner, boolean sameProduct, boolean sameQty, boolean matched)
	{
		int row = xMatchedTable.getSelectedRow();
		if (log.isLoggable(Level.CONFIG)) log.config("Row=" + row);

		//  ** Create SQL **
		int display = MATCH_INVOICE;
		if (displayString.equals(m_matchOptions[MATCH_SHIPMENT]))
			display = MATCH_SHIPMENT;
		else if (displayString.equals(m_matchOptions[MATCH_ORDER]))
			display = MATCH_ORDER;
		
		KeyNamePair lineMatched = (KeyNamePair)xMatchedTable.getValueAt(row, I_Line);
		
		tableInit (display, matchToType, matched, lineMatched);	//	sets m_sql
		//  ** Add Where Clause **
		KeyNamePair BPartner = (KeyNamePair)xMatchedTable.getValueAt(row, I_BPartner);
		KeyNamePair Product = (KeyNamePair)xMatchedTable.getValueAt(row, I_Product);
		if (log.isLoggable(Level.FINE)) log.fine("BPartner=" + BPartner + " - Product=" + Product);
		//
		if (sameBPartner)
			m_sql.append(" AND hdr.C_BPartner_ID=").append(BPartner.getKey());
		if (sameProduct)
			m_sql.append(" AND lin.M_Product_ID=").append(Product.getKey());

		//  calculate qty
		double docQty = ((Double)xMatchedTable.getValueAt(row, I_QTY)).doubleValue();
		if (sameQty)
			m_sql.append(" AND ").append(m_qtyColumn).append("=").append(docQty);
		//  ** Load Table **
		tableLoad (xMatchedToTable);

		return xMatchedToTable;
	}   //  cmd_seachTo
	
	/**************************************************************************
	 *  Initialize Table access - create SQL, dateColumn.
	 *  <br>
	 *  The driving table is "hdr", e.g. for hdr.C_BPartner_ID=..
	 *  The line table is "lin", e.g. for lin.M_Product_ID=..
	 *  You use the dateColumn/qtyColumn variable directly as it is table specific.
	 *  <br>
	 *  The sql is dependent on MatchMode:
	 *  - If Matched - all (fully or partially) matched records are listed
	 *  - If Not Matched - all not fully matched records are listed
	 *  @param display (Invoice, Shipment, Order) see MATCH_*
	 *  @param matchToType (Invoice, Shipment, Order) see MATCH_*
	 */
	protected void tableInit (int display, int matchToType, boolean matched, KeyNamePair lineMatched)
	{
		//boolean matched = matchMode.getSelectedIndex() == MODE_MATCHED;
		if (log.isLoggable(Level.CONFIG)) log.config("Display=" + m_matchOptions[display]
			+ ", MatchTo=" + m_matchOptions[matchToType]
			+ ", Matched=" + matched);

		m_sql = new StringBuffer ();
		int Line_ID = 0;
		if (matched && lineMatched != null )
		{
			Line_ID = lineMatched.getKey();
		}
		if (display == MATCH_INVOICE)
		{
			m_dateColumn = "hdr.DateInvoiced";
			m_qtyColumn = "lin.QtyInvoiced";
			m_sql.append("SELECT hdr.C_Invoice_ID,hdr.DocumentNo, hdr.DateInvoiced, bp.Name,hdr.C_BPartner_ID,"
				+ " lin.Line,lin.C_InvoiceLine_ID, p.Name,lin.M_Product_ID,"
				+ " CASE WHEN dt.DocBaseType='APC' THEN lin.QtyInvoiced * -1 ELSE lin.QtyInvoiced END,SUM(NVL(mi.Qty,0)), org.Name, hdr.AD_Org_ID "  //JAVIER
				+ "FROM C_Invoice hdr"
				+ " INNER JOIN AD_Org org ON (hdr.AD_Org_ID=org.AD_Org_ID)" //JAVIER
				+ " INNER JOIN C_BPartner bp ON (hdr.C_BPartner_ID=bp.C_BPartner_ID)"
				+ " INNER JOIN C_InvoiceLine lin ON (hdr.C_Invoice_ID=lin.C_Invoice_ID)"
				+ " INNER JOIN M_Product p ON (lin.M_Product_ID=p.M_Product_ID)"
				+ " INNER JOIN C_DocType dt ON (hdr.C_DocType_ID=dt.C_DocType_ID AND dt.DocBaseType IN ('API','APC'))"
				+ " FULL JOIN M_MatchInv mi ON (lin.C_InvoiceLine_ID=mi.C_InvoiceLine_ID) "
				+ "WHERE hdr.DocStatus IN ('CO','CL')");
			if (lineMatched!= null && Line_ID > 0 )
				m_sql.append(" AND mi.M_InOutLine_ID  = ").append(Line_ID);
			
			m_groupBy = " GROUP BY hdr.C_Invoice_ID,hdr.DocumentNo,hdr.DateInvoiced,bp.Name,hdr.C_BPartner_ID,"
				+ " lin.Line,lin.C_InvoiceLine_ID,p.Name,lin.M_Product_ID,dt.DocBaseType,lin.QtyInvoiced, org.Name, hdr.AD_Org_ID, dt.DocBaseType " //JAVIER
				+ "HAVING "
				+ (matched ? "0" : "CASE WHEN dt.DocBaseType='APC' THEN lin.QtyInvoiced * -1 ELSE lin.QtyInvoiced END")
				+ "<>SUM(NVL(mi.Qty,0))";
		}
		else if (display == MATCH_ORDER)
		{
			m_dateColumn = "hdr.DateOrdered";
			m_qtyColumn = "lin.QtyOrdered";
			m_sql.append("SELECT hdr.C_Order_ID,hdr.DocumentNo, hdr.DateOrdered, bp.Name,hdr.C_BPartner_ID,"
				+ " lin.Line,lin.C_OrderLine_ID, p.Name,lin.M_Product_ID,"
				+ " lin.QtyOrdered,");
			if (matchToType == MATCH_SHIPMENT)
				m_sql.append("SUM(CASE WHEN (mo.M_InOutLine_ID IS NOT NULL) THEN COALESCE(mo.Qty,0) ELSE 0 END), ");
			else if (matchToType == MATCH_INVOICE)
				m_sql.append("SUM(CASE WHEN (mo.C_InvoiceLine_ID IS NOT NULL) THEN COALESCE(mo.Qty,0) ELSE 0 END), ");
			else
				m_sql.append("SUM(COALESCE(mo.Qty,0)), ");
			m_sql.append("org.Name, hdr.AD_Org_ID " //JAVIER
				+ "FROM C_Order hdr"
				+ " INNER JOIN AD_Org org ON (hdr.AD_Org_ID=org.AD_Org_ID)" //JAVIER
				+ " INNER JOIN C_BPartner bp ON (hdr.C_BPartner_ID=bp.C_BPartner_ID)"
				+ " INNER JOIN C_OrderLine lin ON (hdr.C_Order_ID=lin.C_Order_ID)"
				+ " INNER JOIN M_Product p ON (lin.M_Product_ID=p.M_Product_ID)"
				+ " INNER JOIN C_DocType dt ON (hdr.C_DocType_ID=dt.C_DocType_ID AND dt.DocBaseType='POO')"
				+ " FULL JOIN M_MatchPO mo ON (lin.C_OrderLine_ID=mo.C_OrderLine_ID) "
				+ " WHERE " ) ; //[ 1876972 ] Can't match partially matched PO with an unmatched receipt SOLVED BY BOJANA, AGENDA_GM
			m_linetype = new StringBuffer();
			m_linetype.append( matchToType == MATCH_SHIPMENT ? "M_InOutLine_ID" : "C_InvoiceLine_ID") ;
			if ( matched ) {
				m_sql.append( " mo." + m_linetype + " IS NOT NULL " ) ;
				if (lineMatched!= null && Line_ID > 0 )
					m_sql.append( " AND mo.M_InOutLine_ID = " + Line_ID) ;
			} else {
 				m_sql.append( " ( mo." + m_linetype + " IS NULL OR "
				+ " (lin.QtyOrdered <>  (SELECT sum(mo1.Qty) AS Qty" 
				+ " FROM m_matchpo mo1 WHERE "
				+ " mo1.C_ORDERLINE_ID=lin.C_ORDERLINE_ID AND "
				+ " hdr.C_ORDER_ID=lin.C_ORDER_ID AND "
				+ " mo1." + m_linetype
				+ " IS NOT NULL group by mo1.C_ORDERLINE_ID))) " );	
			}
			m_sql.append( " AND hdr.DocStatus IN ('CO','CL')" );
			m_groupBy = " GROUP BY hdr.C_Order_ID,hdr.DocumentNo,hdr.DateOrdered,bp.Name,hdr.C_BPartner_ID,"
				+ " lin.Line,lin.C_OrderLine_ID,p.Name,lin.M_Product_ID,lin.QtyOrdered, org.Name, hdr.AD_Org_ID " //JAVIER
				+ "HAVING "
				+ (matched ? "0" : "lin.QtyOrdered");
			
			if (matchToType == MATCH_SHIPMENT)
				m_groupBy = m_groupBy + "<>SUM(CASE WHEN (mo.M_InOutLine_ID IS NOT NULL) THEN COALESCE(mo.Qty,0) ELSE 0 END) ";
			else if (matchToType == MATCH_INVOICE)
				m_groupBy = m_groupBy + "<>SUM(CASE WHEN (mo.C_InvoiceLine_ID IS NOT NULL) THEN COALESCE(mo.Qty,0) ELSE 0 END) ";
			else
				m_groupBy = m_groupBy + "<>SUM(COALESCE(mo.Qty,0)) ";
		}
		else    //  Shipment
		{
			m_dateColumn = "hdr.MovementDate";
			m_qtyColumn = "lin.MovementQty";
			m_sql.append("SELECT hdr.M_InOut_ID,hdr.DocumentNo, hdr.MovementDate, bp.Name,hdr.C_BPartner_ID,"
				+ " lin.Line,lin.M_InOutLine_ID, p.Name,lin.M_Product_ID,"
				+ " CASE WHEN (dt.DocBaseType='MMS' AND hdr.issotrx='N') THEN lin.MovementQty * -1 ELSE lin.MovementQty END,");
			if (matchToType == MATCH_ORDER)
				m_sql.append("SUM(CASE WHEN m.M_InOutLine_ID IS NOT NULL THEN COALESCE(m.Qty,0) ELSE 0 END),");
			else
				m_sql.append("SUM(COALESCE(m.Qty,0)),");
			m_sql.append("org.Name, hdr.AD_Org_ID " //JAVIER
				+ "FROM M_InOut hdr"
				+ " INNER JOIN AD_Org org ON (hdr.AD_Org_ID=org.AD_Org_ID)" //JAVIER
				+ " INNER JOIN C_BPartner bp ON (hdr.C_BPartner_ID=bp.C_BPartner_ID)"
				+ " INNER JOIN M_InOutLine lin ON (hdr.M_InOut_ID=lin.M_InOut_ID)"
				+ " INNER JOIN M_Product p ON (lin.M_Product_ID=p.M_Product_ID)"
				+ " INNER JOIN C_DocType dt ON (hdr.C_DocType_ID = dt.C_DocType_ID AND (dt.DocBaseType='MMR' OR (dt.DocBaseType='MMS' AND hdr.isSOTrx ='N')))"
				+ " FULL JOIN ")
				.append(matchToType == MATCH_ORDER ? "M_MatchPO" : "M_MatchInv")
				.append(" m ON (lin.M_InOutLine_ID=m.M_InOutLine_ID) "
				+ "WHERE hdr.DocStatus IN ('CO','CL')");			
			if ( matchToType == MATCH_INVOICE &&   lineMatched!= null && Line_ID > 0 )
				m_sql.append(" AND m.C_InvoiceLine_ID  = ").append(Line_ID);
			if ( matchToType == MATCH_ORDER &&   lineMatched!= null && Line_ID > 0 )
				m_sql.append(" AND m.C_OrderLine_ID  = ").append(Line_ID);

			m_groupBy = " GROUP BY hdr.M_InOut_ID,hdr.DocumentNo,hdr.MovementDate,bp.Name,hdr.C_BPartner_ID,"
				+ " lin.Line,lin.M_InOutLine_ID,p.Name,lin.M_Product_ID,lin.MovementQty, org.Name, hdr.AD_Org_ID, dt.DocBaseType, hdr.IsSOTrx " //JAVIER
				+ "HAVING "
				+ (matched ? "0" : "CASE WHEN (dt.DocBaseType='MMS' AND hdr.issotrx='N') THEN lin.MovementQty * -1 ELSE lin.MovementQty END");
			if (matchToType == MATCH_ORDER)
				m_groupBy = m_groupBy + "<>SUM(CASE WHEN m.M_InOutLine_ID IS NOT NULL THEN COALESCE(m.Qty,0) ELSE 0 END)";
			else
				m_groupBy = m_groupBy + "<>SUM(COALESCE(m.Qty,0))";
		}
	}   //  tableInit


	/**
	 *  Fill the table using m_sql
	 *  @param table table
	 */
	protected void tableLoad (IMiniTable table)
	{
		String sql = MRole.getDefault().addAccessSQL(
			m_sql.toString(), "hdr", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO)
			+ m_groupBy;
		log.finest(sql);
		Statement stmt = null;
		ResultSet rs = null;
		try
		{
			stmt = DB.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY, m_trxName);
			rs = stmt.executeQuery(sql);
			table.loadTable(rs);
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs,stmt);
			rs = null;stmt = null;
		}
	}   //  tableLoad

	/**
	 *  Create Matching Record
	 *  @param invoice true if matching invoice false if matching PO
	 *  @param M_InOutLine_ID shipment line
	 *  @param Line_ID C_InvoiceLine_ID or C_OrderLine_ID
	 *  @param qty quantity
	 *  @param trxName 
	 *  @return true if created
	 */
	protected boolean createMatchRecord (boolean invoice, int M_InOutLine_ID, int Line_ID,
		BigDecimal qty, String trxName)
	{
		if (qty.compareTo(Env.ZERO) == 0)
			return true;
		if (log.isLoggable(Level.FINE)) log.fine("IsInvoice=" + invoice
			+ ", M_InOutLine_ID=" + M_InOutLine_ID + ", Line_ID=" + Line_ID
			+ ", Qty=" + qty);
		//
		boolean success = false;
		MInOutLine sLine = new MInOutLine (Env.getCtx(), M_InOutLine_ID, trxName);
		if (invoice)	//	Shipment - Invoice
		{
			//	Update Invoice Line
			MInvoiceLine iLine = new MInvoiceLine (Env.getCtx(), Line_ID, trxName);
			iLine.setM_InOutLine_ID(M_InOutLine_ID);
			if (sLine.getC_OrderLine_ID() != 0)
				iLine.setC_OrderLine_ID(sLine.getC_OrderLine_ID());
			iLine.saveEx();
			//	Create Shipment - Invoice Link
			if (iLine.getM_Product_ID() != 0)
			{
				MMatchInv match = new MMatchInv (iLine, null, qty);
				match.setM_InOutLine_ID(M_InOutLine_ID);
				match.saveEx();
				success = true;
				if (MClient.isClientAccountingImmediate()) {
					String ignoreError = DocumentEngine.postImmediate(match.getCtx(), match.getAD_Client_ID(), match.get_Table_ID(), match.get_ID(), true, match.get_TrxName());						
					if (ignoreError != null) {
						log.info(ignoreError);
					}
				}
			}
			else
				success = true;
			//	Create PO - Invoice Link = corrects PO
			if (iLine.getM_Product_ID() != 0)
			{
				BigDecimal matchedQty = DB.getSQLValueBD(iLine.get_TrxName(), "SELECT Coalesce(SUM(Qty),0) FROM M_MatchPO WHERE C_InvoiceLine_ID=?" , iLine.getC_InvoiceLine_ID());
				if (matchedQty.add(qty).compareTo(iLine.getQtyInvoiced()) <= 0) 
				{
					MMatchPO matchPO = MMatchPO.create(iLine, sLine, null, qty);
					if (matchPO != null)
					{
						matchPO.saveEx();
						if (MClient.isClientAccountingImmediate()) {
							String ignoreError = DocumentEngine.postImmediate(matchPO.getCtx(), matchPO.getAD_Client_ID(), matchPO.get_Table_ID(), matchPO.get_ID(), true, matchPO.get_TrxName());						
							if (ignoreError != null)
								log.info(ignoreError);
						}
					}
				}
			}
		}
		else	//	Shipment - Order
		{
			//	Update Order Line
			MOrderLine oLine = new MOrderLine(Env.getCtx(), Line_ID, trxName);
			BigDecimal storageReservationToUpdate = null;
			if (oLine.get_ID() != 0)	//	other in MInOut.completeIt
			{
				storageReservationToUpdate = oLine.getQtyReserved();
				oLine.setQtyReserved(oLine.getQtyReserved().subtract(qty));
				if (oLine.getQtyReserved().signum() == -1)
					oLine.setQtyReserved(Env.ZERO);
				else if (oLine.getQtyDelivered().compareTo(oLine.getQtyOrdered()) > 0)
					oLine.setQtyReserved(Env.ZERO);
				oLine.saveEx();
				storageReservationToUpdate = storageReservationToUpdate.subtract(oLine.getQtyReserved());
			}

			// Update Shipment Line
			BigDecimal toDeliver = oLine.getQtyOrdered().subtract(oLine.getQtyDelivered());
			if (toDeliver.signum() < 0)
				toDeliver = Env.ZERO;
			if (sLine.getMovementQty().compareTo(toDeliver) <= 0)
			{
				sLine.setC_OrderLine_ID(Line_ID);
				sLine.saveEx();
			}
			else if (sLine.getC_OrderLine_ID() != 0)
			{ 
				sLine.setC_OrderLine_ID(0);
				sLine.saveEx();
			}

			//	Create PO - Shipment Link
			if (sLine.getM_Product_ID() != 0)
			{
				MMatchPO match = getOrCreate(Line_ID, qty, sLine, trxName);
				match.setC_OrderLine_ID(Line_ID);
				if (!match.save())
				{
					String msg = "PO Match not created: " + match;
					ValueNamePair error = CLogger.retrieveError();
					if (error != null)
					{
						msg = msg + ". " + error.getName();
					}
					throw new AdempiereException(msg);
				}	
				else
				{
					success = true;
					//	Correct Ordered Qty for Stocked Products (see MOrder.reserveStock / MInOut.processIt)
					if (oLine.get_ID() > 0 && oLine.getM_Product_ID() > 0 && oLine.getProduct().isStocked() && storageReservationToUpdate != null) {
						IReservationTracer tracer = null;
						IReservationTracerFactory factory = Core.getReservationTracerFactory();
						if (factory != null) {
							tracer = factory.newTracer(sLine.getParent().getC_DocType_ID(), sLine.getParent().getDocumentNo(), sLine.getLine(), 
									sLine.get_Table_ID(), sLine.get_ID(), oLine.getM_Warehouse_ID(), 
									oLine.getM_Product_ID(), oLine.getM_AttributeSetInstance_ID(), oLine.getParent().isSOTrx(), 
									trxName);
						}
						success = MStorageReservation.add (Env.getCtx(), oLine.getM_Warehouse_ID(),
							oLine.getM_Product_ID(),
							oLine.getM_AttributeSetInstance_ID(),
							storageReservationToUpdate.negate(), oLine.getParent().isSOTrx(), trxName, tracer);
					}
				}
			}
			else
				success = true;
		}
		return success;
	}   //  createMatchRecord


	private MMatchPO getOrCreate(int C_OrderLine_ID, BigDecimal qty, MInOutLine sLine, String trxName) {
		Query query = new Query(Env.getCtx(), MMatchPO.Table_Name, "C_OrderLine_ID=? AND Qty=? AND Posted IN (?,?) AND M_InOutLine_ID IS NULL", trxName);
		MMatchPO matchPO = query.setParameters(C_OrderLine_ID, qty, Doc.STATUS_NotPosted, Doc.STATUS_Deferred).first();
		if (matchPO != null) {
			matchPO.setM_InOutLine_ID(sLine.getM_InOutLine_ID());
			return matchPO;
		} else {
			return new MMatchPO (sLine, null, qty);
		}
	}
	
	/**
	 * 
	 * @param trxName
	 */
	public void setTrxName(String trxName) {
		m_trxName = trxName;
	}

	/**
	 * 
	 * @return trxName
	 */
	public String getTrxName() {
		return m_trxName;
	}
	
	/**
	 * 
	 * @param matchType MATCH_INVOICE, MATCH_SHIPMENT or MATCH_ORDER
	 * @return display text for match type
	 */
	public String getMatchTypeText(int matchType) {
		if (matchType >= 0 && matchType < m_matchOptions.length)
			return m_matchOptions[matchType];
		return null;
	}
	
	/**
	 * 
	 * @return {@link ColumnInfo} array
	 */
	public ColumnInfo[] getColumnLayout() {
		ColumnInfo[] layout = new ColumnInfo[] {
				new ColumnInfo(" ",                                         ".", IDColumn.class, false, false, ""),
				new ColumnInfo(Msg.translate(Env.getCtx(), "DocumentNo"),   ".", String.class),             //  1
				new ColumnInfo(Msg.translate(Env.getCtx(), "Date"),         ".", Timestamp.class),
				new ColumnInfo(Msg.translate(Env.getCtx(), "C_BPartner_ID"),".", KeyNamePair.class, "."),   //  3
				new ColumnInfo(Msg.translate(Env.getCtx(), "Line"),         ".", KeyNamePair.class, "."),
				new ColumnInfo(Msg.translate(Env.getCtx(), "M_Product_ID"), ".", KeyNamePair.class, "."),   //  5
				new ColumnInfo(Msg.translate(Env.getCtx(), "Qty"),          ".", Double.class),
				new ColumnInfo(Msg.translate(Env.getCtx(), "Matched"),      ".", Double.class)
			};
		return layout;
	}	
}
