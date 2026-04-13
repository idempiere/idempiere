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
 **********************************************************************/
package org.idempiere.extension.manager.form;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URI;
import java.net.URL;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import java.util.concurrent.CompletableFuture;

import org.adempiere.base.Core;
import org.adempiere.base.markdown.IMarkdownRenderer;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.Callback;
import org.adempiere.util.ServerContext;
import org.compiere.model.MExtension;
import org.compiere.model.MExtensionEntity;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.MPackageImp;
import org.compiere.model.MPackageImpDetail;
import org.compiere.model.Query;
import org.compiere.model.SystemProperties;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.extension.manager.ExtensionManagerActivator;
import org.idempiere.extension.manager.event.PackageImpDelegate;
import org.osgi.framework.Bundle;
import org.osgi.framework.Version;
import org.osgi.framework.VersionRange;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class ExtensionBrowserService {

	private static final CLogger log = CLogger.getCLogger(ExtensionBrowserService.class);
	private HttpClient httpClient;

	public ExtensionBrowserService() {
		httpClient = HttpClient.newBuilder().followRedirects(HttpClient.Redirect.ALWAYS).build();
	}

	/**
	 * Fetch extensions from the iDempiere Extension Repository
	 * @return JsonArray of extensions
	 * @throws Exception
	 */
	public JsonArray fetchRepositoryExtensions() throws Exception {
		String repoUrl = SystemProperties.getIDempiereRepositoryUrl();
		if (repoUrl == null || repoUrl.trim().isEmpty()) {
			throw new IllegalStateException(Msg.getMsg(Env.getCtx(), "ExtensionRepositoryNotSet")); //iDempiere extension repository URL is not set
		}

		String indexUrl = toRawGithubURL(repoUrl, "index.json");

		// add reasonable timeout
		HttpRequest request = HttpRequest.newBuilder().uri(URI.create(indexUrl)).GET().timeout(Duration.ofSeconds(30)).build();
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		
		if (response.statusCode() == 200) {
			JsonObject indexObj = JsonParser.parseString(response.body()).getAsJsonObject();
			return indexObj.getAsJsonArray("extensions");
		} else {
			throw new RuntimeException(Msg.getMsg(Env.getCtx(), "HttpFetchFailed", new Object[] {response.statusCode(), "index.json"})); //Http {0} fetching {1}
		}
	}

	/**
	 * Get installed extensions
	 * @return List of installed extensions
	 */
	public List<MExtension> getInstalledExtensions() {
		return new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionState IN (?,?)", null)
				.setParameters(MExtension.EXTENSIONSTATE_Installed, MExtension.EXTENSIONSTATE_Disabled)
				.setOnlyActiveRecords(true)
				.list();
	}

	/**
	 * Fetch and render markdown to html
	 * @param url URL to fetch markdown from
	 * @return Rendered markdown
	 */
	public String fetchAndRenderMarkdown(String url) {
		if (url == null || url.isEmpty()) return "";
		
		String rawUrl = toRawGithubPath(url);
		
		try {
			HttpRequest request = HttpRequest.newBuilder().uri(URI.create(rawUrl)).GET().timeout(Duration.ofSeconds(30)).build();
			HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
			
			String markdown = "";
			if (response.statusCode() == 200) {
				markdown = response.body();
			} else {
				throw new Exception(Msg.getMsg(Env.getCtx(), "HttpFetchFailed", new Object[] {response.statusCode(), rawUrl})); //Http {0} fetching {1}
			}
			
			IMarkdownRenderer renderer = Core.getMarkdownRenderer();
			String baseUrl = rawUrl;
			if (baseUrl.contains("/")) {
				baseUrl = baseUrl.substring(0, baseUrl.lastIndexOf('/') + 1);
			}
			return renderer.renderToHtml(markdown, true, baseUrl);
		} catch (Exception e) {
			log.log(Level.SEVERE, "Failed to fetch or render documentation from " + rawUrl, e);
			String safeMessage = e.getMessage() == null ? "" : e.getMessage()
					.replace("&", "&amp;")
					.replace("<", "&lt;")
					.replace(">", "&gt;")
					.replace("\"", "&quot;")
					.replace("'", "&#39;");
			return (
					"<div style=\"padding: 20px; color: '#721c24'; background-color: '#f8d7da'; border: 1px solid '#f5c6cb'; border-radius: 4px;\">" +
					"<h4>%s</h4><p>%s</p></div>"
					).formatted(Msg.getMsg(Env.getCtx(), "Error"), safeMessage);
		}
	}

	/**
	 * Fetch extension metadata from URL
	 * @param url
	 * @return ExtensionMetadata
	 * @throws Exception
	 */
	public ExtensionMetadata fetchExtensionMetadata(String url) throws Exception {
		if (url == null || url.isEmpty()) return null;
		
		String rawUrl = toRawGithubPath(url);
		HttpRequest request = HttpRequest.newBuilder().uri(URI.create(rawUrl)).GET().timeout(Duration.ofSeconds(30)).build();
		HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		
		if (response.statusCode() == 200) {
			String responseBody = response.body();
			List<String> errors = ExtensionMetadataValidator.validate(responseBody);
			if (!errors.isEmpty()) {
				throw new AdempiereException("Metadata Validation Error:\n" + String.join("\n", errors));
			}
			JsonObject json = JsonParser.parseString(responseBody).getAsJsonObject();
			return new ExtensionMetadata(json);
		} else {
			throw new RuntimeException(Msg.getMsg(Env.getCtx(), "HttpFetchFailed", new Object[] {response.statusCode(), rawUrl}));
		}
	}

	/**
	 * Convert github repository URL to raw github URL
	 * @param repoUrl
	 * @param relativePath
	 * @return
	 */
	public String toRawGithubURL(String repoUrl, String relativePath) {
		if (repoUrl.contains("github.com"))
			repoUrl = repoUrl.replace("github.com", "raw.githubusercontent.com");
		String rawUrl = repoUrl.endsWith("/") ? repoUrl + "main/" + relativePath : repoUrl + "/main/" + relativePath;
		return rawUrl;
	}

	/**
	 * Convert github absolute URL to raw github absolute URL
	 * @param absolutePath
	 * @return
	 */
	private String toRawGithubPath(String absolutePath) {
		if (absolutePath.contains("github.com") && absolutePath.contains("/blob/")) {
			absolutePath = absolutePath.replace("github.com", "raw.githubusercontent.com").replace("/blob/", "/");
		}
		return absolutePath;
	}

	/**
	 * Uninstall all OSGi bundles of an extension
	 * @param extension
	 */
	public void uninstallBundles(ExtensionMetadata extension) {
		if (!extension.hasBundles()) return;
		JsonArray bundles = extension.getBundles();
		for (JsonElement bel : bundles) {
			JsonObject b = bel.getAsJsonObject();
			if (b.has("symbolicName")) {
				String symbolicName = b.get("symbolicName").getAsString();
				for (Bundle bundle : ExtensionManagerActivator.context.getBundles()) {
					if (symbolicName.equals(bundle.getSymbolicName())) {
						try {
							if (bundle.getState() != Bundle.UNINSTALLED) {
								if (bundle.getState() == Bundle.ACTIVE) {
									bundle.stop();
								}
								bundle.uninstall();
							}
						} catch (Exception e) {
							log.log(Level.WARNING, "Stop/Uninstall failed for " + symbolicName, e);
						}
					}
				}
			}
		}
	}

	/**
	 * Validate optional database requirement
	 * @param extension
	 * @return error message or null if fulfill
	 * @throws SQLException
	 */
	public String validateDatabaseRequirement(ExtensionMetadata extension) throws SQLException {
		JsonArray array = extension.getDatabase();
		if (array == null || array.isEmpty())
			return null;

		JsonObject dbObject = null;
		for (JsonElement el : array) {
			if (el.isJsonObject()) {
				var jsonObject = el.getAsJsonObject();
				if (jsonObject.has("id")) {
					String id = jsonObject.get("id").getAsString();
					if (DB.isPostgreSQL() && "postgresql".equals(id))
						dbObject = jsonObject;
					else if (DB.isOracle() && "oracle".equals(id))
						dbObject = jsonObject;
				}
			}
			if (dbObject != null)
				break;
		}
		if (dbObject == null)
			return Msg.getMsg(Env.getCtx(), "DatabaseTypeNotSupported", new Object[] {DB.getDatabase().getName()}); //Database {0} not supported
		
		//validate version
		if (dbObject.has("version")) {
			String version = dbObject.get("version").getAsString();
			try (Connection conn = DB.getConnection()) {
				DatabaseMetaData dbmd = conn.getMetaData();
				String fullVersion = dbmd.getDatabaseProductVersion();
				Version requiredVersion = Version.parseVersion(version);
				Version currentVersion = Version.parseVersion(fullVersion.indexOf(" ") > 0 ? fullVersion.substring(0, fullVersion.indexOf(" ")) : fullVersion);
				if (currentVersion.compareTo(requiredVersion) < 0) {
					//{0} version {1} is too old, {2} and above is required
					return Msg.getMsg(Env.getCtx(), "DatabaseVersionTooOld", new Object[] {DB.getDatabase().getName(), currentVersion, requiredVersion});
				}
			}
		}

		//validate PostgreSQL extensions
		if (DB.isPostgreSQL() && dbObject.has("extensions")) {
			JsonArray dbExtensions = dbObject.getAsJsonArray("extensions");
			for (JsonElement el : dbExtensions) {
				String dbExtensionName = el.getAsString();
				int count = DB.getSQLValue(null, "SELECT count(*) FROM pg_available_extensions WHERE name = ?", dbExtensionName.trim());
				if (count == 0)
					//The required extension {0} is not found on this {1} server
					return Msg.getMsg(Env.getCtx(), "DatabaseExtensionNotFound", new Object[] {dbExtensionName, DB.getDatabase().getName()});
			}
		}

		return null;
	}

	/**
	 * Uninstall an extension
	 * @param extension
	 * @throws Exception
	 */
	public void uninstallExtension(ExtensionMetadata extension) throws Exception {
		String extensionId = extension.getId();
		MExtension mExtension = null;
		if (extensionId != null) {
			mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
					.setParameters(extensionId)
					.setOnlyActiveRecords(true)
					.first();
		}
		if (mExtension == null) {
			throw new AdempiereException("Extension not found: " + extensionId);				
		}
		
		try {
			disableExtensionEntities(mExtension);
		} catch (Exception e) {
			log.log(Level.SEVERE, "Error disabling extension entities for " + extensionId, e);
		}
		uninstallBundles(extension);
		mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Uninstalled);
		mExtension.saveEx();
	}

	/**
	 * Disable and stop an extension
	 * @param extension
	 * @throws Exception
	 */
	public void disableExtension(ExtensionMetadata extension) throws Exception {
		if (extension.hasBundles()) {
			JsonArray bundles = extension.getBundles();
			for (JsonElement bel : bundles) {
				JsonObject b = bel.getAsJsonObject();
				if (b.has("symbolicName")) {
					String symbolicName = b.get("symbolicName").getAsString();
					for (Bundle bundle : ExtensionManagerActivator.context.getBundles()) {
						if (symbolicName.equals(bundle.getSymbolicName())) {
							bundle.stop();
						}
					}
				}
			}
		}
		String extensionId = extension.getId();
		if (extensionId != null) {
			MExtension mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
					.setParameters(extensionId)
					.first();
			if (mExtension != null) {
				mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Disabled);
				mExtension.saveEx();
				
				disableExtensionEntities(mExtension);
			}
		}
		CacheMgt.get().reset();
	}

	private void disableExtensionEntities(MExtension mExtension) {
		List<MExtensionEntity> entities = new Query(Env.getCtx(), MExtensionEntity.Table_Name, "AD_Extension_ID=?", null)
				.setParameters(mExtension.getAD_Extension_ID())
				.list();
		for (MExtensionEntity entity : entities) {
			MTable table = MTable.get(Env.getCtx(), entity.getAD_Table_ID());
			if (table == null)
				continue;
			POInfo poInfo = POInfo.getPOInfo(Env.getCtx(), table.getAD_Table_ID());
			if (poInfo == null || poInfo.getTableName() == null)
				continue;
			PO po = table.getPOByUU(entity.getRecord_UU(), null);
			if (po != null) {
				if (po.get_ColumnIndex("IsActive") >= 0) {
					if (po.set_Value("IsActive", false))
						po.saveEx();
				}
			}
		}
	}

	/**
	 * Enable and start an extension
	 * @param extension
	 * @throws Exception
	 */
	public void enableExtension(ExtensionMetadata extension) throws Exception {
		String extensionId = extension.getId();
		MExtension mExtension = null;
		if (extensionId != null) {
			mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
					.setParameters(extensionId)
					.setOnlyActiveRecords(true)
					.first();
		}
		if (mExtension == null) {
			throw new AdempiereException("Extension not found: " + extensionId);				
		}

		validateDependencies(extension);

		if (extension.hasBundles()) {
			JsonArray bundles = extension.getBundles();
			for (JsonElement bel : bundles) {
				JsonObject b = bel.getAsJsonObject();
				if (b.has("symbolicName")) {
					String symbolicName = b.get("symbolicName").getAsString();
					for (Bundle bundle : ExtensionManagerActivator.context.getBundles()) {
						if (symbolicName.equals(bundle.getSymbolicName())) {
							bundle.start();
						}
					}
				}
			}
		}
		
		mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Installed);
		mExtension.saveEx();
		
		enableExtensionEntities(mExtension);
		
		CacheMgt.get().reset();
	}

	/**
	 * Set extension entities to active
	 * @param mExtension
	 */
	public void enableExtensionEntities(MExtension mExtension) {
		List<MExtensionEntity> entities = new Query(Env.getCtx(), MExtensionEntity.Table_Name, "AD_Extension_ID=?", null)
				.setParameters(mExtension.getAD_Extension_ID())
				.list();
		for (MExtensionEntity entity : entities) {
			MTable table = MTable.get(Env.getCtx(), entity.getAD_Table_ID());
			if (table == null)
				continue;
			POInfo poInfo = POInfo.getPOInfo(Env.getCtx(), table.getAD_Table_ID());
			if (poInfo == null || poInfo.getTableName() == null)
				continue;
			PO po = table.getPOByUU(entity.getRecord_UU(), null);
			if (po != null) {
				if (po.get_ColumnIndex("IsActive") >= 0) {
					if (po.set_Value("IsActive", true))
						po.saveEx();
				}
			}
		}
	}

	/**
	 * Create extension archive (.idext)
	 * @param extension
	 * @return
	 * @throws Exception
	 */
	public File buildArchive(ExtensionMetadata extension) throws Exception {
		File tempFile = File.createTempFile("extension", ".idext");
		try (ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(tempFile))) {
			// 1. metadata.json
			zos.putNextEntry(new ZipEntry("metadata.json"));
			zos.write(extension.toString().getBytes(StandardCharsets.UTF_8));
			zos.closeEntry();

			// 2. info.md
			if (extension.hasInfoUrl()) {
				String infoUrl = extension.getInfoUrl();
				infoUrl = toRawGithubPath(infoUrl);
				HttpRequest reqInfo = HttpRequest.newBuilder().uri(URI.create(infoUrl)).GET().timeout(Duration.ofSeconds(30)).build();
				HttpResponse<byte[]> resInfo = httpClient.send(reqInfo, HttpResponse.BodyHandlers.ofByteArray());
				if (resInfo.statusCode() == 200) {
					zos.putNextEntry(new ZipEntry("info.md"));
					zos.write(resInfo.body());
					zos.closeEntry();
				}
			}

			// 3. CHANGELOG.md
			if (extension.hasChangeLogUrl()) {
				String changelogUrl = extension.getChangeLogUrl();
				changelogUrl = toRawGithubPath(changelogUrl);
				HttpRequest reqChangelog = HttpRequest.newBuilder().uri(URI.create(changelogUrl)).GET().timeout(Duration.ofSeconds(30)).build();
				HttpResponse<byte[]> resChangelog = httpClient.send(reqChangelog, HttpResponse.BodyHandlers.ofByteArray());
				if (resChangelog.statusCode() == 200) {
					zos.putNextEntry(new ZipEntry("CHANGELOG.md"));
					zos.write(resChangelog.body());
					zos.closeEntry();
				}
			}

			// 4. assets
			if (extension.hasAssets()) {
				JsonArray assets = extension.getAssets();
				for (JsonElement ael : assets) {
					JsonObject a = ael.getAsJsonObject();
					if (a.has("url") && a.has("name")) {
						String aUrl = a.get("url").getAsString();
						aUrl = toRawGithubPath(aUrl);
						String assetName = Paths.get(a.get("name").getAsString()).getFileName().toString();
						try {
							HttpRequest reqAsset = HttpRequest.newBuilder().uri(URI.create(aUrl)).GET().timeout(Duration.ofSeconds(30)).build();
							HttpResponse<byte[]> resAsset = httpClient.send(reqAsset, HttpResponse.BodyHandlers.ofByteArray());
							if (resAsset.statusCode() == 200) {
								zos.putNextEntry(new ZipEntry("assets/" + assetName));
								zos.write(resAsset.body());
								zos.closeEntry();
							}
						} catch (Exception e) {
							log.log(Level.WARNING, "Failed to fetch asset: " + aUrl, e);
						}
					}
				}
			}

			// 5. bundles
			if (extension.hasBundles()) {
				JsonArray bundles = extension.getBundles();
				for (JsonElement bel : bundles) {
					JsonObject b = bel.getAsJsonObject();
					if (b.has("downloadUrl")) {
						String dUrl = toRawGithubPath(b.getAsJsonPrimitive("downloadUrl").getAsString());
						HttpRequest reqJar = HttpRequest.newBuilder().uri(URI.create(dUrl)).GET().timeout(Duration.ofSeconds(30)).build();
						HttpResponse<InputStream> resJar = httpClient.send(reqJar, HttpResponse.BodyHandlers.ofInputStream());
						if (resJar.statusCode() == 200) {
							String fileName = Paths.get(URI.create(dUrl).getPath()).getFileName().toString();
							if (!fileName.endsWith(".jar") && b.has("symbolicName")) {
								fileName = b.getAsJsonPrimitive("symbolicName").getAsString() + ".jar";
							}
							zos.putNextEntry(new ZipEntry("bundles/" + fileName));
							resJar.body().transferTo(zos);
							zos.closeEntry();
						}
					}
				}
			}
		} catch (Exception e) {
			tempFile.delete();
			throw e;
		}
		return tempFile;
	}

	/**
	 * Check if all OSGi bundles of an extension are installed
	 * @param extension
	 * @return true if all OSGi bundles of an extension are installed
	 */
	public boolean checkAllBundlesInstalled(ExtensionMetadata extension) {
		JsonArray bundles = extension.getBundles();
		if (bundles == null || bundles.size() == 0) return false;
		
		for (JsonElement bel : bundles) {
			String symbolicName = bel.getAsJsonObject().get("symbolicName").getAsString();
			boolean found = false;
			for (Bundle bundle : ExtensionManagerActivator.context.getBundles()) {
				if (symbolicName.equals(bundle.getSymbolicName())) {
					found = true;
					break;
				}
			}
			if (!found) return false;
		}
		return true;
	}

	/**
	 * Create MExtension record
	 * @param extension
	 * @return
	 */
	public MExtension autoRegisterExtension(ExtensionMetadata extension) {
		// update existing state if exits
		MExtension mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
				.setParameters(extension.getId())
				.first();
		if (mExtension != null) {
			mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Installed);
			mExtension.setIsActive(true);
			mExtension.saveEx();
			return mExtension;
		}
		mExtension = new MExtension(Env.getCtx(), 0, null);
		mExtension.setExtensionId(extension.getId());
		mExtension.setName(extension.getName());
		mExtension.setExtensionVersion(extension.getVersion());
		mExtension.setExtensionMetadata(extension.toString());
		mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Installed);
		mExtension.saveEx();
		return mExtension;
	}

	/**
	 * Create MExtensionEntity records for an extension from 2Pack installed histories
	 * @param mExtension
	 * @param extension
	 */
	public void syncExtensionEntities(MExtension mExtension, ExtensionMetadata extension) {
		final Properties ctx = new Properties();
		ctx.putAll(ServerContext.getCurrentInstance());
		CompletableFuture.runAsync(() -> {
			try {
				ServerContext.setCurrentInstance(ctx);
				if (!extension.hasBundles()) return;
				JsonArray bundles = extension.getBundles();
				for (JsonElement bel : bundles) {
					String symbolicName = bel.getAsJsonObject().get("symbolicName").getAsString();
					List<MPackageImp> imps = new Query(Env.getCtx(), MPackageImp.Table_Name, "Name=? AND PK_Status=?", null)
							.setParameters(symbolicName, MPackageImp.PACKAGE_STATUS_COMPLETED)
							.setOnlyActiveRecords(true)
							.list();
					for (MPackageImp imp : imps) {
						List<MPackageImpDetail> details = new Query(Env.getCtx(), MPackageImpDetail.Table_Name, "AD_Package_Imp_ID=? AND Success=? AND Action IN (?,?)", null)
								.setParameters(imp.getAD_Package_Imp_ID(), MPackageImpDetail.ACTION_STATUS_SUCCESS, MPackageImpDetail.ACTION_INSERT, MPackageImpDetail.ACTION_UPDATE)
								.setOnlyActiveRecords(true)
								.list();
						for (MPackageImpDetail detail : details) {
							MExtensionEntity entity = new Query(Env.getCtx(), MExtensionEntity.Table_Name, "AD_Extension_ID=? AND AD_Table_ID=? AND Record_UU=?", null)
									.setParameters(mExtension.getAD_Extension_ID(), detail.getAD_Table_ID(), detail.getRecord_UU())
									.setOnlyActiveRecords(true)
									.first();
							if (entity == null) {
								entity = new MExtensionEntity(Env.getCtx(), 0, null);
								entity.setAD_Extension_ID(mExtension.getAD_Extension_ID());
								entity.setAD_Table_ID(detail.getAD_Table_ID());
								entity.setRecord_UU(detail.getRecord_UU());
								entity.saveEx();
							}
						}
					}
				}
			} finally {
				ServerContext.dispose();
			}
		}).exceptionally(e -> {
			log.log(Level.SEVERE, "Failed to sync extension entities for " + extension.getId(), e);
			return null;
		});
	}

	/**
	 * Prepare MExtension record for installation of extension
	 * @param extension
	 * @return MExtension record with Installing state
	 * @throws Exception
	 */
	public MExtension prepareInstall(ExtensionMetadata extension) throws Exception {
		String id = extension.getId();
		String version = extension.getVersion();

		MExtension mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
				.setParameters(id)
				.setOnlyActiveRecords(true)
				.first();
		if (mExtension != null && MExtension.EXTENSIONSTATE_Installing.equals(mExtension.getExtensionState())) {
			throw new IllegalStateException(Msg.getMsg(Env.getCtx(), "ExtensionAlreadyInstalling")); //Extension is already being installed
		}
		
		// Version check and bundles cleanup
		if (extension.hasBundles()) {
			JsonArray bundles = extension.getBundles();
			for (JsonElement bel : bundles) {
				JsonObject b = bel.getAsJsonObject();
				if (b.has("symbolicName")) {
					String symbolicName = b.get("symbolicName").getAsString();
					Version newVersion = Version.parseVersion(b.has("version") ? b.get("version").getAsString() : "0.0.0");
					for (Bundle bundle : ExtensionManagerActivator.context.getBundles()) {
						if (symbolicName.equals(bundle.getSymbolicName())) {
							Version currentVersion = bundle.getVersion();
							if (currentVersion != null && currentVersion.compareTo(newVersion) > 0) {
								throw new IllegalStateException(Msg.getMsg(Env.getCtx(), "ExtensionBundleNewerVersionInstalled", new Object[] {symbolicName, currentVersion})); //A newer version of bundle {0} ({1}) is already installed
							}
							// If exists and is not newer, uninstall it
							try {
								if (bundle.getState() == Bundle.ACTIVE) {
									bundle.stop();
								}
								bundle.uninstall();
							} catch (Exception e) {
								log.log(Level.WARNING, "Failed to uninstall existing bundle " + symbolicName, e);
							}
						}
					}
				}
			}
		}

		if (mExtension == null) {
			mExtension = new MExtension(Env.getCtx(), 0, null);
			mExtension.setExtensionId(id);
			mExtension.setName(extension.getName());
		}
		mExtension.setExtensionVersion(version);
		mExtension.setExtensionMetadata(extension.toString());
		mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Installing);
		mExtension.saveEx();
		
		return mExtension;
	}

	/**
	 * Update MExtension record to Installed state
	 * @param extension
	 */
	public void handleInstallationSuccess(ExtensionMetadata extension) {
		String extensionId = extension.getId();
		if (extensionId != null) {
			MExtension mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
					.setParameters(extensionId)
					.first();
			if (mExtension != null) {
				mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Installed);
				mExtension.saveEx();
			}
		}
	}

	/**
	 * Update MExtension record to Error state
	 * @param extension
	 */
	public void handleInstallationFailure(ExtensionMetadata extension) {
		try {
			String extensionId = extension.getId();
			if (extensionId != null) {
				MExtension mExtension = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
						.setParameters(extensionId)
						.first();
				if (mExtension != null) {
					mExtension.setExtensionState(MExtension.EXTENSIONSTATE_Error);
					mExtension.saveEx();
				}
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "Failed to update extension state to Error", e);
		} finally {
			try {
				uninstallBundles(extension);
			} catch (Exception e) {
				log.log(Level.SEVERE, "Failed to cleanup bundles after installation failure", e);
			}
		}
	}

	/**
	 * Validate dependencies of an extension
	 * @param metadata
	 * @throws AdempiereException if validation fail
	 */
	public void validateDependencies(ExtensionMetadata metadata) {
		// Dependency Check
		if (metadata.hasDependencies()) {
			JsonArray dependencies = metadata.getDependencies();
			for (JsonElement depEl : dependencies) {
				JsonObject depObj = depEl.getAsJsonObject();
				if (!depObj.has("id") || !depObj.has("version")) {
					continue;
				}
				String depId = depObj.get("id").getAsString();
				String depVersionStr = depObj.get("version").getAsString();
				VersionRange depVersionRange = new VersionRange(depVersionStr);
				
				MExtension depExt = new Query(Env.getCtx(), MExtension.Table_Name, "ExtensionId=?", null)
						.setParameters(depId)
						.setOnlyActiveRecords(true)
						.first();
				
				if (depExt == null || !MExtension.EXTENSIONSTATE_Installed.equals(depExt.getExtensionState())) {
					//Missing dependency: {0}. Please install it first
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "MissingDependency", new Object[] {depId}));
				}
				
				Version installedDepVersion = Version.parseVersion(depExt.getExtensionVersion());
				if (!depVersionRange.includes(installedDepVersion)) {
					//Incompatible dependency version: {0}. Required {1} and above but installed {2}
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "IncompatibleDependencyVersion", new Object[] {depId, depVersionStr, depExt.getExtensionVersion()}));
				}
			}
		}
	}

	/**
	 * Validate no other extension depends on this extension
	 * @param metadata
	 * @throws AdempiereException if validation fail
	 */
	public void validateNoDependentExtensions(ExtensionMetadata metadata) {
		String extensionId = metadata.getId();
		String sql = null;
		Object[] params = null;
		
		if (DB.isPostgreSQL()) {
			sql = "SELECT Name FROM AD_Extension " +
				  "WHERE jsonb_path_exists(ExtensionMetadata, '$.dependencies[*].id ? (@ == $extId)', CAST(? AS jsonb)) " +
				  "AND ExtensionState = 'IN' " +
				  "AND ExtensionId != ? AND IsActive='Y' AND AD_Client_ID=0";
			String jsonVars = "{\"extId\": \"" + extensionId + "\"}";
			params = new Object[] { jsonVars, extensionId };
		} else if (DB.isOracle()) {
			sql = "SELECT Name FROM AD_Extension " +
				  "WHERE JSON_EXISTS(ExtensionMetadata, '$.dependencies[*]?(@.id == $extId)' PASSING ? AS \"extId\") " +
				  "AND ExtensionState = 'IN' " +
				  "AND ExtensionId != ? AND IsActive='Y' AND AD_Client_ID=0";
			params = new Object[] { extensionId, extensionId };
		}
		
		if (sql != null) {
			List<String> dependents = new ArrayList<>();
			try (java.sql.PreparedStatement pstmt = DB.prepareStatement(sql, null)) {
				for (int i = 0; i < params.length; i++) {
					pstmt.setObject(i + 1, params[i]);
				}
				try (java.sql.ResultSet rs = pstmt.executeQuery()) {
					while (rs.next()) {
						dependents.add(rs.getString(1));
					}
				}
			} catch (Exception e) {
				log.log(Level.SEVERE, "Failed to execute dependency validation SQL: " + sql, e);
				throw new AdempiereException("Failed to validate dependencies via SQL: " + e.getMessage());
			}
			
			if (!dependents.isEmpty()) {
				// Cannot uninstall extension {0} because the following extensions depend on it: {1}
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ExtensionHasDependents", new Object[] {metadata.getName(), String.join(", ", dependents)}));
			}
		} else {
			// Fallback to slower Java-based check for other databases
			List<MExtension> installedExtensions = getInstalledExtensions();
			List<String> dependents = new ArrayList<>();
			for (MExtension ext : installedExtensions) {
				if (ext.getExtensionId().equals(extensionId)) {
					continue;
				}
				String metadataJson = ext.getExtensionMetadata();
				if (metadataJson == null || metadataJson.isEmpty()) {
					continue;
				}
				try {
					ExtensionMetadata extMetadata = new ExtensionMetadata(JsonParser.parseString(metadataJson).getAsJsonObject());
					if (extMetadata.hasDependencies()) {
						JsonArray dependencies = extMetadata.getDependencies();
						for (JsonElement depEl : dependencies) {
							JsonObject depObj = depEl.getAsJsonObject();
							if (depObj.has("id") && extensionId.equals(depObj.get("id").getAsString())) {
								dependents.add(ext.getName());
								break;
							}
						}
					}
				} catch (Exception e) {
					log.log(Level.WARNING, "Failed to parse metadata for extension: " + ext.getExtensionId(), e);
				}
			}
			if (!dependents.isEmpty()) {
				// Cannot uninstall extension {0} because the following extensions depend on it: {1}
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ExtensionHasDependents", new Object[] {metadata.getName(), String.join(", ", dependents)}));
			}
		}
	}

	/**
	 * Validate iDempiere version compatibility
	 * @param metadata
	 * @throws AdempiereException if validation fail
	 */
	public void validateIDempiereVersion(ExtensionMetadata metadata) {
		String requiredVersion = metadata.getIDempiereVersion();
		VersionRange requiredVersionRange = new VersionRange(requiredVersion);		
		String currentVersion = org.compiere.Adempiere.getVersion();
		Version currentVersionObj = Version.parseVersion(currentVersion);
		if (!requiredVersionRange.includes(currentVersionObj)) {
			//Incompatible iDempiere version. Extension requires {0} and above but current version is {1}"
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "IncompatibleIdempiereVersion", new Object[] { requiredVersion, currentVersion }));
		}
	}

	public void installExtension(ExtensionMetadata metadata, Callback<String> statusCallback) throws Exception {
		List<Bundle> installedBundles = new ArrayList<>();
				
		// Download and Install OSGi Bundles
		for (JsonElement el : metadata.getBundles()) {
			JsonObject bundleObj = el.getAsJsonObject();
			if (!bundleObj.has("downloadUrl")) {
				//Bundle {0} is missing downloadUrl
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "BundleNoDownloadURL", new Object[]{bundleObj.get("symbolicName").getAsString()}));
			}
			String downloadUrl = bundleObj.get("downloadUrl").getAsString();
			String symbolicName = bundleObj.get("symbolicName").getAsString();
			String id = metadata.getId();
			PackageImpDelegate.addExtension(symbolicName, id);
			
			// convert github blob to raw if needed
			if (downloadUrl.contains("github.com") && downloadUrl.contains("/blob/")) {
				downloadUrl = downloadUrl.replace("github.com", "raw.githubusercontent.com").replace("/blob/", "/");
			}
		
			if (statusCallback != null)
				statusCallback.onCallback(Msg.getMsg(Env.getCtx(), "DownloadingBundleFrom", new Object[]{bundleObj.get("symbolicName").getAsString(), downloadUrl}));

			HttpRequest jarRequest = HttpRequest.newBuilder().uri(URI.create(downloadUrl)).GET().timeout(Duration.ofSeconds(30)).build();
			HttpResponse<InputStream> jarResponse = httpClient.send(jarRequest, HttpResponse.BodyHandlers.ofInputStream());
			
			if (jarResponse.statusCode() != 200) {
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "HttpFetchFailed", new Object[]{jarResponse.statusCode(), downloadUrl}));
			}
			
			File tempZip = File.createTempFile("extbundle_", ".jar");
			
			try (InputStream is = jarResponse.body(); FileOutputStream fos = new FileOutputStream(tempZip)) {
				is.transferTo(fos);
			}
			
			if (bundleObj.has("sha256")) {
				String expectedSha256 = bundleObj.get("sha256").getAsString();
				String actualSha256 = calculateSHA256(tempZip);
				if (!expectedSha256.equalsIgnoreCase(actualSha256)) {
					tempZip.delete();
					//BundleSHA256HashNotMatch SHA256 hash mismatch for bundle {0}. Expected {1} but got {2}
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "BundleSHA256HashNotMatch", new Object[]{downloadUrl, expectedSha256, actualSha256}));
				}
			}
			
			if (statusCallback != null)
				statusCallback.onCallback(Msg.getMsg(Env.getCtx(), "InstallingExtensionBundle", new Object[]{downloadUrl}));
			Bundle bundle;
			try (java.io.FileInputStream fis = new java.io.FileInputStream(tempZip)) {
				bundle = ExtensionManagerActivator.context.installBundle(downloadUrl, fis);
			}
			installedBundles.add(bundle);
			
			tempZip.delete();
		}
		
		// Start (Activate) Bundles and Check for 2pack		
		List<String> twoPackBundles = new ArrayList<>();
		for (Bundle bundle : installedBundles) {
			Enumeration<URL> entries = bundle.findEntries("META-INF", "2Pack_*.zip", false);
			if (entries != null && entries.hasMoreElements()) {
				twoPackBundles.add(bundle.getSymbolicName());
			}
			if (statusCallback != null)
				statusCallback.onCallback(Msg.getMsg(Env.getCtx(), "StartingExtensionBundle", new Object[]{bundle.getSymbolicName()}));
			bundle.start();			
		}

		if (twoPackBundles.size() > 0) {
			StringBuilder whereBuilder = new StringBuilder("Name IN (");
			for (int i = 0; i < twoPackBundles.size(); i++) {
				whereBuilder.append("?");
				if (i < twoPackBundles.size() - 1) {
					whereBuilder.append(",");
				}
			}
			whereBuilder.append(") AND PK_Status = ?");
			List<Object> params = new ArrayList<>(twoPackBundles);
			params.add(MPackageImp.PACKAGE_STATUS_INSTALLING);
			Query query = new Query(Env.getCtx(), MPackageImp.Table_Name, whereBuilder.toString(), null)
					.setParameters(params.toArray());
			int count = query.count();
			if (count > 0) {
				if (statusCallback != null)
					statusCallback.onCallback(Msg.getMsg(Env.getCtx(), "ImportingExtensionDataInBackground"));
			}
		}

		handleInstallationSuccess(metadata);
	}

	private String calculateSHA256(File file) throws Exception {
		java.security.MessageDigest digest = java.security.MessageDigest.getInstance("SHA-256");
		try (java.io.InputStream is = new java.io.FileInputStream(file)) {
			byte[] buffer = new byte[8192];
			int read;
			while ((read = is.read(buffer)) > 0) {
				digest.update(buffer, 0, read);
			}
		}
		byte[] hash = digest.digest();
		StringBuilder hexString = new StringBuilder();
		for (byte b : hash) {
			String hex = Integer.toHexString(0xff & b);
			if (hex.length() == 1) {
				hexString.append('0');
			}
			hexString.append(hex);
		}
		return hexString.toString();
	}

}
