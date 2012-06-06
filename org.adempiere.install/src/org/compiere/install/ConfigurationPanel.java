/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.install;

import java.awt.Color;
import java.awt.Cursor;
import java.awt.Font;
import java.awt.Frame;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ResourceBundle;
import java.util.logging.Level;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JSeparator;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.border.TitledBorder;

import org.adempiere.install.DBConfigStatus;
import org.adempiere.install.IDBConfigMonitor;
import org.apache.tools.ant.Main;
import org.compiere.util.CLogger;

/**
 *	Configuration Panel
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ConfigurationPanel.java,v 1.3 2006/07/30 00:57:42 jjanke Exp $
 */
public class ConfigurationPanel extends JPanel implements ActionListener, IDBConfigMonitor
{
	/**
	 *
	 */
	private static final long serialVersionUID = -5113669370606054608L;


	/**
	 * 	Constructor
	 *  @param statusBar for info
	 */
	public ConfigurationPanel (JLabel statusBar)
	{
		m_statusBar = statusBar;
		try
		{
			jbInit();
		}
		catch (Exception e)
		{
			e.printStackTrace();
			System.exit(1);
		}
	}	//	ConfigurationPanel

	/** Error Info				*/
	private String				m_errorString;
	/** Test Success			*/
	private volatile boolean	m_success = false;
	/** Sync					*/
	private volatile boolean	m_testing = false;

	/** Translation				*/
	static ResourceBundle 		res = ResourceBundle.getBundle("org.compiere.install.SetupRes");

	/** Status Bar				*/
	private JLabel 				m_statusBar;
	/**	Configuration Data		*/
	private ConfigurationData	m_data = new ConfigurationData(this);

	private static ImageIcon iOpen = new ImageIcon(ConfigurationPanel.class.getResource("openFile.gif"));
	private static ImageIcon iSave = new ImageIcon(ConfigurationPanel.class.getResource("images/Save16.gif"));
	private static ImageIcon iHelp = new ImageIcon(ConfigurationPanel.class.getResource("images/Help16.gif"));


	//	-------------	Static UI
	private GridBagLayout gridBagLayout = new GridBagLayout();
	private static final int	FIELDLENGTH = 15;
	//	Java
	private JLabel 		lJavaHome = new JLabel();
	JTextField 	fJavaHome = new JTextField(FIELDLENGTH);
	JCheckBox 	okJavaHome = new JCheckBox();
	private JButton 	bJavaHome = new JButton(iOpen);
	//	Adempiere - KeyStore
	private JLabel 		lAdempiereHome = new JLabel();
	JTextField 	fAdempiereHome = new JTextField(FIELDLENGTH);
	JCheckBox 	okAdempiereHome = new JCheckBox();
	private JButton 	bAdempiereHome = new JButton(iOpen);
	private JLabel 		lKeyStore = new JLabel();
	JPasswordField 	fKeyStore = new JPasswordField();
	JCheckBox 	okKeyStore = new JCheckBox();
	//	Apps Server  - Type
	JLabel lAppsServer = new JLabel();
	JTextField fAppsServer = new JTextField(FIELDLENGTH);
	JCheckBox okAppsServer = new JCheckBox();
	//	Web Ports
	private JLabel lWebPort = new JLabel();
	JTextField fWebPort = new JTextField(FIELDLENGTH);
	JCheckBox okWebPort = new JCheckBox();
	private JLabel lSSLPort = new JLabel();
	JTextField fSSLPort = new JTextField(FIELDLENGTH);
	JCheckBox okSSLPort = new JCheckBox();
	//	Database
	private JLabel lDatabaseType = new JLabel();
	JComboBox fDatabaseType = new JComboBox(ConfigurationData.DBTYPE);
	//
	JLabel lDatabaseServer = new JLabel();
	JTextField fDatabaseServer = new JTextField(FIELDLENGTH);
	private JLabel lDatabaseName = new JLabel();
	JTextField fDatabaseName = new JTextField(FIELDLENGTH);
	private JLabel lDatabaseDiscovered = new JLabel();
	JComboBox fDatabaseDiscovered = new JComboBox();
	private JLabel lDatabasePort = new JLabel();
	JTextField fDatabasePort = new JTextField(FIELDLENGTH);
	private JLabel lSystemPassword = new JLabel();
	JPasswordField fSystemPassword = new JPasswordField();
	private JLabel lDatabaseUser = new JLabel();
	JTextField fDatabaseUser = new JTextField(FIELDLENGTH);
	private JLabel lDatabasePassword = new JLabel();
	JPasswordField fDatabasePassword = new JPasswordField();
	public JCheckBox okDatabaseServer = new JCheckBox();
	public JCheckBox okDatabaseUser = new JCheckBox();
	public JCheckBox okDatabaseSystem = new JCheckBox();
	public JCheckBox okDatabaseSQL = new JCheckBox();
	//
	JLabel lMailServer = new JLabel();
	JTextField fMailServer = new JTextField(FIELDLENGTH);
	private JLabel lAdminEMail = new JLabel();
	JTextField fAdminEMail = new JTextField(FIELDLENGTH);
	private JLabel lMailUser = new JLabel();
	JTextField fMailUser = new JTextField(FIELDLENGTH);
	private JLabel lMailPassword = new JLabel();
	JPasswordField fMailPassword = new JPasswordField();
	JCheckBox okMailServer = new JCheckBox();
	JCheckBox okMailUser = new JCheckBox();
	//
	private JButton bHelp = new JButton(iHelp);
	private JButton bTest = new JButton();
	private JButton bSave = new JButton(iSave);


	/**
	 * 	Static Layout Init
	 *  @throws Exception
	 */
	private void jbInit() throws Exception
	{
		this.setLayout(gridBagLayout);
		Insets bInsets = new Insets(0, 5, 0, 5);
		TitledBorder titledBorder = new TitledBorder("dummy");

		//	Java
		lJavaHome.setToolTipText(res.getString("JavaHomeInfo"));
		lJavaHome.setText(res.getString("JavaHome"));
		fJavaHome.setText(".");
		okJavaHome.setEnabled(false);
		bJavaHome.setMargin(bInsets);
		bJavaHome.setToolTipText(res.getString("JavaHomeInfo"));

		JLabel sectionLabel = new JLabel("Java");
		sectionLabel.setForeground(titledBorder.getTitleColor());
		JSeparator separator = new JSeparator();
		this.add(sectionLabel,    new GridBagConstraints(0, 0, 7, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(15, 5, 0, 10), 0, 0));
		this.add(separator,    new GridBagConstraints(0, 1, 7, 1, 1.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(0, 5, 0, 10), 0, 0));

		this.add(lJavaHome,    new GridBagConstraints(0, 2, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		this.add(fJavaHome,    new GridBagConstraints(1, 2, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(5, 5, 5, 0), 0, 0));
		this.add(okJavaHome,   new GridBagConstraints(2, 2, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 0, 2, 5), 0, 0));
		this.add(bJavaHome,    new GridBagConstraints(3, 2, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 0, 0, 0), 0, 0));
		//	AdempiereHome - KeyStore
		lAdempiereHome.setToolTipText(res.getString("AdempiereHomeInfo"));
		lAdempiereHome.setText(res.getString("AdempiereHome"));
		fAdempiereHome.setText(".");
		okAdempiereHome.setEnabled(false);
		bAdempiereHome.setMargin(bInsets);
		bAdempiereHome.setToolTipText(res.getString("AdempiereHomeInfo"));
		lKeyStore.setText(res.getString("KeyStorePassword"));
		lKeyStore.setToolTipText(res.getString("KeyStorePasswordInfo"));
		fKeyStore.setText("");
		okKeyStore.setEnabled(false);

		sectionLabel = new JLabel("iDempiere");
		sectionLabel.setForeground(titledBorder.getTitleColor());
		separator = new JSeparator();
		this.add(sectionLabel,    new GridBagConstraints(0, 3, 7, 1, 0.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(15, 5, 0, 0), 0, 0));
		this.add(separator,    new GridBagConstraints(0, 4, 7, 1, 1.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(0, 5, 0, 10), 0, 0));
		this.add(lAdempiereHome,		new GridBagConstraints(0, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		this.add(fAdempiereHome,		new GridBagConstraints(1, 5, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(5, 5, 2, 0), 0, 0));
		this.add(okAdempiereHome,	new GridBagConstraints(2, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 0, 2, 5), 0, 0));
		this.add(bAdempiereHome,     new GridBagConstraints(3, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(0, 0, 0, 0), 0, 0));
		this.add(lKeyStore,  		new GridBagConstraints(4, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 0, 0, 0), 0, 0));
		this.add(fKeyStore,  		new GridBagConstraints(5, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(5, 5, 2, 0), 0, 0));
		this.add(okKeyStore,  		new GridBagConstraints(6, 5, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		//	Apps Server - Type
		lAppsServer.setToolTipText(res.getString("AppsServerInfo"));
		lAppsServer.setText(res.getString("AppsServer"));
		lAppsServer.setFont(lAppsServer.getFont().deriveFont(Font.BOLD));
		fAppsServer.setText(".");
		okAppsServer.setEnabled(false);
		sectionLabel = new JLabel(res.getString("AppsServer"));
		sectionLabel.setForeground(titledBorder.getTitleColor());
		separator = new JSeparator();
		this.add(sectionLabel,    new GridBagConstraints(0, 6, 6, 1, 0.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(15, 5, 0, 0), 0, 0));
		this.add(separator,    new GridBagConstraints(0, 7, 7, 1, 1.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(0, 5, 0, 10), 0, 0));
		this.add(lAppsServer,   new GridBagConstraints(0, 8, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		this.add(fAppsServer,   new GridBagConstraints(1, 8, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(5, 5, 2, 0), 0, 0));
		this.add(okAppsServer,  new GridBagConstraints(2, 8, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 0, 2, 5), 0, 0));
		//	Web Ports
		lWebPort.setToolTipText(res.getString("WebPortInfo"));
		lWebPort.setText(res.getString("WebPort"));
		fWebPort.setText(".");
		okWebPort.setEnabled(false);
		lSSLPort.setText("SSL");
		fSSLPort.setText(".");
		okSSLPort.setEnabled(false);
		this.add(lWebPort,   new GridBagConstraints(0, 10, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fWebPort,   new GridBagConstraints(1, 10, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(2, 5, 2, 0), 0, 0));
		this.add(okWebPort,  new GridBagConstraints(2, 10, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 0, 2, 5), 0, 0));
		this.add(lSSLPort,   new GridBagConstraints(4, 10, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fSSLPort,   new GridBagConstraints(5, 10, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(2, 5, 2, 0), 0, 0));
		this.add(okSSLPort,  new GridBagConstraints(6, 10, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 0, 2, 5), 0, 0));
		//	Database Server - Type
		lDatabaseServer.setToolTipText(res.getString("DatabaseServerInfo"));
		lDatabaseServer.setText(res.getString("DatabaseServer"));
		lDatabaseServer.setFont(lDatabaseServer.getFont().deriveFont(Font.BOLD));
		okDatabaseServer.setEnabled(false);
		lDatabaseType.setToolTipText(res.getString("DatabaseTypeInfo"));
		lDatabaseType.setText(res.getString("DatabaseType"));
		fDatabaseType.setPreferredSize(fDatabaseServer.getPreferredSize());
		sectionLabel = new JLabel(res.getString("DatabaseServer"));
		sectionLabel.setForeground(titledBorder.getTitleColor());
		separator = new JSeparator();
		this.add(sectionLabel,    new GridBagConstraints(0, 11, 6, 1, 0.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(15, 5, 0, 0), 0, 0));
		this.add(separator,    new GridBagConstraints(0, 12, 7, 1, 1.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(0, 5, 0, 10), 0, 0));
		this.add(lDatabaseServer,	new GridBagConstraints(0, 13, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		this.add(fDatabaseServer,   new GridBagConstraints(1, 13, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(5, 5, 2, 0), 0, 0));
		this.add(okDatabaseServer,  new GridBagConstraints(2, 13, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 0, 2, 5), 0, 0));
		this.add(lDatabaseType,		new GridBagConstraints(4, 13, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		this.add(fDatabaseType,     new GridBagConstraints(5, 13, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(5, 5, 2, 0), 0, 0));
		//Database/Service Name
		lDatabaseName.setToolTipText(res.getString("DatabaseNameInfo"));
		lDatabaseName.setText(res.getString("DatabaseName"));
		fDatabaseName.setText(".");

		//TNS/Native connection
		lDatabaseDiscovered.setToolTipText(res.getString("TNSNameInfo"));
		lDatabaseDiscovered.setText(res.getString("TNSName"));
		fDatabaseDiscovered.setEditable(true);
		fDatabaseDiscovered.setPreferredSize(fDatabaseName.getPreferredSize());
		okDatabaseSQL.setEnabled(false);
		this.add(lDatabaseName,		new GridBagConstraints(0, 14, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fDatabaseName,		new GridBagConstraints(1, 14, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(2, 5, 2, 0), 0, 0));
		this.add(okDatabaseSQL, 		new GridBagConstraints(2, 14, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 0, 2, 5), 0, 0));
		this.add(lDatabaseDiscovered,  	new GridBagConstraints(4, 14, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 0, 2, 5), 0, 0));
		this.add(fDatabaseDiscovered,  	new GridBagConstraints(5, 14, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(2, 5, 2, 0), 0, 0));
		//	Port - System
		lDatabasePort.setToolTipText(res.getString("DatabasePortInfo"));
		lDatabasePort.setText(res.getString("DatabasePort"));
		fDatabasePort.setText(".");
		lSystemPassword.setToolTipText(res.getString("SystemPasswordInfo"));
		lSystemPassword.setText(res.getString("SystemPassword"));
		fSystemPassword.setText(".");
		okDatabaseSystem.setEnabled(false);
		this.add(lDatabasePort,		new GridBagConstraints(0, 15, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fDatabasePort,     new GridBagConstraints(1, 15, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(2, 5, 2, 0), 0, 0));
		this.add(lSystemPassword,   new GridBagConstraints(4, 15, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fSystemPassword,   new GridBagConstraints(5, 15, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(2, 5, 2, 0), 0, 0));
		this.add(okDatabaseSystem,	new GridBagConstraints(6, 15, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 0, 2, 5), 0, 0));

		//	User - Password
		lDatabaseUser.setToolTipText(res.getString("DatabaseUserInfo"));
		lDatabaseUser.setText(res.getString("DatabaseUser"));
		fDatabaseUser.setText(".");
		lDatabasePassword.setToolTipText(res.getString("DatabasePasswordInfo"));
		lDatabasePassword.setText(res.getString("DatabasePassword"));
		fDatabasePassword.setText(".");
		okDatabaseUser.setEnabled(false);
		this.add(lDatabaseUser,     new GridBagConstraints(0, 16, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fDatabaseUser,		new GridBagConstraints(1, 16, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(2, 5, 2, 0), 0, 0));
		this.add(lDatabasePassword, new GridBagConstraints(4, 16, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fDatabasePassword, new GridBagConstraints(5, 16, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(2, 5, 2, 0), 0, 0));
		this.add(okDatabaseUser,	new GridBagConstraints(6, 16, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 0, 2, 5), 0, 0));

		sectionLabel = new JLabel(res.getString("MailServer"));
		sectionLabel.setForeground(titledBorder.getTitleColor());
		separator = new JSeparator();
		this.add(sectionLabel,    new GridBagConstraints(0, 17, 6, 1, 0.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(15, 5, 0, 0), 0, 0));
		this.add(separator,    new GridBagConstraints(0, 18, 7, 1, 1.0, 0.0
				,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(0, 5, 0, 10), 0, 0));
		//	Mail Server - Email
		lMailServer.setToolTipText(res.getString("MailServerInfo"));
		lMailServer.setText(res.getString("MailServer"));
		lMailServer.setFont(lMailServer.getFont().deriveFont(Font.BOLD));
		fMailServer.setText(".");
		lAdminEMail.setToolTipText(res.getString("AdminEMailInfo"));
		lAdminEMail.setText(res.getString("AdminEMail"));
		fAdminEMail.setText(".");
		okMailServer.setEnabled(false);
		this.add(lMailServer,   new GridBagConstraints(0, 19, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		this.add(fMailServer,   new GridBagConstraints(1, 19, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(5, 5, 2, 0), 0, 0));
		this.add(okMailServer,	new GridBagConstraints(2, 19, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(5, 0, 2, 5), 0, 0));
		this.add(lAdminEMail,   new GridBagConstraints(4, 19, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(5, 5, 2, 5), 0, 0));
		this.add(fAdminEMail,   new GridBagConstraints(5, 19, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(5, 5, 2, 0), 0, 0));

		//	Mail User = Password
		lMailUser.setToolTipText(res.getString("MailUserInfo"));
		lMailUser.setText(res.getString("MailUser"));
		fMailUser.setText(".");
		lMailPassword.setToolTipText(res.getString("MailPasswordInfo"));
		lMailPassword.setText(res.getString("MailPassword"));
		fMailPassword.setText(".");
		okMailUser.setEnabled(false);
		this.add(lMailUser,		new GridBagConstraints(0, 20, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fMailUser,     new GridBagConstraints(1, 20, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.BOTH, new Insets(2, 5, 2, 0), 0, 0));
		this.add(lMailPassword, new GridBagConstraints(4, 20, 1, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(2, 5, 2, 5), 0, 0));
		this.add(fMailPassword, new GridBagConstraints(5, 20, 1, 1, 0.5, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.HORIZONTAL, new Insets(2, 5, 2, 0), 0, 0));
		this.add(okMailUser,	new GridBagConstraints(6, 20, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(2, 0, 2, 5), 0, 0));

		//grap extra space when window is maximized
		JPanel filler = new JPanel();
		filler.setOpaque(false);
		filler.setBorder(null);
		this.add(filler,    		new GridBagConstraints(0, 21, 1, 1, 0.0, 1.0
				,GridBagConstraints.WEST, GridBagConstraints.VERTICAL, new Insets(0, 0, 0, 0), 0, 0));

		//	End
		bTest.setToolTipText(res.getString("TestInfo"));
		bTest.setText(res.getString("Test"));
		bSave.setToolTipText(res.getString("SaveInfo"));
		bSave.setText(res.getString("Save"));
		bHelp.setToolTipText(res.getString("HelpInfo"));
		this.add(bTest,    		new GridBagConstraints(0, 22, 1, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(15, 5, 10, 5), 0, 0));
		this.add(bHelp,         new GridBagConstraints(3, 22, 2, 1, 0.0, 0.0
			,GridBagConstraints.WEST, GridBagConstraints.NONE, new Insets(15, 5, 10, 5), 0, 0));
		this.add(bSave,         new GridBagConstraints(5, 22, 2, 1, 0.0, 0.0
			,GridBagConstraints.EAST, GridBagConstraints.NONE, new Insets(15, 5, 10, 5), 0, 0));
		//
		bAdempiereHome.addActionListener(this);
		bJavaHome.addActionListener(this);
		fDatabaseType.addActionListener(this);
		fDatabaseDiscovered.addActionListener(this);
		bHelp.addActionListener(this);
		bTest.addActionListener(this);
		bSave.addActionListener(this);
	}	//	jbInit

	/**
	 * 	Dynamic Initial.
	 * 	Called by Setup
	 *	@return true if success
	 */
	public boolean dynInit()
	{
		return m_data.load();
	}	//	dynInit

	/**
	 * 	Set Status Bar Text
	 *	@param text text
	 */
	protected void setStatusBar(String text)
	{
		m_statusBar.setText(text);
	}	//	setStatusBar


	/**************************************************************************
	 * 	ActionListener
	 *  @param e event
	 */
	public void actionPerformed(ActionEvent e)
	{
		if (m_testing)
			return;
		//	TNS Name Changed
		if (e.getSource() == fDatabaseDiscovered)
		{
			String dbName = (String)fDatabaseDiscovered.getSelectedItem();
			if (dbName != null && dbName.length() > 0)
				fDatabaseName.setText(m_data.resolveDatabaseName(dbName));
		}
		//
		else if (e.getSource() == fDatabaseType)
			m_data.initDatabase("");
		//
		else if (e.getSource() == bJavaHome)
			setPath (fJavaHome);
		else if (e.getSource() == bAdempiereHome)
			setPath (fAdempiereHome);
		else if (e.getSource() == bHelp)
			new Setup_Help((Frame)SwingUtilities.getWindowAncestor(this));
		else if (e.getSource() == bTest)
			startTest(false);
		else if (e.getSource() == bSave)
			startTest(true);
	}	//	actionPerformed



	/**
	 * 	Set Path in Field
	 * 	@param field field to set Path
	 */
	private void setPath (JTextField field)
	{
		JFileChooser fc = new JFileChooser(field.getText());
		fc.setDialogType(JFileChooser.OPEN_DIALOG);
		fc.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		fc.setMultiSelectionEnabled(false);
		fc.setDialogTitle(field.getToolTipText());
		if (fc.showOpenDialog(this) == JFileChooser.APPROVE_OPTION)
			field.setText(fc.getSelectedFile().getAbsolutePath());
	}	//	setPath


	/**************************************************************************
	 * 	Start Test Async.
	 * 	@param saveIt save
	 *  @return SwingWorker
	 */
	private org.compiere.install.util.SwingWorker startTest(final boolean saveIt)
	{
		org.compiere.install.util.SwingWorker worker = new org.compiere.install.util.SwingWorker()
		{
			//	Start it
			public Object construct()
			{
				m_testing = true;
				setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
				bTest.setEnabled(false);
				m_success = false;
				m_errorString = null;
				try
				{
					test();
				}
				catch (Exception ex)
				{
					ex.printStackTrace();
					m_errorString += "\n" + ex.toString();
				}
				//
				setCursor(Cursor.getDefaultCursor());
				if (m_errorString == null)
					m_success = true;
				bTest.setEnabled(true);
				m_testing = false;
				return new Boolean(m_success);
			}
			//	Finish it
			public void finished()
			{
				if (m_errorString != null)
				{
					CLogger.get().severe(m_errorString);
					JOptionPane.showConfirmDialog (m_statusBar.getParent(),
						m_errorString,
						res.getString("ServerError"),
						JOptionPane.DEFAULT_OPTION, JOptionPane.ERROR_MESSAGE);
				}
				else if (saveIt)
					save();
			}
		};
		worker.start();
		return worker;
	}	//	startIt

	/**
	 *	Test it
	 * 	@throws Exception
	 */
	private void test() throws Exception
	{
		bSave.setEnabled(false);
		if (!m_data.test(this))
			return;
		//
		m_statusBar.setText(res.getString("Ok"));
		bSave.setEnabled(true);
		m_errorString = null;
	}	//	test

	/**
	 * 	UI Signal OK
	 *	@param cb check box
	 *	@param resString resource string key
	 *	@param pass true if test passed
	 *	@param critical true if critical
	 *	@param errorMsg error Message
	 */
	void signalOK (JCheckBox cb, String resString,
		boolean pass, boolean critical, String errorMsg)
	{
		m_errorString = res.getString(resString);
		cb.setSelected(pass);
		if (pass)
			cb.setToolTipText(null);
		else
		{
			cb.setToolTipText(errorMsg);
			m_errorString += " \n(" + errorMsg + ")";
		}
		if (!pass && critical)
			cb.setBackground(Color.RED);
		else
			cb.setBackground(Color.GREEN);
	}	//	setOK


	/**************************************************************************
	 * 	Save Settings.
	 * 	Called from startTest.finished()
	 */
	private void save()
	{
		if (!m_success)
			return;

		bSave.setEnabled(false);
		bTest.setEnabled(false);
		setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));

		if (!m_data.save())
			return;

		//	To be sure
		((Frame)SwingUtilities.getWindowAncestor(this)).dispose();
//		System.exit(0);		//	remains active when License Dialog called
		/** **/
	}	//	save

	/* (non-Javadoc)
	 * @see org.adempiere.install.IDBConfigMonitor#update(org.adempiere.install.DBConfigStatus)
	 */
	@Override
	public void update(DBConfigStatus status) {
		if (status.getStatusType().equals(DBConfigStatus.DATABASE_SERVER))
		{
			signalOK(okDatabaseServer, status.getResourseString(),
					status.isPass(), status.isCritical(), status.getErrorMessage());
		}
		else if (status.getStatusType().equals(DBConfigStatus.DATABASE_SYSTEM_PASSWORD))
		{
			signalOK(okDatabaseSystem, status.getResourseString(), status.isPass(),
					status.isCritical(), status.getErrorMessage());
		}
		else if (status.getStatusType().equals(DBConfigStatus.DATABASE_USER))
		{
			signalOK(okDatabaseUser, status.getResourseString(), status.isPass(),
					status.isCritical(), status.getErrorMessage());
		}
		else if (status.getStatusType().equals(DBConfigStatus.DATABASE_SQL_TEST))
		{
			signalOK(okDatabaseSQL, status.getResourseString(), status.isPass(),
					status.isCritical(), status.getErrorMessage());
		}
	}

}	//	ConfigurationPanel
