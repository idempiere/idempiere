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
 * Contributors:                                                       *
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/

package org.adempiere.webui.panel;

import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.util.Callback;
import org.adempiere.util.LogAuthFailure;
import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ComboItem;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.adempiere.webui.window.LoginWindow;
import org.compiere.model.MMFAMethod;
import org.compiere.model.MMFARegisteredDevice;
import org.compiere.model.MMFARegistration;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.zkoss.zhtml.Div;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Image;

public class ValidateMFAPanel extends Window implements EventListener<Event> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5521412080450156787L;

	private static final CLogger logger = CLogger.getCLogger(ValidateMFAPanel.class);

	private static final String ON_DEFER_LOGOUT = "onDeferLogout";

	protected LoginWindow wndLogin;
	protected Login login;
	private ValidateMFAPanel component;

	/** Context */
	protected Properties m_ctx;

	protected boolean m_show = true;

	protected Label lblMFAMechanism;
	protected Combobox lstMFAMechanism;
	protected Label lblMFAMsg;
	protected Label lblValidationCode;
	protected Textbox txtValidationCode;
	protected Checkbox chkSetPreferred;
	protected Checkbox chkRegisterDevice = null;

	private KeyNamePair m_orgKNPair;

	/* Push the first OK automatically - when the first record is TOTP */
	private boolean m_autoCall = false;

	private static LogAuthFailure logAuthFailure = new LogAuthFailure();

	/* Number of failures to calculate an incremental delay on every trial */
	private int failures = 0;

	public ValidateMFAPanel(Properties ctx, LoginWindow loginWindow, KeyNamePair orgKNPair) {
		this.wndLogin = loginWindow;
		m_ctx = ctx;
		this.m_orgKNPair = orgKNPair;
		this.component = this;

		String cookieName = Env.getAD_User_ID(m_ctx) + "|" + Env.getAD_Client_ID(m_ctx);
		String registerCookie = getCookie(cookieName);
		login = new Login(ctx);
		if (login.isMFARequired(registerCookie)) {
			initComponents();
			init();
			this.setId("validateMFAPanel");
			this.setSclass("login-box");

			AuFocus auf = new AuFocus(lstMFAMechanism);
			Clients.response(auf);

			if (m_autoCall) {
				validateMFAComplete(true);
			}

		} else {
			if (logger.isLoggable(Level.INFO)) logger.info("MFA not required");
			validateMFAComplete(false);
		}

	}

	private void init() {
		Div div = new Div();
		div.setSclass(ITheme.LOGIN_BOX_HEADER_CLASS);
		Label label = new Label(Msg.getMsg(m_ctx, "MFALoginValidationHeader"));
		label.setSclass(ITheme.LOGIN_BOX_HEADER_TXT_CLASS);
		div.appendChild(label);
		this.appendChild(div);

		Table table = new Table();
		table.setId("grdMFAValidate");
		table.setDynamicProperty("cellpadding", "0");
		table.setDynamicProperty("cellspacing", "5");
		table.setSclass(ITheme.LOGIN_BOX_BODY_CLASS);

		this.appendChild(table);

		Tr tr = new Tr();
		table.appendChild(tr);
		Td td = new Td();
		td.setSclass(ITheme.LOGIN_BOX_HEADER_LOGO_CLASS);
		tr.appendChild(td);
		td.setDynamicProperty("colspan", "2");
		Image image = new Image();
		image.setSrc(ThemeManager.getLargeLogo());
		td.appendChild(image);

		tr = new Tr();
		tr.setId("rowMFAMechanism");
		table.appendChild(tr);
		td = new Td();
		tr.appendChild(td);
		td.setSclass(ITheme.LOGIN_LABEL_CLASS);
		td.appendChild(lblMFAMechanism);
		td = new Td();
		td.setSclass(ITheme.LOGIN_FIELD_CLASS);
		tr.appendChild(td);
		td.appendChild(lstMFAMechanism);

		tr = new Tr();
		tr.setId("rowMFAMsg");
		table.appendChild(tr);
		td = new Td();
		tr.appendChild(td);
		td.setSclass(ITheme.LOGIN_LABEL_CLASS);
		td.appendChild(new Label(""));
		td = new Td();
		tr.appendChild(td);
		td.setSclass(ITheme.LOGIN_FIELD_CLASS);
		td.appendChild(lblMFAMsg);

		tr = new Tr();
		tr.setId("rowValidationCode");
		table.appendChild(tr);
		td = new Td();
		tr.appendChild(td);
		td.setSclass(ITheme.LOGIN_LABEL_CLASS);
		td.appendChild(lblValidationCode);
		td = new Td();
		td.setSclass(ITheme.LOGIN_FIELD_CLASS);
		tr.appendChild(td);
		td.appendChild(txtValidationCode);

		tr = new Tr();
		tr.setId("rowSetPreferred");
		table.appendChild(tr);
		td = new Td();
		tr.appendChild(td);
		td.setSclass(ITheme.LOGIN_LABEL_CLASS);
		td.appendChild(new Label(""));
		td = new Td();
		td.setSclass(ITheme.LOGIN_FIELD_CLASS);
		tr.appendChild(td);
		td.appendChild(chkSetPreferred);

		tr = new Tr();
		tr.setId("rowRegisterDevice");
		table.appendChild(tr);
		td = new Td();
		tr.appendChild(td);
		td.setSclass(ITheme.LOGIN_LABEL_CLASS);
		td.appendChild(new Label(""));
		td = new Td();
		td.setSclass(ITheme.LOGIN_FIELD_CLASS);
		tr.appendChild(td);
		td.appendChild(chkRegisterDevice);

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

	private void initComponents() {
		lblMFAMechanism = new Label();
		lblMFAMechanism.setId("lblMFAMechanism");
		lblMFAMechanism.setValue(Msg.getMsg(m_ctx, "MFALoginMechanism"));

		lblValidationCode = new Label();
		lblValidationCode.setId("lblValidationCode");
		lblValidationCode.setValue(Msg.getMsg(m_ctx, "MFALoginValidationCode"));

		lblMFAMsg = new Label();
		lblMFAMsg.setId("lblMFAMsg");
		lblMFAMsg.setValue(Msg.getMsg(m_ctx, "MFALoginMessage"));

		lstMFAMechanism = new Combobox();
		lstMFAMechanism.setAutocomplete(true);
		lstMFAMechanism.setAutodrop(true);
		lstMFAMechanism.setId("lstMFAMechanism");
		boolean first = true;
		for (MMFARegistration reg : MMFARegistration.getValidRegistrationsFromUser()) {
			MMFAMethod method = new MMFAMethod(m_ctx, reg.getMFA_Method_ID(), reg.get_TrxName());
			if (first) {
				first = false;
				if (MMFAMethod.METHOD_Time_BasedOne_TimePassword.equals(method.getMethod())) {
					m_autoCall = true;
				}
			}
			ComboItem ci = new ComboItem(reg.getName() + " - " + method.getMethod(), reg.getMFA_Registration_ID());
			String id = AdempiereIdGenerator.escapeId(ci.getLabel());
			if (lstMFAMechanism.getFellowIfAny(id) == null)
				ci.setId(id);
			lstMFAMechanism.appendChild(ci);
		}
		lstMFAMechanism.setSelectedIndex(0);
		ZKUpdateUtil.setWidth(lstMFAMechanism, "220px");

		chkSetPreferred = new Checkbox(Msg.getMsg(m_ctx, "MFALoginSetPreferred"));
		chkSetPreferred.setId("chkSetPreferred");
		boolean enablePreferred = (lstMFAMechanism.getChildren().size() > 1 && lstMFAMechanism.getSelectedIndex() > 0);
		chkSetPreferred.setVisible(enablePreferred);
		chkSetPreferred.setChecked(false);

		int daysExpire = MSysConfig.getIntValue(MSysConfig.MFA_REGISTERED_DEVICE_EXPIRATION_DAYS, 30, Env.getAD_Client_ID(m_ctx));
		chkRegisterDevice = new Checkbox(Msg.getMsg(m_ctx, "MFALoginRegisterDevice", new Object[] {daysExpire}));
		chkRegisterDevice.setId("chkRegisterDevice");
		boolean enableRegisterDevice = (daysExpire > 0);
		chkRegisterDevice.setVisible(enableRegisterDevice);
		chkRegisterDevice.setChecked(false);

		txtValidationCode = new Textbox();
		txtValidationCode.setId("txtValidationCode");
		txtValidationCode.setCols(25);
		ZKUpdateUtil.setWidth(txtValidationCode, "220px");
		txtValidationCode.setDisabled(true);
		this.addEventListener(ON_DEFER_LOGOUT, this);
	}

	public void onEvent(Event event) {
		if (event.getTarget().getId().equals(ConfirmPanel.A_OK)) {
			validateMFAComplete(true);
		} else if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL)) {
			SessionManager.logoutSession();
		} else if (ON_DEFER_LOGOUT.equals(event.getName())) {
			SessionManager.logoutSession();
		}
	}

	public void validateMFAComplete(boolean required) {
		Clients.clearBusy();

		int registrationId = 0;
		if (required) {
			registrationId = lstMFAMechanism.getSelectedItem().getValue();
			boolean enablePreferred = (lstMFAMechanism.getChildren().size() > 1 && lstMFAMechanism.getSelectedIndex() > 0);
			chkSetPreferred.setVisible(enablePreferred);
			MMFARegistration reg = new MMFARegistration(Env.getCtx(), registrationId, null);
			if (txtValidationCode.isDisabled()) {
				String msg = reg.generateValidationCode(reg);
				lblMFAMsg.setValue(msg);
				txtValidationCode.setDisabled(false);
				lstMFAMechanism.setDisabled(true);
				AuFocus auf = new AuFocus(txtValidationCode);
				Clients.response(auf);
				return;
			} else {
				if (Util.isEmpty(txtValidationCode.getText()) && lstMFAMechanism.getItemCount() > 1) {
					lblMFAMsg.setValue(Msg.getMsg(m_ctx, "MFALoginMessage"));
					txtValidationCode.setDisabled(true);
					lstMFAMechanism.setDisabled(false);
					AuFocus auf = new AuFocus(lstMFAMechanism);
					Clients.response(auf);
					return;
				} else {
					String msg = reg.validateCode(reg, txtValidationCode.getText(), chkSetPreferred.isChecked());
					if (msg != null) {

						String x_Forward_IP = Executions.getCurrent().getHeader("X-Forwarded-For");
						if (x_Forward_IP == null)
							x_Forward_IP = Executions.getCurrent().getRemoteAddr();
						MUser user = MUser.get(m_ctx);
						boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
						logAuthFailure.log(x_Forward_IP, "/webui", email_login ? user.getEMail() : user.getName(), msg);

						// Incremental delay to avoid brute-force attack on testing codes
						try {
							Thread.sleep(failures * 2000);
						} catch (InterruptedException e) {}
						failures++;
						AuFocus auf = new AuFocus(txtValidationCode);
						Clients.response(auf);
						throw new WrongValueException(txtValidationCode, msg);
					}
				}
			}
		}

		if (chkRegisterDevice != null && chkRegisterDevice.isChecked()) {
			String cookieName = Env.getAD_User_ID(m_ctx) + "|" + Env.getAD_Client_ID(m_ctx);
			// TODO: generate the random cookie if possible with some fingerprint of the device
			String cookieValue = UUID.randomUUID().toString();
			setCookie(cookieName, cookieValue);
			MMFARegisteredDevice rd = new MMFARegisteredDevice(m_ctx, 0, null);
			rd.setAD_User_ID(Env.getAD_User_ID(m_ctx));
			rd.setMFADeviceIdentifier(cookieValue);
			long daysExpire = MSysConfig.getIntValue(MSysConfig.MFA_REGISTERED_DEVICE_EXPIRATION_DAYS, 30, Env.getAD_Client_ID(m_ctx));
			rd.setExpiration(new Timestamp(System.currentTimeMillis() + (daysExpire * 86400000L)));
			// TODO: rd.setHelp -> add information about the browser, device and IP address (fingerprint)
			rd.saveEx();
		}

		Session currSess = Executions.getCurrent().getDesktop().getSession();
		HttpSession httpSess = (HttpSession) currSess.getNativeSession();
		int timeout = MSysConfig.getIntValue(MSysConfig.ZK_SESSION_TIMEOUT_IN_SECONDS, -2,
				Env.getAD_Client_ID(Env.getCtx()), Env.getAD_Org_ID(Env.getCtx()));
		if (timeout != -2) // default to -2 meaning not set
			httpSess.setMaxInactiveInterval(timeout);

		String msg = login.validateLogin(m_orgKNPair);
		if (!Util.isEmpty(msg)) {
			Env.getCtx().clear();
			FDialog.error(0, this, "Error", msg, new Callback<Integer>() {					
				@Override
				public void onCallback(Integer result) {
					Events.echoEvent(new Event(ON_DEFER_LOGOUT, component));
				}
			});
			return;
		}
		// See if a popup should encourage user to change its password
		if (!MUser.get(Env.getCtx()).isNoPasswordReset()) {
			int notifyDay = MSysConfig.getIntValue(MSysConfig.USER_LOCKING_PASSWORD_NOTIFY_DAY, 0);
			int pwdAgeDay = MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_PASSWORD_AGE_DAY, 0);
			if (notifyDay > 0 && pwdAgeDay > 0) {
				Timestamp limit = TimeUtil.addDays(MUser.get(Env.getCtx()).getDatePasswordChanged(), pwdAgeDay);
				Timestamp notifyAfter = TimeUtil.addDays(limit, -notifyDay);
				Timestamp now = TimeUtil.getDay(null);

				if (now.after(notifyAfter))
					FDialog.warn(0, null, "", Msg.getMsg(m_ctx, "YourPasswordWillExpireInDays",
							new Object[] { TimeUtil.getDaysBetween(now, limit) }));
			}
		}

		Env.setContext(m_ctx, "#MFA_Registration_ID", registrationId);
		wndLogin.loginCompleted();
	}

	/**
	 * Set a cookie
	 * @param name
	 * @param value
	 */
	public static void setCookie(String name, String value) {
		Cookie cookie = new Cookie(name, value);
		cookie.setSecure(true);
		((HttpServletResponse) Executions.getCurrent().getNativeResponse()).addCookie(cookie);
	}

	/**
	 * Get a cookie by name
	 * @param name
	 * @return
	 */
	public static String getCookie(String name) {
		Cookie[] cookies = ((HttpServletRequest) Executions.getCurrent().getNativeRequest()).getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(name)) {
					return cookie.getValue();
				}
			}
		}
		return null;
	}

}
