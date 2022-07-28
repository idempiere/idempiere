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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.apps.IStatusBar;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MOrder;
import org.compiere.model.MRMA;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

/**
 * 
 * @author hengsin
 *
 */
public abstract class CreateFrom implements ICreateFrom
{
	/**	Logger			*/
	protected transient CLogger log = CLogger.getCLogger(getClass());

	/** Loaded Order            */
	protected MOrder p_order = null;

	/**  Loaded RMA             */
	protected MRMA m_rma = null;

	private GridTab gridTab;

	private String title;

	private boolean initOK = false;
	
	protected boolean isSOTrx = false;

	/** optional db trx name **/
	private String m_trxName;
	
	/**
	 * 
	 * @param gridTab
	 */
	public CreateFrom(GridTab gridTab) {
		this.gridTab = gridTab;
		
		GridField field = gridTab.getField("IsSOTrx"); 
		if (field != null) 
			isSOTrx = (Boolean) field.getValue(); 
		else 
			isSOTrx = "Y".equals(Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "IsSOTrx"));
	}

	/**
	 * dynamic initialization, usually for loading of data
	 * @return true if initialization success
	 * @throws Exception
	 */
	protected abstract boolean dynInit() throws Exception;

	/**
	 * update status bar with info from miniTable
	 * @param miniTable
	 * @param statusBar
	 */
	public abstract void info(IMiniTable miniTable, IStatusBar statusBar);

	/**
	 * save changes
	 * @param miniTable
	 * @param trxName
	 * @return true if save successfully
	 */
	public abstract boolean save(IMiniTable miniTable, String trxName);

	@Override
	public boolean isInitOK()
	{
		return initOK;
	}

	/**
	 * 
	 * @param initOK
	 */
	public void setInitOK(boolean initOK)
	{
		this.initOK = initOK;
	}

	/**
	 *  Load BPartner related Orders.
	 *  @param C_BPartner_ID BPartner
	 *  @param forInvoice for invoice
	 *  @param sameWarehouseOnly
	 *  @return list of order records
	 */
	protected ArrayList<KeyNamePair> loadOrderData (int C_BPartner_ID, boolean forInvoice, boolean sameWarehouseOnly)
	{
		return loadOrderData(C_BPartner_ID, forInvoice, sameWarehouseOnly, false);
	}
	
	/**
	 * load order records
	 * @param C_BPartner_ID
	 * @param forInvoice
	 * @param sameWarehouseOnly
	 * @param forCreditMemo
	 * @return list of order records
	 */
	protected ArrayList<KeyNamePair> loadOrderData (int C_BPartner_ID, boolean forInvoice, boolean sameWarehouseOnly, boolean forCreditMemo)
	{
		ArrayList<KeyNamePair> list = new ArrayList<KeyNamePair>();

		String isSOTrxParam = isSOTrx ? "Y":"N";
		//	Display
		StringBuilder display = new StringBuilder("o.DocumentNo||' - ' ||")
			.append(DB.TO_CHAR("o.DateOrdered", DisplayType.Date, Env.getAD_Language(Env.getCtx())))
			.append("||' - '||")
			.append(DB.TO_CHAR("o.GrandTotal", DisplayType.Amount, Env.getAD_Language(Env.getCtx())));
		//
		String column = "ol.QtyDelivered";
		String colBP = "o.C_BPartner_ID";
		if (forInvoice)
		{
			column = "ol.QtyInvoiced";
			colBP = "o.Bill_BPartner_ID";
		}
		StringBuilder sql = new StringBuilder("SELECT o.C_Order_ID,")
			.append(display)
			.append(" FROM C_Order o WHERE ")
			.append(colBP)
			.append("=? AND o.IsSOTrx=? AND o.DocStatus IN ('CL','CO') AND o.C_Order_ID IN (SELECT ol.C_Order_ID FROM C_OrderLine ol WHERE ");
		if (forCreditMemo)
			sql.append(column).append(">0 AND (CASE WHEN ol.QtyDelivered>=ol.QtyOrdered THEN ol.QtyDelivered-ol.QtyInvoiced!=0 ELSE 1=1 END)) ");
		else
			sql.append("ol.QtyOrdered-").append(column).append("!=0) ");
					
		if(sameWarehouseOnly)
		{
			sql = sql.append(" AND o.M_Warehouse_ID=? ");
		}
		if (forCreditMemo)
			sql = sql.append("ORDER BY o.DateOrdered DESC,o.DocumentNo DESC");
		else
			sql = sql.append("ORDER BY o.DateOrdered,o.DocumentNo");
		//
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), m_trxName);
			pstmt.setInt(1, C_BPartner_ID);
			pstmt.setString(2, isSOTrxParam);
			if(sameWarehouseOnly)
			{
				//only active for material receipts
				pstmt.setInt(3, getM_Warehouse_ID());
			}
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
			rs = null; pstmt = null;
		}

		return list;
	}   //  initBPartnerOIS

	/**
	 *  Load Order Line records
	 *  @param C_Order_ID Order
	 *  @param forInvoice true if for invoice vs. delivery qty
	 *  @return list of order line records
	 */
	protected Vector<Vector<Object>> getOrderData (int C_Order_ID, boolean forInvoice)
	{
		return getOrderData (C_Order_ID, forInvoice, false);
	}
	
	/**
	 * Get order line records
	 * @param C_Order_ID
	 * @param forInvoice
	 * @param forCreditMemo
	 * @return list of order line records
	 */
	protected Vector<Vector<Object>> getOrderData (int C_Order_ID, boolean forInvoice, boolean forCreditMemo)
	{
		/**
		 *  Selected        - 0
		 *  Qty             - 1
		 *  C_UOM_ID        - 2
		 *  M_Product_ID    - 3
		 *  VendorProductNo - 4
		 *  OrderLine       - 5
		 *  ShipmentLine    - 6
		 *  InvoiceLine     - 7
		 */
		if (log.isLoggable(Level.CONFIG)) log.config("C_Order_ID=" + C_Order_ID);
		p_order = new MOrder (Env.getCtx(), C_Order_ID, getTrxName());

		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		StringBuilder sql = new StringBuilder("SELECT ");
		sql.append(forCreditMemo ? "SUM(COALESCE(m.Qty,0))," : "l.QtyOrdered-SUM(COALESCE(m.Qty,0)),");	//	1
		sql.append("CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END,"	//	2
			+ " l.C_UOM_ID,COALESCE(uom.UOMSymbol,uom.Name),"			//	3..4
			+ " COALESCE(l.M_Product_ID,0),COALESCE(p.Name,c.Name),po.VendorProductNo,"	//	5..7
			+ " l.C_OrderLine_ID,l.Line "								//	8..9
			+ "FROM C_OrderLine l"
			+ " LEFT OUTER JOIN M_Product_PO po ON (l.M_Product_ID = po.M_Product_ID AND l.C_BPartner_ID = po.C_BPartner_ID) "
			+ " LEFT OUTER JOIN M_MatchPO m ON (l.C_OrderLine_ID=m.C_OrderLine_ID AND ");
		sql.append(forInvoice ? "m.C_InvoiceLine_ID" : "m.M_InOutLine_ID");
		sql.append(" IS NOT NULL AND COALESCE(m.Reversal_ID,0)=0)")
			.append(" LEFT OUTER JOIN M_Product p ON (l.M_Product_ID=p.M_Product_ID)"
			+ " LEFT OUTER JOIN C_Charge c ON (l.C_Charge_ID=c.C_Charge_ID)");
		if (Env.isBaseLanguage(Env.getCtx(), "C_UOM"))
			sql.append(" LEFT OUTER JOIN C_UOM uom ON (l.C_UOM_ID=uom.C_UOM_ID)");
		else
			sql.append(" LEFT OUTER JOIN C_UOM_Trl uom ON (l.C_UOM_ID=uom.C_UOM_ID AND uom.AD_Language='")
				.append(Env.getAD_Language(Env.getCtx())).append("')");
		//
		sql.append(" WHERE l.C_Order_ID=? "			//	#1
			+ "GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END, "
			+ "l.C_UOM_ID,COALESCE(uom.UOMSymbol,uom.Name),po.VendorProductNo, "
				+ "l.M_Product_ID,COALESCE(p.Name,c.Name), l.Line,l.C_OrderLine_ID "
			+ "ORDER BY l.Line");
		//
		if (log.isLoggable(Level.FINER)) log.finer(sql.toString());
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), getTrxName());
			pstmt.setInt(1, C_Order_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>();
				line.add(Boolean.FALSE);           //  0-Selection
				BigDecimal qtyOrdered = rs.getBigDecimal(1);
				BigDecimal multiplier = rs.getBigDecimal(2);
				BigDecimal qtyEntered = qtyOrdered.multiply(multiplier);
				line.add(qtyEntered);                   //  1-Qty
				KeyNamePair pp = new KeyNamePair(rs.getInt(3), rs.getString(4).trim());
				line.add(pp);                           //  2-UOM
				pp = new KeyNamePair(rs.getInt(5), rs.getString(6));
				line.add(pp);                           //  3-Product
				line.add(rs.getString(7));				//  4-VendorProductNo
				pp = new KeyNamePair(rs.getInt(8), rs.getString(9));
				line.add(pp);                           //  5-OrderLine
				line.add(null);                         //  6-Ship
				line.add(null);                         //  7-Invoice
				data.add(line);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		return data;
	}   //  LoadOrder

	@Override
	public void showWindow()
	{

	}

	@Override
	public void closeWindow()
	{

	}

	/**
	 * 
	 * @return {@link GridTab}
	 */
	public GridTab getGridTab()
	{
		return gridTab;
	}

	/**
	 * Get Warehouse from window's context
	 * @return warehouse id
	 */
	public int getM_Warehouse_ID()
	{
		return Env.getContextAsInt(Env.getCtx(), gridTab.getWindowNo(), "M_Warehouse_ID");
	}

	/**
	 * 
	 * @return title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * 
	 * @param title
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	/**
	 * 
	 * @return trx name
	 */
	public String getTrxName() {
		return m_trxName;
	}
	
	/**
	 * set optional trx name
	 * @param trxName
	 */
	public void setTrxName(String trxName) {
		m_trxName = trxName;
	}
}
