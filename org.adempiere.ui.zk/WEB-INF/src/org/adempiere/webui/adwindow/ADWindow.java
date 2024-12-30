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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.part.AbstractUIPart;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MImage;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MToolBarButton;
import org.compiere.model.MToolBarButtonRestrict;
import org.compiere.model.MWindow;
import org.compiere.model.X_AD_ToolBarButton;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;

/**
 * Controller for AD_Window UI
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 */
public class ADWindow extends AbstractUIPart
{
	/** Component attribute to hold reference to ancestor ADWindow instance **/
    public static final String AD_WINDOW_ATTRIBUTE_KEY = "org.adempiere.webui.adwindow";
    /** Controller for AD_Window content (toolbar, tabbox, statusbar, etc) **/
	private ADWindowContent windowContent;
	/** Environment Context **/
    private Properties ctx;
    /** AD_Window_ID **/
    private int adWindowId;
    private String windowTitle;
    private int windowNo;

    /** initial query when AD Window is first open **/
	private MQuery query;
	/** main component of ADWindowContent **/
	private Component windowPanelComponent;
	/** image for window (desktop tab) title **/
	private MImage image;
    /** AD_Tab_ID:BtnComponentName. List of toolbar buttons to exclude, loaded from AD_ToolBarButtonRestrict **/
	private Map<Integer, List<String>> tabToolbarRestricMap = new HashMap<Integer, List<String>>();
	/** List of BtnComponentName to exclude, loaded from AD_ToolBarButtonRestrict **/
	private List<String> windowToolbarRestrictList = null;
	/** List of advanced (IsAdvancedButton=Y) window toolbar buttons. Accessible by advanced role only. **/
	private List<String> windowToolbarAdvancedList = null;
	/** AD_Window_UU value **/
	private String adWindowUUID;
	
	/**
	 * @param ctx
	 * @param adWindowId
	 */
    public ADWindow(Properties ctx, int adWindowId)
    {
       this(ctx, adWindowId, null);
    }
    
    /**
     * @param ctx
     * @param adWindowId
     * @param query
     */
    public ADWindow(Properties ctx, int adWindowId, MQuery query)
    {
    	 if(adWindowId <= 0)
             throw new IllegalArgumentException("Window Id is invalid");
         
         this.ctx = ctx;
         this.adWindowId = adWindowId;
         MWindow window = MWindow.get(ctx, adWindowId);
         this.adWindowUUID = window.getAD_Window_UU();
         windowNo = SessionManager.getAppDesktop().registerWindow(this);
         Env.setPredefinedVariables(ctx, windowNo, window.getPredefinedContextVariables());
         this.query = query;
         try {
             init();
         } catch (Exception e) {
        	 SessionManager.getAppDesktop().unregisterWindow(windowNo);
        	 throw new ApplicationException(e.getMessage(), e);
         }
    }
    
    /**
     * Create ADWindowContent
     */
    private void init()
    {
        windowContent = new ADWindowContent(ctx, windowNo, adWindowId);      
        windowContent.setADWindow(this);
        windowTitle = windowContent.getTitle();
        image = windowContent.getImage();
    }
    
    /**
     * Get window title
     * @return title of window
     */
    public String getTitle()
    {
        return windowTitle;
    }
    
    /**
     * Get image for window title
     * @return image for window title
     */
    public MImage getMImage()
    {
    	return image;
    }
    
    /**
     * Create component for content part (ADWindowContent).
     * @see ADWindowContent#createPart(Object)
     */
    @Override
    protected Component doCreatePart(Component parent) 
    {
    	windowPanelComponent = windowContent.createPart(parent);
    	windowPanelComponent.setAttribute(AD_WINDOW_ATTRIBUTE_KEY, this);
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

    @Override
	public Component getComponent() {
		return windowPanelComponent;
	}	
	
	/**
	 * Get ADWindowContent instance
	 * @return ADWindowContent
	 */
	public ADWindowContent getADWindowContent() {
		return windowContent;
	}
	
	/**
	 * Get list of toolbar button to exclude/restrict for current login role
	 * @param AD_Tab_ID
	 * @return list of toolbar button to exclude/restrict for current login role
	 */
	public List<String> getTabToolbarRestrictList(int AD_Tab_ID) {
		List<String> tabRestrictList = tabToolbarRestricMap.get(AD_Tab_ID);
        if (tabRestrictList == null) {
        	tabRestrictList = new ArrayList<String>();
        	tabToolbarRestricMap.put(AD_Tab_ID, tabRestrictList);
        	int[] restrictionList = MToolBarButtonRestrict.getOfTab(Env.getCtx(), MRole.getDefault().getAD_Role_ID(), 
        			adWindowId, AD_Tab_ID, null);
    		
			for (int i = 0; i < restrictionList.length; i++)
			{
				int ToolBarButton_ID= restrictionList[i];

				X_AD_ToolBarButton tbt = new X_AD_ToolBarButton(Env.getCtx(), ToolBarButton_ID, null);
				String restrictName = ADWindowToolbar.BTNPREFIX + tbt.getComponentName();
				tabRestrictList.add(restrictName);
			}
        }
        return tabRestrictList;
	}
	
	/**
	 * Get list of window toolbar button to exclude/restrict for current login role
	 * @return list of window toolbar button to exclude/restrict for current login role
	 */
	public List<String> getWindowToolbarRestrictList() {		
		if (windowToolbarRestrictList == null) {
			//load window restriction
			windowToolbarRestrictList = new ArrayList<String>();
	        int[] restrictionList = MToolBarButtonRestrict.getOfWindow(Env.getCtx(), MRole.getDefault().getAD_Role_ID(), adWindowId, false, null);
	
			for (int i = 0; i < restrictionList.length; i++)
			{
				int ToolBarButton_ID= restrictionList[i];
	
				X_AD_ToolBarButton tbt = new X_AD_ToolBarButton(Env.getCtx(), ToolBarButton_ID, null);
				String restrictName = ADWindowToolbar.BTNPREFIX + tbt.getComponentName();
				windowToolbarRestrictList.add(restrictName);		
			}	// All restrictions
		}
		return windowToolbarRestrictList;
	}
	
	/**
	 * Get list of advance (IsAdvancedButton=Y) toolbar buttons for window
	 * @return list of advance (IsAdvancedButton=Y) toolbar buttons for window
	 */
	public List<String> getWindowAdvancedButtonList() {		
		if (windowToolbarAdvancedList == null) {
			//load window advance buttons
			windowToolbarAdvancedList = new ArrayList<String>();			
	        MToolBarButton[] buttons = MToolBarButton.getWindowAdvancedButtons();
	
			for (int i = 0; i < buttons.length; i++)
			{
				String restrictName = ADWindowToolbar.BTNPREFIX + buttons[i].getComponentName();
				windowToolbarAdvancedList.add(restrictName);		
			}	// All restrictions
		}
		return windowToolbarAdvancedList;
	}

	/**
	 * Get AD_Window_ID
	 * @return AD_Window_ID
	 */
	public int getAD_Window_ID() {
		return adWindowId;
	}
	
	/**
	 * Get AD_Window_UU
	 * @return AD_Window_UU
	 */
	public String getAD_Window_UU() {
		return adWindowUUID;
	}
	
	/**
	 * Get ADWindow instance by window number
	 * @param windowNo
	 * @return {@link ADWindow} instance for windowNo ( if any )
	 */
	public static ADWindow get(int windowNo) {
		Object window = SessionManager.getAppDesktop().findWindow(windowNo);
		if (window != null && window instanceof ADWindow)
			return (ADWindow) SessionManager.getAppDesktop().findWindow(windowNo);
		
		return null;
	}
	
	/**
	 * Find ADWindow instance that's the ancestor of comp
	 * @param comp
	 * @return {@link ADWindow} instance if found, null otherwise
	 */
	public static ADWindow findADWindow(Component comp) {
		Component parent = comp;
		while(parent != null) {
			if (parent.getAttribute(AD_WINDOW_ATTRIBUTE_KEY) != null) {
				ADWindow adwindow = (ADWindow) parent.getAttribute(AD_WINDOW_ATTRIBUTE_KEY);
				return adwindow;
			}
			parent = parent.getParent();
		}
		return null;
	}
}
