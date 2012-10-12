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

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import org.compiere.install.util.AEnv;
import org.compiere.install.util.ALayout;
import org.compiere.install.util.ALayoutConstraint;
import org.compiere.install.util.ConfirmPanel;


/**
 *	Key Store Dialog
 *	
 *  @author Jorg Janke
 *  @version $Id: KeyStoreDialog.java,v 1.3 2006/07/30 00:57:42 jjanke Exp $
 */
public class KeyStoreDialog extends JDialog implements ActionListener
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 6114800010246854563L;

	/**
	 * 	Constructor
	 * 	@param owner frame
	 *	@param cn common name
	 *	@param ou org unit
	 *	@param o organization
	 *	@param l locale
	 *	@param s state
	 *	@param c country
	 *	@throws HeadlessException
	 */
	public KeyStoreDialog (JFrame owner,
		String cn, String ou, String o, String l, String s, String c)
		throws HeadlessException
	{
		super (owner, true);
		setTitle("Key Store Dialog");
		//
		jbInit();
		setValues(cn, ou, o, l, s, c);
		//
		AEnv.showCenterWindow(owner, this);
	}	//	KeyStoreDialog

	private JLabel 		lCN = new JLabel("(ON) Common Name");
	private JTextField 	fCN = new JTextField(20);
	private JLabel 		lOU = new JLabel("(OU) Organization Unit");
	private JTextField 	fOU = new JTextField(20);
	private JLabel 		lO = new JLabel("(O) Organization");
	private JTextField 	fO = new JTextField(20);
	private JLabel 		lL = new JLabel("(L) Locale/Town");
	private JTextField 	fL = new JTextField(20);
	private JLabel 		lS = new JLabel("(S) State");
	private JTextField 	fS = new JTextField(20);
	private JLabel 		lC = new JLabel("(C) Country (2 Char)");
	private JTextField 	fC = new JTextField(2);
	// Invert OK/Cancel IDEMPIERE-77
	private JButton		bOK = ConfirmPanel.createOKButton("");
	private JButton		bCancel = ConfirmPanel.createCancelButton("");
	private boolean		m_ok = false;
	
	

	
	/**
	 * 	Static Layout
	 */
	private void jbInit()
	{
		JPanel panel = new JPanel(new ALayout());
		panel.add(lCN, new ALayoutConstraint(0, 0));
		panel.add(fCN, null);
		panel.add(lOU, new ALayoutConstraint(1, 0));
		panel.add(fOU, null);
		panel.add(lO, new ALayoutConstraint(2, 0));
		panel.add(fO, null);
		panel.add(lL, new ALayoutConstraint(3, 0));
		panel.add(fL, null);
		panel.add(lS, new ALayoutConstraint(4, 0));
		panel.add(fS, null);
		panel.add(lC, new ALayoutConstraint(5, 0));
		panel.add(fC, null);
		panel.setPreferredSize(new Dimension(400,150));
		//
		getContentPane().setLayout(new BorderLayout());
		getContentPane().add (panel, BorderLayout.CENTER);
		//
		JPanel confirmPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
		// Invert OK/Cancel IDEMPIERE-77
		confirmPanel.add(bOK);
		confirmPanel.add(bCancel);
		getContentPane().add (confirmPanel, BorderLayout.SOUTH);
		//
		bOK.addActionListener(this);
		bCancel.addActionListener(this);

	}	//	jbInit
	
	/**
	 * 	Action Listener
	 *	@param e evt
	 */
	public void actionPerformed (ActionEvent e)
	{
		if (e.getSource() == bOK)
			m_ok = true;
		dispose();
	}	//	actionPerformed
	
	/**
	 * 	OK Pressed
	 *	@return true if OK
	 */
	public boolean isOK()
	{
		return m_ok;
	}	//	isOK
	
	/**
	 * 	Set Values
	 *	@param cn common name
	 *	@param ou org unit
	 *	@param o organization
	 *	@param l locale
	 *	@param s state
	 *	@param c country
	 */
	public void setValues(String cn, String ou, String o, String l, String s, String c)
	{
		fCN.setText(cn);
		fOU.setText(ou);
		fO.setText(o);
		fL.setText(l);
		fS.setText(s);
		fC.setText(c);
	}	//	setValues

	/**
	 * 	Get CN
	 *	@return common name
	 */
	public String getCN()
	{
		return fCN.getText();
	}
	/**
	 * 	Get OU
	 *	@return organizational unit
	 */
	public String getOU()
	{
		return fOU.getText();
	}
	/**
	 * 	Get O
	 *	@return organization
	 */
	public String getO()
	{
		return fO.getText();
	}
	/**
	 * 	Get L
	 *	@return location/town
	 */
	public String getL()
	{
		return fL.getText();
	}
	/**
	 * 	Get S
	 *	@return state
	 */
	public String getS()
	{
		return fS.getText();
	}
	/**
	 * 	Get C
	 *	@return country
	 */
	public String getC()
	{
		return fC.getText();
	}
	
}	//	KeyStoreDialog
