/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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

import java.util.List;

import javax.activation.DataSource;

import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Span;

/**
 * 
 * @author hengsin
 *
 */
public class AttachmentItem extends Span implements EventListener<Event>{
	/**
	 * generate serial id
	 */
	private static final long serialVersionUID = -7599391160210459080L;
	private DataSource ds;
	private List<DataSource> list;

	public AttachmentItem(DataSource ds, List<DataSource> list, boolean removable) {
		setSclass("z-attachment-item");
		Label label = new Label(ds.getName());
		label.setSclass("z-attachment-item-text");
		appendChild(label);
		if (removable) {
			A x = new A("", ThemeManager.getThemeResource("images/X8.png"));
			x.setSclass("z-attachment-item-del-button");
			appendChild(x);
			this.ds = ds;
			this.list = list;
			x.addEventListener(Events.ON_CLICK, this);
		}
		ZKUpdateUtil.setHflex(this, "0");
	}

	@Override
	public void onEvent(Event event) throws Exception {
		list.remove(ds);
		this.detach();
	}
}
