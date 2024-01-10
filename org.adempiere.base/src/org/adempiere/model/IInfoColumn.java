/******************************************************************************
 * Copyright (C) 2014 iDempiere                                               *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
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

package org.adempiere.model;

import org.compiere.model.MInfoColumn;

/**
 * Interface for class to provide access to contain or related {@link MInfoColumn}.
 * @see MInfoProcess
 * @see MInfoRelated
 * @author hieplq
 */
public interface IInfoColumn {
	/**
	 * Id of MInfoColumn
	 * @return
	 */
	public int getInfoColumnID ();
	
	/**
	 * Get MInfoColumn instance
	 * @return MInfoColumn
	 */
	public MInfoColumn getAD_InfoColumn ();
}
