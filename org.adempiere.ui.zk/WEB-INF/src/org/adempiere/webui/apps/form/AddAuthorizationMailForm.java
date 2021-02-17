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
 **********************************************************************/
package org.adempiere.webui.apps.form;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.List;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MAuthorizationAccount;
import org.compiere.model.MAuthorizationCredential;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.Timer;

/**
 * @author hengsin
 *
 */
public class AddAuthorizationMailForm extends ADForm {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8872474736618627740L;

	private Combobox credentialCombo;
	private ConfirmPanel confirmPanel;
	private List<MAuthorizationCredential> credentialList;
	private Textbox tokenBox;

	private Timer timer;

	/**
	 * 
	 */
	public AddAuthorizationMailForm() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.ADForm#initForm()
	 */
	@Override
	protected void initForm() {
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
		Label label = new Label("Grant EMail access to this application from your account"); // TODO: translate
		label.setStyle("font-weight: 600");
		row.appendCellChild(new Space());
		row.appendCellChild(label, 2);
		row.appendCellChild(new Space());
		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);
		row = rows.newRow();
		row.appendCellChild(new Separator(), 4);
		row = rows.newRow();
		row.appendCellChild(new Space());
		label = new Label("Authorization Credential"); // TODO: translate, use element
		row.appendCellChild(label.rightAlign());
		credentialCombo = new Combobox();
		credentialCombo.setHflex("1");
		credentialCombo.addEventListener(Events.ON_SELECT, evt -> onCredentialComboSelectionChanged());
		row.appendCellChild(credentialCombo);
		row.appendCellChild(new Space());
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
		
		tokenBox = new Textbox();
		tokenBox.addEventListener(Events.ON_CHANGE, evt -> onTokenBoxChanged());
		appendChild(tokenBox);
		tokenBox.setVisible(false);
		
		timer = new Timer();		
		timer.setRepeats(true);
		timer.setDelay(100);		
		timer.setRunning(false);
		appendChild(timer);		
		
		setHeight("350px");
		setWidth("350px");
		setVflex("min");
	}

	/**
	 * Build a timer script to wait for answer from authorization URL
	 * @param credential
	 */
	private void buildTimerClientScript(MAuthorizationCredential credential) {
		StringBuilder timerScript = new StringBuilder();
		timerScript.append("try {\n")
		 .append("  var t = zk.Widget.$('#").append(tokenBox.getUuid()).append("');\n")
		 .append("  var authWindow = this.windowRef;console.log(this);\n")
		 .append("  if (authWindow && authWindow.closed) {\n")
		 .append("      t.setValue('error=Request Fail or Aborted by User'); t.fireOnChange(); \n") // TODO: translate
		 .append("      this.stop();\n")
		 .append("      return;\n")
		 .append("  }\n")
		 .append("  if (authWindow && authWindow.location) {\n")
		 .append("      if (authWindow.location.href.indexOf('").append(credential.getAuthorizationRedirectURL_Parsed(AEnv.getApplicationUrl())).append("') >= 0) {\n")
		 .append("           this.stop();\n")
		 .append("           var url = new URL(authWindow.location.href);\n")
		 .append("           var error=url.searchParams.get('error');\n")
		 .append("           var code=url.searchParams.get('code');\n")
		 .append("           if (error) {\n" )
		 .append("                var msg = 'error='+error;\n")
		 .append("                t.setValue(msg, false); t.fireOnChange(); ")
		 .append("           } else if (code) {\n")
		 .append("                t.setValue(code, false); t.fireOnChange(); ")
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

	/**
	 * Set Window Mode Highlighted
	 */
	@Override
	public Mode getWindowMode() {
		return Mode.HIGHLIGHTED;
	}
	
	private void onCredentialComboSelectionChanged() {
		int index = credentialCombo.getSelectedIndex();
		try {
			buildClientListener(index);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	private void onTokenBoxChanged() throws IOException, GeneralSecurityException {
		Trx trx = Trx.get(Trx.createTrxName(), true);
		trx.setDisplayName(getClass().getName() +"_processToken");
		try {
			trx.start();
			String code = tokenBox.getValue();
			tokenBox.setValue("");
			processToken(code, trx.getTrxName());
			trx.commit(true);;
		} catch (SQLException e) {
			trx.rollback();
			throw new RuntimeException(e);
		} finally {
			Clients.clearBusy();
			confirmPanel.getButton(ConfirmPanel.A_OK).setEnabled(true);
			trx.close();
		}
	}

	private void processToken(String code, String trxName) throws IOException, GeneralSecurityException {
		if (!Util.isEmpty(code)) {
			if (code.startsWith("error=")) {
				code = code.replace("error=", "");
				if (code.equals("access_denied"))
					FDialog.error(m_WindowNo, "Access Denied by User");
				else
					FDialog.error(m_WindowNo, code);
				return;
			}
			int index = credentialCombo.getSelectedIndex();
			MAuthorizationCredential credential = credentialList.get(index);
			credential.set_TrxName(trxName);
			String msg = credential.processToken(code, AEnv.getApplicationUrl());

			this.detach();
			
			FDialog.info(m_WindowNo, this, msg);
			return;
		}
		FDialog.error(m_WindowNo, "Request Fail or Aborted by User");
	}

	/**
	 * Populate the credential combobox
	 */
	private void populateCredential() {
		credentialList = MAuthorizationCredential.getCredentialsOfScope(MAuthorizationAccount.AD_AUTHORIZATIONSCOPE_EMail);
		for(MAuthorizationCredential credential : credentialList) {
			credentialCombo.appendItem(credential.getName());
		}
		if (!credentialList.isEmpty()) {
			credentialCombo.setSelectedIndex(0);
			try {
				buildClientListener(0);
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	}

	/**
	 * Build listener script
	 * @param index
	 */
	private void buildClientListener(int index) {
		MAuthorizationCredential credential = credentialList.get(index);
		String url = credential.getAuthorizationRedirectURL_Full(AEnv.getApplicationUrl(), MAuthorizationAccount.AD_AUTHORIZATIONSCOPE_EMail);

		StringBuilder authScript = new StringBuilder("var x = window.outerWidth / 2 + window.screenX - (800 / 2);\n" + 
			    "var y = window.outerHeight / 2 + window.screenY - (600 / 2);\n" + 
			    "var authWindow = window.open('" + url + "','_blank','width=800, height=600, top='+y+', left='+x);\n");		
		authScript.append("var timer = zk.Widget.$('#").append(timer.getUuid()).append("');console.log(timer);\n");
		authScript.append("timer.windowRef = authWindow; timer.play();");		
		confirmPanel.getButton(ConfirmPanel.A_OK).setWidgetListener("onClick", authScript.toString());
		
		buildTimerClientScript(credential);
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
	 * Trigger action when highlighted
	 */
	@Override
	public void doHighlighted() {
		super.doHighlighted();
		populateCredential();
	}

}
