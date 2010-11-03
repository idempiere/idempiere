/**
 *
 */
package org.adempiere.base;

import org.adempiere.base.equinox.StackTraceCommand;
import org.eclipse.osgi.framework.console.CommandProvider;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

/**
 * @author hengsin
 *
 */
public class BaseActivator implements BundleActivator {

	/**
	 *
	 */
	public BaseActivator() {
		// TODO Auto-generated constructor stub
	}

	/* (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	@Override
	public void start(BundleContext context) throws Exception {
		context.registerService(CommandProvider.class.getName(), new StackTraceCommand(), null);
	}

	/* (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	@Override
	public void stop(BundleContext context) throws Exception {
	}

}
