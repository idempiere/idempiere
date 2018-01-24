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
package org.compiere.grid.ed;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Frame;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.logging.Level;

import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JSplitPane;
import javax.swing.JTabbedPane;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import org.adempiere.plaf.AdempierePLAF;
import org.compiere.apps.AEnv;
import org.compiere.apps.ConfirmPanel;
import org.compiere.apps.StatusBar;
import org.compiere.model.MPostIt;
import org.compiere.swing.CDialog;
import org.compiere.swing.CMenuItem;
import org.compiere.swing.CPanel;
import org.compiere.swing.CTextArea;
import org.compiere.swing.CTextPane;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *  Post-it, bas� sur Editor
 *
 * 	@author Nico
 */
public class VPostIt extends CDialog implements ChangeListener, ActionListener, KeyListener
{
	private static final long serialVersionUID = -8314686583942866712L;

	/**
	 *	Standard constructor
	 *	@param frame parent
	 *	@param header heading
	 *	@param postItID
	 *	@param tableID
	 *	@param recordID
	 *	@param trxName
	 */
	public VPostIt(Frame frame, String header, int postItID, int tableID, int recordID, String trxName)
	{
		super (frame, header, frame != null);
		try
		{
			jbInit();
			setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "", ex);
		}

		if (postItID > 0)
			m_postIt = new MPostIt (Env.getCtx(), postItID, trxName);
		else
			m_postIt = new MPostIt (Env.getCtx(), tableID, recordID, trxName);

		//	Set Text
		textArea.setText(m_postIt.getText());
		textArea.setEditable(true);
		textArea.setBackground(AdempierePLAF.getFieldBackground_Normal());
		textPane.setBackground(AdempierePLAF.getFieldBackground_Inactive());

		String createdupdated = null;
		if (m_postIt.getAD_PostIt_ID() > 0)
			createdupdated = m_postIt.getCreatedString();
		String updated = m_postIt.getUpdatedString();

		if (!updated.equals(""))
			createdupdated += "\n" + updated;

		modifText.setText(createdupdated);
		modifText.setReadWrite(false);

		updateStatusBar();

		try
		{
			AEnv.showCenterWindow(frame, this);
		}
		catch (Exception e)
		{
		}
		modifText.requestFocus();
	}	//	Editor

	/** Maximum Size		*/
	private int			m_maxSize = 2000; 
	/**	Logger				*/
	private static CLogger log = CLogger.getCLogger(VPostIt.class);

	private CPanel panel = new CPanel();
	private BorderLayout panelLayout = new BorderLayout();
	private JTabbedPane tabbedPane = new JTabbedPane();
	private CTextArea textArea = new CTextArea();
	private CTextPane textPane = new CTextPane();
	private JMenuBar menuBar = new JMenuBar();
	private JMenu mFile = new JMenu();
	private CMenuItem mImport = new CMenuItem();
	private CMenuItem mExport = new CMenuItem();
	private ConfirmPanel confirmPanel = new ConfirmPanel();
	private StatusBar statusBar = new StatusBar(false);
	private CTextArea modifText = new CTextArea();
	private MPostIt m_postIt = null;

	/**
	 *	Static Init
	 * 	@throws Exception
	 */
	private void jbInit() throws Exception
	{
		panel.setLayout(panelLayout);
		this.setJMenuBar(menuBar);
		//	Text Tab
		textArea.setPreferredSize(new Dimension(500, 300));
		textArea.setWrapStyleWord(true);
		textArea.setLineWrap(true);
		tabbedPane.add(textArea, "Text");
		textArea.addKeyListener(this);
		//	HTML Tab
		textPane.setContentType("text/html");
		textPane.setEditable(false);
		tabbedPane.add(textPane, "HTML");
		//
		// Traduction de File � partir du message File ; cf org.compiere.apps.AEnv.getMenu(String)
		String textFile = Msg.getMsg(Env.getCtx(), "File");
		int pos = textFile.indexOf('&');
		if (pos != -1 && textFile.length() > pos)	//	We have a nemonic
		{
			char ch = textFile.toUpperCase().charAt(pos+1);
			if (ch != ' ')
				textFile = textFile.substring(0, pos) + textFile.substring(pos+1);
		}
		mFile.setText(textFile);
		mImport.setText(Msg.getMsg(Env.getCtx(), "Import"));
		mImport.addActionListener(this);
		mExport.setText(Msg.getMsg(Env.getCtx(), "Export"));
		mExport.addActionListener(this);
		tabbedPane.addChangeListener(this);

		modifText.setPreferredSize(new Dimension(500,50));
		JSplitPane textPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, true, tabbedPane, modifText);
		panel.add(textPane, BorderLayout.CENTER);

		confirmPanel.addActionListener(this);
		panel.add(confirmPanel, BorderLayout.SOUTH);
		this.getContentPane().add(panel, BorderLayout.CENTER);
		this.getContentPane().add(statusBar, BorderLayout.SOUTH);
		//
		menuBar.add(mFile);
		mFile.add(mImport);
		mFile.add(mExport);
		updateStatusBar();
	}	//	jbInit

	/**
	 *	ActionListener
	 * 	@param e event
	 */
	public void actionPerformed(ActionEvent e)
	{
		if (e.getActionCommand().equals(ConfirmPanel.A_OK))
		{
			m_postIt.setText(textArea.getText());
			m_postIt.saveEx();
			log.fine("OK - length=" + textArea.getText().length());
			dispose();
		}
		else if (e.getActionCommand().equals(ConfirmPanel.A_CANCEL))
			dispose();
		else if (e.getSource() == mImport)
			importText();
		else if (e.getSource() == mExport)
			exportText();
	}	//	actionPerformed

	/**
	 * 	Update Status Bar
	 */
	private void updateStatusBar()
	{
		String str = textArea.getText();
		int length = str.length();
		statusBar.setStatusDB(length);
		int size = length;
		try
		{
			size = str.getBytes("UTF-8").length;
		}
		catch (UnsupportedEncodingException e)
		{
			log.log(Level.SEVERE, str, e);
		}

		if (m_maxSize == 0)
			statusBar.setStatusLine(String.valueOf(size));
		else if (size < m_maxSize)
			statusBar.setStatusLine(size + " < " + m_maxSize, false);
		else if (size == m_maxSize)
			statusBar.setStatusLine(size + " = " + m_maxSize, false);
		else
		{
			statusBar.setStatusLine(size + " > " + m_maxSize, true);
			Toolkit.getDefaultToolkit().beep();
		}
	}	//	updateStatusBar

	/**
	 *	Import Text from File
	 */
	private void importText()
	{
		JFileChooser jc = new JFileChooser();
		jc.setDialogTitle(Msg.getMsg(Env.getCtx(), "ImportText"));
		jc.setDialogType(JFileChooser.OPEN_DIALOG);
		jc.setFileSelectionMode(JFileChooser.FILES_ONLY);
		//
		if (jc.showOpenDialog(this) != JFileChooser.APPROVE_OPTION)
			return;

		StringBuffer sb = new StringBuffer();
		try
		{
			InputStreamReader in = new InputStreamReader (new FileInputStream (jc.getSelectedFile()));
			char[] cbuf = new char[1024];
			int count;
			while ((count = in.read(cbuf)) > 0)
				sb.append(cbuf, 0, count);
			in.close();
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, e.getMessage());
			return;
		}
		textArea.setText(sb.toString());
		updateStatusBar();
	}	//	importText

	/**
	 *	Export Text to File
	 */
	private void exportText()
	{
		JFileChooser jc = new JFileChooser();
		jc.setDialogTitle(Msg.getMsg(Env.getCtx(), "ExportText"));
		jc.setDialogType(JFileChooser.SAVE_DIALOG);
		jc.setFileSelectionMode(JFileChooser.FILES_ONLY);
		//
		if (jc.showSaveDialog(this) != JFileChooser.APPROVE_OPTION)
			return;

		try
		{
			BufferedWriter bout = new BufferedWriter (new OutputStreamWriter (new FileOutputStream (jc.getSelectedFile())));
			bout.write(textArea.getText());
			bout.flush();
			bout.close();
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, e.getMessage());
		}
	}	//	exportText

	/**
	 *	ChangeListener for TabbedPane
	 * 	@param e event
	 */
	public void stateChanged(ChangeEvent e)
	{
		if (tabbedPane.getSelectedIndex() == 1)		//	switch to HTML
			textPane.setText(textArea.getText());
	}	//	stateChanged

	public void keyTyped (KeyEvent e)
	{
	}

	public void keyPressed (KeyEvent e)
	{
	}

	public void keyReleased (KeyEvent e)
	{
		updateStatusBar();
	}

}	//	VPostIt