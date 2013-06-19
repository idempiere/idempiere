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

import org.adempiere.webui.AdempiereWebUI;
import org.compiere.model.MClientInfo;
import org.compiere.model.MImage;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.image.AImage;

/**
 *
 * @author hengsin
 *
 */
public final class ThemeManager {

	/**
	 * @return url for large logo
	 */
	public static String getLargeLogo() {
		String theme = getTheme();
		String def = ITheme.THEME_PATH_PREFIX+theme+ITheme.LOGIN_LOGO_IMAGE;
		return MSysConfig.getValue(MSysConfig.ZK_LOGO_LARGE, def);
	}

	/**
	 * @return url for small logo
	 */
	public static String getSmallLogo() {
		String theme = getTheme();
		String def = ITheme.THEME_PATH_PREFIX+theme+ITheme.HEADER_LOGO_IMAGE;
		String url = MSysConfig.getValue(MSysConfig.ZK_LOGO_SMALL, null);
		if (url == null)
			url = MSysConfig.getValue(MSysConfig.WEBUI_LOGOURL, def);
		return url;
	}

	/**
	 * @return name of active theme
	 */
	public static String getTheme() {
		String theme = System.getProperty("ZK_THEME");
		return Util.isEmpty(theme) ? MSysConfig.getValue(ITheme.ZK_THEME, ITheme.ZK_THEME_DEFAULT) : theme;
	}

	/**
	 * @return url of theme stylesheet
	 */
	public static String getStyleSheet() {
		return ITheme.THEME_PATH_PREFIX + getTheme() + ITheme.THEME_STYLESHEET;
	}

	/**
	 * @return url of theme stylesheet by browser
	 */
	public static String getStyleSheetByBrowser() {
		return ITheme.THEME_PATH_PREFIX + getTheme() + ITheme.THEME_STYLESHEET_BY_BROWSER;
	}

	/**
	 * @return url of theme preference page
	 */
	public static String getPreference() {
		return ITheme.THEME_PATH_PREFIX + getTheme() + ITheme.THEME_PREFERENCE;
	}
	
	/**
	 * @return title text for the browser window
	 */
	public static String getBrowserTitle() {
		String s = Env.getContext(Env.getCtx(), "#ZK_BROWSER_TITLE");
		return Util.isEmpty(s) ? MSysConfig.getValue(MSysConfig.ZK_BROWSER_TITLE, AdempiereWebUI.APP_NAME) : s;
	}

	/**
	 * @return url for browser icon
	 */
	public static String getBrowserIcon() {
		String theme = getTheme();
		String def = ITheme.THEME_PATH_PREFIX + theme + ITheme.BROWSER_ICON_IMAGE;
		return MSysConfig.getValue(MSysConfig.ZK_BROWSER_ICON, def);
	}
	
	/**
	 * Get theme resource url
	 * @param name relative resource name from theme root
	 * @return full resource url
	 */
	public static String getThemeResource(String name) {
		StringBuilder builder = new StringBuilder(ITheme.THEME_PATH_PREFIX);
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
			return new AImage(mImage.getName(), mImage.getData());
	    	
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
}
