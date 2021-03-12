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
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/

package org.idempiere.process;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.util.Enumeration;
import java.util.List;
import java.util.logging.Level;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.adempiere.exceptions.AdempiereException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Target;
import org.apache.tools.ant.taskdefs.Zip;
import org.compiere.install.Translation;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.tools.FileUtil;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

public class TranslationImpExp extends SvrProcess {

	// Process to import or export translations
	private String p_ImportOrExport;
	private int p_AD_Client_ID;    // Client
	private String p_AD_Language;
	private int p_AD_Table_ID;
	private boolean p_IsOnlyCentralizedData;
	private String p_Folder;
	private String p_FileName;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("ImportOrExport".equals(name)) {
				p_ImportOrExport = para.getParameterAsString();
			} else if ("AD_AllClients_V_ID".equals(name)) {
				p_AD_Client_ID  = para.getParameterAsInt();
			} else if ("AD_Language".equals(name)) {
				p_AD_Language = para.getParameterAsString();
			} else if ("AD_Table_ID".equals(name)) {
				p_AD_Table_ID = para.getParameterAsInt();
			} else if ("IsOnlyCentralizedData".equals(name)) {
				p_IsOnlyCentralizedData = para.getParameterAsBoolean();
			} else if ("Folder".equals(name)) {
				p_Folder = para.getParameterAsString();
			} else if ("FileName".equals(name)) {
				p_FileName = para.getParameterAsString();
			} else {
				if (log.isLoggable(Level.INFO)) log.log(Level.INFO, "Custom Parameter: " + name + "=" + para.getInfo());
			}
		}
	}

	@Override
	protected String doIt() throws Exception {
		// validate parameters
		if (Util.isEmpty(p_AD_Language, true))
			throw new AdempiereSystemError("@Mandatory@ @AD_Language@");
		if ("import".equals(p_ImportOrExport) && Util.isEmpty(p_Folder, true) && Util.isEmpty(p_FileName, true))
			throw new AdempiereSystemError("@Mandatory@ @Folder@ / @FileName@");

		File tempFolder = null;
		try {
			if (! Util.isEmpty(p_FileName, true) && "import".equals(p_ImportOrExport)) {
				if (p_FileName.startsWith("http://") || p_FileName.startsWith("https://")) {
					String tmpZip = null;
					FileOutputStream fos = null;
					try {
						URL website = new URL(p_FileName);
						ReadableByteChannel rbc = Channels.newChannel(website.openStream());
						tmpZip = FileUtil.getTempMailName(p_AD_Language, ".zip");
						fos = new FileOutputStream(tmpZip);
						fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
						p_FileName = tmpZip;
					} catch (Exception e) {
						throw new AdempiereSystemError("Could not download " + p_FileName + " -> " + e.getLocalizedMessage());
					} finally {
						fos.close();
					}
				} else {
					if (! p_FileName.toLowerCase().endsWith(".zip")) {
						throw new AdempiereSystemError("@FileMustBeZIP@");
					}
				}
				tempFolder = createTempFolder(p_AD_Language);
				unZipLangFile(p_FileName, p_AD_Language, tempFolder);
				p_Folder = tempFolder.getAbsolutePath();
			} else {
				if (Util.isEmpty(p_Folder)) {
					tempFolder = createTempFolder(p_AD_Language);
					p_Folder = tempFolder.getAbsolutePath();
				}
			}

			Translation translation = new Translation(Env.getCtx());
			String msg = translation.validateLanguage(p_AD_Language, get_TrxName());
			if (msg.length() > 0)
				throw new AdempiereSystemError(msg);

			StringBuilder whereClause = new StringBuilder("TableName LIKE '%_Trl' AND TableName<>'AD_Column_Trl'");
			if (p_AD_Table_ID > 0)
				whereClause.append(" AND AD_Table_ID=?");

			Query query = new Query(getCtx(), MTable.Table_Name, whereClause.toString(), get_TrxName())
					.setOnlyActiveRecords(true)
					.setOrderBy("TableName");
			if (p_AD_Table_ID > 0)
				query.setParameters(p_AD_Table_ID);
			List<MTable> tables = query.list();
			for (MTable table : tables) {
				String msgProc;
				String tableName = table.getTableName();
				if ("import".equals(p_ImportOrExport)) {
					statusUpdate(Msg.parseTranslation(getCtx(), "@Import@ " + tableName + " ..."));
					msgProc = translation.importTrl(p_Folder, p_AD_Client_ID, p_AD_Language, tableName);
				} else {
					statusUpdate(Msg.parseTranslation(getCtx(), "@Export@ " + tableName + " ..."));
					msgProc = translation.exportTrl(p_Folder, p_AD_Client_ID, p_AD_Language, tableName, p_IsOnlyCentralizedData);
				}
				addLog(tableName + " " + msgProc);
			}

			if (!"import".equals(p_ImportOrExport) && tempFolder != null) {
				// exporting to zip, now zip the exported files
				File destZipFile = null;
				try {
					destZipFile = File.createTempFile(p_AD_Language + "_trlExport_", ".zip");
				} catch (Throwable e) {
					throw new AdempiereException("Unable to create temp file", e);
				}
				destZipFile.delete();

				Zip zipper = new Zip();
				zipper.setDestFile(destZipFile);
				zipper.setBasedir(tempFolder);
				zipper.setUpdate(false);
				zipper.setCompress(true);
				zipper.setCaseSensitive(false);
				zipper.setFilesonly(true);
				zipper.setTaskName("zip");
				zipper.setTaskType("zip");
				zipper.setProject(new Project());
				zipper.setOwningTarget(new Target());
				zipper.execute();
				processUI.download(destZipFile);
			}
		} finally {
			// Cleanup when temp folder
			if (tempFolder != null) {
				try {
					FileUtil.deleteFolderRecursive(tempFolder);
				} catch (IOException e) {}
			}
		}

		return "@OK@";
	}

	private File createTempFolder(String language) {
		// create temp folder
		File tmpFolder;
		try {
			tmpFolder = File.createTempFile(language, ".trl");
			tmpFolder.delete();
			tmpFolder.mkdir();
		} catch (IOException e1) {
			throw new AdempiereException("Problem creating temp folder", e1);
		}
		return tmpFolder;
	}

	/**
	 * Unzip the fileName into a temp folder and return the folder name
	 * @param file Name
	 * @return folder Name
	 * @throws AdempiereException
	 */
	private void unZipLangFile(String fileName, String language, File folder) throws AdempiereException {
		String suffix = "_" + language + ".xml";
		ZipFile zipFile = null;
		boolean validfile = false;
		try {
			zipFile = new ZipFile(fileName);

			Enumeration<? extends ZipEntry> entries = zipFile.entries();
			while (entries.hasMoreElements()) {
				ZipEntry entry = (ZipEntry)entries.nextElement();

				if (entry.isDirectory()) {
					// ignore folders
					addLog("Imported zip must not contain folders, ignored folder" + entry.getName());
					continue;
				}

				if (! entry.getName().endsWith(suffix)) {
					// not valid file
					addLog("Ignored file " + entry.getName());
					continue;
				}
				String outName = entry.getName();
				String prefixFolderLang = language + File.separator;
				// allow files in the language folder (in case the zip was created including the folder)
				if (outName.startsWith(prefixFolderLang)) {
					outName = outName.substring(prefixFolderLang.length());
				}
				File outFile = new File(folder.getPath(), outName);
				if (!outFile.toPath().normalize().startsWith(folder.toPath())) {
					log.severe("Bad zip entry: " + entry.getName());
					addLog("Bad zip entry: " + entry.getName());
					continue;
				}

				if (log.isLoggable(Level.INFO)) log.info("Extracting file: " + entry.getName());
				copyInputStream(zipFile.getInputStream(entry), new BufferedOutputStream(new FileOutputStream(outFile)));
				validfile = true;
			}
		} catch (Throwable e) {
			throw new AdempiereException("Uncompress zip failed", e);
		} finally {
			if (zipFile != null)
				try {
					zipFile.close();
				} catch (IOException e) {}
		}

		if (!validfile) {
			throw new AdempiereException("ZIP file invalid, doesn't contain *" + suffix + " files");
		}
	}

	public static final void copyInputStream(InputStream in, OutputStream out) throws IOException {
		byte[] buffer = new byte[1024];
		int len;

		while((len = in.read(buffer)) >= 0)
			out.write(buffer, 0, len);

		in.close();
		out.close();
	}	

}
