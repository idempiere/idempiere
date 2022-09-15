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
* - Igor Pojzl, Cloudempiere                                          *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/

package org.adempiere.webui.apps.graph;

import org.adempiere.webui.apps.graph.WPerformanceIndicator.Options;
import org.adempiere.webui.component.Panel;
import org.compiere.model.MGoal;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;

public class WPAWidget extends Panel {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5684412399657327777L;
	
	/**************************************************************************
	 * 	Constructor
	 */
	public WPAWidget (MGoal goal, Options options, boolean isShowTitle)
	{
		super();
		goal.updateGoal(false);
		init(goal, options, isShowTitle);
	}
	
	/**
	 * 	Static/Dynamic Init
	 * @param goal
	 * @param options 
	 */
	private void init(MGoal goal, Options options, boolean isShowTitle)
	{
		Div div = new Div();
		appendChild(div);
		WPerformanceIndicator pi = new WPerformanceIndicator(goal, options);
		div.appendChild(pi);
		if (goal.getMeasure() != null) 
			pi.addEventListener(Events.ON_CLICK, e -> new WPerformanceDetail(pi.getGoal())); //Action Listener for Drill Down
		if(isShowTitle) {
			Div titleDiv = new Div();
			titleDiv.setSclass("gauge-indicator-title");
			Label label = new Label(pi.getTitle());
			div.appendChild(titleDiv);
			titleDiv.appendChild(label);
		}
	}	//	init
}
