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
import java.util.ArrayList;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MProcess;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.utils.DigestOfFile;

/**
 * Load report resources from attachment to process
 * @author hengsin
 *
 */
public class AttachmentResourceLoader {

	private final static CLogger log = CLogger.getCLogger(AttachmentResourceLoader.class);

	private String destinationFolder;

	private MAttachment attachment;

	private static final String ATTACHMENT_PATH_PREFIX = "attachment:";

	/**
	 * 
	 * @param destinationFolder
	 */
	public AttachmentResourceLoader(String destinationFolder) {
		this.destinationFolder = destinationFolder;
	}

	/**
	 * Get report file from process attachment
	 * 
	 * @param reportPath must of syntax attachment:filename
	 * @return File
	 */
	public File getReportFile(ProcessInfo processInfo, String reportPath) {
		File reportFile = null;
		String name = reportPath.substring(ATTACHMENT_PATH_PREFIX.length()).trim();
		MProcess process = new MProcess(Env.getCtx(), processInfo.getAD_Process_ID(), processInfo.getTransactionName());
		attachment = process.getAttachment();
		if (attachment != null) {
			MAttachmentEntry[] entries = attachment.getEntries();
			MAttachmentEntry entry = null;
			for (int i = 0; i < entries.length; i++) {
				if (entries[i].getName().equals(name)) {
					entry = entries[i];
					break;
				}
			}
			if (entry != null) {
				reportFile = getAttachmentEntryFile(entry);
			}
		}
		return reportFile;
	}

	/**
	 * Download db attachment to local file
	 * 
	 * @param entry
	 * @return File
	 */
	private File getAttachmentEntryFile(MAttachmentEntry entry) {
		String localFile = destinationFolder + entry.getName();
		String downloadedLocalFile = destinationFolder + "TMP_" + entry.getName();
		File reportFile = new File(localFile);
		if (reportFile.exists()) {
			String localMD5hash = DigestOfFile.getMD5Hash(reportFile);
			String entryMD5hash = DigestOfFile.getMD5Hash(entry.getData());
			if (localMD5hash.equals(entryMD5hash)) {
				log.info(" no need to download: local report is up-to-date");
			} else {
				log.info(" report on server is different from local copy, download and replace");
				File downloadedFile = new File(downloadedLocalFile);
				entry.getFile(downloadedFile);
				if (!reportFile.delete()) {
					throw new AdempiereException("Cannot delete temporary file " + reportFile.toString());
				}
				if (!downloadedFile.renameTo(reportFile)) {
					throw new AdempiereException("Cannot rename temporary file " + downloadedFile.toString() + " to "
							+ reportFile.toString());
				}
			}
		} else {
			entry.getFile(reportFile);
		}
		return reportFile;
	}

	private File getAttachmentEntryFile(String resname) {
		File fileattach = null;
		MAttachmentEntry[] entries = attachment.getEntries();
		for (int i = 0; i < entries.length; i++) {
			if (entries[i].getName().equals(resname)) {
				fileattach = getAttachmentEntryFile(entries[i]);
				break;
			}
		}
		return fileattach;
	}

	/**
	 * Get property resource file from process attachment
	 * 
	 * @param bundleName
	 * @param currLang
	 * @return File
	 */
	public File getResourceBundle(String bundleName, Language currLang) {
		String resname = bundleName + "_" + currLang.getLocale().getLanguage() + "_" + currLang.getLocale().getCountry()
				+ ".properties";
		File resFile = getAttachmentEntryFile(resname);
		if (resFile == null) {
			resname = bundleName + "_" + currLang.getLocale().getLanguage() + ".properties";
			resFile = getAttachmentEntryFile(resname);
			if (resFile == null) {
				resname = bundleName + ".properties";
				resFile = getAttachmentEntryFile(resname);
			}
		}
		return resFile;
	}

	/**
	 * Get subreports and other resources (for e.g images) from attachment. Assume all other jasper attachment is
	 * subreport.
	 * 
	 * @param reportPath
	 * @return File[] of subreports
	 */
	public File[] getSubreports(String reportPath) {
		String name = reportPath.substring(ATTACHMENT_PATH_PREFIX.length()).trim();
		ArrayList<File> subreports = new ArrayList<File>();
		MAttachmentEntry[] entries = attachment.getEntries();
		for (int i = 0; i < entries.length; i++) {
			// @Trifon
			if (!entries[i].getName().equals(name)) {
				File reportFile = getAttachmentEntryFile(entries[i]);
				if (reportFile != null) {
					if (entries[i].getName().toLowerCase().endsWith(".jrxml")
							|| entries[i].getName().toLowerCase().endsWith(".jasper")) {
						subreports.add(reportFile);
					}
				}
			}
		}
		return subreports.toArray(new File[0]);
	}

	/**
	 * 
	 * @param path
	 * @return true if path starts with "attachment:"
	 */
	public static boolean isAttachmentResourcePath(String path) {
		return path != null && path.startsWith(AttachmentResourceLoader.ATTACHMENT_PATH_PREFIX);
	}
}
