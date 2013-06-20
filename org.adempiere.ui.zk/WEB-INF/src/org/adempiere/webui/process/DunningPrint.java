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
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.SimplePDFViewer;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MDunningLevel;
import org.compiere.model.MDunningRun;
import org.compiere.model.MDunningRunEntry;
import org.compiere.model.MMailText;
import org.compiere.model.MQuery;
import org.compiere.model.MUser;
import org.compiere.model.MUserMail;
import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.EMail;

/**
 *	Dunning Letter Print
 *	
 *  @author Jorg Janke
 *  @version $Id: DunningPrint.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 *  
 *  FR 2872010 - Dunning Run for a complete Dunning (not just level) - Developer: Carlos Ruiz - globalqss - Sponsor: Metas
 */
public class DunningPrint extends SvrProcess
{
	/**	Mail PDF				*/
	private boolean		p_EMailPDF = false;
	/** Mail Template			*/
	private int			p_R_MailText_ID = 0;
	/** Dunning Run				*/
	private int			p_C_DunningRun_ID = 0;
	/** Print only Outstanding	*/
	private boolean		p_IsOnlyIfBPBalance = true;
	/** Print only unprocessed lines */
	private boolean p_PrintUnprocessedOnly = true;
	
	
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
			else if (name.equals("EMailPDF"))
				p_EMailPDF = "Y".equals(para[i].getParameter());
			else if (name.equals("R_MailText_ID"))
				p_R_MailText_ID = para[i].getParameterAsInt();
			else if (name.equals("C_DunningRun_ID"))
				p_C_DunningRun_ID = para[i].getParameterAsInt();
			else if (name.equals("IsOnlyIfBPBalance"))
				p_IsOnlyIfBPBalance = "Y".equals(para[i].getParameter());
			else if (name.equals("PrintUnprocessedOnly"))
				p_PrintUnprocessedOnly = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 * Process
	 * @return info
	 * @throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("C_DunningRun_ID=" + p_C_DunningRun_ID + ",R_MailText_ID=" + p_R_MailText_ID 
			+ ", EmailPDF=" + p_EMailPDF + ",IsOnlyIfBPBalance=" + p_IsOnlyIfBPBalance 
			+ ",PrintUnprocessedOnly=" + p_PrintUnprocessedOnly);
		
		//	Need to have Template
		if (p_EMailPDF && p_R_MailText_ID == 0)
			throw new AdempiereUserError ("@NotFound@: @R_MailText_ID@");
//		String subject = "";
		MMailText mText = null;
		if (p_EMailPDF)
		{
			mText = new MMailText (getCtx(), p_R_MailText_ID, get_TrxName());
			if (p_EMailPDF && mText.get_ID() == 0)
				throw new AdempiereUserError ("@NotFound@: @R_MailText_ID@ - " + p_R_MailText_ID);
//			subject = mText.getMailHeader();
		}
		//
		MDunningRun run = new MDunningRun (getCtx(), p_C_DunningRun_ID, get_TrxName());
		if (run.get_ID() == 0)
			throw new AdempiereUserError ("@NotFound@: @C_DunningRun_ID@ - " + p_C_DunningRun_ID);
		MClient client = MClient.get(getCtx());
		
		int count = 0;
		int errors = 0;
		MDunningRunEntry[] entries = run.getEntries(false);
		List<File> pdfList = new ArrayList<File>();
		for (int i = 0; i < entries.length; i++)
		{
			MDunningRunEntry entry = entries[i];

			//	Print Format on Dunning Level
			MDunningLevel level = new MDunningLevel (getCtx(), entry.getC_DunningLevel_ID(), get_TrxName());
			MPrintFormat format = null;
			if (level.getDunning_PrintFormat_ID() > 0)
				format = MPrintFormat.get (getCtx(), level.getDunning_PrintFormat_ID(), false);
			
			if (p_IsOnlyIfBPBalance && entry.getAmt().signum() <= 0)
				continue;
			if (p_PrintUnprocessedOnly && entry.isProcessed())
				continue;
			//	To BPartner
			MBPartner bp = new MBPartner (getCtx(), entry.getC_BPartner_ID(), get_TrxName());
			if (bp.get_ID() == 0)
			{
				StringBuilder msglog = new StringBuilder("@NotFound@: @C_BPartner_ID@ ").append(entry.getC_BPartner_ID());
				addLog (entry.get_ID(), null, null,msglog.toString() );
				errors++;
				continue;
			}
			//	To User
			MUser to = new MUser (getCtx(), entry.getAD_User_ID(), get_TrxName());
			if (p_EMailPDF)
			{
				if (to.get_ID() == 0)
				{
					StringBuilder msglog = new StringBuilder("@NotFound@: @AD_User_ID@ - ").append(bp.getName());
					addLog (entry.get_ID(), null, null,msglog.toString());
					errors++;
					continue;
				}
				else if (to.getEMail() == null || to.getEMail().length() == 0)
				{
					StringBuilder msglog = new StringBuilder("@NotFound@: @EMail@ - ").append(to.getName());
					addLog (entry.get_ID(), null, null, msglog.toString());
					errors++;
					continue;
				}
			}			
				
			//	query
			MQuery query = new MQuery("C_Dunning_Header_v");
			query.addRestriction("C_DunningRunEntry_ID", MQuery.EQUAL, 
				new Integer(entry.getC_DunningRunEntry_ID()));

			//	Engine
			PrintInfo info = new PrintInfo(
				bp.getName(),
				MDunningRunEntry.Table_ID,
				entry.getC_DunningRunEntry_ID(),
				entry.getC_BPartner_ID());
			StringBuilder msginfo = new StringBuilder().append(bp.getName()).append(", Amt=").append(entry.getAmt());
			info.setDescription(msginfo.toString());
			ReportEngine re = null;
			if (format != null)
				re = new ReportEngine(getCtx(), format, query, info);
			boolean printed = false;
			if (p_EMailPDF)
			{
				EMail email = client.createEMail(to.getEMail(), null, null);
				if (!email.isValid())
				{
					StringBuilder msglog = new StringBuilder(
							"@RequestActionEMailError@ Invalid EMail: ").append(to);
					addLog (entry.get_ID(), null, null,msglog.toString() );
					errors++;
					continue;
				}
				mText.setUser(to);	//	variable context
				mText.setBPartner(bp);
				mText.setPO(entry);
				String message = mText.getMailText(true);
				if (mText.isHtml())
					email.setMessageHTML(mText.getMailHeader(), message);
				else
				{
					email.setSubject (mText.getMailHeader());
					email.setMessageText (message);
				}
				//
				if (re != null) {
					File attachment = re.getPDF(File.createTempFile("Dunning", ".pdf"));
					StringBuilder msglog = new StringBuilder().append(to.toString()).append(" - ").append(attachment);
					if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
					email.addAttachment(attachment);
				}
				//
				String msg = email.send();
				MUserMail um = new MUserMail(mText, entry.getAD_User_ID(), email);
				um.saveEx();
				if (msg.equals(EMail.SENT_OK))
				{
					StringBuilder msglog = new StringBuilder()
							.append(bp.getName()).append(" @RequestActionEMailOK@");
					addLog (entry.get_ID(), null, null,msglog.toString());
					count++;
					printed = true;
				}
				else
				{
					StringBuilder msglog = new StringBuilder().append(bp.getName()).append(" @RequestActionEMailError@ ").append(msg);
					addLog (entry.get_ID(), null, null,msglog.toString()	);
					errors++;
				}
			}
			else
			{
				if (re != null) {
					pdfList.add(re.getPDF());					
					count++;
					printed = true;
				}
				
					
			}
			if (printed)
			{
				entry.setProcessed (true);
				entry.save ();
			}

		}	//	for all dunning letters
		if (errors==0) {
			run.setProcessed(true);
			run.saveEx();
		}
		if (p_EMailPDF){
			StringBuilder msgreturn = new StringBuilder("@Sent@=").append(count).append(" - @Errors@=").append(errors);
			return msgreturn.toString();
		}
		
		if (pdfList.size() > 1) {
			try {
				File outFile = File.createTempFile("DunningPrint", ".pdf");					
				AEnv.mergePdf(pdfList, outFile);
				Window win = new SimplePDFViewer(this.getName(), new FileInputStream(outFile));
				win.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		} else if (pdfList.size() > 0) {
			try {
				Window win = new SimplePDFViewer(this.getName(), new FileInputStream(pdfList.get(0)));
				win.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
				SessionManager.getAppDesktop().showWindow(win, "center");
			} catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}
		}
		StringBuilder msgreturn = new StringBuilder("@Printed@=").append(count);
		return msgreturn.toString();
	}	//	doIt
	
}	//	DunningPrint
