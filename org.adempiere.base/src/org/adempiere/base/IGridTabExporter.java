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
package org.adempiere.base;

import java.io.File;
import java.util.List;

import org.compiere.model.GridTab;

/**
 * Interface to export data from {@link GridTab}
 * @author hengsin
 */
public interface IGridTabExporter {

	/**
	 * export gridTab data to file
	 * @param gridTab
	 * @param childs
	 * @param isCurrentRowOnly
	 * @param file
	 * @param indxDetailSelected index of selected child tab
	 */
	public void export(GridTab gridTab, List<GridTab> childs, boolean isCurrentRowOnly, File file, int indxDetailSelected);

	/**
	 * @return file extension (csv, zip, ect)
	 */
	public String getFileExtension();

	/**
	 * @return label for file extension
	 */
	public String getFileExtensionLabel();

	/**
	 * @return mime content type
	 */
	public String getContentType();

	/**
	 * @return suggested file name
	 */
	public String getSuggestedFileName(GridTab gridTab);
	
	/**
	 * Check if exported support the export of a child tab
	 * @param childTab
	 * @return true if export is supported, false otherwise
	 */
	public boolean isExportableTab (GridTab childTab);
	
	/**
	 * @return true if exporter is available to role with advanced access only
	 */
	default boolean isAdvanced()  {
		return false;
	}
	
	/**
	 * @return true if export of child tabs is supported only when current row only is on.
	 */
	default boolean isExportChildTabsForCurrentRowOnly() {
		return false;
	}
	
	/**
	 * Maximum deep of child tab supported by the exporter
	 * @return &gt; 0 for maximum level of deep, &lt;= 0 for unlimited level of deep 
	 */
	default int maxDeepOfChildTab() {
		return 0;
	}
}
