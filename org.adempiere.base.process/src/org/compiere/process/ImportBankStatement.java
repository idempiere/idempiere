/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.MBankAccount;
import org.compiere.model.MBankStatement;
import org.compiere.model.MBankStatementLine;
import org.compiere.model.X_I_BankStatement;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	Import Bank Statement from I_BankStatement
 *
 *	author Eldir Tomassen
 *	@version $Id: ImportBankStatement.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class ImportBankStatement extends SvrProcess
{
	/**	Client to be imported to		*/
	private int				p_AD_Client_ID = 0;
	/**	Organization to be imported to	*/
	private int				p_AD_Org_ID = 0;
	/** Default Bank Account			*/
	private int				p_C_BankAccount_ID = 0;
	/**	Delete old Imported				*/
	private boolean			p_deleteOldImported = false;
	
	/** Properties						*/
	private Properties 		m_ctx;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Client_ID"))
				p_AD_Client_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("AD_Org_ID"))
				p_AD_Org_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_BankAccount_ID"))
				p_C_BankAccount_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("DeleteOldImported"))
				p_deleteOldImported = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		m_ctx = Env.getCtx();
	}	//	prepare


	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws java.lang.Exception
	{
		StringBuilder msglog = new StringBuilder("AD_Org_ID=").append(p_AD_Org_ID).append(", C_BankAccount_ID").append(p_C_BankAccount_ID);
		log.info(msglog.toString());
		StringBuilder sql = null;
		int no = 0;
		StringBuilder clientCheck = new StringBuilder(" AND AD_Client_ID=").append(p_AD_Client_ID);

		//	****	Prepare	****

		//	Delete Old Imported
		if (p_deleteOldImported)
		{
			sql = new StringBuilder ("DELETE I_BankStatement ")
				  .append("WHERE I_IsImported='Y'").append (clientCheck);
			no = DB.executeUpdate(sql.toString(), get_TrxName());
			if (log.isLoggable(Level.FINE)) log.fine("Delete Old Impored =" + no);
		}

		//	Set Client, Org, IsActive, Created/Updated
		sql = new StringBuilder ("UPDATE I_BankStatement ")
			  .append("SET AD_Client_ID = COALESCE (AD_Client_ID,").append (p_AD_Client_ID).append ("),")
			  .append(" AD_Org_ID = COALESCE (AD_Org_ID,").append (p_AD_Org_ID).append ("),");
		sql.append(" IsActive = COALESCE (IsActive, 'Y'),")
			  .append(" Created = COALESCE (Created, SysDate),")
			  .append(" CreatedBy = COALESCE (CreatedBy, 0),")
			  .append(" Updated = COALESCE (Updated, SysDate),")
			  .append(" UpdatedBy = COALESCE (UpdatedBy, 0),")
			  .append(" I_ErrorMsg = ' ',")
			  .append(" I_IsImported = 'N' ")
			  .append("WHERE I_IsImported<>'Y' OR I_IsImported IS NULL OR AD_Client_ID IS NULL OR AD_Org_ID IS NULL OR AD_Client_ID=0 OR AD_Org_ID=0");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		log.info ("Reset=" + no);

		sql = new StringBuilder ("UPDATE I_BankStatement o ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Org, '")
			.append("WHERE (AD_Org_ID IS NULL OR AD_Org_ID=0")
			.append(" OR EXISTS (SELECT * FROM AD_Org oo WHERE o.AD_Org_ID=oo.AD_Org_ID AND (oo.IsSummary='Y' OR oo.IsActive='N')))")
			.append(" AND I_IsImported<>'Y'").append (clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning ("Invalid Org=" + no);
			
		//	Set Bank Account
		sql = new StringBuilder("UPDATE I_BankStatement i ")
			.append("SET C_BankAccount_ID=")
			.append("( ")
			.append(" SELECT C_BankAccount_ID ")
			.append(" FROM C_BankAccount a, C_Bank b ")
			.append(" WHERE b.IsOwnBank='Y' ")
			.append(" AND a.AD_Client_ID=i.AD_Client_ID ")
			.append(" AND a.C_Bank_ID=b.C_Bank_ID ")
			.append(" AND a.AccountNo=i.BankAccountNo ")
			.append(" AND b.RoutingNo=i.RoutingNo ")
			.append(" OR b.SwiftCode=i.RoutingNo ")
			.append(") ")
			.append("WHERE i.C_BankAccount_ID IS NULL ")
			.append("AND i.I_IsImported<>'Y' ")
			.append("OR i.I_IsImported IS NULL").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Bank Account (With Routing No)=" + no);
		//
		sql = new StringBuilder("UPDATE I_BankStatement i ") 
		 	.append("SET C_BankAccount_ID=")
			.append("( ")
			.append(" SELECT C_BankAccount_ID ")
			.append(" FROM C_BankAccount a, C_Bank b ")
			.append(" WHERE b.IsOwnBank='Y' ")
			.append(" AND a.C_Bank_ID=b.C_Bank_ID ") 
			.append(" AND a.AccountNo=i.BankAccountNo ")
			.append(" AND a.AD_Client_ID=i.AD_Client_ID ")
			.append(") ")
			.append("WHERE i.C_BankAccount_ID IS NULL ")
			.append("AND i.I_isImported<>'Y' ")
			.append("OR i.I_isImported IS NULL").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Bank Account (Without Routing No)=" + no);
		//
		sql = new StringBuilder("UPDATE I_BankStatement i ")
			.append("SET C_BankAccount_ID=(SELECT C_BankAccount_ID FROM C_BankAccount a WHERE a.C_BankAccount_ID=").append(p_C_BankAccount_ID)
			.append(" and a.AD_Client_ID=i.AD_Client_ID) ")
			.append("WHERE i.C_BankAccount_ID IS NULL ")
			.append("AND i.BankAccountNo IS NULL ")
			.append("AND i.I_isImported<>'Y' ")
			.append("OR i.I_isImported IS NULL").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Bank Account=" + no);
		//	
		sql = new StringBuilder("UPDATE I_BankStatement ")
			.append("SET I_isImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Bank Account, ' ")
			.append("WHERE C_BankAccount_ID IS NULL ")
			.append("AND I_isImported<>'Y' ")
			.append("OR I_isImported IS NULL").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning("Invalid Bank Account=" + no);
		 
		//	Set Currency
		sql = new StringBuilder ("UPDATE I_BankStatement i ")
			.append("SET C_Currency_ID=(SELECT C_Currency_ID FROM C_Currency c")
			.append(" WHERE i.ISO_Code=c.ISO_Code AND c.AD_Client_ID IN (0,i.AD_Client_ID)) ")
			.append("WHERE C_Currency_ID IS NULL")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Set Currency=" + no);
		//
		sql = new StringBuilder("UPDATE I_BankStatement i ")
			.append("SET C_Currency_ID=(SELECT C_Currency_ID FROM C_BankAccount WHERE C_BankAccount_ID=i.C_BankAccount_ID) ")
			.append("WHERE i.C_Currency_ID IS NULL ")
			.append("AND i.ISO_Code IS NULL").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Set Currency=" + no);
		//
		sql = new StringBuilder ("UPDATE I_BankStatement ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'ERR=Invalid Currency,' ")
			.append("WHERE C_Currency_ID IS NULL ")
			.append("AND I_IsImported<>'E' ")
			.append(" AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.warning("Invalid Currency=" + no);
		
		 
		//	Set Amount
		 sql = new StringBuilder("UPDATE I_BankStatement ")
		 	.append("SET ChargeAmt=0 ")
			.append("WHERE ChargeAmt IS NULL ")
			.append("AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Charge Amount=" + no);
		//
		 sql = new StringBuilder("UPDATE I_BankStatement ")
		 	.append("SET InterestAmt=0 ")
			.append("WHERE InterestAmt IS NULL ")
			.append("AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Interest Amount=" + no);
		//
		 sql = new StringBuilder("UPDATE I_BankStatement ")
		 	.append("SET TrxAmt=StmtAmt - InterestAmt - ChargeAmt ")
			.append("WHERE TrxAmt IS NULL ")
			.append("AND I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Transaction Amount=" + no);
		//
		sql = new StringBuilder("UPDATE I_BankStatement ")
			.append("SET I_isImported='E', I_ErrorMsg=I_ErrorMsg||'Err=Invalid Amount, ' ")
			.append("WHERE TrxAmt + ChargeAmt + InterestAmt <> StmtAmt ")
			.append("AND I_isImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Invaid Amount=" + no);
		 
		 //	Set Valuta Date
		sql = new StringBuilder("UPDATE I_BankStatement ")
		 	.append("SET ValutaDate=StatementLineDate ")
			.append("WHERE ValutaDate IS NULL ")
			.append("AND I_isImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Valuta Date=" + no);
			
		//	Check Payment<->Invoice combination
		sql = new StringBuilder("UPDATE I_BankStatement ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'Err=Invalid Payment<->Invoice, ' ")
			.append("WHERE I_BankStatement_ID IN ")
				.append("(SELECT I_BankStatement_ID ")
				.append("FROM I_BankStatement i")
				.append(" INNER JOIN C_Payment p ON (i.C_Payment_ID=p.C_Payment_ID) ")
				.append("WHERE i.C_Invoice_ID IS NOT NULL ")
				.append(" AND p.C_Invoice_ID IS NOT NULL ")
				.append(" AND p.C_Invoice_ID<>i.C_Invoice_ID) ")
			.append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Payment<->Invoice Mismatch=" + no);
			
		//	Check Payment<->BPartner combination
		sql = new StringBuilder("UPDATE I_BankStatement ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'Err=Invalid Payment<->BPartner, ' ")
			.append("WHERE I_BankStatement_ID IN ")
				.append("(SELECT I_BankStatement_ID ")
				.append("FROM I_BankStatement i")
				.append(" INNER JOIN C_Payment p ON (i.C_Payment_ID=p.C_Payment_ID) ")
				.append("WHERE i.C_BPartner_ID IS NOT NULL ")
				.append(" AND p.C_BPartner_ID IS NOT NULL ")
				.append(" AND p.C_BPartner_ID<>i.C_BPartner_ID) ")
			.append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Payment<->BPartner Mismatch=" + no);
			
		//	Check Invoice<->BPartner combination
		sql = new StringBuilder("UPDATE I_BankStatement ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'Err=Invalid Invoice<->BPartner, ' ")
			.append("WHERE I_BankStatement_ID IN ")
				.append("(SELECT I_BankStatement_ID ")
				.append("FROM I_BankStatement i")
				.append(" INNER JOIN C_Invoice v ON (i.C_Invoice_ID=v.C_Invoice_ID) ")
				.append("WHERE i.C_BPartner_ID IS NOT NULL ")
				.append(" AND v.C_BPartner_ID IS NOT NULL ")
				.append(" AND v.C_BPartner_ID<>i.C_BPartner_ID) ")
			.append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Invoice<->BPartner Mismatch=" + no);
			
		//	Check Invoice.BPartner<->Payment.BPartner combination
		sql = new StringBuilder("UPDATE I_BankStatement ")
			.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'Err=Invalid Invoice.BPartner<->Payment.BPartner, ' ")
			.append("WHERE I_BankStatement_ID IN ")
				.append("(SELECT I_BankStatement_ID ")
				.append("FROM I_BankStatement i")
				.append(" INNER JOIN C_Invoice v ON (i.C_Invoice_ID=v.C_Invoice_ID)")
				.append(" INNER JOIN C_Payment p ON (i.C_Payment_ID=p.C_Payment_ID) ")
				.append("WHERE p.C_Invoice_ID<>v.C_Invoice_ID")
				.append(" AND v.C_BPartner_ID<>p.C_BPartner_ID) ")
			.append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.info("Invoice.BPartner<->Payment.BPartner Mismatch=" + no);
			
		//	Detect Duplicates
		 sql = new StringBuilder("SELECT i.I_BankStatement_ID, l.C_BankStatementLine_ID, i.EftTrxID ")
			.append("FROM I_BankStatement i, C_BankStatement s, C_BankStatementLine l ")
			.append("WHERE i.I_isImported='N' ")
			.append("AND s.C_BankStatement_ID=l.C_BankStatement_ID ")
			.append("AND i.EftTrxID IS NOT NULL AND ")
			//	Concatenate EFT Info
			.append("(l.EftTrxID||l.EftAmt||l.EftStatementLineDate||l.EftValutaDate||l.EftTrxType||l.EftCurrency||l.EftReference||s.EftStatementReference ")
			.append("||l.EftCheckNo||l.EftMemo||l.EftPayee||l.EftPayeeAccount) ")
			.append("= ")
			.append("(i.EftTrxID||i.EftAmt||i.EftStatementLineDate||i.EftValutaDate||i.EftTrxType||i.EftCurrency||i.EftReference||i.EftStatementReference ")
			.append("||i.EftCheckNo||i.EftMemo||i.EftPayee||i.EftPayeeAccount) ");
		
		StringBuilder updateSql = new StringBuilder("UPDATE I_Bankstatement ")
				.append("SET I_IsImported='E', I_ErrorMsg=I_ErrorMsg||'Err=Duplicate['||?||']' ")
				.append("WHERE I_BankStatement_ID=?").append(clientCheck);
		PreparedStatement pupdt = DB.prepareStatement(updateSql.toString(), get_TrxName());
		
		PreparedStatement pstmtDuplicates = null;
		ResultSet rs = null;
		no = 0;
		try
		{
			pstmtDuplicates = DB.prepareStatement(sql.toString(), get_TrxName());
			rs = pstmtDuplicates.executeQuery();
			while (rs.next())
			{
				StringBuilder info = new StringBuilder("Line_ID=").append(rs.getInt(2))		//	l.C_BankStatementLine_ID
				 .append(",EDTTrxID=").append(rs.getString(3));			//	i.EftTrxID
				pupdt.setString(1, info.toString());	
				pupdt.setInt(2, rs.getInt(1));	//	i.I_BankStatement_ID
				pupdt.executeUpdate();
				no++;
			}
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "DetectDuplicates " + e.getMessage());
		}
		finally
		{
			DB.close(rs, pstmtDuplicates);
			rs = null;pstmtDuplicates = null;
			DB.close(pupdt);
			pupdt = null;
		}
		if (no != 0)
			log.info("Duplicates=" + no);
		
		commitEx();
		
		//Import Bank Statement
		sql = new StringBuilder("SELECT * FROM I_BankStatement")
			.append(" WHERE I_IsImported='N'")
			.append(" ORDER BY C_BankAccount_ID, Name, EftStatementDate, EftStatementReference");
			
		MBankStatement statement = null;
		MBankAccount account = null;
		PreparedStatement pstmt = null;
		int lineNo = 10;
		int noInsert = 0;
		int noInsertLine = 0;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			rs = pstmt.executeQuery();
				
			while (rs.next())
			{ 
				X_I_BankStatement imp = new X_I_BankStatement(m_ctx, rs, get_TrxName());
				//	Get the bank account for the first statement
				if (account == null)
				{
					account = MBankAccount.get (m_ctx, imp.getC_BankAccount_ID());
					statement = null;
					msglog = new StringBuilder("New Statement, Account=").append(account.getAccountNo());
					log.info(msglog.toString());
				}
				//	Create a new Bank Statement for every account
				else if (account.getC_BankAccount_ID() != imp.getC_BankAccount_ID())
				{
					account = MBankAccount.get (m_ctx, imp.getC_BankAccount_ID());
					statement = null;
					msglog = new StringBuilder("New Statement, Account=").append(account.getAccountNo());
					log.info(msglog.toString());
				}
				//	Create a new Bank Statement for every statement name
				else if ((statement.getName() != null) && (imp.getName() != null))
				{
					if (!statement.getName().equals(imp.getName()))
					{
						statement = null;
						msglog = new StringBuilder("New Statement, Statement Name=").append(imp.getName());
						log.info(msglog.toString());
					}
				}
				//	Create a new Bank Statement for every statement reference
				else if ((statement.getEftStatementReference() != null) && (imp.getEftStatementReference() != null))
				{
					if (!statement.getEftStatementReference().equals(imp.getEftStatementReference()))
					{
						statement = null;
						msglog = new StringBuilder("New Statement, Statement Reference=").append(imp.getEftStatementReference());
						log.info(msglog.toString());
					}
				}
				//	Create a new Bank Statement for every statement date
				else if ((statement.getStatementDate() != null) && (imp.getStatementDate() != null))
				{
					if (!statement.getStatementDate().equals(imp.getStatementDate()))
					{
						statement = null;
						msglog = new StringBuilder("New Statement, Statement Date=").append(imp.getStatementDate());
						log.info(msglog.toString());
					}
				}
				
				//	New Statement
				if (statement == null)
				{
					statement = new MBankStatement(account);
					statement.setEndingBalance(Env.ZERO);
					
					//	Copy statement data
					if (imp.getName() != null) {
						statement.setName(imp.getName());
					}
					if (imp.getStatementDate() != null) {
						statement.setStatementDate(imp.getStatementDate());
					}
					if (imp.getDateAcct() != null) {
						statement.setDateAcct(imp.getDateAcct());
					} else {
						statement.setDateAcct(statement.getStatementDate());
					}
					statement.setDescription(imp.getDescription());
					statement.setEftStatementReference(imp.getEftStatementReference());
					statement.setEftStatementDate(imp.getEftStatementDate());
					if (statement.save())
					{
						noInsert++;
					}
					lineNo = 10;
				}
				
				//	New StatementLine
				MBankStatementLine line = new MBankStatementLine(statement, lineNo);
				
				//	Copy statement line data
				//line.setC_BPartner_ID(imp.getC_BPartner_ID());
				//line.setC_Invoice_ID(imp.getC_Invoice_ID());
				line.setReferenceNo(imp.getReferenceNo());
				line.setDescription(imp.getLineDescription());
				line.setStatementLineDate(imp.getStatementLineDate());
				// line.setDateAcct(imp.getStatementLineDate()); // set on beforeSave
				line.setValutaDate(imp.getValutaDate());
				line.setIsReversal(imp.isReversal());
				line.setC_Currency_ID(imp.getC_Currency_ID());
				line.setTrxAmt(imp.getTrxAmt());
				line.setStmtAmt(imp.getStmtAmt());
				if (imp.getC_Charge_ID() != 0)
				{
					line.setC_Charge_ID(imp.getC_Charge_ID());
				}
				line.setInterestAmt(imp.getInterestAmt());
				line.setChargeAmt(imp.getChargeAmt());
				line.setMemo(imp.getMemo());
				if (imp.getC_Payment_ID() != 0)
				{
					line.setC_Payment_ID(imp.getC_Payment_ID());
				}
				
				//	Copy statement line reference data
				line.setEftTrxID(imp.getEftTrxID());
				line.setEftTrxType(imp.getEftTrxType());
				line.setEftCheckNo(imp.getEftCheckNo());
				line.setEftReference(imp.getEftReference());
				line.setEftMemo(imp.getEftMemo());
				line.setEftPayee(imp.getEftPayee());
				line.setEftPayeeAccount(imp.getEftPayeeAccount());
				line.setEftStatementLineDate(imp.getEftStatementLineDate());
				line.setEftValutaDate(imp.getEftValutaDate());
				line.setEftCurrency(imp.getEftCurrency());
				line.setEftAmt(imp.getEftAmt());
				
				//	Save statement line
				if (line.save())
				{
					imp.setC_BankStatement_ID(statement.getC_BankStatement_ID());
					imp.setC_BankStatementLine_ID(line.getC_BankStatementLine_ID());
					imp.setI_IsImported(true);
					imp.setProcessed(true);
					imp.saveEx();
					noInsertLine++;
					lineNo += 10;	
				}
				line = null;
				
			}
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		//	Set Error to indicator to not imported
		sql = new StringBuilder ("UPDATE I_BankStatement ")
			.append("SET I_IsImported='N', Updated=SysDate ")
			.append("WHERE I_IsImported<>'Y'").append(clientCheck);
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog (0, null, new BigDecimal (no), "@Errors@");
		//
		addLog (0, null, new BigDecimal (noInsert), "@C_BankStatement_ID@: @Inserted@");
		addLog (0, null, new BigDecimal (noInsertLine), "@C_BankStatementLine_ID@: @Inserted@");
		return "";

	}	//	doIt

}	//	ImportBankStatement
