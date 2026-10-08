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
package org.idempiere.ui.zk.report.sample;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.IntFunction;

import org.adempiere.webui.component.Combobox;
import org.compiere.model.MClient;
import org.compiere.model.MSysConfig;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.ui.zk.report.IReportFormatSelector;
import org.idempiere.ui.zk.report.IReportFormatSelectorFactory;
import org.idempiere.ui.zk.report.ReportFormatEntry;
import org.idempiere.ui.zk.report.ReportFormatRequest;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;

/**
 * Sample report format selector that groups the print formats by client: the formats of the user's client first,
 * then the formats of the System client, each group headed by the client name, with a description under each name.
 * The group headers are disabled items, so they cannot be picked. The create actions come last.
 * The groups and descriptions belong to the selector. The viewer only supplies key, name, client and kind,
 * and only for print formats the role may use.
 */
public class GroupedReportFormatSelector implements IReportFormatSelector {

	/** AD_SysConfig name. Set to Y to show the report formats grouped instead of the default drop-down. */
	public static final String SYSCONFIG_NAME = "ZK_REPORT_FORMAT_SELECTOR_SAMPLE";

	/**
	 * Supplies {@link GroupedReportFormatSelector} for clients that turned on {@link #SYSCONFIG_NAME}.
	 * It declines otherwise, so the viewer keeps its default drop-down.
	 */
	@org.osgi.service.component.annotations.Component(immediate = true, service = IReportFormatSelectorFactory.class,
			property = { "service.ranking:Integer=100" })
	public static class Factory implements IReportFormatSelectorFactory {
		@Override
		public IReportFormatSelector createSelector(ReportFormatRequest request) {
			if (!MSysConfig.getBooleanValue(SYSCONFIG_NAME, false, Env.getAD_Client_ID(Env.getCtx())))
				return null;
			return new GroupedReportFormatSelector(key -> DB.getSQLValueString(null,
					"SELECT Description FROM AD_PrintFormat WHERE AD_PrintFormat_ID=?", key));
		}
	}

	private final Combobox combobox = new Combobox();
	private final IntFunction<String> descriptions;
	private final Map<Integer, String> descriptionCache = new HashMap<>();
	private int selectedKey = ReportFormatEntry.KEY_NONE;
	private Runnable selectionListener;

	/**
	 * @param descriptions returns the description of a print format key, or null
	 */
	public GroupedReportFormatSelector(IntFunction<String> descriptions) {
		this.descriptions = descriptions;
		combobox.setAutocomplete(true);
		combobox.setAutodrop(true);
		combobox.setTooltiptext(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID"));
		combobox.addEventListener(Events.ON_SELECT, event -> {
			Comboitem item = combobox.getSelectedItem();
			if (item == null || item.getValue() == null)
				return;
			selectedKey = (Integer) item.getValue();
			if (selectionListener != null)
				selectionListener.run();
		});
	}

	@Override
	public Component getComponent() {
		return combobox;
	}

	@Override
	public boolean isLimitedToReportView() {
		return true;
	}

	@Override
	public void setFormats(List<ReportFormatEntry> entries, int selectedKey) {
		combobox.removeAllItems();
		loadDescriptions(entries);
		List<ReportFormatEntry> formats = new ArrayList<>(entries.stream().filter(ReportFormatEntry::isFormat).toList());
		formats.sort(Comparator.comparing((ReportFormatEntry e) -> e.clientId() == 0).thenComparing(ReportFormatEntry::name));
		boolean mine = false;
		boolean system = false;
		for (ReportFormatEntry entry : formats) {
			if (entry.clientId() != 0 && !mine) {
				addHeader(MClient.get(Env.getCtx(), entry.clientId()).getName());
				mine = true;
			} else if (entry.clientId() == 0 && !system) {
				addHeader(MClient.get(Env.getCtx(), 0).getName());
				system = true;
			}
			addItem(entry);
		}
		for (ReportFormatEntry entry : entries) {
			if (!entry.isFormat())
				addItem(entry);
		}
		setSelectedKey(selectedKey);
	}

	@Override
	public int getSelectedKey() {
		return selectedKey;
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
		selectedKey = selected != null ? key : ReportFormatEntry.KEY_NONE;
		combobox.setSelectedItem(selected);
	}

	@Override
	public void setSelectionListener(Runnable listener) {
		selectionListener = listener;
	}

	private void addHeader(String text) {
		Comboitem header = new Comboitem(text);
		header.setDisabled(true);
		header.setSclass("report-format-group");
		combobox.appendChild(header);
	}

	private void addItem(ReportFormatEntry entry) {
		Comboitem item = new Comboitem(entry.name());
		item.setValue(entry.key());
		if (entry.isFormat()) {
			String description = descriptionOf(entry.key());
			if (description != null)
				item.setDescription(description);
		}
		combobox.appendChild(item);
	}

	private String descriptionOf(int key) {
		return descriptionCache.get(key);
	}

	private void loadDescriptions(List<ReportFormatEntry> entries) {
		descriptionCache.clear();
		for (ReportFormatEntry entry : entries) {
			if (entry.isFormat()) {
				String description = descriptions.apply(entry.key());
				if (description != null)
					descriptionCache.put(entry.key(), description);
			}
		}
	}
}
