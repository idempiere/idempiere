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

import java.io.IOException;

import org.adempiere.webui.apps.AEnv;
import org.compiere.model.MAttachment;
import org.compiere.model.MClientInfo;
import org.compiere.model.MImage;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUserDefTheme;
import org.compiere.model.MUserDefThemeDetail;
import org.compiere.model.SystemProperties;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.image.AImage;

/**
 * Static methods for web client theme.
 * @author hengsin
 */
public final class ThemeManager {
	//zk predefined starting path for classpath resources (src/web)
	public static final String ZK_PREFIX_FOR_CLASSPATH_RESOURCE = "/web";
	
	//zk predefined url prefix for resources loaded from classpath 
	public static final String ZK_URL_PREFIX_FOR_CLASSPATH_RESOURCE = "~./";

	/**	Logger			*/
	private static CLogger log = CLogger.getCLogger(ThemeManager.class);

	private static String m_theme = ITheme.ZK_THEME_DEFAULT;
	private static String m_brokenTheme = null;
	
	public static String THEME_PATH_PREFIX = ITheme.THEME_PATH_PREFIX_V8;
	
	/**
	 * Get large logo URL
	 * @return url for large logo
	 */
	public static String getLargeLogo() {
		String theme = getTheme();
		String def = THEME_PATH_PREFIX+theme+ITheme.LOGIN_LOGO_IMAGE;
		return MSysConfig.getValue(MSysConfig.ZK_LOGO_LARGE, def);
	}

	/**
	 * Get small logo URL
	 * @return url for small logo
	 */
	public static String getSmallLogo() {
		String theme = getTheme();
		String def = THEME_PATH_PREFIX+theme+ITheme.HEADER_LOGO_IMAGE;
		String url = MSysConfig.getValue(MSysConfig.ZK_LOGO_SMALL, null);
		if (url == null)
			url = MSysConfig.getValue(MSysConfig.WEBUI_LOGOURL, def);
		return url;
	}

	/**
	 * Get name of active theme
	 * @return name of active theme
	 */
	public static String getTheme() {
		String theme = SystemProperties.getZkTheme();
		if (Util.isEmpty(theme))
			theme = MSysConfig.getValue(MSysConfig.ZK_THEME, ITheme.ZK_THEME_DEFAULT);
		if (theme.equals(m_brokenTheme)) {
			theme = ITheme.ZK_THEME_DEFAULT;
		} else {
			if (! theme.equals(m_theme)) {
				if (! ITheme.ZK_THEME_DEFAULT.equals(theme)) {
					// Verify the theme.css.dsp exists in the theme folder
					String themeCSSURL = getStyleSheet();
					if (ThemeManager.class.getResource(toClassPathResourcePath(themeCSSURL)) == null) {
						// verify if is a v7 theme
						themeCSSURL = ITheme.THEME_PATH_PREFIX_V7 + theme + ITheme.THEME_STYLESHEET;
						if (ThemeManager.class.getResource(toClassPathResourcePath(themeCSSURL)) != null) {
							THEME_PATH_PREFIX = ITheme.THEME_PATH_PREFIX_V7;
						} else {
							log.warning("The theme " + theme + " does not exist or is not properly configured, falling back to " + ITheme.ZK_THEME_DEFAULT);
							m_brokenTheme = theme;
							THEME_PATH_PREFIX = ITheme.THEME_PATH_PREFIX_V8;
							theme = ITheme.ZK_THEME_DEFAULT;
						}
					}
				} else {
					THEME_PATH_PREFIX = ITheme.THEME_PATH_PREFIX_V8;
				}
				m_theme = theme;
			}
		}
		return theme;
	}

	/**
	 * Get theme stylesheet URL
	 * @return url of theme stylesheet
	 */
	public static String getStyleSheet() {
		return THEME_PATH_PREFIX + getTheme() + ITheme.THEME_STYLESHEET;
	}

	/**
	 * Get user define style sheet
	 * @return user define style sheet
	 */
	public static String getUserDefineStyleSheet() {
		MUserDefTheme userDef = MUserDefTheme.getBestMatch(Env.getCtx(), getTheme());
		if (userDef != null && !Util.isEmpty(userDef.getStylesheet())) {
			String styleSheet = userDef.getStylesheet();
			if (styleSheet.toLowerCase().startsWith("https://")) {
				return styleSheet;
			} else if (MAttachment.isAttachmentURLPath(styleSheet)) {
				return MAttachment.getStyleSheetAttachmentURLFromPath(null, styleSheet);
			} else {
				return THEME_PATH_PREFIX + getTheme() + styleSheet;
			}
		}

		return null;
	}

	/**
	 * Get theme stylesheet URL for specific browsers
	 * @return url of theme stylesheet by browser
	 */
	public static String getStyleSheetByBrowser() {
		return THEME_PATH_PREFIX + getTheme() + ITheme.THEME_STYLESHEET_BY_BROWSER;
	}

	/**
	 * Get theme preference URL
	 * @return url of theme preference page
	 */
	public static String getPreference() {
		return THEME_PATH_PREFIX + getTheme() + ITheme.THEME_PREFERENCE;
	}
	
	/**
	 * Get title text for browser tab
	 * @return title text for browser tab
	 */
	public static String getBrowserTitle() {		
		return AEnv.getDesktop().getWebApp().getAppName();
	}

	/**
	 * Get browser tab icon URL
	 * @return url for browser icon
	 */
	public static String getBrowserIcon() {
		String theme = getTheme();
		String def = THEME_PATH_PREFIX + theme + ITheme.BROWSER_ICON_IMAGE;
		return MSysConfig.getValue(MSysConfig.ZK_BROWSER_ICON, def);
	}
	
	/**
	 * Get theme resource URL
	 * @param name relative resource name from theme root (can be overwritten using Theme Variation, see https://idempiere.atlassian.net/browse/IDEMPIERE-6293)
	 * @return full resource url
	 */
	public static String getThemeResource(String name) {

		MUserDefThemeDetail userDef = MUserDefThemeDetail.get(Env.getCtx(), getTheme(), name);
		if (userDef != null && !Util.isEmpty(userDef.getNewValue())) {
			name = userDef.getNewValue();
			if (name.startsWith("https://")) {
				return name;
			} else if (MAttachment.isAttachmentURLPath(name)) {
				return MAttachment.getImageAttachmentURLFromPath(null, name);
			}
		}

		StringBuilder builder = new StringBuilder(THEME_PATH_PREFIX);
		builder.append(getTheme());
		builder.append("/").append(name);
		String url = builder.toString().intern();
		return  url;
	}
	
	/**
	 * Get tenant web logi image
	 * @return tenant web logo if available
	 * @throws IOException
	 */
	public static org.zkoss.image.Image getClientWebLogo() throws IOException {
		MClientInfo cinfo = MClientInfo.get(Env.getCtx());
		if (cinfo.getLogoWeb_ID() > 0) {
			MImage mImage = MImage.get(Env.getCtx(), cinfo.getLogoWeb_ID());
			if (mImage.getData() != null)
				return new AImage(mImage.getName(), mImage.getData());
			else
				return null;	    	
		} else {
			return null;
		}
	}

	/** Theme Name:Boolean */
	private static final CCache<String, Boolean> s_themeHasCustomCSSCache = new CCache<String, Boolean>(null, "ThemeHasCustomCSSCache", 2, 0, false, 0);

	/**
	 * Is current theme has custom CSS fragment
	 * @return true if custom css ({theme}/css/fragment/custom.css.dsp) exists
	 */
	public static Boolean isThemeHasCustomCSSFragment() {
		String theme = getTheme();
		Boolean flag = s_themeHasCustomCSSCache.get(theme);
		if (flag != null)
			return flag;
		String customCSSURL = THEME_PATH_PREFIX + theme + "/css/fragment/custom.css.dsp";
		if (ThemeManager.class.getResource(toClassPathResourcePath(customCSSURL)) == null) {
			flag = Boolean.FALSE;
		} else {
			flag = Boolean.TRUE;
		}
		s_themeHasCustomCSSCache.put(theme, flag);
		return flag;
	}

	/**
	 * Is use CSS to define size of dialog
	 * @return true if css is use to define size of dialog
	 */
	public static boolean isUseCSSForWindowSize() {
		return "Y".equals(Env.getContext(Env.getCtx(), ITheme.USE_CSS_FOR_WINDOW_SIZE));
	}	
	
	/**
	 * Is use font icon
	 * @return true if use font icon instead of image 
	 */
	public static boolean isUseFontIconForImage() {
		return "Y".equals(Env.getContext(Env.getCtx(), ITheme.USE_FONT_ICON_FOR_IMAGE));
	}
	
	/**
	 * Convert zkResourceURL to class path resource URL (if URL start with ~./)
	 * @param zkResourceURL zk resource url for classpath resources (url start with ~./)
	 * @return Resource path for lookup/loading through class loader (absolute path start with /web)
	 */
	public static String toClassPathResourcePath(String zkResourceURL) {
		if (zkResourceURL == null)
			return zkResourceURL;
		
		if (!zkResourceURL.startsWith(ZK_URL_PREFIX_FOR_CLASSPATH_RESOURCE))
			return zkResourceURL;
		
		return ZK_PREFIX_FOR_CLASSPATH_RESOURCE+zkResourceURL.substring(2);
	}
	
	/**
	 * Translate image name to font icon name
	 * @param imagePath
	 * @return font icon css class name
	 */
	public static String getIconSclass(String imagePath) {
		String iconSclass = null;
		if (!Util.isEmpty(imagePath, true)) {
			// remove path and extension
			iconSclass = imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.lastIndexOf("."));
			
			// remove prefix m
			if (iconSclass.length() > 2)
				iconSclass = iconSclass.startsWith("m") && Character.isUpperCase(iconSclass.charAt(1)) ? iconSclass.substring(1) : iconSclass;
			
			// remove image size
			iconSclass = iconSclass.replaceAll("(\\d\\d)$", "");
			
			iconSclass = "z-icon-" + iconSclass;
		}
		
		return iconSclass;
	}
}
