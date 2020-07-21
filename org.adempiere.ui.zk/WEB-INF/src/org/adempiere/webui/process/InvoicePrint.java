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
package org.adempiere.webui.process;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MClient;
import org.compiere.model.MInvoice;
import org.compiere.model.MMailText;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MUser;
import org.compiere.model.MUserMail;
import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Util;

/**
 *	Print Invoices on Paper or send PDFs
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: InvoicePrint.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class InvoicePrint extends SvrProcess
{
	/**	Mail PDF			*/
	protected boolean		p_EMailPDF = false;
	/** Mail Template		*/
	protected int			p_R_MailText_ID = 0;
	
	protected Timestamp	m_dateInvoiced_From = null;
	protected Timestamp	m_dateInvoiced_To = null;
	protected int		m_C_BPartner_ID = 0;
	protected int		m_C_Invoice_ID = 0;
	protected String		m_DocumentNo_From = null;
	protected String		m_DocumentNo_To = null;
	private String		p_IsPaid = null;
	private int			m_C_DocType_ID = 0;
	private String		p_IsPrinted = null;
	private String		m_PaymentRule = null;
	private int	  	    m_C_PaymentTerm_ID = 0;
	private String		m_DocStatus = null;

	protected volatile StringBuffer sql = new StringBuffer();
	protected volatile List<Object> params = new ArrayList<Object>();

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null && para[i].getParameter_To() == null)
				;
			else if (name.equals("DateInvoiced"))
			{
				m_dateInvoiced_From = ((Timestamp)para[i].getParameter());
				m_dateInvoiced_To = ((Timestamp)para[i].getParameter_To());
			}
			else if (name.equals("EMailPDF"))
				p_EMailPDF = "Y".equals(para[i].getParameter());
			else if (name.equals("R_MailText_ID"))
				p_R_MailText_ID = para[i].getParameterAsInt();
			else if (name.equals("C_BPartner_ID"))
				m_C_BPartner_ID = para[i].getParameterAsInt();
			else if (name.equals("C_Invoice_ID"))
				m_C_Invoice_ID = para[i].getParameterAsInt();
			else if (name.equals("DocumentNo"))
			{
				m_DocumentNo_From = (String)para[i].getParameter();
				m_DocumentNo_To = (String)para[i].getParameter_To();
			}
			else if (name.equals("IsPaid"))
				p_IsPaid = (String)para[i].getParameter();
			else if (name.equals("C_DocType_ID"))
				m_C_DocType_ID = para[i].getParameterAsInt();
			else if (name.equals("IsPrinted"))
				p_IsPrinted = (String)para[i].getParameter();
			else if (name.equals("PaymentRule"))
				m_PaymentRule = (String)para[i].getParameter();
			else if (name.equals("C_PaymentTerm_ID"))
				m_C_PaymentTerm_ID = para[i].getParameterAsInt();
			else if (name.equals("DocStatus"))
				m_DocStatus = (String)para[i].getParameter();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
		if (m_DocumentNo_From != null && m_DocumentNo_From.length() == 0)
			m_DocumentNo_From = null;
		if (m_DocumentNo_To != null && m_DocumentNo_To.length() == 0)
			m_DocumentNo_To = null;
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws java.lang.Exception
	{
		//	Need to have Template
		if (p_EMailPDF && p_R_MailText_ID == 0)
			throw new AdempiereUserError ("@NotFound@: @R_MailText_ID@");
		if (log.isLoggable(Level.INFO)) log.info ("C_BPartner_ID=" + m_C_BPartner_ID
			+ ", C_Invoice_ID=" + m_C_Invoice_ID
			+ ", EmailPDF=" + p_EMailPDF + ",R_MailText_ID=" + p_R_MailText_ID
			+ ", DateInvoiced=" + m_dateInvoiced_From + "-" + m_dateInvoiced_To
			+ ", DocumentNo=" + m_DocumentNo_From + "-" + m_DocumentNo_To
			+ ", IsPaid=" + p_IsPaid
			+ ", C_DocType_ID=" + m_C_DocType_ID
			+ ", IsPrinted=" + p_IsPrinted
			+ ", PaymentRule=" + m_PaymentRule
			+ ", C_PaymentTerm_ID=" + m_C_PaymentTerm_ID
			+ ", DocStatus=" + m_DocStatus);
		
		MMailText mText = null;
		if (p_R_MailText_ID != 0)
		{
			mText = new MMailText(getCtx(), p_R_MailText_ID, get_TrxName());
			if (mText.get_ID() != p_R_MailText_ID)
				throw new AdempiereUserError ("@NotFound@: @R_MailText_ID@ - " + p_R_MailText_ID);
		}

		//	Too broad selection
		if (m_C_BPartner_ID == 0 && m_C_Invoice_ID == 0 && m_dateInvoiced_From == null && m_dateInvoiced_To == null
			&& m_DocumentNo_From == null && m_DocumentNo_To == null && m_PaymentRule == null && m_C_PaymentTerm_ID == 0
			&& m_DocStatus == null)
			throw new AdempiereUserError ("@RestrictSelection@");

		MClient client = MClient.get(getCtx());

		setSQLAndParams();
		if (log.isLoggable(Level.FINE)) log.fine(sql.toString());

		MPrintFormat format = null;
		int old_AD_PrintFormat_ID = -1;
		int old_C_Invoice_ID = -1;
		int C_BPartner_ID = 0;
		int count = 0;
		int errors = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		final List<File> pdfList = new ArrayList<File>();
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), get_TrxName());
			int idx = 1;
			for (Object param : params) {
				if (param instanceof Integer)
					pstmt.setInt(idx, (Integer) param);
				else if (param instanceof Timestamp)
					pstmt.setTimestamp(idx, (Timestamp) param);
				else
					pstmt.setString(idx, param.toString());
				idx++;
			}
			rs = pstmt.executeQuery();
						
			while (rs.next())
			{
				int C_Invoice_ID = rs.getInt(1);
				if (C_Invoice_ID == old_C_Invoice_ID)	//	multiple pf records
					continue;
				old_C_Invoice_ID = C_Invoice_ID;
				//	Set Language when enabled
				Language language = Language.getLoginLanguage();		//	Base Language
				String AD_Language = rs.getString(2);
				if (AD_Language != null && "Y".equals(rs.getString(3)))
					language = Language.getLanguage(AD_Language);
				//
				int AD_PrintFormat_ID = rs.getInt(4);
				int copies = rs.getInt(5);
				if (copies == 0)
					copies = 1;
				int AD_User_ID = rs.getInt(6);
				MUser to = new MUser (getCtx(), AD_User_ID, get_TrxName());
				String DocumentNo = rs.getString(7);
				C_BPartner_ID = rs.getInt(8);
				//
				String documentDir = client.getDocumentDir();
				if (documentDir == null || documentDir.length() == 0)
					documentDir = ".";
				//
				if (p_EMailPDF && (to.get_ID() == 0 || to.getEMail() == null || to.getEMail().length() == 0))
				{
					addLog (C_Invoice_ID, null, null, DocumentNo + " @RequestActionEMailNoTo@");
					errors++;
					continue;
				}
				if (AD_PrintFormat_ID == 0)
				{
					addLog (C_Invoice_ID, null, null, DocumentNo + " No Print Format");
					errors++;
					continue;
				}
				//	Get Format & Data
				if (AD_PrintFormat_ID != old_AD_PrintFormat_ID)
				{
					format = MPrintFormat.get (getCtx(), AD_PrintFormat_ID, false);
					old_AD_PrintFormat_ID = AD_PrintFormat_ID;
				}
				format.setLanguage(language);
				format.setTranslationLanguage(language);
				//	query
				MQuery query = new MQuery("C_Invoice_Header_v");
				query.addRestriction("C_Invoice_ID", MQuery.EQUAL, Integer.valueOf(C_Invoice_ID));

				//	Engine
				PrintInfo info = new PrintInfo(
					DocumentNo,
					MInvoice.Table_ID,
					C_Invoice_ID,
					C_BPartner_ID);
				info.setCopies(copies);
				ReportEngine re = new ReportEngine(getCtx(), format, query, info);
				boolean printed = false;
				if (p_EMailPDF)
				{
					String subject = mText.getMailHeader() + " - " + DocumentNo;
					EMail email = client.createEMail(to.getEMail(), subject, null);
					if (!email.isValid())
					{
						addLog (C_Invoice_ID, null, null,
						  DocumentNo + " @RequestActionEMailError@ Invalid EMail: " + to);
						errors++;
						continue;
					}
					mText.setUser(to);					//	Context
					mText.setBPartner(C_BPartner_ID);	//	Context
					mText.setPO(new MInvoice(getCtx(), C_Invoice_ID, get_TrxName()));
					String message = mText.getMailText(true);
					if (mText.isHtml())
						email.setMessageHTML(subject, message);
					else
					{
						email.setSubject (subject);
						email.setMessageText (message);
					}
					//
					File invoice = null;
					if (!Ini.isClient())
						invoice = new File(MInvoice.getPDFFileName(documentDir, C_Invoice_ID));
					File attachment = re.getPDF(invoice);
					if (log.isLoggable(Level.FINE)) log.fine(to + " - " + attachment);
					email.addAttachment(attachment);
					//
					String msg = email.send();
					MUserMail um = new MUserMail(mText, getAD_User_ID(), email);
					um.saveEx();
					if (msg.equals(EMail.SENT_OK))
					{
						addLog (C_Invoice_ID, null, null,
						  DocumentNo + " @RequestActionEMailOK@ - " + to.getEMail());
						count++;
						printed = true;
					}
					else
					{
						addLog (C_Invoice_ID, null, null,
						  DocumentNo + " @RequestActionEMailError@ " + msg
						  + " - " + to.getEMail());
						errors++;
					}
				}
				else
				{
					pdfList.add(re.getPDF());
					count++;
					printed = true;
				}
				//	Print Confirm
				if (printed)
				{
					StringBuffer sb = new StringBuffer ("UPDATE C_Invoice "
						+ "SET DatePrinted=getDate(), IsPrinted='Y' WHERE C_Invoice_ID=")
						.append (C_Invoice_ID);
					DB.executeUpdateEx(sb.toString(), get_TrxName());
				}
			}	//	for all entries						
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "doIt - " + sql, e);
			throw new Exception (e);
		}
		finally {
			DB.close(rs, pstmt);
		}
		
		if (processUI != null)
		{
			processUI.showReports(pdfList);
			}

		//
		if (p_EMailPDF)
			return "@Sent@=" + count + " - @Errors@=" + errors;
		return "@Printed@=" + count;
	}	//	doIt

	protected void setSQLAndParams() {
		//	Get Info
		sql.append(
			"SELECT i.C_Invoice_ID,bp.AD_Language,c.IsMultiLingualDocument,"		//	1..3
			//	Prio: 1. BPartner 2. DocType, 3. PrintFormat (Org)	//	see ReportCtl+MInvoice
			+ " COALESCE(bp.Invoice_PrintFormat_ID, dt.AD_PrintFormat_ID, pf.Invoice_PrintFormat_ID),"	//	4 
			+ " dt.DocumentCopies+bp.DocumentCopies,"								//	5
			+ " bpc.AD_User_ID, i.DocumentNo,"										//	6..7
			+ " bp.C_BPartner_ID "													//	8
			+ "FROM C_Invoice i"
			+ " INNER JOIN C_BPartner bp ON (i.C_BPartner_ID=bp.C_BPartner_ID)"
			+ " LEFT OUTER JOIN AD_User bpc ON (i.AD_User_ID=bpc.AD_User_ID)"
			+ " INNER JOIN AD_Client c ON (i.AD_Client_ID=c.AD_Client_ID)"
			+ " INNER JOIN AD_PrintForm pf ON (i.AD_Client_ID=pf.AD_Client_ID)"
			+ " INNER JOIN C_DocType dt ON (i.C_DocType_ID=dt.C_DocType_ID)"
		    + " WHERE i.AD_Client_ID=? AND i.isSOTrx='Y' AND "
		    + "       pf.AD_Org_ID IN (0,i.AD_Org_ID) " );	//	more them 1 PF
		params.add(Env.getAD_Client_ID(Env.getCtx()));
		if (m_C_Invoice_ID != 0) {
			sql.append(" AND i.C_Invoice_ID=?");
			params.add(m_C_Invoice_ID);
		} else {
			if (m_C_BPartner_ID != 0)
			{
				sql.append (" AND i.C_BPartner_ID=?");
				params.add(m_C_BPartner_ID);
			}
			if (m_dateInvoiced_From != null && m_dateInvoiced_To != null)
			{
				sql.append(" AND TRUNC(i.DateInvoiced) BETWEEN ? AND ?");
				params.add(m_dateInvoiced_From);
				params.add(m_dateInvoiced_To);
			}
			else if (m_dateInvoiced_From != null)
			{
				sql.append(" AND TRUNC(i.DateInvoiced) >= ?");
				params.add(m_dateInvoiced_From);
			}
			else if (m_dateInvoiced_To != null)
			{
				sql.append(" AND TRUNC(i.DateInvoiced) <= ?");
				params.add(m_dateInvoiced_To);
			}
			else if (m_DocumentNo_From != null && m_DocumentNo_To != null)
			{
				sql.append(" AND i.DocumentNo BETWEEN ? AND ?");
				params.add(m_DocumentNo_From);
				params.add(m_DocumentNo_To);
			}
			else if (m_DocumentNo_From != null)
			{
				if (m_DocumentNo_From.indexOf('%') == -1) {
					sql.append(" AND i.DocumentNo >= ?");
				} else {
					sql.append(" AND i.DocumentNo LIKE ?");
				}
				params.add(m_DocumentNo_From);
			}
			
			if (p_EMailPDF)
			{
				/* if emailed to customer only select COmpleted & CLosed invoices */ 
				sql.append(" AND i.DocStatus IN ('CO','CL') "); 
			}
			if (p_IsPaid != null && p_IsPaid.length() == 1)
			{ 
				sql.append(" AND i.IsPaid=?");
				params.add(p_IsPaid);
			}
			if (m_C_DocType_ID != 0)
			{
				sql.append (" AND i.C_DocTypeTarget_ID=?");
				params.add(m_C_DocType_ID);
			}
			if (p_IsPrinted != null && p_IsPrinted.length() == 1)
			{
				sql.append (" AND i.IsPrinted=?");
				params.add(p_IsPrinted);
			}
			if (m_PaymentRule != null)
			{
				sql.append (" AND i.PaymentRule=?");
				params.add(m_PaymentRule);
			}
			if (m_C_PaymentTerm_ID != 0)
			{
				sql.append (" AND i.C_PaymentTerm_ID=?");
				params.add(m_C_PaymentTerm_ID);
			}
			if (m_DocStatus != null)
			{
				sql.append (" AND i.DocStatus=?");
				params.add(m_DocStatus);
			}
		}
		String orgWhere = MRole.getDefault(getCtx(), false).getOrgWhere(MRole.SQL_RO);
		if (!Util.isEmpty(orgWhere, true)) {
			orgWhere = orgWhere.replaceAll("AD_Org_ID", "i.AD_Org_ID");
			sql.append(" AND ");
			sql.append(orgWhere);
		}
		sql.append(" ORDER BY i.C_Invoice_ID, pf.AD_Org_ID DESC");	//	more than 1 PF record
	}

}	//	InvoicePrint
