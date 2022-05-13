/******************************************************************************
 * Copyright (C) 2015 iDempiere                                               *
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
import org.adempiere.webui.part.UIPart;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.util.Clients;

/**
 * Helper class for any component want implement {@link ISupportMask}
 * Just make a instance of this class and let it do everything  
 * @author hieplq
 *
 */
public class ShowMaskWrapper implements ISupportMask {

	/**
	 * component will implement ISupportMask;
	 */
	private Component comp;
	
	/**
	 * cache {@link Mask} Object
	 */
	private Mask maskObj;
	
	/**
	 * comp is component want implement this interface 
	 * @param comp
	 */
	public ShowMaskWrapper (Component comp){
		this.comp = comp;
	}
	
	/**
	 * this mask will show over component from {@link UIPart#getComponent()}
	 * @param uiPart
	 */
	public ShowMaskWrapper (UIPart uiPart){
		this.comp = uiPart.getComponent();
	}
	
	
	/**
	 * {@inheritDoc}
	 */
	@Override
	public void showMask() {
		maskObj = getMaskObj ();
		if (maskObj.getParent() == null){
			comp.appendChild(maskObj);
		}
		ShowMaskWrapper.setFlagShowMask(comp);
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public void hideMask() {
		if (maskObj != null || maskObj.getParent() != null){
			// in same request, not yet call to show mask
			if (!ShowMaskWrapper.hasFlagShowMask(comp)){
				Component p = maskObj.getParent();
				maskObj.detach();
				if (p == comp) {
					StringBuilder script = new StringBuilder("var w=zk.Widget.$('#");
					script.append(p.getUuid()).append("');");
					script.append("w.busy=null;");
					Clients.response(new AuScript(script.toString()));
				}
			}
		}
	}

	/**
	 * {@inheritDoc}
	 * return new {@link Mask} when mask is not yet create
	 */
	@Override
	public Mask getMaskObj() {
		if (maskObj == null)
			maskObj = new Mask();
		
		return maskObj;
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Component getMaskComponent() {
		return comp;
	}
	
	/**
	 * Set flag {@link ISupportMask#READY_SHOW_MASK_FLAG} to Component.REQUEST_SCOPE
	 * @param comp
	 */
	public static void setFlagShowMask (Component comp){
		comp.setAttribute(ISupportMask.READY_SHOW_MASK_FLAG, Integer.valueOf(1), Component.REQUEST_SCOPE);
	}
	
	/**
	 * check flag {@link ISupportMask#READY_SHOW_MASK_FLAG} ready in scope Component.REQUEST_SCOPE
	 * @param comp
	 * @return
	 */
	public static boolean hasFlagShowMask (Component comp){
		return (comp.getAttribute(ISupportMask.READY_SHOW_MASK_FLAG, Component.REQUEST_SCOPE) != null);
	}
}
