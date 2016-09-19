package org.adempiere.webui.apps.graph;

import org.adempiere.webui.panel.ADForm;
import org.compiere.model.MGoal;

public class WViewPI extends ADForm {

	/**
	 *
	 */
	private static final long serialVersionUID = -755873621984745607L;

	@Override
	protected void initForm() {
		this.setSclass("window-view-pi");
		WPerformanceIndicator.Options options = new WPerformanceIndicator.Options();
		
		WPAPanel paPanel = new WPAPanel();
		MGoal [] data = WPAPanel.loadGoal();
		if (data != null && data.length > 0){
			paPanel.setGoals (data, options);
			appendChild(paPanel);	
		}
		
	}
}
