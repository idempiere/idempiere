/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.compiere.util;

import java.io.Serializable;
import java.util.concurrent.Callable;

/**
 * 
 * @author hengsin
 *
 */
public class ResetCacheCallable implements Callable<Integer>, Serializable 
{

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 6669645804211785491L;
	
	private String tableName;
	private int Record_ID;
	
	protected ResetCacheCallable(String tableName, int Record_ID)
	{
		this.tableName = tableName;
		this.Record_ID = Record_ID;
	}
	
	@Override
	public Integer call() throws Exception {
		return CacheMgt.get().resetLocalCache(tableName, Record_ID);
	}
	
}