/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.apps.IStatusBar;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.GridTab;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * 
 * @author Elaine
 *
 */
public abstract class CreateFromBatch extends CreateFrom 
{
	/**
	 * 
	 * @param gridTab
	 */
	public CreateFromBatch(GridTab gridTab) 
	{
		super(gridTab);
	}
	
	@Deprecated
	public String getSQLWhere(Object BPartner, String DocumentNo, Object DateFrom, Object DateTo, 
			Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode)
	{
		return getSQLWhere((Integer)BPartner, DocumentNo, (Timestamp)DateFrom, (Timestamp)DateTo, 
				(BigDecimal)AmtFrom, (BigDecimal)AmtTo, (Integer)DocType, (String)TenderType, AuthCode);
	}
	
	/**
	 * 
	 * @param BPartner
	 * @param DocumentNo
	 * @param DateFrom
	 * @param DateTo
	 * @param AmtFrom
	 * @param AmtTo
	 * @param DocType
	 * @param TenderType
	 * @param AuthCode
	 * @return where clause
	 */
	protected String getSQLWhere(Integer BPartner, String DocumentNo, Timestamp DateFrom, Timestamp DateTo, 
			BigDecimal AmtFrom, BigDecimal AmtTo, Integer DocType, String TenderType, String AuthCode)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("WHERE p.Processed='Y' AND p.IsReconciled='N'");
		sql.append(" AND p.DocStatus IN ('CO','CL','RE','VO') AND p.PayAmt<>0"); 
		sql.append(" AND p.C_BankAccount_ID = ?");
	    sql.append(" AND NOT EXISTS (SELECT * FROM C_BankStatementLine l WHERE p.C_Payment_ID=l.C_Payment_ID AND l.StmtAmt <> 0)");
	    	    
	    if(DocType != null)
			sql.append(" AND p.C_DocType_ID=?");
	    if(TenderType != null && TenderType.toString().length() > 0)
			sql.append(" AND p.TenderType=?");
		if(BPartner != null)
			sql.append(" AND p.C_BPartner_ID=?");
		
		if(DocumentNo != null && DocumentNo.length() > 0)
			sql.append(" AND UPPER(p.DocumentNo) LIKE ?");
		if(AuthCode != null && AuthCode.length() > 0)
			sql.append(" AND p.R_AuthCode LIKE ?");
		
		if(AmtFrom != null || AmtTo != null)
		{
			if(AmtFrom == null && AmtTo != null)
				sql.append(" AND p.PayAmt <= ?");
			else if(AmtFrom != null && AmtTo == null)
				sql.append(" AND p.PayAmt >= ?");
			else if(AmtFrom != null && AmtTo != null)
				sql.append(" AND p.PayAmt BETWEEN ? AND ?");
		}
		
		if(DateFrom != null || DateTo != null)
		{
			if(DateFrom == null && DateTo != null)
				sql.append(" AND TRUNC(p.DateTrx) <= ?");
			else if(DateFrom != null && DateTo == null)
				sql.append(" AND TRUNC(p.DateTrx) >= ?");
			else if(DateFrom != null && DateTo != null)
				sql.append(" AND TRUNC(p.DateTrx) BETWEEN ? AND ?");
		}

		if (log.isLoggable(Level.FINE)) log.fine(sql.toString());
		return sql.toString();
	}
	
	@Deprecated
	void setParameters(PreparedStatement pstmt, Object BankAccount, Object BPartner, String DocumentNo, Object DateFrom, Object DateTo, 
			Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode)
	throws SQLException
	{
		setParameters(pstmt, (Integer)BankAccount, (Integer)BPartner, DocumentNo, (Timestamp)DateFrom, (Timestamp)DateTo, 
				(BigDecimal)AmtFrom, (BigDecimal)AmtTo, (Integer)DocType, (String)TenderType, AuthCode);
	}
	
	/**
	 * 
	 * @param pstmt
	 * @param BankAccount
	 * @param BPartner
	 * @param DocumentNo
	 * @param DateFrom
	 * @param DateTo
	 * @param AmtFrom
	 * @param AmtTo
	 * @param DocType
	 * @param TenderType
	 * @param AuthCode
	 * @throws SQLException
	 */
	protected void setParameters(PreparedStatement pstmt, Integer BankAccount, Integer BPartner, String DocumentNo, Timestamp DateFrom, Timestamp DateTo, 
			BigDecimal AmtFrom, BigDecimal AmtTo, Integer DocType, String TenderType, String AuthCode)
	throws SQLException
	{
		int index = 1;
		
		pstmt.setInt(index++, BankAccount != null ? BankAccount : (Integer) getGridTab().getValue("C_BankAccount_ID"));
		
		if(DocType != null)
			pstmt.setInt(index++, DocType);
		
		if(TenderType != null && TenderType.toString().length() > 0)
			pstmt.setString(index++, TenderType);
		
		if(BPartner != null)
			pstmt.setInt(index++, BPartner);
		
		if(DocumentNo != null && DocumentNo.length() > 0)
			pstmt.setString(index++, getSQLText(DocumentNo));
		
		if(AuthCode != null && AuthCode.length() > 0)
			pstmt.setString(index++, getSQLText(AuthCode));
		
		if(AmtFrom != null || AmtTo != null)
		{
			if (log.isLoggable(Level.FINE)) log.fine("Amt From=" + AmtFrom + ", To=" + AmtTo);
			if(AmtFrom == null && AmtTo != null)
				pstmt.setBigDecimal(index++, AmtTo);
			else if(AmtFrom != null && AmtTo == null)
				pstmt.setBigDecimal(index++, AmtFrom);
			else if(AmtFrom != null && AmtTo != null)
			{
				pstmt.setBigDecimal(index++, AmtFrom);
				pstmt.setBigDecimal(index++, AmtTo);
			}
		}
		
		if(DateFrom != null || DateTo != null)
		{
			if (log.isLoggable(Level.FINE)) log.fine("Date From=" + DateFrom + ", To=" + DateTo);
			if(DateFrom == null && DateTo != null)
				pstmt.setTimestamp(index++, DateTo);
			else if(DateFrom != null && DateTo == null)
				pstmt.setTimestamp(index++, DateFrom);
			else if(DateFrom != null && DateTo != null)
			{
				pstmt.setTimestamp(index++, DateFrom);
				pstmt.setTimestamp(index++, DateTo);
			}
		}
	}
	
	private String getSQLText(String text)
	{
		String s = text.toUpperCase();
		if(!s.endsWith("%"))
			s += "%";
		if (log.isLoggable(Level.FINE)) log.fine( "String=" + s);
		return s;
	}
	
	@Deprecated
	protected Vector<Vector<Object>> getBankAccountData(Object BankAccount, Object BPartner, String DocumentNo, 
			Object DateFrom, Object DateTo, Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode)
	{
		return getBankAccountData((Integer)BankAccount, (Integer)BPartner, DocumentNo, (Timestamp)DateFrom, (Timestamp)DateTo, 
				(BigDecimal)AmtFrom, (BigDecimal)AmtTo, (Integer)DocType, (String)TenderType, AuthCode);
	}
	
	/**
	 * 
	 * @param BankAccount
	 * @param BPartner
	 * @param DocumentNo
	 * @param DateFrom
	 * @param DateTo
	 * @param AmtFrom
	 * @param AmtTo
	 * @param DocType
	 * @param TenderType
	 * @param AuthCode
	 * @return list of transaction records (usually payments) for bank account
	 */
	protected abstract Vector<Vector<Object>> getBankAccountData(Integer BankAccount, Integer BPartner, String DocumentNo, 
			Timestamp DateFrom, Timestamp DateTo, BigDecimal AmtFrom, BigDecimal AmtTo, Integer DocType, String TenderType, String AuthCode);
	
	@Override
	public void info(IMiniTable miniTable, IStatusBar statusBar)
	{		
		DecimalFormat format = DisplayType.getNumberFormat(DisplayType.Amount);
		BigDecimal total = Env.ZERO;
		int rows = miniTable.getRowCount();
		int count = 0;
		for(int i = 0; i < rows; i++)
		{
			if(((Boolean) miniTable.getValueAt(i, 0)).booleanValue())
			{
				total = total.add((BigDecimal) miniTable.getValueAt(i, 4));
				count++;
			}
		}
		statusBar.setStatusLine(String.valueOf(count) + " - " + Msg.getMsg(Env.getCtx(), "Sum") + "  " + format.format(total));
	}
}