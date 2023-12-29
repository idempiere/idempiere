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
package org.adempiere.webui.editor;

import java.util.logging.Level;

import org.adempiere.webui.dashboard.DashboardRunnable;
import org.adempiere.webui.desktop.DashboardController;
import org.compiere.model.GridField;
import org.compiere.model.MDashboardContent;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Div;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;

/**
 * Default editor for {@link DisplayType#DashboardContent}.<br/>
 * A readonly editor that render dashboard content from {@link MDashboardContent} to {@link Panel} component. 
 * @author hengsin
 *
 */
public class WDashboardContentEditor extends WEditor {

	private static final String ON_RENDER_CONTENT = "onRenderContent";
	private DashboardController dashboardController;
	private MDashboardContent content;
	private String fieldStyle;

	private final static CLogger logger  = CLogger.getCLogger(WDashboardContentEditor.class);
	
	/**
	 * 
	 * @param gridField
	 * @param windowNo
	 */
	public WDashboardContentEditor(GridField gridField, int windowNo) {
		this(gridField, windowNo, false, null);
	}
	
	/**
	 * 
	 * @param gridField GridField for PA_DashboardContent_ID
	 * @param windowNo
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WDashboardContentEditor(GridField gridField, int windowNo, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(new Panel(), gridField, tableEditor, editorConfiguration);
		dashboardController = new DashboardController();
		content = new MDashboardContent(Env.getCtx(), gridField.getPA_DashboardContent_ID(), null);
		Panelchildren pc = new Panelchildren();
		getComponent().appendChild(pc);		
		
		if (content.get_ID() > 0) {
			Caption caption = new Caption(content.get_Translation(MDashboardContent.COLUMNNAME_Name));
			getComponent().appendChild(caption);
		}
    	getComponent().addEventListener(ON_RENDER_CONTENT, this);
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.event.EventListener#onEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(ON_RENDER_CONTENT)) {
			try {
				render();
			} catch (Exception e) {
				logger.log(Level.SEVERE, e.getLocalizedMessage(), e);
			}		
		}
	}

	/**
	 * No op.
	 */
	@Override
	public void setReadWrite(boolean readWrite) {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#isReadWrite()
	 */
	@Override
	public boolean isReadWrite() {
		return false;
	}

	/**
	 * No op.
	 */
	@Override
	public void setValue(Object value) {
	}

	/**
	 * Always return null.
	 */
	@Override
	public Object getValue() {
		return null;
	}

	/**
	 * Always return null.
	 */
	@Override
	public String getDisplay() {
		return null;
	}

	/**
	 * Post {@link #ON_RENDER_CONTENT} event to render dashboard content.
	 */
	@Override
	public void dynamicDisplay() {
		super.dynamicDisplay();
		Events.postEvent(ON_RENDER_CONTENT, getComponent(), null);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getComponent()
	 */
	@Override
	public Panel getComponent() {
		return (Panel) super.getComponent();
	}

	/**
	 * Render dashboard content
	 * @throws Exception
	 */
	private void render() throws Exception {
		Panel panel = getComponent();
		panel.setSclass("dashboard-field-panel");
		Panelchildren pc = panel.getPanelchildren();
		pc.getChildren().clear();
		Div div = new Div();		
		if (!Util.isEmpty(fieldStyle))
			div.setStyle(fieldStyle);
		
		DashboardRunnable dashboardRunnable = new DashboardRunnable(panel.getDesktop());
		dashboardController.render(div, content, dashboardRunnable);
		
		pc.appendChild(div);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setFieldStyle(java.lang.String)
	 */
	@Override
	protected void setFieldStyle(String style) {
		fieldStyle = style;
	}
	
}
