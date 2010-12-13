/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 SC ARHIPAC SERVICE SRL. All Rights Reserved.            *
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
package org.compiere.apps;

import java.awt.Component;
import java.awt.Cursor;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;

import javax.swing.JFileChooser;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.base.Service;
import org.compiere.grid.GridController;
import org.compiere.grid.VTabbedPane;
import org.compiere.model.GridTab;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.ExtensionFileFilter;

/**
 * Export button consequences
 * @author Teo Sarca, www.arhipac.ro
 *  			<li>FR [ 1943731 ] Window data export functionality
 */
public class AExport
{
	private CLogger log = CLogger.getCLogger(getClass());
	private int m_WindowNo = 0;
	private Map<String, IGridTabExporter> exporterMap = null;
	private Map<String, String> extensionMap = null;
	private APanel parent;

	public AExport(APanel parent)
	{
		m_WindowNo = parent.getWindowNo();
		//
		exporterMap = new HashMap<String, IGridTabExporter>();
		extensionMap = new HashMap<String, String>();
		List<IGridTabExporter> exporterList = Service.list(IGridTabExporter.class);
		for(IGridTabExporter exporter : exporterList)
		{
			String extension = exporter.getFileExtension();
			if (!extensionMap.containsKey(extension))
			{
				extensionMap.put(extension, exporter.getFileExtensionLabel());
				exporterMap.put(extension, exporter);
			}
		}
		JFileChooser chooser = new JFileChooser();
		for(Map.Entry<String, String> entry : extensionMap.entrySet())
		{
			chooser.addChoosableFileFilter(new ExtensionFileFilter(entry.getKey(), entry.getValue()));
		}

		if (chooser.showSaveDialog(parent) != JFileChooser.APPROVE_OPTION)
			return;

		//	Create File
		File outFile = ExtensionFileFilter.getFile(chooser.getSelectedFile(), chooser.getFileFilter());
		try
		{
			outFile.createNewFile();
		}
		catch (IOException e)
		{
			log.log(Level.SEVERE, "", e);
			ADialog.error(m_WindowNo, parent, "FileCannotCreate", e.getLocalizedMessage());
			return;
		}

		String ext = outFile.getPath();
		//	no extension
		if (ext.lastIndexOf('.') == -1)
		{
			ADialog.error(m_WindowNo, parent, "FileInvalidExtension");
			return;
		}
		ext = ext.substring(ext.lastIndexOf('.')+1).toLowerCase();
		log.config( "File=" + outFile.getPath() + "; Type=" + ext);

		parent.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
		this.parent = parent;
		try
		{
			if (extensionMap.containsKey(ext))
			{
				export(outFile, parent.getCurrentTab(), ext);
			}
			else
			{
				ADialog.error(m_WindowNo, parent, "FileInvalidExtension");
			}
		}
		catch (Exception e)
		{
			ADialog.error(m_WindowNo, parent, "Error", e.getLocalizedMessage());
			if (CLogMgt.isLevelFinest())
				e.printStackTrace();
		}
		finally
		{
			parent.setCursor(Cursor.getDefaultCursor());
		}
	}

	private void export(File outFile, GridTab tab, String extension)
	throws Exception
	{
		boolean currentRowOnly = ADialog.ask(m_WindowNo, parent, "Export current row only ?");

		IGridTabExporter exporter = exporterMap.get(extension);
		Set<String> tables = new HashSet<String>();
		List<GridTab> childs = new ArrayList<GridTab>();
		List<GridTab> includedList = tab.getIncludedTabs();
		for(GridTab included : includedList)
		{
			String tableName = included.getTableName();
			if (tables.contains(tableName))
				continue;
			tables.add(tableName);
			childs.add(included);
		}

		int selected = parent.getSelectedTabIndex();
		VTabbedPane tabbedPane = (VTabbedPane) parent.getCurrentTabbedPane();
		for(int i = selected+1; i < tabbedPane.getTabCount(); i++)
		{
			Component c = tabbedPane.getComponentAt(i);
			if (!(c instanceof GridController))
				continue;

			GridController gc = (GridController) c;
			if (gc.getMTab() == null)
				continue;
			if (gc.getMTab().getTabLevel() <= tab.getTabLevel())
				break;
			String tableName = gc.getMTab().getTableName();
			if (tables.contains(tableName))
				continue;
			tables.add(tableName);
			childs.add(gc.getMTab());
		}

		exporter.export(tab, childs, currentRowOnly, outFile);
	}
}
