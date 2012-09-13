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

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.LoginWindow;
import org.compiere.model.MClient;
import org.compiere.model.MMailText;
import org.compiere.model.MPasswordRule;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.EMail;
import org.compiere.util.Env;
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
 * Reset Password Panel
 * @author Elaine
 * @date September 10, 2012
 */
public class ResetPasswordPanel extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -657724758165769510L;

	private static CLogger logger = CLogger.getCLogger(ResetPasswordPanel.class);
	
    private static final int MAX_RESET_PASSWORD_TRIES = 3;
    private static final String RESET_PASSWORD_MAIL_TEXT_NAME = "Reset Password";

    private LoginWindow wndLogin;

    /** Context					*/
    private Properties      m_ctx;
    /** Username				*/
    private String			m_userName;
    /** No Security Question	*/
    private boolean 		m_noSecurityQuestion;
    /** Tries Counter			*/
    private int				counter;
	
    private Label lblSecurityQuestion;
    private Label lblAnswer;
    private Label lblUserId;
    private Label lblEmail;
    private Textbox txtSecurityQuestion;
    private Textbox txtAnswer;
    private Textbox txtUserId;
    private Textbox txtEmail;
    
    public ResetPasswordPanel(Properties ctx, LoginWindow loginWindow, String userName, boolean noSecurityQuestion) 
    {
    	this.wndLogin = loginWindow;
    	m_ctx = ctx;
    	m_userName = userName;
    	m_noSecurityQuestion = noSecurityQuestion;
    	
        initComponents();
        init();
        this.setId("resetPasswordPanel");
        
        loadData();
    }

    private void init()
    {
    	Div div = new Div();
    	div.setSclass(ITheme.LOGIN_BOX_HEADER_CLASS);
    	Label label = new Label(Msg.getMsg(m_ctx, "ResetPassword"));
    	label.setSclass(ITheme.LOGIN_BOX_HEADER_TXT_CLASS);
    	div.appendChild(label);
    	this.appendChild(div);

    	Table table = new Table();
    	table.setId("grdResetPassword");
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

        if (m_noSecurityQuestion)
        {
        	tr = new Tr();
            tr.setId("rowUser");
            table.appendChild(tr);
        	td = new Td();
        	tr.appendChild(td);
        	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
        	td.appendChild(lblUserId);
        	td = new Td();
        	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
        	tr.appendChild(td);
        	td.appendChild(txtUserId);
        }
        else
        {
        	tr = new Tr();
	        tr.setId("rowEmail");
	        table.appendChild(tr);
	    	td = new Td();
	    	tr.appendChild(td);
	    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
	    	td.appendChild(lblEmail);
	    	td = new Td();
	    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
	    	tr.appendChild(td);
	    	td.appendChild(txtEmail);
	    	
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
	    	td.appendChild(txtSecurityQuestion);
	
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
        }

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
    	if (m_noSecurityQuestion)
        {
    		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
    		lblUserId = new Label();
            lblUserId.setId("lblUserId");
            lblUserId.setValue(email_login ? Msg.getMsg(m_ctx, "Name") : Msg.getMsg(m_ctx, "EMail"));
            
    		txtUserId = new Textbox();
            txtUserId.setId("txtUserId");
            txtUserId.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + txtUserId.getId());
            txtUserId.setCols(25);
            txtUserId.setMaxlength(40);
            txtUserId.setWidth("220px");
        }
    	else
    	{
    		lblEmail = new Label();
    		lblEmail.setId("lblEmail");
    		lblEmail.setValue(Msg.getMsg(m_ctx, "EMail"));
	    	
	    	lblSecurityQuestion = new Label();
	    	lblSecurityQuestion.setId("lblSecurityQuestion");
	    	lblSecurityQuestion.setValue(Msg.getMsg(m_ctx, "SecurityQuestion"));
	
	    	lblAnswer = new Label();
	    	lblAnswer.setId("lblAnswer");
	    	lblAnswer.setValue(Msg.getMsg(m_ctx, "Answer"));
	    	
	    	txtEmail = new Textbox();
	    	txtEmail.setId("txtEmail");
	    	txtEmail.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + txtEmail.getId());
	    	txtEmail.setCols(25);
	    	txtEmail.setWidth("220px");
	    	txtEmail.setReadonly(false);
	    	
	    	txtSecurityQuestion = new Textbox();
	    	txtSecurityQuestion.setId("txtSecurityQuestion");
	    	txtSecurityQuestion.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + txtSecurityQuestion.getId());
	    	txtSecurityQuestion.setCols(25);
	    	txtSecurityQuestion.setWidth("220px");
	    	txtSecurityQuestion.setReadonly(true);
	        
	    	txtAnswer = new Textbox();
	    	txtAnswer.setId("txtAnswer");
	//        txtAnswer.setType("password");
	        txtAnswer.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + txtAnswer.getId());
	        txtAnswer.setCols(25);
	        txtAnswer.setWidth("220px");
	        txtAnswer.setReadonly(true);
    	}
    }
    
    private void loadData()
    {
    	boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
    	if (email_login)
    	{
    		txtEmail.setText(m_userName);
        	loadSecurityQuestion();        	
    	}
    }
    
    private void loadSecurityQuestion()
    {
    	String email = txtEmail.getValue();
		if (Util.isEmpty(email))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "FillMandatory") + " " + lblEmail.getValue());
		
		// Assume user with same email uses the same password and security question
    	StringBuilder sql = new StringBuilder("SELECT SecurityQuestion ");
    	sql.append("FROM AD_User ");
    	sql.append("WHERE IsActive='Y' ");
    	sql.append("AND EMail=? ");
    	sql.append("AND SecurityQuestion IS NOT NULL ");
    	sql.append("ORDER BY AD_Client_ID DESC");
    	
    	String securityQuestion = DB.getSQLValueString(null, sql.toString(), email);
    	txtSecurityQuestion.setValue(securityQuestion);
    	
    	txtEmail.setReadonly(true);
    	txtAnswer.setReadonly(false);
    }

    public void onEvent(Event event)
    {
        if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
        {
        	if (txtAnswer != null && txtAnswer.isReadonly())
        		validateEmail();
        	else
        		validateResetPassword();
        }
        else if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
        {
        	SessionManager.logoutSession();
            wndLogin.loginCancelled();
        }
    }
    
    private void validateEmail()
    {
    	String email = txtEmail.getValue();
		if (Util.isEmpty(email))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "FillMandatory") + " " + lblEmail.getValue());
		
    	StringBuilder whereClause = new StringBuilder("Password IS NOT NULL ");
		whereClause.append("AND COALESCE(LDAPUser,Name)=? ");
    	whereClause.append("AND EMail=? ");
		whereClause.append(" AND")
				.append(" EXISTS (SELECT * FROM AD_User_Roles ur")
				.append("         INNER JOIN AD_Role r ON (ur.AD_Role_ID=r.AD_Role_ID)")
				.append("         WHERE ur.AD_User_ID=AD_User.AD_User_ID AND ur.IsActive='Y' AND r.IsActive='Y') AND ")
				.append(" EXISTS (SELECT * FROM AD_Client c")
				.append("         WHERE c.AD_Client_ID=AD_User.AD_Client_ID")
				.append("         AND c.IsActive='Y') AND ")
				.append(" AD_User.IsActive='Y'");
		
		List<MUser> users = new Query(m_ctx, MUser.Table_Name, whereClause.toString(), null)
			.setParameters(m_userName, email)
			.setOrderBy(MUser.COLUMNNAME_AD_User_ID)
			.list();
		
		if (users.size() == 0)
			throw new AdempiereException(Msg.getMsg(m_ctx, "InvalidUserNameAndEmail"));
		
		loadSecurityQuestion();
    }
    
    private void validateResetPassword()
    {
    	List<MUser> users = null;
    	if (m_noSecurityQuestion)
    	{
    		String userId = txtUserId.getValue();
    		if (Util.isEmpty(userId))
        		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "FillMandatory") + " " + lblUserId.getValue());
    		
	    	StringBuilder whereClause = new StringBuilder("Password IS NOT NULL ");
	    	boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
	    	if (email_login)
	    	{
				whereClause.append("AND EMail=? ");
				whereClause.append("AND COALESCE(LDAPUser,Name)=? ");
	    	}
	    	else
	    	{
				whereClause.append("AND COALESCE(LDAPUser,Name)=? ");
	    		whereClause.append("AND EMail=? ");
	    	}
			whereClause.append(" AND")
					.append(" EXISTS (SELECT * FROM AD_User_Roles ur")
					.append("         INNER JOIN AD_Role r ON (ur.AD_Role_ID=r.AD_Role_ID)")
					.append("         WHERE ur.AD_User_ID=AD_User.AD_User_ID AND ur.IsActive='Y' AND r.IsActive='Y') AND ")
					.append(" EXISTS (SELECT * FROM AD_Client c")
					.append("         WHERE c.AD_Client_ID=AD_User.AD_Client_ID")
					.append("         AND c.IsActive='Y') AND ")
					.append(" AD_User.IsActive='Y'");
			
			users = new Query(m_ctx, MUser.Table_Name, whereClause.toString(), null)
				.setParameters(m_userName, userId)
				.setOrderBy(MUser.COLUMNNAME_AD_User_ID)
				.list();
    	}
    	else
    	{
    		String email = txtEmail.getValue();
	    	String securityQuestion = txtSecurityQuestion.getValue();
	    	String answer = txtAnswer.getValue();
	    	
	    	if (Util.isEmpty(securityQuestion))
	    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "SecurityQuestionMandatory"));
	
	    	if (Util.isEmpty(answer))
	    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "AnswerMandatory"));
	    	
	    	StringBuilder whereClause = new StringBuilder("Password IS NOT NULL AND ");
			whereClause.append("EMail=?");
			whereClause.append(" AND")
					.append(" EXISTS (SELECT * FROM AD_User_Roles ur")
					.append("         INNER JOIN AD_Role r ON (ur.AD_Role_ID=r.AD_Role_ID)")
					.append("         WHERE ur.AD_User_ID=AD_User.AD_User_ID AND ur.IsActive='Y' AND r.IsActive='Y') AND ")
					.append(" EXISTS (SELECT * FROM AD_Client c")
					.append("         WHERE c.AD_Client_ID=AD_User.AD_Client_ID")
					.append("         AND c.IsActive='Y') AND ")
					.append(" AD_User.IsActive='Y'")
					.append(" AND AD_User.SecurityQuestion=?")
					.append(" AND AD_User.Answer=?");
			
			users = new Query(m_ctx, MUser.Table_Name, whereClause.toString(), null)
				.setParameters(email, securityQuestion, answer)
				.setOrderBy(MUser.COLUMNNAME_AD_User_ID)
				.list();
    	}
    	
		if (users.size() == 0)
		{
			String errMsg = m_noSecurityQuestion ? Msg.getMsg(m_ctx, "InvalidUserNameAndEmail") : Msg.getMsg(m_ctx, "InvalidSecurityQuestionAndAnswer");
			++counter;
			
			if (counter >= MAX_RESET_PASSWORD_TRIES)
			{
		    	counter = 0;
				SessionManager.logoutSession();
		    	wndLogin.loginCancelled();
			}			
			throw new AdempiereException(errMsg);
		}
		
		String newPassword;
		MPasswordRule pwdrule = MPasswordRule.getRules(Env.getCtx(), null);
		if (pwdrule != null) {
			newPassword = pwdrule.generate();
		} else {
			SecureRandom random = new SecureRandom();
			newPassword = BigInteger.probablePrime(50, random).toString(Character.MAX_RADIX);
		}
		
		String errorMsg = "";
		Trx trx = null;
    	try
    	{
        	String trxName = Trx.createTrxName("ResetPasswordTrx");
    		trx = Trx.get(trxName, true);
    		
			for (MUser user : users)
			{
				user.set_TrxName(trx.getTrxName());
				
				user.set_ValueOfColumn("Password", newPassword); // will be hashed and validate on saveEx
				user.setIsExpired(true);
				user.saveEx();

				if (sendEmail(user, newPassword))
		    		logger.fine(user.getEMail());
				else
				{
					if (errorMsg.length() > 0)
						errorMsg += ", ";
					errorMsg += user.getEMail();
					throw new AdempiereException(Msg.getMsg(m_ctx, "RequestActionEMailError") + ": " + user.getEMail());
				}
			}

	    	trx.commit();
    	}
    	catch (Exception e)
    	{
    		if (trx != null)
    			trx.rollback();
    	}
    	finally
    	{
    		if (trx != null)
    			trx.close();
    	}

    	if (errorMsg.length() > 0)
			throw new AdempiereException(Msg.getMsg(m_ctx, "RequestActionEMailError") + ": " + errorMsg);
    	else
    	{
        	SessionManager.logoutSession();
        	wndLogin.loginCancelled();
//    		FDialog.info(0, this, Msg.getMsg(m_ctx, "RequestActionEMailOK"));
    	}    	
    }
    
    private boolean sendEmail(MUser to, String newPassword)
    {
    	MClient client = MClient.get(m_ctx, to.getAD_Client_ID());
    	
    	StringBuilder sql = new StringBuilder("SELECT R_MailText_ID ");
    	sql.append("FROM R_MailText ");
    	sql.append("WHERE IsActive='Y' ");
    	sql.append("AND Name=? ");
    	sql.append("AND AD_Client_ID IN (?, 0) ");
    	sql.append("ORDER BY AD_Client_ID ");
    	
        int R_MailText_ID = DB.getSQLValue(null, sql.toString(), RESET_PASSWORD_MAIL_TEXT_NAME, to.getAD_Client_ID());
    	if (R_MailText_ID <= 0)
    		return false;

        MMailText mailText = new MMailText(m_ctx, R_MailText_ID, null);    	
		to.set_ValueOfColumn("Password", newPassword); // will be hashed and validate on saveEx
    	mailText.setUser(to);
		String message = mailText.getMailText(true);
		message = Env.parseVariable(message, to, to.get_TrxName(), true);
		EMail email = client.createEMail(to.getEMail(), mailText.getMailHeader(), message, mailText.isHtml());
		if (mailText.isHtml())
			email.setMessageHTML(mailText.getMailHeader(), message);
		else
		{
			email.setSubject(mailText.getMailHeader());
			email.setMessageText(message);
		}
		if (!email.isValid() && !email.isValid(true))
		{
			logger.warning("NOT VALID - " + email);
			return Boolean.FALSE;
		}
    	return EMail.SENT_OK.equals(email.send());
    }
}
