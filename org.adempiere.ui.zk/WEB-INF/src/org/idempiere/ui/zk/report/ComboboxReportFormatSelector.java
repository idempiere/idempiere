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
 **********************************************************************/
package org.idempiere.ui.zk.report;

import java.util.List;

import org.adempiere.webui.component.Combobox;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;

/**
 * Default report format selector, a combo box of the print format names.
 */
public class ComboboxReportFormatSelector implements IReportFormatSelector {

	private final Combobox combobox = new Combobox();
	private Runnable selectionListener;

	/**
	 * Create the combo box
	 */
	public ComboboxReportFormatSelector() {
		combobox.setAutocomplete(true);
		combobox.setAutodrop(true);
		combobox.setTooltiptext(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID"));
		combobox.addEventListener(Events.ON_SELECT, event -> {
			if (selectionListener != null)
				selectionListener.run();
		});
	}

	@Override
	public Component getComponent() {
		return combobox;
	}

	@Override
	public void setFormats(List<ReportFormatEntry> entries, int selectedKey) {
		combobox.removeAllItems();
		for (ReportFormatEntry entry : entries)
			combobox.appendItem(entry.name(), entry.key());
		setSelectedKey(selectedKey);
	}

	@Override
	public int getSelectedKey() {
		Comboitem item = combobox.getSelectedItem();
		return item != null && item.getValue() != null ? (Integer) item.getValue() : ReportFormatEntry.KEY_NONE;
	}

	@Override
	public void setSelectedKey(int key) {
		Comboitem selected = null;
		for (Comboitem item : combobox.getItems()) {
			if (item.getValue() != null && ((Integer) item.getValue()).intValue() == key) {
				selected = item;
				break;
			}
		}
		combobox.setSelectedItem(selected);
	}

	@Override
	public void setSelectionListener(Runnable listener) {
		selectionListener = listener;
	}
}
