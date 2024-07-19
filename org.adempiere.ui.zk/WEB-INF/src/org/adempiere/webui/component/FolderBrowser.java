/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.component;

import java.io.File;
import java.util.Arrays;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.MSysConfig;
import org.compiere.util.Ini;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 * Directory and File Browser
 * @author Elaine
 *
 */
public class FolderBrowser extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 5477614056976038703L;
	
	private Textbox txtPath = new Textbox();
	/** Listbox of folders and files */
	private Listbox listDir = new Listbox();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);

	private boolean browseForFolder = false;
	private String path;
	private File root;

	/**
	 * Default constructor
	 */
	public FolderBrowser()
	{
		this(null, false);
	}

	/**
	 * @param browseForFolder
	 */
	public FolderBrowser(boolean browseForFolder)
	{
		this(null, browseForFolder);
	}

	/**
	 * @param rootPath Optional root folder. If null, take ZK_ROOT_FOLDER_BROWSER from AD_SysConfig or iDempiere home as root folder.
	 * @param browseForFolder true for folder browser, false for file.
	 */
	public FolderBrowser(String rootPath, boolean browseForFolder)
	{
		if (Util.isEmpty(rootPath)) {
			rootPath = MSysConfig.getValue(MSysConfig.ZK_ROOT_FOLDER_BROWSER, Ini.getAdempiereHome());
		}
		root = new File(rootPath);

		this.browseForFolder = browseForFolder;

		setTitle(browseForFolder ? "Directory Browser" : "File Browser");
		ZKUpdateUtil.setWindowWidthX(this, 500);
		ZKUpdateUtil.setWindowHeightX(this, 500);
		setBorder("normal");
		
		Borderlayout contentLayout = new Borderlayout();
		appendChild(contentLayout);
		
		North north = new North();
		contentLayout.appendChild(north);
		north.appendChild(txtPath);
		
		Center center = new Center();
		contentLayout.appendChild(center);
		center.appendChild(listDir);
		ZKUpdateUtil.setVflex(listDir, "1");
		ZKUpdateUtil.setHflex(listDir, "1");
		
		South south = new South();
		south.setStyle("border: none");
		contentLayout.appendChild(south);
		south.appendChild(confirmPanel);
		
		ZKUpdateUtil.setWidth(txtPath, "475px");
		txtPath.setReadonly(true);
		
		getFileListing(root.getPath());
		listDir.setMultiple(false);
		listDir.addDoubleClickListener(this);
		listDir.addActionListener(this);

		confirmPanel.addActionListener(this);

		AEnv.showWindow(this);
	}
	
	/**
	 * Get files and folders under dirPath
	 * @param dirPath Directory path
	 */
	private void getFileListing(String dirPath)
	{		
		File dir = new File(dirPath);
		if(!dir.exists())
			return;
				
		if(dir.isDirectory())
		{
			listDir.removeAllItems();
			
			if(!dir.getParent().equals(root.getParent()))
			{
				ListItem li = new ListItem(dir.getName(), dir.getParent());
				if (ThemeManager.isUseFontIconForImage())
					((Listcell)li.getFirstChild()).setIconSclass("z-icon-Undo");
				else
					li.setImage(ThemeManager.getThemeResource("images/Undo16.png"));
				listDir.appendChild(li);
			}

			File[] files = dir.listFiles();
			Arrays.sort(files);
			
			for(File file: files)
			{
				if(file.isDirectory())
				{
					ListItem li = new ListItem(file.getName(), file.getAbsolutePath());
					if (ThemeManager.isUseFontIconForImage())
						((Listcell)li.getFirstChild()).setIconSclass("z-icon-Folder");
					else
						li.setImage(ThemeManager.getThemeResource("images/Folder16.png"));
					listDir.appendChild(li);
				}
			}

			if(!browseForFolder)
			{
				for(File file: files)
				{
					if(file.isFile())
					{
						ListItem li = new ListItem(file.getName(), file.getAbsolutePath());
						listDir.appendChild(li);
					}
				}
			}
		}
		
		txtPath.setValue(dir.getAbsolutePath());
	}
	
	@Override
	public void onEvent(Event e) throws Exception 
	{	
		if(e.getName().equals(Events.ON_DOUBLE_CLICK) && e.getTarget() instanceof ListItem)
		{
			int index = listDir.getSelectedIndex();
			if (index >= 0)
			{
				ValueNamePair vnp = listDir.getItemAtIndex(index).toValueNamePair();
				getFileListing(vnp.getValue());
			}
		}
		else if(e.getName().equals(Events.ON_SELECT) && e.getTarget() == listDir)
		{
			int index = listDir.getSelectedIndex();
			if (index >= 0)
			{
				ValueNamePair vnp = listDir.getItemAtIndex(index).toValueNamePair();
				txtPath.setValue(vnp.getValue());
			}
		}
		if(e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK))
		{
			path = txtPath.getValue();
			if(path != null)
			{
				File file = new File(path);

				if(browseForFolder)
				{
					if(!file.isDirectory() || !file.exists())
					{
						Dialog.error(0, "Invalid directory");
						return;
					}
				}
				else
				{
					if(!file.isFile() || !file.exists())
					{
						Dialog.error(0, "Invalid file");
						return;
					}
				}
				
				path = file.getAbsolutePath();
			}
			dispose();
		}
		else if(e.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
		{
			path = null;
			dispose();
		}
	}
	
	/**
	 * @return selected path
	 */
	public String getPath()
	{
		return path;
	}
}
