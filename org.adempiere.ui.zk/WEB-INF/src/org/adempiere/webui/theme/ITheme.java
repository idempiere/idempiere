/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.theme;

/**
 * Interface to hold global theme constant
 * @author hengsin
 *
 */
public interface ITheme {
	//default theme
	public static final String ZK_THEME_DEFAULT = "default";
	//theme resource url prefix
	public static final String THEME_PATH_PREFIX = "/theme/";

	//css for login window and box
	public static final String LOGIN_WINDOW_CLASS = "login-window";
	public static final String LOGIN_BOX_HEADER_CLASS = "login-box-header";
	public static final String LOGIN_BOX_HEADER_TXT_CLASS = "login-box-header-txt";
	public static final String LOGIN_BOX_HEADER_LOGO_CLASS = "login-box-header-logo";
	public static final String LOGIN_BOX_BODY_CLASS = "login-box-body";
	public static final String LOGIN_BOX_FOOTER_CLASS = "login-box-footer";
	public static final String LOGIN_BOX_FOOTER_PANEL_CLASS = "login-box-footer-pnl";

	//css for login control
	public static final String LOGIN_BUTTON_CLASS = "login-btn";
	public static final String LOGIN_LABEL_CLASS = "login-label";
	public static final String LOGIN_FIELD_CLASS = "login-field";

	//logo
	public static final String LOGIN_LOGO_IMAGE = "/images/login-logo.png";
	public static final String HEADER_LOGO_IMAGE = "/images/header-logo.png";
	public static final String BROWSER_ICON_IMAGE= "/images/icon.png";

	//stylesheet url
	public static final String THEME_STYLESHEET = "/css/theme.css.dsp";
	//http://books.zkoss.org/wiki/ZK_Developer's_Reference/Internationalization/Locale-Dependent_Resources#Specifying_Locale-_and_browser-dependent_URL
	public static final String THEME_STYLESHEET_BY_BROWSER = "/css/theme*.css.dsp*";
	
	//theme preference
	public static final String THEME_PREFERENCE = "/preference.zul";
	
	public static final String USE_CSS_FOR_WINDOW_SIZE = "#THEME_USE_CSS_FOR_WINDOW_SIZE";
	
	public static final String USE_FONT_ICON_FOR_IMAGE = "#THEME_USE_FONT_ICON_FOR_IMAGE";
	
	public static final String ZK_TOOLBAR_BUTTON_SIZE = "#ZK_Toolbar_Button_Size";
}
