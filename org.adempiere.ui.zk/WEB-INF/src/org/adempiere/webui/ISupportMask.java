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
 * Interface for any component want support show other window over it with a
 * mask.<br/> Class manage component as AbstractUIPart also implement this interface.<br/>
 * Consider following scenario:<br/>
 * <pre>
 * 1. show a dialog =&gt; show mask
 * 2. process an event
 *     2.1. show other dialog =&gt; show mask
 *     2.1. hide dialog in step 1 =&gt; hide mask
 * 3. result dialog show without mask
 * </pre>
 * To void this issue, proceed as below:<br/>
 * - In {@link #showMask()} set a flag to request scope by call {@link Component#setAttribute(String, Object, int)} 
 * with name {@link #READY_SHOW_MASK_FLAG}, value Integer(1) and scope {@link Component#REQUEST_SCOPE}.<br/>
 * - In {@link #hideMask()} check flag before hide mask. When has flag, don't hide mask.
 * <p>
 * Component want support show mask can implement this interface or use support class {@link ShowMaskWrapper} as composite object 
 */
public interface ISupportMask {
	public static String READY_SHOW_MASK_FLAG = "ISupportMask_READY_SHOW_MASK_FLAG";
	/**
	 * Show mask over this component.<br/>
	 * When override, remember to call {@link Component#setAttribute(String, Object, int)} with 
	 * name {@link #READY_SHOW_MASK_FLAG}, value Integer(1) and scope {@link Component#REQUEST_SCOPE}.<br/>
	 * Call by {@link LayoutUtils}.
	 */
	public void showMask();

	/**
	 * Hide mask. With ISupportMask return from showMask, call this function in handle close event of window. <br/>
	 * When override, remember check exists of key {@link #READY_SHOW_MASK_FLAG} at scope {@link Component#REQUEST_SCOPE} in attribute.
	 * If flag exists, don't hide mask.<br/>
	 * Call by {@link LayoutUtils}. 
	 */
	public void hideMask();

	/**
	 * Return cache Mask or create new Mask and return. 
	 * @return {@link Mask}
	 */
	public Mask getMaskObj();

	/**
	 * Return self if is a component or return component it manage.<br/>
	 * {@link AbstractUIPart} subclasses that implement this interface should return {@link AbstractUIPart#getComponent()}.   
	 * @return {@link Component}
	 */
	public Component getMaskComponent();
}