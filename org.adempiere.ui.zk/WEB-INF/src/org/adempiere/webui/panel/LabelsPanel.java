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
 * - Nicolas Micoud (TGI)                                              *
 * - Alan Lescano                                                      *
 * - Norbert Bede                                                      *
 **********************************************************************/
package org.adempiere.webui.panel;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.apps.LabelsSearchController;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ZkCssHelper;
import org.compiere.model.MLabel;
import org.compiere.model.MLabelAssignment;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Groupbox;

/**
 * Label for a record (AD_LabelAssignment)
 */
public class LabelsPanel extends Div implements EventListener<Event> {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8776043844483214400L;

	private AbstractADWindowContent abstractADWindowContent;
	private int AD_Table_ID;
	private int Record_ID;
	private String Record_UU;
	
	/**
	 * Standard constructor
	 * @param abstractADWindowContent 
	 * @param AD_Table_ID
	 * @param Record_ID
 	 * @deprecated Use {@link LabelsPanel#LabelsPanel(AbstractADWindowContent, int, int, String)} instead
	 */
	@Deprecated
	public LabelsPanel(AbstractADWindowContent abstractADWindowContent, int AD_Table_ID, int Record_ID) {
		this(abstractADWindowContent, AD_Table_ID, Record_ID, null);
		if (Record_ID > 0) {
			MTable table = MTable.get(AD_Table_ID);
			PO po = table.getPO(Record_ID, null);
			this.Record_UU = po.get_UUID();
		}
	}	

	/**
	 * Standard constructor
	 * @param abstractADWindowContent 
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param Record_UU
	 */
	public LabelsPanel(AbstractADWindowContent abstractADWindowContent, int AD_Table_ID, int Record_ID, String Record_UU) {
		this.abstractADWindowContent = abstractADWindowContent;
		this.AD_Table_ID = AD_Table_ID;
		this.Record_ID = Record_ID;
		if (Record_ID > 0 && Record_UU == null) {
			MTable table = MTable.get(AD_Table_ID);
			PO po = table.getPO(Record_ID, null);
			this.Record_UU = po.get_UUID();
		} else {
			this.Record_UU = Record_UU;
		}
		setStyle("padding:0px 5px;");
		addEventListener(LabelsSearchController.ON_POST_SELECT_LABELITEM_EVENT, this);		
		update();
	}	

	/**
	 * Get current table id
	 * @return AD_Table_ID
	 */
	public int getAD_Table_ID() {
		return AD_Table_ID;
	}

	/**
	 * Get current record id
	 * @return Record_ID
	 */
	public int getRecord_ID() {
		return Record_ID;
	}

	/**
	 * Get current record uuid
	 * @return Record_UU
	 */
	public String getRecord_UU() {
		return Record_UU;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(LabelsSearchController.ON_POST_SELECT_LABELITEM_EVENT)) {
			update();
		}
	}
	
	/**
	 * Re-render with latest data from AD_LabelAssignment
	 */
	private void update() {
		// Clear children
		List<Component> children = new ArrayList<Component>(getChildren());
		
		for (Component child : children) {
			this.removeChild(child);
		}
		
		// Query
		List<MLabelAssignment> assignmentsList = new Query(Env.getCtx(),
				MLabelAssignment.Table_Name, "AD_Table_ID=? AND Record_UU=?", null)
			.setParameters(AD_Table_ID, Record_UU)
			.setOrderBy(MLabelAssignment.COLUMNNAME_Created)
			.list();
		
		for (MLabelAssignment assignment : assignmentsList) {
			Div d = new Div();
			ZkCssHelper.appendStyle(d, "float: left;");

			LabelPill gb = new LabelPill(assignment);
	        d.appendChild(gb);
	        appendChild(d);
		}

		abstractADWindowContent.getToolbar().setPressed("Label",abstractADWindowContent.getActiveGridTab().hasLabel());
	}
	
	/**
	 * Pill shape label component
	 */
	private class LabelPill extends Groupbox {
		private static final long serialVersionUID = -2248242199670448950L;
		
		public LabelPill(MLabelAssignment assignment) {
			setContentStyle("border: none; padding: 0px 4px 6px 4px;");
			
			MLabel label = new MLabel(assignment.getCtx(), assignment.getAD_Label_ID(), assignment.get_TrxName());
			
			Label name = new Label(label.getName());
	        ZkCssHelper.appendStyle(name, label.buildStyle());	        
	        appendChild(name);
	        
	        Label closeButton = new Label("x");
	        ZkCssHelper.appendStyle(closeButton,
	        		"cursor: pointer; margin:3px; font-size: 10px; font-weight: bold; color: #909090; vertical-align: super;");	        
	        appendChild(closeButton);
	        
	        closeButton.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					if (Events.ON_CLICK.equals(event.getName())) {
						assignment.deleteEx(true);
						LabelsPanel.this.update();
			        }
				}	        	
	        });
		}
	}
}
