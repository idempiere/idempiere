/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *                                                                            *
 * Copyright (C) 2005 Robert KLEIN. robeklein@gmail.com                       *
 * Contributor(s): ______________________________________.                    *
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;

import org.adempiere.base.annotation.Parameter;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.I_AD_Role_Included;
import org.compiere.model.MRole;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;


/**
 *	Copy role access records
 *	
 *  @author Robert Klein
 *  @author Paul Bowden
 *  @contributor Jose.Leite
 *  @version $Id: CopyRole.java,v 1.0$
 *  
 */

@org.adempiere.base.annotation.Process
public class CopyRole extends SvrProcess
{
	@Parameter
	private int p_AD_Role_ID_From = 0;
	@Parameter
	private int p_AD_Role_ID_To = 0;
	@Parameter
	private int p_AD_Org_ID = 0;
	

	protected void prepare(){	
		
	}

	/**
	 * 	Copy the role access records
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt() throws Exception
	{			
		
		if (! MRole.getDefault().isAccessAdvanced()) {
			return "@Error@ @Advanced@ @Process@";
		}

		if (p_AD_Role_ID_From == p_AD_Role_ID_To)
			throw new AdempiereException(Msg.getMsg(getCtx(), "RolesMustBeDifferent"));

		String[] tables = new String[] {"AD_Window_Access", "AD_Process_Access", "AD_Form_Access",
				"AD_Workflow_Access", "AD_Task_Access", "AD_Document_Action_Access", "AD_InfoWindow_Access",
				I_AD_Role_Included.Table_Name
		};
		String[] keycolumns = new String[] {"AD_Window_ID", "AD_Process_ID", "AD_Form_ID",
				"AD_Workflow_ID", "AD_Task_ID", "C_DocType_ID, AD_Ref_List_ID", "AD_InfoWindow_ID",
				I_AD_Role_Included.COLUMNNAME_Included_Role_ID
		};
		
		int action = 0;
		
		for ( int i = 0; i < tables.length; i++ )
		{
			String table = tables[i];
			String keycolumn = keycolumns[i];
			
			StringBuilder sql = new StringBuilder("DELETE FROM ").append(table).append(" WHERE AD_Role_ID = ").append(p_AD_Role_ID_To);
			int no = DB.executeUpdateEx(sql.toString(), get_TrxName());
			addLog(action++, null, BigDecimal.valueOf(no), "Old records deleted from " + table );
			
			final boolean column_IsReadWrite =
				!table.equals("AD_Document_Action_Access")
				&& !table.equals("AD_InfoWindow_Access")
				&& !table.equals(I_AD_Role_Included.Table_Name);
			final boolean column_SeqNo = table.equals(I_AD_Role_Included.Table_Name); 
			
			sql = new StringBuilder("INSERT INTO ").append(table)
				.append(" (AD_Client_ID, AD_Org_ID, Created, CreatedBy, Updated, UpdatedBy, ") 
				.append(   "AD_Role_ID, ").append(keycolumn).append(", isActive");
			if (column_SeqNo)
				sql.append(", SeqNo ");
			if (column_IsReadWrite)
				sql.append(", isReadWrite) ");
			else
				sql.append(") ");
			sql.append("SELECT ").append(Env.getAD_Client_ID(getCtx()))
				.append(", ").append(p_AD_Org_ID)
				.append(", getDate(), ").append(Env.getAD_User_ID(Env.getCtx()))
				.append(", getDate(), ").append(Env.getAD_User_ID(Env.getCtx()))
				.append(", ").append(p_AD_Role_ID_To)
				.append(", ").append(keycolumn)
				.append(", IsActive ");
			if (column_SeqNo)
				sql.append(", SeqNo ");
			if (column_IsReadWrite)
				sql.append(", isReadWrite ");
			sql.append("FROM ").append(table).append(" WHERE AD_Role_ID = ").append(p_AD_Role_ID_From);

			no = DB.executeUpdateEx (sql.toString(), get_TrxName());

			addLog(action++, null, new BigDecimal(no), "New records inserted into " + table );
		}
	
		return Msg.getMsg(getCtx(),"RoleCopied");
	}	//	doIt

}	//	CopyRole
