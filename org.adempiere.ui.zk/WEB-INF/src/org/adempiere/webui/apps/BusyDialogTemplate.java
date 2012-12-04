package org.adempiere.webui.apps;

import org.adempiere.webui.component.Window;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

public class BusyDialogTemplate implements Runnable, EventListener<Event> {

	private static final String EVENT_NAME = "onRun";

	private Runnable runnable;

	private BusyDialog busyDialog;

	public BusyDialogTemplate(Runnable runnable) {
		this.runnable = runnable;
	}

	private void hideBusyDialog() {
		if (busyDialog != null)
		{
			busyDialog.dispose();
			busyDialog = null;
		}
	}

    private void showBusyDialog() {
		busyDialog = new BusyDialog();
		busyDialog.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showCenterScreen(busyDialog);
	}

	public void onEvent(Event event) throws Exception {
		try {
			if (event.getName().equals(EVENT_NAME)) {
				runnable.run();
			}
		} finally {
			hideBusyDialog();
		}
	}

	public void run() {
		showBusyDialog();

        busyDialog.addEventListener(EVENT_NAME, this);
        Events.echoEvent(EVENT_NAME, busyDialog, null);
	}
}
