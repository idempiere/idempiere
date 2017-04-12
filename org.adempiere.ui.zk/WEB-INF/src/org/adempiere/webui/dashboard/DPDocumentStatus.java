/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
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
* Contributors:                                                       *
* - Adaxa                                                             *
* - Murilo Ht                                                         *
* - Carlos Ruiz                                                       *
**********************************************************************/

package org.adempiere.webui.dashboard;

import org.adempiere.webui.apps.graph.WDocumentStatusPanel;
import org.adempiere.webui.util.ServerPushTemplate;

public class DPDocumentStatus extends DashboardPanel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2089844018551832142L;

	private WDocumentStatusPanel statusPanel;

	@Override
	public void refresh(ServerPushTemplate template) {
		statusPanel.refresh();
		template.execute(this);
	}

	@Override
	public void updateUI() {
		statusPanel.updateUI();
	}

	public DPDocumentStatus()
	{
		super();
        
        statusPanel = WDocumentStatusPanel.get();
        if (statusPanel != null) this.appendChild(statusPanel);
	}	
}
