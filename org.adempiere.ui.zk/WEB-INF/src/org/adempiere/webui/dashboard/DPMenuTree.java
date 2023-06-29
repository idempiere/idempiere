/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

package org.adempiere.webui.dashboard;

import org.adempiere.webui.panel.MenuTreePanel;

/**
 * Dashboard gadget: Menu Tree
 * @author Elaine
 * @date July 31, 2012
 */
public class DPMenuTree extends DashboardPanel {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3095921038206382907L;
	
	private MenuTreePanel menuTreePanel;

	/**
	 * Default constructor
	 */
	public DPMenuTree()
	{
		super();
		
		menuTreePanel = new MenuTreePanel(this);
	}
	
	/**
	 * @return {@link MenuTreePanel}
	 */
	public MenuTreePanel getMenuTreePanel()
	{
		return menuTreePanel;
	}
	
}
