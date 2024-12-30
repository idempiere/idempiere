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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.compiere.minigrid;

/**
 * UUID Column for {@link IMiniTable}, allows to select a column and maintains the record UUID
 * @author Carlos Ruiz - globalqss - bxservice
 */
public class UUIDColumn implements SelectableIDColumn
{
	/**
	 *  UUID Column constructor
	 *  @param record_UU
	 */
	public UUIDColumn(String record_UU)
	{
		super();
		setRecord_UU(record_UU);
		setSelected(false);
	}   //  UUIDColumn

	/** Is the row selected         */
	private boolean     m_selected = false;
	/** The Record_UU               */
	private String     m_record_UU;

	/**
	 *  Set Selected
	 *  @param selected
	 */
	public void setSelected(boolean selected)
	{
		m_selected = selected;
	}
	/**
	 *  Is Column Selected
	 *  @return true if selected
	 */
	public boolean isSelected()
	{
		return m_selected;
	}

	/**
	 *  Set Record_UU
	 *  @param record_UU
	 */
	public void setRecord_UU(String record_UU)
	{
		m_record_UU = record_UU;
	}
	/**
	 * Get Record UU
	 * @return UU
	 */
	public String getRecord_UU()
	{
		return m_record_UU;
	}

	/**
	 *  To String
	 *  @return String representation
	 */
	@Override
	public String toString()
	{
		return "UUIDColumn - UU=" + m_record_UU + ", Selected=" + m_selected;
	}   //  toString

}   //  UUIDColumn
