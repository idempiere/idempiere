/******************************************************************************
 * Copyright (C) 2014 TrekGlobal                                              *
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
package org.zkoss.zul.impl;

import org.zkoss.lang.Library;

/**
 * @author hengsin
 *
 */
public class CustomGridDataLoader extends GridDataLoader {

	public static final String GRID_DATA_LOADER_LIMIT = "org.zkoss.zul.grid.DataLoader.limit";
	
	/**
	 * 
	 */
	public CustomGridDataLoader() {
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zul.impl.GridDataLoader#getLimit()
	 */
	@Override
	public int getLimit() {
		String limit = Library.getProperty(GRID_DATA_LOADER_LIMIT);
		if (limit != null) {
			return Integer.parseInt(limit);
		}
		return super.getLimit();
	}

}
