/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.plugin.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.IDictionaryService;
import org.adempiere.util.ServerContext;
import org.compiere.Adempiere;
import org.compiere.model.Query;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;
import org.osgi.util.tracker.ServiceTrackerCustomizer;

/**
 * 
 * @author hengsin
 *
 */
public class Incremental2PackActivator implements BundleActivator, ServiceTrackerCustomizer<IDictionaryService, IDictionaryService> {

	protected final static CLogger logger = CLogger.getCLogger(Incremental2PackActivator.class.getName());
	private BundleContext context;
	private ServiceTracker<IDictionaryService, IDictionaryService> serviceTracker;
	private IDictionaryService service;

	@Override
	public void start(BundleContext context) throws Exception {
		this.context = context;
		if (logger.isLoggable(Level.INFO)) logger.info(getName() + " " + getVersion() + " starting...");
		serviceTracker = new ServiceTracker<IDictionaryService, IDictionaryService>(context, IDictionaryService.class.getName(), this);
		serviceTracker.open();
		start();
		if (logger.isLoggable(Level.INFO)) logger.info(getName() + " " + getVersion() + " ready.");
	}

	public String getName() {
		return context.getBundle().getSymbolicName();
	}

	public String getVersion() {
		String version = (String) context.getBundle().getHeaders().get("Bundle-Version");
		// e.g. 1.0.0.qualifier, check only the "1.0.0" part
		String[] components = version.split("[.]");
		StringBuilder versionBuilder = new StringBuilder(components[0]);
		if (components.length >= 3) {
			versionBuilder.append(".").append(components[1]).append(".").append(components[2]);
		} else if (components.length == 2) {
			versionBuilder.append(".").append(components[1]).append(".0");
		} else {
			versionBuilder.append(".0.0");
		}
		return versionBuilder.toString();
	}

	public String getDescription() {
		return getName();
	}

	private void installPackage() {
		String trxName = Trx.createTrxName();
		try {			
			// e.g. 1.0.0.qualifier, check only the "1.0.0" part
			String bundleVersionPart = getVersion();
			String installedVersionPart = null;
			String where = "Name=?";
			Query q = new Query(Env.getCtx(), X_AD_Package_Imp.Table_Name,
					where.toString(), null);
			q.setParameters(new Object[] { getName() });
			List<X_AD_Package_Imp> pkgs = q.list();
			if (pkgs != null && !pkgs.isEmpty()) {
				for(X_AD_Package_Imp pkg : pkgs) {
					String packageVersionPart = pkg.getPK_Version();
					String[] part = packageVersionPart.split("[.]");
					if (installedVersionPart == null) {
						if (part.length > 3) {
							installedVersionPart = part[0]+"."+part[1]+"."+part[2];
						} else {
							installedVersionPart = packageVersionPart;
						}
					} else {
						Version installedVersion = new Version(installedVersionPart);
						if (part.length > 3) {
							packageVersionPart = part[0]+"."+part[1]+"."+part[2];
						}
						Version packageVersion = new Version(packageVersionPart);
						if (packageVersion.compareTo(installedVersion) > 0) {
							installedVersionPart = packageVersionPart;
						}
					}
				}
			}
			packIn(trxName, installedVersionPart, bundleVersionPart);
			afterPackIn();
			Trx.get(trxName, false).commit();
		} finally {
			if (Trx.get(trxName, false) != null) {
				Trx.get(trxName, false).close();
			}
		}
	}
	
	private static class TwoPackEntry {
		private URL url;
		private String version;
		private TwoPackEntry(URL url, String version) {
			this.url=url;
			this.version = version;
		}
	}
	
	protected void packIn(String trxName, String installedVersionPart, String bundleVersionPart) {
		List<TwoPackEntry> list = new ArrayList<TwoPackEntry>();
				
		//2Pack_1.0.0.zip, 2Pack_1.0.1.zip, etc
		Enumeration<URL> urls = context.getBundle().findEntries("/META-INF", "2Pack_*.zip", false);
		Version bundleVersion = new Version(bundleVersionPart);
		if (!Util.isEmpty(installedVersionPart)) {
			Version installedVersion = new Version(installedVersionPart);
			while(urls.hasMoreElements()) {
				URL u = urls.nextElement();
				String version = extractVersionString(u);
				Version packageVersion = new Version(version);
				if (packageVersion.compareTo(bundleVersion) <= 0 && packageVersion.compareTo(installedVersion) > 0)
					list.add(new TwoPackEntry(u, version));
			}
		} else {
			while(urls.hasMoreElements()) {
				URL u = urls.nextElement();
				String version = extractVersionString(u);
				Version packageVersion = new Version(version);
				if (packageVersion.compareTo(bundleVersion) <= 0)
					list.add(new TwoPackEntry(u, version));
			}
		}
		
		Collections.sort(list, new Comparator<TwoPackEntry>() {
			@Override
			public int compare(TwoPackEntry o1, TwoPackEntry o2) {
				return new Version(o1.version).compareTo(new Version(o2.version));
			}
		});		
				
		for(TwoPackEntry entry : list) {
			packIn(trxName, entry.url);
		}
	}

	private String extractVersionString(URL u) {
		String p = u.getPath();
		int upos=p.lastIndexOf("_");
		int dpos=p.lastIndexOf(".");
		String v = p.substring(upos+1, dpos);
		return v;
	}

	protected void packIn(String trxName, URL packout) {
		if (packout != null && service != null) {
			String path = packout.getPath();
			String suffix = path.substring(path.lastIndexOf("_"));
			System.out.println("Installing " + getName() + " " + path + " ...");
			FileOutputStream zipstream = null;
			try {
				// copy the resource to a temporary file to process it with 2pack
				InputStream stream = packout.openStream();
				File zipfile = File.createTempFile(getName(), suffix);
				zipstream = new FileOutputStream(zipfile);
			    byte[] buffer = new byte[1024];
			    int read;
			    while((read = stream.read(buffer)) != -1){
			    	zipstream.write(buffer, 0, read);
			    }
			    // call 2pack
				service.merge(context, zipfile);
			} catch (Throwable e) {
				logger.log(Level.SEVERE, "Pack in failed.", e);
			} finally{
				if (zipstream != null) {
					try {
						zipstream.close();
					} catch (Exception e2) {}
				}
			}
			System.out.println(getName() + " " + packout.getPath() + " installed");
		} 
	}

	protected BundleContext getContext() {
		return context;
	}

	protected void setContext(BundleContext context) {
		this.context = context;
	}
	
	@Override
	public void stop(BundleContext context) throws Exception {
		stop();
		serviceTracker.close();
		this.context = null;
		if (logger.isLoggable(Level.INFO)) logger.info(context.getBundle().getSymbolicName() + " "
				+ context.getBundle().getHeaders().get("Bundle-Version")
				+ " stopped.");
	}

	protected void afterPackIn() {
	};

	/**
	 * call when bundle have been started ( after this.context have been set )
	 */
	protected void start() {
	};

	/**
	 * call when bundle is stop ( before this.context is set to null )
	 */
	protected void stop() {
	}

	@Override
	public IDictionaryService addingService(
			ServiceReference<IDictionaryService> reference) {
		service = context.getService(reference);
		if (Adempiere.getThreadPoolExecutor() != null) {
			Adempiere.getThreadPoolExecutor().execute(new Runnable() {			
				@Override
				public void run() {
					ClassLoader cl = Thread.currentThread().getContextClassLoader();
					try {
						Thread.currentThread().setContextClassLoader(Incremental2PackActivator.class.getClassLoader());
						setupPackInContext();
						installPackage();
					} finally {
						ServerContext.dispose();
						service = null;
						Thread.currentThread().setContextClassLoader(cl);
					}
				}
			});
		} else {
			Adempiere.addServerStateChangeListener(new ServerStateChangeListener() {				
				@Override
				public void stateChange(ServerStateChangeEvent event) {
					if (event.getEventType() == ServerStateChangeEvent.SERVER_START && service != null) {
						ClassLoader cl = Thread.currentThread().getContextClassLoader();
						try {
							Thread.currentThread().setContextClassLoader(Incremental2PackActivator.class.getClassLoader());
							setupPackInContext();
							installPackage();
						} finally {
							ServerContext.dispose();
							service = null;
							Thread.currentThread().setContextClassLoader(cl);
						}
					}					
				}
			});
		}
		return null;
	}

	@Override
	public void modifiedService(ServiceReference<IDictionaryService> reference,
			IDictionaryService service) {
	}

	@Override
	public void removedService(ServiceReference<IDictionaryService> reference,
			IDictionaryService service) {
	}

	protected void setupPackInContext() {
		Properties serverContext = new Properties();
		ServerContext.setCurrentInstance(serverContext);
	};
}
