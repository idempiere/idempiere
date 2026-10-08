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
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.IntFunction;

import org.compiere.model.MRole;
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
import org.zkoss.zul.Button;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;
import org.zkoss.zul.Popup;

/**
 * Sample report format selector that draws the print formats as cards in a popup.
 * Each card has an icon, the name and the description. The formats of the user's role come first,
 * the other formats follow, and the create actions sit in a footer. The look comes from the theme CSS classes
 * {@code report-format-*}.
 * Which formats belong to a role is the selector's own mapping, here a comma separated list of
 * AD_PrintFormat_ID in the AD_SysConfig {@link #SYSCONFIG_ROLE_PREFIX} plus the AD_Role_ID.
 * The viewer only supplies key, name, client and kind, and only for print formats the role may use.
 */
public class RoleGroupedReportFormatSelector implements IReportFormatSelector {

	/** AD_SysConfig name prefix of the print formats of a role. Append the AD_Role_ID. */
	public static final String SYSCONFIG_ROLE_PREFIX = "ZK_REPORT_FORMAT_SAMPLE_ROLE_";

	/**
	 * Supplies {@link RoleGroupedReportFormatSelector} for clients where the AD_SysConfig
	 * {@link GroupedReportFormatSelector#SYSCONFIG_NAME} is set to ROLE. It declines otherwise.
	 */
	@org.osgi.service.component.annotations.Component(immediate = true, service = IReportFormatSelectorFactory.class,
			property = { "service.ranking:Integer=100" })
	public static class Factory implements IReportFormatSelectorFactory {
		@Override
		public IReportFormatSelector createSelector(ReportFormatRequest request) {
			int clientId = Env.getAD_Client_ID(Env.getCtx());
			if (!"ROLE".equalsIgnoreCase(MSysConfig.getValue(GroupedReportFormatSelector.SYSCONFIG_NAME, "", clientId)))
				return null;
			MRole role = MRole.getDefault();
			Set<Integer> formats = new HashSet<>();
			String csv = MSysConfig.getValue(SYSCONFIG_ROLE_PREFIX + role.getAD_Role_ID(), "", clientId);
			Arrays.stream(csv.split(",")).map(String::trim).filter(s -> s.matches("\\d+"))
					.forEach(s -> formats.add(Integer.valueOf(s)));
			return new RoleGroupedReportFormatSelector(role.getName(), formats, key -> DB.getSQLValueString(null,
					"SELECT Description FROM AD_PrintFormat WHERE AD_PrintFormat_ID=?", key));
		}
	}

	private final Div root = new Div();
	private final Button button = new Button();
	private final Popup popup = new Popup();
	private final String roleName;
	private final Set<Integer> roleFormats;
	private final IntFunction<String> descriptions;
	private final Map<Integer, String> descriptionCache = new HashMap<>();
	private List<ReportFormatEntry> entries = List.of();
	private int selectedKey = ReportFormatEntry.KEY_NONE;
	private Runnable selectionListener;

	/**
	 * @param roleName name of the role shown in the first group
	 * @param roleFormats AD_PrintFormat_ID of the print formats made for the role
	 * @param descriptions returns the description of a print format key, or null
	 */
	public RoleGroupedReportFormatSelector(String roleName, Set<Integer> roleFormats, IntFunction<String> descriptions) {
		this.roleName = roleName;
		this.roleFormats = roleFormats;
		this.descriptions = descriptions;
		popup.setSclass("report-format-popup");
		root.appendChild(button);
		root.appendChild(popup);
		button.addEventListener(Events.ON_CLICK, event -> popup.open(button, "after_start"));
	}

	@Override
	public Component getComponent() {
		return root;
	}

	@Override
	public boolean isLimitedToReportView() {
		return true;
	}

	@Override
	public void setFormats(List<ReportFormatEntry> entries, int selectedKey) {
		this.entries = entries;
		this.selectedKey = selectedKey;
		loadDescriptions(entries);
		rebuild();
	}

	@Override
	public int getSelectedKey() {
		return selectedKey;
	}

	@Override
	public void setSelectedKey(int key) {
		selectedKey = entries.stream().anyMatch(e -> e.key() == key) ? key : ReportFormatEntry.KEY_NONE;
		rebuild();
	}

	@Override
	public void setSelectionListener(Runnable listener) {
		selectionListener = listener;
	}

	private void rebuild() {
		popup.getChildren().clear();
		Label who = new Label(Msg.translate(Env.getCtx(), "AD_Role_ID") + ": " + roleName);
		who.setSclass("report-format-who");
		popup.appendChild(who);

		List<ReportFormatEntry> formats = new ArrayList<>(entries.stream().filter(ReportFormatEntry::isFormat).toList());
		formats.sort(Comparator.comparing(ReportFormatEntry::name));
		addGroup(roleName, formats.stream().filter(e -> roleFormats.contains(e.key())).toList());
		addGroup(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID"), formats.stream().filter(e -> !roleFormats.contains(e.key())).toList());

		Div footer = new Div();
		footer.setSclass("report-format-footer");
		for (ReportFormatEntry entry : entries) {
			if (!entry.isFormat())
				footer.appendChild(action(entry));
		}
		popup.appendChild(footer);

		button.setLabel(entries.stream().filter(e -> e.key() == selectedKey).map(ReportFormatEntry::name).findFirst()
				.orElse(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID")) + " ▾");
	}

	private void addGroup(String title, List<ReportFormatEntry> group) {
		if (group.isEmpty())
			return;
		Label header = new Label(title);
		header.setSclass("report-format-group");
		popup.appendChild(header);
		for (ReportFormatEntry entry : group)
			popup.appendChild(card(entry));
	}

	private Div card(ReportFormatEntry entry) {
		boolean selected = entry.key() == selectedKey;
		Div row = new Div();
		row.setSclass(selected ? "report-format-row selected" : "report-format-row");
		Label icon = new Label("##");
		icon.setSclass("report-format-icon");
		row.appendChild(icon);
		Div text = new Div();
		text.setSclass("report-format-text");
		Label name = new Label(entry.name());
		name.setSclass("report-format-name");
		text.appendChild(name);
		String description = descriptionOf(entry.key());
		if (description != null) {
			Label detail = new Label(description);
			detail.setSclass("report-format-description");
			text.appendChild(detail);
		}
		row.appendChild(text);
		if (selected)
			row.appendChild(new Label("✓"));
		row.addEventListener(Events.ON_CLICK, event -> pick(entry));
		return row;
	}

	private Label action(ReportFormatEntry entry) {
		Label label = new Label(entry.name());
		label.setSclass("report-format-action");
		label.addEventListener(Events.ON_CLICK, event -> pick(entry));
		return label;
	}

	private void pick(ReportFormatEntry entry) {
		selectedKey = entry.key();
		rebuild();
		popup.close();
		if (selectionListener != null)
			selectionListener.run();
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
