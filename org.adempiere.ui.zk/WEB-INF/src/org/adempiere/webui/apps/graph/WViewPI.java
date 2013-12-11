package org.adempiere.webui.apps.graph;

import org.adempiere.webui.panel.ADForm;

public class WViewPI extends ADForm {

	/**
	 *
	 */
	private static final long serialVersionUID = -755873621984745607L;

	@Override
	protected void initForm() {
		this.setSclass("window-view-pi");
		WPerformanceIndicator.Options options = new WPerformanceIndicator.Options();
		options.chartHeight = 180;
		options.chartWidth = 180;
		WPAPanel paPanel = WPAPanel.get(options);
		if (paPanel != null)
			appendChild(paPanel);
	}

}
