/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Trek Global                                           *
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
* Developer:                                                          *
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/

package org.adempiere.pipo2;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.compiere.model.MAttachment;
import org.compiere.model.MClient;
import org.compiere.model.MSysConfig;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.WebUtil;

/**
 *	PackIn Notifier
 *
 * 	@author 	Carlos Ruiz - globalqss - sponsored by Trek Global
 */

public class PackInNotifier {

	private String fileName;
	private String pluginName;
	private List<KeyNamePair> knpLines = new ArrayList<KeyNamePair>();
	private PackIn packIn;
	private Exception packInException = null;

	public PackInNotifier(PackIn packIn) {
		this.packIn = packIn;
	}

	private static final int LEVEL_STATUS = 0;
	private static final int LEVEL_FAILURE = 1;
	private static final int LEVEL_SUCCESS = 2;

	public void addStatusLine(String msg) {
		addLine(LEVEL_STATUS, msg);
	}

	public void addFailureLine(String msg) {
		addLine(LEVEL_FAILURE, msg);
	}

	public void addException(Exception e) {
		this.packInException = e;
	}

	public void addSuccessLine(String msg) {
		addLine(LEVEL_SUCCESS, msg);
	}

	public void addLine(int level, String msg) {
		knpLines.add(new KeyNamePair(level, msg));
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPluginName() {
		return pluginName;
	}

	public void setPluginName(String pluginName) {
		this.pluginName = pluginName;
	}

	public void notifyRecipient() {
		// get list from current tenant
		String emailList = MSysConfig.getValue(MSysConfig.EMAIL_NOTIFY_2PACK, "", Env.getAD_Client_ID(Env.getCtx())).trim();
		String emailSys = MSysConfig.getValue(MSysConfig.EMAIL_NOTIFY_2PACK, "", 0).trim();
		if (!emailSys.isEmpty() && !emailList.equals(emailSys))
			emailList += "," + emailSys;
		boolean attachNotify = MSysConfig.getBooleanValue(MSysConfig.ATTACH_NOTIFY_2PACK, false, Env.getAD_Client_ID(Env.getCtx()));
		if (emailList.isEmpty() && !attachNotify)
			return;

		// Compose Subject
		StringBuilder subject = new StringBuilder("*");
		String status;
		if (packIn.isSuccess()) {
			status = "Success";
		} else {
			status = "Failure";
		}
		String serverName = null;
		try {
			serverName = InetAddress.getLocalHost().getHostName();
		} catch (UnknownHostException e) {
			serverName = WebUtil.getHostIP();
		}
		subject.append(status).append("* ").append(serverName).append(" - Result for PackIn ").append(getFileName());
		if (getPluginName() != null) {
			subject.append(" from ").append(getPluginName());
		}

		// Body
		StringBuilder message = new StringBuilder();
		message.append("===========================\n");
		message.append("Packin File: ").append(getFileName()).append("\n");
		if (getPluginName() != null)
			message.append("Plugin: ").append(getPluginName()).append("\n");
		MClient client = MClient.get(Env.getCtx());
		message.append("Executed on: ").append(client.getName()).append("\n");
		message.append("Status: ").append(status).append("\n");
		for (String line : getLines(LEVEL_STATUS)) {
			message.append(line).append("\n");
		}
		message.append("===========================\n");

		// --> if failed:
		List<String> fLines = getLines(LEVEL_FAILURE);
		if (!fLines.isEmpty()) {
			message.append("Failed Objects:").append("\n");
			for (String line : fLines) {
				message.append(line).append("\n");
			}
			message.append("===========================\n");
		}

		List<String> sLines = getLines(LEVEL_SUCCESS);
		if (!sLines.isEmpty()) {
			message.append("Successful Objects:").append("\n");
			for (String line : sLines) {
				message.append(line).append("\n");
			}
			message.append("===========================\n");
		}

		if (packInException != null) {
			message.append("StackTrace:").append("\n");
	        StringWriter sw = new StringWriter();
	        PrintWriter pw = new PrintWriter(sw);
	        packInException.printStackTrace(pw);
			message.append(sw.toString());
			message.append("===========================\n");
		}

		/* Send EMail */
		boolean mailOK = true;
		if (!emailList.isEmpty()) {
			StringTokenizer st = new StringTokenizer(emailList, " ,;", false);
			String to = st.nextToken();
			String from = client.getRequestEMail();
			if (from == null && client.getAD_Client_ID() != 0 && MClient.isSendCredentialsSystem()) {
				MClient sysclient = MClient.get(Env.getCtx(), 0);
				from = sysclient.getRequestEMail();
			}

			EMail email;
			try {
				email = client.createEMailFrom(from, to, subject.toString(), message.toString(), false);
			} catch (Exception e) {
				// ignore exceptions when the email cannot be created, just log it
				e.printStackTrace();
				email = null;
			}
			if (email != null)
			{
				if (!packIn.isSuccess()) {
					email.setHeader("X-Priority", "1");
					email.setHeader("Priority","Urgent");
					email.setHeader("Importance","high");
				}
				while (st.hasMoreTokens())
					email.addTo(st.nextToken());
				String mailStatus = email.send();
				mailOK = EMail.SENT_OK.equals(mailStatus);
			}
		}

		/* Attach Error */
		if (attachNotify || !mailOK) {
			String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date(System.currentTimeMillis()));
			StringBuilder attachFileName = new StringBuilder();
			if (packIn.isSuccess()) {
				attachFileName.append("result_");
			} else {
				attachFileName.append("error_");
			}
			attachFileName.append(timestamp).append(".log");
	        StringBuilder fullContent = new StringBuilder()
	        		.append(subject)
	        		.append("\n")
	        		.append(message);
	        if (! mailOK)
	        	fullContent.append("Email notification failed");

	        try (MAttachment attachment = MAttachment.get(Env.getCtx(), X_AD_Package_Imp_Proc.Table_ID, packIn.getAD_Package_Imp_Proc().getAD_Package_Imp_Proc_ID());) {
	        if (attachment != null) {
		        attachment.addEntry(attachFileName.toString(), fullContent.toString().getBytes(StandardCharsets.UTF_8));
		        attachment.saveEx();
	        }}
		}

	}

	private List<String> getLines(int levelStatus) {
		List<String> lines = new ArrayList<String>();
		for (KeyNamePair knp : knpLines) {
			if (knp.getKey() == levelStatus) {
				lines.add(knp.getName());
			}
		}
		return lines;
	}

}
