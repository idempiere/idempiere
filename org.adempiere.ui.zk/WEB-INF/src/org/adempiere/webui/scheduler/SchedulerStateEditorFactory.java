/**********************************************************************
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
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.adempiere.webui.scheduler;

import org.adempiere.webui.editor.IEditorConfiguration;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.factory.IEditorFactory;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.osgi.service.component.annotations.Component;

/**
 * @author hengsin
 *
 */
@Component(name = "org.adempiere.webui.scheduler.SchedulerStateEditorFactory", service = {IEditorFactory.class}, 
		   property = {"service.ranking:Integer=1"})
public class SchedulerStateEditorFactory implements IEditorFactory {

	private final static int SCHEDULER_STATE_AD_REFERENCE_ID = 200173;
	
	/**
	 * default constructor 
	 */
	public SchedulerStateEditorFactory() {
	}

	@Override
	public WEditor getEditor(GridTab gridTab, GridField gridField, boolean tableEditor) {
		return getEditor(gridTab, gridField, tableEditor, null);
	}

	@Override
	public WEditor getEditor(GridTab gridTab, GridField gridField, boolean tableEditor,
			IEditorConfiguration editorConfiguration) {
		if (gridField != null && gridField.getDisplayType() == SCHEDULER_STATE_AD_REFERENCE_ID) {
			return new SchedulerStateEditor(gridField, tableEditor, editorConfiguration);
		}
		return null;
	}

}
