/***********************************************************************
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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.window;

import org.adempiere.webui.component.Window;
import org.compiere.model.GridTab;

/**
 * @author hengsin
 *
 */
public class WRecordTimeLine extends Window {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -7887774385203335178L;
	private RecordTimeLinePanel activityLayout;
	
	/**
	 * 
	 */
	public WRecordTimeLine() {
		activityLayout = new RecordTimeLinePanel();
		appendChild(activityLayout);
	}

	public void render(GridTab gridTab) {
		activityLayout.render(gridTab);
	}
}
