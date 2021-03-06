/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Sponsor:                                                            *
 * - FH                                                                *
 * Contributors:                                                       *
 * - Carlos Ruiz                                                       *
 **********************************************************************/
package org.adempiere.webui.apps.form;

import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.panel.ADForm;
import org.compiere.model.MAuthorizationAccount;
import org.compiere.model.MPInstancePara;
import org.compiere.model.Query;
import org.compiere.model.X_AD_PInstance_Log;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.Timer;

/**
 *	IDEMPIERE-3101
 * 	@author Carlos Ruiz - globalqss
 */
public class AddAuthorizationForm extends ADForm {
	/**
	 * 
	 */
	private static final long serialVersionUID = -293618692686586645L;

	/* A label to show the title of the form */
	private Label labelTitle;

	/* A label to show the messages to user */
	private Label msgLabel;

	/* A box to receive the message from the popup window */
	private Textbox msgBox;

	/* The confirm panel to close the window */
	private ConfirmPanel confirmPanel;

	/* Timer to monitor the popup */
	private Timer timer;

	/* The process instance opening this form */
	private int pInstanceId;


	/**
	 *
	 */
	public AddAuthorizationForm() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.ADForm#initForm()
	 */
	@Override
	protected void initForm() {
		setClosable(true);
		setSizable(true);

		Grid grid = GridFactory.newGridLayout();
		grid.setHeight("100%");
		grid.setWidth("100%");
		appendChild(grid);
		Columns columns = new Columns();
		grid.appendChild(columns);
		Column column = new Column();
		column.setWidth("5%");
		columns.appendChild(column);
		column = new Column();
		column.setWidth("30%");
		columns.appendChild(column);
		column = new Column();
		column.setWidth("60%");
		columns.appendChild(column);
		column = new Column();
		column.setWidth("10%");
		columns.appendChild(column);

		Rows rows = new Rows();
		grid.appendChild(rows);
		Row row = rows.newRow();
		row.appendCellChild(new Separator(), 4);
		row = rows.newRow();
		labelTitle = new Label(Msg.getMsg(Env.getCtx(), "Authorization_Grant_Access"));
		labelTitle.setStyle("font-weight: 600");
		row.appendCellChild(labelTitle, 4);
		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);

		msgLabel = new Label(Msg.getMsg(Env.getCtx(), "Authorization_Message"));
		msgLabel.setMultiline(true);

		row = rows.newRow();
		row.appendCellChild(msgLabel, 4);
		row.getLastCell().setRowspan(7);
		msgLabel.setHflex("1");
		msgLabel.setHeight("150px");

		msgBox = new Textbox();
		msgBox.addEventListener(Events.ON_CHANGE, evt -> onMsgBoxChanged());
		msgBox.setVisible(false);

		row = rows.newRow();
		row.appendCellChild(msgBox);

		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);
		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);
		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);
		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);
		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);

		row = rows.newRow();
		confirmPanel = new ConfirmPanel(true);
		row.appendCellChild(new Space());
		row.appendCellChild(confirmPanel, 3);
		confirmPanel.addActionListener(Events.ON_CLICK, evt -> onConfirmPanelAction(evt));

		timer = new Timer();
		timer.setRepeats(true);
		timer.setDelay(100);
		timer.setRunning(false);
		appendChild(timer);

		setHeight("300px");
		setWidth("350px");
		setVflex("min");

	}

	/**
	 * Set Window Mode Highlighted
	 */
	@Override
	public Mode getWindowMode() {
		return Mode.HIGHLIGHTED;
	}

	/**
	 * React when the message box is filled
	 */
	private void onMsgBoxChanged()  {
		Clients.clearBusy();

		/* Obtain info from the process instance saved on the callback servlet */
		final String wherepip = "AD_PInstance_ID=? AND ParameterName=?";
		MPInstancePara pip = new Query(Env.getCtx(), MPInstancePara.Table_Name, wherepip, null)
				.setParameters(pInstanceId, "Auth_CallbackAnswer")
				.first();
		final String wherepil = "AD_PInstance_ID=? AND AD_Table_ID=?";
		X_AD_PInstance_Log pil = new Query(Env.getCtx(), X_AD_PInstance_Log.Table_Name, wherepil, null)
				.setParameters(pInstanceId, MAuthorizationAccount.Table_ID)
				.first();

		StringBuilder msg = new StringBuilder();
		if (   (pip != null && pip.getP_String() != null)
			|| (pil != null && pil.getP_Msg() != null)) {
			// the callback ran and wrote info, the message can be because the user closed the window, ignore it
		} else {
			if (msgBox.getText().startsWith("! "))
				msg.append(msgBox.getText().substring(2));
			else
				msg.append(msgBox.getText());
		}
		if (pip != null && pip.getP_String() != null)
			msg.append("\n\n").append(pip.getP_String());
		if (pil != null && pil.getP_Msg() != null)
			msg.append("\n\n").append(pil.getP_Msg());
		msgLabel.setText(msg.toString());

		labelTitle.setVisible(false);
		confirmPanel.getButton(ConfirmPanel.A_OK).setEnabled(false);
		confirmPanel.getButton(ConfirmPanel.A_OK).setVisible(false);
	}

	/**
	 * Confirm panel to process OK/Cancel buttons
	 * @param evt
	 */
	private void onConfirmPanelAction(Event evt) {
		if (evt.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL)) {
			this.detach();
		} else if (evt.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			confirmPanel.getButton(ConfirmPanel.A_OK).setEnabled(false);
			Clients.showBusy(null);
		}
	}

	/**
	 * Build popup and listener script
	 * @param authURL
	 * @param pInstanceId 
	 */
	public void buildClientPopupAndListener(String authURL, int pInstanceId) {
		this.pInstanceId = pInstanceId;
		
		StringBuilder authScript = new StringBuilder()
				.append("var x = window.outerWidth / 2 + window.screenX - (800 / 2);\n")
				.append("var y = window.outerHeight / 2 + window.screenY - (600 / 2);\n")
				.append("var authWindow = window.open('").append(authURL).append("','_blank','width=800, height=600, top='+y+', left='+x);\n")
				.append("var timer = zk.Widget.$('#").append(timer.getUuid()).append("');\n")
				.append("timer.windowRef = authWindow; timer.play();");
		// Note: the listener can be set to onBind instead of onClick to open the popup without user intervention,
		//       but in this case the browser popup restrictions apply.
		//       As most browser block popups by default I prefer to go the safest route using onClick
		confirmPanel.getButton(ConfirmPanel.A_OK).setWidgetListener("onClick", authScript.toString());

		String msgError = Msg.getMsg(Env.getCtx(), "Error");
		String msgFailure = Msg.getMsg(Env.getCtx(), "OAuthPopup_Failure");
		StringBuilder timerScript = new StringBuilder()
				.append("function sleep (time) {return new Promise((resolve) => setTimeout(resolve, time));}\n")
				.append("try {\n")
				.append("  var t = zk.Widget.$('#").append(msgBox.getUuid()).append("');\n")
				.append("  var authWindow = this.windowRef;\n")
				.append("  if (authWindow && authWindow.closed) {\n")
				.append("    t.setValue('! ").append(msgError).append(msgFailure).append("'); t.fireOnChange(); \n") // prefix "! " - see onMsgBoxChanged
				.append("    this.stop();\n")
				.append("    return;\n")
				.append("  }\n")
				.append("  if (authWindow && authWindow.location) {\n")
				.append("    if (authWindow.location.href.indexOf('/callback.jsp') >= 0) {\n")
				.append("      this.stop();\n")
				.append("      var url = new URL(authWindow.location.href);\n")
				.append("      var error = url.searchParams.get('error');\n")
				.append("      var msg = url.searchParams.get('msg');\n")
				.append("      if (error) {\n" )
				.append("        var msg = '").append(msgError).append("'+error;\n")
				.append("        t.setValue(msg, false); t.fireOnChange();\n")
				.append("      } else if (msg) {\n")
				.append("        t.setValue(msg, false); t.fireOnChange();\n")
				.append("      }\n")
				.append("      sleep(1500).then(() => {\n")
				.append("        authWindow.close();\n")
				.append("      });\n")
				.append("    }\n")
				.append("  } else {\n")
				.append("    t.setValue('! ").append(msgError).append(msgFailure).append("'); t.fireOnChange(); \n") // prefix "! " - see onMsgBoxChanged
				.append("    this.stop();\n")
				.append("  }\n")
				.append("} catch(err){}\n");
		timer.setWidgetListener("onTimer", timerScript.toString());
	}

}
