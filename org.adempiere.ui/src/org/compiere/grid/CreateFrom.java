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
import org.compiere.grid.CreateFrom.DocumentType;
import org.compiere.minigrid.ColumnInfo;
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
import org.compiere.util.Msg;

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

	protected int preferredLocator_ID=0; 
	public enum DocumentType {Sales, Purchase, Invoice, RMACreate, RMAReceipt, InOut };
	public static final int Sales = 0;
	public static final int Purchase = 1;
	public static final int Invoice = 2;
	public static final int RMACreate = 3;
	public static final int RMAReceipt = 4;
	public static final int InOut = 5;	
	
	public CreateFrom(GridTab gridTab) {
		this.gridTab = gridTab;
		
		GridField field = gridTab.getField("IsSOTrx"); 
		if (field != null) 
			isSOTrx = (Boolean) field.getValue(); 
		else 
			isSOTrx = "Y".equals(Env.getContext(Env.getCtx(), gridTab.getWindowNo(), "IsSOTrx"));
	}

	public abstract boolean dynInit() throws Exception;

	public abstract void info(IMiniTable miniTable, IStatusBar statusBar);

	public abstract boolean save(IMiniTable miniTable, String trxName);

	/**
	 *	Init OK to be able to make changes?
	 *  @return on if initialized
	 */
	public boolean isInitOK()
	{
		return initOK;
	}

	public void setInitOK(boolean initOK)
	{
		this.initOK = initOK;
	}

	/**
	 *  Load PBartner dependent Order/Invoice/Shipment Field.
	 *  @param C_BPartner_ID BPartner
	 *  @param forInvoice for invoice
	 */
	protected ArrayList<KeyNamePair> loadOrderData (int C_BPartner_ID, boolean forInvoice, boolean sameWarehouseOnly)
	{
		return loadOrderData(C_BPartner_ID, forInvoice, sameWarehouseOnly, false);
	}
	
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
			pstmt = DB.prepareStatement(sql.toString(), null);
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
	 *  Load Data - Order
	 *  @param C_Order_ID Order
	 *  @param forInvoice true if for invoice vs. delivery qty
	 */
	protected Vector<Vector<Object>> getOrderData (int C_Order_ID, boolean forInvoice)
	{
		return getOrderData (C_Order_ID, forInvoice, false);
	}
	
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
		p_order = new MOrder (Env.getCtx(), C_Order_ID, null);

		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		StringBuilder sql = new StringBuilder("SELECT ");
		sql.append("l.QtyOrdered- COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il ");
		sql.append( " where il.C_OrderLine_ID = l.C_OrderLine_ID) ,0),");						//	1
		sql.append( " CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END,");	//	2
		sql.append( " COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il ");
		sql.append( " where il.processed = 'N' ");
		sql.append( " and il.C_OrderLine_ID = l.C_OrderLine_ID) ,0) ,");						// 4
		sql.append( " COALESCE((SELECT sum(il.qtyinvoiced) FROM C_InvoiceLine il ");
		sql.append( " where il.processed = 'Y' ");
		sql.append( " and il.C_OrderLine_ID = l.C_OrderLine_ID) ,0) ,");																// 4
		sql.append( " l.QtyOrdered, ");																// 5
		sql.append( " l.C_UOM_ID,COALESCE(uom.UOMSymbol,uom.Name),"	);							//	6..7
		sql.append( " COALESCE(l.M_Product_ID,0),COALESCE(p.Name,c.Name),po.VendorProductNo,");		//	8..10
		sql.append( " o.DocumentNo, ");																// 11
		sql.append( " l.C_OrderLine_ID,l.Line ");													//	12..13
		sql.append( " FROM C_OrderLine l");
		sql.append( " LEFT OUTER JOIN M_Product_PO po ON (l.M_Product_ID = po.M_Product_ID AND l.C_BPartner_ID = po.C_BPartner_ID) ");
		sql.append( " LEFT OUTER JOIN C_Order o ON (l.C_Order_ID = o.C_Order_ID) ");
		sql.append("  LEFT OUTER JOIN M_Product p ON (l.M_Product_ID=p.M_Product_ID)");			
		sql.append( " LEFT OUTER JOIN C_Charge c ON (l.C_Charge_ID=c.C_Charge_ID)");
		if (Env.isBaseLanguage(Env.getCtx(), "C_UOM"))
			sql.append(" LEFT OUTER JOIN C_UOM uom ON (l.C_UOM_ID=uom.C_UOM_ID)");
		else
			sql.append(" LEFT OUTER JOIN C_UOM_Trl uom ON (l.C_UOM_ID=uom.C_UOM_ID AND uom.AD_Language='")
				.append(Env.getAD_Language(Env.getCtx())).append("')");
		//
		sql.append(" WHERE l.C_Order_ID=? "			//	#1
			+ "GROUP BY l.QtyOrdered,CASE WHEN l.QtyOrdered=0 THEN 0 ELSE l.QtyEntered/l.QtyOrdered END, "
			+ "l.C_UOM_ID,COALESCE(uom.UOMSymbol,uom.Name),po.VendorProductNo, "
				+ "l.M_Product_ID,COALESCE(p.Name,c.Name), o.DocumentNo, l.Line,l.C_OrderLine_ID "
			+ "ORDER BY l.Line");
		//
		if (log.isLoggable(Level.FINER)) log.finer(sql.toString());
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, C_Order_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>();
				line.add(false); 				        // 0-Selection
				BigDecimal qtyOrdered = rs.getBigDecimal(1);
				BigDecimal multiplier = rs.getBigDecimal(2);
				line.add(rs.getBigDecimal(1).multiply(multiplier));    // 1-Qty
				line.add(rs.getBigDecimal(3));
				line.add(rs.getBigDecimal(4));
				line.add(rs.getBigDecimal(5));	
				KeyNamePair pp = new KeyNamePair(rs.getInt(6), rs.getString(7).trim());
				line.add(pp); 			// 2-UOM
				pp = new KeyNamePair(rs.getInt(8), rs.getString(9));
				line.add(pp);                           									// 3-Product
				line.add(rs.getString(10));													// 4-VendorProductNo
				if (forInvoice) {
					pp = new KeyNamePair(Sales, rs.getString(11));
				} else {
					pp = new KeyNamePair(Purchase, rs.getString(11));	
				}
				line.add(pp);																// 9-document no
				pp = new KeyNamePair(rs.getInt(12), rs.getString(13));
				line.add(pp);
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

	public void showWindow()
	{

	}

	public void closeWindow()
	{

	}

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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	//Added to support the rendering heading of the listboxes
	public  ColumnInfo[] getlayout(DocumentType docType)   //static
	{	
		
//		Boolean SO = isSOTrx;
//		String isSOTrxParam = isSOTrx ? "Y":"N";
		ColumnInfo[] layout = new ColumnInfo[] {};
		switch (docType) {
		case Purchase:
		    layout = new ColumnInfo[] {
			new ColumnInfo(Msg.translate(Env.getCtx(), "Select"),				".", 				Boolean.class, 		false,	true, "",  "."),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Quantity"),   			"QTY", 				BigDecimal.class, 	false,	true, "",  "QTY"),             //  1
			new ColumnInfo(Msg.translate(Env.getCtx(), "Registered Qty"), 		"QTY", 				BigDecimal.class, 	true,	true, "",  "Registered_Qty"), 
			new ColumnInfo(Msg.translate(Env.getCtx(), "ProcessedQty"),  		"QTY", 				BigDecimal.class, 	true,	true, "",  "Processed_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "OrderedQty"),  			"QTY", 				BigDecimal.class, 	true,	true, "",  "Ordered_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "C_UOM_ID"),         	"C_UOM_ID", 		String.class, 		true,	true, "",  "C_UOM_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Locator_ID"),			"M_Locator_ID", 	String.class, 		false,	true, "",  "M_Locator_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Product_ID"),			"M_Product_ID", 	String.class, 		true,	true, ".", "M_Product_ID"),   // 
			new ColumnInfo(Msg.translate(Env.getCtx(), "VendorProductNo"),		"VendorProductNo", 	String.class, 		true,	true, ".", "VendorProductNo"),   //  3
			new ColumnInfo(Msg.getElement(Env.getCtx(), "C_Order_ID", false),   "c_order_id", 		String.class, 		true,	true, ".", "C_Order_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Line"),         		"Line", 			String.class, 		true,	true, ".", "Line")};
			break;
	
		case Sales:
			layout = new ColumnInfo[] {
			new ColumnInfo(Msg.translate(Env.getCtx(), "Select"),				".", 				Boolean.class, 		false,	true, "",  "."),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Quantity"),   			"QTY", 				BigDecimal.class, 	false,	true, "",  "QTY"),             //  1
			new ColumnInfo(Msg.translate(Env.getCtx(), "Registered Qty"), 		"QTY", 				BigDecimal.class, 	true,	true, "",  "Registered_QTY"), 
			new ColumnInfo(Msg.translate(Env.getCtx(), "ProcessedQty"),  		"QTY", 				BigDecimal.class, 	true,	true, "",  "Processed_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "OrderedQty"),  			"QTY", 				BigDecimal.class, 	true,	true, "",  "Ordered_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "C_UOM_ID"),         	"C_UOM_ID", 		String.class, 		true,	true, "",  "C_UOM_ID"),
		  //new ColumnInfo(Msg.translate(Env.getCtx(), "M_Locator_ID"),			"M_Locator_ID", 	String.class, 		false,	true, "",  "M_Locator_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Product_ID"),			"M_Product_ID", 	String.class, 		true,	true, ".", "M_Product_ID"),   // 
			new ColumnInfo(Msg.translate(Env.getCtx(), "VendorProductNo"),		"VendorProductNo", 	String.class, 		true,	true, ".", "VendorProductNo"),   //  3
			new ColumnInfo(Msg.getElement(Env.getCtx(), "C_Order_ID", true),   "c_order_id", 		String.class, 		true,	true, ".", "C_Order_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Line"),         		"Line", 			String.class, 		true,	true, ".", "Line")};
		break;
			
		case Invoice:
			layout = new ColumnInfo[] {
			new ColumnInfo(Msg.translate(Env.getCtx(), "Select"),				".", 				Boolean.class, 		false,	true, ""),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Quantity"),   			"QTY", 				BigDecimal.class, 	false,	true, "",  "QTY"),             //  1
			new ColumnInfo(Msg.translate(Env.getCtx(), "Registered Qty"), 		"QTY", 				BigDecimal.class, 	true,	true, "",  "Registered_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "ProcessedQty"),  		"QTY", 				BigDecimal.class, 	true,	true, "",  "Processed_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "OrderedQty"),  			"QTY", 				BigDecimal.class, 	true,	true, "",  "Ordered_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "C_UOM_ID"),         	"C_UOM_ID", 		String.class, 		true,	true, "",  "C_UOM_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Locator_ID"),			"M_Locator_ID",		String.class, 		false,	true, "",  "M_Locator_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Product_ID"),			"M_Product_ID", 	String.class, 		true,	true, ".", "M_Product_ID"),   // 
			new ColumnInfo(Msg.translate(Env.getCtx(), "VendorProductNo"),		"VendorProductNo", 	String.class, 		true,	true, ".", "VendorProductNo"),   //  3
			new ColumnInfo(Msg.translate(Env.getCtx(), "c_invoice_id"),     	"c_invoice_id", 	String.class, 		true,	true, ".", "c_invoice_id"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Line"),         		"Line", 			String.class, 		true,	true, ".", "Line")};
			break;
			
		case RMAReceipt:
			layout = new ColumnInfo[] {
			new ColumnInfo(Msg.translate(Env.getCtx(), "Select"),				".", 				Boolean.class, 		false,	true, "",  "."),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Quantity"),   			"QTY",		 		BigDecimal.class, 	false,	true, "",  "QTY"),             //  1
			new ColumnInfo(Msg.translate(Env.getCtx(), "Registered Qty"),		"QTY", 				BigDecimal.class, 	true,	true, "",  "Registered_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "ProcessedQty"),  		"QTY", 				BigDecimal.class, 	true,	true, "",  "Processed_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "OrderedQty"),  			"QTY", 				BigDecimal.class, 	true,	true, "",  "Ordered_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "C_UOM_ID"),         	"C_UOM_ID", 		String.class, 		true,	true, "",  "C_UOM_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Locator_ID"),			"M_Locator_ID",		String.class, 		false,	true, "",  "M_Locator_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Product_ID"),			"M_Product_ID", 	String.class, 		true,	true, ".", "M_Product_ID"),   //
			new ColumnInfo(Msg.translate(Env.getCtx(), "VendorProductNo"),		"VendorProductNo", 	String.class, 		true,	true, ".", "VendorProductNo"),   //  3
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_RMA_ID"),      		"M_RMA_ID",			String.class, 		true,	true, ".", "M_RMA_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Line"),         		"Line", 			String.class, 		true,	true, ".", "Line")};
			break;
			
		case RMACreate:	
			layout = new ColumnInfo[] {
			new ColumnInfo(Msg.translate(Env.getCtx(), "Select"),		"Select", 		Boolean.class, false, true, ""),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Shipment"),   	"Shipment", 	String.class , true, true, ""),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Line"),   		"Line", 		String.class , true, true, ""),         
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Product_ID"), "M_Product_ID", String.class, true, true, ""),
			new ColumnInfo(Msg.translate(Env.getCtx(), "SerNo"),		"SerNo", 		String.class ,  true, true, ""),   // 
			new ColumnInfo(Msg.translate(Env.getCtx(), "Quantity"),		"QTY", 			BigDecimal.class, true, true, ""),   //  3
			new ColumnInfo(Msg.translate(Env.getCtx(), "QtyDelivered"), "QTY", 			BigDecimal.class, false, true, ""),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Description"),  "Description", 	String.class, false, true, "")};
			break;	
			
		case InOut:
			layout = new ColumnInfo[] {
			new ColumnInfo(Msg.translate(Env.getCtx(), "Select"),				".", 				Boolean.class, 		false,	true, "",  "."),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Quantity"),   			"QTY",		 		BigDecimal.class, 	false,	true, "",  "QTY"),             //  1
			new ColumnInfo(Msg.translate(Env.getCtx(), "Registered Qty"),		"QTY", 				BigDecimal.class, 	true,	true, "",  "Registered_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "ProcessedQty"),  		"QTY", 				BigDecimal.class, 	true,	true, "",  "Processed_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "OrderedQty"),  			"QTY", 				BigDecimal.class, 	true,	true, "",  "Ordered_QTY"),  
			new ColumnInfo(Msg.translate(Env.getCtx(), "C_UOM_ID"),         	"C_UOM_ID", 		String.class, 		true,	true, "",  "C_UOM_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Locator_ID"),			"M_Locator_ID",		String.class, 		isSOTrx,	true, "",  "M_Locator_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_Product_ID"),			"M_Product_ID", 	String.class, 		true,	true, ".", "M_Product_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "VendorProductNo"),		"VendorProductNo", 	String.class, 		true,	true, ".", "VendorProductNo"),   //  3
			new ColumnInfo(Msg.translate(Env.getCtx(), "M_InOut_ID"),      		"M_RMA_ID",			String.class, 		true,	true, ".", "M_RMA_ID"),
			new ColumnInfo(Msg.translate(Env.getCtx(), "Line"),         		"Line", 			String.class, 		true,	true, ".", "Line")}; 
			break;
		}

		return layout;
	}		

	protected Vector<String> getOISColumnNames(ColumnInfo[] columns)
	{
		//  Header Info

		Vector<String> columnNames = new Vector<String>(columns.length);
		
		for (int i = 0; i < columns.length; i++)
		{
			if (columns[i] != null) 
				columnNames.add(columns[i].getColHeader());
		}
	    return columnNames;
	}
}
