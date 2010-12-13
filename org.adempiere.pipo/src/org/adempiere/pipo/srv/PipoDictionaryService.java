package org.adempiere.pipo.srv;

import java.io.File;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.adempiere.base.IDictionaryService;
import org.adempiere.pipo2.PackIn;
import org.compiere.Adempiere;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.osgi.framework.BundleContext;

public class PipoDictionaryService implements IDictionaryService {

	Logger logger = Logger.getLogger(PipoDictionaryService.class.getName());

	@Override
	public void merge(BundleContext context, File packageFile) throws Exception {
		if (packageFile == null || !packageFile.exists()) {
			logger.info("No PackIn Model found");
			return;
		}
		String trxName = Trx.createTrxName();
		try {
			PackIn packIn = new PackIn();
			packIn.setPackageName(context.getBundle().getSymbolicName());
			packIn.setPackageVersion((String) context.getBundle().getHeaders().get("Bundle-Version"));
			packIn.setUpdateDictionary(false);
			packIn.setPackageDirectory(getPackageDir());
			packIn.importXML(packageFile.getAbsolutePath(), Env.getCtx(), trxName);
			Trx.get(trxName, false).commit();
			logger.info("commit " + trxName);
		} catch (Exception e) {
			logger.log(Level.SEVERE, "importXML:", e);
			throw e;
		} finally {
			Trx.get(trxName, false).close();
		}

	}

	private String getPackageDir() {

		// Create Target directory if required
		String packageDirectory = Adempiere.getAdempiereHome();
		String result = packageDirectory + File.separator
				+ "packages";
		File docDir = new File( result+File.separator+"doc");

		if (!docDir.exists()) {
			boolean success = docDir.mkdirs();
			if (!success) {
				logger.info("Target directory creation failed");
			}
		}
		return result;
	}

}
