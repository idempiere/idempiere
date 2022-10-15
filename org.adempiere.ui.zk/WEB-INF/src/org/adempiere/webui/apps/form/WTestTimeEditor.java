package org.adempiere.webui.apps.form;

import org.adempiere.webui.component.Label;
import org.adempiere.webui.editor.WTimeEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.ADForm;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Vbox;

@org.idempiere.ui.zk.annotation.Form
public class WTestTimeEditor extends ADForm implements EventListener<Event>, ValueChangeListener {
	private static final long serialVersionUID = -5661912464378243252L;

	private WTimeEditor fTimeBoxValueChange = new WTimeEditor();
	private WTimeEditor fTimeBoxEvent = new WTimeEditor();

	public WTestTimeEditor() {
		super();
	}

	@Override
	protected void initForm() {

		fTimeBoxValueChange.getComponent().setFormat("HH:mm");
		fTimeBoxValueChange.addValueChangeListener(this);
		fTimeBoxEvent.getComponent().setFormat("HH:mm");
		fTimeBoxEvent.getComponent().addEventListener(Events.ON_BLUR, this);

		Vbox vbox = new Vbox();
		Hlayout hl = new Hlayout();
		hl.setValign("middle");
		hl.appendChild(new Label("ValueChange"));
		hl.appendChild(fTimeBoxValueChange.getComponent());
		vbox.appendChild(hl);

		hl = new Hlayout();
		hl.setValign("middle");
		hl.appendChild(new Label("Event"));
		hl.appendChild(fTimeBoxEvent.getComponent());
		vbox.appendChild(hl);

		appendChild(vbox);

	}

	public void onEvent(Event event) throws Exception {
		System.out.println("Event " + event.getTarget() + " - " + fTimeBoxEvent.getValue());
	}

	@Override
	public void valueChange(ValueChangeEvent evt) {
		System.out.println("ValueChange" + evt.getSource() + " - " + evt.getOldValue() + " -> "+ evt.getNewValue());
	}

}
