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

import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;

import org.adempiere.webui.theme.ThemeManager;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zul.Comboitem;

/**
 * 	Auto-complete with combobox.<br/>
 * 	Based on ZK's Auto-complete.
 * 
 * 	@author Niraj Sohun
 * 			Aug 20, 2007
 */
public class AutoComplete extends Combobox 
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 7437206681528058083L;

	/** comboItems	All items	 */
	private String[] comboItems;
	
	/** strDescription	Description of items	 */
	private String[] strDescription;
	
	/** Image url or font icon sclass */
	private String[] images;

	/** Content for comboitem */
	private String[] contents;
	
	/** Value object for comboitem */
	private Object[] values;

	/** Comboitem:Content. Content is from {@link #contents} */
	private HashMap<Comboitem, String> mapItems = new HashMap<Comboitem, String>();

	/**
	 * Set items
	 * @param vals	Menu labels
	 */	
	public void setDict(String[] vals)
	{
		setDict(vals, true);
	}
	
	/**
	 * Set items
	 * @param vals values
	 * @param sort true to sort in natural order
	 */
	public void setDict(String[] vals, boolean sort)
	{
		comboItems = vals;
		
		if (comboItems != null && sort)
		{
			Arrays.sort(comboItems);
		}
	}
	
	/**
	 * Set description of items
	 * 
	 * @param vals	Description of items
	 */	
	public void setDescription(String[] vals)
	{
		strDescription = vals;
	}
	
	/**
	 * Set content of items
	 * 
	 * @param vals	Content of items
	 */	
	public void setContents(String[] vals)
	{
		contents = vals;
	}

	/**
	 * set image urls or font icon sclasses 
	 * @param images
	 */
	public void setImages(String[] images)
	{
		this.images = images;
	}
	
	/**
	 * set comboitem object values
	 * @param values
	 */
	public void setValues(Object[] values)
	{
		this.values = values;
	}
	
	/**
	 * 	Constructor
	 */	
	public AutoComplete() 
	{
		if (comboItems != null)
			refresh("");
	}
	
	/**
	 * @param value
	 */
	public AutoComplete(String value) 
	{
		super.setValue(value);
	}

	/**
	 * @param value
	 */
	@Override
	public void setValue(String value) 
	{
		super.setValue(value);
		refresh(value);
	}
	
	/**
	 * Event handler responsible to reducing number of items.<br/>
	 * Method is invoked each time something is typed into the combobox.
	 * 
	 * @param evt Input event
	 */	
	public void onChanging(InputEvent evt) 
	{
		if (!evt.isChangingBySelectBack())
		{
			refresh(evt.getValue());
		}
	}
	
	/**
	 * Filter {@link #comboItems} by val	
	 * @param val input text
	 */
	public void refresh(String val) 
	{
		if (comboItems == null || val == null) {
			super.getChildren().clear();
			mapItems.clear();
			return;
		}
		
		String compare = val.toLowerCase().trim();
		
		Iterator<?> it = getItems().iterator();
		for (int i = 0; i < comboItems.length; i++)
		{
			boolean match = false;
			if (compare.length() < 3)
			{
				match = comboItems[i].toLowerCase().startsWith(compare);
			}
			else
			{
				match = comboItems[i].toLowerCase().contains(compare);
			}
			if (match)
			{
				Comboitem comboitem = null;
				if (it != null && it.hasNext()) {
					comboitem = ((Comboitem)it.next());
			    } else {
			        it = null;
			        comboitem = new Comboitem();
			        super.appendChild(comboitem);
			    }

				comboitem.setLabel(comboItems[i]);
				if (values != null)
					comboitem.setValue(values[i]);
				comboitem.setDescription(strDescription[i]);

				if (images != null && i < images.length && images[i] != null && images[i].trim().length() > 0)
				{
					if (ThemeManager.isUseFontIconForImage())
						comboitem.setIconSclass(ThemeManager.getIconSclass(images[i]));
					else
						comboitem.setImage(images[i]);
				}
				if (contents != null && i < contents.length && contents[i] != null && contents[i].trim().length() > 0)
				{
					mapItems.put(comboitem, contents[i]);
				}
			}
		}
		while (it != null && it.hasNext()) {
	      it.next();
	      it.remove();
	    }		
	}

	/**
	 * @param item
	 * @return content text
	 */
	public String getContent(Comboitem item)
	{		
		return mapItems.get(item);
	}
}
