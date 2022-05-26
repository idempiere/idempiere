package org.cloudempiere.model;

import java.util.Properties;

import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessDrillRule;
import org.compiere.model.MReportView;

/**
 *
 * @author Igor Pojzl, Cloudempiere
 *
 */
public class CalloutProcessDrillRule extends CalloutEngine {

	/**
	 * Process Callout Setup
	 *  @param ctx context
	 *  @param WindowNo current Window No
	 *  @param mTab Grid Tab
	 *  @param mField Grid Field
	 *  @param value New Value
	 *  @return null or error message
	 */
	public String process (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer AD_Process_ID = (Integer)value;
		if (AD_Process_ID == null || AD_Process_ID.intValue() == 0)
			return "";

		MProcess process = MProcess.get(AD_Process_ID);

		if(process == null || process.getAD_ReportView_ID() <= 0)
			return "";

		MReportView reportView = MReportView.get(process.getAD_ReportView_ID());

		if(reportView == null || reportView.getAD_Table_ID() <= 0)
			return "";

		mTab.setValue(MProcessDrillRule.COLUMNNAME_AD_Table_ID, reportView.getAD_Table_ID());
		return "";
	}

}
