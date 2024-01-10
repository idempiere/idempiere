/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Copyright (C) 2003-2007 e-Evolution,SC. All Rights Reserved.               *
 * Contributor(s): Victor Perez www.e-evolution.com                           *
 *****************************************************************************/

package org.eevolution.process;

import java.util.List;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MSequence;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_AD_Table;
import org.compiere.process.SvrProcess;
import org.compiere.util.CacheMgt;

/**
 *	Process to Enable Native Sequence
 *	
 *  @author Victor Perez, e-Evolution, S.C.
 *  @author Teo Sarca, teo.sarca@gmail.com
 */
@org.adempiere.base.annotation.Process
public class EnableNativeSequence extends SvrProcess
{
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	@Override
	protected void prepare()
	{
	}	//	prepare
	
	@Override
	protected String doIt() throws Exception              
	{
		boolean SYSTEM_NATIVE_SEQUENCE = MSysConfig.getBooleanValue(MSysConfig.SYSTEM_NATIVE_SEQUENCE,false);
		if (SYSTEM_NATIVE_SEQUENCE)
		{
			throw new AdempiereException("Native Sequence is already set");
		}
		
		// update the sysconfig key to Y out of trx and reset the cache
		MSysConfig conf = new MSysConfig(getCtx(), SystemIDs.SYSCONFIG_SYSTEM_NATIVE_SEQUENCE, null);
		conf.setValue("Y");
		conf.saveEx();
		CacheMgt.get().reset(MSysConfig.Table_Name);

		try
		{
			createSequence("AD_Sequence", null);
			createSequence("AD_Issue", null);
			createSequence("AD_ChangeLog", null);
			//
			final String whereClause = "TableName NOT IN ('AD_Sequence', 'AD_Issue', 'AD_ChangeLog')"; 
			List<MTable> tables = new Query(getCtx(),X_AD_Table.Table_Name, whereClause, get_TrxName())
				.setOrderBy("TableName")
				.list();
			for(MTable table : tables)
			{
				createSequence(table, get_TrxName());
			}
		} catch (Exception e) {
			// reset to N on exception
			conf.setValue("N");
			conf.saveEx();
			throw e;
		}
		
		return "@OK@";
	}
	
	/**
	 * Create native sequence
	 * @param table
	 * @param trxName
	 */
	private void createSequence(MTable table, String trxName)
	{
		if(!table.isView())
		{	
			if(!MSequence.createTableSequence(getCtx(), table.getTableName(), trxName))
			{
				throw new AdempiereException("Can not create Native Sequence for table "+table.getTableName());
			}	
			else
			{	
				this.addLog("Create Native Sequence for : "+table.getTableName());		
			}
		}
	}
	
	/**
	 * Create native sequence
	 * @param tableName
	 * @param trxName
	 */
	private void createSequence(String tableName, String trxName)
	{
		createSequence(MTable.get(getCtx(), tableName), trxName);
	}	
}

