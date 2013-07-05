package org.adempiere.plugin.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
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
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;
import org.osgi.util.tracker.ServiceTrackerCustomizer;

public class AdempiereActivator implements BundleActivator, ServiceTrackerCustomizer<IDictionaryService, IDictionaryService> {

	protected final static CLogger logger = CLogger.getCLogger(AdempiereActivator.class.getName());
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
		return (String) context.getBundle().getHeaders().get("Bundle-Version");
	}

	public String getDescription() {
		return getName();
	}

	private void installPackage() {
		String trxName = Trx.createTrxName();
		try {
			
			// e.g. 1.0.0.qualifier, check only the "1.0.0" part
			String version = getVersion();
			if (version != null)
			{
				int count = 0;
				int index = -1;
				for(int i = 0; i < version.length(); i++)
				{
					if(version.charAt(i) == '.')
						count++;
					
					if (count == 3)
					{
						index = i;
						break;
					}
				}
				
				if (index == -1)
					index = version.length();
				version = version.substring(0,  index);
			}
			
			String where = "Name=? AND PK_Version LIKE ?";
			Query q = new Query(Env.getCtx(), X_AD_Package_Imp.Table_Name,
					where.toString(), null);
			q.setParameters(new Object[] { getName(), version + "%" });
			X_AD_Package_Imp pkg = q.first();
			if (pkg == null) {
				System.out.println("Installing " + getName() + " " + version + " ...");
				packIn(trxName);
				install();
				System.out.println(getName() + " " + version + " installed.");
			} else {
				if (logger.isLoggable(Level.INFO)) logger.info(getName() + " " + version + " was installed: "
						+ pkg.getCreated());
			}
			Trx.get(trxName, false).commit();
		} finally {
			if (Trx.get(trxName, false) != null) {
				Trx.get(trxName, false).close();
			}
		}
	}

	protected void packIn(String trxName) {
		URL packout = context.getBundle().getEntry("/META-INF/2Pack.zip");
		if (packout != null && service != null) {
			FileOutputStream zipstream = null;
			try {
				// copy the resource to a temporary file to process it with 2pack
				InputStream stream = context.getBundle().getEntry("/META-INF/2Pack.zip").openStream();
				File zipfile = File.createTempFile(getName(), ".zip");
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
			}
			finally{
				if (zipstream != null) {
					try {
						zipstream.close();
					} catch (Exception e2) {}
				}
			}
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

	protected void install() {
	};

	protected void start() {
	};

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
						Thread.currentThread().setContextClassLoader(AdempiereActivator.class.getClassLoader());
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
							Thread.currentThread().setContextClassLoader(AdempiereActivator.class.getClassLoader());
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
