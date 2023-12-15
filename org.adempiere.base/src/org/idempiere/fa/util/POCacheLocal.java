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
 **********************************************************************/
package org.idempiere.fa.util;

import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MTable;
import org.compiere.model.PO;

/**
 * Load and cache instance of foreign key referenced PO.<br/>
 * For e.g, parent is MOrderLine and referenced PO is MProduct.
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * @param <T> Foreing key reference type
 */
public final class POCacheLocal<T extends PO>
{
	private final PO parent;
	private final String idColumnName;
	private final String po_tableName;
	private T po = null;
	
	/**
	 * Create new instance of POCacheLocal 
	 * @param <T>
	 * @param parent
	 * @param cl
	 * @return POCacheLocal
	 */
	public static <T extends PO> POCacheLocal<T> newInstance(PO parent, Class<T> cl)
	{
		return new POCacheLocal<T>(parent, cl);
	}
	
	/**
	 * Create new instance of POCacheLocal
	 * @param <T>
	 * @param parent
	 * @param cl
	 * @param idColumnName
	 * @return POCacheLocal
	 */
	public static <T extends PO> POCacheLocal<T> newInstance(PO parent, Class<T> cl, String idColumnName)
	{
		return new POCacheLocal<T>(parent, cl, idColumnName);
	}
	
	/**
	 * @param parent
	 * @param cl
	 */
	private POCacheLocal(PO parent, Class<T> cl)
	{
		this(parent, cl, null);
	}
	
	/**
	 * @param parent Parent PO
	 * @param cl foreign key reference type
	 * @param idColumnName optional foreign key reference column name in parent
	 */
	private POCacheLocal(PO parent, Class<T> cl, String idColumnName)
	{
		this.parent = parent;
		try
		{
			this.po_tableName = (String)cl.getField("Table_Name").get(null);
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		if (idColumnName == null)
		{
			this.idColumnName = this.po_tableName + "_ID";
		}
		else
		{
			this.idColumnName = idColumnName;
		}
	}
	
	/**
	 * Get instance of referenced PO from cache or DB 
	 * @param requery true to always reload from DB
	 * @return instance of referenced PO
	 */
	public T get(boolean requery)
	{
		int id = get_id();
		if (id <= 0)
		{
			this.po = null;
			return null;
		}
		if (requery || !isValidPO(this.po))
		{
			this.po = load(this.parent.getCtx(), id, this.parent.get_TrxName());
		}
		return this.po;
	}
	
	/**
	 * Set cached referenced PO
	 * @param po
	 */
	public void set(T po)
	{
		if (isValidPO(po))
		{
			this.po = po;
		}
	}
	
	/**
	 * @param po
	 * @return true if po is a valid instance of referenced PO
	 */
	private boolean isValidPO(T po)
	{
		int id = get_id();
		return id > 0
				&& po != null
				&& po.get_ID() == id
				&& Util.equals(this.parent.get_TrxName(), po.get_TrxName())
		;
	}

	/**
	 * Load referenced PO from DB
	 * @param ctx
	 * @param id
	 * @param trxName
	 * @return loaded referenced PO instance
	 */
	@SuppressWarnings("unchecked")
	protected T load(Properties ctx, int id, String trxName)
	{
		return (T)MTable.get(ctx, this.po_tableName).getPO(id, trxName);
	}
	
	/**
	 * @return foreign key reference id value from parent PO
	 */
	private int get_id()
	{
		return parent.get_ValueAsInt(idColumnName);
	}
}
