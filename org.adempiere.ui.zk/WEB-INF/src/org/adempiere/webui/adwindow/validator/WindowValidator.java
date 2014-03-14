package org.adempiere.webui.adwindow.validator;

import org.adempiere.util.Callback;

public interface WindowValidator {
	public void onWindowEvent(WindowValidatorEvent event, Callback<Boolean> callback);
}
