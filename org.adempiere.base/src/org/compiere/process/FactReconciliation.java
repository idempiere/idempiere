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
 **********************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MProcessPara;
import org.compiere.util.DB;
import org.compiere.util.Msg;

/**
 * Account reconciliation report
 */
@org.adempiere.base.annotation.Process
public class FactReconciliation extends SvrProcess
{
	private Timestamp			p_DateAcct_From = null;
	private Timestamp			p_DateAcct_To = null;
	private int					p_Account_ID = 0;
	/**	Start Time						*/
	private long 				m_start = System.currentTimeMillis();
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	@Override
	protected void prepare()
	{
		//	Parameter
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (name.equals("DateAcct"))
			{
				p_DateAcct_From = (Timestamp)para[i].getParameter();
				p_DateAcct_To = (Timestamp)para[i].getParameter_To();
			}
			else if (name.equals("Account_ID"))
				p_Account_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
	}	//	prepare
	
	/**
	 *  Insert reconciliation report records to T_Reconciliation table.
	 *  @return empty string or error message
	 */
	@Override
	protected String doIt()
	{
		PreparedStatement pstmt = null;
		
		String sql = "INSERT into T_Reconciliation " +
		"(AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy, " +
		"IsActive, Fact_Acct_ID,  " +
		"AD_PInstance_ID, MatchCode) " +
		"SELECT f.AD_Client_ID, f.AD_Org_ID, f.Created, f.CreatedBy, " +
		"f.Updated, f.UpdatedBy, f.IsActive, " +
		"f.Fact_Acct_ID, ?, r.MatchCode " +
		"FROM Fact_Acct f " +
		"LEFT OUTER JOIN Fact_Reconciliation r ON (f.Fact_Acct_ID=r.Fact_Acct_ID) " +
		"WHERE Account_ID = ? " +
		"AND DateAcct BETWEEN  ? AND ? ";
		
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getAD_PInstance_ID());
			pstmt.setInt(2, p_Account_ID);
			pstmt.setTimestamp(3, p_DateAcct_From);
			pstmt.setTimestamp(4, p_DateAcct_To);
			int count = pstmt.executeUpdate();
			String result = Msg.getMsg(getCtx(),"Created") + ": " + count + ", ";
			
			if (log.isLoggable(Level.FINE))log.log(Level.FINE, result);

			sql = "DELETE FROM T_Reconciliation t " +
			"WHERE (SELECT SUM(f.amtacctdr-f.amtacctcr) FROM T_Reconciliation r " +
				"    INNER JOIN Fact_Acct f ON (f.Fact_Acct_ID = r.Fact_Acct_ID) " +
				"       WHERE r.MatchCode=t.MatchCode" +
				"       AND r.AD_PInstance_ID = t.AD_PInstance_ID) = 0 " +
				"AND t.AD_PInstance_ID = ?";
		
			DB.close(pstmt);
			pstmt = null;
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getAD_PInstance_ID());
			count = pstmt.executeUpdate();
			result = Msg.getMsg(getCtx(), "Deleted") + ": " + count;
			
			if (log.isLoggable(Level.FINE))log.log(Level.FINE, result);
		
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return e.getLocalizedMessage();
		}
		finally
		{
			DB.close(pstmt);
			pstmt = null;
		}
	
		if (log.isLoggable(Level.FINE)) log.fine((System.currentTimeMillis() - m_start) + " ms");
		return "";
	}	//	doIt


}
