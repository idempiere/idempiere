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
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Hlayout;

/**
 * 
 * @author hengsin
 *
 */
public class AttachmentItem extends Hlayout implements EventListener<Event>{
	/**
	 * generate serial id
	 */
	private static final long serialVersionUID = 9105759170502414466L;
	private DataSource ds;
	private List<DataSource> list;

	public AttachmentItem(DataSource ds, List<DataSource> list, boolean removable) {
		setStyle("border: 1px solid #dcdcdc; background-color: #f5f5f5; " +
				"width: auto !important;display: inline-block; height: 21px; " +
				"margin-right: 5px; margin-bottom: 5px;padding-left: 5px; padding-right: 5px;");
		appendChild(new Label(ds.getName()));
		if (removable) {
			A x = new A("", ThemeManager.getThemeResource("images/X8.png"));
			x.setStyle("float: right; background-color: #f5f5f5");
			appendChild(x);
			this.ds = ds;
			this.list = list;
			x.addEventListener(Events.ON_CLICK, this);
		}
		setHflex("0");
	}

	@Override
	public void onEvent(Event event) throws Exception {
		list.remove(ds);
		this.detach();
	}
}
