/**********************************************************************
* This file is part of Idempiere ERP Bazaar                           *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Idempiere                                             *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
**********************************************************************/

package org.adempiere.webui.component;

import org.adempiere.webui.apps.AEnv;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;

/**
 * Make link to document window
 * @author hieplq
 *
 */
public class DocumentLink extends A implements EventListener<Event> {	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1498406053715803814L;

	public static final String ATT_RECORD_ID = "Record_ID";
	public static final String ATT_AD_TABLE_ID = "AD_Table_ID";
	
	protected int recordId;
	
	public int getRecordId() {
		return recordId;
	}

	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}

	protected int adTableId;
	
	public int getAdTableId() {
		return adTableId;
	}

	public void setAdTableId(int adTableId) {
		this.adTableId = adTableId;
	}
	
	public DocumentLink(String label, int adTableId, int recordId){
		this(label, adTableId, recordId, null);
	}
	
	public DocumentLink(String label, int adTableId, int recordId, EventListener<Event> clickHandle){
		super();
		if (label == null || label.trim().length() == 0)
			label = String.valueOf(recordId);
		
		super.setLabel(label);
		
		setAdTableId(adTableId);
		setRecordId(recordId);
		
		if (clickHandle == null)
			this.addEventListener (Events.ON_CLICK, this);
		else
			this.addEventListener (Events.ON_CLICK, clickHandle);
			
	}
	
	/**
	 * Go to document window
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getTarget() instanceof DocumentLink){
			DocumentLink documentLink = (DocumentLink)event.getTarget();
			if (documentLink.getAdTableId() > 0 && documentLink.getRecordId() > 0)
				AEnv.zoom(documentLink.getAdTableId(), documentLink.getRecordId());
		}
	}

}
