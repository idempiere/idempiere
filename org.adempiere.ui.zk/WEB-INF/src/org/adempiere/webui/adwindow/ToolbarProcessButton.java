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
import org.compiere.model.MColumn;
import org.compiere.model.MProcess;
import org.compiere.model.MToolBarButton;
import org.compiere.model.MUserDefProc;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Button;

/**
 * Model for AD_ToolBarButton with AD_Process_ID > 0
 * @author hengsin
 */
public class ToolbarProcessButton implements IProcessButton, Evaluatee {

	/** model instance for AD_ToolBarButton **/
	private MToolBarButton mToolbarButton;
	/** {@link IADTabpanel} that own this ToolbarProcessButton instance **/
	private IADTabpanel adTabpanel;
	/** translated process name **/
	private String name;
	/** translated process description **/
	private String description;
	/** ActionListener for button **/
	private ActionListener actionListener;
	/** Button instance **/
	private Button button;
	private int windowNo;

	/**
	 * @param mToolbarButton
	 * @param adTabpanel
	 * @param listener
	 * @param windowNo
	 */
	public ToolbarProcessButton(MToolBarButton mToolbarButton, IADTabpanel adTabpanel, ActionListener listener, int windowNo) {
		this.mToolbarButton = mToolbarButton;
		this.adTabpanel = adTabpanel;
		this.actionListener = listener;
		this.windowNo = windowNo;
		MProcess process = MProcess.get(Env.getCtx(), getProcess_ID());
		name = process.get_Translation(I_AD_Process.COLUMNNAME_Name);
		description = process.get_Translation(I_AD_Process.COLUMNNAME_Description);

		MUserDefProc userDef = MUserDefProc.getBestMatch(Env.getCtx(), process.getAD_Process_ID());
		if (userDef != null) {
			if (userDef.getName() != null)
				name = userDef.getName();
			if (userDef.getDescription() != null)
				description = userDef.getDescription();
		}

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

	/**
	 * @return {@link Button}
	 */
	public Button getButton() {
		return button;
	}
	
	/**
	 * Dynamic update of button state.
	 */
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
	 * Evaluate readOnlyLogic (if defined)
	 */
	public void readOnlyLogic() {

		String readOnlyLogic = mToolbarButton.getReadOnlyLogic();
		if (readOnlyLogic == null || readOnlyLogic.trim().length() == 0)
			return;

		boolean disabled = validateLogic(readOnlyLogic, adTabpanel.getTabNo());
		button.setDisabled(disabled);
	} // readOnlyLogic

	/**
	 * Evaluate pressedLogic (if defined)
	 */
	public void pressedLogic() {

		String pressedLogic = mToolbarButton.getPressedLogic();
		if (pressedLogic == null || pressedLogic.trim().length() == 0)
			return;

		boolean isPressed = validateLogic(pressedLogic, adTabpanel.getTabNo());
		button.setAttribute(ProcessButtonPopup.BUTTON_ATTRIBUTE_PRESSED, isPressed ? "Y" : "N");
	} // pressedLogic

	/**
	 * Evaluate SQL or boolean logic expression.<br/>
	 * For SQL expression, return true if the SQL expression has result (it doesn't check the return value of the SQL statement).
	 * @param logic SQL (@SQL=) or boolean expression
	 * @param tabNo
	 * @return result of evaluation of logic 
	 */
	private boolean validateLogic(String logic, int tabNo) {
		boolean isValid = false;
		if (logic.startsWith(MColumn.VIRTUAL_UI_COLUMN_PREFIX)) {
			isValid = Evaluator.parseSQLLogic(logic, Env.getCtx(), windowNo, tabNo, getColumnName());
		} else {
			isValid = Evaluator.evaluateLogic(this, logic);
		}

		return isValid;
	} // validateLogic
}
