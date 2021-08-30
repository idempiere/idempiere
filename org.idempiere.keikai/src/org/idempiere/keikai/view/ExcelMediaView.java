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

import java.io.IOException;

import org.idempiere.ui.zk.media.IMediaView;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.Component;

import io.keikai.api.Importer;
import io.keikai.api.Importers;
import io.keikai.api.model.Book;
import io.keikai.ui.AuxAction;
import io.keikai.ui.Spreadsheet;
import io.keikai.ui.UserActionManager;
import io.keikai.ui.impl.DefaultUserActionManagerCtrl;

/**
 * @author hengsin
 *
 */
public class ExcelMediaView implements IMediaView {

	public final static ExcelMediaView INSTANCE =  new ExcelMediaView();
	
	/**
	 * 
	 */
	private ExcelMediaView() {
	}

	@Override
	public Component renderMediaView(Component container, AMedia media, boolean readOnly) {
		Spreadsheet spreadsheet = new Spreadsheet();
		if (!readOnly) {
			spreadsheet.setShowFormulabar(true);
			spreadsheet.setShowContextMenu(true);
		}		
		spreadsheet.setShowToolbar(true);
		spreadsheet.setHeight("100%");
		spreadsheet.setWidth("100%");
		container.appendChild(spreadsheet);
		
		Importer importer = Importers.getImporter();
        Book book;
		try {
			book = importer.imports(media.getStreamData(), media.getName());
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
        spreadsheet.setBook(book);
        if (readOnly) {
        	Helper.protectSheet(book.getSheetAt(0));
        }
        
        Helper.customizeToolbar(container, readOnly);
        
        UserActionManager actionManager = spreadsheet.getUserActionManager();
        actionManager.registerHandler(
                DefaultUserActionManagerCtrl.Category.AUXACTION.getName(),
                AuxAction.SAVE_BOOK.getAction(), new SaveBookHandler());
        
		return spreadsheet;
	}

}
