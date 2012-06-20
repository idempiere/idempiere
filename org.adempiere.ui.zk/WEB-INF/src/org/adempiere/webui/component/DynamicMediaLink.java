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
package org.adempiere.webui.component;


import org.zkoss.util.media.AMedia;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Filedownload;

/**
 * @author hengsin
 *
 */
public class DynamicMediaLink extends A {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 5017833977652241179L;
	
	private AMedia media;
	
	public DynamicMediaLink() {
		super();
		this.addEventListener(Events.ON_CLICK, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				Filedownload.save(media);
			}
		});
	}

	public DynamicMediaLink(String label, String image) {
		super(label, image);
	}

	public DynamicMediaLink(String label) {
		super(label);
	}
	
	public void setMedia(AMedia media) {
		this.media = media;
	}	
}
