/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.webui.action;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import org.adempiere.base.IServiceHolder;
import org.adempiere.base.Service;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.util.CCache;
import org.zkoss.image.AImage;

/**
 * 
 * @author hengsin
 *
 */
public class Actions {

	private static final String ACTION_IMAGES_PATH = "/action/images/";
	private static CCache<String, IServiceHolder<IAction>> trackerCache = new CCache<String, IServiceHolder<IAction>>(null, "ActionsServiceTracker", 5, false);
	private static CCache<String, AImage> imageCache = new CCache<String, AImage>(null, "ActionsImages",5, false);
	
	/**
	 * 
	 * @param actionId
	 * @return {@link IServiceHolder}
	 */
	public static IServiceHolder<IAction> getAction(String actionId) {
		IServiceHolder<IAction> action = null;
		synchronized (trackerCache) {
			action = trackerCache.get(actionId);
		} 
		if (action != null && action.getService() != null)
			return action;
		
		action = Service.locator().locate(IAction.class, actionId, null);
		if (action != null) {
			synchronized (trackerCache) {
				trackerCache.put(actionId, action);
			}
		}
		return action;
	}
	
	/**
	 * 
	 * @param actionId
	 * @return {@link AImage}
	 */
	public static AImage getActionImage(String actionId) {
		AImage aImage = null;
		synchronized (imageCache) {
			aImage = imageCache.get(actionId);
		}
		if (aImage != null)
			return aImage;

		String imageName = actionId+ "24.png";
		IServiceHolder<IAction> action = getAction(actionId);
		if (action.getService() != null) {
			InputStream inputStream = null;
			//try current theme
			String themePath = ThemeManager.getThemeResource(imageName);
			URL themeURL = ThemeManager.class.getResource(ThemeManager.toClassPathResourcePath(themePath));
			if (themeURL != null) {
				try {
					inputStream = themeURL.openStream();
				} catch (IOException e) {
				}
			}
			//try plugin theme resource
			if (inputStream == null) {				
				String path = ACTION_IMAGES_PATH + ThemeManager.getTheme() + "/" + imageName;
				inputStream = action.getService().getClass().getClassLoader().getResourceAsStream(path);
			}
			//try plugin default theme resource
			if (inputStream == null) {				
				if (!(ITheme.ZK_THEME_DEFAULT.equals(ThemeManager.getTheme()))) {
					String path = ACTION_IMAGES_PATH + ITheme.ZK_THEME_DEFAULT + "/" + imageName;
					inputStream = action.getService().getClass().getClassLoader().getResourceAsStream(path);
				}
			}
			//fall back to plugin resource
			if (inputStream == null) {				
				String path = ACTION_IMAGES_PATH + imageName;
				inputStream = action.getService().getClass().getClassLoader().getResourceAsStream(path);
			}
			if (inputStream != null) {
				try {
					aImage = new AImage(actionId, inputStream);
				} catch (IOException e) {
				} finally {
					try {
						inputStream.close();
					} catch (IOException e) {}
				}
			}
			if (aImage != null) {
				synchronized (imageCache) {
					imageCache.put(actionId, aImage);
				}
			}
		}
		return aImage;
	}
	
	/**
	 * 
	 * @param actionId
	 * @return font icon sclass
	 */
	public static String getActionIconSclass(String actionId) {
		IServiceHolder<IAction> action = getAction(actionId);
		IAction service = action.getService();
		if (service != null) {
			return service.getIconSclass();
		}
		return "";
	}
}
