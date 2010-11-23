/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.grid.ed;

import java.util.List;

import org.adempiere.base.Service;
import org.adempiere.osgi.IEditorFactory;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.swing.CLabel;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;

/**
 *  Factory for VEditor and its Label for single Row display and multi row-editor
 *
 *  @see VCellRenderer for multi-row display
 *  @author  Jorg Janked
 *  @version $Id: VEditorFactory.java,v 1.3 2006/07/30 00:51:28 jjanke Exp $
 */
public class VEditorFactory
{
	/**
	 *  Create Editor for MField.
	 *  The Name is set to the column name for dynamic display management
	 *  @param mField MField
	 *  @param tableEditor true if table editor
	 *  @return grid editor
	 */
	public static VEditor getEditor (GridField mField, boolean tableEditor)
	{
		return getEditor (null, mField, tableEditor);
	}   //  getEditor

	/**
	 *  Create Editor for MField.
	 *  The Name is set to the column name for dynamic display management
	 *  @param mTab MTab
	 *  @param mField MField
	 *  @param tableEditor true if table editor
	 *  @return grid editor
	 */
	public static VEditor getEditor (GridTab mTab, GridField mField, boolean tableEditor)
	{
		VEditor editor = null;
		List<IEditorFactory> factoryList = Service.list(IEditorFactory.class);
		for(IEditorFactory factory : factoryList)
		{
			editor = factory.getEditor(mTab, mField, tableEditor);
			if (editor != null)
				break;
		}
		return editor;
	}	//	getEditor

	/**
	 *  Create Label for MField. (null for YesNo/Button)
	 *  The Name is set to the column name for dynamic display management
	 *
	 *  @param mField MField
	 *  @return Label
	 */
	public static CLabel getLabel (GridField mField)
	{
		if (mField == null)
			return null;

		int displayType = mField.getDisplayType();

		//	No Label for FieldOnly, CheckBox, Button
		if (mField.isFieldOnly()
				|| displayType == DisplayType.YesNo
				|| displayType == DisplayType.Button)
			return null;
		//
		CLabel label = new CLabel(mField.getHeader(), mField.getDescription());
		label.setName(mField.getColumnName());
	//	label.setFont(AdempierePLAF.getFont_Label());
	//	label.setForeground(AdempierePLAF.getTextColor_Label());
		return label;
	}   //  getLabel

	/**	Logger			*/
	@SuppressWarnings("unused")
	private static CLogger log = CLogger.getCLogger(VEditorFactory.class);


}   //  VEditorFactory
