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

package org.adempiere.webui.editor;

import java.util.ArrayList;

import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.compiere.model.Lookup;
import org.compiere.model.MRole;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Menuitem;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 25, 2007
 * @version $Revision: 0.10 $
 */
public class WEditorPopupMenu extends Menupopup implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7826535512581441259L;

	public static final String EVENT_ATTRIBUTE = "EVENT";
    public static final String ZOOM_EVENT = "ZOOM";
    public static final String REQUERY_EVENT = "REQUERY";
    public static final String PREFERENCE_EVENT = "VALUE_PREFERENCE";
    public static final String NEW_EVENT = "NEW_RECORD";
    public static final String UPDATE_EVENT = "UPDATE_RECORD"; // Elaine 2009/02/16 - update record
    public static final String SHOWLOCATION_EVENT = "SHOW_LOCATION";
    public static final String CHANGE_LOG_EVENT = "CHANGE_LOG";
    public static final String EDITOR_EVENT = "EDITOR";
   
    private boolean newEnabled = true;
    private boolean updateEnabled = true; // Elaine 2009/02/16 - update record
    private boolean zoomEnabled  = true;
    private boolean requeryEnabled = true;
    private boolean preferencesEnabled = true;
	private boolean showLocation = true;
    
    private Menuitem zoomItem;
    private Menuitem requeryItem;
    private Menuitem prefItem;
    private Menuitem newItem;
    private Menuitem updateItem; // Elaine 2009/02/16 - update record   
	private Menuitem showLocationItem;
    
    private ArrayList<ContextMenuListener> menuListeners = new ArrayList<ContextMenuListener>();
    
    public WEditorPopupMenu(boolean zoom, boolean requery, boolean preferences)
    {
        this(zoom, requery, preferences, false, false, false, null); // no check zoom
    }
    
    @Deprecated
    public WEditorPopupMenu(boolean zoom, boolean requery, boolean preferences, boolean newRecord)
    {
    	this(zoom, requery, preferences, newRecord, false, false, null);
    }
    
    @Deprecated
    public WEditorPopupMenu(boolean zoom, boolean requery, boolean preferences, boolean newRecord, boolean updateRecord)
    {
    	this(zoom, requery, preferences, newRecord, updateRecord, false, null);
    }

    @Deprecated
    public WEditorPopupMenu(boolean zoom, boolean requery, boolean preferences, boolean newRecord, boolean updateRecord, boolean showLocation)
    {
    	this(zoom, requery, preferences, newRecord, updateRecord, false, null);
    }

    /**
     * @param zoom - enable zoom in menu - disabled if the lookup cannot zoom
     * @param requery - enable requery in menu
     * @param preferences - enable preferences in menu
     * @param newRecord - enable new record (ignored and recalculated if lookup is received)
     * @param updateRecord - enable update record (ignored and recalculated if lookup is received)
     * @param showLocation - enable show location in menu
     * @param lookup - when this parameter is received then new and update are calculated based on the zoom and quickentry
     */
    public WEditorPopupMenu(boolean zoom, boolean requery, boolean preferences, boolean newRecord, boolean updateRecord, boolean showLocation, Lookup lookup)
    {
    	super();
    	this.zoomEnabled = zoom;
    	this.requeryEnabled = requery;
    	this.preferencesEnabled = preferences;
    	this.newEnabled = newRecord;
    	this.updateEnabled = updateRecord; // Elaine 2009/02/16 - update record
    	this.showLocation = showLocation;
    	if (lookup != null) {
    		int winID = lookup.getZoom();
    		Boolean canAccess = MRole.getDefault().getWindowAccess(winID);
    		if (winID <= 0 || canAccess == null || ! canAccess) {
    	    	this.zoomEnabled = false;
    	    	this.newEnabled = false;
    	    	this.updateEnabled = false;
    		} else {
    			int cnt = DB.getSQLValueEx(null,
    					"SELECT COUNT(*) "
    							+ "FROM   AD_Field f "
    							+ "       JOIN AD_Tab t "
    							+ "         ON ( t.AD_Tab_ID = f.AD_Tab_ID ) "
    							+ "WHERE  t.AD_Window_ID = ? "
    							+ "       AND f.IsActive = 'Y' "
    							+ "       AND t.IsActive = 'Y' "
    							+ "       AND f.IsQuickEntry = 'Y' ",
    					winID);
    			if (cnt > 0) {
        	    	this.newEnabled = true;
        	    	this.updateEnabled = true;
    			} else {
        	    	this.newEnabled = false;
        	    	this.updateEnabled = false;
    			}
    		}
    	}
    	init();
    }

	public boolean isZoomEnabled() {
    	return zoomEnabled;
    }
    
    private void init()
    {
        if (zoomEnabled)
        {
            zoomItem = new Menuitem();
            zoomItem.setAttribute(EVENT_ATTRIBUTE, ZOOM_EVENT);
            zoomItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Zoom")));
            zoomItem.setImage("/images/Zoom16.png");
            zoomItem.addEventListener(Events.ON_CLICK, this);
            
            this.appendChild(zoomItem);
        }
        
        if (requeryEnabled)
        {
            requeryItem = new Menuitem();
            requeryItem.setAttribute(EVENT_ATTRIBUTE, REQUERY_EVENT);
            requeryItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
            requeryItem.setImage("/images/Refresh16.png");
            requeryItem.addEventListener(Events.ON_CLICK, this);
            this.appendChild(requeryItem);
        }
        
        if (preferencesEnabled)
        {
            prefItem = new Menuitem();
            prefItem.setAttribute(EVENT_ATTRIBUTE, PREFERENCE_EVENT);
            prefItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ValuePreference")));
            prefItem.setImage("/images/VPreference16.png");
            prefItem.addEventListener(Events.ON_CLICK, this);
            this.appendChild(prefItem);
        }
        
        if (newEnabled)
        {
        	newItem = new Menuitem();
        	newItem.setAttribute(EVENT_ATTRIBUTE, NEW_EVENT);
        	newItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "New")));
        	newItem.setImage("/images/New16.png");
        	newItem.addEventListener(Events.ON_CLICK, this);
        	this.appendChild(newItem);
        }
        
        // Elaine 2009/02/16 - update record
        if (updateEnabled)
        {
        	updateItem = new Menuitem();
        	updateItem.setAttribute(EVENT_ATTRIBUTE, UPDATE_EVENT);
        	updateItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Update")));
        	updateItem.setImage("/images/InfoBPartner16.png");
        	updateItem.addEventListener(Events.ON_CLICK, this);
        	this.appendChild(updateItem);
        }
        //
        if (showLocation)
        {
        	showLocationItem = new Menuitem();
        	showLocationItem.setAttribute(EVENT_ATTRIBUTE, SHOWLOCATION_EVENT);
        	showLocationItem.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ShowLocation")));
        	showLocationItem.setImage("/images/InfoBPartner16.png");
        	showLocationItem.addEventListener(Events.ON_CLICK, this);
        	this.appendChild(showLocationItem);
        }
        
    }
    
    public void addMenuListener(ContextMenuListener listener)
    {
    	if (!menuListeners.contains(listener))
    		menuListeners.add(listener);
    }

    public void onEvent(Event event)
    {
        String evt = (String)event.getTarget().getAttribute(EVENT_ATTRIBUTE);
        
        if (evt != null)
        {
            ContextMenuEvent menuEvent = new ContextMenuEvent(evt);
            
            ContextMenuListener[] listeners = new ContextMenuListener[0];
            listeners = menuListeners.toArray(listeners);
            for (ContextMenuListener listener : listeners)
            {
                listener.onMenu(menuEvent);
            }
        }
    }
}
