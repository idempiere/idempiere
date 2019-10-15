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
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.concurrent.Callable;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.util.CLogFile;
import org.compiere.util.CLogger;

/**
 * @author hengsin
 *
 */
public class ReadLogCallable implements Callable<byte[]>, Serializable {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 33969865104073117L;
	private static final String s_dirAccessFileName = "dirAccess.txt";
	private static CLogger log = CLogger.getCLogger(ReadLogCallable.class);

	private String fileName;

	/**
	 * default constructor
	 */
	public ReadLogCallable(String fileName) {
		this.fileName = fileName;
	}

	@Override
	public byte[] call() throws Exception {
		CLogFile fileHandler = CLogFile.get(false, null, false);
		//
		// Display current log File
		if (fileHandler != null && fileHandler.getFileName().equals(fileName))
			fileHandler.flush();

		File file = new File(fileName);
		if (!file.exists() || !file.canRead()) {
			return null;
		}
		if (file.length() == 0) {
			return new byte[0];
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
			return null;
		}

		// Stream Log
		try (FileInputStream fis = new FileInputStream(file)) {
			int bufferSize = 2048; // 2k Buffer
			byte[] buffer = new byte[bufferSize];
			//
			ByteArrayOutputStream baos = new ByteArrayOutputStream(bufferSize);
			//
			int read = 0;
			while ((read = fis.read(buffer)) > 0)
				baos.write(buffer, 0, read);
			return baos.toByteArray();
		} catch (Exception ex) {
			log.log(Level.SEVERE, "stream" + ex);
			return null;
		}
	}

	private ArrayList<File> getDirAcessList() {
		final ArrayList<File> dirAccessList = new ArrayList<File>();

		// by default has access to log directory
		CLogFile fileHandler = CLogFile.get(true, null, false);
		File logDir = fileHandler.getLogDirectory();
		dirAccessList.add(logDir);

		// load from dirAccess.properties file
		String dirAccessPathName = Adempiere.getAdempiereHome() + File.separator + s_dirAccessFileName;
		File dirAccessFile = new File(dirAccessPathName);
		if (dirAccessFile.exists()) {
			try {
				BufferedReader br = new BufferedReader(new FileReader(dirAccessFile));
				while (true) {
					String pathName = br.readLine();
					if (pathName == null)
						break;
					File pathDir = new File(pathName);
					if (pathDir.exists() && !dirAccessList.contains(pathDir))
						dirAccessList.add(pathDir);
				}
				br.close();
			} catch (Exception e) {
				log.log(Level.SEVERE, dirAccessPathName + " - " + e.toString());
			}
		}

		return dirAccessList;
	}
}
