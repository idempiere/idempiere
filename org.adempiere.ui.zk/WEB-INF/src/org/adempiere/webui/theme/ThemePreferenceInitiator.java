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
 * - Norbert Bede                                                      *
 **********************************************************************/
package org.adempiere.webui.theme;

import java.util.Map;

import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.util.Initiator;
import org.zkoss.zul.theme.Themes;

/**
 * Initiator for the theme preference zul (see {@link ThemeManager#getPreference()}),
 * the Java replacement of the BeanShell script used by the built-in themes.<br/>
 * Usage: &lt;?init class="org.adempiere.webui.theme.ThemePreferenceInitiator" zkTheme="breeze"?&gt;<br/>
 * <br/>
 * Arguments:
 * <ul>
 * <li>zkTheme: name of the ZK theme to use (mandatory)</li>
 * <li>toolbarButtonSize: value for {@link ITheme#ZK_TOOLBAR_BUTTON_SIZE}, default 24</li>
 * <li>useCSSForWindowSize: value for {@link ITheme#USE_CSS_FOR_WINDOW_SIZE}, default Y</li>
 * </ul>
 * The optional arguments let a custom theme with other values use this initiator instead of a zscript.<br/>
 * {@link ITheme#USE_FONT_ICON_FOR_IMAGE} is set from the SysConfig {@link MSysConfig#ZK_THEME_USE_FONT_ICON_FOR_IMAGE}.<br/>
 * The selected ZK theme is stored in the execution attribute {@link ThemeInitiator#ZK_THEME_ATTRIBUTE},
 * which {@link ThemeInitiator} checks to redirect when the ZK theme changed.<br/>
 * Themes that need more logic can keep using a zscript in their preference zul.
 */
public class ThemePreferenceInitiator implements Initiator {

	/** Argument: name of the ZK theme */
	public static final String ARG_ZK_THEME = "zkTheme";
	/** Argument: toolbar button size */
	public static final String ARG_TOOLBAR_BUTTON_SIZE = "toolbarButtonSize";
	/** Argument: use CSS for window size (Y/N) */
	public static final String ARG_USE_CSS_FOR_WINDOW_SIZE = "useCSSForWindowSize";

	/** Default toolbar button size */
	private static final String DEFAULT_TOOLBAR_BUTTON_SIZE = "24";
	/** Default for use CSS for window size */
	private static final String DEFAULT_USE_CSS_FOR_WINDOW_SIZE = "Y";

	/**
	 * Default constructor
	 */
	public ThemePreferenceInitiator() {
	}

	/**
	 * Set the theme context variables and the ZK theme from the initiator arguments.
	 */
	@Override
	public void doInit(Page page, Map<String, Object> args) throws Exception {
		String zkTheme = getArgument(args, ARG_ZK_THEME, null);
		if (Util.isEmpty(zkTheme, true))
			throw new IllegalArgumentException(ThemePreferenceInitiator.class.getName() + ": argument " + ARG_ZK_THEME + " is mandatory");

		Env.setContext(Env.getCtx(), ITheme.ZK_TOOLBAR_BUTTON_SIZE, getArgument(args, ARG_TOOLBAR_BUTTON_SIZE, DEFAULT_TOOLBAR_BUTTON_SIZE));
		Env.setContext(Env.getCtx(), ITheme.USE_CSS_FOR_WINDOW_SIZE, getArgument(args, ARG_USE_CSS_FOR_WINDOW_SIZE, DEFAULT_USE_CSS_FOR_WINDOW_SIZE));
		Env.setContext(Env.getCtx(), ITheme.USE_FONT_ICON_FOR_IMAGE, MSysConfig.getBooleanValue(MSysConfig.ZK_THEME_USE_FONT_ICON_FOR_IMAGE, false));

		Execution execution = Executions.getCurrent();
		Themes.setTheme(execution, zkTheme);
		execution.setAttribute(ThemeInitiator.ZK_THEME_ATTRIBUTE, zkTheme);
	}

	/**
	 * Get argument value
	 * @param args initiator arguments
	 * @param name argument name
	 * @param defaultValue value to return when the argument is missing or empty
	 * @return argument value or defaultValue
	 */
	private String getArgument(Map<String, Object> args, String name, String defaultValue) {
		Object value = args != null ? args.get(name) : null;
		if (value == null || Util.isEmpty(value.toString(), true))
			return defaultValue;
		return value.toString().trim();
	}
}
