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
package org.adempiere.webui.adwindow;

import java.util.Collection;

import org.adempiere.util.Callback;
import org.adempiere.webui.editor.WEditor;

/**
 * Interface for container that host one or more field editors
 * @author hengsin
 *
 */
public interface IFieldEditorContainer {
	/**
	 * set focus to first field editor
	 */
	public void focusToFirstEditor();
	
	/**
	 * set focus to next field editor from ref
	 * @param ref
	 */
	public void focusToNextEditor(WEditor ref);
	
	/**
	 * Call editorTaverseCallback for all editors hosted by this container
	 * @param editorTaverseCallback
	 */
	public void editorTraverse (Callback<WEditor> editorTaverseCallback);
	
	/**
	 * Default implementation for {@link #editorTraverse(Callback)}
	 * @param editorTaverseCallback
	 * @param editors
	 */
	default void editorTraverse (Callback<WEditor> editorTaverseCallback, Collection<WEditor> editors) {
		for (WEditor editor : editors) {
			editorTaverseCallback.onCallback(editor);
		}
	}
}
