package org.adempiere.plugin.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.adempiere.base.IDictionaryService;
import org.adempiere.base.Service;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

public class AdempiereActivator implements BundleActivator {

	protected final static Logger logger = Logger
			.getLogger(AdempiereActivator.class.getName());
	private BundleContext context;

	@Override
	public void start(BundleContext context) throws Exception {
		this.context = context;
		logger.info(getName() + " " + getVersion() + " starting...");
		installPackage();
		start();
		logger.info(getName() + " " + getVersion() + " ready.");
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
		String where = "Name=? AND PK_Version=?";
		Query q = new Query(Env.getCtx(), X_AD_Package_Imp.Table_Name,
				where.toString(), trxName);
		q.setParameters(new Object[] { getName(), getVersion() });
		X_AD_Package_Imp pkg = q.first();
		if (pkg == null) {
			packIn(trxName);
			install();
			logger.info(getName() + " " + getVersion() + " installed.");
		} else {
			logger.info(getName() + " " + getVersion() + " was installed: "
					+ pkg.getCreated());
		}
		Trx.get(trxName, false).commit();
	}

	protected void packIn(String trxName) {
		URL packout = context.getBundle().getEntry("/META-INF/2Pack.zip");
		if (packout != null) {
			IDictionaryService service = Service.locate(IDictionaryService.class);
			try {
				// copy the resource to a temporary file to process it with 2pack
				InputStream stream = context.getBundle().getEntry("/META-INF/2Pack.zip").openStream();
				File zipfile = File.createTempFile(getName(), ".zip");
				FileOutputStream zipstream = new FileOutputStream(zipfile);
			    byte[] buffer = new byte[1024];
			    int read;
			    while((read = stream.read(buffer)) != -1){
			    	zipstream.write(buffer, 0, read);
			    }
			    // call 2pack
				service.merge(context, zipfile);
			} catch (Exception e) {
				logger.log(Level.WARNING, "Error on Dictionary service", e);
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
		logger.info(context.getBundle().getSymbolicName() + " "
				+ context.getBundle().getHeaders().get("Bundle-Version")
				+ " stopped.");
	}

	protected void install() {
	};

	protected void start() {
	};

	protected void stop() {
	};
}
