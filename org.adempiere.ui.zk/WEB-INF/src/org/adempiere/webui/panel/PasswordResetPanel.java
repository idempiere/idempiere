/******************************************************************************
 * This file is part of iDempiere ERP Open Source                             *
 * http://www.idempiere.org                                                   *
 *                                                                            *
 * Copyright (C) Contributors                                                 *
 *                                                                            *
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
package org.adempiere.webui.panel;

import java.util.Properties;

import org.adempiere.base.IPasswordResetService;
import org.adempiere.base.PasswordResetServiceFactory;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.LoginWindow;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zhtml.Div;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.AbstractComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.sys.ComponentCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Image;

/**
 * Code-based password reset panel (3 steps: identify, enter code, set new password).
 * <p>
 * In-page panel that replaces the login panel (styled like it). UI-only: all logic goes
 * through {@link IPasswordResetService} from {@link PasswordResetServiceFactory}.
 * Shown when email login is enabled.
 *
 * @author d-ruiz - IDEMPIERE-7060
 */
public class PasswordResetPanel extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1L;

	private static final int STEP_IDENTIFY = 1;
	private static final int STEP_CODE = 2;
	private static final int STEP_PASSWORD = 3;

	/** Number of digits in the reset code (matches the service) */
	private static final int OTP_LENGTH = 6;

	/** Client-side auto-advance for the OTP boxes (boxes are direct widget siblings) */
	private static final String OTP_KEYUP_JS =
			  "var inp=this.$n();"
			+ "if(inp){inp.value=inp.value.replace(/[^0-9]/g,'');}"
			+ "var kc=(event&&(event.keyCode||event.which))||0;"
			+ "var isDigit=(kc>=48&&kc<=57)||(kc>=96&&kc<=105);"
			+ "if(kc===8){ if((!inp||!inp.value||inp.value.length===0) && this.previousSibling){ this.previousSibling.focus(); } }"
			+ "else if(isDigit && inp&&inp.value&&inp.value.length>=1 && this.nextSibling){ this.nextSibling.focus(); }";

	private final LoginWindow wndLogin;
	private final Properties m_ctx;
	private final int clientId;
	private final String language;

	private int step = STEP_IDENTIFY;
	private String email;
	private String verifiedToken;

	private Label lblMessage;
	private Table bodyTable;

	private Textbox txtEmail;
	private Textbox[] otpBoxes;
	private Textbox txtNewPassword;
	private Textbox txtConfirmPassword;

	/**
	 * @param ctx context
	 * @param loginWindow parent login window
	 * @param email pre-filled email (may be empty)
	 * @param clientId tenant context (usually 0 at login)
	 * @param language AD_Language for the email template (may be null)
	 */
	public PasswordResetPanel(Properties ctx, LoginWindow loginWindow, String email, int clientId, String language)
	{
		this.m_ctx = ctx;
		this.wndLogin = loginWindow;
		this.email = email;
		this.clientId = clientId;
		this.language = language;

		this.setId("passwordResetPanel");
		this.setSclass("login-box");
		createUI();
		buildStep();
	}

	/**
	 * Layout the fixed parts (header, body table shell, footer) of the panel.
	 */
	private void createUI()
	{
		Div div = new Div();
		div.setSclass(ITheme.LOGIN_BOX_HEADER_CLASS);
		Label header = new Label(Msg.getMsg(m_ctx, "ForgotMyPassword"));
		header.setSclass(ITheme.LOGIN_BOX_HEADER_TXT_CLASS);
		div.appendChild(header);
		this.appendChild(div);

		bodyTable = new Table();
		bodyTable.setId("grdPasswordReset");
		bodyTable.setDynamicProperty("cellpadding", "0");
		bodyTable.setDynamicProperty("cellspacing", "5");
		bodyTable.setSclass(ITheme.LOGIN_BOX_BODY_CLASS);
		this.appendChild(bodyTable);

		lblMessage = new Label();
		lblMessage.setSclass("password-reset-message");

		div = new Div();
		div.setSclass(ITheme.LOGIN_BOX_FOOTER_CLASS);
		ConfirmPanel pnlButtons = new ConfirmPanel(true);
		pnlButtons.addActionListener(this);
		LayoutUtils.addSclass(ITheme.LOGIN_BOX_FOOTER_PANEL_CLASS, pnlButtons);
		ZKUpdateUtil.setWidth(pnlButtons, null);
		pnlButtons.getButton(ConfirmPanel.A_OK).setSclass(ITheme.LOGIN_BUTTON_CLASS);
		pnlButtons.getButton(ConfirmPanel.A_CANCEL).setSclass(ITheme.LOGIN_BUTTON_CLASS);
		div.appendChild(pnlButtons);
		this.appendChild(div);
	}

	/**
	 * Rebuild the body rows for the current step (keeps header/footer).
	 */
	private void buildStep()
	{
		bodyTable.getChildren().clear();

		// logo row
		Tr tr = new Tr();
		bodyTable.appendChild(tr);
		Td td = new Td();
		td.setSclass(ITheme.LOGIN_BOX_HEADER_LOGO_CLASS);
		td.setDynamicProperty("colspan", "2");
		tr.appendChild(td);
		Image image = new Image();
		image.setSrc(ThemeManager.getLargeLogo());
		td.appendChild(image);

		// message row
		tr = new Tr();
		bodyTable.appendChild(tr);
		td = new Td();
		td.setDynamicProperty("colspan", "2");
		td.appendChild(lblMessage);
		tr.appendChild(td);

		switch (step)
		{
			case STEP_IDENTIFY:
				lblMessage.setValue(Msg.getMsg(m_ctx, "PasswordResetEnterEmail"));
				txtEmail = new Textbox();
				txtEmail.setId("txtEmail");
				txtEmail.setCols(25);
				ZKUpdateUtil.setWidth(txtEmail, "220px");
				txtEmail.setClientAttribute("autocomplete", "email");
				if (!Util.isEmpty(email))
					txtEmail.setValue(email);
				addFieldRow(Msg.getMsg(m_ctx, "EMail"), txtEmail);
				focus(txtEmail);
				break;
			case STEP_CODE:
				lblMessage.setValue(Msg.getMsg(m_ctx, "PasswordResetEnterCode"));
				addOtpRow();
				if (otpBoxes.length > 0)
					Clients.response(new AuFocus(otpBoxes[0]));
				break;
			case STEP_PASSWORD:
				lblMessage.setValue(Msg.getMsg(m_ctx, "New Password"));
				txtNewPassword = newPasswordBox();
				txtConfirmPassword = newPasswordBox();
				addFieldRow(Msg.getMsg(m_ctx, "New Password"), txtNewPassword);
				addFieldRow(Msg.getMsg(m_ctx, "New Password Confirm"), txtConfirmPassword);
				focus(txtNewPassword);
				break;
			default:
				break;
		}
	}

	private Textbox newPasswordBox()
	{
		Textbox tb = new Textbox();
		tb.setType("password");
		tb.setCols(25);
		ZKUpdateUtil.setWidth(tb, "220px");
		tb.setClientAttribute("autocomplete", "new-password");
		return tb;
	}

	/**
	 * Append a login-styled label + field row to the body table.
	 */
	private void addFieldRow(String labelText, Textbox field)
	{
		Tr tr = new Tr();
		bodyTable.appendChild(tr);
		Td td = new Td();
		td.setSclass(ITheme.LOGIN_LABEL_CLASS);
		td.appendChild(new Label(labelText));
		tr.appendChild(td);
		td = new Td();
		td.setSclass(ITheme.LOGIN_FIELD_CLASS);
		td.appendChild(field);
		tr.appendChild(td);
	}

	/**
	 * Append the OTP boxes row (full width, outside a .login-field cell so they keep the
	 * square OTP styling instead of the 220px login-field width).
	 */
	private void addOtpRow()
	{
		otpBoxes = new Textbox[OTP_LENGTH];
		Div otpDiv = new Div();
		otpDiv.setSclass("otp-input");
		for (int i = 0; i < OTP_LENGTH; i++)
		{
			Textbox box = new Textbox();
			box.setMaxlength(1);
			box.setCols(1);
			box.setClientAttribute("inputmode", "numeric");
			box.setClientAttribute("autocomplete", i == 0 ? "one-time-code" : "off");
			box.setClientAttribute("aria-label", Msg.getElement(m_ctx, "OneTimeCode") + " " + (i + 1) + "/" + OTP_LENGTH);
			box.setClientAttribute("onfocus", "this.select()");
			box.setWidgetListener("onKeyUp", OTP_KEYUP_JS);
			box.addCallback(ComponentCtrl.AFTER_PAGE_DETACHED,
					t -> ((AbstractComponent) t).setWidgetListener("onKeyUp", null));
			otpBoxes[i] = box;
			otpDiv.appendChild(box);
		}
		Tr tr = new Tr();
		bodyTable.appendChild(tr);
		Td td = new Td();
		td.setDynamicProperty("colspan", "2");
		td.appendChild(otpDiv);
		tr.appendChild(td);
	}

	private void focus(Textbox tb)
	{
		Clients.response(new AuFocus(tb));
	}

	private void setMessage(String message)
	{
		lblMessage.setValue(message == null ? "" : message);
	}

	@Override
	public void onEvent(Event event)
	{
		if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
			validate();
		else if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			wndLogin.loginCancelled();
	}

	/**
	 * Handle OK / ENTER for the current step.
	 */
	public void validate()
	{
		Clients.clearBusy();
		IPasswordResetService service = PasswordResetServiceFactory.getService(clientId);
		if (service == null)
		{
			setMessage(Msg.getMsg(m_ctx, "Error"));
			return;
		}
		try
		{
			switch (step)
			{
				case STEP_IDENTIFY:
					doIdentify(service);
					break;
				case STEP_CODE:
					doVerify(service);
					break;
				case STEP_PASSWORD:
					doComplete(service);
					break;
				default:
					break;
			}
		}
		catch (Exception e)
		{
			setMessage(Util.cleanAmp(e.getLocalizedMessage()));
		}
	}

	private void doIdentify(IPasswordResetService service)
	{
		String value = txtEmail.getValue();
		if (Util.isEmpty(value, true))
		{
			setMessage(Msg.getMsg(m_ctx, "FillMandatory") + " " + Msg.getMsg(m_ctx, "EMail"));
			return;
		}
		email = value.trim();
		service.requestReset(email, clientId, language);
		// neutral: always advance regardless of whether the account exists
		step = STEP_CODE;
		buildStep();
		setMessage(Msg.getMsg(m_ctx, "PasswordResetCodeSent"));
	}

	private void doVerify(IPasswordResetService service)
	{
		StringBuilder sb = new StringBuilder();
		for (Textbox box : otpBoxes)
		{
			String v = box.getValue();
			if (v != null)
				sb.append(v.trim());
		}
		String code = sb.toString();
		if (code.length() < OTP_LENGTH)
		{
			setMessage(Msg.getMsg(m_ctx, "FillMandatory") + " " + Msg.getMsg(m_ctx, "Code"));
			return;
		}
		verifiedToken = service.verifyCode(email, code);
		step = STEP_PASSWORD;
		buildStep();
	}

	private void doComplete(IPasswordResetService service)
	{
		String newPassword = txtNewPassword.getValue();
		String confirm = txtConfirmPassword.getValue();
		if (Util.isEmpty(newPassword, false))
		{
			setMessage(Msg.getMsg(m_ctx, "FillMandatory") + " " + Msg.getMsg(m_ctx, "New Password"));
			return;
		}
		if (!newPassword.equals(confirm))
		{
			setMessage(Msg.getMsg(m_ctx, "PasswordNotMatch"));
			return;
		}
		service.completeReset(verifiedToken, newPassword);
		Dialog.info(0, "PasswordResetSuccess");
		wndLogin.loginCancelled();
	}
}
