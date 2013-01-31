/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.compiere.grid;

import java.util.List;

import org.adempiere.base.Service;
import org.compiere.model.GridTab;

public class VCreateFromFactory
{
	public static ICreateFrom create (GridTab mTab)
	{
		ICreateFrom createFrom = null;
		List<ICreateFromFactory> factories = Service.locator().list(ICreateFromFactory.class).getServices();
		for (ICreateFromFactory factory : factories) 
		{
			createFrom = factory.create(mTab);
			if (createFrom != null)
				break;
		}
		return createFrom;
	}
}