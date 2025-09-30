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
package org.compiere.print;

import org.apache.ecs.ConcreteElement;
import org.apache.ecs.xhtml.a;
import org.apache.ecs.xhtml.body;

/**
 * Extension interface for HTML report
 * @author hengsin
 */
public interface IHTMLExtension {

	/**
	 * Get CSS class prefix for HTML report element
	 * @return CSS class prefix for HTML report element
	 */
	public String getClassPrefix();
	
	/**
	 * Get URL to report CSS
	 * @return URL to report CSS
	 */
	public String getStyleURL();
	
	/**
	 * Get URL to report javascript
	 * @return URL to report javascript
	 */
	public String getScriptURL();
	
	/**
	 * Apply customization to row
	 * @param row
	 * @param printData
	 */
	public void extendRowElement(ConcreteElement row, PrintData printData);
	
	/**
	 * Apply customization to ID element
	 * @param row
	 * @param columnElement
	 * @param href link for ID column
	 * @param dataElement
	 */
	public void extendIDColumn(int row, ConcreteElement columnElement, a href, PrintDataElement dataElement);
	
	/**
	 * Add attributes to reportBody
	 * @param reportBody
	 */
	public void setWebAttribute (body reportBody);
	
	/**
	 * Get absolute local file path to CSS file (typically for embedding the file content to HTML report)
	 * @return absolute local file path to CSS file
	 */
	public String getFullPathStyle ();

	/**
	 * Get one or more links (&lt;link ... &gt;) to web font
	 * @return one or more links for web font
	 */
	String getWebFontLinks();
}
