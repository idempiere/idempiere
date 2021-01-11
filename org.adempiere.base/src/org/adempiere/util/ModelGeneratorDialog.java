/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.util;

import java.awt.BorderLayout;
import java.awt.Cursor;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.Panel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;

import org.compiere.Adempiere;

/**
 *
 * @author hengsin
 *
 */
public class ModelGeneratorDialog extends JFrame implements ActionListener {

	/**
	 * default generated serial version Id
	 */
	private static final long serialVersionUID = 3546051609729699491L;
	private JButton bGenerate;
	private JButton bCancel;
	private JButton bFolder;
	private JTextField fFolderName;
	private JTextField fPackageName;
	private JTextField fTableName;
	private JCheckBox fGenerateInterface;
	private JCheckBox fGenerateClass;
	private JTextField fEntityType;
	private JTextField fColumnEntityType;

	public ModelGeneratorDialog() {
		super();
		setTitle("Model Class Generator");
		BorderLayout layout = new BorderLayout();
		this.getContentPane().setLayout(layout);
		Panel confirmPanel = new Panel();
		this.getContentPane().add(confirmPanel, BorderLayout.SOUTH);
		Panel mainPanel = new Panel();
		this.getContentPane().add(mainPanel, BorderLayout.CENTER);
		mainPanel.setLayout(new GridBagLayout());

		Panel filePanel = new Panel();
		filePanel.setLayout(new BorderLayout());
		String defaultPath = Adempiere.getAdempiereHome() + File.separator + "org.adempiere.base" + File.separator + "src";
		fFolderName = new JTextField(defaultPath);
		filePanel.add(fFolderName, BorderLayout.CENTER);
		bFolder = new JButton("...");
		bFolder.setMargin(new Insets(0, 0, 0, 0));
		filePanel.add(bFolder, BorderLayout.EAST);
		mainPanel.add(new JLabel("Source Folder"), makeGbc(0, 0));
		mainPanel.add(filePanel, makeGbc(1, 0));
		bFolder.addActionListener(this);

		mainPanel.add(new JLabel("Package Name"), makeGbc(0, 1));
		fPackageName = new JTextField("org.compiere.model");
		mainPanel.add(fPackageName, makeGbc(1, 1));

		mainPanel.add(new JLabel("Table Name"), makeGbc(0, 2));
		fTableName = new JTextField("AD_ReplaceThis%");
		mainPanel.add(fTableName, makeGbc(1, 2));

		mainPanel.add(new JLabel("Table Entity Type"), makeGbc(0, 3));
		fEntityType = new JTextField("D");
		mainPanel.add(fEntityType, makeGbc(1, 3));
		
		mainPanel.add(new JLabel("Column Entity Type"), makeGbc(0, 4));
		fColumnEntityType = new JTextField("");
		mainPanel.add(fColumnEntityType, makeGbc(1, 4));

		Panel chkPanel = new Panel();
		chkPanel.setLayout(new GridLayout(1, 2));
		mainPanel.add(new JLabel(""), makeGbc(0, 5));
		mainPanel.add(chkPanel, makeGbc(1, 5));
		fGenerateInterface = new JCheckBox("Generate Interface");
		fGenerateInterface.setSelected(true);
		chkPanel.add(fGenerateInterface);
		fGenerateClass = new JCheckBox("Generate Class");
		fGenerateClass.setSelected(true);
		chkPanel.add(fGenerateClass);

		bGenerate = new JButton("Generate Source");
		confirmPanel.add(bGenerate);
		bCancel = new JButton("Cancel");
		confirmPanel.add(bCancel);
		bGenerate.addActionListener(this);
		bCancel.addActionListener(this);
	}

	private GridBagConstraints makeGbc(int x, int y) {
		GridBagConstraints gbc = new GridBagConstraints();
		gbc.gridwidth = 1;
		gbc.gridheight = 1;
		gbc.gridx = x;
		gbc.gridy = y;
		gbc.weightx = x;
		gbc.weighty = 1.0;
		gbc.insets = new Insets(2, 2, 2, 2);
		gbc.anchor = (x == 0) ? GridBagConstraints.LINE_START : GridBagConstraints.LINE_END;
		gbc.fill = GridBagConstraints.HORIZONTAL;
		return gbc;
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == bGenerate) {
			String folder = fFolderName.getText();
			if (folder == null || folder.trim().length() == 0) {
				JOptionPane.showMessageDialog(this, "Please enter source folder name", "Error", JOptionPane.ERROR_MESSAGE);
				return;
			}
			String packageName = fPackageName.getText();
			if (packageName == null || packageName.trim().length() == 0) {
				JOptionPane.showMessageDialog(this, "Please enter package name", "Error", JOptionPane.ERROR_MESSAGE);
				return;
			}
			String tableName = fTableName.getText();
			if (tableName == null || tableName.trim().length() == 0) {
				JOptionPane.showMessageDialog(this, "Please enter table name", "Error", JOptionPane.ERROR_MESSAGE);
				return;
			}
			String entityType = fEntityType.getText();
			if (entityType == null || entityType.trim().length() == 0) {
				JOptionPane.showMessageDialog(this, "Please enter entity type", "Error", JOptionPane.ERROR_MESSAGE);
				return;
			}
			if (!fGenerateClass.isSelected() && !fGenerateInterface.isSelected()) {
				JOptionPane.showMessageDialog(this, "Must select at least one of generate interface or generate class", "Error", JOptionPane.ERROR_MESSAGE);
				return;
			}
			String columnEntityType = fColumnEntityType.getText();
			this.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
			if (fGenerateInterface.isSelected()) {
				ModelInterfaceGenerator.generateSource(folder, packageName, entityType, tableName, columnEntityType);
			}
			if (fGenerateClass.isSelected()) {
				ModelClassGenerator.generateSource(folder, packageName, entityType, tableName, columnEntityType);
			}			
			this.dispose();
		} else if (e.getSource() == bCancel) {
			this.dispose();
		} else if (e.getSource() == bFolder) {
			JFileChooser fileChooser = new JFileChooser();
			fileChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
			int state = fileChooser.showOpenDialog(this);
			if (state == JFileChooser.APPROVE_OPTION) {
				fFolderName.setText(fileChooser.getSelectedFile().getAbsolutePath());
			}
		}
	}

}
