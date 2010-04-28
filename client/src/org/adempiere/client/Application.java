package org.adempiere.client;

import org.compiere.util.CLogger;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;

public class Application implements IApplication {
	private static CLogger log = CLogger.getCLogger(Application.class);

	public Object start(IApplicationContext ctx) throws Exception {
		log.info("Starting client");
		org.compiere.AdempiereClient.main(new String[]{});
		return IApplication.EXIT_OK;
	}

	public void stop() {
	}

}
