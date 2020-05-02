/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 SC ARHIPAC SERVICE SRL. All Rights Reserved.            *
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
import java.util.HashMap;
import java.util.List;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Excel Exporter Adapter for GridTab
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 1943731 ] Window data export functionality
 */
public class GridTabExcelExporter extends AbstractExcelExporter implements IGridTabExporter
{
	private GridTab m_tab = null;

	public GridTabExcelExporter()
	{
		setFreezePane(0, 1);
	}

	@Override
	public int getColumnCount()
	{
		return m_tab.getFieldCount();
	}

	@Override
	public int getDisplayType(int row, int col)
	{
		return m_tab.getField(col).getDisplayType();
	}

	@Override
	public String getHeaderName(int col)
	{
		return m_tab.getField(col).getHeader();
	}

	@Override
	public int getRowCount()
	{
		return m_tab.getRowCount();
	}

	@Override
	public Object getValueAt(int row, int col)
	{
		GridField f = m_tab.getField(col);
		Object key = m_tab.getValue(row, f.getColumnName());
		Object value = key;
		Lookup lookup = f.getLookup();
		if (lookup != null)
		{
			;
		}
		else if (f.getDisplayType() == DisplayType.Button)
		{
			lookup = getButtonLookup(f);
		}
		//
		if (lookup != null)
		{
			value = lookup.getDisplay(key);
		}
		return value;
	}

	@Override
	public boolean isColumnPrinted(int col)
	{
		GridField f = m_tab.getField(col);
		// Hide not displayed fields
		if (!f.isDisplayed())
			return false;
		// Hide encrypted fields
		if (f.isEncrypted())
			return false;
		// Hide simple button fields without a value
		if (f.getDisplayType() == DisplayType.Button && f.getAD_Reference_Value_ID() == 0)
			return false;
		return true;
	}

	@Override
	public boolean isFunctionRow()
	{
		return false;
	}

	@Override
	public boolean isPageBreak(int row, int col)
	{
		return false;
	}

	@Override
	protected void setCurrentRow(int row)
	{
		; // nothing
	}

	protected int getCurrentRow()
	{
		return m_tab.getCurrentRow();
	}

	private HashMap<String, MLookup> m_buttonLookups = new HashMap<String, MLookup>();

	private MLookup getButtonLookup(GridField mField)
	{
		MLookup lookup = m_buttonLookups.get(mField.getColumnName());
		if (lookup != null)
			return lookup;
		// TODO: refactor with org.compiere.grid.ed.VButton.setField(GridField)
		if (mField.getColumnName().endsWith("_ID") && !mField.getColumnName().equals("Record_ID"))
		{
			lookup = MLookupFactory.get(Env.getCtx(), mField.getWindowNo(), 0,
				mField.getAD_Column_ID(), DisplayType.Search);
		}
		else if (mField.getAD_Reference_Value_ID() != 0)
		{
			//	Assuming List
			lookup = MLookupFactory.get(Env.getCtx(), mField.getWindowNo(), 0,
				mField.getAD_Column_ID(), DisplayType.List);
		}
		//
		m_buttonLookups.put(mField.getColumnName(), lookup);
		return lookup;
	}

	@Override
	public void export(GridTab gridTab, List<GridTab> childs, boolean currentRowOnly, File file,int indxDetailSelected) {
		m_tab = gridTab;
		setCurrentRowOnly(currentRowOnly);
		try {
			export(file, null);
		} catch (Exception e) {
			throw new AdempiereException(e);
		}
	}

	@Override
	public String getFileExtension() {
		return "xls";
	}

	@Override
	public String getFileExtensionLabel() {
		return Msg.getMsg(Env.getCtx(), "FileXLS");
	}

	@Override
	public String getContentType() {
		return "application/vnd.ms-excel";
	}

	@Override
	public String getSuggestedFileName(GridTab gridTab) {
		return gridTab.getName() + "." + getFileExtension();
	}

	/**
	 * {@inheritDoc}
	 * no detail tab is support to export with excel
	 */
	@Override
	public boolean isExportableTab(GridTab gridTab) {
		return false;
	}

	@Override
	public boolean isDisplayed(int row, int col)
	{
		return true;
	}
}
