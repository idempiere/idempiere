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
package org.compiere.apps;

import org.compiere.model.DataStatusEvent;

/**
 * Status bar with three zone (from left to right): line, info and db.
 * @author hengsin
 *
 */
public interface IStatusBar 
{
	/**
	 * set text for db zone
	 * @param text
	 */
	public void setStatusDB (String text);
	
	/**
	 * set text for db zone
	 * @param text
	 * @param dse
	 */
	public void setStatusDB (String text, DataStatusEvent dse);
	
	/**
	 * set text for text zone
	 * @param text
	 */
	public void setStatusLine (String text);
	
	/**
	 * set text for text zone
	 * @param text
	 * @param error
	 */
	public void setStatusLine (String text, boolean error);
	
	/**
	 * set text for info zone
	 * @param text
	 */
	public void setInfo (String text);
}
