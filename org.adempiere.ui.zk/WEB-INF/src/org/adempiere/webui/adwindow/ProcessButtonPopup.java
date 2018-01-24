/**
 * 
 */
package org.adempiere.webui.adwindow;

import java.util.List;

import org.adempiere.util.Callback;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.editor.IProcessButton;
import org.adempiere.webui.editor.WButtonEditor;
import org.adempiere.webui.panel.WDocActionPanel;
import org.compiere.model.GridTab;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Button;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menu;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menuseparator;

/**
 * @author hengsin
 *
 */
public class ProcessButtonPopup extends Menupopup implements EventListener<Event> {
	
	private static final String DOCUMENT_ACTION_MENUITEM_ATTRIBUTE = "document-action-menuitem";
	private static final String DOC_ACTION_PANEL_ATTRIBUTE = "doc-action-panel";
	private static final String BUTTON_ATTRIBUTE = "button";
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 304878472233552113L;

	public void render(List<Button> buttons) {
		this.setSclass("z-menu-noimage");
		
		//process button
		Button docActionBtn = null;
		for(Button button : buttons) {
			if (button.getPage() != null) {
				button.detach();
			}
			if ("DocAction".equals(button.getId())) {
				docActionBtn = button;				
				continue;
			}			
			Menuitem mi = new Menuitem(button.getLabel());
			appendChild(mi);
			mi.setAttribute(BUTTON_ATTRIBUTE, button);
			mi.addEventListener(Events.ON_CLICK, this);
			if (button.isDisabled())
				mi.setDisabled(true);
		}
		
		//document actions
		if (docActionBtn != null) {
			IProcessButton processButton = (IProcessButton) docActionBtn.getAttribute(WButtonEditor.EDITOR_ATTRIBUTE);
			WDocActionPanel actionPanel = new WDocActionPanel(processButton.getADTabpanel().getGridTab());
			List<Listitem> actions = actionPanel.getDocActionItems();
			if (actions.size() > 0) {
				if (this.getChildren().size() > 0)
					appendChild(new Menuseparator());
				Menu menu = new Menu(Msg.getElement(Env.getCtx(), "DocAction"));
				appendChild(menu);
				Menupopup popup = new Menupopup();
				popup.setAttribute(BUTTON_ATTRIBUTE, docActionBtn);
				popup.setAttribute(DOC_ACTION_PANEL_ATTRIBUTE, actionPanel);
				popup.setSclass("z-menu-noimage");
				menu.appendChild(popup);
				menu.setSclass("z-menu-noimage");
				for(Listitem action : actions) {
					Menuitem mi = new Menuitem(action.getLabel());
					mi.setValue((String)action.getValue());
					mi.setSclass(DOCUMENT_ACTION_MENUITEM_ATTRIBUTE);
					mi.addEventListener(Events.ON_CLICK, this);
					popup.appendChild(mi);
				}
			}
		}
	}

	@Override
	public void onEvent(Event event) throws Exception {
		Menuitem mi = (Menuitem) event.getTarget();
		if (DOCUMENT_ACTION_MENUITEM_ATTRIBUTE.equals(mi.getSclass())) {
			final Button button = (Button) mi.getParent().getAttribute(BUTTON_ATTRIBUTE);
			WDocActionPanel panel = (WDocActionPanel) mi.getParent().getAttribute(DOC_ACTION_PANEL_ATTRIBUTE);
			panel.setSelectedItem(mi.getValue());
			panel.onOk(new Callback<Boolean>() {				
				@Override
				public void onCallback(Boolean result) {
					if (result) {
						IProcessButton pb = (IProcessButton) button.getAttribute(WButtonEditor.EDITOR_ATTRIBUTE);
						GridTab gridTab = pb.getADTabpanel().getGridTab();
						ADWindow adwindow = ADWindow.get(gridTab.getWindowNo());
						ADWindowContent windowContent = adwindow.getADWindowContent();
						windowContent.executeButtonProcess(pb, true, gridTab.getAD_Table_ID(), gridTab.getRecord_ID(), true);
					}
				}
			});
			
		} else {
			Button button = (Button) mi.getAttribute(BUTTON_ATTRIBUTE);
			Events.sendEvent(Events.ON_CLICK, button, null);
		}
	}
}