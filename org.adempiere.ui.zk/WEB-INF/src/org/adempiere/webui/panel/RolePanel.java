/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *                                                                            *
 * Contributors:                                                              *
 * - Heng Sin Low                                                             *
 *                                                                            *
 * Sponsors:                                                                  *
 * - Idalica Corporation                                                      *
 *****************************************************************************/

package org.adempiere.webui.panel;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Properties;

import org.adempiere.base.sso.SSOUtils;
import org.adempiere.util.Callback;
import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ComboItem;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.UserPreference;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.LoginWindow;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.SystemProperties;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Login;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.WebUtil;
import org.zkoss.util.Locales;
import org.zkoss.web.Attributes;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.AbstractComponent;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Deferrable;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.sys.ComponentCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Div;
import org.zkoss.zul.Image;

/**
 * Select role panel of {@link LoginWindow}
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @author <a href="mailto:sendy.yagambrum@posterita.org">Sendy Yagambrum</a>
 * @date    July 18, 2007
 */
public class RolePanel extends Window implements EventListener<Event>, Deferrable
{
    /**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8077156023041816851L;

	protected LoginWindow wndLogin;
	protected Login login;

	protected Combobox lstRole, lstClient, lstOrganisation, lstWarehouse;
	protected Label lblRole, lblClient, lblDef, lblOrganisation, lblWarehouse, lblDate;
    protected Label lblLanguage;
	protected WDateEditor lstDate;
    protected Combobox lstLanguage;
    protected String validLstLanguage = null;
    protected ConfirmPanel pnlButtons;

    /** Context					*/
	protected Properties      m_ctx;
    /** Username					*/
	protected String			m_userName;
    /** Password					*/
	protected KeyNamePair[]	m_clientKNPairs;
    
	protected UserPreference m_userpreference=null;

	protected boolean m_showRolePanel = true;

	private RolePanel component;

	private boolean isChangeRole = false;

	private boolean m_isClientDefined;

	public boolean isChangeRole() {
		return isChangeRole;
	}

	public void setChangeRole(boolean isChangeRole) {
		this.isChangeRole = isChangeRole;
	}

	// backup old value
	private Properties ctxBeforeChangeRole = null;

	private static final String ON_DEFER_LOGOUT = "onDeferLogout";

	/**
	 * @param ctx
	 * @param loginWindow
	 * @param userName
	 * @param show
	 * @param clientsKNPairs
	 * @param isClientDefined
	 */
	public RolePanel(Properties ctx, LoginWindow loginWindow, String userName, boolean show, KeyNamePair[] clientsKNPairs, boolean isClientDefined) {
    	this.wndLogin = loginWindow;
    	m_ctx = ctx;
    	m_userName = userName;    	
    	login = new Login(ctx);
    	m_showRolePanel = show;
    	m_isClientDefined = isClientDefined;
        m_clientKNPairs = clientsKNPairs;
        
    	m_userpreference = SessionManager.getSessionApplication().getUserPreference();
        if( m_clientKNPairs.length == 1  &&  !m_showRolePanel ){
        	Env.setContext(m_ctx, Env.AD_CLIENT_ID, (String) m_clientKNPairs[0].getID());
        	MUser user = MUser.get (m_ctx, Login.getAppUser(m_userName));
        	m_userpreference.loadPreference(user.get_ID());        	
        } else {
        	m_userpreference.loadPreference(-1);
        }
    	
        initComponents();
        init();
        this.setId("rolePanel");
        this.setSclass("login-box");

        if (! m_showRolePanel) {
        	// check if all mandatory fields are ok to not show
        	if (   lstRole.getSelectedItem() == null || lstRole.getSelectedItem().getValue() == null
       			|| lstClient.getSelectedItem() == null || lstClient.getSelectedItem().getValue() == null
       			|| lstOrganisation.getSelectedItem() == null || lstOrganisation.getSelectedItem().getValue() == null) {
        		m_showRolePanel = true;
        	}
        }
        if (m_showRolePanel) {
        	AuFocus auf = null;
            if (lstClient.getItemCount() > 1) {
            	auf = new AuFocus(lstClient);
            } else if (lstRole.getItemCount() > 1) {
            	auf = new AuFocus(lstRole);
            } else {
           		auf = new AuFocus(lstOrganisation);
            }
            Clients.response(auf);
        }
    }

	/**
	 * Layout panel
	 */
    private void init()
    {
    	Clients.response(new AuScript("zAu.cmd0.clearBusy()"));
    	createUI();
    }

    /**
     * Layout panel
     */
	protected void createUI() {
		Div div = new Div();
    	div.setSclass(ITheme.LOGIN_BOX_HEADER_CLASS);
    	Label label = new Label(Msg.getMsg(Env.getCtx(), "SelectRole"));
    	label.setSclass(ITheme.LOGIN_BOX_HEADER_TXT_CLASS);
    	div.appendChild(label);
    	this.appendChild(div);

        Table table = new Table();
        table.setId("grdChooseRole");
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
        tr.setId("rowclient");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblClient.rightAlign());
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(lstClient);

        tr = new Tr();
        tr.setId("rowRole");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblRole.rightAlign());
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(lstRole);

    	tr = new Tr();
        tr.setId("rowLabelDefault");
        table.appendChild(tr);
    	//td = new Td();
    	//tr.appendChild(td);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
		div = new Div();
		div.setStyle("text-align: right; text-decoration: underline");
		div.appendChild(lblDef);
    	td.appendChild(div);

    	tr = new Tr();
        tr.setId("rowOrganisation");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblOrganisation.rightAlign());
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(lstOrganisation);

    	tr = new Tr();
        tr.setId("rowWarehouse");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblWarehouse.rightAlign());
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(lstWarehouse);
    	
    	tr = new Tr();
    	tr.setId("rowLanguage");
    	table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblLanguage.rightAlign());
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(lstLanguage);

    	tr = new Tr();
        tr.setId("rowDate");
        table.appendChild(tr);
    	td = new Td();
    	tr.appendChild(td);
    	td.setSclass(ITheme.LOGIN_LABEL_CLASS);
    	td.appendChild(lblDate.rightAlign());
    	td = new Td();
    	td.setSclass(ITheme.LOGIN_FIELD_CLASS);
    	tr.appendChild(td);
    	td.appendChild(lstDate.getComponent());

    	div = new Div();
    	div.setSclass(ITheme.LOGIN_BOX_FOOTER_CLASS);
        
    	pnlButtons = new ConfirmPanel(true, false, false, false, false, false, true);
        pnlButtons.addActionListener(this);
        Button okBtn = pnlButtons.getButton(ConfirmPanel.A_OK);
        okBtn.setWidgetListener("onClick", "zAu.cmd0.showBusy(null)");
        okBtn.addCallback(ComponentCtrl.AFTER_PAGE_DETACHED, t -> ((AbstractComponent)t).setWidgetListener("onClick", null));

        Button helpButton = pnlButtons.createButton(ConfirmPanel.A_HELP);
		helpButton.addEventListener(Events.ON_CLICK, this);
		helpButton.setSclass(ITheme.LOGIN_BUTTON_CLASS);
		pnlButtons.addComponentsRight(helpButton);

        LayoutUtils.addSclass(ITheme.LOGIN_BOX_FOOTER_PANEL_CLASS, pnlButtons);
        ZKUpdateUtil.setWidth(pnlButtons, null);
        pnlButtons.getButton(ConfirmPanel.A_OK).setSclass(ITheme.LOGIN_BUTTON_CLASS);
        pnlButtons.getButton(ConfirmPanel.A_CANCEL).setSclass(ITheme.LOGIN_BUTTON_CLASS);
        div.appendChild(pnlButtons);
        this.appendChild(div);
        
        if(validLstLanguage!=null)
        	languageChanged(validLstLanguage);
	}

	/**
	 * Create components
	 */
    private void initComponents()
    {
    	Language language = Env.getLanguage(m_ctx);

    	lblClient = new Label();
        lblClient.setId("lblClient");
        lblClient.setValue(Msg.getMsg(language,"Client"));

        lblRole = new Label();
        lblRole.setId("lblRole");
        lblRole.setValue(Msg.getMsg(language,"Role"));

        lblDef = new Label();
        lblDef.setId("lblDef");
        lblDef.setValue(Msg.getMsg(language,"Defaults"));

        lblOrganisation = new Label();
        lblOrganisation.setId("lblOrganisation");
        lblOrganisation.setValue(Msg.getMsg(language,"Organization"));

        lblWarehouse = new Label();
        lblWarehouse.setId("lblWarehouse");
        lblWarehouse.setValue(Msg.getMsg(language,"Warehouse"));
        
        lblLanguage = new Label();
        lblLanguage.setId("lblLanguage");
        lblLanguage.setValue("Language");

        lblDate = new Label();
        lblDate.setId("lblDate");
        lblDate.setValue(Msg.getMsg(language,"Date"));

        lstRole = new Combobox();
        lstRole.setAutocomplete(true);
        lstRole.setAutodrop(true);
        lstRole.setId("lstRole");

        lstRole.addEventListener(Events.ON_SELECT, this);
        ZKUpdateUtil.setWidth(lstRole, "220px");

        lstClient = new Combobox();
        lstClient.setAutocomplete(true);
        lstClient.setAutodrop(true);
        lstClient.setId("lstClient");

        lstClient.addEventListener(Events.ON_SELECT, this);
        ZKUpdateUtil.setWidth(lstClient, "220px");

        lstOrganisation = new Combobox();
        lstOrganisation.setAutocomplete(true);
        lstOrganisation.setAutodrop(true);
        lstOrganisation.setId("lstOrganisation");

        lstOrganisation.addEventListener(Events.ON_SELECT, this);
        ZKUpdateUtil.setWidth(lstOrganisation, "220px");

        lstWarehouse = new Combobox();
        lstWarehouse.setAutocomplete(true);
        lstWarehouse.setAutodrop(true);
        lstWarehouse.setId("lstWarehouse");

        lstWarehouse.addEventListener(Events.ON_SELECT, this);
        ZKUpdateUtil.setWidth(lstWarehouse, "220px");

        lstDate = new WDateEditor();
        lstDate.setValue(new Timestamp(System.currentTimeMillis()));
        lstDate.getComponent().setId("loginDate");

    	//  initial client - Elaine 2009/02/06
    	UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
		String initDefault = userPreference.getProperty(UserPreference.P_CLIENT);
		if( initDefault.length() == 0 &&  !m_showRolePanel  &&  m_userpreference != null )
		{
			initDefault=m_userpreference.getProperty( UserPreference.P_CLIENT );
		}
        if (m_clientKNPairs != null && m_clientKNPairs.length > 0)
        {
            for(int i = 0; i < m_clientKNPairs.length; i++)
            {
            	ComboItem ci = new ComboItem(m_clientKNPairs[i].getName(), m_clientKNPairs[i].getID());
        		if (SystemProperties.isZkUnitTest()) {
                	String id = AdempiereIdGenerator.escapeId(ci.getLabel());
                	if (lstClient.getFellowIfAny(id) == null)
                		ci.setId(id);
        		}
            	lstClient.appendChild(ci);
                if (m_clientKNPairs[i].getID().equals(initDefault))
                	lstClient.setSelectedItem(ci);
            }
            if (lstClient.getSelectedIndex() == -1 && lstClient.getItemCount() > 0) {
            	m_showRolePanel = true; // didn't find default client
            	lstClient.setSelectedIndex(0);
            }
        }
        //

        if (m_clientKNPairs!=null && m_clientKNPairs.length == 1) {
        	// disable client if is just one
			lstClient.setSelectedIndex(0);
			lstClient.setEnabled(false);
        } else {
			lstClient.setEnabled(true);
        }
        
        // Disable date combo-box at login screen
        if (!MSysConfig.getBooleanValue(MSysConfig.ALogin_ShowDate, true))
        {
        	lstDate.setReadWrite(false);
        }
        
        lstLanguage = new Combobox();
        lstLanguage.setAutocomplete(true);
        lstLanguage.setAutodrop(true);
        lstLanguage.setId("lstLanguage");
        ZKUpdateUtil.setWidth(lstLanguage, "220px");

        // Update Language List
        lstLanguage.getItems().clear();
        ArrayList<String> supported = Env.getLoginLanguages();
        String[] availableLanguages = Language.getNames();
        for (String langName : availableLanguages)
        {
        	Language lang = Language.getLanguage(langName);
        	if (!supported.contains(lang.getAD_Language()))
        		continue;
        	lstLanguage.appendItem(langName, lang.getAD_Language());
        }

        if(language!=null)
        {
        	validLstLanguage = language.getName();
        	lstLanguage.setValue(validLstLanguage);
        }
        else if (lstLanguage.getItems().size() > 0)
        {
        	validLstLanguage = (String) lstLanguage.getItems().get(0).getLabel();
        	lstLanguage.setValue(validLstLanguage);
        }
        lstLanguage.addEventListener(Events.ON_SELECT, this);

        setUserID();
        updateRoleList();

        this.component = this;
    	component.addEventListener(ON_DEFER_LOGOUT, this);
    }

    /**
     * Update roles available for selection (after selection of tenant)
     */
    private void updateRoleList()
    {
		lstRole.getItems().clear();
		lstRole.setText("");
        setUserID();
    	UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
        Comboitem lstItemClient = lstClient.getSelectedItem();
        if (lstItemClient != null)
        {
       		userPreference.loadPreference(Env.getContextAsInt(m_ctx, Env.AD_USER_ID));

        	//  initial role
			String initDefault = userPreference.getProperty(UserPreference.P_ROLE);
			if( initDefault.length() == 0 &&  !m_showRolePanel  &&  m_userpreference != null )
			{
				initDefault=m_userpreference.getProperty( UserPreference.P_ROLE );
			}
			int clientId = Integer.valueOf((String)lstItemClient.getValue());
            KeyNamePair clientKNPair = new KeyNamePair(clientId, lstItemClient.getLabel());
            KeyNamePair roleKNPairs[] = login.getRoles(m_userName, clientKNPair, LoginPanel.ROLE_TYPES_WEBUI);
            if (roleKNPairs != null && roleKNPairs.length > 0)
            {
                for (int i = 0; i < roleKNPairs.length; i++)
                {
                	ComboItem ci = new ComboItem(roleKNPairs[i].getName(), roleKNPairs[i].getID());
            		if (SystemProperties.isZkUnitTest()) {
                    	String id = AdempiereIdGenerator.escapeId(ci.getLabel());
                    	if (lstRole.getFellowIfAny(id) == null)
                    		ci.setId(id);
            		}
                	lstRole.appendChild(ci);
                    if (roleKNPairs[i].getID().equals(initDefault))
                    	lstRole.setSelectedItem(ci);
                }
                if (lstRole.getSelectedIndex() == -1 && lstRole.getItemCount() > 0) {
                	m_showRolePanel = true; // didn't find default role
                	lstRole.setSelectedIndex(0);
                }
            }
            //

    		// If we have only one role, we can make readonly the combobox
    		if (lstRole.getItemCount() == 1)
    		{
    			lstRole.setSelectedIndex(0);
    			lstRole.setEnabled(false);
    		} else {
    			lstRole.setEnabled(true);
    		}
        }
        updateOrganisationList();
       	updateLanguage();
    	if (lstClient.getChildren().size() > 1) {
    		userPreference.loadPreference(Env.getContextAsInt(m_ctx, Env.AD_USER_ID));
    		// saving the preferences was postponed until the user selects the client
        	Comboitem lstItemRole = lstRole.getSelectedItem();
        	Comboitem lstItemOrg = lstOrganisation.getSelectedItem();
        	Comboitem lstItemWarehouse = lstWarehouse.getSelectedItem();
        	Comboitem lstItemLanguage = lstLanguage.getSelectedItem();
        	if (lstItemLanguage != null && lstItemLanguage.getValue() != null)
        		userPreference.setProperty(UserPreference.P_LANGUAGE,  (String) lstItemLanguage.getValue());
        	else
        		userPreference.setProperty(UserPreference.P_LANGUAGE, Env.getContext(m_ctx, UserPreference.LANGUAGE_NAME));
        	if (lstItemRole != null && lstItemRole.getValue() != null)
        		userPreference.setProperty(UserPreference.P_ROLE, (String) lstItemRole.getValue());
        	if (lstItemClient != null && lstItemClient.getValue() != null)
        		userPreference.setProperty(UserPreference.P_CLIENT, (String) lstItemClient.getValue());
        	if (lstItemOrg != null && lstItemOrg.getValue() != null)
        		userPreference.setProperty(UserPreference.P_ORG, (String) lstItemOrg.getValue());
        	if (lstItemWarehouse != null && lstItemWarehouse.getValue() != null)
        		userPreference.setProperty(UserPreference.P_WAREHOUSE, (String) lstItemWarehouse.getValue());
        	userPreference.savePreference();
    	}
    }
    
    private void updateLanguage()
	{
		UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
		String initDefault = userPreference.getProperty(UserPreference.P_LANGUAGE);
		for (int i = 0; i < lstLanguage.getItemCount(); i++)
		{
			Comboitem li = lstLanguage.getItemAtIndex(i);
			if (li.getLabel().equals(initDefault))
			{
				lstLanguage.setSelectedIndex(i);
				languageChanged(li.getLabel()); // Elaine 2009/04/17 language changed
				break;
			}
		}
		if (lstLanguage.getItemCount() == 1)
		{
			lstLanguage.setSelectedIndex(0);
			lstLanguage.setEnabled(false);
		}
		else
		{
			lstLanguage.setEnabled(true);
		}
	}

	private void languageChanged(String langName)
	{
		Language language = findLanguage(langName);
		lblClient.setValue(Msg.getMsg(language, "Client"));
		lblRole.setValue(Msg.getMsg(language, "Role"));
		lblDef.setValue(Msg.getMsg(language, "Defaults"));
		lblOrganisation.setValue(Msg.getMsg(language, "Organization"));
		lblWarehouse.setValue(Msg.getMsg(language, "Warehouse"));
		lblLanguage.setValue(Msg.getMsg(language, "Language"));
		lblDate.setValue(Msg.getMsg(language, "Date"));
		if (pnlButtons != null) {
			pnlButtons.getButton(ConfirmPanel.A_OK).setLabel(Util.cleanAmp(Msg.getMsg(language, ConfirmPanel.A_OK)));
			pnlButtons.getButton(ConfirmPanel.A_HELP)
					.setLabel(Util.cleanAmp(Msg.getMsg(language, ConfirmPanel.A_HELP)));
			pnlButtons.getButton(ConfirmPanel.A_CANCEL)
					.setLabel(Util.cleanAmp(Msg.getMsg(language, ConfirmPanel.A_CANCEL)));
		}
	}
    
	private Language findLanguage(String langName)
	{
		Language tmp = Language.getLanguage(langName);
		Language language = new Language(tmp.getName(), tmp.getAD_Language(), tmp.getLocale(), tmp.isDecimalPoint(),
						tmp.getDateFormat().toPattern(), tmp.getMediaSize());
		Env.verifyLanguage(m_ctx, language);
		Env.setContext(m_ctx, Env.LANGUAGE, language.getAD_Language());
		Env.setContext(m_ctx, AEnv.LOCALE, language.getLocale().toString());

		// cph::erp added this in order to get the processing dialog in the correct language
		Locale locale = language.getLocale();
		try
		{
			Clients.reloadMessages(locale);
		}
		catch (IOException e)
		{
			Dialog.warn(0, e.getLocalizedMessage(), e.getMessage());
		}
		Locales.setThreadLocal(locale);
		// cph::erp end
		return language;
	}

    /**
     * After organizations available for selection (after selection of role)
     */
    private void updateOrganisationList()
    {
        lstOrganisation.getItems().clear();
        lstOrganisation.setText("");
        Comboitem lstItemRole = lstRole.getSelectedItem();
        if(lstItemRole != null)
        {
			//  initial organisation - Elaine 2009/02/06
        	UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
			String initDefault = userPreference.getProperty(UserPreference.P_ORG);
			if( initDefault.length() == 0  &&  !m_showRolePanel  &&  m_userpreference != null )
			{
				initDefault=m_userpreference.getProperty( UserPreference.P_ORG );
			}
            KeyNamePair RoleKNPair = new KeyNamePair(Integer.valueOf((String)lstItemRole.getValue()), lstItemRole.getLabel());
            KeyNamePair orgKNPairs[] = login.getOrgs(RoleKNPair);
            if(orgKNPairs != null && orgKNPairs.length > 0)
            {
                for(int i = 0; i < orgKNPairs.length; i++)
                {
                	ComboItem ci = new ComboItem(orgKNPairs[i].getName(), orgKNPairs[i].getID());
            		if (SystemProperties.isZkUnitTest()) {
                    	String id = AdempiereIdGenerator.escapeId(ci.getLabel());
                    	if (lstOrganisation.getFellowIfAny(id) == null)
                    		ci.setId(id);
            		}
                	lstOrganisation.appendChild(ci);
                    if(orgKNPairs[i].getID().equals(initDefault))
                    	lstOrganisation.setSelectedItem(ci);

                }
                if (lstOrganisation.getSelectedIndex() == -1 && lstOrganisation.getItemCount() > 0) {
                	m_showRolePanel = true; // didn't find default organisation
                	lstOrganisation.setSelectedIndex(0);
                }
            }

            // If we have only one org, we can make readonly the combobox
    		if (lstOrganisation.getItemCount() == 1)
    		{
    			lstOrganisation.setSelectedIndex(0);
    			lstOrganisation.setEnabled(false);
    		} else {
    			lstOrganisation.setEnabled(true);
    		}
            //
        }
        updateWarehouseList();
    }

    /**
     * Update list of warehouse available for selection (after selection of organization)
     */
    private void updateWarehouseList()
    {
        lstWarehouse.getItems().clear();
        lstWarehouse.setText("");
        Comboitem lstItemOrganisation = lstOrganisation.getSelectedItem();
        if(lstItemOrganisation != null)
        {
			//  initial warehouse - Elaine 2009/02/06
        	UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
			String initDefault = userPreference.getProperty(UserPreference.P_WAREHOUSE);
			if( initDefault.length() == 0 &&  !m_showRolePanel  &&  m_userpreference != null )
			{
				initDefault=m_userpreference.getProperty( UserPreference.P_WAREHOUSE );
			}
            KeyNamePair organisationKNPair = new KeyNamePair(Integer.valueOf((String)lstItemOrganisation.getValue()), lstItemOrganisation.getLabel());
            KeyNamePair warehouseKNPairs[] = login.getWarehouses(organisationKNPair);
            if(warehouseKNPairs != null && warehouseKNPairs.length > 0)
            {
                for(int i = 0; i < warehouseKNPairs.length; i++)
                {
                	ComboItem ci = new ComboItem(warehouseKNPairs[i].getName(), warehouseKNPairs[i].getID());
                	ci.setLabel(ci.getLabel());
                	lstWarehouse.appendChild(ci);
                    if(warehouseKNPairs[i].getID().equals(initDefault))
                    	lstWarehouse.setSelectedItem(ci);
                }
                if (lstWarehouse.getSelectedIndex() == -1 && lstWarehouse.getItemCount() > 0) {
                	lstWarehouse.setSelectedIndex(0);
                }
            }
            //
        }
    }

    @Override
    public void onEvent(Event event)
    {
        String eventCompId = event.getTarget().getId();
        String eventName = event.getName();
        if(eventName.equals("onSelect"))
        {
            if(eventCompId.equals(lstClient.getId())){
            	checkMandatoryField(lstClient, lblClient);
            	updateRoleList();
            }
            else if(eventCompId.equals(lstRole.getId())) {
            	checkMandatoryField(lstRole, lblRole);
            	setUserID();
                updateOrganisationList();
            }
            else if(eventCompId.equals(lstOrganisation.getId())) {
            	checkMandatoryField(lstOrganisation, lblOrganisation);
                updateWarehouseList();
            }
			else if (eventCompId.equals(lstLanguage.getId()))
			{
				if (lstLanguage.getSelectedItem() == null)
				{
					lstLanguage.setValue(validLstLanguage);
				}
				else
				{
					validLstLanguage = lstLanguage.getSelectedItem().getLabel();
				}

				languageChanged(validLstLanguage);
			}
        }
        if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
        {
            validateRoles(false);
        }
        else if (event.getTarget().getId().equals(ConfirmPanel.A_HELP))
        {
            openLoginHelp();
        }
        else if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
        {
        	if (isChangeRole()) {
        		changeRole(ctxBeforeChangeRole);
        		validateRoles(false);
        	} else {
        		ctxBeforeChangeRole = null;
        		SessionManager.logoutSession();
        		//wndLogin.loginCancelled();
        	}
        }
		else if (ON_DEFER_LOGOUT.equals(event.getName()))
		{
            SessionManager.logoutSession();
            //wndLogin.loginCancelled();
		}
    }
    
	private void openLoginHelp() {
		String lang = Env.getContext(Env.getCtx(), Env.LANGUAGE);
		lang = lang.substring(0, 2);
		String helpURL = MSysConfig.getValue(MSysConfig.LOGIN_SELECT_ROLE_HELP_URL, "https://wiki.idempiere.org/{lang}/Login_Select_Role_Help");
		if (helpURL.contains("{lang}")) {
			String rawURL = helpURL;
			helpURL = Util.replace(rawURL, "{lang}", lang);
			if (!"en".equals(lang) && !WebUtil.isUrlOk(helpURL))
				helpURL = Util.replace(rawURL, "{lang}", "en"); // default to English
		}
		try {
			Executions.getCurrent().sendRedirect(helpURL, "_blank");
		}
		catch (Exception e) {
			String message = e.getMessage();
			Dialog.warn(0, "URLnotValid", message);
		}
	}

	/**
	 * Set user id to environment context
	 */
    private void setUserID() {
    	if (lstClient.getSelectedItem() != null) {
        	Env.setContext(m_ctx, Env.AD_CLIENT_ID, (String) lstClient.getSelectedItem().getValue());
    	} else {
        	Env.setContext(m_ctx, Env.AD_CLIENT_ID, (String) null);
    	}
    	MUser user = MUser.get (m_ctx, Login.getAppUser(m_userName));
    	if (user != null) {
    		Env.setContext(m_ctx, Env.AD_USER_ID, user.getAD_User_ID() );
    		Env.setContext(m_ctx, Env.AD_USER_NAME, user.getName() );
    		Env.setContext(m_ctx, Env.SALESREP_ID, user.getAD_User_ID() );
    	}
    }
    
    /**
     * Show UI for change role
     * @param ctx env context
     */
    public void changeRole(Properties ctx) {
    	ctxBeforeChangeRole = new Properties();
    	ctxBeforeChangeRole.putAll(ctx);
    	int AD_Client_ID = Env.getAD_Client_ID(ctx);
    	lstClient.setValue(AD_Client_ID);
    	updateRoleList();
    	int AD_Role_ID = Env.getAD_Role_ID(ctx);
    	lstRole.setValue(AD_Role_ID);
    	updateOrganisationList();
    	int AD_Org_ID = Env.getContextAsInt(ctx, "#AD_Org_ID_ChangeRole");
    	lstOrganisation.setValue(AD_Org_ID);
    	updateWarehouseList();
    	int M_Warehouse_ID = Env.getContextAsInt(ctx, Env.M_WAREHOUSE_ID);
    	lstWarehouse.setValue(M_Warehouse_ID);
    }

    /**
     * Validate fields
     * @param isMFAValidated
     */
    public void validateRoles(boolean isMFAValidated)
    {
    	Clients.clearBusy();
    	Comboitem lstItemRole = lstRole.getSelectedItem();
    	Comboitem lstItemClient = lstClient.getSelectedItem();
    	Comboitem lstItemOrg = lstOrganisation.getSelectedItem();
    	Comboitem lstItemWarehouse = lstWarehouse.getSelectedItem();
    	Comboitem lstItemLanguage = lstLanguage.getSelectedItem();

    	checkMandatoryField(lstClient, lblClient);
    	checkMandatoryField(lstRole, lblRole);
    	checkMandatoryField(lstOrganisation, lblOrganisation);
        int orgId = 0, warehouseId = 0;
        orgId = Integer.parseInt((String)lstItemOrg.getValue());
        KeyNamePair orgKNPair = new KeyNamePair(orgId, lstItemOrg.getLabel());
        KeyNamePair warehouseKNPair = null;
        if(lstItemWarehouse != null && lstItemWarehouse.getValue() != null)
        {
            warehouseId = Integer.parseInt((String)lstItemWarehouse.getValue());
            warehouseKNPair = new KeyNamePair(warehouseId, lstItemWarehouse.getLabel());
        }

		Timestamp date = (Timestamp)lstDate.getValue();

		String msg = login.loadPreferences(orgKNPair, warehouseKNPair, date, null);
        if (! Util.isEmpty(msg))
		{
			Env.getCtx().clear();
			Dialog.error(0, "Error", msg, new Callback<Integer>() {					
				@Override
				public void onCallback(Integer result) {
					Events.echoEvent(new Event(ON_DEFER_LOGOUT, component));
				}
			});
            return;
		}

		// Elaine 2009/02/06 save preference to AD_Preference
		UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
		if (lstItemLanguage != null && lstItemLanguage.getValue() != null)
			userPreference.setProperty(UserPreference.P_LANGUAGE,  (String) lstItemLanguage.getValue());
		else
			userPreference.setProperty(UserPreference.P_LANGUAGE, Env.getContext(m_ctx, UserPreference.LANGUAGE_NAME));
		userPreference.setProperty(UserPreference.P_ROLE, (String) lstItemRole.getValue());
		userPreference.setProperty(UserPreference.P_CLIENT, (String) lstItemClient.getValue());
		userPreference.setProperty(UserPreference.P_ORG, (String) lstItemOrg.getValue());
		userPreference.setProperty(UserPreference.P_WAREHOUSE,
				lstItemWarehouse != null ? (String) lstItemWarehouse.getValue() : "0");
		userPreference.savePreference();

		// force reload of default role when more than 1 client
		if (lstClient.getChildren().size() > 1)
			MRole.getDefault(m_ctx, true);
		String langName = null;
		if (lstLanguage.getSelectedItem() != null)
			langName = (String) lstLanguage.getSelectedItem().getLabel();
		else
			langName = Language.getBaseLanguage().getName();
		Language language = findLanguage(langName);
		Env.setContext(m_ctx, UserPreference.LANGUAGE_NAME, language.getName());

		Locale locale = language.getLocale();
		Desktop desktop = Executions.getCurrent().getDesktop();
		desktop.getSession().setAttribute(Attributes.PREFERRED_LOCALE, locale);
		try
		{
			Clients.reloadMessages(locale);
		}
		catch (IOException e)
		{
			Dialog.warn(0, e.getLocalizedMessage(), e.getMessage());
		}
		Locales.setThreadLocal(locale);

		if (m_isClientDefined || isMFAValidated)
			wndLogin.loginCompleted(login, orgKNPair, this);
		else
			wndLogin.validateMFA(orgKNPair, m_isClientDefined, m_userName, m_showRolePanel, m_clientKNPairs);
		
		desktop.getSession().setAttribute(SSOUtils.ISCHANGEROLE_REQUEST, false);
    }

    /**
     * Check if the field is filled, throws WrongValueException if not
     * @param lst
     * @param lbl
     */
    private void checkMandatoryField(Combobox lst, Label lbl) {
    	Comboitem item = lst.getSelectedItem();
        if (item == null || item.getValue() == null) {
        	throw new WrongValueException(lst, Msg.getMsg(m_ctx, "FillMandatory") + lbl.getValue());
        }
	}

	@Override
	public boolean isDeferrable() {
		return false;
	}

    /**
     * Is show role selection panel to user
     * @return true if role selection panel will be shown to user
     */
	public boolean show() {
		return m_showRolePanel;
	}
}
