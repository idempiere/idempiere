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
 * consider below case.
 * 1. show a dialog => show mask
 * 2. process a event
 *     2.1. show other dialog => show mask
 *     2.1. hidden dialog in step 1 => hidden mask
 * 3. result dialog show without mask
 * to void this case process as below
 * in {@link #showMask()} set a flag to request scope by call: {@link Component#setAttribute(String, Object, int)} 
 * key is {@link #READY_SHOW_MASK_FLAG} value is Integer(1) and scope is {@link Component#REQUEST_SCOPE}
 * in {@link #hideMask()} check flag before hidden mask. when has flag, don't hidden mask
 * 
 * component want support show mask can implement this interface or use support class {@link ShowMaskWrapper} as composite object 
 */
public interface ISupportMask {
	public static String READY_SHOW_MASK_FLAG = "ISupportMask_READY_SHOW_MASK_FLAG";
	/**
	 * show mask over this component
	 * when override, remember call {@link Component#setAttribute(String, Object, int)} with 
	 * key is {@link #READY_SHOW_MASK_FLAG} value is Integer(1) and scope is {@link Component#REQUEST_SCOPE}
	 * by call {@link LayoutUtils#setFlagShowMask(Component)}
	 */
	public void showMask();

	/**
	 * Hide mask. at code call showMask will hand reference to this object. and
	 * call this function in handle close event of window
	 * when override, remember check exists of key {@link #READY_SHOW_MASK_FLAG} at scope {@link Component#REQUEST_SCOPE} in attribute
	 * by call {@link LayoutUtils#hasFlagShowMask(Component)}
	 * if exists flag, don't hidden mask 
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