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

import java.sql.Timestamp;

import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.panel.ADForm;
import org.compiere.model.IMFAMechanism;
import org.compiere.model.MMFAMethod;
import org.compiere.model.MMFARegistration;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Html;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;

/**
 *	IDEMPIERE-4782
 * 	@author Carlos Ruiz - globalqss - BX Service
 */
public class MFARegisterForm extends ADForm {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6186035815377577281L;

	/* A label to show the messages to user */
	private Html msgInstructions;

	/* A label to show the additional messages to user */
	private Html msgAdditional;

	/* A box to receive the validation code */
	private Label codeLabel;
	private Textbox codeBox;

	/* A box to receive optionally a name */
	private Label nameLabel;
	private Textbox nameBox;

	/* A checkbox to set registration as preferred */
	private Checkbox prefBox;

	/* The confirm panel to close the window */
	private ConfirmPanel confirmPanel;

	/* The process instance opening this form */
	@SuppressWarnings("unused")
	private int pInstanceId;

	private MMFARegistration registration = null;

	/**
	 *
	 */
	public MFARegisterForm() {
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
		row = rows.newRow();
		msgInstructions = new Html();
		row.appendCellChild(msgInstructions, 4);
		msgInstructions.setHflex("1");

		row = rows.newRow();
		msgAdditional = new Html();
		row.appendCellChild(msgAdditional, 4);
		msgAdditional.setHflex("1");

		row = rows.newRow();
		codeLabel = new Label(Msg.getElement(Env.getCtx(), "MFAValidationCode"));
		row.appendCellChild(codeLabel, 2);
		codeBox = new Textbox();
		row.appendCellChild(codeBox, 2);

		row = rows.newRow();
		nameLabel = new Label(Msg.getElement(Env.getCtx(), "Name"));
		row.appendCellChild(nameLabel, 2);
		nameBox = new Textbox();
		row.appendCellChild(nameBox, 2);

		row = rows.newRow();
		row.appendCellChild(new Separator(), 2);
		prefBox = new Checkbox();
		prefBox.setLabel(Msg.getElement(Env.getCtx(), "IsUserMFAPreferred"));
		row.appendCellChild(prefBox, 2);

		row = rows.newRow();
		confirmPanel = new ConfirmPanel(true);
		row.appendCellChild(new Space());
		row.appendCellChild(confirmPanel, 3);
		confirmPanel.addActionListener(Events.ON_CLICK, evt -> onConfirmPanelAction(evt));

		//setHeight("600px");
		setHeight(null);
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
	 * Confirm panel to process OK/Cancel buttons
	 * @param evt
	 */
	private void onConfirmPanelAction(Event evt) {
		if (evt.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL)) {
			this.detach();
		} else if (evt.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			if (codeBox.isDisabled())
				this.detach();

			if (Util.isEmpty(codeBox.getValue()))
				throw new WrongValueException(codeBox, Msg.getMsg(Env.getCtx(), "MFACodeRequired"));

			Timestamp now = new Timestamp(System.currentTimeMillis());
			if (registration.getExpiration() != null && now.after(registration.getExpiration()))
				throw new WrongValueException(codeBox, Msg.getMsg(Env.getCtx(), "MFARegistrationExpired"));

			MMFAMethod method = new MMFAMethod(Env.getCtx(), registration.getMFA_Method_ID(), registration.get_TrxName());
			IMFAMechanism mechanism = method.getMFAMechanism();

			String msg;
			try {
				msg = mechanism.complete(Env.getCtx(), registration, codeBox.getValue(), nameBox.getValue(), prefBox.isChecked(), registration.get_TrxName());
			} catch (Exception e) {
				String err;
				if (! Util.isEmpty(e.getLocalizedMessage()))
					err = e.getLocalizedMessage();
				else
					err = Msg.getMsg(Env.getCtx(), "Error") + " = " + e.toString();
				throw new WrongValueException(codeBox, err);
			}
			codeBox.setDisabled(true);
			nameBox.setDisabled(true);
			prefBox.setDisabled(true);
			msgInstructions.setContent(msg);
			msgAdditional.setContent(null);

			confirmPanel.getButton(ConfirmPanel.A_CANCEL).setDisabled(true);
			confirmPanel.getButton(ConfirmPanel.A_CANCEL).setVisible(false);
		}
	}

	/**
	 *
	 * @param retArray
	 * @param pInstanceId 
	 */
	public void completeRegistration(Object[] retArray, int pInstanceId) {
		this.pInstanceId = pInstanceId;

		String instructions = retArray[0].toString();
		StringBuilder additionalInstructions = new StringBuilder();
		for (int i = 1; i < retArray.length; i++) {
			if (retArray[i] instanceof String) {
				if (additionalInstructions.length() > 0)
					additionalInstructions.append("<br>");
				String reti = (String) retArray[i];
				if (reti.startsWith("data:image/png;base64,"))
					additionalInstructions.append("<img src=\"" + reti.toString() + "\" width=\"180\" height=\"180\"/>"); // show QR code
				else
					additionalInstructions.append(reti.toString());
			} else if (retArray[i] instanceof MMFARegistration) {
				registration = (MMFARegistration) retArray[i];
			}
		}
		msgInstructions.setContent(instructions);
		msgAdditional.setContent(additionalInstructions.toString());
		nameBox.setValue(registration.getName());
		registration.set_TrxName(null); // this is post-process, the transaction from the process was already closed
	}

}
