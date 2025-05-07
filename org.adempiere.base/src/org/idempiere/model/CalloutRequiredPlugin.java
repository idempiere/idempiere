package org.idempiere.model;

import java.util.Properties;

import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MRequiredPlugin;
import org.compiere.util.Util;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleContext;
import org.osgi.framework.FrameworkUtil;

public class CalloutRequiredPlugin extends CalloutEngine {

	/**
	 * @param ctx
	 * @param windowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @param oldValue
	 * @return
	 */
	public String validate(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		String msg = null;
		String pluginName = mTab.get_ValueAsString(MRequiredPlugin.COLUMNNAME_PluginName);
		if (isCalloutActive() || Util.isEmpty(pluginName))
			return "";

		// Validate the plugin already exists and warn the user if not
		String expectedState = mTab.get_ValueAsString(MRequiredPlugin.COLUMNNAME_PluginExpectedState);
		Bundle thisBundle = FrameworkUtil.getBundle(this.getClass());
		boolean found = false;
		String state = null;
		if (thisBundle != null) {
			BundleContext context = thisBundle.getBundleContext();
			if (context != null) {
				for (Bundle bundle : context.getBundles()) {
					if (bundle.getSymbolicName().equals(pluginName)) {
						found = true;
						if (!Util.isEmpty(expectedState)) {
							state = MRequiredPlugin.getBundleState(bundle);
							if (! expectedState.equals(state)) {
								msg = "RequiredPluginInDifferentState";
							}
						}
						break;
					}
				}
			}
		}
		if (! found) {
			msg = "RequiredPluginDoesNotExist";
		}
		return msg;
	}

}

