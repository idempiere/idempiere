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
package org.compiere.process;

import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.Msg;

/**
 * Process to create or update DB view with view definition from AD_ViewComponent
 */
@org.adempiere.base.annotation.Process
public class DatabaseViewValidate extends SvrProcess {

	private int		p_AD_Table_ID = 0; 
	
	@Override
	protected void prepare() 
	{
		p_AD_Table_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception 
	{
		MTable table = new MTable(getCtx(), p_AD_Table_ID, get_TrxName());
		log.info(table.toString());
		if (!table.isView() || !table.isActive())
			throw new AdempiereException(Msg.getMsg(getCtx(), "NotActiveDatabaseView"));
		
		return validateDatabaseView(getCtx(), table, get_TrxName());
	}
	
	/**
	 * Create or update DB view with view definition from AD_ViewComponent
	 * @param ctx
	 * @param table
	 * @param trxName
	 * @return info message
	 * @throws Exception if create/update view fail
	 */
	public static String validateDatabaseView(Properties ctx, MTable table, String trxName) throws Exception 
	{
		String sql = "INSERT INTO t_alter_view(viewname) VALUES ('" + table.getTableName() + "')";
		DB.executeUpdateEx(sql, trxName);
		return Msg.getMsg(ctx, "CreatedOrReplacedViewSuccess");
	}
}
