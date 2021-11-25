/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.component;

import java.net.URL;
import java.util.HashSet;
import java.util.Set;

import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ManageImageCache;
import org.compiere.model.MImage;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MUserDefInfo;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.image.Image;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.SelectEvent;
import org.zkoss.zul.Include;
import org.zkoss.zul.impl.LabelImageElement;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Tab extends org.zkoss.zul.Tab
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7504310693884092219L;
	private boolean isDisableDraggDrop = false;
	
	public Tab(String str)
    {
    	this.setLabel(str);
    }

    public Tab()
    {

    }

    public void setDecorateInfo (DecorateInfo decorateInfo){
    	if (decorateInfo != null)
    		decorateInfo.decorate(this);
    }
    
	@Override
	public void onClose() {
		Tabpanel tp = (Tabpanel) getLinkedPanel();
		if (tp != null) {
			tp.onClose();
		}
	}

	public boolean isDisableDraggDrop() {
		return isDisableDraggDrop;
	}

	/**
	 * home tab don't want to drag and drop. 
	 * {@link Tab} like that can be set true for this properties
	 * @param isDisableDraggDrop
	 */
	public void setDisableDraggDrop(boolean isDisableDraggDrop) {
		this.isDisableDraggDrop = isDisableDraggDrop;
	}

	/**
	 * class contain decorate info
	 * at the moment, has only image info
	 * at the moment, it's use to transfer decorate info from info window, standard window, report, process,... to tab
	 * @author hieplq
	 *
	 */
	public static class DecorateInfo {
		private String imageKey;
		private URL imageIntenalUrl;
		
		public void decorate (LabelImageElement comp){
			if (imageIntenalUrl != null) {
				if (ThemeManager.isUseFontIconForImage()) {
					String iconClass = imageIntenalUrl.getFile().replace("16.png", "").replaceAll(".*\\/", "");
					comp.setIconSclass("z-icon-" + iconClass);
				} else {
					Image image = ManageImageCache.instance().getImage(imageIntenalUrl);
					if (image != null)
						comp.setImageContent(image);
				}
			} else if (imageKey != null){
				Image ico = ManageImageCache.instance().getImage(imageKey);
				if (ico != null)
					comp.setImageContent(ico);
			}
		}
		
		public DecorateInfo (MImage imageData){
			if (imageData != null) {
				imageIntenalUrl = ManageImageCache.getImageInternalUrl(imageData);
				if (imageIntenalUrl == null)
					imageKey = ManageImageCache.instance().loadImage(imageData);
			}
		}
		
		public DecorateInfo (String imagePath){
			if (imagePath != null) {
				imageIntenalUrl = ManageImageCache.getImageInternalUrl(imagePath);
				if (imageIntenalUrl == null)
					imageKey = imagePath;
			}
		}
		
		/**
		 * Helper method for create decorate info from adWindow info
		 * @param adWindow
		 * @return
		 */
		public static DecorateInfo get (ADWindow adWindow){
			return adWindow == null?null:new DecorateInfo(adWindow.getMImage());
		}
		
		public static DecorateInfo get (MInfoWindow mInfo){

			if (mInfo != null) {
				String image = mInfo.getImageURL();
				MUserDefInfo userDef = MUserDefInfo.getBestMatch(Env.getCtx(), mInfo.getAD_InfoWindow_ID());
				if (userDef != null && !Util.isEmpty(userDef.getImageURL()))
					image = userDef.getImageURL();

				return new DecorateInfo(image);
			}
			return null;
		}
	}
	
	/**
	 * copy from {@link org.zkoss.zul.Tab#close()} to work-around for http://tracker.zkoss.org/browse/ZK-3705
	 */
	@Override
	public void close() {
		if (isSelected()) {
			final org.zkoss.zul.Tab tab = selectNextTabWR();
			if (tab != null) {
				final Set<org.zkoss.zul.Tab> selItems = new HashSet<>(2);
				selItems.add(tab);
				Events.postEvent(new SelectEvent<org.zkoss.zul.Tab, Object>(Events.ON_SELECT, tab, selItems));
			}
		}
		org.zkoss.zul.Tabbox tabbox = getTabbox();

		// Nothing to do according to ZK-2027 issue, let application developer to do so.
		if (tabbox != null && tabbox.getModel() != null)
			return;

		//Cache panel before detach , or we couldn't get it after tab is detached.
		final org.zkoss.zul.Tabpanel panel = getLinkedPanel();

		if (getTabbox() instanceof Tabbox) {
			((Tabbox)getTabbox()).removeTabFromActiveSeq(this);
		}

		detach();
		
		if (panel != null) {
			// B60-ZK-1160: Exception when closing tab with included content
			// Must clean up included content before detaching tab panel
			Component include = panel.getFirstChild();
			if (include instanceof Include) {
				include.detach();
			}
			panel.detach();
		}
	}
	
	/**
	 * http://tracker.zkoss.org/browse/ZK-3705
	 * change default behavior to get prev tab is new active tab
	 * @return
	 */
	protected org.zkoss.zul.Tab selectNextTabWR() {
		Tabbox idTabbox = null;
		if (getTabbox() instanceof Tabbox) {
			idTabbox = (Tabbox)getTabbox();
		}
		
		if (idTabbox != null && idTabbox.isActiveBySeq()) {
			org.zkoss.zul.Tab nextActiveTab = idTabbox.getNextActiveBySeq(this);
			if (nextActiveTab != null) {
				nextActiveTab.setSelected(true);
				return nextActiveTab;
			}
		}
		
		for (org.zkoss.zul.Tab tab = (org.zkoss.zul.Tab) getPreviousSibling(); tab != null; tab = (org.zkoss.zul.Tab) tab.getPreviousSibling())
			if (!tab.isDisabled()) {
				tab.setSelected(true);
				return tab;
			}
		for (org.zkoss.zul.Tab tab = (org.zkoss.zul.Tab) getNextSibling(); tab != null; tab = (org.zkoss.zul.Tab) tab.getNextSibling())
			if (!tab.isDisabled()) {
				tab.setSelected(true);
				return tab;
			}
		return null;
	}
}
