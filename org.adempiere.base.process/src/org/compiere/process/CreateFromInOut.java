/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - etantg                         								   *
 **********************************************************************/

package org.compiere.process;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MInOut;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MProduct;
import org.compiere.model.MRMA;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;

/**
 *  Create M_InOutLine for M_InOut from Purchase Orders, Vendor Invoice or Customer RMA
 *
 *	@author etantg
 */
@org.adempiere.base.annotation.Process
public class CreateFromInOut extends SvrProcess
{
	private int			p_M_InOut_ID = 0;
	private int			p_M_Locator_ID = 0;
	
	private ArrayList<Integer> 			selectionIDList = new ArrayList<Integer>();
	private HashMap<String, Object> 	selectionValueMap = new HashMap<String, Object>();
	private int							m_created = 0;
	
	@Override
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_InOut_ID"))
				p_M_InOut_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception {
		if (p_M_InOut_ID == 0)
			throw new AdempiereUserError("@NotFound@ @M_InOut_ID@");
		
		if (getProcessInfo().getAD_InfoWindow_ID() > 0)
			return createLines();
		else
			throw new AdempiereException("@NotSupported@");
	}
	
	private String createLines() {
		// Get Shipment
		MInOut inout = new MInOut(getCtx(), p_M_InOut_ID, get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config(inout + ", M_Locator_ID=" + p_M_Locator_ID);

		// Lines
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT t.T_Selection_ID, t.ViewID, v.AD_Table_ID, v.Line, v.C_Order_ID, v.C_Invoice_ID, v.M_RMA_ID, ");
		sql.append("v.Qty, v.C_UOM_ID, v.M_Locator_ID, v.M_Product_ID, v.C_OrderLine_ID, v.C_InvoiceLine_ID, v.M_RMALine_ID ");
		sql.append("FROM T_Selection t, M_InOut_CreateFrom_v v ");
		sql.append("WHERE (t.ViewID || '_' || t.T_Selection_ID)=(v.AD_Table_ID || '_' || v.M_InOut_CreateFrom_v_ID) ");
		sql.append("AND t.AD_PInstance_ID=? ");
		sql.append("ORDER BY v.Line, v.AD_Table_ID, t.T_Selection_ID ");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			pstmt.setInt(1, getAD_PInstance_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int T_Selection_ID = rs.getInt("T_Selection_ID");				
				if (!selectionIDList.contains(T_Selection_ID))
					selectionIDList.add(T_Selection_ID);
				
				String ColumnName = "AD_Table_ID";
				String key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "Line";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "C_Order_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "C_Invoice_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "M_RMA_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "Qty";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getBigDecimal(ColumnName));
				
				ColumnName = "C_UOM_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "M_Locator_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "M_Product_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "C_OrderLine_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "C_InvoiceLine_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "M_RMALine_ID";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
			}
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
		
		sql = new StringBuilder();
		sql.append("SELECT T_Selection_ID, ColumnName, Value_String, Value_Number, Value_Date ");
		sql.append("FROM T_Selection_InfoWindow ");
		sql.append("WHERE AD_PInstance_ID=? ");
		sql.append("ORDER BY T_Selection_ID, ColumnName ");
		
		pstmt = null;
		rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			pstmt.setInt(1, getAD_PInstance_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				int T_Selection_ID = rs.getInt("T_Selection_ID");
				String ColumnName = rs.getString("ColumnName");
				String Value_String = rs.getString("Value_String");
				
				Object Value_Number = null;
				if (ColumnName.toUpperCase().endsWith("_ID"))
					Value_Number = rs.getInt("Value_Number");
				else
					Value_Number = rs.getBigDecimal("Value_Number");
				
				Timestamp Value_Date = rs.getTimestamp("Value_Date");
				
				String key = ColumnName + "_" + T_Selection_ID;
				Object value = null;
				if (Value_String != null)
					value = Value_String;
				else if (Value_Number != null)
					value = Value_Number;
				else if (Value_Date != null)
					value = Value_Date;
				selectionValueMap.put(key, value);
			}
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
				
		MOrder m_order = null;
		MInvoice m_invoice = null;
		MRMA m_rma = null;
		
		for (int i = 0; i < selectionIDList.size(); i++)
		{
			int T_Selection_ID = selectionIDList.get(i);
			
			String ColumnName = "C_Order_ID";
			String key = ColumnName + "_" + T_Selection_ID;
			Object value = selectionValueMap.get(key);
			int C_Order_ID = value != null ? ((Number) value).intValue() : 0;
			if (C_Order_ID != 0 && (m_order == null || m_order.getC_Order_ID() != C_Order_ID))
				m_order = new MOrder(getCtx(), C_Order_ID, get_TrxName());
			
			ColumnName = "C_Invoice_ID";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			int C_Invoice_ID = value != null ? ((Number) value).intValue() : 0;
			if (C_Invoice_ID != 0 && (m_invoice == null || m_invoice.getC_Invoice_ID() != C_Invoice_ID))
				m_invoice = new MInvoice(getCtx(), C_Invoice_ID, get_TrxName());
			
			ColumnName = "M_RMA_ID";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			int M_RMA_ID = value != null ? ((Number) value).intValue() : 0;
			if (M_RMA_ID != 0 && (m_rma == null || m_rma.getM_RMA_ID() != M_RMA_ID))
				m_rma = new MRMA(getCtx(), M_RMA_ID, get_TrxName());
			
			ColumnName = "Qty";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			BigDecimal QtyEntered = value != null ? (BigDecimal) value : null;
			
			ColumnName = "C_UOM_ID";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			int C_UOM_ID = value != null ? ((Number) value).intValue() : 0;
			
			ColumnName = "M_Locator_ID";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			// If a locator is specified on the product, choose that otherwise default locator
			int M_Locator_ID = value != null ? ((Number) value).intValue() : 0;

			ColumnName = "M_Product_ID";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			int M_Product_ID = value != null ? ((Number) value).intValue() : 0;
			
			ColumnName = "C_OrderLine_ID";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			int C_OrderLine_ID = value != null ? ((Number) value).intValue() : 0;
			
			ColumnName = "C_InvoiceLine_ID";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			int C_InvoiceLine_ID = value != null ? ((Number) value).intValue() : 0;
			
			ColumnName = "M_RMALine_ID";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			int M_RMALine_ID = value != null ? ((Number) value).intValue() : 0;
			
			//	Precision of Qty UOM
			int precision = 2;
			if (M_Product_ID != 0)
			{
				MProduct product = MProduct.get(getCtx(), M_Product_ID);
				precision = product.getUOMPrecision();
			}
			QtyEntered = QtyEntered.setScale(precision, RoundingMode.HALF_DOWN);
			//
			if (log.isLoggable(Level.FINE)) log.fine("Line QtyEntered=" + QtyEntered
					+ ", Product=" + M_Product_ID 
					+ ", OrderLine=" + C_OrderLine_ID + ", InvoiceLine=" + C_InvoiceLine_ID);

			//	Credit Memo - negative Qty
			if (m_invoice != null && m_invoice.isCreditMemo())
				QtyEntered = QtyEntered.negate();

			//	Create new InOut Line
			inout.createLineFrom(C_OrderLine_ID, C_InvoiceLine_ID, M_RMALine_ID, M_Product_ID, C_UOM_ID, QtyEntered, M_Locator_ID);
			m_created++;
		}   //  for all rows

		//  Update Header
		//  - if linked to another order/invoice/rma - remove link
		//  - if no link set it
		inout.updateFrom(m_order, m_invoice, m_rma);
		
		StringBuilder msgreturn = new StringBuilder("@Created@ = ").append(m_created);
		return msgreturn.toString();
	}
}
