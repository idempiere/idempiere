/******************************************************************************
 * Copyright (C) 2012 Low Heng Sin                                            *
 * Copyright (C) 2012 www.idempiere.org                                       *
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
package org.adempiere.webui.component;

import java.util.ArrayList;
import java.util.List;

import org.zkoss.zk.ui.Page;
import org.zkoss.zul.impl.XulElement;

/**
 * 
 * @author hengsin
 *
 */
public class Menupopup extends org.zkoss.zul.Menupopup {

	/**
	 * generated serial version id
	 */
	private static final long serialVersionUID = -4929397362586559388L;

	/**
	 * listo of xulelement that use this as the context menu
	 */
	private List<XulElement> elementList = new ArrayList<XulElement>();

	/**
	 * add xul element that want to use this as the context menu
	 * @param element
	 */
	public void addContextElement(XulElement element) {
		elementList.add(element);
		if (this.getPage() != null) {
			element.setContext(this);
		}
	}
	
	/**
	 * stop the xul element from using this as the context menu
	 * @param element
	 * @return true if exists and remove from the added xul element list
	 */
	public boolean removeContextElement(XulElement element) {
		if (elementList.remove(element)) {
			element.setContext((String)null);
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		for(XulElement e : elementList) {
			e.setContext(this);
		}
	}

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		for(XulElement e : elementList) {
			e.setContext((String)null);
		}
	}
}
