/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

package org.compiere.apps.form;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.compiere.model.GridField;
import org.compiere.model.MField;
import org.compiere.model.MTab;
import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 *
 * @author Juan David Arboleda
 * @author Carlos Ruiz
 *
 */
public class TabEditor
{

	public MTab m_tab;

	/**	Logger			*/
	public static CLogger log = CLogger.getCLogger(TabEditor.class);

	private List<MField> fields = new ArrayList<MField>();

	private MField m_activeField;

	private List<GridField> gridFields = new ArrayList<GridField>();

	public List<GridField> getGridFields() {
		return gridFields;
	}

	public MTab getMTab() {
		return m_tab;
	}

	public List<MField> getMFields() {
		return fields;
	}

	protected void initMFields(int windowNo, int tabid) {
		m_tab = new MTab(Env.getCtx(), tabid, null);
		GridField[] l_gridFields = GridField.createFields(Env.getCtx(), windowNo, 0, tabid);
		for (GridField gridField : l_gridFields) {
			gridFields.add(gridField);
			MField field = new MField(Env.getCtx(), gridField.getAD_Field_ID(), null);
			fields.add(field);
			gridField.getVO().IsReadOnly = true;
			gridField.getVO().IsMandatory = false;
			gridField.getVO().IsUpdateable = false;
			gridField.getVO().IsAlwaysUpdateable = false;
		}
		resortArrays();
	}

	public boolean cmd_save() {
		for (MField field : fields) {
			if (field.isActive())
				field.saveEx();
		}
		return true;
	}

	protected MField getMField(int fieldid) {
		for (MField field : fields) {
			if (field.getAD_Field_ID() == fieldid) {
				return field;
			}
		}
		return null;
	}

	protected GridField getGridField(MField field) {
		for (GridField gridfield : gridFields) {
			if (gridfield.getAD_Field_ID() == field.getAD_Field_ID()) {
				return gridfield;
			}
		}
		return null;
	}

	public MField getActiveMField() {
		return m_activeField;
	}

	protected void setActiveMField(MField field) {
		m_activeField = field;
	}

	protected void resortArrays() {
		Collections.sort(fields, new Comparator<MField>() {
			@Override
			public int compare(MField field1, MField field2) {
				String compare1 = String.format("%s%10d%s",
						(field1.isDisplayed() ? "0" : "1"), 
						(field1.isDisplayed() ? field1.getSeqNo() : 0),
						field1.getName());
				String compare2 = String.format("%s%10d%s",
						(field2.isDisplayed() ? "0" : "1"), 
						(field2.isDisplayed() ? field2.getSeqNo() : 0),
						field2.getName());
				return compare1.compareTo(compare2);
			}
		});

		int seq = 10;
		for (MField field : fields) {
			if (field.isDisplayed()) {
				field.setSeqNo(seq);
				seq = seq + 10;
			} else {
				field.setSeqNo(0);
			}
		}

		Collections.sort(gridFields, new Comparator<GridField>() {
			@Override
			public int compare(GridField f1, GridField f2) {
				MField field1 = getMField(f1.getAD_Field_ID());
				MField field2 = getMField(f2.getAD_Field_ID());
				String compare1 = String.format("%s%10d%s",
						(field1.isDisplayed() ? "0" : "1"), 
						(field1.isDisplayed() ? field1.getSeqNo() : 0),
						field1.getName());
				String compare2 = String.format("%s%10d%s",
						(field2.isDisplayed() ? "0" : "1"), 
						(field2.isDisplayed() ? field2.getSeqNo() : 0),
						field2.getName());
				return compare1.compareTo(compare2);
			}
		});
		
	}

}   //  TabEditor
