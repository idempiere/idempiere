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

import org.adempiere.exceptions.AdempiereException;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MRole;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 * Form to perform Matching between Purchase Order, Vendor Invoice and Material Receipt.
 */
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
	public static final int		MODE_MATCHED = 1;

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
	private String 			m_trxName = null;
	
	/**
	 * Get applicable match to options for match from
	 * @param selection match from
	 * @return list of applicable match to options
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
	 *  Retrieve available match from records
	 *  @param xMatchedTable table to fill with retrieved records
	 *  @param display match from (MATCH_* constant), to popular xMatchedTable.
	 *  @param matchToString match to (invoice, material receipt or purchase order)
	 *  @param Product optional M_Product_ID
	 *  @param Vendor optional C_BPartner_ID
	 *  @param from optional from date
	 *  @param to optional to date
	 *  @param matched true for partial or fully match, false for not matched
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
	 * Process Matching
	 * @param xMatchedTable Match from table
	 * @param xMatchedToTable Match to table
	 * @param matchMode {@link #MODE_NOTMATCHED} or {@link #MODE_MATCHED}
	 * @param matchFrom Match from document type
	 * @param matchTo Match to document type
	 * @param m_xMatched Difference to match
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
	 * Retrieve available match to records
	 * @param xMatchedTable Match from table, to get line id from selected row
	 * @param xMatchedToTable Match to table, to fill with retrieved records
	 * @param displayString Match from, to populate xMatchedToTable
	 * @param matchToType Document to match with displayString (MATCH_* constant)
	 * @param sameBPartner
	 * @param sameProduct
	 * @param sameQty
	 * @param matched true for partial or fully match, false for not matched
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
	
	/**
	 *  Initialize Table - build SQL, set dateColumn and qtyColumn.
	 *  <br>
	 *  The driving table is "hdr", e.g. for hdr.C_BPartner_ID=..<br/>
	 *  The line table is "lin", e.g. for lin.M_Product_ID=..<br/>
	 *  You use the dateColumn/qtyColumn variable directly as it is table specific.
	 *  <br>
	 *  The sql is dependent on MatchMode:<br/>
	 *  - If Matched - all (fully or partially) matched records are listed<br/>
	 *  - If Not Matched - all not fully matched records are listed
	 *  @param display (Match from - Invoice, Material Receipt, Order) see MATCH_*
	 *  @param matchToType (Match to - Invoice, Material Receipt, Order) see MATCH_*
	 *  @param matched false for not matched, true for full/partially matched
	 *  @param lineMatched
	 */
	protected void tableInit (int display, int matchToType, boolean matched, KeyNamePair lineMatched)
	{
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
			//invoice matched with material receipt (m_matchinv)
			m_dateColumn = "hdr.DateInvoiced";
			m_qtyColumn = "lin.QtyInvoiced";
			m_sql.append(MInvoice.MATCH_TO_RECEIPT_SQL);
			if (lineMatched!= null && Line_ID > 0 )
				m_sql.append(" AND mi.M_InOutLine_ID  = ").append(Line_ID);
			
			m_groupBy = matched ? MInvoice.FULL_OR_PARTIALLY_MATCHED_TO_RECEIPT_GROUP_BY : MInvoice.NOT_FULLY_MATCHED_TO_RECEIPT_GROUP_BY;
		}
		else if (display == MATCH_ORDER)
		{
			//order match with receipt or invoice (m_matchpo) 
			//note that only matchToType == MATCH_SHIPMENT is implemented in UI
			m_dateColumn = "hdr.DateOrdered";
			m_qtyColumn = "lin.QtyOrdered";
			if (matchToType == MATCH_SHIPMENT)
			{
				m_sql.append(matched ? MOrder.FULL_OR_PARTIALLY_MATCHED_TO_RECEIPT : MOrder.NOT_FULLY_MATCHED_TO_RECEIPT);
				if (lineMatched!= null && Line_ID > 0 )
					m_sql.append( " AND mo.M_InOutLine_ID = " + Line_ID) ;
				m_groupBy = matched ? MOrder.FULL_OR_PARTIALLY_MATCHED_TO_RECEIPT_GROUP_BY : MOrder.NOT_FULLY_MATCHED_TO_RECEIPT_GROUP_BY;
			}
			else
			{
				m_sql.append(matched ? MOrder.FULL_OR_PARTIALLY_MATCHED_TO_INVOICE : MOrder.NOT_FULLY_MATCHED_TO_INVOICE);
				if (lineMatched!= null && Line_ID > 0 )
					m_sql.append( " AND mo.C_InvoiceLine_ID = " + Line_ID) ;
				m_groupBy = matched ? MOrder.FULL_OR_PARTIALLY_MATCHED_TO_INVOICE_GROUP_BY : MOrder.NOT_FULLY_MATCHED_TO_INVOICE_GROUP_BY;
			}			
		}
		else    //  Shipment
		{
			//receipt match with order (m_matchpo) or invoice (m_matchinv)
			m_dateColumn = "hdr.MovementDate";
			m_qtyColumn = "lin.MovementQty";
			if (matchToType == MATCH_ORDER)
				m_sql.append(matched ? MInOut.FULL_OR_PARTIALLY_MATCHED_TO_ORDER : MInOut.NOT_FULLY_MATCHED_TO_ORDER);
			else
				m_sql.append(matched ? MInOut.FULL_OR_PARTIALLY_MATCHED_TO_INVOICE : MInOut.NOT_FULLY_MATCHED_TO_INVOICE);
			if ( matchToType == MATCH_INVOICE && lineMatched != null && Line_ID > 0 )
				m_sql.append(" AND m.C_InvoiceLine_ID  = ").append(Line_ID);
			if ( matchToType == MATCH_ORDER && lineMatched != null && Line_ID > 0 )
				m_sql.append(" AND m.C_OrderLine_ID  = ").append(Line_ID);

			if (matchToType == MATCH_ORDER)
				m_groupBy = matched ? MInOut.FULL_OR_PARTIALLY_MATCHED_TO_ORDER_GROUP_BY : MInOut.NOT_FULLY_MATCHED_TO_ORDER_GROUP_BY;
			else
				m_groupBy = matched ? MInOut.FULL_OR_PARTIALLY_MATCHED_TO_INVOICE_GROUP_BY : MInOut.NOT_FULLY_MATCHED_TO_INVOICE_GROUP_BY;
		}
	}   //  tableInit

	/**
	 *  Fill table with records retrieve using m_sql
	 *  @param table table
	 */
	protected void tableLoad (IMiniTable table)
	{
		String sql = MRole.getDefault().addAccessSQL(
			m_sql.toString(), "hdr", MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO)
			+ m_groupBy;
		if (log.isLoggable(Level.FINEST)) log.finest(sql);
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
			success = sLine.matchToInvoiceLine(Line_ID, qty);
		}
		else	//	Shipment - Order
		{
			success = sLine.matchToOrderLine(Line_ID, qty);
		}
		return success;
	}   //  createMatchRecord

	/**
	 * @param trxName
	 */
	public void setTrxName(String trxName) {
		m_trxName = trxName;
	}

	/**
	 * @return trxName
	 */
	public String getTrxName() {
		return m_trxName;
	}
	
	/**
	 * Get display text for matching type
	 * @param matchType MATCH_INVOICE, MATCH_SHIPMENT or MATCH_ORDER
	 * @return display text for match type
	 */
	public String getMatchTypeText(int matchType) {
		if (matchType >= 0 && matchType < m_matchOptions.length)
			return m_matchOptions[matchType];
		return null;
	}
	
	/**
	 * Get column names for table
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
