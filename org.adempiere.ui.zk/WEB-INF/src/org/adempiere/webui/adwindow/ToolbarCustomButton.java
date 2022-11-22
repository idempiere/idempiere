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

import org.adempiere.base.IServiceHolder;
import org.adempiere.webui.action.Actions;
import org.adempiere.webui.action.IAction;
import org.adempiere.webui.component.ToolBarButton;
import org.compiere.model.MToolBarButton;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Toolbarbutton;

public class ToolbarCustomButton implements EventListener<Event>, Evaluatee { 

	private Toolbarbutton toolbarButton;
	private String actionId;
	private int windowNo;
	private int tabNo = -1;
	private MToolBarButton mToolbarButton;

	public ToolbarCustomButton(MToolBarButton mToolbarButton, Toolbarbutton btn, String actionId, int windowNo) {
		this(mToolbarButton, btn, actionId, windowNo, -1);
	}
	
	public ToolbarCustomButton(MToolBarButton mToolbarButton, Toolbarbutton btn, String actionId, int windowNo, int tabNo) {
		toolbarButton = btn;
		this.actionId = actionId;
		this.windowNo = windowNo;
		this.tabNo = tabNo;
		this.mToolbarButton = mToolbarButton;
		
		toolbarButton.addEventListener(Events.ON_CLICK, this);
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		IServiceHolder<IAction> serviceHolder = Actions.getAction(actionId);
		if (serviceHolder != null) {
			IAction action = serviceHolder.getService();
			if (action != null) {
				action.execute(ADWindow.get(windowNo));
			}
		}
	}

	@Override
	public String get_ValueAsString(String variableName) {
		ADWindow adwindow = ADWindow.get(windowNo);
		if (adwindow == null) 
			return "";
		
		IADTabpanel adTabpanel = adwindow.getADWindowContent().getADTab().getSelectedTabpanel();
		if (adTabpanel == null)
			return "";
		
		int tabNo = this.tabNo >= 0 ? this.tabNo : adTabpanel.getTabNo();
		if( tabNo == 0)
	    	return adTabpanel.get_ValueAsString(variableName);
	    else
	    	return Env.getContext (Env.getCtx(), windowNo, tabNo, variableName, false, true);
	}
	
	public void dynamicDisplay() {
		dynamicDisplay(false);
	}
	
	public void dynamicDisplay(boolean forceValidation) {
		if (toolbarButton.getParent() == null && !forceValidation)
			return;
		
		String displayLogic = mToolbarButton.getDisplayLogic();
		if (displayLogic == null || displayLogic.trim().length() == 0)
			return;

		boolean visible = true;
		if (displayLogic.startsWith("@SQL=")) {
			ADWindow adwindow = ADWindow.get(windowNo);
			if (adwindow == null)
				return;
			
			IADTabpanel adTabpanel = adwindow.getADWindowContent().getADTab().getSelectedTabpanel();
			if (adTabpanel == null)
				return;
			
			visible = Evaluator.parseSQLLogic(displayLogic, Env.getCtx(), windowNo, adTabpanel.getTabNo(), mToolbarButton.getActionName());
		}else {
			visible = Evaluator.evaluateLogic(this, displayLogic);	
		}

		toolbarButton.setVisible(visible);
	}

	public void pressedLogic() {
		if (toolbarButton.getParent() == null)
			return;

		String pressedLogic = mToolbarButton.getPressedLogic();

		if (Util.isEmpty(pressedLogic, true))
			return;

		ADWindow window = ADWindow.get(windowNo);

		if (window == null)
			return;

		IADTabpanel adTabpanel = window.getADWindowContent().getADTab().getSelectedTabpanel();

		if (adTabpanel == null || adTabpanel.getRecord_ID() <= 0)
			return;

		boolean isPressed = validateLogic(pressedLogic, adTabpanel.getTabNo());
		((ToolBarButton) toolbarButton).setPressed(isPressed);
	}

	public void readOnlyLogic() {
		if (toolbarButton.getParent() == null)
			return;

		String readOnlyLogic = mToolbarButton.getReadOnlyLogic();

		if (Util.isEmpty(readOnlyLogic, true))
			return;

		ADWindow window = ADWindow.get(windowNo);

		if (window == null)
			return;

		IADTabpanel adTabpanel = window.getADWindowContent().getADTab().getSelectedTabpanel();

		if (adTabpanel == null || adTabpanel.getRecord_ID() <= 0)
			return;

		boolean isReadOnly = validateLogic(readOnlyLogic, adTabpanel.getTabNo());

		toolbarButton.setDisabled(isReadOnly);
	}

	private boolean validateLogic(String logic, int tabNo) {
		boolean isValid = false;

		if (logic.startsWith("@SQL="))
		{
			isValid = Evaluator.parseSQLLogic(logic, Env.getCtx(), windowNo, tabNo, "");
		}
		else
		{
			isValid = Evaluator.evaluateLogic(this, logic);
		}

		return isValid;
	}

	public Toolbarbutton getToolbarbutton() {
		return toolbarButton;
	}
}
