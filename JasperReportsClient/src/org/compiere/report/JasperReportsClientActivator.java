/**
 * 
 */
package org.compiere.report;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

/**
 * @author hengsin
 *
 */
public class JasperReportsClientActivator implements BundleActivator {

	/**
	 * default constructor 
	 */
	public JasperReportsClientActivator() {
		super();
	}

	@Override
	public void start(BundleContext arg0) throws Exception {
		ReportStarter.setReportViewerProvider(new SwingJRViewerProvider());
	}

	@Override
	public void stop(BundleContext arg0) throws Exception {
	}

}
