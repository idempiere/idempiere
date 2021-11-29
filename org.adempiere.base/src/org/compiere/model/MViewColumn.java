/******************************************************************************
 * Product: Compiere ERP & CRM Smart Business Solution                        *
 * Copyright (C) 1999-2007 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 3600 Bridge Parkway #102, Redwood City, CA 94065, USA      *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.db.Database;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOSupport;


public class MViewColumn extends X_AD_ViewColumn implements ImmutablePOSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4049071242637196213L;

	/**
	 * Standard constructor
	 * @param ctx context
	 * @param AD_ViewColumn_ID view column
	 * @param trxName trx name
	 */
	public MViewColumn(Properties ctx, int AD_ViewColumn_ID, String trxName)
	{
		super(ctx, AD_ViewColumn_ID, trxName);
	}
	
	/**
	 * Load constructor
	 * @param ctx context
	 * @param rs result set
	 * @param trxName trx name
	 */
	public MViewColumn(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * Parent constructor
	 * @param parent parent
	 */
	public MViewColumn(MViewComponent parent)
	{
		this(parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setAD_ViewComponent_ID(parent.getAD_ViewComponent_ID());
	}
	
	/**
	 * 
	 * @param copy
	 */
	public MViewColumn(MViewColumn copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MViewColumn(Properties ctx, MViewColumn copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MViewColumn(Properties ctx, MViewColumn copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * String representation
	 * @return info
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MViewColumn[");
		sb.append(get_ID()).append("-")
			.append(getColumnName())
			.append("]");
		return sb.toString();
	}

	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	@Override
	protected boolean beforeSave(boolean newRecord) {
		String error = Database.isValidIdentifier(getColumnName());
		if (!Util.isEmpty(error)) {
			if ( ! (getColumnName().startsWith("\"") && getColumnName().endsWith("\"")) ) { // quoted column is valid in views
				log.saveError("Error", Msg.getMsg(getCtx(), error) + " [ColumnName]");
				return false;
			}
		}
		return true;
	}

	@Override
	public MViewColumn markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
