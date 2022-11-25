/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.adwindow;

import org.adempiere.webui.editor.IProcessButton;
import org.adempiere.webui.event.ActionEvent;
import org.adempiere.webui.event.ActionListener;
import org.compiere.model.I_AD_Process;
import org.compiere.model.MProcess;
import org.compiere.model.MToolBarButton;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Button;

/**
 * @author hengsin
 *
 */
public class ToolbarProcessButton implements IProcessButton, Evaluatee {

	private MToolBarButton mToolbarButton;
	private IADTabpanel adTabpanel;	
	private String name;
	private String description;
	private ActionListener actionListener;
	private Button button;
	private int windowNo;

	/**
	 * @param windowNo 
	 * 
	 */
	public ToolbarProcessButton(MToolBarButton mToolbarButton, IADTabpanel adTabpanel, ActionListener listener, int windowNo) {
		this.mToolbarButton = mToolbarButton;
		this.adTabpanel = adTabpanel;
		this.actionListener = listener;
		this.windowNo = windowNo;
		MProcess process = MProcess.get(Env.getCtx(), getProcess_ID());
		name = process.get_Translation(I_AD_Process.COLUMNNAME_Name);
		description = process.get_Translation(I_AD_Process.COLUMNNAME_Description);
		
		button = new Button();
    	button.setLabel(name);
    	if (description != null && description.trim().length() > 0)
    		button.setTooltiptext(description);
    	button.setAttribute("component.name", mToolbarButton.getComponentName());
    	button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (actionListener != null) {
					ActionEvent actionEvent = new ActionEvent(ToolbarProcessButton.this, getColumnName(), Events.ON_CLICK);
					actionListener.actionPerformed(actionEvent);
				}
			}
		});
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IProcessButton#getProcess_ID()
	 */
	@Override
	public int getProcess_ID() {
		return mToolbarButton.getAD_Process_ID();
	}
	
	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IProcessButton#getInfoWindow_ID()
	 */
	@Override
	public int getInfoWindow_ID() {
		return 0;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IProcessButton#getADTabpanel()
	 */
	@Override
	public IADTabpanel getADTabpanel() {
		return adTabpanel;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IProcessButton#getColumnName()
	 */
	@Override
	public String getColumnName() {
		return mToolbarButton.getComponentName();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IProcessButton#getDescription()
	 */
	@Override
	public String getDescription() {
		return description;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IProcessButton#getDisplay()
	 */
	@Override
	public String getDisplay() {
		return name;
	}

	public Button getButton() {
		return button;
	}
	
	public void dynamicDisplay() {
		String displayLogic = mToolbarButton.getDisplayLogic();
		if (displayLogic == null || displayLogic.trim().length() == 0)
			return;

		boolean visible = validateLogic(displayLogic, adTabpanel.getTabNo());
		button.setVisible(visible);
	}

	@Override
	public String get_ValueAsString(String variableName) {
		int tabNo = adTabpanel.getTabNo();
		if( tabNo == 0)
	    	return adTabpanel.get_ValueAsString(variableName);
	    else
	    	return Env.getContext (Env.getCtx(), windowNo, tabNo, variableName, false, true);
	}

	public void readOnlyLogic() {

		String readOnlyLogic = mToolbarButton.getReadOnlyLogic();
		if (readOnlyLogic == null || readOnlyLogic.trim().length() == 0)
			return;

		boolean disabled = validateLogic(readOnlyLogic, adTabpanel.getTabNo());
		button.setDisabled(disabled);
	} // readOnlyLogic

	public void pressedLogic() {

		String pressedLogic = mToolbarButton.getPressedLogic();
		if (pressedLogic == null || pressedLogic.trim().length() == 0)
			return;

		boolean isPressed = validateLogic(pressedLogic, adTabpanel.getTabNo());
		button.setAttribute(ProcessButtonPopup.BUTTON_ATTRIBUTE_PRESSED, isPressed ? "Y" : "N");
	} // pressedLogic

	private boolean validateLogic(String logic, int tabNo) {

		boolean isValid = false;
		if (logic.startsWith("@SQL=")) {
			isValid = Evaluator.parseSQLLogic(logic, Env.getCtx(), windowNo, tabNo, getColumnName());
		} else {
			isValid = Evaluator.evaluateLogic(this, logic);
		}

		return isValid;
	} // validateLogic
}
