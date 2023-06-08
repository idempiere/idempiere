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

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.compiere.util.KeyNamePair;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Listitem;

/**
 * Extend {@link org.zkoss.zul.Listbox}
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Listbox extends org.zkoss.zul.Listbox implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3713350125429939476L;

	private List<EventListener<Event>> doubleClickListeners = new ArrayList<EventListener<Event>>();
    private List<EventListener<Event>> onDropListeners = new ArrayList<EventListener<Event>>();
	private boolean draggable;
	private String oddRowSclass;
	
	/**
	 * Default Constructor
	 */
    public Listbox() {
		super();
		//cache default
		oddRowSclass = super.getOddRowSclass();
		super.setOddRowSclass(oddRowSclass);
	}
    
    /**
     * Create Listbox with items from pairs
     * @param pairs KeyNamePair[]
     */
    public Listbox(KeyNamePair[] pairs) {
    	super();
    	if (pairs != null && pairs.length > 0) {
    		for(KeyNamePair pair : pairs) {
    			this.appendItem(pair.getName(), pair.getKey());
    		}
    	}
    	//cache default
		oddRowSclass = super.getOddRowSclass();
		super.setOddRowSclass(oddRowSclass);
    }

    /**
     * Set enable/disable listbox
     * @param enabled
     */
	public void setEnabled(boolean enabled)
    {
        this.setDisabled(!enabled);
    }
    
	/**
	 * @return true if enable, false otherwise
	 */
    public boolean isEnabled()
    {
        return !this.isDisabled();
    }
    
    /**
     * Add and return new {@link ListItem}
     * @param label
     * @param value
     * @return ListItem
     */
    public ListItem appendItem(String label, Object value)
    {
        ListItem item = new ListItem(label, value);
        super.appendChild(item);
        return item;
    }

    /**
     * Add and return new {@link ListItem}
     * @param label
     * @param value
     */
    public ListItem appendItem(String label, String value)
    {
        ListItem item = new ListItem(label, value);
        super.appendChild(item);
        return item;
    }
    
    /**
     * @param index
     * @return ListItem at index
     */
    public ListItem getItemAtIndex(int index)
    {
        return (ListItem)super.getItemAtIndex(index);
    }
    
    /**
     * @return Current selected ListItem
     */
    public ListItem getSelectedItem()
    {
        return (ListItem)super.getSelectedItem();
    }
    
    /** 
     * Set selected item for the list box based on the value of list item.<br/>
     * Set selected to none if no item found matching the value given or 
     * value is null.
     * @param value Value of ListItem to set as selected
     */
    public void setValue(Object value)
    {
        setSelectedItem(null);
        
        if (value == null)
        {
            return ;
        }
        
        List<Listitem> items = getItems();
        for (Listitem item : items)
        {
        	if (value.getClass() != item.getValue().getClass()) {
        		// if the classes of value and item are different convert both to String
        		String stringValue = value.toString();
        		String stringItem = item.getValue().toString();
                if (stringValue.equals(stringItem))
                {
                    setSelectedItem(item);
                    break;
                }
        	} else {
                if (value.equals(item.getValue()))
                {
                    setSelectedItem(item);
                    break;
                }
        	}
        }
    }
    
    /**
     * @return ListHead
     */
    public ListHead getListHead()
    {
    	return (ListHead)super.getListhead();
    }

    /**
     * @return int[] selected indices
     */
	public int[] getSelectedIndices() {
		Set<Listitem> selectedItems = this.getSelectedItems();
		int[] selecteds = new int[this.getSelectedCount()];
		int i = 0;
		for (Object obj : selectedItems) {
			ListItem listItem = (ListItem) obj;
			selecteds[i] = this.getIndexOfItem(listItem);
			i++;
		}
		return selecteds;
	}
	
	/**
	 * Set selected indices
	 * @param selected int[] selected indices
	 */
	public void setSelectedIndices(int[] selected) {
		if (selected != null && selected.length > 0) {
			this.setSelectedIndex(selected[0]);
			for(int i = 1; i < selected.length; i++) {
				this.addItemToSelection(getItemAtIndex(selected[i]));
			}
		} else {
			this.clearSelection();
		}
	}

	/**
	 * Add listener for ON_DROP event
	 * @param listener
	 */
	public void addOnDropListener(EventListener<Event> listener) {
		onDropListeners.add(listener);
	}

	/**
	 * Add listener for DOUBLE_CLICK event
	 * @param listener
	 */
	public void addDoubleClickListener(EventListener<Event> listener) {
		doubleClickListeners.add(listener);
	}
	
	@Override
	public boolean insertBefore(Component newChild, Component refChild) {
		if (newChild instanceof ListItem) {
			newChild.addEventListener(Events.ON_DOUBLE_CLICK, this);
			if (onDropListeners.size() > 0) {
				((ListItem)newChild).setDroppable("true");	
				newChild.addEventListener(Events.ON_DROP, this);
			}
			if (isItemDraggable()) {
				((ListItem)newChild).setDraggable("true");
			}
		}
		return super.insertBefore(newChild, refChild);
	}

	/**
	 * @return true if ListItem should be draggable
	 */
	public boolean isItemDraggable() {
		return draggable;
	}
	
	/**
	 * @param b true to enable draggable support for ListItem
	 */
	public void setItemDraggable(boolean b) {
		draggable = b;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_DOUBLE_CLICK.equals(event.getName()) && !doubleClickListeners.isEmpty()) {
			for(EventListener<Event> listener : doubleClickListeners) {
				listener.onEvent(event);
			}
		} else if (Events.ON_DROP.equals(event.getName()) && !onDropListeners.isEmpty()) {
			for(EventListener<Event> listener : onDropListeners) {
				listener.onEvent(event);
			}
		}
	}

	/**
	 * shortcut for appendItem(pp.getName(), pp.getKey()), to ease porting of swing form
	 * @param pp
	 */
	public void addItem(KeyNamePair pp) {
		appendItem(pp.getName(), pp.getKey());
	}

	/**
	 * remove all items, to ease porting of swing form
	 */
	public void removeAllItems() {
		int cnt = getItemCount();
		for (int i = cnt - 1; i >=0; i--) {
			removeItemAt(i);
		}
	}

	/**
	 * alias for removeEventListener(Events.ON_SELECT, listener), to ease porting of swing form
	 * @param listener
	 */
	public void removeActionListener(EventListener<Event> listener) {
		removeEventListener(Events.ON_SELECT, listener);
	}

	/**
	 * alias for addEventListener(Events.ON_SELECT, listener), to ease porting of swing form
	 * @param listener
	 */
	public void addActionListener(EventListener<Event> listener) {
		addEventListener(Events.ON_SELECT, listener);
	}

	/**
	 * shortcut for appendItem(pp.getName(), pp.getValue()), to ease porting of swing form
	 * @param pp
	 */
	public void addItem(ValueNamePair pp) {
		appendItem(pp.getName(), pp.getValue());
	}

	/**
	 * select selected item base on vp.getValue, to ease porting of swing form
	 * @param vp ValueNamePair
	 */
	public void setSelectedValueNamePair(ValueNamePair vp) {
		int count = this.getItemCount();
		for(int i = 0; i < count; i++) {
			ListItem item = getItemAtIndex(i);
			if (vp.getValue().equals(item.getValue())) {
				setSelectedIndex(i);
				break;
			}
		}
	}
	

	/**
	 * select selected item base on kp.getKey, to ease porting of swing form
	 * @param kp KeyNamePair
	 */
	public void setSelectedKeyNamePair(KeyNamePair kp) {
		int count = this.getItemCount();
		for(int i = 0; i < count; i++) {
			ListItem item = getItemAtIndex(i);
			if (item.getValue() instanceof Integer) {
				if (kp.getKey() == (Integer)item.getValue()) {
					setSelectedIndex(i);
					break;
				}
			}
		}
	}

	@Override
	protected void afterInsert(Component comp) {
		super.afterInsert(comp);
		if ("select".equals(getMold()) && comp instanceof Listitem) {
			if (getSelectedIndex() < 0 && getItemCount() > 0) {
				setSelectedIndex(0);
			}
		}
	}
	 
	@Override
	public boolean removeChild(Component child) {
		boolean b = super.removeChild(child);
		if (b) {
			if ("select".equals(getMold()) && child instanceof Listitem) {
				if (getSelectedIndex() < 0 && getItemCount() > 0) {
					setSelectedIndex(0);
				}
			}
		}
		return b;
	}    

	@Override
	public String getOddRowSclass() {
		if (oddRowSclass == null)
			return null;
		else
			return super.getOddRowSclass();
	}

	@Override
	public void setOddRowSclass(String scls) {
		if (scls != null && scls.length() == 0)
			oddRowSclass = null;
		else
			oddRowSclass = scls;
		super.setOddRowSclass(scls);
	}
	
	@Override
	public String toString() {
		StringBuilder items = new StringBuilder("[");
		for (Listitem item : getItems()) {
			if (items.length() > 1)
				items.append(", ");
			items.append(item.toString());
		}
		items.append("]");
		return items.toString();
	}

	/** 
	 * Get selected item for the list box based on the value of list item
	 * @return Value of selected ListItem
	 */
	public Object getValue()
	{
		ListItem item = getSelectedItem();

		return item.getValue();

	}

}
