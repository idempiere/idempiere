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
package org.compiere.server;

import java.io.File;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.compiere.util.CLogFile;

/**
 * @author hengsin
 *
 */
public class LogFileInfo implements Serializable {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5841677623091843473L;
	
	private String fileName;
	private long fileSize;


	private LogFileInfo() {
	}
	

	/**
	 * 
	 * @return LogFileInfo[]
	 */
	public static LogFileInfo[] getLogFileInfos() {
		List<LogFileInfo> list = new ArrayList<>();
		CLogFile fileHandler = CLogFile.get (true, null, false);
		File logDir = fileHandler.getLogDirectory();
		if (logDir != null && logDir.isDirectory())
		{
			File[] logs = logDir.listFiles();
			Arrays.sort(logs);
			for (int i = 0; i < logs.length; i++) 
			{
				// Skip if is not a file - teo_sarca [ 1726066 ]
				if (!logs[i].isFile())
					continue;
				
				LogFileInfo lfi = new LogFileInfo();
				lfi.fileName = logs[i].getAbsolutePath();
				lfi.fileSize = logs[i].length();
				list.add(lfi);
			}
		}
		
		return list.toArray(new LogFileInfo[0]);
	}


	/**
	 * 
	 * @return current log file name
	 */
	public static String getCurrentLogFile() {
		CLogFile fileHandler = CLogFile.get (true, null, false);
		return fileHandler.getFileName();
	}
	
	/**
	 * @return the fileName
	 */
	public String getFileName() {
		return fileName;
	}


	/**
	 * @return the fileSize
	 */
	public long getFileSize() {
		return fileSize;
	}
}
