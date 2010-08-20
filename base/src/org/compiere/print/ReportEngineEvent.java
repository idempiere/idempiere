package org.compiere.print;

import java.util.EventObject;

public class ReportEngineEvent extends EventObject {

	/**
	 * generated serial version Id
	 */
	private static final long serialVersionUID = 5414130140480852195L;

	/**
	 * @param source
	 */
	public ReportEngineEvent(ReportEngine source) {
		super(source);
	}
	
	/**
	 * @return report engine
	 */
	public ReportEngine getReportEngine() {
		return (ReportEngine) getSource();
	}

}
