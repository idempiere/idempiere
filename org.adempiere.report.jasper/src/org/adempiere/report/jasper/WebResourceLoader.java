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

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CLogger;
import org.compiere.util.Language;
import org.compiere.util.Util;
import org.compiere.utils.DigestOfFile;

/**
 * 
 * Load report resources from http or https
 * @author hengsin
 *
 */
public class WebResourceLoader {

	private final static CLogger log = CLogger.getCLogger(WebResourceLoader.class);

	private String destinationFolder;

	/**
	 * 
	 * @param destinationFolder destination folder to download report file to
	 */
	public WebResourceLoader(String destinationFolder) {
		this.destinationFolder = destinationFolder;
	}

	/**
	 * Download remote report file from web server
	 * 
	 * @param reportFilePath full http path to report file
	 * @return downloaded File
	 */
	private File downloadFile(String reportFilePath) {
		File reportFile = null;
		File downloadedFile = null;
		if (log.isLoggable(Level.INFO))
			log.info(" report deployed to " + reportFilePath);
		try {
			String[] tmps = reportFilePath.split("/");
			String fileName = tmps[tmps.length - 1];
			String localFilePath = destinationFolder + fileName;
			String tmpLocalFilePath = destinationFolder + "TMP_" + fileName;

			reportFile = new File(localFilePath);
			if (reportFile.exists()) {
				String remoteMD5Hash = getRemoteMD5(reportFilePath);
				if (!Util.isEmpty(remoteMD5Hash, true)) {
					String localMD5hash = DigestOfFile.getMD5Hash(reportFile);
					if (log.isLoggable(Level.INFO))
						log.info("MD5 for local file is " + localMD5hash);
					if (localMD5hash.equals(remoteMD5Hash.trim())) {
						if (log.isLoggable(Level.INFO))
							log.info("MD5 match: local report file is up-to-date");
						return reportFile;
					} else {
						if (log.isLoggable(Level.INFO))
							log.info("MD5 is different, download and replace");
						downloadedFile = getRemoteFile(reportFilePath, tmpLocalFilePath);
						if (downloadedFile != null) {
							Path to = reportFile.toPath();
							Path from = downloadedFile.toPath();
							Files.copy(from, to, StandardCopyOption.REPLACE_EXISTING);
							Files.delete(from);
							return to.toFile();
						} else {
							return null;
						}
					}
				} else {
					downloadedFile = getRemoteFile(reportFilePath, tmpLocalFilePath);
					if (downloadedFile == null)
						return null;

					// compare hash of existing and downloaded
					if (DigestOfFile.md5HashCompare(reportFile, downloadedFile)) {
						// nothing file are identical
						if (log.isLoggable(Level.INFO))
							log.info("MD5 match: local report file is up-to-date");
						return reportFile;
					} else {
						if (log.isLoggable(Level.INFO))
							log.info("MD5 is different, replace with downloaded file");
						Path to = reportFile.toPath();
						Path from = downloadedFile.toPath();
						Files.copy(from, to, StandardCopyOption.REPLACE_EXISTING);
						Files.delete(from);
						return to.toFile();
					}
				}
			} else {
				reportFile = getRemoteFile(reportFilePath, localFilePath);
				return reportFile;
			}

		} catch (Exception e) {
			throw new AdempiereException("Unknown exception: " + e.getLocalizedMessage());
		}

	}

	/**
	 * 
	 * @param reportFilePath
	 * @return File
	 */
	public File getReportFile(String reportFilePath) {
		return downloadFile(reportFilePath);
	}

	/**
	 * Get property resource file from http URL
	 * 
	 * @param reportPath
	 * @param bundleName
	 * @param currLang
	 * @return File
	 */
	public File getResourceBundle(String reportPath, String bundleName, Language currLang) {
		String remoteDir = reportPath.substring(0, reportPath.lastIndexOf("/"));
		String resname = bundleName + "_" + currLang.getLocale().getLanguage() + "_" + currLang.getLocale().getCountry()
				+ ".properties";
		try {
			File resFile = downloadFile(remoteDir + "/" + resname);
			if (resFile == null) {
				resname = bundleName + "_" + currLang.getLocale().getLanguage() + ".properties";
				resFile = downloadFile(remoteDir + "/" + resname);
				if (resFile == null) {
					resname = bundleName + ".properties";
					resFile = downloadFile(remoteDir + "/" + resname);
				}
			}
			return resFile;
		} catch (Exception e) {
			if (log.isLoggable(Level.CONFIG))
				log.log(Level.CONFIG, e.getMessage(), e);
			return null;
		}
	}

	private String getRemoteMD5(String reportLocation) {
		try {
			String md5url = reportLocation + ".md5";
			URL reportURL = new URL(md5url);
			try (InputStream in = reportURL.openStream()) {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				byte buf[] = new byte[1024];
				int s = 0;
				while ((s = in.read(buf, 0, 1024)) > 0)
					baos.write(buf, 0, s);

				String hash = new String(baos.toByteArray());
				int posSpace = hash.indexOf(" ");
				if (posSpace > 0)
					hash = hash.substring(0, posSpace);
				return hash;
			}
		} catch (Exception e) {
			if (log.isLoggable(Level.CONFIG))
				log.log(Level.CONFIG, "MD5 not available for " + reportLocation, e);
			return null;
		}
	}

	/**
	 * @author rlemeill
	 * @param reportLocation http://applicationserver/webApp/standalone.jrxml for
	 *                       example
	 * @param localPath      Where to put the http downloaded file
	 * @return abstract File which represent the downloaded file
	 */
	private File getRemoteFile(String reportLocation, String localPath) {
		try {
			URL reportURL = new URL(reportLocation);
			try (InputStream in = reportURL.openStream();) {

				File downloadedFile = new File(localPath);

				if (downloadedFile.exists()) {
					downloadedFile.delete();
				}

				try (FileOutputStream fout = new FileOutputStream(downloadedFile);) {
					byte buf[] = new byte[1024];
					int s = 0;
					while ((s = in.read(buf, 0, 1024)) > 0)
						fout.write(buf, 0, s);

					fout.flush();
				}
				return downloadedFile;
			}
		} catch (Exception e) {
			throw new AdempiereException(e.getMessage(), e);
		}
	}

	/**
	 * 
	 * @param path
	 * @return true if path is http or https
	 */
	public static boolean isWebResourcePath(String path) {
		return path.startsWith("http://") || path.startsWith("https://");
	}
}
