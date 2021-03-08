/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2018 iDempiere.org. All Rights Reserved.               *
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
package org.adempiere.webui.apps;

import org.adempiere.webui.editor.WEditor;

/**
 * Listener interface for process parameter panel.
 * Implementation must be thread safe
 * @author hengsin
 *
 */
public interface IProcessParameterListener {
	/**
	 * on value change of parameter field editor
	 * @param parameterPanel
	 * @param columnName - for range parameter the To columnname is suffixed with _2
	 * @param editor
	 */
	public void onChange(ProcessParameterPanel parameterPanel, String columnName, WEditor editor);
	
	/**
	 * validate process parameter form
	 * @param parameterPanel
	 * @return error message (if any)
	 */
	public default String validate(ProcessParameterPanel parameterPanel) {
		return null;
	}	
}
