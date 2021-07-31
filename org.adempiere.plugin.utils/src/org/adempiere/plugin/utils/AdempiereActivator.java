package org.adempiere.plugin.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.util.ServerContext;
import org.compiere.Adempiere;
import org.compiere.model.MSession;
import org.compiere.model.Query;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkEvent;

public class AdempiereActivator extends AbstractActivator {

	protected final static CLogger logger = CLogger.getCLogger(AdempiereActivator.class.getName());

	public String getName() {
		return context.getBundle().getSymbolicName();
	}

	@Override
	public String getVersion() {
		return (String) context.getBundle().getHeaders().get("Bundle-Version");
	}

	public String getDescription() {
		return getName();
	}

	private void installPackage() {
			// e.g. 1.0.0.qualifier, check only the "1.0.0" part
			String version = getPKVersion();
			
			String where = "Name=? AND PK_Version LIKE ?";
			Query q = new Query(Env.getCtx(), X_AD_Package_Imp.Table_Name,
					where.toString(), null);
			q.setParameters(new Object[] { getName(), version + "%" });
			X_AD_Package_Imp pkg = q.first();
			if (pkg == null) {
				try {
					if (getDBLock()) {
						logger.log(Level.WARNING, "Installing " + getName() + " " + version + " ...");
						packIn();
						install();
						logger.log(Level.WARNING, getName() + " " + version + " installed.");
					} else {
						logger.log(Level.WARNING, "Could not acquire the DB lock to install:" + getName());
					}
				} catch (AdempiereSystemError e) {
					e.printStackTrace();
				} finally {
					releaseLock();
				}
			} else {
				if (logger.isLoggable(Level.INFO)) logger.info(getName() + " " + version + " was installed: "
						+ pkg.getCreated());
			}
	}
	
	private String getPKVersion() {
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
		return version;
	}

	protected void packIn() {
		URL packout = context.getBundle().getEntry("/META-INF/2Pack.zip");
		if (packout != null && service != null) {
			//Create Session to be able to create records in AD_ChangeLog
			MSession.get(Env.getCtx(), true);
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
				merge(zipfile, getPKVersion());
			} catch (Throwable e) {
				logger.log(Level.WARNING, "Pack in failed.", e);
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

	protected void install() {
	};

	protected void setupPackInContext() {
		Properties serverContext = new Properties();
		serverContext.setProperty(Env.AD_CLIENT_ID, "0");
		ServerContext.setCurrentInstance(serverContext);
	};
	
	@Override
	public void frameworkEvent(FrameworkEvent event) {
		if (event.getType() == FrameworkEvent.STARTLEVEL_CHANGED) {
			frameworkStarted();
		}		
	}

	protected void frameworkStarted() {
		if (service != null) {
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
		}
	}
}
