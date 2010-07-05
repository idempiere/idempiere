package org.adempiere.pipo.srv;

import java.io.File;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.adempiere.base.IDictionaryService;
import org.adempiere.pipo.PackIn;
import org.adempiere.pipo.PackInHandler;
import org.compiere.Adempiere;
import org.compiere.util.DB;
import org.compiere.util.Trx;

public class PipoDictionaryService implements IDictionaryService {

	Logger logger = Logger.getLogger(PipoDictionaryService.class.getName());

	@Override
	public void merge(InputStream model) throws Exception {
		if (model == null) {
			logger.info("No PackIn Model found");
			return;
		}
		try {
			String trxName = Trx.createTrxName();
			logger.info("starting " + trxName);
			PackIn.m_UpdateMode = "true";
			if (DB.isOracle())
				PackIn.m_Database = "Oracle";
			else if (DB.isPostgreSQL())
				PackIn.m_Database = "PostgreSQL";
			PackIn.m_Package_Dir = getPackageDir();

			System.setProperty("javax.xml.parsers.SAXParserFactory",
					"org.apache.xerces.jaxp.SAXParserFactoryImpl");
			PackInHandler handler = new PackInHandler();
			handler.set_TrxName(trxName);
			handler.setCtx(null);
			PackIn packIn = new PackIn();
			handler.setProcess(packIn);
			SAXParserFactory factory = SAXParserFactory.newInstance();
			SAXParser parser = factory.newSAXParser();
			logger.info("Start Parser");
			parser.parse(model, handler);
			logger.info("End Parser");
			Trx.get(trxName, false).commit();
			logger.info("commit " + trxName);
		} catch (Exception e) {
			logger.log(Level.SEVERE, "importXML:", e);
			throw e;
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
