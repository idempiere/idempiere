package org.adempiere.webui.window;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.compiere.report.JRViewerProvider;

public class ZkJRViewerProvider implements JRViewerProvider {

	public void openViewer(final JasperPrint jasperPrint, final String title)
			throws JRException {
		Runnable runnable = new Runnable() {
			
			@Override
			public void run() {
				Window viewer = new ZkJRViewer(jasperPrint, title);
				
				viewer.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
				viewer.setAttribute(Window.INSERT_POSITION_KEY, Window.INSERT_NEXT);
				SessionManager.getAppDesktop().showWindow(viewer);
			}
		};
		AEnv.executeAsyncDesktopTask(runnable);
	}

}
