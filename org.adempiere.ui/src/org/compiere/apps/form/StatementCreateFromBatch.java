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
package org.compiere.apps.form;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.apps.IStatusBar;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.GridTab;
import org.compiere.model.MBankStatement;
import org.compiere.model.MBankStatementLine;
import org.compiere.model.MPayment;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

/**
 * 
 * @author Elaine
 *
 */
public abstract class StatementCreateFromBatch extends CreateFromForm
{
	/**	Logger			*/
	protected CLogger log = CLogger.getCLogger(getClass());
	
	public boolean dynInit() throws Exception
	{
		log.config("");
		setTitle(Msg.getElement(Env.getCtx(), "C_BankStatement_ID") + " .. " + Msg.getElement(Env.getCtx(), "X_CreateFromBatch"));
		
		return true;
	}

	public String getSQLWhere(Object BPartner, String DocumentNo, Object DateFrom, Object DateTo, 
			Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode)
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
		
		if(DocumentNo.length() > 0)
			sql.append(" AND UPPER(p.DocumentNo) LIKE ?");
		if(AuthCode.length() > 0)
			sql.append(" AND p.R_AuthCode LIKE ?");
		
		if(AmtFrom != null || AmtTo != null)
		{
			BigDecimal from = (BigDecimal) AmtFrom;
			BigDecimal to = (BigDecimal) AmtTo;
			if(from == null && to != null)
				sql.append(" AND p.PayAmt <= ?");
			else if(from != null && to == null)
				sql.append(" AND p.PayAmt >= ?");
			else if(from != null && to != null)
				sql.append(" AND p.PayAmt BETWEEN ? AND ?");
		}
		
		if(DateFrom != null || DateTo != null)
		{
			Timestamp from = (Timestamp) DateFrom;
			Timestamp to = (Timestamp) DateTo;
			if(from == null && to != null)
				sql.append(" AND TRUNC(p.DateTrx) <= ?");
			else if(from != null && to == null)
				sql.append(" AND TRUNC(p.DateTrx) >= ?");
			else if(from != null && to != null)
				sql.append(" AND TRUNC(p.DateTrx) BETWEEN ? AND ?");
		}

		if (log.isLoggable(Level.FINE)) log.fine(sql.toString());
		return sql.toString();
	}
	
	void setParameters(PreparedStatement pstmt, Object BankAccount, Object BPartner, String DocumentNo, Object DateFrom, Object DateTo, 
			Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode, GridTab gridTab)
	throws SQLException
	{
		//  Get StatementDate
		Timestamp ts = (Timestamp) gridTab.getValue("StatementDate");
		if (ts == null)
			ts = new Timestamp(System.currentTimeMillis());

		int index = 1;
		
		pstmt.setTimestamp(index++, ts);		
		pstmt.setInt(index++, BankAccount != null ? (Integer) BankAccount : (Integer) gridTab.getValue("C_BankAccount_ID"));
		
		if(DocType != null)
			pstmt.setInt(index++, (Integer) DocType);
		
		if(TenderType != null && TenderType.toString().length() > 0)
			pstmt.setString(index++, (String) TenderType);
		
		if(BPartner != null)
			pstmt.setInt(index++, (Integer) BPartner);
		
		if(DocumentNo.length() > 0)
			pstmt.setString(index++, getSQLText(DocumentNo));
		
		if(AuthCode.length() > 0)
			pstmt.setString(index++, getSQLText(AuthCode));
		
		if(AmtFrom != null || AmtTo != null)
		{
			BigDecimal from = (BigDecimal) AmtFrom;
			BigDecimal to = (BigDecimal) AmtTo;
			if (log.isLoggable(Level.FINE)) log.fine("Amt From=" + from + ", To=" + to);
			if(from == null && to != null)
				pstmt.setBigDecimal(index++, to);
			else if(from != null && to == null)
				pstmt.setBigDecimal(index++, from);
			else if(from != null && to != null)
			{
				pstmt.setBigDecimal(index++, from);
				pstmt.setBigDecimal(index++, to);
			}
		}
		
		if(DateFrom != null || DateTo != null)
		{
			Timestamp from = (Timestamp) DateFrom;
			Timestamp to = (Timestamp) DateTo;
			if (log.isLoggable(Level.FINE)) log.fine("Date From=" + from + ", To=" + to);
			if(from == null && to != null)
				pstmt.setTimestamp(index++, to);
			else if(from != null && to == null)
				pstmt.setTimestamp(index++, from);
			else if(from != null && to != null)
			{
				pstmt.setTimestamp(index++, from);
				pstmt.setTimestamp(index++, to);
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
	
	protected Vector<Vector<Object>> getBankAccountData(Object BankAccount, Object BPartner, String DocumentNo, 
			Object DateFrom, Object DateTo, Object AmtFrom, Object AmtTo, Object DocType, Object TenderType, String AuthCode, 
			GridTab gridTab)
	{
		if (log.isLoggable(Level.CONFIG)) log.config ("C_BankAccount_ID=" + BankAccount);

		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT py.X_DepositBatch_ID, db.DocumentNo, db.DateDeposit, db.C_BankAccount_ID, ba.AccountNo,");
		sql.append("SUM(currencyConvert(p.PayAmt,p.C_Currency_ID,ba.C_Currency_ID,?,null,p.AD_Client_ID,p.AD_Org_ID)) AS amount,");
		sql.append("SUM(p.PayAmt) AS amountoriginal");
		sql.append(" FROM C_BankAccount ba");
		sql.append(" INNER JOIN C_Payment_v p ON (p.C_BankAccount_ID=ba.C_BankAccount_ID)");
		sql.append(" INNER JOIN C_Currency c ON (p.C_Currency_ID=c.C_Currency_ID)");
		sql.append(" INNER JOIN C_Payment py ON (py.C_Payment_ID=p.C_Payment_ID)");
		sql.append(" INNER JOIN X_DepositBatch db ON (py.X_DepositBatch_ID = db.X_DepositBatch_ID) ");
		sql.append(getSQLWhere(BPartner, DocumentNo, DateFrom, DateTo, AmtFrom, AmtTo, DocType, TenderType, AuthCode));
		
		sql.append(" AND p.IsReceipt = 'Y'");
		sql.append(" AND py.X_DepositBatch_ID <> 0");
		sql.append(" AND db.Processed = 'Y'");
		
		sql.append(" GROUP BY py.X_DepositBatch_ID,db.DocumentNo,db.DateDeposit, db.C_BankAccount_ID,ba.AccountNo");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			setParameters(pstmt, BankAccount, BPartner, DocumentNo, DateFrom, DateTo, AmtFrom, AmtTo, DocType, TenderType, AuthCode, gridTab);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				Vector<Object> line = new Vector<Object>(5);
				line.add(new Boolean(false));       //  0-Selection
				line.add(rs.getTimestamp(3));       //  1-DateDeposit
				KeyNamePair pp = new KeyNamePair(rs.getInt(1), rs.getString(2));
				line.add(pp);                       //  2-X_DepositBatch  
				line.add(rs.getBigDecimal(7));      //  3-PayAmt
				line.add(rs.getBigDecimal(6));      //  4-Conv Amt
				pp = new KeyNamePair(rs.getInt(4), rs.getString(5));
				line.add(pp);      					//  5-Bank Account
				data.add(line);
			}
		}
		catch(SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		return data;
	}
	
	protected void configureMiniTable (IMiniTable miniTable)
	{
		miniTable.setColumnClass(0, Boolean.class, false);      //  0-Selection
		miniTable.setColumnClass(1, Timestamp.class, true);     //  1-TrxDate
		miniTable.setColumnClass(2, String.class, true);        //  2-DepositBatch
		miniTable.setColumnClass(3, BigDecimal.class, true);    //  3-Amount
		miniTable.setColumnClass(4, BigDecimal.class, true);    //  4-ConvAmount
		miniTable.setColumnClass(5, String.class, true);    	//  5-BankAccount
		//  Table UI
		miniTable.autoSize();
	}
	
	public boolean save(IMiniTable miniTable, String trxName, GridTab gridTab)
	{
		//  fixed values
		int C_BankStatement_ID = ((Integer) gridTab.getValue("C_BankStatement_ID")).intValue();
		MBankStatement bs = new MBankStatement (Env.getCtx(), C_BankStatement_ID, null);
		if (log.isLoggable(Level.CONFIG)) log.config(bs.toString());

		StringBuilder sql = new StringBuilder();
		sql.append("SELECT p.DateTrx,p.C_Payment_ID,p.DocumentNo, p.C_Currency_ID,c.ISO_Code, p.PayAmt,");
		sql.append("currencyConvert(p.PayAmt,p.C_Currency_ID,ba.C_Currency_ID,?,null,p.AD_Client_ID,p.AD_Org_ID), bp.Name ");
		sql.append(" FROM C_BankAccount ba");
		sql.append(" INNER JOIN C_Payment_v p ON (p.C_BankAccount_ID=ba.C_BankAccount_ID)");
		sql.append(" INNER JOIN C_Currency c ON (p.C_Currency_ID=c.C_Currency_ID)");
		sql.append(" INNER JOIN C_Payment py ON (py.C_Payment_ID=p.C_Payment_ID)");
		sql.append(" INNER JOIN X_DepositBatch db ON (py.X_DepositBatch_ID = db.X_DepositBatch_ID)");
		sql.append(" LEFT OUTER JOIN C_BPartner bp ON (p.C_BPartner_ID=bp.C_BPartner_ID)");
		sql.append(" WHERE p.Processed='Y' AND p.IsReconciled='N'");
		sql.append(" AND p.IsReceipt = 'Y'");
		sql.append(" AND py.X_DepositBatch_ID = ?");
		sql.append(" AND p.DocStatus IN ('CO','CL','RE','VO') AND p.PayAmt<>0");
		sql.append(" AND p.C_BankAccount_ID=?");
		sql.append(" AND NOT EXISTS (SELECT * FROM C_BankStatementLine l WHERE p.C_Payment_ID=l.C_Payment_ID AND l.StmtAmt <> 0)");
		
		Timestamp ts = (Timestamp) gridTab.getValue("StatementDate");
		if(ts == null)
			ts = new Timestamp(System.currentTimeMillis());

		//  Lines
		for(int i = 0; i < miniTable.getRowCount(); i++)
		{
			if(((Boolean) miniTable.getValueAt(i, 0)).booleanValue())
			{
				Timestamp trxDate = (Timestamp) miniTable.getValueAt(i, 1);  //  1-DateTrx
				KeyNamePair pp = (KeyNamePair) miniTable.getValueAt(i, 2);   //  2-X_DepositBatch_ID
				int X_DepositBatch_ID = pp.getKey();
				
				pp = (KeyNamePair) miniTable.getValueAt(i, 5);               //  5- C_BankAccount_ID
				int C_BankAccount_ID = pp.getKey();

				if (log.isLoggable(Level.FINE)) log.fine("Deposit Batch Date=" + trxDate + ", Batch=" + X_DepositBatch_ID 
						+" , Bank Account" + C_BankAccount_ID);

				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try
				{
					pstmt = DB.prepareStatement(sql.toString(), null);
					pstmt.setTimestamp(1, ts);
					pstmt.setInt(2, X_DepositBatch_ID);
					pstmt.setInt(3, C_BankAccount_ID);
					rs = pstmt.executeQuery();
					while(rs.next())
					{
						int C_Payment_ID = rs.getInt(2);
						int C_Currency_ID = rs.getInt(4);
						BigDecimal TrxAmt = rs.getBigDecimal(6); //  PayAmt
						
						if (log.isLoggable(Level.FINE)) log.fine("Line Date=" + trxDate + ", Payment=" + C_Payment_ID + ", Currency=" + C_Currency_ID + ", Amt=" + TrxAmt);
						//	
						MBankStatementLine bsl = new MBankStatementLine (bs);
						bsl.setStatementLineDate(trxDate);
						bsl.setPayment(new MPayment(Env.getCtx(), C_Payment_ID, null));
						if (!bsl.save())
							log.log(Level.SEVERE, "Line not created #" + i);
							
					}
				}
				catch(SQLException e)
				{
					log.log(Level.SEVERE, sql.toString(), e);
				}
				finally
				{
					DB.close(rs, pstmt);
					rs = null; pstmt = null;
				}
			}   //   if selected
		}   //  for all rows
		return true;
	}

	protected Vector<String> getOISColumnNames()
	{
		//  Header Info
	    Vector<String> columnNames = new Vector<String>(6);
	    columnNames.add(Msg.getMsg(Env.getCtx(), "Select"));
		columnNames.add(Msg.translate(Env.getCtx(), "Date"));
		columnNames.add(Msg.getElement(Env.getCtx(), "X_DepositBatch_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "Amount"));
		columnNames.add(Msg.translate(Env.getCtx(), "ConvertedAmount"));
		columnNames.add(Msg.translate(Env.getCtx(), "C_BankAccount_ID"));		

	    return columnNames;
	}
	
	public void info(IMiniTable miniTable, IStatusBar statusBar)
	{		
		DecimalFormat format = DisplayType.getNumberFormat(DisplayType.Amount);
		BigDecimal total = new BigDecimal(0);
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