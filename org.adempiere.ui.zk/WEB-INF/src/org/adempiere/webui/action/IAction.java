/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.webui.action;

import org.zkoss.zul.Toolbarbutton;

/**
 * Custom UI action provided through OSGi service. Implementation must be thread safe.   
 * @author hengsin
 *
 */
public interface IAction {
	/**
	 * 
	 * @param target
	 */
	public void execute(Object target);
	
	/**
	 * you can customize toolbar button like add style, client javascript,...
	 * @param toolbarButton
	 */
	public default void decorate(Toolbarbutton toolbarButton) {		
	}
	
	/**
	 * @return font icon class
	 */
	public default String getIconSclass() {
		return "";
	}
}
