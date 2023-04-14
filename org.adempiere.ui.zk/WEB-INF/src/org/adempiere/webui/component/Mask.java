/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.webui.component;

import org.zkoss.zul.Div;

/**
 * Background mask
 * @author hengsin
 */
public class Mask extends Div {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7462166722064971644L;

	/**
	 * default constructor
	 */
	public Mask() {
		setStyle("position: absolute; width: 100%; height: 100%; border: none; margin: 0; background-color: #e4e4e4; " +
			"padding: 0; z-index:999; opacity:0.6; top: 0px; left: 0px;");
	}
		
	/**
	 * Close mask
	 */
	public void hideMask() {
		if (this.getParent() != null){
			this.detach();
		}		
	}

}
