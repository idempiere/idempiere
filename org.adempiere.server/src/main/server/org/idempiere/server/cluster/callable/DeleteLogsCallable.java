/**********************************************************************
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
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.idempiere.server.cluster.callable;

import java.io.File;
import java.io.Serializable;
import java.util.concurrent.Callable;

import org.adempiere.util.LogAuthFailure;
import org.compiere.util.CLogFile;

/**
 * @author hengsin
 *
 */
public class DeleteLogsCallable implements Callable<Boolean>, Serializable {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5830938669376247267L;

	/**
	 * 
	 */
	public DeleteLogsCallable() {
	}

	@Override
	public Boolean call() throws Exception {
		CLogFile fileHandler = CLogFile.get (false, null, false);
		//
		File logDir = fileHandler.getLogDirectory();
		if (logDir != null && logDir.isDirectory())
		{
			File[] logs = logDir.listFiles();
			for (int i = 0; i < logs.length; i++) 
			{
				String fileName = logs[i].getAbsolutePath();
				if (fileName.equals(fileHandler.getFileName()))
					continue;
				if (fileName.endsWith(LogAuthFailure.authFailureFilename)) // Do not delete login failure
					continue;
				logs[i].delete();
			}
		}
		return true;
	}
}
