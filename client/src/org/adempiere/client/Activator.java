package org.adempiere.client;

import org.compiere.util.CLogger;
import org.eclipse.core.runtime.Plugin;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.BundleException;

public class Activator extends Plugin {
	private static final String ADMEPIERE_PREFIX = "org.adempiere";
	private static CLogger log = CLogger.getCLogger(Activator.class);

	@Override
	public void start(BundleContext context) throws Exception {
		activateAll(context.getBundles());
	}

	private void activateAll(Bundle[] bundles) {
		for (Bundle bundle : bundles) {
			if (shouldStart(bundle))
				try {
					bundle.start();
					log.info("Started "+bundle.getSymbolicName());
				} catch (BundleException e) {
					log.warning("Could not start "+bundle.getSymbolicName());
				}
		}
	}

	private boolean shouldStart(Bundle bundle) {
		return bundle.getSymbolicName().startsWith(ADMEPIERE_PREFIX);
	}
}
