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



import static org.compiere.model.SystemIDs.PROCESS_AD_NATIVE_SEQUENCE_ENABLE;

import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.Adempiere;
import org.compiere.model.MPInstance;
import org.compiere.model.MSequence;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_AD_Table;
import org.compiere.process.ProcessInfo;
import org.compiere.process.SvrProcess;
import org.compiere.util.CLogMgt;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;

/**
 *	Enable Native Sequence
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
	protected void prepare()
	{
	}	//	prepare
	
	protected String doIt() throws Exception              
	{
		boolean SYSTEM_NATIVE_SEQUENCE = MSysConfig.getBooleanValue(MSysConfig.SYSTEM_NATIVE_SEQUENCE,false);
		if (SYSTEM_NATIVE_SEQUENCE)
		{
			throw new AdempiereException("Native Sequence is Actived");
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
	private void createSequence(String tableName, String trxName)
	{
		createSequence(MTable.get(getCtx(), tableName), trxName);
	}
	
	/**
	 * Main test
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) 
	{
		Adempiere.startupEnvironment(true);
		CLogMgt.setLevel(Level.INFO);

		Properties ctx = Env.getCtx();
		int AD_Process_ID = PROCESS_AD_NATIVE_SEQUENCE_ENABLE; // HARDCODED

		MPInstance pinstance = new MPInstance(ctx, AD_Process_ID, -1);
		pinstance.saveEx();

		ProcessInfo pi = new ProcessInfo("", AD_Process_ID, 0, 0);
		pi.setAD_Client_ID(Env.getAD_Client_ID(ctx));
		pi.setAD_User_ID(Env.getAD_User_ID(ctx));
		pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		//
		EnableNativeSequence proc = new EnableNativeSequence();
		proc.startProcess(ctx, pi, null);
		if (pi.isError())
		{
			throw new AdempiereException(pi.getSummary());
		}
	}
}

