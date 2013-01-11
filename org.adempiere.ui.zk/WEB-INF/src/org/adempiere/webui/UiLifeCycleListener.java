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
package org.adempiere.webui;

import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.util.UiLifeCycle;

/**
 * @author hengsin
 *
 */
public class UiLifeCycleListener implements UiLifeCycle {

	/**
	 * 
	 */
	public UiLifeCycleListener() {
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.UiLifeCycle#afterComponentAttached(org.zkoss.zk.ui.Component, org.zkoss.zk.ui.Page)
	 */
	@Override
	public void afterComponentAttached(Component comp, Page page) {
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.UiLifeCycle#afterComponentDetached(org.zkoss.zk.ui.Component, org.zkoss.zk.ui.Page)
	 */
	@Override
	public void afterComponentDetached(Component comp, Page prevpage) {
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.UiLifeCycle#afterComponentMoved(org.zkoss.zk.ui.Component, org.zkoss.zk.ui.Component, org.zkoss.zk.ui.Component)
	 */
	@Override
	public void afterComponentMoved(Component parent, Component child, Component prevparent) {
		String locator = child.getWidgetAttribute(AdempiereIdGenerator.ZK_LOCATOR_ATTRIBUTE);
		if (locator != null) {
			AdempiereIdGenerator.updateZkLocatorAttribute(child);
		}
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.UiLifeCycle#afterPageAttached(org.zkoss.zk.ui.Page, org.zkoss.zk.ui.Desktop)
	 */
	@Override
	public void afterPageAttached(Page page, Desktop desktop) {
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.util.UiLifeCycle#afterPageDetached(org.zkoss.zk.ui.Page, org.zkoss.zk.ui.Desktop)
	 */
	@Override
	public void afterPageDetached(Page page, Desktop prevdesktop) {
	}

}
