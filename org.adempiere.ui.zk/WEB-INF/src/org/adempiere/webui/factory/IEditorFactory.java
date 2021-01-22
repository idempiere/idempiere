/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.webui.factory;

import org.adempiere.webui.editor.IEditorConfiguration;
import org.adempiere.webui.editor.WEditor;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;

/**
 *
 * @author hengsin
 *
 */
public interface IEditorFactory {

	/**
	 * @param gridTab
	 * @param gridField
	 * @param tableEditor
	 * @return {@link WEditor}
	 */
	public WEditor getEditor(GridTab gridTab, GridField gridField, boolean tableEditor);
	
	/**
	 * 
	 * @param gridTab
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 * @return {@link WEditor}
	 */
	public WEditor getEditor(GridTab gridTab, GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration);
}
