package org.adempiere.pipo.srv;

import java.io.File;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.base.IDictionaryService;
import org.adempiere.pipo2.PackIn;
import org.adempiere.pipo2.Zipper;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.osgi.framework.BundleContext;

public class PipoDictionaryService implements IDictionaryService {

	CLogger logger = CLogger.getCLogger(PipoDictionaryService.class.getName());

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
//			packIn.setPackageDirectory(getPackageDir());

			X_AD_Package_Imp_Proc adPackageImp = new X_AD_Package_Imp_Proc(Env.getCtx(),
					0, trxName);
			File zipFilepath = packageFile;
			if (logger.isLoggable(Level.INFO)) logger.info("zipFilepath->" + zipFilepath);
			String parentDir = Zipper.getParentDir(zipFilepath);
			File targetDir = new File(System.getProperty("java.io.tmpdir"));
			Zipper.unpackFile(zipFilepath, targetDir);

			String dict_file = targetDir + File.separator + parentDir + File.separator
					+ "dict" + File.separator + "PackOut.xml";
			
			packIn.setPackageDirectory(targetDir + File.separator + parentDir);

			if (logger.isLoggable(Level.INFO)) logger.info("dict file->" + dict_file);

			// call XML Handler
			String msg = packIn.importXML(dict_file, Env.getCtx(), trxName);
			adPackageImp.setName(packIn.getPackageName());
			adPackageImp.setDateProcessed(new Timestamp(System.currentTimeMillis()));
			adPackageImp.setP_Msg(msg);
			adPackageImp.setAD_Package_Source_Type("File");
			adPackageImp.saveEx();
			
			Trx.get(trxName, false).commit();
			if (logger.isLoggable(Level.INFO)) logger.info("commit " + trxName);
		} catch (Exception e) {
			logger.log(Level.SEVERE, "importXML:", e);
			throw e;
		} finally {
			Trx.get(trxName, false).close();
		}

	}

	/*
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
	}*/

}
