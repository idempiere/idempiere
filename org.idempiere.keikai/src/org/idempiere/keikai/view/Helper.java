/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.keikai.view;

import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.util.Clients;

import io.keikai.api.Ranges;
import io.keikai.api.model.Sheet;

/**
 * 
 * @author hengsin
 *
 */
public final class Helper {

	private Helper() {
	}

	/**
	 * 
	 * @param sheet
	 */
	public static void protectSheet(Sheet sheet) {
		/**
		 * String password, boolean allowSelectingLockedCells, boolean
		 * allowSelectingUnlockedCells, boolean allowFormattingCells, boolean
		 * allowFormattingColumns, boolean allowFormattingRows, boolean
		 * allowInsertColumns, boolean allowInsertRows, boolean
		 * allowInsertingHyperlinks, boolean allowDeletingColumns, boolean
		 * allowDeletingRows, boolean allowSorting, boolean allowFiltering, boolean
		 * allowUsingPivotTables, boolean drawingObjects, boolean scenarios);
		 **/
		Ranges.range(sheet).protectSheet(null, true, true, true, true, true, false, false, false, false, false, true,
				true, false, false, false);
	}

	/**
	 * 
	 * @param container 
	 * @param readOnly
	 */
	public static void customizeToolbar(Component container, boolean readOnly) {
		// hide toolbar items that's not applicable or only available for ee
		String uuid = "#" + container.getUuid();
		StringBuilder script = new StringBuilder();		
		script.append("var wgt=zk('").append(uuid).append(" .zstbtn-insertPicture').$();if(wgt) wgt.setVisible(false);");
		script.append("wgt=zk('").append(uuid).append(" .zstbtn-insertChart').$();if(wgt) wgt.setVisible(false);");
		script.append("wgt=zk('").append(uuid).append(" .zstbtn-exportPDF').$();if(wgt) wgt.setVisible(false);");
		script.append("wgt=zk('").append(uuid).append(" .zstbtn-newBook').$();if(wgt) wgt.setVisible(false);");
		script.append("wgt=zk('").append(uuid).append(" .zstbtn-hyperlink').$();if(wgt) wgt.setVisible(false);");
		script.append("wgt=zk('").append(uuid).append(" .zschktbtn-gridlines + a').$();if(wgt) wgt.setVisible(false);");
		script.append("wgt=zk('").append(uuid).append(" .zschktbtn-protectSheet').$();if(wgt) wgt.setVisible(false);");
		script.append("wgt=zk('").append(uuid).append(" .zstbtn-mergeAndCenter').$();if(wgt) wgt.setVisible(false);");
		if (readOnly) {
			script.append("wgt=zk('").append(uuid).append(" .zstbtn-cut').$();if(wgt) wgt.setVisible(false);");
			script.append("wgt=zk('").append(uuid).append(" .zstbtn-paste').$();if(wgt) wgt.setVisible(false);");
			script.append("wgt=zk('").append(uuid).append(" .zstbtn-clear').$();if(wgt) wgt.setVisible(false);");
			script.append("wgt=zk('").append(uuid).append(" .zstbtn-insert').$();if(wgt) wgt.setVisible(false);");
			script.append("wgt=zk('").append(uuid).append(" .zstbtn-del').$();if(wgt) wgt.setVisible(false);");
			script.append("wgt=zk('").append(uuid).append(" .zstbtn-del + a').$();if(wgt) wgt.setVisible(false);");
		}
		Clients.evalJavaScript(script.toString());
	}
}
