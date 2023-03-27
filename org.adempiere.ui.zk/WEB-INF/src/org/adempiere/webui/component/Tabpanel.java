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

import org.adempiere.webui.ISupportMask; 
import org.adempiere.webui.ShowMaskWrapper;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zul.Tab;

/**
 * Extend {@link org.zkoss.zul.Tabpanel}
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Tabpanel extends org.zkoss.zul.Tabpanel implements IdSpace, ISupportMask
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1057250877531248907L;

	/** optional onClose handler */
	private ITabOnCloseHandler onCloseHandler = null;
    
    private boolean enabled;

    @Deprecated
	private int tabLevel;

	protected ShowMaskWrapper showMaskWrapper = new ShowMaskWrapper(this);
	
	/**
	 * @return true if enable, false otherwise
	 */
    public boolean isEnabled()
    {
        return enabled;
    }

    @Override
	public boolean setVisible(boolean visible) {
		return super.setVisible(visible);
	}

	@Override
	protected void setVisibleDirectly(boolean visible) {
		super.setVisibleDirectly(visible);
	}

	/**
	 * Enable/disable tab panel
	 * @param enabled
	 */
	public void setEnabled(boolean enabled)
    {
        this.enabled = enabled;
    }
    
	/**
	 * @return AD_Tab Tab level
	 */
	@Deprecated
    public int getTabLevel() 
    {
    	return tabLevel;    	
    }
    
    /**
     * Set AD_Tab tab level 
     * @param l Tab level
     */
    @Deprecated
    public void setTabLevel(int l)
    {
    	tabLevel = l;
    }

    /**
     * Call {@link #onCloseHandler} (if not null).<br/>
     * If {@link #onCloseHandler} is null, close linked tab.
     */
	public void onClose() {
		if (onCloseHandler != null) {
			onCloseHandler.onClose(this);
		} else {
			Tab tab = this.getLinkedTab();
			if (tab != null)
				tab.close();
		}
	}
	
	/**
	 * Set on close handler
	 * @param handler ITabOnCloseHandler
	 */
	public void setOnCloseHandler(ITabOnCloseHandler handler) {
		this.onCloseHandler = handler;
	}
	
	/**
	 * {@inheritDoc}
	 */
	@Override
	public void showMask() {
		showMaskWrapper.showMask();
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public void hideMask() {
		showMaskWrapper.hideMask();
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Mask getMaskObj() {
		return showMaskWrapper.getMaskObj();
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Component getMaskComponent() {		
		return showMaskWrapper.getMaskComponent();
	}
}
