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

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.idempiere.ui.zk.media.Medias;
import org.zkoss.util.media.AMedia;
import org.zkoss.zul.Filedownload;

import io.keikai.api.Exporter;
import io.keikai.api.Exporters;
import io.keikai.api.Ranges;
import io.keikai.api.model.Book;
import io.keikai.api.model.Sheet;
import io.keikai.ui.UserActionContext;
import io.keikai.ui.UserActionHandler;

/**
 * @author hengsin
 *
 */
public class SaveBookHandler implements UserActionHandler {

	/**
	 * default constructor
	 */
	public SaveBookHandler() {
	}

	@Override
	public boolean isEnabled(Book book, Sheet sheet) {
		return book != null && sheet != null;
	}

	@Override
	public boolean process(UserActionContext context) {
		Book book = context.getBook();
		String bookName = book.getBookName();
		if (bookName.endsWith(".csv")) {
			bookName = bookName.substring(0, bookName.length()-4) + ".xlsx";
		}
		
		//don't export as protected/readonly
		boolean isProtected = book.getSheetAt(0).isProtected();  
		if (isProtected)
			Ranges.range(book.getSheetAt(0)).unprotectSheet(null);
		
		Exporter exporter = bookName.endsWith(".xls") ? Exporters.getExporter("xls") : Exporters.getExporter("xlsx");        
        File file = null;
		try {
			file = File.createTempFile(Long.toString(System.currentTimeMillis()),"temp");
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(file);
            exporter.export(book, fos);
        } catch (Exception e) {
			throw new RuntimeException(e.getMessage(), e);
		} finally{
            if(fos!=null){
                try {
					fos.close();
				} catch (IOException e) {
				}
            }
        }
        
        String contentType = bookName.endsWith(".xls") ? Medias.EXCEL_MIME_TYPE : Medias.EXCEL_XML_MIME_TYPE;
        String extension = bookName.endsWith(".xls") ? Medias.EXCEL_FILE_EXT : Medias.EXCEL_XML_FILE_EXT;
        try {
			Filedownload.save(new AMedia(bookName, contentType, extension, file, true));
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
        
        //restore protection
        if (isProtected) {
        	Helper.protectSheet(book.getSheetAt(0));
        }
        
        return true;
	}

}
