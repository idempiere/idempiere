package org.adempiere.testplugin;

import org.adempiere.base.Service;
import org.adempiere.plugin.utils.AdempiereActivator;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

public class Activator extends AdempiereActivator {

	@Override
	protected void start() {
		System.out.println("Testplugin starting...");
	}
	
	@Override
	protected void stop() {
		System.out.println("Testplugin stopping...");
	}
}
