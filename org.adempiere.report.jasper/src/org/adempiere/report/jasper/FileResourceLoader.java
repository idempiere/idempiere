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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.report.jasper;

import java.io.File;
import java.io.FilenameFilter;
import java.net.URI;
import java.net.URISyntaxException;

import org.compiere.util.CLogger;
import org.compiere.util.Language;

/**
 * 
 * @author hengsin
 *
 */
public class FileResourceLoader {

	private final static CLogger log = CLogger.getCLogger(FileResourceLoader.class);

	private static final String FILE_PATH_PREFIX = "file:/";

	public FileResourceLoader() {
	}

	/**
	 * 
	 * @param reportPath
	 * @return File
	 */
	public File getReportFile(String reportPath) {
		File reportFile = null;
		try {
			reportFile = new File(new URI(reportPath));
		} catch (URISyntaxException e) {
			log.warning(e.getLocalizedMessage());
			reportFile = null;
		}
		return reportFile;
	}

	/**
	 * Get property resource file from file://
	 * 
	 * @param resourcePath
	 * @param bundleName
	 * @param currLang
	 * @return File
	 */
	public File getResourceBundle(String resourcePath, String bundleName, Language currLang) {
		String resname = bundleName + "_" + currLang.getLocale().getLanguage() + "_" + currLang.getLocale().getCountry()
				+ ".properties";
		File resFile = new File(resourcePath, resname);
		if (!resFile.exists()) {
			resname = bundleName + "_" + currLang.getLocale().getLanguage() + ".properties";
			resFile = new File(resourcePath, resname);
			if (!resFile.exists()) {
				resname = bundleName + ".properties";
				resFile = new File(resourcePath, resname);
				if (!resFile.exists()) {
					resFile = null;
				}
			}
		}
		return resFile;
	}

	/**
	 * 
	 * @param reportFile
	 * @param reportDir
	 * @return File[]
	 */
	public File[] getSubreports(File reportFile, File reportDir) {
		return reportDir.listFiles(new FileFilter(reportFile, reportDir));
	}

	/**
	 * 
	 * @param path
	 * @return true if path is "file:*"
	 */
	public static boolean isFileResourcePath(String path) {
		return path != null && path.startsWith(FILE_PATH_PREFIX);
	}
	
	private static class FileFilter implements FilenameFilter {
		private File directory;
		private File reportFile;

		/**
		 * 
		 * @param reportFile
		 * @param directory
		 */
		public FileFilter(File reportFile, File directory) {
			this.reportFile = reportFile;
			this.directory = directory;
		}

		@Override
		public boolean accept(File file, String name) {
			if (file.equals(directory)) {
				if (!name.equals(reportFile.getName())) {
					String lower = name.toLowerCase();
					if (lower.endsWith(".jasper") || lower.endsWith(".jrxml"))
						return true;
				}
			}
			return false;
		}
	}
}
