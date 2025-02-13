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
 *                                                                            *
 *  Contributors:                                                             *
 *    Carlos Ruiz - GlobalQSS:                                                *
 *      FR 3132033 - Make payment export class configurable per bank
 *    Markus Bozem:  IDEMPIERE-1546 / IDEMPIERE-3286        				  *
 *****************************************************************************/
package org.compiere.apps.form;

import static org.compiere.model.SystemIDs.REFERENCE_PAYMENTRULE;

import java.io.File;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPaymentBatch;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.PaymentExport;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;

import com.lowagie.text.pdf.PdfReader;

/**
 * Form to Print and Export payment.
 */
public class PayPrint {

	/**	Window No			*/
	protected int         	m_WindowNo = 0;
	/**	Used Bank Account	*/
	protected int				m_C_BankAccount_ID = -1;
	/**	Export Class for Bank Account	*/
	protected String			m_PaymentExportClass = null;
	/**	Payment Selection	*/
	protected int         		m_C_PaySelection_ID = 0;

	/** Payment Information */
	protected MPaySelectionCheck[]     m_checks = null;
	/** Payment Batch		*/
	protected MPaymentBatch	m_batch = null; 
	/**	Logger			*/
	protected static final CLogger log = CLogger.getCLogger(PayPrint.class);
	
	protected String bank;
	protected String currency;
	protected BigDecimal balance;
	protected PaymentExport m_PaymentExport;
	
	/**
	 *  Load pay selection (C_PaySelection) details (bank info, balance and payment export class)
	 *  @param C_PaySelection_ID
	 */
	public void loadPaySelectInfo(int C_PaySelection_ID)
	{
		//  load Banks from PaySelectLine
		m_C_BankAccount_ID = -1;
		String sql = "SELECT ps.C_BankAccount_ID, b.Name || ' ' || ba.AccountNo,"	//	1..2
			+ " c.ISO_Code, CurrentBalance, ba.PaymentExportClass "					//	3..5
			+ "FROM C_PaySelection ps"
			+ " INNER JOIN C_BankAccount ba ON (ps.C_BankAccount_ID=ba.C_BankAccount_ID)"
			+ " INNER JOIN C_Bank b ON (ba.C_Bank_ID=b.C_Bank_ID)"
			+ " INNER JOIN C_Currency c ON (ba.C_Currency_ID=c.C_Currency_ID) "
			+ "WHERE ps.C_PaySelection_ID=? AND ps.Processed='Y' AND ba.IsActive='Y'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, C_PaySelection_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				m_C_BankAccount_ID = rs.getInt(1);
				bank = rs.getString(2);
				currency = rs.getString(3);
				balance = rs.getBigDecimal(4);
				m_PaymentExportClass = rs.getString(5);
			}
			else
			{
				m_C_BankAccount_ID = -1;
				bank = "";
				currency = "";
				balance = Env.ZERO;
				m_PaymentExportClass = null;
				log.log(Level.SEVERE, "No active BankAccount for C_PaySelection_ID=" + C_PaySelection_ID);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
	}   //  loadPaySelectInfo

	/**
	 *  Get payment rules that's applicable to a pay selection record
	 *  @param C_PaySelection_ID
	 *  @return list of applicable payment rules
	 */
	public ArrayList<ValueNamePair> loadPaymentRule(int C_PaySelection_ID)
	{
		ArrayList<ValueNamePair> data = new ArrayList<ValueNamePair>();

		// load PaymentRule for Bank
		int AD_Reference_ID = REFERENCE_PAYMENTRULE;  //  MLookupInfo.getAD_Reference_ID("All_Payment Rule");
		Language language = Language.getLanguage(Env.getAD_Language(Env.getCtx()));
		MLookupInfo info = MLookupFactory.getLookup_List(language, AD_Reference_ID);
		String sql = info.Query.substring(0, info.Query.indexOf(" ORDER BY"))
			+ " AND " + info.KeyColumn
			+ " IN (SELECT PaymentRule FROM C_PaySelectionCheck WHERE C_PaySelection_ID=?) "
			+ info.Query.substring(info.Query.indexOf(" ORDER BY"));
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, C_PaySelection_ID);
			rs = pstmt.executeQuery();
			//
			while (rs.next())
			{
				ValueNamePair pp = new ValueNamePair(rs.getString(2), rs.getString(3));
				data.add(pp);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		if (data.size() == 0)
			if (log.isLoggable(Level.CONFIG)) log.config("PaySel=" + C_PaySelection_ID + ", BAcct=" + m_C_BankAccount_ID + " - " + sql);
		
		return data;
	}   //  loadPaymentRule
	
	protected String noPayments;
	protected Integer documentNo;
	protected Double sumPayments;
	protected Integer printFormatId;

	/**
	 *  PaymentRule changed - get next DocumentNo, No of Payments and total pay amount
	 *  @param C_PaySelection_ID
	 *  @param PaymentRule
	 *  @return error message (if any)
	 */
	public String loadPaymentRuleInfo(int C_PaySelection_ID, String PaymentRule)
	{
		String msg = null;
		
		// get number of payments and total payamt
		String sql = "SELECT COUNT(*),SUM(payamt) "
			+ "FROM C_PaySelectionCheck "
			+ "WHERE C_PaySelection_ID=? AND PaymentRule=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, C_PaySelection_ID);
			pstmt.setString(2, PaymentRule);
			rs = pstmt.executeQuery();
			//
			if (rs.next())
			{
				noPayments = String.valueOf(rs.getInt(1));
				sumPayments = rs.getDouble(2);
			}   
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		printFormatId = null;
		documentNo = null;
		
		// Next DocumentNo
		sql = "SELECT CurrentNext, Check_PrintFormat_ID "
			+ "FROM C_BankAccountDoc "
			+ "WHERE C_BankAccount_ID=? AND PaymentRule=? AND IsActive='Y'";
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_C_BankAccount_ID);
			pstmt.setString(2, PaymentRule);
			rs = pstmt.executeQuery();
			//
			if (rs.next())
			{
				documentNo = Integer.valueOf(rs.getInt(1));
				printFormatId = Integer.valueOf(rs.getInt(2));
			}
			else
			{
				log.log(Level.SEVERE, "VPayPrint.loadPaymentRuleInfo - No active BankAccountDoc for C_BankAccount_ID="
					+ m_C_BankAccount_ID + " AND PaymentRule=" + PaymentRule);
				msg = "VPayPrintNoDoc";
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return msg;
	}   //  loadPaymentRuleInfo
	
	/**
	 * Instantiate payment export service
	 * @param err error message buffer
	 * @return 0 if loaded fine, -1 if failed to load 
	 */
	protected int loadPaymentExportClass (StringBuffer err)
	{
		m_PaymentExport = null ;
		
		if (m_PaymentExportClass == null || m_PaymentExportClass.trim().length() == 0) {
			m_PaymentExportClass = "org.compiere.util.GenericPaymentExport";
		}
		try
		{
			m_PaymentExport = Core.getPaymentExporter(m_PaymentExportClass);			
			if (m_PaymentExport == null)
			{
				Class<?> clazz = Class.forName (m_PaymentExportClass);
				m_PaymentExport = (PaymentExport)clazz.getDeclaredConstructor().newInstance();
			}
			
		}
		catch (ClassNotFoundException e)
		{
			if (err!=null)
			{
				err.append("No custom PaymentExport class " + m_PaymentExportClass + " - " + e.toString());
				log.log(Level.SEVERE, err.toString(), e);
			}
			return -1;
		}
		catch (Exception e)
		{
			if (err!=null)
			{
				err.append("Error in " + m_PaymentExportClass + " check log, " + e.toString());
				log.log(Level.SEVERE, err.toString(), e);
			}
			return -1;
		}
		return 0 ;
	} // loadPaymentExportClass
	
	/**
	 * Create PDF documents (usually check) from pay selection check records
	 * @param startDocumentNo
	 * @param paymentRule
	 * @return list of PDF documents
	 * @throws Exception
	 */
	protected List<File> createCheckDocuments(int startDocumentNo, String paymentRule) throws Exception 
	{
		//	for all checks
		List<File> pdfList = new ArrayList<File>();
		int lastDocumentNo = startDocumentNo;
		for (int i = 0; i < m_checks.length; i++)
		{
			MPaySelectionCheck check = m_checks[i];
			
			//	Set new Check Document No
			check.setDocumentNo(String.valueOf(lastDocumentNo));
			check.saveEx(); 
			
			//	Update BankAccountDoc
			MPaySelectionCheck.confirmPrint(m_checks[i], m_batch);

			//	ReportCtrl will check BankAccountDoc for PrintFormat
			ReportEngine re = ReportEngine.get(Env.getCtx(), ReportEngine.CHECK, check.get_ID(), m_WindowNo);
			MPrintFormat format = re.getPrintFormat();
			File pdfFile = null;
			if (format.getJasperProcess_ID() > 0)	
			{
				ProcessInfo pi = new ProcessInfo("", format.getJasperProcess_ID());
				pi.setRecord_ID(check.get_ID());
				pi.setIsBatch(true);
				pi.setTransientObject(format);
									
				ServerProcessCtl.process(pi, null);
				pdfFile = pi.getPDFReport();
			}
			else
			{
				pdfFile = File.createTempFile("WPayPrint", null);
				re.getPDF(pdfFile);
			}
			
			if (pdfFile != null)
			{
				// increase the check document no by the number of pages of the generated pdf file
				try (PdfReader document = new PdfReader(pdfFile.getAbsolutePath())) {
					lastDocumentNo += document.getNumberOfPages();
				}
				pdfList.add(pdfFile);
			}
		}

		//	Update Check Next Document No		
		if (startDocumentNo != lastDocumentNo)
		{
			StringBuilder sb = new StringBuilder();
			sb.append("UPDATE C_BankAccountDoc SET CurrentNext=").append(lastDocumentNo)
				.append(" WHERE C_BankAccount_ID=").append(m_C_BankAccount_ID)
				.append(" AND PaymentRule='").append(paymentRule).append("'");
			DB.executeUpdate(sb.toString(), null);
		}
		
		return pdfList;
	}
	
	/**
	 * Create Remittance Documents (PDF) from pay selection check records
	 * @return list of Remittance documents
	 */
	protected List<File> createRemittanceDocuments()
	{		
		List<File> pdfList = new ArrayList<File>();
		for (int i = 0; i < m_checks.length; i++)
		{
			MPaySelectionCheck check = m_checks[i];
			ReportEngine re = ReportEngine.get(Env.getCtx(), ReportEngine.REMITTANCE, check.get_ID(), m_WindowNo);
			try
			{
				MPrintFormat format = re.getPrintFormat();
				if (format.getJasperProcess_ID() > 0)	
				{
					ProcessInfo pi = new ProcessInfo("", format.getJasperProcess_ID());
					pi.setRecord_ID(check.get_ID());
					pi.setIsBatch(true);
					pi.setTransientObject(format);
					
					ServerProcessCtl.process(pi, null);
					pdfList.add(pi.getPDFReport());
				}
				else
				{
					File file = File.createTempFile("WPayPrint", null);
					re.getPDF(file);
					pdfList.add(file);
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		}
		return pdfList;
	}
	
	/**
	 *  Get Checks
	 *  @param PaymentRule Payment Rule
	 *  @param startDocumentNo
	 *  @param error
	 *  @param trxName
	 *  @return true if payments were created
	 */
	protected boolean getChecks(String PaymentRule, BigDecimal startDocumentNo, AtomicReference<ValueNamePair> error, String trxName)
	{
		//  do we have values
		if (m_C_PaySelection_ID <= 0 || m_C_BankAccount_ID == -1
			|| Util.isEmpty(PaymentRule, true) || startDocumentNo == null)
		{
			error.set(new ValueNamePair("VPayPrintNoRecords", "(" + Msg.translate(Env.getCtx(), "C_PaySelectionLine_ID") + " #0"));
			return false;
		}

		if (log.isLoggable(Level.CONFIG)) log.config("C_PaySelection_ID=" + m_C_PaySelection_ID + ", PaymentRule=" +  PaymentRule);
		
		//	get payment selection checks without check no assignment
		m_checks = MPaySelectionCheck.get(m_C_PaySelection_ID, PaymentRule, trxName);

		//
		if (m_checks == null || m_checks.length == 0)
		{
			error.set(new ValueNamePair("VPayPrintNoRecords", "(" + Msg.translate(Env.getCtx(), "C_PaySelectionLine_ID") + " #0"));
			return false;
		}
		m_batch = MPaymentBatch.getForPaySelection (Env.getCtx(), m_C_PaySelection_ID, null);
		return true;
	}   //  getChecks
}
