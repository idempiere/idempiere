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
 * - deepak															   *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.window;

import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomizeUserDefTabGridView;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.idempiere.ui.zk.annotation.Form;
import org.zkoss.zk.ui.event.Events;

/**
 * Form to customize grid view for AD_UserDef_Tab
 */
@Form
public class WCustomizeUserDefTabGridView extends ADForm {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4294023071892041844L;
	private CustomizeUserDefTabGridView customizePanel;

	/**
	 * Default Constructor
	 */
	public WCustomizeUserDefTabGridView() {
	}
	
	/**
	 * Create components and layout form
	 * @param AD_UserDef_Tab_ID
	 */
	private void initComponent(int AD_UserDef_Tab_ID) {
		customizePanel = new CustomizeUserDefTabGridView(AD_UserDef_Tab_ID, getWindowNo());
		
		this.setClosable(true);
		this.setSizable(true);
		this.setMaximizable(true);
		this.setBorder("normal");
		this.setSclass("popup-dialog");		
		
		ZKUpdateUtil.setWindowWidthX(this, 900);
		ZKUpdateUtil.setWindowHeightX(this, 800);

		appendChild(customizePanel);
		customizePanel.createUI();
		customizePanel.loadData();
		
		addEventListener(Events.ON_CANCEL, e -> customizePanel.onCancel());
	}

	@Override
	protected void initForm() {
		initComponent(getProcessInfo().getRecord_ID());
	}

	@Override
	public Mode getWindowMode() {
		return Mode.HIGHLIGHTED;
	}	
}
