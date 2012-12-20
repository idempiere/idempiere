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

package org.adempiere.webui.apps.form;

import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Columns;
import org.zkoss.zul.South;

/**
 * Reset Password Form
 * @author Elaine
 * @date September 18, 2012
 */
public class WResetPassword implements IFormController, EventListener<Event>, ValueChangeListener {

	private static CLogger log = CLogger.getCLogger(WResetPassword.class);

	private CustomForm form;
	private Grid gridPanel;
    private ConfirmPanel confirmPanel;
    
    private Label lblUser;
	private Label lblOldPassword;
    private Label lblNewPassword;
    private Label lblRetypeNewPassword;
    private Label lblNewEMail;
    private Label lblRetypeNewEMail;
    private Label lblNewEMailUser;
    private Label lblNewEMailUserPW;
    
    private WSearchEditor fUser;
    private Textbox txtOldPassword;
    private Textbox txtNewPassword;
    private Textbox txtRetypeNewPassword;
    private Textbox txtNewEMail;
    private Textbox txtRetypeNewEMail;
    private Textbox txtNewEMailUser;
    private Textbox txtNewEMailUserPW;
    
    public WResetPassword()
    {
    	form = new CustomForm();
    	
    	try
		{
			dynInit();
			zkInit();
			
			Borderlayout contentPane = new Borderlayout();
			form.appendChild(contentPane);
			contentPane.setWidth("99%");
			contentPane.setHeight("100%");
			Center center = new Center();
			center.setStyle("border: none");
			contentPane.appendChild(center);
			gridPanel.setHflex("true");
			gridPanel.setVflex("true");
			center.appendChild(gridPanel);
			South south = new South();
			south.setStyle("border: none");
			contentPane.appendChild(south);
			south.appendChild(confirmPanel);
			confirmPanel.addActionListener(this);
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "init", ex);
		}
    }
	
	private void dynInit() throws Exception
	{
		lblUser = new Label(Msg.translate(Env.getCtx(), "AD_User_ID"));
    	lblOldPassword = new Label(Msg.getMsg(Env.getCtx(), "Old Password"));
    	lblNewPassword = new Label(Msg.getMsg(Env.getCtx(), "New Password"));
    	lblRetypeNewPassword = new Label(Msg.getMsg(Env.getCtx(), "New Password Confirm"));
    	lblNewEMail = new Label(Msg.getMsg(Env.getCtx(), "New EMail"));
    	lblRetypeNewEMail = new Label(Msg.getMsg(Env.getCtx(), "New EMail Confirm"));
    	lblNewEMailUser = new Label(Msg.getMsg(Env.getCtx(), "New EMail User"));
    	lblNewEMailUserPW = new Label(Msg.getMsg(Env.getCtx(), "New EMail User Password"));
    	
		//	AD_User.AD_User_ID
		MLookup userLkp = MLookupFactory.get(Env.getCtx(), form.getWindowNo(), 0, 212, DisplayType.Search);
		fUser = new WSearchEditor("AD_User_ID", false, false, true, userLkp);
		fUser.getComponent().setWidth("220px");
		
		txtOldPassword = new Textbox();
        txtOldPassword.setId("txtOldPassword");
        txtOldPassword.setType("password");
        txtOldPassword.setCols(25);
        txtOldPassword.setWidth("220px");

        txtNewPassword = new Textbox();
        txtNewPassword.setId("txtNewPassword");
        txtNewPassword.setType("password");
        txtNewPassword.setCols(25);
        txtNewPassword.setWidth("220px");
        
        txtRetypeNewPassword = new Textbox();
        txtRetypeNewPassword.setId("txtRetypeNewPassword");
        txtRetypeNewPassword.setType("password");
        txtRetypeNewPassword.setCols(25);
        txtRetypeNewPassword.setWidth("220px");
        
        txtNewEMail = new Textbox();
        txtNewEMail.setId("txtNewEMail");
        txtNewEMail.setCols(25);
        txtNewEMail.setWidth("220px");
        
        txtRetypeNewEMail = new Textbox();
        txtRetypeNewEMail.setId("txtRetypeNewEMail");
        txtRetypeNewEMail.setCols(25);
        txtRetypeNewEMail.setWidth("220px");
        
        txtNewEMailUser = new Textbox();
        txtNewEMailUser.setId("txtNewEMailUser");
        txtNewEMailUser.setCols(25);
        txtNewEMailUser.setWidth("220px");
        
        txtNewEMailUserPW = new Textbox();
        txtNewEMailUserPW.setId("txtNewEMailUserPW");
        txtNewEMailUserPW.setCols(25);
        txtNewEMailUserPW.setWidth("220px");
        
		confirmPanel = new ConfirmPanel(true);
	}
    
    private void zkInit() throws Exception
	{
    	gridPanel = GridFactory.newGridLayout();
    	
    	Columns columns = new Columns();
    	gridPanel.appendChild(columns);
    	
    	Column column = new Column();
    	columns.appendChild(column);
    	column.setWidth("40%");
    	
    	column = new Column();
    	columns.appendChild(column);
    	column.setWidth("60%");
    	
    	Rows rows = new Rows();
    	gridPanel.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblUser.rightAlign());
		row.appendChild(fUser.getComponent());
		fUser.addValueChangeListener(this);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblOldPassword.rightAlign());
		row.appendChild(txtOldPassword);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblNewPassword.rightAlign());
		row.appendChild(txtNewPassword);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblRetypeNewPassword.rightAlign());
		row.appendChild(txtRetypeNewPassword);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblNewEMail.rightAlign());
		row.appendChild(txtNewEMail);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblRetypeNewEMail.rightAlign());
		row.appendChild(txtRetypeNewEMail);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblNewEMailUser.rightAlign());
		row.appendChild(txtNewEMailUser);
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblNewEMailUserPW.rightAlign());
		row.appendChild(txtNewEMailUserPW);
	}
    
	@Override
	public void valueChange(ValueChangeEvent e) {
		log.info(e.getPropertyName() + "=" + e.getNewValue());
		if (e.getPropertyName().equals("AD_User_ID"))
			fUser.setValue(e.getNewValue());
	}

	@Override
	public void onEvent(Event e) throws Exception 
	{
		if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
		{
			SessionManager.getAppDesktop().closeActiveWindow();
			return;
		}
		else if (e.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			validateChangePassword();
		}
	}
		
	private void validateChangePassword()
    {
		int p_AD_User_ID = -1;
		if (fUser.getValue() != null)
			p_AD_User_ID = Integer.parseInt(fUser.getValue().toString());
		if (p_AD_User_ID < 0)
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "UserMandatory"));
		
		String p_OldPassword = txtOldPassword.getValue();
		String p_NewPassword = txtNewPassword.getValue();
		String p_NewPasswordConfirm = txtRetypeNewPassword.getValue();
		String p_NewEMail = txtNewEMail.getValue();
		String p_NewEMailConfirm = txtRetypeNewEMail.getValue();
		String p_NewEMailUser = txtNewEMailUser.getValue();
		String p_NewEMailUserPW = txtNewEMailUserPW.getValue();
				
		MUser user = MUser.get(Env.getCtx(), p_AD_User_ID);		
		log.fine("User=" + user);
				
		//	Do we need a password ?
		if (Util.isEmpty(p_OldPassword))		//	Password required
		{
			MUser operator = MUser.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()));
			log.fine("Operator=" + operator);
			
			if (p_AD_User_ID == 0			//	change of System
					|| p_AD_User_ID == 100		//	change of SuperUser
					|| !operator.isAdministrator())
				throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "OldPasswordMandatory"));
		} else {
			//	is entered Password correct ?
			boolean hash_password = MSysConfig.getBooleanValue(MSysConfig.USER_PASSWORD_HASH, false);
			if (hash_password) {
				if (!user.authenticateHash(p_OldPassword))
					throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "OldPasswordNoMatch"));
			} else {
				if (!p_OldPassword.equals(user.getPassword()))
					throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "OldPasswordNoMatch"));
			}
	    	if (MSysConfig.getBooleanValue(MSysConfig.CHANGE_PASSWORD_MUST_DIFFER, true))
	    	{
	    		if (p_OldPassword.equals(p_NewPassword)) {
	        		throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "NewPasswordMustDiffer"));
	    		}
	    	}
		}
		
		// new password confirm
//		if (!Util.isEmpty(p_NewPassword)) {
			if (Util.isEmpty(p_NewPasswordConfirm)) {
				throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "NewPasswordConfirmMandatory"));
			} else {
				if (!p_NewPassword.equals(p_NewPasswordConfirm)) {
					throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PasswordNotMatch"));
				} 
			}
//		}
		
		if (!Util.isEmpty(p_NewEMailUserPW)) {
			if (Util.isEmpty(p_NewEMailConfirm)) {
				throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "NewEmailConfirmMandatory"));
			} else {
				if (!p_NewEMailUserPW.equals(p_NewEMailConfirm)) {
					throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "NewEmailNotMatch"));
				}
			}
		}
		
		if (!Util.isEmpty(p_NewPassword))
			user.set_ValueOfColumn("Password", p_NewPassword); // will be hashed and validate on saveEx
		if (!Util.isEmpty(p_NewEMail))
			user.setEMail(p_NewEMail);
		if (!Util.isEmpty(p_NewEMailUser))
			user.setEMailUser(p_NewEMailUser);
		if (!Util.isEmpty(p_NewEMailUserPW))
			user.setEMailUserPW(p_NewEMailUserPW);
		
		try {
			user.saveEx();
		}
		catch(AdempiereException e)
		{
			user.load(user.get_TrxName());
			throw e;
		}
		clearForm();
		FDialog.info(form.getWindowNo(), form, "RecordSaved");
		return;
    }
	
	private void clearForm()
	{
		fUser.setValue(null);
		txtOldPassword.setValue(null);
	    txtNewPassword.setValue(null);
	    txtRetypeNewPassword.setValue(null);
	    txtNewEMail.setValue(null);
	    txtRetypeNewEMail.setValue(null);
	    txtNewEMailUser.setValue(null);
	    txtNewEMailUserPW.setValue(null);
	}

	@Override
	public ADForm getForm() 
	{
		return form;
	}
}
