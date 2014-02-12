package org.adempiere.window.payment.validator;

import org.adempiere.util.Callback;
import org.adempiere.webui.adwindow.validator.WindowValidator;
import org.adempiere.webui.adwindow.validator.WindowValidatorEvent;
import org.adempiere.webui.adwindow.validator.WindowValidatorEventType;
import org.adempiere.webui.window.FDialog;

public class PaymentWindowValidator implements WindowValidator {

	@Override
	public void onWindowEvent(WindowValidatorEvent event,
			Callback<Boolean> callback) {
		if (event.getName().equals(WindowValidatorEventType.BEFORE_PRINT.getName())) {
			FDialog.ask(event.getWindow().getADWindowContent().getWindowNo(), 
					event.getWindow().getComponent(), "Print ?", callback);
		} else {
			callback.onCallback(Boolean.TRUE);
		}
	}
}