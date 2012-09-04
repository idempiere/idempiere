package org.adempiere.webui.panel;

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
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zhtml.Div;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Image;

public class ChangePasswordPanel extends Window implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5323925843783103350L;

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
    private Textbox txtOldPassword;
    private Textbox txtNewPassword;
    private Textbox txtRetypeNewPassword;

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
    	Label label = new Label("Login");
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
        tr.setId("rowUser");
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
    	
    	if (Util.isEmpty(oldPassword))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "@OldPasswordMandatory@"));
    	
    	if (Util.isEmpty(retypeNewPassword))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "@NewPasswordConfirmMandatory@"));
    	
    	if (!newPassword.equals(retypeNewPassword))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "@PasswordNotMatch@"));
    	
    	if (!oldPassword.equals(m_userPassword))
    		throw new IllegalArgumentException(Msg.getMsg(m_ctx, "@OldPasswordNoMatch@"));

    	for (KeyNamePair clientKNPair : m_clientKNPairs)
    	{
    		int clientId = clientKNPair.getKey();
    		Env.setContext(m_ctx, "#AD_Client_ID", clientId);
    		MUser user = MUser.get(m_ctx, m_userName);
    		if (user == null)
    		{
    			logger.severe("Could not find user '" + m_userName + "'");
    			throw new AdempiereException("Could not find user");
    		}
    		
    		user.setPassword(newPassword);
    		user.saveEx();
    	}
    	
    	wndLogin.loginOk(m_userName, m_show, m_clientKNPairs);
    }
}
