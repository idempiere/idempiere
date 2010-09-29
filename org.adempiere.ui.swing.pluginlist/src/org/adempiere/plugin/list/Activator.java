package org.adempiere.plugin.list;

import org.adempiere.plugin.utils.AdempiereActivator;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

public class Activator extends AdempiereActivator implements BundleActivator {

	static private BundleContext ctx;

	@Override
	public void start() {
		ctx = getContext();
	}
	
	public static BundleContext getPluginContext() {
		return ctx;
	}
}
