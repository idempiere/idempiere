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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MRMA;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;

/**
 *  Create lines from RMA
 *
 *	@author etantg
 */
@org.adempiere.base.annotation.Process
public class CreateFromRMA extends SvrProcess 
{
	private int			p_M_RMA_ID = 0;
	
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
			else if (name.equals("M_RMA_ID"))
				p_M_RMA_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception {
		if (p_M_RMA_ID == 0)
			throw new AdempiereUserError("@NotFound@ @M_RMA_ID@");
		
		if (getProcessInfo().getAD_InfoWindow_ID() > 0)
			return createLines();
		else
			throw new AdempiereException("@NotSupported@");
	}
	
	private String createLines() {
		MRMA rma = new MRMA(getCtx(), p_M_RMA_ID, get_TrxName());
		if (log.isLoggable(Level.CONFIG)) log.config(rma.toString());
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT t.T_Selection_ID, v.Line, v.M_InOut_ID, v.M_InOutLine_ID, ");
		sql.append("v.MovementQty, v.Description ");
		sql.append("FROM T_Selection t, M_RMA_CreateFrom_v v ");
		sql.append("WHERE t.T_Selection_ID=v.M_RMA_CreateFrom_v_ID ");
		sql.append("AND t.AD_PInstance_ID=? ");
		sql.append("ORDER BY v.Line, v.M_InOut_ID, t.T_Selection_ID ");
		
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
				
				String ColumnName = "M_InOutLine_ID";
				String key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getInt(ColumnName));
				
				ColumnName = "MovementQty";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getBigDecimal(ColumnName));
				
				ColumnName = "Description";
				key = ColumnName + "_" + T_Selection_ID;
				selectionValueMap.put(key, rs.getString(ColumnName));
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
		
		for (int i = 0; i < selectionIDList.size(); i++)
		{
			int T_Selection_ID = selectionIDList.get(i);
			
			String ColumnName = "M_InOutLine_ID";
			String key = ColumnName + "_" + T_Selection_ID;
			Object value = selectionValueMap.get(key);
			int M_InOutLine_ID = value != null ? ((Number) value).intValue() : 0;
			
			ColumnName = "MovementQty";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			BigDecimal MovementQty = value != null ? (BigDecimal) value : null;
			
			ColumnName = "Description";
			key = ColumnName + "_" + T_Selection_ID;
			value = selectionValueMap.get(key);
			String Description = value != null ? (String) value : null;
			
			rma.createLineFrom(M_InOutLine_ID, MovementQty, Description);
            m_created++;
		}
		
		StringBuilder msgreturn = new StringBuilder("@Created@ = ").append(m_created);
		return msgreturn.toString();
	}
}
