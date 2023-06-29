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
	 * @return css class prefix for report element
	 */
	public String getClassPrefix();
	
	/**
	 * @return url to report css
	 */
	public String getStyleURL();
	
	/**
	 * @return url to report js
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
	 * @return absolute path to css style file
	 */
	public String getFullPathStyle ();

	/**
	 * @return one or more links for web font
	 */
	String getWebFontLinks();
}
