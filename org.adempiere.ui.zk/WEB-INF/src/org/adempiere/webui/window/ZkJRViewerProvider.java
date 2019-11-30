package org.adempiere.webui.window;

import java.util.List;

import org.adempiere.report.jasper.JRViewerProvider;
import org.adempiere.report.jasper.JRViewerProviderList;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.PrintInfo;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

public class ZkJRViewerProvider implements JRViewerProvider, JRViewerProviderList {

	public void openViewer(final JasperPrint jasperPrint, final String title, final PrintInfo printInfo)
			throws JRException {
		Runnable runnable = new Runnable() {

			@Override
			public void run() {
				Window viewer = new ZkJRViewer(jasperPrint, title, printInfo);

				viewer.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
				viewer.setAttribute(Window.INSERT_POSITION_KEY, Window.INSERT_NEXT);
				viewer.setAttribute(WindowContainer.DEFER_SET_SELECTED_TAB, Boolean.TRUE);
				SessionManager.getAppDesktop().showWindow(viewer);
			}
		};
		AEnv.executeAsyncDesktopTask(runnable);
	}

	public void openViewer(final List<JasperPrint> jasperPrintList, final String title , final PrintInfo printInfo)
			throws JRException {
		Runnable runnable = new Runnable() {

			@Override
			public void run() {
				Window viewer = new ZkJRViewer(jasperPrintList, title, printInfo);

				viewer.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
				viewer.setAttribute(Window.INSERT_POSITION_KEY, Window.INSERT_NEXT);
				viewer.setAttribute(WindowContainer.DEFER_SET_SELECTED_TAB, Boolean.TRUE);
				SessionManager.getAppDesktop().showWindow(viewer);
			}
		};
		AEnv.executeAsyncDesktopTask(runnable);
	}

}
