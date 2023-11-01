/**
 * 
 */
package org.idempiere.webservices.helper.resoucelookup;
import javax.servlet.ServletContextEvent;

import org.compiere.util.CLogger;
import org.eclipse.jetty.osgi.boot.OSGiWebappConstants;
import org.eclipse.jetty.server.handler.ContextHandler;
import org.osgi.framework.BundleContext;
import org.osgi.framework.wiring.BundleWiring;

/**
 * @author hengsin
 * 
 *
 */
public class ContextLoaderListener extends
		org.springframework.web.context.ContextLoaderListener {

	private static final CLogger log = CLogger.getCLogger(ContextLoaderListener.class);
	/**
	 * 
	 */
	public ContextLoaderListener() {
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		Object bundleContextObj = null;
		if (event.getSource() != null && event.getSource() instanceof ContextHandler.StaticContext) {
			ContextHandler.StaticContext staticContext = (ContextHandler.StaticContext)event.getSource();
			bundleContextObj = staticContext.getAttribute(OSGiWebappConstants.OSGI_BUNDLECONTEXT);
		}

		// get ClassLoader of web app is loading		
		ClassLoader webappBundleCl = null;
		if (bundleContextObj != null && bundleContextObj instanceof BundleContext) {
			BundleContext webappBundleContext = (BundleContext)bundleContextObj;
			webappBundleCl = webappBundleContext.getBundle().adapt(BundleWiring.class).getClassLoader();
		}
		
		// set ClassLoader to load schema also
		if (webappBundleCl != null) {
			ClassLoader currentCl = Thread.currentThread().getContextClassLoader();
			try {
				Thread.currentThread().setContextClassLoader(webappBundleCl);
				super.contextInitialized(event); 
			} finally {
				Thread.currentThread().setContextClassLoader(currentCl); 
			}
		}else {
			log.warning("can't findout ClassLoader for web service:" + event.getServletContext().getContextPath());
		}

	}

}
