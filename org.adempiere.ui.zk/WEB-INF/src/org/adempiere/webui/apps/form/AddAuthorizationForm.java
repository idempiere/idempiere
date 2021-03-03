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
	private static final long serialVersionUID = 6584722624231384676L;

	private Textbox msgBox;

	private ConfirmPanel confirmPanel;

	private Timer timer;

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
		Label label = new Label(Msg.getMsg(Env.getCtx(), "Authorization_Grant_Access"));
		label.setStyle("font-weight: 600");
		row.appendCellChild(label, 4);
		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);

		msgBox = new Textbox();
		msgBox.setMultiline(true);
		msgBox.addEventListener(Events.ON_CHANGE, evt -> onTokenBoxChanged());
		msgBox.setVisible(false);

		row = rows.newRow();
		row.appendCellChild(msgBox, 4);
		row.getLastCell().setRowspan(3);
		msgBox.setHflex("1");
		msgBox.setHeight("60px");
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

		setHeight("250px");
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

	private void onTokenBoxChanged()  {
		Clients.clearBusy();
		msgBox.setVisible(true);
		msgBox.setReadonly(true);
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
	 * Build listener script
	 * @param authURL 
	 * @param redirectURL 
	 */
	public void buildClientListener(String authURL) {
		confirmPanel.getButton(ConfirmPanel.A_OK).setEnabled(false);
		Clients.showBusy(null);
		StringBuilder authScript = new StringBuilder("var x = window.outerWidth / 2 + window.screenX - (800 / 2);\n" + 
				"var y = window.outerHeight / 2 + window.screenY - (600 / 2);\n" + 
				"var authWindow = window.open('" + authURL + "','_blank','width=800, height=600, top='+y+', left='+x);\n");		
		authScript.append("var timer = zk.Widget.$('#").append(timer.getUuid()).append("');/*console.log(timer);*/\n");
		authScript.append("timer.windowRef = authWindow; timer.play();");		
		confirmPanel.getButton(ConfirmPanel.A_OK).setWidgetListener("onBind", authScript.toString());

		StringBuilder timerScript = new StringBuilder();
		timerScript.append("try {\n")
		 .append("  var t = zk.Widget.$('#").append(msgBox.getUuid()).append("');\n")
		 .append("  var authWindow = this.windowRef;console.log(this);\n")
		 .append("  if (authWindow && authWindow.closed) {\n")
		 .append("      t.setValue('error=Request Fail or Aborted by User'); t.fireOnChange(); \n")
		 .append("      this.stop();\n")
		 .append("      return;\n")
		 .append("  }\n")
		 .append("  if (authWindow && authWindow.location) {\n")
		 .append("      if (authWindow.location.href.indexOf('/callback.jsp') >= 0) {\n")
		 .append("           this.stop();\n")
		 .append("           var url = new URL(authWindow.location.href);\n")
		 .append("           var error=url.searchParams.get('error');\n")
		 .append("           var msg=url.searchParams.get('msg');\n")
		 .append("           if (error) {\n" )
		 .append("                var msg = 'error='+error;\n")
		 .append("                t.setValue(msg, false); t.fireOnChange(); ")
		 .append("           } else if (msg) {\n")
		 .append("                t.setValue(msg, false); t.fireOnChange(); ")
		 .append("           }\n")
		 .append("           authWindow.close();\n")
		 .append("      }\n")
		 .append("   }\n")								 
		 .append("   else {\n")
		 .append("      t.setValue('error=Request Fail or Aborted by User'); t.fireOnChange(); \n")
		 .append("      this.stop();\n")
		 .append("   }\n")
		 .append("} catch(err){}\n");
		timer.setWidgetListener("onTimer", timerScript.toString());

	}

}
