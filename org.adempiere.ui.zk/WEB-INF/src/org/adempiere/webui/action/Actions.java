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

import org.adempiere.webui.WebUIActivator;
import org.compiere.util.CCache;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Filter;
import org.osgi.framework.InvalidSyntaxException;
import org.osgi.service.component.ComponentConstants;
import org.osgi.util.tracker.ServiceTracker;
import org.zkoss.image.AImage;

/**
 * 
 * @author hengsin
 *
 */
public class Actions {

	private static final String ACTION_IMAGES_PATH = "/action/images/";
	private static CCache<String, ServiceTracker<IAction, IAction>> trackerCache = new CCache<String, ServiceTracker<IAction,IAction>>("ActionsServiceTracker", 5);
	private static CCache<String, AImage> imageCache = new CCache<String, AImage>("ActionsImages",5);
	
	private static final String COMPONENT_FILTER = "(&(objectclass=org.adempiere.webui.action.IAction)("
			+ ComponentConstants.COMPONENT_NAME + "=?))";
	
	public static ServiceTracker<IAction, IAction> getActionTracker(String actionId) {
		ServiceTracker<IAction, IAction> actionTracker = null;
		synchronized (trackerCache) {
			actionTracker = trackerCache.get(actionId);
		}
		if (actionTracker != null)
			return actionTracker;
		BundleContext context = WebUIActivator.getBundleContext();
		Filter filter = null;
		try {
			String sFilter = COMPONENT_FILTER.replaceFirst("[?]", actionId);
			filter = context.createFilter(sFilter);
		} catch (InvalidSyntaxException e) {
			e.printStackTrace();
		}

		actionTracker = new ServiceTracker<IAction, IAction>(context, filter, null);
		if (actionTracker != null) {
			actionTracker.open();
			synchronized (trackerCache) {
				trackerCache.put(actionId, actionTracker);
			}
		}
		return actionTracker;
	}
	
	public static AImage getActionImage(String actionId) {
		AImage aImage = null;
		synchronized (imageCache) {
			aImage = imageCache.get(actionId);
		}
		if (aImage != null)
			return aImage;
		
		String path = ACTION_IMAGES_PATH + actionId + "24.png";
		InputStream inputStream = Actions.class.getClassLoader().getResourceAsStream(path);
		if (inputStream != null) {
			try {
				aImage = new AImage(actionId, inputStream);
			} catch (IOException e) {
			}
		}
		if (aImage != null) {
			synchronized (imageCache) {
				imageCache.put(actionId, aImage);
			}
		}
		return aImage;
	}
}
