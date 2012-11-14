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

package org.adempiere.webui.adwindow;

import java.io.IOException;
import java.util.Properties;

import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.part.AbstractUIPart;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MImage;
import org.compiere.model.MQuery;
import org.compiere.util.CCache;
import org.zkoss.image.AImage;
import org.zkoss.zk.ui.Component;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class ADWindow extends AbstractUIPart
{
    private ADWindowContent windowContent;
    private Properties ctx;
    private int adWindowId;
    private String _title;
    private int windowNo;

	private MQuery query;

	private Component windowPanelComponent;
	private MImage image;
	
	private static final CCache<Integer, AImage> imageCache = new CCache<Integer, AImage>("WindowImageCache", 5);
    
    public ADWindow(Properties ctx, int adWindowId)
    {
       this(ctx, adWindowId, null);
    }
    
    public ADWindow(Properties ctx, int adWindowId, MQuery query)
    {
    	 if(adWindowId <= 0)
             throw new IllegalArgumentException("Window Id is invalid");
         
         this.ctx = ctx;
         this.adWindowId = adWindowId;
         windowNo = SessionManager.getAppDesktop().registerWindow(this);
         this.query = query;
         init();
    }
    
    private void init()
    {
        windowContent = new ADWindowContent(ctx, windowNo, adWindowId);      
        _title = windowContent.getTitle();
        image = windowContent.getImage();
    }
    
    public String getTitle()
    {
        return _title;
    }
    
    public MImage getMImage()
    {
    	return image;
    }
    
    public AImage getAImage() throws IOException {
    	MImage image = getMImage();
    	AImage aImage = null;
    	if (image != null) {
    		synchronized (imageCache) {
    			aImage = imageCache.get(image.getAD_Image_ID());
			}
    		if (aImage == null) {
    			aImage = new AImage(image.getName(), image.getData());
    			synchronized (imageCache) {
    				imageCache.put(image.getAD_Image_ID(), aImage);
    			}
    		}
    	}
		return aImage;
	}
    
    protected Component doCreatePart(Component parent) 
    {
    	windowPanelComponent = windowContent.createPart(parent);
    	windowPanelComponent.setAttribute("ADWindow", this);
    	windowPanelComponent.setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, windowNo);
    	if (windowContent.initPanel(query))
    	{
    		return windowPanelComponent;
    	}
    	else
    	{
    		windowPanelComponent.detach();
    		return null;
    	}
    }

	public Component getComponent() {
		return windowPanelComponent;
	}	
	
	/**
	 * @return ADWindowContent
	 */
	public ADWindowContent getADWindowContent() {
		return windowContent;
	}
	
	public static ADWindow get(int windowNo) {
		return (ADWindow) SessionManager.getAppDesktop().findWindow(windowNo);
	}
}
