/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com
 * Contributor(s): Low Heng Sin hengsin@avantz.com
 *****************************************************************************/
package org.adempiere.pipo2;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.xml.sax.Attributes;

/**
 * XML element structure
 * @author Low Heng Sin
 *
 */
public class Element {

	public String uri;
	public String localName;
	public String qName;
	//element attributes
	public Attributes attributes;
	//defer for later reprocessing
	public boolean defer = false;
	//defer for post packin foreign key processing
	public int deferFKColumnID = 0;
	//parent element
	public Element parent;
	//resolved db recordid, store for reference by child element
	public Object recordId = null;
	//unresolved dependency
	public String unresolved = "";
	//number of pass
	public int pass = 1;
	//skip this node
	public boolean skip = false;

	public boolean deferEnd = false;

	public boolean requireRoleAccessUpdate = false;

	public Map<String, Element> properties = new LinkedHashMap<String, Element>();

	public List<Element> childrens = new ArrayList<Element>();

	public StringBuffer contents = new StringBuffer();

	/**
	 * @param uri
	 * @param localName
	 * @param qName
	 * @param attributes
	 */
	public Element(String uri, String localName, String qName, Attributes attributes) {
		this.uri = uri;
		this.localName = localName;
		this.qName = qName;
		this.attributes = attributes;
	}

	/**
     * @return elementValue
     */
    public String getElementValue() {
    	String elementValue = null;
		if ("".equals (uri))
			elementValue = qName;
		else
			elementValue = uri + localName;
		return elementValue;
    }
}
