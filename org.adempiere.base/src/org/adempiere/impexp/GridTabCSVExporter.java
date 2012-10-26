/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Carlos Ruiz                                             *
 * Copyright (C) 2012 Trek Global                                             *
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
package org.adempiere.impexp;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.MTabCustomization;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.MColumn;
import org.compiere.model.MRefList;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.supercsv.cellprocessor.FmtBool;
import org.supercsv.cellprocessor.FmtDate;
import org.supercsv.cellprocessor.FmtNumber;
import org.supercsv.cellprocessor.Optional;
import org.supercsv.cellprocessor.ift.CellProcessor;
import org.supercsv.io.CsvMapWriter;
import org.supercsv.io.ICsvMapWriter;
import org.supercsv.prefs.CsvPreference;

/**
 * CSV Exporter for GridTab
 * @author Carlos Ruiz
 */
public class GridTabCSVExporter implements IGridTabExporter
{
	@Override
	public void export(GridTab gridTab, List<GridTab> childs, boolean currentRowOnly, File file) {

		ICsvMapWriter mapWriter = null;
		try {
			mapWriter = new CsvMapWriter(new FileWriter(file), CsvPreference.STANDARD_PREFERENCE);
			GridTable gt = gridTab.getTableModel();
			GridField[] gridFields = getFields(gridTab);
			List<String> headArray = new ArrayList<String>();
			List<String> colsArray = new ArrayList<String>();
			List<CellProcessor> procArray = new ArrayList<CellProcessor>();
			MTable table = MTable.get(Env.getCtx(), gridTab.getTableName());
			for (int idxfld = 0; idxfld < gridFields.length; idxfld++) {
				GridField field = gridFields[idxfld];
				colsArray.add(field.getColumnName());
				MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
				String headName = resolveColumnName(table, column);
				headArray.add(headName);
				if (DisplayType.Date == column.getAD_Reference_ID()) {
					procArray.add(new Optional(new FmtDate(DisplayType.DEFAULT_DATE_FORMAT)));
				} else if (DisplayType.DateTime == column.getAD_Reference_ID()) {
					procArray.add(new Optional(new FmtDate(DisplayType.DEFAULT_TIMESTAMP_FORMAT)));
				} else if (DisplayType.Time == column.getAD_Reference_ID()) {
					procArray.add(new Optional(new FmtDate("DisplayType.DEFAULT_TIME_FORMAT")));
				} else if (DisplayType.Integer == column.getAD_Reference_ID() || DisplayType.isNumeric(column.getAD_Reference_ID())) {
					DecimalFormat nf = DisplayType.getNumberFormat(column.getAD_Reference_ID());
					nf.setGroupingUsed(false);
					procArray.add(new Optional(new FmtNumber(nf)));
				} else if (DisplayType.YesNo == column.getAD_Reference_ID()) {
					procArray.add(new Optional(new FmtBool("Y", "N")));
				} else { // lookups and text
					procArray.add(null);
				}
			}
			// the header elements are used to map the bean values to each column (names must match)
			String[] header = headArray.toArray(new String[headArray.size()]);
			CellProcessor[] processors = procArray.toArray(new CellProcessor[procArray.size()]);
			// write the header
			mapWriter.writeHeader(header);
			// write the beans
			int start = 0;
			int end = 0;
			if (currentRowOnly) {
				start = gridTab.getCurrentRow();
				end = start + 1;
			} else {
				end = gt.getRowCount();
			}
			for (int idxrow = start; idxrow < end; idxrow++) {
				Map<String, Object> row = new HashMap<String, Object>();
				for (int idxfld = 0; idxfld < header.length; idxfld++) {
					GridField field = gridFields[idxfld];
					MColumn column = MColumn.get(Env.getCtx(), field.getAD_Column_ID());
					String headName = header[idxfld];
					Object value = resolveValue(gridTab, table, column, idxrow, headName);
					row.put(headName, value);
				}
				mapWriter.write(row, header, processors);
			}
		} catch (IOException e) {
			throw new AdempiereException(e);
		} finally {
			if (mapWriter != null) {
				try {
					mapWriter.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	private Object resolveValue(GridTab gridTab, MTable table, MColumn column, int i, String headName) {
		Object value = null;
		if (headName.indexOf("[") >= 0 && headName.endsWith("]")) {
			String foreignTable = column.getReferenceTableName();
			Object idO = gridTab.getValue(i, column.getColumnName());
			if (idO != null) {
				if (foreignTable.equals("AD_Ref_List")) {
					String ref = (String) idO;
					value = MRefList.getListName(Env.getCtx(), column.getAD_Reference_Value_ID(), ref);
				} else {
					int id = (Integer) idO;
					int start = headName.indexOf("[")+1;
					int end = headName.length()-1;
					String foreignColumn = headName.substring(start, end);
					StringBuilder select = new StringBuilder("SELECT ")
							.append(foreignColumn).append(" FROM ")
							.append(foreignTable).append(" WHERE ")
							.append(foreignTable).append("_ID=?");
					value = DB.getSQLValueStringEx(null, select.toString(), id);
				}
			}
		} else {
			value = gridTab.getValue(i, headName);
		}
		return value;
	}

	private String resolveColumnName(MTable table, MColumn column) {
		StringBuilder name = new StringBuilder(column.getColumnName());
		if (DisplayType.isLookup(column.getAD_Reference_ID())) {
			// resolve to identifier - search for value first, if not search for name - if not use the ID
			String foreignTable = column.getReferenceTableName();
			if ( ! ("AD_Language".equals(foreignTable) || "AD_EntityType".equals(foreignTable))) {
				MTable fTable = MTable.get(Env.getCtx(), foreignTable);
				// Hardcoded / do not check for Value on AD_Org, AD_User and AD_Ref_List, must use name for these two tables
				if (! ("AD_Org".equals(foreignTable) || "AD_User".equals(foreignTable) || "AD_Ref_List".equals(foreignTable))
					&& fTable.getColumn("Value") != null) {
					name.append("[Value]"); // fully qualified
				} else if (fTable.getColumn("Name") != null) {
					name.append("[Name]");
				} else if (fTable.getColumn("DocumentNo") != null) {
					name.append("[DocumentNo]");
				}
			}
		}
		return name.toString();
	}

	@Override
	public String getFileExtension() {
		return "csv";
	}

	@Override
	public String getFileExtensionLabel() {
		return Msg.getMsg(Env.getCtx(), "FileCSV");
	}

	@Override
	public String getContentType() {
		return "application/csv";
	}

	private GridField[] getFields (GridTab gridTab) {
		GridTable tableModel = gridTab.getTableModel();
		GridField[] tmpFields = tableModel.getFields();
		MTabCustomization tabCustomization = MTabCustomization.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), gridTab.getAD_Tab_ID(), null);
		GridField[] gridFields = null;
		if (tabCustomization != null 
			&& tabCustomization.getAD_Tab_Customization_ID() > 0 
			&& !Util.isEmpty(tabCustomization.getCustom(), true)) 
		{
			String custom = tabCustomization.getCustom().trim();
			String[] customComponent = custom.split(";");
			String[] fieldIds = customComponent[0].split("[,]");
			List<GridField> fieldList = new ArrayList<GridField>();
			for (String fieldIdStr : fieldIds) 
			{
				fieldIdStr = fieldIdStr.trim();
				if (fieldIdStr.length() == 0) continue;
				int AD_Field_ID = Integer.parseInt(fieldIdStr);
				for (GridField gridField : tmpFields) 
				{
					if (gridField.getAD_Field_ID() == AD_Field_ID) 
					{
						if (!gridField.isReadOnly() && gridField.isDisplayedGrid())
							fieldList.add(gridField);
						
						break;
					}
				}
			}
			gridFields = fieldList.toArray(new GridField[0]);
		} 
		else 
		{
			ArrayList<GridField> gridFieldList = new ArrayList<GridField>();
			
			for (GridField field:tmpFields)
			{
				if ("AD_Client_ID".equals(field.getColumnName()))
					continue;
				if (field.isParentValue() || (!field.isReadOnly() && field.isDisplayedGrid()))
					gridFieldList.add(field);
			}
			
			Collections.sort(gridFieldList, new Comparator<GridField>() {
				@Override
				public int compare(GridField o1, GridField o2) {
					return o1.getSeqNoGrid()-o2.getSeqNoGrid();
				}
			});
			
			gridFields = new GridField[gridFieldList.size()];
			gridFieldList.toArray(gridFields);
		}
		return gridFields;
	}

	@Override
	public String getSuggestedFileName(GridTab gridTab) {
		return "Export_" + gridTab.getTableName() + "." + getFileExtension();
	}

}
