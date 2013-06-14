/******************************************************************************
 * Copyright (C) 2010 Low Heng Sin                                            *
 * Copyright (C) 2010 Idalica Corporation                                     *
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
package org.adempiere.webui.apps;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Window;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zul.Div;
import org.zkoss.zul.Span;

/**
 * 
 * @author hengsin
 *
 */
public class BusyDialog extends Window {

	private static final long serialVersionUID = -779475945298887887L;
	private Label label;

	public BusyDialog() {
		super();
		LayoutUtils.addSclass("busy-dialog", this);
		
		Div box = new Div();
		LayoutUtils.addSclass("busy-dialog-box", box);
		appendChild(box);
		
		Span image = new Span();
		LayoutUtils.addSclass("busy-dialog-img", image);
		box.appendChild(image);
		
		label = new Label(Msg.getMsg(Env.getCtx(), "Processing"));
		LayoutUtils.addSclass("busy-dialog-label", label);
		box.appendChild(label);
		
		setPosition("center");
		setShadow(true);
	}

	public void statusUpdate(String message) {
		if (label != null) {
			label.setText(message);
			this.invalidate();
		}
	}
}
