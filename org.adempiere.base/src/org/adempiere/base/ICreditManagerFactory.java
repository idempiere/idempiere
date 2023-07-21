/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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
package org.adempiere.base;

import org.compiere.model.PO;

/**
 * Interface for Credit Manager Factory
 * 
 * @author Logilite Technologies
 * @since  June 25, 2023
 */
public interface ICreditManagerFactory
{
	/**
	 * get Credit Manager
	 * 
	 * @param  po Model class
	 * @return    instance of the ICreditManager
	 */
	public ICreditManager getCreditManager(PO po);
}
