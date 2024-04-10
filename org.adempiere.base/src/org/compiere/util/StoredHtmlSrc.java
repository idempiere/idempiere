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
 **********************************************************************/
package org.compiere.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

import org.apache.ecs.MultiPartElement;
import org.apache.ecs.Printable;

/**
 *  Load html-src (text) stored in JAR, e.g. to load a style-sheet
 */
public class StoredHtmlSrc extends MultiPartElement implements Printable {
	
	private static final long serialVersionUID = 50303119083373138L;
	
	/**	Logger					*/
	protected static CLogger 	log = CLogger.getCLogger(StoredHtmlSrc.class.getName());
		
	/**
	 *  Load html-src (text) stored in JAR, e.g. to load a style-sheet
	 *  @param elementType e.g. elementType=STYLE
	 *  @param srcLocation package/filename in SRC e.g. org/compiere/util/standard.css
	 *  todo if needed: also write for SinglePartElement and StringElement
	 */
	public StoredHtmlSrc(String elementType, String srcLocation) {
		this.setElementType(elementType);
		
		URL url = getClass().getClassLoader().getResource(srcLocation);
		if (url==null) {
			log.warning("failed to load html-src: " + srcLocation);
			return;
		}			
		InputStreamReader ins;
		BufferedReader bufferedReader = null;
		try {
			ins = new InputStreamReader(url.openStream());
			bufferedReader = new BufferedReader( ins );
			String cssLine;
			String result="";
			while ((cssLine = bufferedReader.readLine()) != null) 
				result+=cssLine;
			this.setTagText(result);
		} catch (IOException e1) {
			log.warning("failed to load html-src: " + srcLocation);
		}
		finally{
			if (bufferedReader != null) {
				try {
					bufferedReader.close();
				} catch (IOException e) {}
				bufferedReader = null;
			}
		}
	}
}
