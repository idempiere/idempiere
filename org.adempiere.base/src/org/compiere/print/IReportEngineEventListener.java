package org.compiere.print;

public interface IReportEngineEventListener {

	/**
	 * @param event
	 */
	public void onPrintFormatChanged(ReportEngineEvent event);

	/**
	 * @param event
	 */
	public void onQueryChanged(ReportEngineEvent event);

	/**
	 * @param event
	 */
	public void onPageSetupChanged(ReportEngineEvent event);
}
