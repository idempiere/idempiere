package org.compiere.install;

import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;

public class Application implements IApplication {

	public Object start(IApplicationContext arg0) throws Exception {
		Setup.main(new String[]{});
		return null;
	}

	public void stop() {
	}

}
