/******************************************************************************
 * Copyright (C) 2010 Low Heng Sin  All Rights Reserved.                      *
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
package org.adempiere.client;

import java.awt.BorderLayout;
import java.awt.Cursor;
import java.awt.Dialog;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.util.ResourceBundle;

import javax.swing.JPasswordField;
import javax.swing.SwingConstants;

import org.compiere.Adempiere;
import org.compiere.apps.ConfirmPanel;
import org.compiere.swing.CDialog;
import org.compiere.swing.CLabel;
import org.compiere.swing.CPanel;
import org.compiere.swing.CTextField;
import org.compiere.util.CLogger;
import org.compiere.util.Ini;

/**
 * 
 * @author hengsin
 *
 */
public final class ClientCredentialDialog extends CDialog
	implements ActionListener
{

	/**
	 * generated serial version Id
	 */
	private static final long serialVersionUID = 2728290476926236505L;


	/**
	 *	Construct the dialog.
	 *	Need to call initLogin for dynamic start
	 *  @param parent parent
	 */
	public ClientCredentialDialog (Dialog parent)
	{
		super (parent, "Login", true);	//	Modal
		log.finer("");
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		res = ResourceBundle.getBundle(RESOURCE);
		//
		try
		{
			jbInit();
			initLogin();
		}
		catch(Exception e)
		{
			log.severe(e.toString());
		}
		//  Focus to OK
		this.getRootPane().setDefaultButton(confirmPanel.getOKButton());
		parent.setIconImage(Adempiere.getImage16());
	}   //  ALogin


	protected static final String RESOURCE = "org.compiere.apps.ALoginRes";
	private static ResourceBundle res = ResourceBundle.getBundle(RESOURCE);
	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ClientCredentialDialog.class);

	private CPanel mainPanel = new CPanel(new BorderLayout());
	private CLabel userLabel = new CLabel();
	private CTextField userTextField = new CTextField();
	private CLabel passwordLabel = new CLabel();
	private JPasswordField passwordField = new JPasswordField();
	private GridBagLayout loginLayout = new GridBagLayout();
	private CPanel loginPanel = new CPanel(loginLayout);
	private CPanel southPanel = new CPanel();
	private BorderLayout southLayout = new BorderLayout();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true, false, false, false, false, false, false);
	/**	Combo Active			*/
	private boolean			m_okPressed = false;

	
	/**************************************************************************
	 *	Component initialization
	 *  @throws Exception
	 */
	private void jbInit() throws Exception
	{
		this.setName("Login");
		userLabel.setRequestFocusEnabled(false);
		userLabel.setLabelFor(userTextField);
		passwordLabel.setRequestFocusEnabled(false);
		passwordLabel.setLabelFor(passwordField);
		southPanel.setLayout(southLayout);

		userLabel.setHorizontalAlignment(SwingConstants.RIGHT);
		userLabel.setText(res.getString("User"));
		userLabel.setLabelFor(userTextField);
		loginPanel.add(userLabel,        new GridBagConstraints(0, 3, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 12, 5, 5), 0, 0));
		userTextField.setText("System");			//	default
		loginPanel.add(userTextField,         new GridBagConstraints(1, 3, 3, 1, 1.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(5, 0, 5, 12), 0, 0));
		passwordLabel.setHorizontalAlignment(SwingConstants.RIGHT);
		passwordLabel.setText(res.getString("Password"));
		passwordLabel.setLabelFor(passwordField);
		loginPanel.add(passwordLabel,         new GridBagConstraints(0, 4, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(0, 12, 5, 5), 0, 0));
		passwordField.setText("System");			//	default
		loginPanel.add(passwordField,         new GridBagConstraints(1, 4, 3, 1, 1.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(0, 0, 5, 12), 0, 0));

		//
		this.getContentPane().add(mainPanel);
		mainPanel.add(loginPanel, BorderLayout.CENTER);
		mainPanel.setName("loginMainPanel");
		mainPanel.add(southPanel, BorderLayout.SOUTH);
		//
		southPanel.add(confirmPanel, BorderLayout.NORTH);
		confirmPanel.addActionListener(this);
	} 	//	jbInit

	/**
	 *	Set Initial & Ini Parameters
	 *	Optional Automatic login
	 *	@return true, if connected & parameters set
	 */
	public boolean initLogin()
	{
		//  Application/PWD
		userTextField.setText(Ini.getProperty(Ini.P_UID));
		if (Ini.isPropertyBool(Ini.P_STORE_PWD))
			passwordField.setText(Ini.getProperty(Ini.P_PWD));
		else
			passwordField.setText("");

		return false;
	}	//	initLogin

	/**
	 *  Window Events - requestFocus
	 *  @param e event
	 */
	protected void processWindowEvent(WindowEvent e)
	{
		super.processWindowEvent(e);
		if (e.getID() == WindowEvent.WINDOW_OPENED)
		{
			this.toFront();
			confirmPanel.getOKButton().requestFocusInWindow();
		}
	}   //  processWindowEvent

	/*************************************************************************
	 *	Exit action performed
	 */
	private void appExit()
	{
		dispose();
	}	//	appExit_actionPerformed


	/**
	 * 	Did the user press OK
	 *	@return true if user pressed final OK button
	 */
	public boolean isOKpressed()
	{
		return m_okPressed;
	}	//	isOKpressed
	
	/**************************************************************************
	 *	Action Event handler
	 *  @param e event
	 */
	public void actionPerformed(ActionEvent e)
	{
		if (e.getActionCommand().equals(ConfirmPanel.A_OK))
		{
			setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
			m_okPressed = true; 
			appExit();
		}
		else if (e.getActionCommand().equals(ConfirmPanel.A_CANCEL))
		{
			m_okPressed = false;
			appExit();
		}
	}	//	actionPerformed
	
	/**
	 * @return user id
	 */
	public String getUserId()
	{
		return userTextField.getText();
	}
	
	/**
	 * @return password
	 */
	public char[] getPassword()
	{
		return passwordField.getPassword();
	}
}
