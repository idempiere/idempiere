/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.LoginWindow;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.zkoss.zhtml.Div;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Image;

/**
 * Change Password Panel
 * @author Elaine
 * @date August 30, 2012
 */
public class ChangePasswordPanel extends Window implements EventListener<Event>
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 6055606520280550335L;

	private static CLogger logger = CLogger.getCLogger(ChangePasswordPanel.class);

    private LoginWindow wndLogin;

    /** Context					*/
    private Properties      m_ctx;
    /** Username					*/
    private String			m_userName;
    /** Password					*/
    private String			m_userPassword;
    private KeyNamePair[]	m_clientKNPairs;

	private boolean m_show = true;
	
    private Label lblOldPassword;
    private Label lblNewPassword;
    private Label lblRetypeNewPassword;
    private Label lblSecurityQuestion;
    private Label lblAnswer;
    private Combobox lstSecurityQuestion;
    private Textbox txtOldPassword;
    private Textbox txtNewPassword;
    private Textbox txtRetypeNewPassword;
    private Textbox txtAnswer;

    public ChangePasswordPanel(Properties ctx, LoginWindow loginWindow, String userName, String userPassword, boolean show, KeyNamePair[] clientsKNPairs) 
    {
    	this.wndLogin = loginWindow;
    	m_ctx = ctx;
    	m_userName = userName;
    	m_userPassword = userPassword;
    	m_show = show;
        m_clientKNPairs = clientsKNPairs;
    	
        initComponents();
        init();
        this.setId("changePasswordPanel");
    }

    private void init()
    {
    	Div div = new Div();
    	div.setSclass(ITheme.LOGIN_BOX_HEADER_CLASS);
    	Label label = new Label(Msg.getMsg(m_ctx, "ChangePassword"));
    	label.setSclass(ITheme.LOGIN_BOX_HEADER_TXT_CLASS);
    	div.appendChild(label);
    	this.appendChild(div);

    	Table table = new Table();
    	table.setId("grdChangePassword");
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
        tr.setId("rowOldPassword");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblOldPassword);
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(txtOldPassword);

    	tr = new Tr();
        tr.setId("rowNewPassword");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblNewPassword);
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(txtNewPassword);

    	tr = new Tr();
        tr.setId("rowRetypeNewPassword");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblRetypeNewPassword);
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(txtRetypeNewPassword);
    	
    	tr = new Tr();
        tr.setId("rowSecurityQuestion");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblSecurityQuestion);
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(lstSecurityQuestion);

    	tr = new Tr();
        tr.setId("rowAnswer");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblAnswer);
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(txtAnswer);

    	div = new Div();
    	div.setSclass(ITheme.LOGIN_BOX_FOOTER_CLASS);
        ConfirmPanel pnlButtons = new ConfirmPanel(true);
        pnlButtons.addActionListener(this);
        LayoutUtils.addSclass(ITheme.LOGIN_BOX_FOOTER_PANEL_CLASS, pnlButtons);
        pnlButtons.setWidth(null);
        pnlButtons.getButton(ConfirmPanel.A_OK).setSclass(ITheme.LOGIN_BUTTON_CLASS);
        pnlButtons.getButton(ConfirmPanel.A_CANCEL).setSclass(ITheme.LOGIN_BUTTON_CLASS);
        div.appendChild(pnlButtons);
        this.appendChild(div);
    }

    private void initComponents()
    {
    	lblOldPassword = new Label();
    	lblOldPassword.setId("lblOldPassword");
    	lblOldPassword.setValue(Msg.getMsg(m_ctx, "Old Password"));

        lblNewPassword = new Label();
        lblNewPassword.setId("lblNewPassword");
        lblNewPassword.setValue(Msg.getMsg(m_ctx, "New Password"));
        
        lblRetypeNewPassword = new Label();
        lblRetypeNewPassword.setId("lblRetypeNewPassword");
        lblRetypeNewPassword.setValue(Msg.getMsg(m_ctx, "New Password Confirm"));
        
        lblSecurityQuestion = new Label();
    	lblSecurityQuestion.setId("lblSecurityQuestion");
    	lblSecurityQuestion.setValue(Msg.getMsg(m_ctx, "SecurityQuestion"));

    	lblAnswer = new Label();
    	lblAnswer.setId("lblAnswer");
    	lblAnswer.setValue(Msg.getMsg(m_ctx, "Answer"));

    	lstSecurityQuestion = new Combobox();
    	lstSecurityQuestion.setAutocomplete(true);
    	lstSecurityQuestion.setAutodrop(true);
    	lstSecurityQuestion.setId("lstSecurityQuestion");
    	lstSecurityQuestion.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + lstSecurityQuestion.getId());
    	lstSecurityQuestion.setWidth("220px");
    	
    	lstSecurityQuestion.getItems().clear();
    	for (int i = 1; i <= ResetPasswordPanel.NO_OF_SECURITY_QUESTION; i++)
    		lstSecurityQuestion.appendItem(Msg.getMsg(m_ctx, ResetPasswordPanel.SECURITY_QUESTION_PREFIX + i), ResetPasswordPanel.SECURITY_QUESTION_PREFIX + i);

        txtOldPassword = new Textbox();
        txtOldPassword.setId("txtOldPassword");
        txtOldPassword.setType("password");
        txtOldPassword.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + txtOldPassword.getId());
        txtOldPassword.setCols(25);
        txtOldPassword.setWidth("220px");

        txtNewPassword = new Textbox();
        txtNewPassword.setId("txtNewPassword");
        txtNewPassword.setType("password");
        txtNewPassword.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + txtNewPassword.getId());        
        txtNewPassword.setCols(25);
        txtNewPassword.setWidth("220px");
        
        txtRetypeNewPassword = new Textbox();
        txtRetypeNewPassword.setId("txtRetypeNewPassword");
        txtRetypeNewPassword.setType("password");
        txtRetypeNewPassword.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + txtNewPassword.getId());        
        txtRetypeNewPassword.setCols(25);
        txtRetypeNewPassword.setWidth("220px");
        
    	txtAnswer = new Textbox();
    	txtAnswer.setId("txtAnswer");
//        txtAnswer.setType("password");
        txtAnswer.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + txtAnswer.getId());
        txtAnswer.setCols(25);
        txtAnswer.setWidth("220px");
   }

    public void onEvent(Event event)
    {
        if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
        {
			validateChangePassword();
        }
        else if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
        {
        	SessionManager.logoutSession();
            wndLogin.loginCancelled();
        }
    }
    
    public void validateChangePassword()
    {
    	String oldPassword = txtOldPassword.getValue();
    	String newPassword = txtNewPassword.getValue();
    	String retypeNewPassword = txtRetypeNewPassword.getValue();
    	
    	String securityQuestion = null;
    	if (lstSecurityQuestion.getSelectedItem() != null)
    		securityQuestion = (String) lstSecurityQuestion.getSelectedItem().getLabel();
    	
    	String answer = txtAnswer.getValue();
    	
    	if (Util.isEmpty(oldPassword))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "OldPasswordMandatory"));
    	
    	if (Util.isEmpty(retypeNewPassword))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "NewPasswordConfirmMandatory"));

    	if (!newPassword.equals(retypeNewPassword))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "PasswordNotMatch"));

    	if (Util.isEmpty(securityQuestion))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "SecurityQuestionMandatory"));

    	if (Util.isEmpty(answer))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "AnswerMandatory"));

    	if (!oldPassword.equals(m_userPassword))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "OldPasswordNoMatch"));
    	
    	if (MSysConfig.getBooleanValue(MSysConfig.CHANGE_PASSWORD_MUST_DIFFER, true))
    	{
    		if (oldPassword.equals(newPassword))
        		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "NewPasswordMustDiffer"));
    	}

    	Trx trx = null;
    	try
    	{
        	String trxName = Trx.createTrxName("ChangePasswordTrx");
    		trx = Trx.get(trxName, true);
    		
	    	for (KeyNamePair clientKNPair : m_clientKNPairs)
	    	{	    		
	    		int clientId = clientKNPair.getKey();
	    		Env.setContext(m_ctx, "#AD_Client_ID", clientId);
	    		MUser user = MUser.get(m_ctx, m_userName);
	    		if (user == null)
	    		{
	    			trx.rollback();
	    			logger.severe("Could not find user '" + m_userName + "'");
	    			throw new AdempiereException("Could not find user");
	    		}

				user.set_ValueOfColumn("Password", newPassword); // will be hashed and validate on saveEx
	    		user.setIsExpired(false);
	    		user.setSecurityQuestion(securityQuestion);
	    		user.setAnswer(answer);    		
	    		user.saveEx(trx.getTrxName());
	    	}
	    	
	    	trx.commit();
    	}
    	catch (AdempiereException e)
    	{
    		if (trx != null)
    			trx.rollback();
    		throw e;
    	}
    	finally
    	{
    		if (trx != null)
    			trx.close();
    	}
    	
    	wndLogin.loginOk(m_userName, m_show, m_clientKNPairs);
    }
}
