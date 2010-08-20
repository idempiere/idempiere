package org.adempiere.pipo.srv;

import java.io.File;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.adempiere.base.IDictionaryService;
import org.compiere.Adempiere;
import org.compiere.model.I_AD_Package_Imp_Proc;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.osgi.framework.BundleContext;

public class PipoDictionaryService implements IDictionaryService {

	Logger logger = Logger.getLogger(PipoDictionaryService.class.getName());

	/** official packin process id **/
	private final static int PACKIN_PROCESS_ID = 50008;
	
	@Override
	public void merge(BundleContext context, File packageFile) throws Exception {
		if (packageFile == null || !packageFile.exists()) {
			logger.info("No PackIn Model found");
			return;
		}
		String trxName = Trx.createTrxName();
		try {
			MProcess process = new MProcess(Env.getCtx(), PACKIN_PROCESS_ID, trxName);
			X_AD_Package_Imp_Proc packageImp = new X_AD_Package_Imp_Proc(Env.getCtx(), 0, trxName);
			packageImp.setAD_Override_Dict(false);
			packageImp.setAD_Package_Dir(getPackageDir());
			packageImp.setAD_Package_Source(packageFile.getAbsolutePath());
			packageImp.setAD_Package_Source_Type(X_AD_Package_Imp_Proc.AD_PACKAGE_SOURCE_TYPE_File);
			packageImp.saveEx();
			int Record_ID = packageImp.getAD_Package_Imp_Proc_ID();
			MPInstance pInstance = new MPInstance(process, Record_ID);
			pInstance.saveEx();
			MPInstancePara para = new MPInstancePara(pInstance, 10);
			para.setParameter("Name", context.getBundle().getSymbolicName());
			para.saveEx();
			para = new MPInstancePara(pInstance, 20);
			para.setParameter("Version", (String) context.getBundle().getHeaders().get("Bundle-Version"));
			para.saveEx();
			ProcessInfo pi = new ProcessInfo (process.getName(), process.getAD_Process_ID(), I_AD_Package_Imp_Proc.Table_ID, Record_ID);
			pi.setAD_PInstance_ID(pInstance.getAD_PInstance_ID());
			process.processIt(pi, Trx.get(trxName, false));
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
