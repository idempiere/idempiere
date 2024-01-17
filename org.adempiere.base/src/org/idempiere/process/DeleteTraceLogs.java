/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
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
 * Contributors:                                                       *
 * - Zuhri Utama - Reka Estu Digital                                   *
 **********************************************************************/

package org.idempiere.process;

import java.io.File;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Arrays;
import java.util.Date;
import org.compiere.model.MProcessPara;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.CLogFile;

/**
 * Process to delete old server log
 */
@org.adempiere.base.annotation.Process
public class DeleteTraceLogs extends SvrProcess {

	// Process to delete trace logs for n days last
	
	private int p_KeepLogDays = 0;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "KeepLogDays":
				p_KeepLogDays = para.getParameterAsInt();
				break;
			default:
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
				break;
			}
		}
	}

	@Override
	protected String doIt() throws Exception {
		int cnt = 0;
		LocalDateTime limit = LocalDateTime.now().minusDays(p_KeepLogDays);
		CLogFile fileHandler = CLogFile.get (true, null, false);
		File logDir = fileHandler.getLogDirectory();
		if (logDir != null && logDir.isDirectory())
		{
			File[] logs = logDir.listFiles();
			Arrays.sort(logs);
			for (int i = 0; i < logs.length; i++) 
			{
				if (!logs[i].isFile())
					continue;
				
				Date lastModified = new Date(logs[i].lastModified());
				if(limit.isAfter(LocalDateTime.ofInstant(lastModified.toInstant(), ZoneId.systemDefault()))) {
					if(logs[i].delete()) {
						addLog(logs[i].getName());
						cnt++;
					}
				}
			}
		}
		
		return "@Deleted@ "+cnt;
	}


}
