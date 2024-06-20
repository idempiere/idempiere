/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.webui.action;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.MToolBarButton;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.image.AImage;
import org.zkoss.zul.Toolbarbutton;

/**
 * Custom UI action provided through OSGi service. Implementation must be thread safe.   
 * @author hengsin
 *
 */
public interface IAction {
	/**
	 * execute action
	 * @param target
	 */
	public void execute(Object target);
	
	public default void decorate(Toolbarbutton btn, MToolBarButton mButton) {
		String actionId = mButton.getActionClassName();
		String labelKey = actionId + ".label";
		String tooltipKey = actionId + ".tooltip";
		String label = Msg.getMsg(Env.getCtx(), labelKey, true);
		String tooltiptext = Msg.getMsg(Env.getCtx(), labelKey, false);
		if (Util.isEmpty(tooltiptext, true))
			tooltiptext = Msg.getMsg(Env.getCtx(), tooltipKey, true);
		else
			tooltipKey = labelKey;
		if (labelKey.equals(label)) {
			label = mButton.getName();
		}
		if (tooltipKey.equals(tooltiptext) || labelKey.equals(tooltiptext)) {
			tooltipKey = null;
		}
		
		btn.setIconSclass(null);
		if (ThemeManager.isUseFontIconForImage()) {
			String iconSclass = Actions.getActionIconSclass(actionId);
			if (!Util.isEmpty(iconSclass, true)) {
				btn.setIconSclass(iconSclass);
				LayoutUtils.addSclass("font-icon-toolbar-button", btn);
			}
		}
		//not using font icon, fallback to image or label
		if (Util.isEmpty(btn.getIconSclass(), true)) {
			AImage aImage = Actions.getActionImage(actionId);
			if (aImage != null) {
				btn.setImageContent(aImage);
			} else {
				btn.setLabel(label);
			}
		}
	}
	/**
	 * you can customize toolbar button like add style, client javascript,...
	 * @deprecated(forRemoval = true, since = "11")
	 * replace by {@link #decorate(Toolbarbutton, String)}
	 * @param toolbarButton
	 */
	public default void decorate(Toolbarbutton btn) {	
		decorate(btn, null);
	}
	
	/**
	 * @return font icon class
	 */
	public default String getIconSclass() {
		return "";
	}
}
