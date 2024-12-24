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
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

/**
 * Create C_BankStatementLine for C_BankStatement
 * @author Elaine
 *
 */
public abstract class CreateFromStatement extends CreateFromBatch 
{
	/**
	 * 
	 * @param mTab
	 */
	public CreateFromStatement(GridTab mTab) 
	{
		super(mTab);
		if (log.isLoggable(Level.INFO)) log.info(mTab.toString());
	}

	@Override
	protected boolean dynInit() throws Exception
	{
		log.config("");
		setTitle(Msg.getElement(Env.getCtx(), "C_BankStatement_ID") + " .. " + Msg.translate(Env.getCtx(), "CreateFrom"));
		
		return true;
	}
	
	/**
	 * @return transactions (selection,dateTrx,[c_payment_id,documentNo],[c_currency_id,iso_code],payamt,convertedAmt,bpName)
	 */
	@Override
	protected Vector<Vector<Object>> getBankAccountData(Integer BankAccount, Integer BPartner, String DocumentNo, 
			Timestamp DateFrom, Timestamp DateTo, BigDecimal AmtFrom, BigDecimal AmtTo, Integer DocType, String TenderType, String AuthCode, Integer Currency)
	{
		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		
		StringBuilder sql = new StringBuilder();
		sql.append("WITH Payments AS ( ");
		sql.append("SELECT p.DateTrx as DateTrx, p.C_Payment_ID, NULL AS C_DepositBatch_ID, p.DocumentNo, p.C_Currency_ID, c.ISO_Code, p.PayAmt,");
		sql.append(" currencyConvert(p.PayAmt,p.C_Currency_ID,ba.C_Currency_ID,p.DateAcct,p.C_ConversionType_ID,p.AD_Client_ID,p.AD_Org_ID) AS ConvAmount, bp.Name,");
		sql.append(" p.Processed, p.C_BankAccount_ID, p.C_DocType_ID, p.TenderType, p.R_AuthCode, p.C_BPartner_ID ");
		sql.append("FROM C_BankAccount ba");
		sql.append(" INNER JOIN C_Payment_v p ON (p.C_BankAccount_ID=ba.C_BankAccount_ID)");
		sql.append(" INNER JOIN C_Currency c ON (p.C_Currency_ID=c.C_Currency_ID)");
		sql.append(" LEFT OUTER JOIN C_BPartner bp ON (p.C_BPartner_ID=bp.C_BPartner_ID) ");
		sql.append(" WHERE (p.C_DepositBatch_ID = 0 OR p.C_DepositBatch_ID IS NULL) ");
		sql.append(" AND p.IsReconciled = 'N'");
		sql.append(" AND p.DocStatus IN ('CO','CL') AND p.PayAmt<>0");
		sql.append(" AND NOT EXISTS (SELECT 1 FROM C_BankStatementLine l WHERE p.C_Payment_ID=l.C_Payment_ID AND l.StmtAmt <> 0)");
		
		// Add Deposit Batch in selection
		sql.append("UNION ALL ");
		sql.append("SELECT db.DateDeposit AS DateTrx, NULL AS C_Payment_ID, db.C_DepositBatch_ID, db.DocumentNo, p.C_Currency_ID, c.ISO_Code, SUM(p.PayAmt) AS PayAmt,");
		sql.append(" SUM(currencyConvert(p.PayAmt,p.C_Currency_ID,ba.C_Currency_ID,p.DateAcct,p.C_ConversionType_ID,p.AD_Client_ID,p.AD_Org_ID)) AS ConvAmount, NULL As Name,");
		sql.append(" p.Processed, p.C_BankAccount_ID, p.C_DocType_ID, NULL AS TenderType, NULL AS R_AuthCode, NULL AS C_BPartner_ID ");
		sql.append(" FROM C_BankAccount ba");
		sql.append(" INNER JOIN C_DepositBatch db ON (db.C_BankAccount_ID=ba.C_BankAccount_ID)");
		sql.append(" INNER JOIN C_DepositBatchLine dbl ON (dbl.C_DepositBatch_ID = db.C_DepositBatch_ID)");
		sql.append(" INNER JOIN C_Payment_v p ON (p.C_Payment_ID=dbl.C_Payment_ID)");
		sql.append(" INNER JOIN C_Currency c ON (p.C_Currency_ID=c.C_Currency_ID)");
		sql.append(" WHERE db.DocStatus IN ('CO','CL') AND db.DepositAmt<>0");
	    sql.append(" AND NOT EXISTS (SELECT 1 FROM C_BankStatementLine l WHERE p.C_Payment_ID=l.C_Payment_ID AND l.StmtAmt <> 0)");
		sql.append(" AND NOT EXISTS (SELECT 1 FROM C_BankStatementLine l WHERE db.C_DepositBatch_ID=l.C_DepositBatch_ID AND l.StmtAmt <> 0)");
		sql.append(" GROUP BY db.C_DepositBatch_ID,db.DocumentNo,p.C_Currency_ID, c.ISO_Code, db.DateDeposit, p.Processed, p.C_BankAccount_ID, p.C_DocType_ID ");
		
		sql.append(") SELECT DateTrx, C_Payment_ID, C_DepositBatch_ID, DocumentNo, C_Currency_ID, ISO_Code, PayAmt, ConvAmount, Name FROM Payments p ");
		sql.append(getSQLWhere(BPartner, DocumentNo, DateFrom, DateTo, AmtFrom, AmtTo, DocType, TenderType, AuthCode, Currency, 0));
		sql.append(" ORDER BY DateTrx");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), getTrxName());
			setParameters(pstmt, BankAccount, BPartner, DocumentNo, DateFrom, DateTo, AmtFrom, AmtTo, DocType, TenderType, AuthCode, Currency, 0);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				Vector<Object> line = new Vector<Object>(7);
				line.add(Boolean.FALSE);       //  0-Selection
				line.add(rs.getTimestamp(1));       //  1-DateTrx
				if (rs.getInt(2) > 0)
					line.add(new KeyNamePair(rs.getInt(2), rs.getString(4)));
				else
					line.add(null); 				// 2-C_Payment_ID
				
				if (rs.getInt(3) > 0)
					line.add(new KeyNamePair(rs.getInt(3), rs.getString(4)));					
				else 
					line.add(null);					// 3-DepositBatch
				line.add(new KeyNamePair(rs.getInt(5), rs.getString(6))); //  4-Currency
				line.add(rs.getBigDecimal(7));      //  5-PayAmt
				line.add(rs.getBigDecimal(8));      //  6-Conv Amt
				line.add(rs.getString(9));      	//  7-BParner
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
			rs = null; pstmt = null;
		}
		
		return data;
	}
	
	/**
	 * set class/type of columns
	 * @param miniTable
	 */
	protected void configureMiniTable(IMiniTable miniTable)
	{
		miniTable.setColumnClass(0, Boolean.class, false);      //  0-Selection
		miniTable.setColumnClass(1, Timestamp.class, false);    //  1-TrxDate / nmicoud - idempiere 240 Let user choose the 'Statement Line Date'
		miniTable.setColumnClass(2, String.class, true);        //  2-Payment
		miniTable.setColumnClass(3, String.class, true);        //  3-DepositBatch
		miniTable.setColumnClass(4, String.class, true);        //  4-Currency
		miniTable.setColumnClass(5, BigDecimal.class, true);    //  5-Amount
		miniTable.setColumnClass(6, BigDecimal.class, true);    //  6-ConvAmount
		miniTable.setColumnClass(7, String.class, true);    	//  7-BPartner
		//  Table UI
		miniTable.autoSize();
	}

	/**
	 * Create C_BankStatementLine
	 */
	@Override
	public boolean save(IMiniTable miniTable, String trxName)
	{
		//  fixed values
		int C_BankStatement_ID = ((Integer) getGridTab().getValue("C_BankStatement_ID")).intValue();
		MBankStatement bs = (MBankStatement) MTable.get(Env.getCtx(), MBankStatement.Table_ID).getPO(
				C_BankStatement_ID, trxName);
		if (log.isLoggable(Level.CONFIG)) log.config(bs.toString());

		//  Lines
		for(int i = 0; i < miniTable.getRowCount(); i++)
		{
			if(((Boolean) miniTable.getValueAt(i, 0)).booleanValue())
			{
				int C_Payment_ID = 0;
				int C_DepositBatch_ID = 0;
				
				Timestamp trxDate = (Timestamp) miniTable.getValueAt(i, 1);  //  1-DateTrx
				KeyNamePair pp = (KeyNamePair) miniTable.getValueAt(i, 2);   //  2-C_Payment_ID
				if (pp != null)
					C_Payment_ID = pp.getKey();
				
				pp = (KeyNamePair) miniTable.getValueAt(i, 3);   			//  3-C_DepositBatch_ID
				if (pp != null)
					C_DepositBatch_ID = pp.getKey();
				pp = (KeyNamePair) miniTable.getValueAt(i, 4);               //  4-Currency
				int C_Currency_ID = pp.getKey();
				BigDecimal TrxAmt = (BigDecimal) miniTable.getValueAt(i, 6); //  6- Conv Amt

				if (log.isLoggable(Level.FINE)) log.fine("Line Date=" + trxDate
					+ ", Payment=" + C_Payment_ID + ", Currency=" + C_Currency_ID + ", Amt=" + TrxAmt);
				//	
				MBankStatementLine bsl = new MBankStatementLine (bs);
				bsl.setStatementLineDate(trxDate);
				if (C_Payment_ID > 0)
					bsl.setPayment((MPayment) MTable.get(Env.getCtx(), MPayment.Table_ID).getPO(C_Payment_ID,trxName));
				
				if (C_DepositBatch_ID > 0)
					bsl.setC_DepositBatch_ID(C_DepositBatch_ID);
				
				bsl.setTrxAmt(TrxAmt);
				bsl.setStmtAmt(TrxAmt);
				bsl.setC_Currency_ID(bs.getBankAccount().getC_Currency_ID()); 
				
				if (!bsl.save())
					log.log(Level.SEVERE, "Line not created #" + i);
			}   //   if selected
		}   //  for all rows
		return true;
	}   //  save
	
	/**
	 * 
	 * @return column header names (select,date,payment,currency,amount,convertedAmount,bpartner)
	 */
	protected Vector<String> getOISColumnNames()
	{
		//  Header Info
		Vector<String> columnNames = new Vector<String>(7);
		columnNames.add(Msg.getMsg(Env.getCtx(), "Select"));
		columnNames.add(Msg.translate(Env.getCtx(), "Date"));
		columnNames.add(Msg.getElement(Env.getCtx(), "C_Payment_ID"));
		columnNames.add(Msg.getElement(Env.getCtx(), "C_DepositBatch_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "C_Currency_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "Amount"));
		columnNames.add(Msg.translate(Env.getCtx(), "ConvertedAmount"));
		columnNames.add(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
	    
	    return columnNames;
	}
	
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
				total = total.add((BigDecimal) miniTable.getValueAt(i, 5));
				count++;
			}
		}
		statusBar.setStatusLine(String.valueOf(count) + " - " + Msg.getMsg(Env.getCtx(), "Sum") + "  " + format.format(total));
	}
	
}