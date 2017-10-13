package org.adempiere.report.jasper;

import java.util.List;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;

public interface JRViewerProviderList {

	public void openViewer(List<JasperPrint> jasperPrintList, String title) throws JRException;
}
