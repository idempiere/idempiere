/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.webservices.resources;
import javax.servlet.ServletContextEvent;

import org.compiere.util.CLogger;
import org.eclipse.jetty.ee8.webapp.WebAppContext;
import org.eclipse.jetty.osgi.OSGiWebappConstants;
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
		if (event.getSource() != null && event.getSource() instanceof WebAppContext.Context context) {
			bundleContextObj = context.getAttribute(OSGiWebappConstants.OSGI_BUNDLECONTEXT);
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
