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
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.Enumeration;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.Language;
import org.compiere.utils.DigestOfFile;

/**
 * 
 * Get report resources from fragment bundle
 * @author hengsin
 *
 */
public class BundleResourceLoader {

	private final static CLogger log = CLogger.getCLogger(BundleResourceLoader.class);

	private String destinationFolder;
	
	private String resourcePath;

	private static final String BUNDLE_PATH_PREFIX = "bundle:";

	/**
	 * 
	 * @param destinationFolder
	 */
	public BundleResourceLoader(String destinationFolder) {
		this.destinationFolder = destinationFolder;
	}

	/**
	 * @param path
	 * @return File or URL
	 */
	public Object getResource(String path) {
		String resourceName = path.startsWith(BUNDLE_PATH_PREFIX) ? path.substring(BUNDLE_PATH_PREFIX.length()).trim() : path.trim();
		
		File reportFile = null;				
		boolean empty = true;
		String parentPath = "/";
		String bundleFileName = resourceName;
		if (resourceName.lastIndexOf("/") > 0) {
			parentPath = "/"+resourceName.substring(0, resourceName.lastIndexOf("/"));
			bundleFileName = resourceName.substring(resourceName.lastIndexOf("/")+1);
		}
		URL url = null;
		Enumeration<URL> entries = Activator.getBundleContext().getBundle().findEntries(parentPath, bundleFileName, false);
		if (entries != null && entries.hasMoreElements())
			url = entries.nextElement();
		if (url != null) {
			if (resourceName.endsWith(".jrxml")) {
				File tmpOutputFile = null;
				try (InputStream inputStream = url.openStream()) {
					if (inputStream != null) {
						String localResourceName = toLocalName(resourceName);
						String localAbsoluteFileName = destinationFolder + localResourceName;
						String localAbsolutePathName = localAbsoluteFileName.substring(0, localAbsoluteFileName.lastIndexOf(System.getProperty("file.separator"))+1);
						Path localPath = Path.of(localAbsolutePathName);
						try {
							if (!Files.exists(localPath))
								Files.createDirectory(localPath);
						} catch (IOException e) {
							throw new RuntimeException(e);
						}
						String localFileName = localAbsoluteFileName.substring(localAbsoluteFileName.lastIndexOf(System.getProperty("file.separator"))+1);
						String extension = localFileName.substring(localFileName.lastIndexOf("."));
						reportFile = new File(localAbsoluteFileName);						
						if (!reportFile.exists()) {
							reportFile.createNewFile();
							tmpOutputFile = reportFile;
						} else {
							tmpOutputFile = File.createTempFile(localFileName.substring(0, localFileName.lastIndexOf(".")), extension, localPath.toFile());
						}
						try (OutputStream out = new FileOutputStream(tmpOutputFile);) {
							if (out != null) {
								byte buf[] = new byte[1024];
								int len;
								while ((len = inputStream.read(buf)) > 0) {
									empty = false;
									out.write(buf, 0, len);
								}
							}
						}
					}
				} catch (Exception e) {
					log.log(Level.SEVERE, e.getMessage(), e);
					empty = true;
				}
				if (!empty && tmpOutputFile != reportFile) {
					if (!DigestOfFile.md5HashCompare(reportFile, tmpOutputFile)) {
						Path to = reportFile.toPath();
						Path from = tmpOutputFile.toPath();
						try {
							Files.copy(from, to, StandardCopyOption.REPLACE_EXISTING);
						} catch (IOException e) {
							log.log(Level.SEVERE, e.getMessage(), e);
							return null;
						}
					}
					try {
						Files.delete(tmpOutputFile.toPath());
					} catch (IOException e) {}
				}
			} else {
				empty = false;
			}
		}

		if (empty)
			return null;
		
		if (url != null) {
			resourcePath = url.toString();
			if (resourcePath != null && resourcePath.lastIndexOf("/") > 0)
				resourcePath = resourcePath.substring(0, resourcePath.lastIndexOf("/")+1);
		}
		
		return reportFile != null ? reportFile : url;
	}

	private String toLocalName(String name) {
		String localName = name;
		if (localName.startsWith("/"))
			localName = localName.substring(1);
		if (localName.lastIndexOf("/") > 0) {
			String path = localName.substring(0, localName.lastIndexOf("/"));
			localName = localName.substring(localName.lastIndexOf("/")+1);
			path = path.replace('/', '_');
			localName = path + System.getProperty("file.separator") + localName;
		}
		return localName;
	}

	/**
	 * Get property resource file from resources
	 * 
	 * @param bundleName
	 * @param currLang
	 * @return URL
	 */
	public URL getResourceBundle(String bundleName, Language currLang) {
		String resname = bundleName + "_" + currLang.getLocale().getLanguage() + "_" + currLang.getLocale().getCountry()
				+ ".properties";
		URL resourceURL = null;
		try {
			resourceURL = (URL) getResource(resname);
		} catch (Exception e) {
			// ignore exception - file couldn't exist
		}
		if (resourceURL == null) {
			resname = bundleName + "_" + currLang.getLocale().getLanguage() + ".properties";
			try {
				resourceURL = (URL) getResource(resname);
			} catch (Exception e) {
				// ignore exception - file couldn't exist
			}
			if (resourceURL == null) {
				resname = bundleName + ".properties";
				try {
					resourceURL = (URL) getResource(resname);
				} catch (Exception e) {
					// ignore exception - file couldn't exist
				}
			}
		}
		return resourceURL;
	}

	/**
	 * @param path The full path to the parent report
	 * @return File[0];
	 */
	public File[] getSubreports(String path) {
		return new File[0];
	}
	
	/**
	 * 
	 * @return url path to load subreports, images and resource bundle
	 */
	public String getRelatedResourcesPath() {
		return resourcePath;
	}
	
	/**
	 * 
	 * @param path
	 * @return true if path is "bundle:*"
	 */
	public static boolean isBundleResourcePath(String path) {
		return path != null && path.startsWith(BUNDLE_PATH_PREFIX);
	}
}
