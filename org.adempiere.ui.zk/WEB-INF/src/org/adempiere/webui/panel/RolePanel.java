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

import java.sql.Timestamp;
import java.util.Properties;
import java.util.ResourceBundle;

import org.adempiere.webui.AdempiereIdGenerator;
import org.adempiere.webui.LayoutUtils;
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
import org.adempiere.webui.window.LoginWindow;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.Login;
import org.compiere.util.Msg;
import org.zkoss.zhtml.Table;
import org.zkoss.zhtml.Td;
import org.zkoss.zhtml.Tr;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Deferrable;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Button;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Div;
import org.zkoss.zul.Image;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 * @author <a href="mailto:sendy.yagambrum@posterita.org">Sendy Yagambrum</a>
 * @date    July 18, 2007
 */
public class RolePanel extends Window implements EventListener, Deferrable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4403663665119775251L;

	private static final String RESOURCE = "org.compiere.apps.ALoginRes";

    private LoginWindow wndLogin;
    private Login login;

    private Combobox lstRole, lstClient, lstOrganisation, lstWarehouse;
    private Label lblRole, lblClient, lblOrganisation, lblWarehouse, lblDate;
	private WDateEditor lstDate;
    private Button btnOk, btnCancel;

    /** Context					*/
    private Properties      m_ctx;
    /** Username					*/
    private String			m_userName;
    /** Password					*/
    private KeyNamePair[]	m_clientKNPairs;

	private boolean m_show = true;

    public RolePanel(Properties ctx, LoginWindow loginWindow, String userName, boolean show, KeyNamePair[] clientsKNPairs) {
    	this.wndLogin = loginWindow;
    	m_ctx = ctx;
    	m_userName = userName;    	
    	login = new Login(ctx);
    	m_show = show;
        m_clientKNPairs = clientsKNPairs;
    	

        initComponents();
        init();
        this.setId("rolePanel");

        if (m_show) {
        	AuFocus auf = null;
            if (lstClient.getItemCount() > 1) {
            	auf = new AuFocus(lstClient);
            } else {
            	if (MSysConfig.getBooleanValue(MSysConfig.ALogin_ShowOneRole, true) || lstRole.getItemCount() > 1) {
            		auf = new AuFocus(lstRole);
            	} else {
            		auf = new AuFocus(lstOrganisation);
            	}
            }
            Clients.response(auf);
        } else {
        	validateRoles();
        }
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
    	Language language = Env.getLanguage(m_ctx);

    	ResourceBundle res = ResourceBundle.getBundle(RESOURCE, language.getLocale());

        lblClient = new Label();
        lblClient.setId("lblClient");
        lblClient.setValue(res.getString("Client"));

        lblRole = new Label();
        lblRole.setId("lblRole");
        lblRole.setValue(res.getString("Role"));

        lblOrganisation = new Label();
        lblOrganisation.setId("lblOrganisation");
        lblOrganisation.setValue(res.getString("Organization"));

        lblWarehouse = new Label();
        lblWarehouse.setId("lblWarehouse");
        lblWarehouse.setValue(res.getString("Warehouse"));

        lblDate = new Label();
        lblDate.setId("lblDate");
        lblDate.setValue(res.getString("Date"));

        lstRole = new Combobox();
        lstRole.setAutocomplete(true);
        lstRole.setAutodrop(true);
        lstRole.setId("lstRole");
        lstRole.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + lstRole.getId());

        lstRole.addEventListener(Events.ON_SELECT, this);
        lstRole.setWidth("220px");

        lstClient = new Combobox();
        lstClient.setAutocomplete(true);
        lstClient.setAutodrop(true);
        lstClient.setId("lstClient");
        lstClient.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + lstClient.getId());

        lstClient.addEventListener(Events.ON_SELECT, this);
        lstClient.setWidth("220px");

        lstOrganisation = new Combobox();
        lstOrganisation.setAutocomplete(true);
        lstOrganisation.setAutodrop(true);
        lstOrganisation.setId("lstOrganisation");
        lstOrganisation.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + lstOrganisation.getId());

        lstOrganisation.addEventListener(Events.ON_SELECT, this);
        lstOrganisation.setWidth("220px");

        lstWarehouse = new Combobox();
        lstWarehouse.setAutocomplete(true);
        lstWarehouse.setAutodrop(true);
        lstWarehouse.setId("lstWarehouse");
        lstWarehouse.setAttribute(AdempiereIdGenerator.ZK_COMPONENT_PREFIX_ATTRIBUTE, "unq" + lstWarehouse.getId());

        lstWarehouse.addEventListener(Events.ON_SELECT, this);
        lstWarehouse.setWidth("220px");

        lstDate = new WDateEditor();
        lstDate.setValue(new Timestamp(System.currentTimeMillis()));

        btnOk = new Button();
        btnOk.setId("btnOk");
        btnOk.setLabel("Ok");
        btnOk.addEventListener("onClick", this);

        btnCancel = new Button();
        btnCancel.setId("btnCancel");
        btnCancel.setLabel("Cancel");
        btnCancel.addEventListener("onClick", this);
        
    	//  initial client - Elaine 2009/02/06
    	UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
		String initDefault = userPreference.getProperty(UserPreference.P_CLIENT);
        if (m_clientKNPairs != null && m_clientKNPairs.length > 0)
        {
            for(int i = 0; i < m_clientKNPairs.length; i++)
            {
            	ComboItem ci = new ComboItem(m_clientKNPairs[i].getName(), m_clientKNPairs[i].getID());
            	lstClient.appendChild(ci);
                if (m_clientKNPairs[i].getID().equals(initDefault))
                	lstClient.setSelectedItem(ci);
            }
            if (lstClient.getSelectedIndex() == -1 && lstClient.getItemCount() > 0) {
            	m_show = true; // didn't find default client
            	lstClient.setSelectedIndex(0);
            }
        }
        //

        if (m_clientKNPairs.length == 1) {
        	// don't show client if is just one
			lstClient.setSelectedIndex(0);
			lblClient.setVisible(false);
			lstClient.setVisible(false);
        } else {
			lblClient.setVisible(true);
			lstClient.setVisible(true);
        }
        setUserID();
        updateRoleList();
    }

    private void updateRoleList()
    {
		lstRole.getItems().clear();
        Comboitem lstItemClient = lstClient.getSelectedItem();
        if (lstItemClient != null)
        {
        	//  initial role
        	UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
			String initDefault = userPreference.getProperty(UserPreference.P_ROLE);
            KeyNamePair clientKNPair = new KeyNamePair(new Integer((String)lstItemClient.getValue()), lstItemClient.getLabel());
            KeyNamePair roleKNPairs[] = login.getRoles(m_userName, clientKNPair);
            if (roleKNPairs != null && roleKNPairs.length > 0)
            {
                for (int i = 0; i < roleKNPairs.length; i++)
                {
                	ComboItem ci = new ComboItem(roleKNPairs[i].getName(), roleKNPairs[i].getID());
                	lstRole.appendChild(ci);
                    if (roleKNPairs[i].getID().equals(initDefault))
                    	lstRole.setSelectedItem(ci);
                }
                if (lstRole.getSelectedIndex() == -1 && lstRole.getItemCount() > 0) {
                	m_show = true; // didn't find default role
                	lstRole.setSelectedIndex(0);
                }
            }
            //

            //force reload of default role
            MRole.getDefault(m_ctx, true);
            
    		// If we have only one role, we can hide the combobox - metas-2009_0021_AP1_G94
    		if (m_clientKNPairs.length == 1 && lstRole.getItemCount() == 1 && ! MSysConfig.getBooleanValue(MSysConfig.ALogin_ShowOneRole, true))
    		{
    			lstRole.setSelectedIndex(0);
    			lblRole.setVisible(false);
    			lstRole.setVisible(false);
    		}
    		else
    		{
    			lblRole.setVisible(true);
    			lstRole.setVisible(true);
    		}
            
        }
        setUserID();
        updateOrganisationList();
    }

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
            KeyNamePair RoleKNPair = new KeyNamePair(new Integer((String)lstItemRole.getValue()), lstItemRole.getLabel());
            KeyNamePair orgKNPairs[] = login.getOrgs(RoleKNPair);
            if(orgKNPairs != null && orgKNPairs.length > 0)
            {
                for(int i = 0; i < orgKNPairs.length; i++)
                {
                	ComboItem ci = new ComboItem(orgKNPairs[i].getName(), orgKNPairs[i].getID());
                	lstOrganisation.appendChild(ci);
                    if(orgKNPairs[i].getID().equals(initDefault))
                    	lstOrganisation.setSelectedItem(ci);

                }
                if (lstOrganisation.getSelectedIndex() == -1 && lstOrganisation.getItemCount() > 0) {
                	m_show = true; // didn't find default organisation
                	lstOrganisation.setSelectedIndex(0);
                }
            }
            //
        }
        updateWarehouseList();
    }

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
            KeyNamePair organisationKNPair = new KeyNamePair(new Integer((String)lstItemOrganisation.getValue()), lstItemOrganisation.getLabel());
            KeyNamePair warehouseKNPairs[] = login.getWarehouses(organisationKNPair);
            if(warehouseKNPairs != null && warehouseKNPairs.length > 0)
            {
                for(int i = 0; i < warehouseKNPairs.length; i++)
                {
                	ComboItem ci = new ComboItem(warehouseKNPairs[i].getName(), warehouseKNPairs[i].getID());
                	lstWarehouse.appendChild(ci);
                    if(warehouseKNPairs[i].getID().equals(initDefault))
                    	lstWarehouse.setSelectedItem(ci);
                }
                if (lstWarehouse.getSelectedIndex() == -1 && lstWarehouse.getItemCount() > 0) {
                	m_show = true; // didn't find default warehouse
                	lstWarehouse.setSelectedIndex(0);
                }
            }
            //
        }
    }

    public void onEvent(Event event)
    {
        String eventCompId = event.getTarget().getId();
        String eventName = event.getName();
        if(eventName.equals("onSelect"))
        {
            if(eventCompId.equals(lstClient.getId())){            	
            	updateRoleList();	
            }                
            else if(eventCompId.equals(lstRole.getId())) {
            	setUserID();
                updateOrganisationList();
            }
            else if(eventCompId.equals(lstOrganisation.getId()))
                updateWarehouseList();
        }
        if (event.getTarget().getId().equals(ConfirmPanel.A_OK))
        {
            validateRoles();
        }
        else if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
        {
            SessionManager.logoutSession();
            wndLogin.loginCancelled();
        }
    }
    
    private void setUserID() {
    	Env.setContext(m_ctx, "#AD_Client_ID", (String) lstClient.getSelectedItem().getValue());
    	MUser user = MUser.get (m_ctx, m_userName);
    	if (user != null) {
    		Env.setContext(m_ctx, "#AD_User_ID", user.getAD_User_ID() );
    		Env.setContext(m_ctx, "#AD_User_Name", user.getName() );
    		Env.setContext(m_ctx, "#SalesRep_ID", user.getAD_User_ID() );
    	}
    }
    
    public void changeRole(Properties ctx) {
    	int AD_Client_ID = Env.getAD_Client_ID(ctx);
    	lstClient.setValue(AD_Client_ID);
    	updateRoleList();
    	int AD_Role_ID = Env.getAD_Role_ID(ctx);
    	lstRole.setValue(AD_Role_ID);
    	updateOrganisationList();
    	int AD_Org_ID = Env.getAD_Org_ID(ctx);
    	lstOrganisation.setValue(AD_Org_ID);
    	updateWarehouseList();
    	int M_Warehouse_ID = Env.getContextAsInt(ctx, Env.M_WAREHOUSE_ID);
    	lstWarehouse.setValue(M_Warehouse_ID);
    }

    /**
     *  validate Roles
     *
    **/
    public void validateRoles()
    {
    	Comboitem lstItemRole = lstRole.getSelectedItem();
    	Comboitem lstItemClient = lstClient.getSelectedItem();
    	Comboitem lstItemOrg = lstOrganisation.getSelectedItem();
    	Comboitem lstItemWarehouse = lstWarehouse.getSelectedItem();

        if(lstItemRole == null || lstItemRole.getValue() == null)
        {
        	throw new WrongValueException(lstRole, Msg.getMsg(m_ctx, "FillMandatory") + lblRole.getValue());
        }
        else if(lstItemClient == null || lstItemClient.getValue() == null)
        {
        	throw new WrongValueException(lstClient, Msg.getMsg(m_ctx, "FillMandatory") + lblClient.getValue());
        }
        else if(lstItemOrg == null || lstItemOrg.getValue() == null)
        {
        	throw new WrongValueException(lstOrganisation, Msg.getMsg(m_ctx, "FillMandatory") + lblOrganisation.getValue());
        }
        int orgId = 0, warehouseId = 0;
        orgId = Integer.parseInt((String)lstItemOrg.getValue());
        KeyNamePair orgKNPair = new KeyNamePair(orgId, lstItemOrg.getLabel());
        KeyNamePair warehouseKNPair = null;
        if(lstItemWarehouse != null && lstItemWarehouse.getValue() != null)
        {
            warehouseId = Integer.parseInt((String)lstItemWarehouse.getValue());
            warehouseKNPair = new KeyNamePair(warehouseId, lstItemWarehouse.getLabel());
        }

        String msg = login.validateLogin(orgKNPair);
		if (msg != null && msg.length() > 0)
		{
			throw new WrongValueException(msg);
		}

		Timestamp date = (Timestamp)lstDate.getValue();

		msg = login.loadPreferences(orgKNPair, warehouseKNPair, date, null);

        if(!(msg == null || msg.length() == 0))
        {
        	throw new WrongValueException(msg);
        }
        wndLogin.loginCompleted();

        // Elaine 2009/02/06 save preference to AD_Preference
        UserPreference userPreference = SessionManager.getSessionApplication().getUserPreference();
        userPreference.setProperty(UserPreference.P_LANGUAGE, Env.getContext(m_ctx, UserPreference.LANGUAGE_NAME));
        userPreference.setProperty(UserPreference.P_ROLE, lstItemRole != null ? (String) lstItemRole.getValue() : "0");
        userPreference.setProperty(UserPreference.P_CLIENT, lstItemClient != null ? (String) lstItemClient.getValue() : "0");
        userPreference.setProperty(UserPreference.P_ORG, lstItemOrg != null ? (String) lstItemOrg.getValue() : "0");
        userPreference.setProperty(UserPreference.P_WAREHOUSE, lstItemWarehouse != null ? (String) lstItemWarehouse.getValue() : "0");
        userPreference.savePreference();
        //
    }

	public boolean isDeferrable() {
		return false;
	}
}
