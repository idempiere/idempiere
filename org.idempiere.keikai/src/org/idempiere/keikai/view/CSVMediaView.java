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

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.util.List;

import org.idempiere.ui.zk.media.IMediaView;
import org.supercsv.io.CsvListReader;
import org.supercsv.io.ICsvListReader;
import org.supercsv.prefs.CsvPreference;
import org.zkoss.poi.xssf.usermodel.XSSFWorkbook;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.Component;

import io.keikai.api.Importer;
import io.keikai.api.Importers;
import io.keikai.api.Ranges;
import io.keikai.api.model.Book;
import io.keikai.api.model.Sheet;
import io.keikai.ui.AuxAction;
import io.keikai.ui.Spreadsheet;
import io.keikai.ui.UserActionManager;
import io.keikai.ui.impl.DefaultUserActionManagerCtrl;

/**
 * @author hengsin
 *
 */
public class CSVMediaView implements IMediaView {

	public static final CSVMediaView INSTANCE = new CSVMediaView();
	
	/**
	 * default constructor
	 */
	private CSVMediaView() {
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
		
		try {
			XSSFWorkbook xw = new XSSFWorkbook();
			xw.createSheet();
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			xw.write(baos);
			ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
			Importer importer = Importers.getImporter();
			Book book = importer.imports(bais, media.getName());
			spreadsheet.setBook(book);
			Sheet sheet = book.getSheetAt(0);
			Reader reader;
			if (media.isBinary())
				reader = new InputStreamReader(new ByteArrayInputStream(media.getByteData()));
			else
				reader = media.getReaderData();
			ICsvListReader csvListReader = new CsvListReader(reader, CsvPreference.STANDARD_PREFERENCE);
			List<String> headers = csvListReader.read();
			if (headers != null) {
				for(int i = 0; i < headers.size(); i++) {
					Ranges.range(sheet, 0, i).setCellValue(headers.get(i));
				}
			}
			List<String> line = null;
			int row = 0;
			while ((line = csvListReader.read()) != null) {
				row++;
				for(int i = 0; i < line.size(); i++) {								
					Ranges.range(sheet, row, i).setCellValue(line.get(i) != null ? line.get(i) : "");
				}
			}
			csvListReader.close();
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
        
		if (readOnly) {
			Book book = spreadsheet.getBook();
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
