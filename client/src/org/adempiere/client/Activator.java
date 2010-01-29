package org.adempiere.client;

import org.eclipse.core.runtime.Plugin;
import org.osgi.framework.BundleContext;

public class Activator extends Plugin {
	@Override
	public void start(BundleContext context) throws Exception {
		System.out.println("Starting client");
		org.compiere.AdempiereClient.main(new String[]{});
	}
}
