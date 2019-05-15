/******************************************************************************
 * Copyright (C) 2019 Murilo H. Torquato                                      *
 * Copyright (C) 2019 devCoffee                                               *
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
package org.adempiere.util;

import org.compiere.model.MLookup;



/**
 * Interface for callout Ask For Input
 *
 * @author Murilo H. Torquato (devCoffee, http://devcoffee.com.br)
 *
 */
public interface ICalloutUI {

	default public void askForInput(String message, MLookup lookup, int displayType, Callback<Object> callback){
		throw new RuntimeException("Not Implemented");
	}

	public void setDesktop(Object desktop);

}
