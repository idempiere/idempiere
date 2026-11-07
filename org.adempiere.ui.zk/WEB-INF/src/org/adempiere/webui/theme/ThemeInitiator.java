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

import org.zkoss.lang.Library;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.util.Initiator;
import org.zkoss.zk.ui.util.InitiatorExt;
import org.zkoss.zul.theme.Themes;

/**
 * Page initiator that sets the theme variables used by the web client entry pages
 * (the Java replacement of the BeanShell script theme.zs).<br/>
 * Usage: &lt;?init class="org.adempiere.webui.theme.ThemeInitiator"?&gt;<br/>
 * <br/>
 * The variables are set as page attributes, so the page resolves them in EL expressions
 * (for example ${themeStyleSheet}) without running a BeanShell interpreter.<br/>
 * After the page is composed, it redirects to the same URL when the theme preference
 * (see {@link ThemeManager#getPreference()}) selected a ZK theme other than the current one,
 * so that the new ZK theme is applied on the next request.
 */
public class ThemeInitiator implements Initiator, InitiatorExt {

	/** Page attribute: URL of the theme style sheet */
	private static final String THEME_STYLE_SHEET = "themeStyleSheet";
	/** Page attribute: URL of the browser specific theme style sheet */
	private static final String THEME_STYLE_SHEET_BY_BROWSER = "themeStyleSheetByBrowser";
	/** Page attribute: URL of the browser icon */
	private static final String BROWSER_ICON = "browserIcon";
	/** Page attribute: URL of the theme preference zul */
	private static final String THEME_PREFERENCE = "themePreference";
	/** Page attribute: medium font size, as CSS declaration (font-size:...;) */
	private static final String FONT_SIZE_M = "fontSizeM";
	/** Page attribute: small font size */
	private static final String FONT_SIZE_S = "fontSizeS";
	/** Page attribute: extra small font size */
	private static final String FONT_SIZE_XS = "fontSizeXS";
	/** Page attribute: medium small font size */
	private static final String FONT_SIZE_MS = "fontSizeMS";
	/** Page attribute: font family, as CSS declaration (font-family:...;) */
	private static final String FONT_FAMILY_C = "fontFamilyC";

	/** Execution attribute set by the theme preference zul with the ZK theme to use */
	public static final String ZK_THEME_ATTRIBUTE = "Themes.setTheme";

	/** Prefix of the ZK library properties for theme fonts */
	private static final String ZK_THEME_PROPERTY_PREFIX = "org.zkoss.zul.theme.";

	/**
	 * Default constructor
	 */
	public ThemeInitiator() {
	}

	@Override
	public void doInit(Page page, Map<String, Object> args) throws Exception {
		page.setAttribute(THEME_STYLE_SHEET, ThemeManager.getStyleSheet());
		page.setAttribute(THEME_STYLE_SHEET_BY_BROWSER, ThemeManager.getStyleSheetByBrowser());
		page.setAttribute(BROWSER_ICON, ThemeManager.getBrowserIcon());
		page.setAttribute(THEME_PREFERENCE, ThemeManager.getPreference());

		String fontSizeM = Library.getProperty(ZK_THEME_PROPERTY_PREFIX + FONT_SIZE_M);
		if (fontSizeM != null)
			fontSizeM = "font-size:" + fontSizeM + ";";
		page.setAttribute(FONT_SIZE_M, fontSizeM);
		page.setAttribute(FONT_SIZE_S, Library.getProperty(ZK_THEME_PROPERTY_PREFIX + FONT_SIZE_S));
		page.setAttribute(FONT_SIZE_XS, Library.getProperty(ZK_THEME_PROPERTY_PREFIX + FONT_SIZE_XS));
		page.setAttribute(FONT_SIZE_MS, Library.getProperty(ZK_THEME_PROPERTY_PREFIX + FONT_SIZE_MS));
		String fontFamilyC = Library.getProperty(ZK_THEME_PROPERTY_PREFIX + FONT_FAMILY_C);
		if (fontFamilyC != null)
			fontFamilyC = "font-family:" + fontFamilyC + ";";
		page.setAttribute(FONT_FAMILY_C, fontFamilyC);
	}

	/**
	 * Redirect to the same URL if the theme preference zul selected a different ZK theme.
	 */
	@Override
	public void doAfterCompose(Page page, Component[] comps) throws Exception {
		Execution execution = Executions.getCurrent();
		if (execution.isVoided())
			return;
		Object setZkTheme = execution.getAttribute(ZK_THEME_ATTRIBUTE);
		if (setZkTheme != null && !setZkTheme.equals(Themes.getTheme(execution)))
			execution.sendRedirect(null);
	}

	@Override
	public boolean doCatch(Throwable ex) throws Exception {
		return false;
	}

	@Override
	public void doFinally() throws Exception {
	}
}
