/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.component;

import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zul.Tab;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Tabpanel extends org.zkoss.zul.Tabpanel implements IdSpace
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -3392752891445762516L;

	private ITabOnCloseHandler onCloseHandler = null;
    
    private boolean enabled;

	private int tabLevel;

    public boolean isEnabled()
    {
        return enabled;
    }

    @Override
	public boolean setVisible(boolean visible) {
		// TODO Auto-generated method stub
		return super.setVisible(visible);
	}

	@Override
	protected void setVisibleDirectly(boolean visible) {
		// TODO Auto-generated method stub
		super.setVisibleDirectly(visible);
	}

	public void setEnabled(boolean enabled)
    {
        this.enabled = enabled;
    }
    
    public int getTabLevel() 
    {
    	return tabLevel;    	
    }
    
    public void setTabLevel(int l)
    {
    	tabLevel = l;
    }

	public void onClose() {
		if (onCloseHandler != null) {
			onCloseHandler.onClose(this);
		} else {
			Tab tab = this.getLinkedTab();
			if (tab != null)
				tab.close();
		}
	}
	
	public void setOnCloseHandler(ITabOnCloseHandler handler) {
		this.onCloseHandler = handler;
	}
}
