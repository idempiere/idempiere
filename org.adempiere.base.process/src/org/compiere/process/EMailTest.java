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

import java.io.File;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MClient;
import org.compiere.model.MMailText;
import org.compiere.model.MSMTP;
import org.compiere.model.MSysConfig;
import org.compiere.model.MSystem;
import org.compiere.model.MTable;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Util;

/**
 *	Client EMail Test
 *	
 *  @author Jorg Janke
 *  @version $Id: EMailTest.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
@org.adempiere.base.annotation.Process
public class EMailTest extends SvrProcess
{
	/** Client Parameter			*/
	protected int	p_AD_Client_ID = 0;
	
	/**
	 * 	Get Parameters
	 */
	protected void prepare ()
	{
		p_AD_Client_ID = getRecord_ID();
		if (p_AD_Client_ID == 0)
			p_AD_Client_ID = Env.getAD_Client_ID(getCtx());
	}	//	prepare

	/**
	 * 	Process - Test EMail
	 *	@return info
	 */
	protected String doIt () throws Exception
	{
		if (getProcessInfo().getTable_ID() == MClient.Table_ID) {
			MClient client = MClient.get (getCtx(), p_AD_Client_ID);
			if (log.isLoggable(Level.INFO)) log.info(client.toString());
			
			//	 Test Client Mail
			String clientTest = client.testEMail();
			StringBuilder msglog = new StringBuilder().append(client.getName()).append(": ").append(clientTest);
			addLog(0, null, null, msglog.toString());
			
			//	Test Client DocumentDir
			if (!Ini.isClient())
			{
				String documentDir = client.getDocumentDir();
				if (documentDir == null || documentDir.length() == 0)
					documentDir = ".";
				File file = new File (documentDir);
				if (file.exists() && file.isDirectory())
					addLog(0, null, null, "Found Directory: " + documentDir);
				else
					addLog(0, null, null, "Not Found Directory: " + documentDir);
			}
			return Util.isEmpty(clientTest) ? "OK" : ("@Error@ " + clientTest);
		}
		else if (getProcessInfo().getTable_ID() == MSMTP.Table_ID) {
			
			MClient client = MClient.get(getAD_Client_ID());
			MSMTP smtp = new MSMTP(getCtx(), getRecord_ID(), get_TrxName());
			
			String systemName = MSystem.get(getCtx()).getName();
			StringBuilder subject = new StringBuilder(systemName).append(" EMail Test");
			StringBuilder msgce = new StringBuilder(systemName).append(" EMail Test");
			
			int mailtextID = MSysConfig.getIntValue(MSysConfig.EMAIL_TEST_MAILTEXT_ID, 0, getAD_Client_ID());
			if (mailtextID > 0) {
				MMailText mt = new MMailText(getCtx(), mailtextID, get_TrxName());
				mt.setPO(client);
				subject = new StringBuilder(mt.getMailHeader());
				msgce = new StringBuilder(mt.getMailText(true));
			}

			EMail email = client.createEMail (smtp.getRequestUser(), subject.toString(), msgce.toString());
			if (email == null){
				StringBuilder msgreturn = new StringBuilder("Could not create EMail: ").append(getName());
				return msgreturn.toString();
			}	
			try
			{
				String from = smtp.getUsedByEmailOrDomain();
				if (! from.contains("@"))
					from = "test@" + from;
				email.setFrom(from);
				String msg = email.sendEx();
				if (EMail.SENT_OK.equals (msg))
				{
					if (log.isLoggable(Level.INFO)) log.info("Sent Test EMail to " + client.getRequestEMail());
					return "";
				}
				else
				{
					log.warning("Could NOT send Test EMail from "
						+ smtp.getSMTPHost() + ": "
						+ " (" + smtp.getRequestUser()
						+ ") to " + client.getRequestEMail() + ": " + msg);
					return "@Error@" + msg;
				}
			}
			catch (Exception ex)
			{
				throw new AdempiereException(ex);
			}
			
		}
		
		return "@Error@ this process is not intented to be executed from table " + MTable.get(getCtx(), getProcessInfo().getTable_ID()).getName();
		
	}	//	doIt
	
}	//	EMailTest
