/***********************************************************************
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
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.print.layout;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.exceptions.DBException;
import org.compiere.model.X_AD_PrintFormatItem;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.print.util.SerializableMatrix;
import org.compiere.util.DB;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;

/**
 * @author hengsin
 *
 */
public class InstanceAttributeData {
	private MPrintFormatItem item;
	private List<String> attributes;
	private List<Map<String, String>> attributeRows;
	private int columnIndex;

	/**
	 * 
	 * @param item
	 * @param columnIndex
	 */
	public InstanceAttributeData(MPrintFormatItem item, int columnIndex) {
		this.item = item;
		this.columnIndex = columnIndex;
	}

	/**
	 * 
	 * @param rowIndex
	 * @param attributeName
	 * @return attribute value
	 */
	public String getAttributeValue(int rowIndex, String attributeName) {
		if (attributeRows == null)
			return null;
		if (rowIndex >= attributeRows.size())
			return null;
		Map<String, String> valueMap = attributeRows.get(rowIndex);
		return valueMap.get(attributeName);
	}

	/**
	 * 
	 * @return {@link MPrintFormatItem}
	 */
	public MPrintFormatItem getPrintFormatItem() {
		return item;
	}

	/**
	 * 
	 * @return column index
	 */
	public int getColumnIndex() {
		return columnIndex;
	}

	/**
	 * 
	 * @return attribute columns
	 */
	public List<InstanceAttributeColumn> getColumns() {
		List<InstanceAttributeColumn> list = new ArrayList<>();
		for (String s : attributes) {
			InstanceAttributeColumn col = new InstanceAttributeColumn(s, this);
			list.add(col);
		}
		return list;
	}

	/**
	 * 
	 * @param printData
	 */
	public void readAttributesData(PrintData printData) {
		attributes = new ArrayList<>();
		attributeRows = new ArrayList<>();
		for (int i = 0; i < printData.getRowCount(); i++) {
			printData.setRowIndex(i);
			Map<String, String> attributeMap = new HashMap<>();
			Object node = printData.getNodeByPrintFormatItem(item);
			if (node instanceof PrintDataElement) {
				PrintDataElement dataElement = (PrintDataElement) node;
				Object value = dataElement.getValue();
				if (value != null && value instanceof KeyNamePair) {
					KeyNamePair knp = (KeyNamePair) value;
					int asiId = knp.getKey();
					if (asiId > 0) {
						String sql = "SELECT b.Name, a.Value FROM M_AttributeInstance a JOIN M_Attribute b ON (a.M_Attribute_ID=b.M_Attribute_ID) "
								+ "WHERE a.M_AttributeSetInstance_ID=?";
						try (PreparedStatement stmt = DB.prepareStatement(sql, null)) {
							stmt.setInt(1, asiId);
							ResultSet rs = stmt.executeQuery();
							while (rs.next()) {
								String attribute = rs.getString(1);
								String attributeValue = rs.getString(2);
								if (Util.isEmpty(attributeValue))
									continue;
								if (!attributes.contains(attribute))
									attributes.add(attribute);
								attributeMap.put(attribute, attributeValue);
							}
						} catch (SQLException e) {
							throw new DBException(e);
						}
					}
				}
			}
			attributeRows.add(attributeMap);
		}
	}

	/**
	 * 
	 * @param elements
	 * @param tableProperties
	 * @param columnOffset
	 */
	public void updateTable(SerializableMatrix<Serializable> elements, TableProperties tableProperties,
			int columnOffset) {
		List<ValueNamePair> columnHeaderList = new ArrayList<>();
		Collections.addAll(columnHeaderList, tableProperties.getColumnHeader());
		List<Integer> columnMaxWidthList = new ArrayList<>();
		for (int t : tableProperties.getColumnMaxWidth())
			columnMaxWidthList.add(t);
		List<Integer> columnMaxHeightList = new ArrayList<>();
		for (int t : tableProperties.getColumnMaxHeight())
			columnMaxHeightList.add(t);
		List<String> columnJustificationList = new ArrayList<>();
		Collections.addAll(columnJustificationList, tableProperties.getColumnJustification());
		List<Boolean> fixedWidthList = new ArrayList<>();
		for (boolean t : tableProperties.getFixedWidth())
			fixedWidthList.add(t);
		List<Boolean> colSuppressRepeatsList = new ArrayList<>();
		for (boolean t : tableProperties.getColSuppressRepeats())
			colSuppressRepeatsList.add(t);

		int valueMaxWidth = item.getMaxWidth();
		boolean valueFixedWidth = (valueMaxWidth != 0 && item.isFixedWidth());
		boolean valueSuppressRepeats = item.isSuppressRepeats();
		if (item.isSuppressNull()) {
			if (valueMaxWidth == 0)
				valueMaxWidth = -1; // indication suppress if Null
			else
				valueMaxWidth *= -1;
		}
		int valueMaxHeight = item.getMaxHeight();
		if (item.isHeightOneLine())
			valueMaxHeight = -1;
		String valueJustification = item.getFieldAlignmentType();
		if (valueJustification == null || valueJustification.equals(X_AD_PrintFormatItem.FIELDALIGNMENTTYPE_Default))
			valueJustification = X_AD_PrintFormatItem.FIELDALIGNMENTTYPE_LeadingLeft;
		int index = columnIndex + columnOffset;
		for (String s : attributes) {
			columnHeaderList.add(index, new ValueNamePair(s, s));
			columnMaxWidthList.add(index, valueMaxWidth);
			columnMaxHeightList.add(index, valueMaxHeight);
			columnJustificationList.add(index, valueJustification);
			fixedWidthList.add(index, valueFixedWidth);
			colSuppressRepeatsList.add(index, valueSuppressRepeats);
			index++;
		}
		tableProperties.setColumnHeader(columnHeaderList.toArray(new ValueNamePair[0]));
		tableProperties.setColumnMaxWidth(columnMaxWidthList.stream().mapToInt(i -> i).toArray());
		tableProperties.setColumnMaxHeight(columnMaxHeightList.stream().mapToInt(i -> i).toArray());
		tableProperties.setColumnJustification(columnJustificationList.toArray(new String[0]));
		boolean[] fixedWidth = new boolean[fixedWidthList.size()];
		for (int i = 0; i < fixedWidthList.size(); i++)
			fixedWidth[i] = fixedWidthList.get(i);
		tableProperties.setFixedWidth(fixedWidth);
		Boolean[] colSuppressRepeats = new Boolean[colSuppressRepeatsList.size()];
		for (int i = 0; i < colSuppressRepeatsList.size(); i++)
			colSuppressRepeats[i] = colSuppressRepeatsList.get(i);
		tableProperties.setColSuppressRepeats(colSuppressRepeats);
		for (int i = 0; i < elements.getRowCount(); i++) {
			elements.setRowIndex(i);
			List<Serializable> columns = elements.getRowData();
			Map<String, String> attributeRow = attributeRows.get(i);
			index = columnIndex + columnOffset;
			for (String s : attributes) {
				String value = attributeRow.get(s);
				columns.add(index, value);
				index++;
			}
		}
	}
}
