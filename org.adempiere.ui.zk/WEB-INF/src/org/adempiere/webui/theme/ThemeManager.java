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
import org.compiere.model.MClientInfo;
import org.compiere.model.MImage;
import org.compiere.model.MSysConfig;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.image.AImage;

/**
 *
 * @author hengsin
 *
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
	 * @return url for large logo
	 */
	public static String getLargeLogo() {
		String theme = getTheme();
		String def = THEME_PATH_PREFIX+theme+ITheme.LOGIN_LOGO_IMAGE;
		return MSysConfig.getValue(MSysConfig.ZK_LOGO_LARGE, def);
	}

	/**
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
	 * @return name of active theme
	 */
	public static String getTheme() {
		String theme = System.getProperty(MSysConfig.ZK_THEME);
		if (Util.isEmpty(theme))
			theme = MSysConfig.getValue(MSysConfig.ZK_THEME, ITheme.ZK_THEME_DEFAULT);
		if (theme.equals(m_brokenTheme)) {
			theme = ITheme.ZK_THEME_DEFAULT;
		} else {
			if (! theme.equals(m_theme)) {
				if (! ITheme.ZK_THEME_DEFAULT.equals(theme)) {
					// Verify the theme.css.dsp exists in the theme folder
					String themeCSSURL = THEME_PATH_PREFIX + theme + ITheme.THEME_STYLESHEET;
					if (ThemeManager.class.getResource(toClassPathResourcePath(themeCSSURL)) == null) {
						// verify if is a v7 theme
						themeCSSURL = ITheme.THEME_PATH_PREFIX_V7 + theme + ITheme.THEME_STYLESHEET;
						if (ThemeManager.class.getResource(toClassPathResourcePath(themeCSSURL)) != null) {
							THEME_PATH_PREFIX = ITheme.THEME_PATH_PREFIX_V7;
						} else {
							log.warning("The theme " + theme + " does not exist or is not properly configured, falling back to default");
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
	 * @return url of theme stylesheet
	 */
	public static String getStyleSheet() {
		return THEME_PATH_PREFIX + getTheme() + ITheme.THEME_STYLESHEET;
	}

	/**
	 * @return url of theme stylesheet by browser
	 */
	public static String getStyleSheetByBrowser() {
		return THEME_PATH_PREFIX + getTheme() + ITheme.THEME_STYLESHEET_BY_BROWSER;
	}

	/**
	 * @return url of theme preference page
	 */
	public static String getPreference() {
		return THEME_PATH_PREFIX + getTheme() + ITheme.THEME_PREFERENCE;
	}
	
	/**
	 * @return title text for the browser window
	 */
	public static String getBrowserTitle() {		
		return AEnv.getDesktop().getWebApp().getAppName();
	}

	/**
	 * @return url for browser icon
	 */
	public static String getBrowserIcon() {
		String theme = getTheme();
		String def = THEME_PATH_PREFIX + theme + ITheme.BROWSER_ICON_IMAGE;
		return MSysConfig.getValue(MSysConfig.ZK_BROWSER_ICON, def);
	}
	
	/**
	 * Get theme resource url
	 * @param name relative resource name from theme root
	 * @return full resource url
	 */
	public static String getThemeResource(String name) {
		StringBuilder builder = new StringBuilder(THEME_PATH_PREFIX);
		builder.append(getTheme());
		builder.append("/").append(name);
		String url = builder.toString().intern();
		return  url;
	}
	
	/**
	 * 
	 * @return client web logo if available
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
	    	
			/* Using different approach: ImageEncoder supports only PNG and JPEG
			Image image = mImage.getImage();
			if (image instanceof RenderedImage) {
				RenderedImage rImage = (RenderedImage)image;
				return Images.encode(mImage.getName(), rImage);
			} else {
				BufferedImage bImage = new BufferedImage(image.getWidth(null),
	                    image.getHeight(null),
	                    BufferedImage.TYPE_INT_ARGB);
				Graphics2D bImageGraphics = bImage.createGraphics();
				bImageGraphics.drawImage(image, null, null);
				RenderedImage rImage = (RenderedImage)bImage;
				String name = mImage.getName();
				if (name.endsWith("jpg")) {
					name = name.replace("jpg", "jpeg");
				}
				return Images.encode(name, rImage);
			}
			*/			
		} else {
			return null;
		}
	}

	private static final CCache<String, Boolean> s_themeHasCustomCSSCache = new CCache<String, Boolean>(null, "ThemeHasCustomCSSCache", 2, -1, false);

	/**
	 * @return true if custom css exists
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

	public static boolean isUseCSSForWindowSize() {
		return "Y".equals(Env.getContext(Env.getCtx(), ITheme.USE_CSS_FOR_WINDOW_SIZE));
	}	
	
	public static boolean isUseFontIconForImage() {
		return "Y".equals(Env.getContext(Env.getCtx(), ITheme.USE_FONT_ICON_FOR_IMAGE));
	}
	
	/**
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
}
