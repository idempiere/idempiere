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

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.util.CLogFile;
import org.compiere.util.CLogger;

/**
 * @author hengsin
 *
 */
public abstract class LogFileCallable {

	protected static final int BLOCK_SIZE = 1024 * 1024 * 5;
	protected static final String s_dirAccessFileName = "dirAccess.txt";
	
	protected transient CLogger log = CLogger.getCLogger(getClass());
	
	/**
	 * default constructor
	 */
	public LogFileCallable() {
	}

	/**
	 * 
	 * @return list of files accessible
	 */
	protected ArrayList<File> getDirAcessList() {
		final ArrayList<File> dirAccessList = new ArrayList<File>();

		// by default has access to log directory
		CLogFile fileHandler = CLogFile.get(true, null, false);
		File logDir = fileHandler.getLogDirectory();
		dirAccessList.add(logDir);

		// load from dirAccess.properties file
		String dirAccessPathName = Adempiere.getAdempiereHome() + File.separator + s_dirAccessFileName;
		File dirAccessFile = new File(dirAccessPathName);
		if (dirAccessFile.exists()) {
			try (BufferedReader br = new BufferedReader(new FileReader(dirAccessFile))) {				
				while (true) {
					String pathName = br.readLine();
					if (pathName == null)
						break;
					File pathDir = new File(pathName);
					if (pathDir.exists() && !dirAccessList.contains(pathDir))
						dirAccessList.add(pathDir);
				}
			} catch (Exception e) {
				log.log(Level.SEVERE, dirAccessPathName + " - " + e.toString());
			}
		}
		
		return dirAccessList;
	}
	
	/**
	 * 
	 * @param file
	 * @return true if log file is accessible, false otherwise
	 * @throws IOException
	 */
	protected boolean isAccessible(File file) throws IOException {
		if (!file.exists() || !file.canRead()) {
			return false;
		}

		boolean found = false;
		ArrayList<File> dirAccessList = getDirAcessList();

		for (File dir : dirAccessList) {
			if (file.getCanonicalPath().startsWith(dir.getAbsolutePath())) {
				found = true;
				break;
			}
		}

		if (!found) {
			log.warning("Couldn't find file in directories that allowed to access");
			return false;
		}
		
		return true;
	}
}
