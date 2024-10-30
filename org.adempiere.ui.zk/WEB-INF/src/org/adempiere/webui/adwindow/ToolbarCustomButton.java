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
import org.compiere.model.MColumn;
import org.compiere.model.MToolBarButton;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Toolbarbutton;

/**
 * Model for AD_ToolBarButton with IsCustomization=Y
 * @author hengsin
 */
public class ToolbarCustomButton implements EventListener<Event>, Evaluatee { 

	/** Toolbarbutton instance **/
	private Toolbarbutton toolbarButton;
	/** AD_ToolBarButton.ActionClassName **/
	private String actionId;
	private int windowNo;
	private int tabNo = -1;
	/** model instance for AD_ToolBarButton **/
	private MToolBarButton mToolbarButton;

	/**
	 * @param mToolbarButton
	 * @param btn
	 * @param actionId
	 * @param windowNo
	 */
	public ToolbarCustomButton(MToolBarButton mToolbarButton, Toolbarbutton btn, String actionId, int windowNo) {
		this(mToolbarButton, btn, actionId, windowNo, -1);
	}
	
	/**
	 * @param mToolbarButton
	 * @param btn
	 * @param actionId
	 * @param windowNo
	 * @param tabNo
	 */
	public ToolbarCustomButton(MToolBarButton mToolbarButton, Toolbarbutton btn, String actionId, int windowNo, int tabNo) {
		toolbarButton = btn;
		this.actionId = actionId;
		this.windowNo = windowNo;
		this.tabNo = tabNo;
		this.mToolbarButton = mToolbarButton;
		
		toolbarButton.addEventListener(Events.ON_CLICK, this);
	}
	
	/**
	 * Call {@link IAction#execute(Object)}.
	 */
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
		{
	    	return adTabpanel.get_ValueAsString(variableName);
		}
	    else
	    {
	    	DefaultEvaluatee evaluatee = new DefaultEvaluatee(adTabpanel.getGridTab(), windowNo, tabNo, false, true);
	    	return evaluatee.get_ValueAsString(variableName);
	    }
	}
	
	/**
	 * Delegate to {@link #dynamicDisplay(boolean)}
	 */
	public void dynamicDisplay() {
		dynamicDisplay(false);
	}
	
	/**
	 * Dynamic update of button state.
	 * @param forceValidation if true, execute dynamic update event if button is in detached state
	 */
	public void dynamicDisplay(boolean forceValidation) {
		if (toolbarButton.getParent() == null && !forceValidation)
			return;
		
		String displayLogic = mToolbarButton.getDisplayLogic();
		if (displayLogic == null || displayLogic.trim().length() == 0)
			return;

		boolean visible = true;
		if (displayLogic.startsWith(MColumn.VIRTUAL_UI_COLUMN_PREFIX)) {
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

	/**
	 * Evaluate pressedLogic (if defined)
	 */
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

	/**
	 * Evaluate readOnlyLogic (if defined)
	 */
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

	/**
	 * Evaluate SQL or boolean logic expression.<br/>
	 * For SQL expression, return true if the SQL expression has result (it doesn't check the return value of the SQL statement).
	 * @param logic
	 * @param tabNo
	 * @return result of evaluation of logic
	 */
	private boolean validateLogic(String logic, int tabNo) {
		boolean isValid = false;

		if (logic.startsWith(MColumn.VIRTUAL_UI_COLUMN_PREFIX))
		{
			isValid = Evaluator.parseSQLLogic(logic, Env.getCtx(), windowNo, tabNo, "");
		}
		else
		{
			isValid = Evaluator.evaluateLogic(this, logic);
		}

		return isValid;
	}

	/**
	 * @return {@link Toolbarbutton}
	 */
	public Toolbarbutton getToolbarbutton() {
		return toolbarButton;
	}
}
