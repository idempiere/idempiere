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
* - Diego Ruiz, BX Service GmbH                                       *
**********************************************************************/
package org.adempiere.webui.editor;

import org.compiere.model.GridField;
import org.compiere.util.Util;


public class WJsonEditor extends WStringEditor {
	
	/**
	 * 
	 * @param gridField
	 */
	public WJsonEditor(GridField gridField) {
		super(gridField);
		getComponent().setMultiline(true);
		setChangeEventWhenEditing(false);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public WJsonEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
        super(gridField, tableEditor, editorConfiguration);
        getComponent().setMultiline(true);
        setChangeEventWhenEditing(false);
    }
    
    @Override
    public void setValue(Object value) {
    	super.setValue(value);

    	String prettyValue = null;
    	if (value != null && !Util.isEmpty(value.toString())) {
    		prettyValue = Util.prettifyJSONString(value.toString());
    		if (! prettyValue.equals(value)) {
        		getComponent().setText(prettyValue);
    		}
    	}
    }
    
}
