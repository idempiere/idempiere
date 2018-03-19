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

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.compiere.model.MClient;
import org.compiere.model.MSysConfig;
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
		if (emailSys.length() > 0 && !emailList.equals(emailSys))
			emailList += "," + emailSys;
		if (emailList.length() == 0)
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
		if (fLines.size() > 0) {
			message.append("Failed Objects:").append("\n");
			for (String line : fLines) {
				message.append(line).append("\n");
			}
			message.append("===========================\n");
		}

		List<String> sLines = getLines(LEVEL_SUCCESS);
		if (sLines.size() > 0) {
			message.append("Successful Objects:").append("\n");
			for (String line : sLines) {
				message.append(line).append("\n");
			}
			message.append("===========================\n");
		}

		StringTokenizer st = new StringTokenizer(emailList, " ,;", false);
		String to = st.nextToken();
		String from = client.getRequestEMail();
		if (from == null && client.getAD_Client_ID() != 0 && MClient.isSendCredentialsSystem()) {
			MClient sysclient = MClient.get(Env.getCtx(), 0);
			from = sysclient.getRequestEMail();
		}

		EMail email = client.createEMailFrom(from, to, subject.toString(), message.toString(), false);
		if (email != null)
		{
			if (!packIn.isSuccess()) {
				email.setHeader("X-Priority", "1");
				email.setHeader("Priority","Urgent");
				email.setHeader("Importance","high");
			}
			while (st.hasMoreTokens())
				email.addTo(st.nextToken());
			status = email.send();
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
