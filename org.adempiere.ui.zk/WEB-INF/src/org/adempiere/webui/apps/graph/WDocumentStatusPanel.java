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
* - Ashley Ramdass                                                    *
* - Deepak Pansheriya                                                 *
* - Murilo Ht                                                         *
* - Carlos Ruiz                                                       *
**********************************************************************/

package org.adempiere.webui.apps.graph;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Group;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.desktop.IDesktop;
import org.compiere.model.MDocumentStatus;
import org.compiere.model.MFieldGroup;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventQueue;
import org.zkoss.zk.ui.event.EventQueues;

/**
 * Panel that hold one or more {@link WDocumentStatusIndicator}. 
 */
public class WDocumentStatusPanel extends Panel {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7473476079783059880L;

	private List<WDocumentStatusIndicator> indicatorList = new ArrayList<WDocumentStatusIndicator>();

	/** Document Status Indicators	*/
	private MDocumentStatus[] 	m_indicators = null;

	private int lastRefreshCount;

	/**	Logger	*/
	private static final CLogger log = CLogger.getCLogger (WDocumentStatusPanel.class);

	/**
	 * 	Get Panel if User has Document Status Indicators
	 *	@return new WDocumentStatusPanel instance
	 */
	public static WDocumentStatusPanel get()
	{
		int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		int AD_Role_ID = Env.getAD_Role_ID(Env.getCtx());
		MDocumentStatus[] indicators = MDocumentStatus.getDocumentStatusIndicators(Env.getCtx(), AD_User_ID, AD_Role_ID);
		return new WDocumentStatusPanel(indicators);
	}

	/**
	 * 	Constructor
	 *	@param Document Status Indicators
	 */
	private WDocumentStatusPanel (MDocumentStatus[] indicators)
	{
		super ();
		m_indicators = indicators;
		init();
	}

	/**
	 * Layout panel
	 */
	private void init()
	{
		if (log.isLoggable(Level.INFO))
			log.info("");
		Grid grid = new Grid();
		appendChild(grid);
		grid.setWidth("100%");
		grid.makeNoStrip();
		grid.setOddRowSclass("even");
		grid.setStyle("border: none;");

		Rows rows = new Rows();
		grid.appendChild(rows);

		Group group = null;
		int prevFieldGroup = -1;
		for (int i = 0; i < m_indicators.length; i++)
		{
			MDocumentStatus ind = m_indicators[i];
			Row row = new Row();
			WDocumentStatusIndicator pi = new WDocumentStatusIndicator(ind, true);
			if (ind.getAD_FieldGroup_ID() > 0) {
				if (ind.getAD_FieldGroup_ID() != prevFieldGroup) {
					MFieldGroup fg = new MFieldGroup(ind.getCtx(), ind.getAD_FieldGroup_ID(), ind.get_TrxName());
					group = new Group(fg.get_Translation(MFieldGroup.COLUMNNAME_Name));
					rows.appendChild(group);
					prevFieldGroup = ind.getAD_FieldGroup_ID();
				}
				row.setGroup(group);
			}
			rows.appendChild(row);
			row.appendChild(pi);
			indicatorList.add(pi);
		}
	}	//	init

	/**
	 * Call {@link WDocumentStatusIndicator#refresh()} of {@link #indicatorList}.
	 */
	public void refresh() {
		lastRefreshCount = 0;
		for (WDocumentStatusIndicator indicator : indicatorList) {
			indicator.refresh();
			if (indicator.getDocumentStatus().getAD_Client_ID() == 0)
				lastRefreshCount += indicator.getStatusCount();
		}
		
	}

	/**
	 * Call {@link WDocumentStatusIndicator#updateUI()} of {@link #indicatorList}.
	 */
	public void updateUI() {
		boolean isPanelVisible = false;
		List<Group> groups = new ArrayList<>();
		List<Group> visibleGroups = new ArrayList<>();
		for (WDocumentStatusIndicator indicator : indicatorList) {
			boolean isVisible = indicator.isVisible();
			boolean newVisible = (indicator.getStatusCount() != 0 || !indicator.getDocumentStatus().isHideWhenZero());
			if (isVisible != newVisible) {
				indicator.setVisible(newVisible);
				if (indicator.getParent() instanceof Row)
					indicator.getParent().setVisible(newVisible);
			}
			if (newVisible && indicator.getDocumentStatus().getName_PrintColorZero_ID() > 0)
				indicator.decorateNameLabel();
			Group group = null;
			if (indicator.getParent() != null && indicator.getParent() instanceof Row && ((Row) indicator.getParent()).getGroup() != null) {
				group = ((Row) indicator.getParent()).getGroup();
				if (!groups.contains(group))
					groups.add(group);
			}

			indicator.updateUI();
			if (indicator.isVisible()) {
				isPanelVisible = true;
				if (group != null && !visibleGroups.contains(group))
					visibleGroups.add(group);
			}
		}
		if (!groups.isEmpty()) {
			for (Group group : groups) {
				if (visibleGroups.contains(group))
					group.setVisible(true);
				else
					group.setVisible(false);
			}
		}
		// hide the Activities dashboard if all indicators are hidden, otherwise show it
		Component parent = getParent();
		while (parent != null) {
			if (parent instanceof org.zkoss.zul.Panel) {
				parent.setVisible(isPanelVisible);
				break;
			}
			parent = parent.getParent();
		}
		EventQueue<Event> queue = EventQueues.lookup(IDesktop.ACTIVITIES_EVENT_QUEUE, true);
		Event event = new Event(IDesktop.ON_ACTIVITIES_CHANGED_EVENT, null, lastRefreshCount);
		queue.publish(event);		
	}

}
