package org.adempiere.report.jasper;

import java.util.List;

import org.compiere.model.PrintInfo;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

public interface JRViewerProviderList {

	public void openViewer(List<JasperPrint> jasperPrintList, String title, PrintInfo printInfo) throws JRException;

	default void openViewer(List<JasperPrint> jasperPrintList, String title) throws JRException {
		openViewer(jasperPrintList, title, null);
	}

}
