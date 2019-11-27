package org.adempiere.report.jasper;

import org.compiere.model.PrintInfo;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

public interface JRViewerProvider {

	public void openViewer(JasperPrint jasperPrint, String title, PrintInfo printInfo) throws JRException;
}
