package org.compiere.apps.form;

import java.awt.BorderLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyVetoException;
import java.beans.VetoableChangeListener;
import java.util.logging.Level;

import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

import org.compiere.apps.ADialog;
import org.compiere.apps.ConfirmPanel;
import org.compiere.grid.ed.VLookup;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.swing.CLabel;
import org.compiere.swing.CPanel;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

public class VResetPassword implements FormPanel, ActionListener, VetoableChangeListener {

	private static CLogger log = CLogger.getCLogger(VResetPassword.class);
	
	private FormFrame frame;
	private CPanel mainPanel;
	private ConfirmPanel confirmPanel;
	
	private CLabel lblUser;
	private CLabel lblOldPassword;
    private CLabel lblNewPassword;
    private CLabel lblRetypeNewPassword;
    private CLabel lblNewEMail;
    private CLabel lblRetypeNewEMail;
    private CLabel lblNewEMailUser;
    private CLabel lblNewEMailUserPW;
    
    private VLookup fUser;
    private JPasswordField txtOldPassword;
    private JPasswordField txtNewPassword;
    private JPasswordField txtRetypeNewPassword;
    private JTextField txtNewEMail;
    private JTextField txtRetypeNewEMail;
    private JTextField txtNewEMailUser;
    private JTextField txtNewEMailUserPW;
    
    public int windowNo = 0;
	
	@Override
	public void init(int WindowNo, FormFrame frame) 
	{
		this.windowNo = WindowNo;
		this.frame = frame;
		
		try
		{
			dynInit();
			jbInit();
			
			frame.getContentPane().add(mainPanel, BorderLayout.CENTER);
			frame.getContentPane().add(confirmPanel, BorderLayout.SOUTH);
			confirmPanel.addActionListener(this);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "init", e);
		}
	}
	
	private void jbInit() throws Exception
	{
		GridBagLayout panelLayout = new GridBagLayout();
		mainPanel.setLayout(panelLayout);
		
		mainPanel.add(lblUser,       new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(12, 12, 5, 5), 0, 0));		
			mainPanel.add(fUser,        new GridBagConstraints(1, 0, 1, 1, 1.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(12, 0, 5, 12), 0, 0));
		mainPanel.add(lblOldPassword,       new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(12, 12, 5, 5), 0, 0));		
			mainPanel.add(txtOldPassword,        new GridBagConstraints(1, 1, 1, 1, 1.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(12, 0, 5, 12), 0, 0));		
		mainPanel.add(lblNewPassword,       new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(12, 12, 5, 5), 0, 0));		
			mainPanel.add(txtNewPassword,        new GridBagConstraints(1, 2, 1, 1, 1.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(12, 0, 5, 12), 0, 0));
		mainPanel.add(lblRetypeNewPassword,       new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(12, 12, 5, 5), 0, 0));		
			mainPanel.add(txtRetypeNewPassword,        new GridBagConstraints(1, 3, 1, 1, 1.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(12, 0, 5, 12), 0, 0));
		mainPanel.add(lblNewEMail,       new GridBagConstraints(0, 4, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(12, 12, 5, 5), 0, 0));		
			mainPanel.add(txtNewEMail,        new GridBagConstraints(1, 4, 1, 1, 1.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(12, 0, 5, 12), 0, 0));
		mainPanel.add(lblRetypeNewEMail,       new GridBagConstraints(0, 5, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(12, 12, 5, 5), 0, 0));		
			mainPanel.add(txtRetypeNewEMail,        new GridBagConstraints(1, 5, 1, 1, 1.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(12, 0, 5, 12), 0, 0));
		mainPanel.add(lblNewEMailUser,       new GridBagConstraints(0, 6, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(12, 12, 5, 5), 0, 0));		
			mainPanel.add(txtNewEMailUser,        new GridBagConstraints(1, 6, 1, 1, 1.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(12, 0, 5, 12), 0, 0));
		mainPanel.add(lblNewEMailUserPW,       new GridBagConstraints(0, 7, 1, 1, 0.0, 0.0
				,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(12, 12, 5, 5), 0, 0));		
			mainPanel.add(txtNewEMailUserPW,        new GridBagConstraints(1, 7, 1, 1, 1.0, 0.0
					,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(12, 0, 5, 12), 0, 0));
		
		fUser.addVetoableChangeListener(this);
	}
	
	private void dynInit()
	{
		mainPanel = new CPanel();
		
		//	AD_User.AD_User_ID
		MLookup userLkp = MLookupFactory.get (Env.getCtx(), windowNo, 0, 212, DisplayType.Search);
		fUser = new VLookup("AD_User_ID", false, false, true, userLkp);
		
		txtOldPassword = new JPasswordField();
        txtOldPassword.setName("txtOldPassword");

        txtNewPassword = new JPasswordField();
        txtNewPassword.setName("txtNewPassword");
        
        txtRetypeNewPassword = new JPasswordField();
        txtRetypeNewPassword.setName("txtRetypeNewPassword");
        
        txtNewEMail = new JTextField();
        txtNewEMail.setName("txtNewEMail");
        
        txtRetypeNewEMail = new JTextField();
        txtRetypeNewEMail.setName("txtRetypeNewEMail");
        
        txtNewEMailUser = new JTextField();
        txtNewEMailUser.setName("txtNewEMailUser");
        
        txtNewEMailUserPW = new JTextField();
        txtNewEMailUserPW.setName("txtNewEMailUserPW");
        
		lblUser = new CLabel(Msg.translate(Env.getCtx(), "AD_User_ID"));
		lblUser.setRequestFocusEnabled(false);
		lblUser.setLabelFor(fUser);
		lblUser.setHorizontalAlignment(SwingConstants.RIGHT);
		
    	lblOldPassword = new CLabel(Msg.getMsg(Env.getCtx(), "Old Password"));
    	lblOldPassword.setRequestFocusEnabled(false);
    	lblOldPassword.setLabelFor(txtOldPassword);
    	lblOldPassword.setHorizontalAlignment(SwingConstants.RIGHT);
    	
    	lblNewPassword = new CLabel(Msg.getMsg(Env.getCtx(), "New Password"));
    	lblNewPassword.setRequestFocusEnabled(false);
    	lblNewPassword.setLabelFor(txtNewPassword);
    	lblNewPassword.setHorizontalAlignment(SwingConstants.RIGHT);
    	
    	lblRetypeNewPassword = new CLabel(Msg.getMsg(Env.getCtx(), "New Password Confirm"));
    	lblRetypeNewPassword.setRequestFocusEnabled(false);
    	lblRetypeNewPassword.setLabelFor(txtRetypeNewPassword);
		lblRetypeNewPassword.setHorizontalAlignment(SwingConstants.RIGHT);
    	
    	lblNewEMail = new CLabel(Msg.getMsg(Env.getCtx(), "New EMail"));
    	lblNewEMail.setRequestFocusEnabled(false);
    	lblNewEMail.setLabelFor(txtNewEMail);
    	lblNewEMail.setHorizontalAlignment(SwingConstants.RIGHT);
    	
    	lblRetypeNewEMail = new CLabel(Msg.getMsg(Env.getCtx(), "New EMail Confirm"));
    	lblRetypeNewEMail.setRequestFocusEnabled(false);
    	lblRetypeNewEMail.setLabelFor(txtRetypeNewEMail);
    	lblRetypeNewEMail.setHorizontalAlignment(SwingConstants.RIGHT);
    	
    	lblNewEMailUser = new CLabel(Msg.getMsg(Env.getCtx(), "New EMail User"));
    	lblNewEMailUser.setRequestFocusEnabled(false);
    	lblNewEMailUser.setLabelFor(txtNewEMailUser);
    	lblNewEMailUser.setHorizontalAlignment(SwingConstants.RIGHT);
    	
    	lblNewEMailUserPW = new CLabel(Msg.getMsg(Env.getCtx(), "New EMail User Password"));
    	lblNewEMailUserPW.setRequestFocusEnabled(false);
    	lblNewEMailUserPW.setLabelFor(txtNewEMailUserPW);
    	lblNewEMailUserPW.setHorizontalAlignment(SwingConstants.RIGHT);
    	
    	confirmPanel = new ConfirmPanel();
	}

	@Override
	public void vetoableChange(PropertyChangeEvent e) throws PropertyVetoException 
	{
		log.info(e.getPropertyName() + "=" + e.getNewValue());
		if (e.getPropertyName().equals("AD_User_ID"))
			fUser.setValue(e.getNewValue());
	}

	@Override
	public void actionPerformed(ActionEvent e) 
	{
		if (e.getActionCommand().equals(ConfirmPanel.A_CANCEL))
		{
			dispose();
			return;
		}
		else if (e.getActionCommand().equals(ConfirmPanel.A_OK))
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
		{
			ADialog.error(windowNo, frame, "UserMandatory");
			return;
		}
		
		String p_OldPassword = new String(txtOldPassword.getPassword());
		String p_NewPassword = new String(txtNewPassword.getPassword());
		String p_NewPasswordConfirm = new String(txtRetypeNewPassword.getPassword());
		String p_NewEMail = txtNewEMail.getText();
		String p_NewEMailConfirm = txtRetypeNewEMail.getText();
		String p_NewEMailUser = txtNewEMailUser.getText();
		String p_NewEMailUserPW = txtNewEMailUserPW.getText();
				
		MUser user = MUser.get(Env.getCtx(), p_AD_User_ID);		
		if (log.isLoggable(Level.FINE)) log.fine("User=" + user);
				
		//	Do we need a password ?
		if (Util.isEmpty(p_OldPassword))		//	Password required
		{
			MUser operator = MUser.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()));
			if (log.isLoggable(Level.FINE)) log.fine("Operator=" + operator);
			
			if (p_AD_User_ID == 0			//	change of System
					|| p_AD_User_ID == 100		//	change of SuperUser
					|| !operator.isAdministrator())
			{
				ADialog.error(windowNo, frame, "OldPasswordMandatory");
				return;
			}
		} else {
			//	is entered Password correct ?
			boolean hash_password = MSysConfig.getBooleanValue(MSysConfig.USER_PASSWORD_HASH, false);
			if (hash_password) {
				if (!user.authenticateHash(p_OldPassword))
				{
					ADialog.error(windowNo, frame, "OldPasswordNoMatch");
					return;
				}
			} else {
				if (!p_OldPassword.equals(user.getPassword()))
				{
					ADialog.error(windowNo, frame, "OldPasswordNoMatch");
					return;
				}
			}
	    	if (MSysConfig.getBooleanValue(MSysConfig.CHANGE_PASSWORD_MUST_DIFFER, true))
	    	{
	    		if (p_OldPassword.equals(p_NewPassword)) {
					ADialog.error(windowNo, frame, "NewPasswordMustDiffer");
					return;
	    		}
	    	}
		}
		
		// new password confirm
//		if (!Util.isEmpty(p_NewPassword)) {
			if (Util.isEmpty(p_NewPasswordConfirm)) {
				ADialog.error(windowNo, frame, "NewPasswordConfirmMandatory");
				return;
			} else {
				if (!p_NewPassword.equals(p_NewPasswordConfirm)) {
					ADialog.error(windowNo, frame, "PasswordNotMatch");
					return;
				} 
			}
//		}
		
		if (!Util.isEmpty(p_NewEMailUserPW)) {
			if (Util.isEmpty(p_NewEMailConfirm)) {
				ADialog.error(windowNo, frame, "NewEmailConfirmMandatory");
				return;
			} else {
				if (!p_NewEMailUserPW.equals(p_NewEMailConfirm)) {
					ADialog.error(windowNo, frame, "NewEmailNotMatch");
					return;
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
		catch(Exception e)
		{
			ADialog.error(windowNo, frame, e.getLocalizedMessage());
			user.load(user.get_TrxName());
			return;
		}
		clearForm();
		ADialog.info(windowNo, frame, "RecordSaved");
		return;
    }
	
	private void clearForm()
	{
		fUser.setValue(null);
		txtOldPassword.setText(null);
	    txtNewPassword.setText(null);
	    txtRetypeNewPassword.setText(null);
	    txtNewEMail.setText(null);
	    txtRetypeNewEMail.setText(null);
	    txtNewEMailUser.setText(null);
	    txtNewEMailUserPW.setText(null);
	}

	@Override
	public void dispose() 
	{
		if (frame != null)
			frame.dispose();
		frame = null;
	}
}