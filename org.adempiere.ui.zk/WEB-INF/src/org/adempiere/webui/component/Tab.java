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

import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.util.ManageImageCache;
import org.compiere.model.MImage;
import org.compiere.model.MInfoWindow;
import org.zkoss.image.Image;
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
	private static final long serialVersionUID = -5146887728183695020L;

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

	/**
	 * class contain decorate info
	 * at the moment, has only image info
	 * at the moment, it's use to transfer decorate info from info window, standard window, report, process,... to tab
	 * @author hieplq
	 *
	 */
	public static class DecorateInfo {
		private String imageKey;
		private String imageIntenalUrl;
		
		public void decorate (LabelImageElement comp){
			if (imageIntenalUrl != null)
				comp.setImage(imageIntenalUrl);
			else if (imageKey != null){
				Image ico = ManageImageCache.instance().getImage(imageKey);
				if (ico != null)
					comp.setImageContent(ico);
			}
		}
		
		public DecorateInfo (MImage imageData){
			imageIntenalUrl = ManageImageCache.getImageInternalUrl(imageData);
			if (imageIntenalUrl == null)
				imageKey = ManageImageCache.instance().loadImage(imageData);
		}
		
		public DecorateInfo (String imagePath){
			imageIntenalUrl = ManageImageCache.getImageInternalUrl(imagePath);
			if (imageIntenalUrl == null)
				imageKey = imagePath;
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
			return mInfo==null?null:new DecorateInfo(mInfo.getImageURL());
		}
	}
}
