/******************************************************************************
 * Copyright (C) 2014 iDempiere                                               *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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
package org.adempiere.webui;

import org.adempiere.webui.component.Mask;
import org.adempiere.webui.part.AbstractUIPart;
import org.zkoss.zk.ui.Component;

/**
 * interface for any component want support show other window over it with a
 * mask. object manage component as AbstractUIPart also implement this interface
 * 
 */
public interface ISupportMask {
	/**
	 * show mask over this component
	 */
	public void showMask();

	/**
	 * Hide mask. at code call showMask will hand reference to this object. and
	 * call this function in handle close event of window
	 */
	public void hideMask();

	/**
	 * return cache object or make new object and return 
	 * @return
	 */
	public Mask getMaskObj();

	/**
	 * return self if is a component or return component it manage
	 * if {@link AbstractUIPart} is implement this interface, return {@link AbstractUIPart#getComponent()}   
	 * @return
	 */
	public Component getMaskComponent();
}
