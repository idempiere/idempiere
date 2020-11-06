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

import java.util.Iterator;

import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Tabpanels;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 2, 2007
 * @version $Revision: 0.10 $
 */
public class Tabs extends org.zkoss.zul.Tabs implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4939779587719677815L;

	public Tabs()
    {
        super();
    }
	
	/**
	 * override to set drag/drop for {@link Tab} already add to {@link Tabs} before {@link Tabs} add to {@link Tabbox}
	 */
	@Override
	public void setParent(Component parent) {
		super.setParent(parent);
		if (parent == null || !(parent instanceof Tabbox)) {
			return;
		}
		
		Tabbox tabBox = (Tabbox)parent;
		
		// set drag/drop for tab already added to tabs
		for (Iterator<Component> it = getChildren().iterator(); it.hasNext();) {
			final Tab tabAdded = (Tab) it.next();
			if (tabBox.isSupportTabDragDrop()) {
				setDragDropTab(tabAdded);
			}else {
				unsetDragDropTab(tabAdded);
			}
		}
		
		// handle drop tab to tabs (end of tabs)
		if (tabBox.isSupportTabDragDrop()) {
			this.addEventListener(Events.ON_DROP, this);
			this.setDroppable(Boolean.TRUE.toString());
		}else {
			this.removeEventListener(Events.ON_DROP, this);
			this.setDroppable(Boolean.FALSE.toString());
		}
		
	}
	
	/**
	 * override to set drag|drop for tab depends on {@link Tabbox#isSupportTabDragDrop()}
	 */
	@Override
	public void onChildAdded(Component child) {
		super.onChildAdded(child);
		if (getTabbox() != null && getTabbox() instanceof Tabbox) {
			Tabbox tabbox = (Tabbox)getTabbox();
			if (child instanceof org.zkoss.zul.Tab && tabbox.isSupportTabDragDrop()) {
				org.zkoss.zul.Tab tab = (org.zkoss.zul.Tab)child;
				setDragDropTab(tab);
			}
		}
	}
	
	/**
	 * setup {@link Tab} to support drag|drop
	 * @param tab
	 */
	protected void setDragDropTab (org.zkoss.zul.Tab tab){
		tab.setDraggable("true");
		tab.setDroppable("true");
		//set org.zkoss.zk.ui.EventListener.duplicateIgnored=true, so don't worry about duplicate handle
		tab.addEventListener(Events.ON_DROP, this);
	}
	
	/**
	 * setup {@link Tab} to un-support drag|drop
	 * @param tab
	 */
	protected void unsetDragDropTab (org.zkoss.zul.Tab tab){
		tab.setDraggable("false");
		tab.setDroppable("false");
		tab.removeEventListener(Events.ON_DROP, this);
	}

	/**
	 * handle when user drop tab
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if (event != null && event instanceof DropEvent) {
			dragDropTab((DropEvent)event);
		}
	}
	
	/**
	 * implement handle drop a {@link Tab} to other {@link Tab} or {@link Tabs}
	 * @param dropEvent
	 */
	protected void dragDropTab(DropEvent dropEvent) {
		Component dropComp = dropEvent.getTarget();
		Component draggComp = dropEvent.getDragged();
		
		if (!isValidateDragDropComponent (dropComp, draggComp))
			return;
		
		Tabpanels tabpanels = this.getTabbox().getTabpanels();
		int dropIndex = -1;
		Component dropPanel = null;
		
		if (dropComp instanceof Tab) {
			dropIndex = this.getChildren().indexOf(dropComp);
			dropPanel = tabpanels.getChildren().get(dropIndex);
		}// other case is drop to tabs
		
		int draggIndex = this.getChildren().indexOf(draggComp);
		Component draggPanel = tabpanels.getChildren().get(draggIndex);
		
		if (dropIndex != -1 && draggIndex < dropIndex) {
			if (dropComp.getNextSibling() == null) {
				dropIndex = -1;// drop to end
				dropComp = null;
				dropPanel = null;
			}else {
				dropIndex = dropIndex + 1;// insert before of tab next to drop tab
				dropComp = dropComp.getNextSibling();
				dropPanel = tabpanels.getChildren().get(dropIndex);
			}
		}
		
		insertBefore(draggComp, dropComp);
		tabpanels.insertBefore(draggPanel, dropPanel);
		if (draggPanel.getPage() != null) {
			StringBuilder script = new StringBuilder("zk.Widget.$('#").append(draggPanel.getUuid()).append("').rerender(0);");
			Clients.evalJavaScript(script.toString());
		}
	}
	
	/**
	 * just allow drag|drop {@link Tab} on same {@link org.zkoss.zul.Tabs}
	 * @param dropComp
	 * @param draggComp
	 * @return
	 */
	protected boolean isValidateDragDropComponent(Component dropComp, Component draggComp) {
		if (dropComp == null || draggComp == null || !(dropComp instanceof org.zkoss.zul.Tab || dropComp instanceof org.zkoss.zul.Tabs) || !(draggComp instanceof Tab))// make sure drag and drop component is tab
			return false;
		
		if (dropComp instanceof org.zkoss.zul.Tabs && dropComp != this)// make sure drop on same tabs
			return false;
		
		if ((dropComp instanceof Tab && this != dropComp.getParent()) || this != draggComp.getParent())// make sure drag and drop on same tabbox
			return false;
		
		if ((dropComp instanceof org.adempiere.webui.component.Tab && ((org.adempiere.webui.component.Tab)dropComp).isDisableDraggDrop())
				|| (draggComp instanceof org.adempiere.webui.component.Tab && ((org.adempiere.webui.component.Tab)draggComp).isDisableDraggDrop())
				) {
			return false;
		}
		
		return true;
	}
}
