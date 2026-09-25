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
package org.idempiere.extension.manager.form;

import java.util.HashMap;

import org.adempiere.webui.component.Button;
import org.zkoss.zul.Vlayout;
import org.adempiere.webui.panel.CustomForm;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.select.Selectors;
import org.zkoss.zk.ui.select.annotation.Wire;
import org.zkoss.zul.Div;
import org.zkoss.zul.Tab;

/**
 * ZK UI component wrapper for Extension Browser form.
 */
public class ExtensionBrowserForm extends CustomForm {

	private static final long serialVersionUID = 1L;

	@Wire("#extensionListbox")
	protected Vlayout extensionListbox;
	@Wire("#installedListbox")
	protected Vlayout installedListbox;
	@Wire("#filterInput")
	protected org.zkoss.zul.Textbox filterInput;
	@Wire("#filterButton")
	protected org.adempiere.webui.component.Button filterButton;
	@Wire("#installUpdateButton")
	protected Button installUpdateButton;
	@Wire("#uninstallButton")
	protected Button uninstallButton;
	@Wire("#enableDisableButton")
	protected Button enableDisableButton;
	@Wire("#downloadButton")
	protected Button downloadButton;
	@Wire("#registryButton")
	protected Button registryButton;
	@Wire("#infoArea")
	protected Div infoArea;
	@Wire("#repositoryTab")
	protected Tab repositoryTab;
	@Wire("#installedTab")
	protected Tab installedTab;

	public ExtensionBrowserForm() {
		HashMap<String, Object> arguments = new HashMap<>();
		arguments.put("install", Msg.getMsg(Env.getCtx(), "Install"));
		arguments.put("uninstall", Msg.getMsg(Env.getCtx(), "Uninstall"));
		arguments.put("disable", Msg.getMsg(Env.getCtx(), "Disable")); //Disable
		arguments.put("download", Msg.getMsg(Env.getCtx(), "ExtensionDownloadArchive")); //Download (.idext)
		arguments.put("registry", Msg.getMsg(Env.getCtx(), "ExtensionRegistryButton")); //Registry
		arguments.put("repository", Msg.getMsg(Env.getCtx(), "ExtensionRepository")); //Extension Repository
		arguments.put("installed", Msg.getMsg(Env.getCtx(), "InstalledExtensions")); //Installed Extensions
		arguments.put("filterPlaceholderText", Msg.getMsg(Env.getCtx(), "ExtensionFilterPlaceHolderText")); //Filter by name, description, tag: or category:
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		try {
			Thread.currentThread().setContextClassLoader(getClass().getClassLoader());
			// Load the zul component from the web package
			Component form = Executions.createComponents("~./extension-browser.zul", this, arguments);
			// Wire components annotated with @Wire to this instance
			Selectors.wireComponents(form, this, false);
		} finally {
			Thread.currentThread().setContextClassLoader(cl);
		}
	}
}
