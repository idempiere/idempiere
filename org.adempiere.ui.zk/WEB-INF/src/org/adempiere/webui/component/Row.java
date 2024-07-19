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

import org.zkoss.zk.ui.Component;
import org.zkoss.zul.Cell;

/**
 * Extend {@link org.zkoss.zul.Row}
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Row extends org.zkoss.zul.Row
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5813452501151101553L;

	/** Last Cell added to Row */
	private Cell m_lastCell;

	/**
	 * Add component to row
	 * @param child Component 
	 * @return true if added
	 */
	public boolean appendCellChild(Component child) {
		return this.appendCellChild(child, 1);
	}
	
	/**
	 * Add component to row. A new {@link Cell} with colspan will be created as parent of the component.
	 * @param child Component 
	 * @param colspan Column span
	 * @return true if added
	 */
	public boolean appendCellChild(Component child, int colspan) {
		Cell cell = new Cell();
		cell.setColspan(colspan);
		cell.setRowspan(1);
		cell.appendChild(child);
		m_lastCell = cell;
		return super.appendChild(cell);
	}

	/** Optional Group that own this Row instance */
	private Group m_group;

	/**
	 * @return Group
	 */
	public Group getGroup() {
		return m_group;
	}

	/**
	 * Add row to Group
	 * @param group Group
	 */
	public void setGroup(Group group) {
		this.m_group = group;
		if (m_group != null)
			m_group.add(this);
	}
	
	/**
	 * @return last Cell added to Row
	 */
	public Cell getLastCell() {
		return m_lastCell;
	}

}
