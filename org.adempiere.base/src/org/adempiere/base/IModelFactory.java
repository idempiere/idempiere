/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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

import java.sql.ResultSet;

import org.compiere.model.PO;

/**
 * Model factory interface, extracted from legacy code in MTable.
 * @author hengsin
 */
public interface IModelFactory {
	/**
	 * 	Get Persistence Class for Table
	 *	@param tableName table name
	 *	@return class or null
	 */
	public Class<?> getClass (String tableName);

	/**************************************************************************
	 * 	Get PO Class Instance
	 *  @param tableName
	 *	@param Record_ID record
	 *	@param trxName
	 *	@return PO for Record or null
	 */
	public PO getPO (String tableName, int Record_ID, String trxName);

	/**
	 * 	Get PO Class Instance
	 *  @param tableName
	 *	@param rs result set
	 *	@param trxName transaction
	 *	@return PO for Record or null
	 */
	public PO getPO (String tableName, ResultSet rs, String trxName);
}
