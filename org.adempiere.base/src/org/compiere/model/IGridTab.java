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
package org.compiere.model;

/**
 * 
 * @author Elaine
 *
 */
public interface IGridTab {
	public String setValue(String columnName, Object value);
	public String setValue(GridField field, Object value);
	public Object getValue(String columnName);
	public Object getValue(GridField field);
	
	public String[] getActiveCallouts();
	public Callout[] getActiveCalloutInstance();
	
	public String processCallout(GridField field);
}
