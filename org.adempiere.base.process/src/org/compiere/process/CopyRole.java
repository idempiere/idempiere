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

import org.compiere.model.I_AD_Role_Included;
import org.compiere.util.DB;
import org.compiere.util.Env;


/**
 *	Copy role access records
 *	
 *  @author Robert Klein
 *  @ author Paul Bowden
 *  @version $Id: CopyRole.java,v 1.0$
 *  
 */

public class CopyRole extends SvrProcess
{
	private int m_AD_Role_ID_From = 0;
	private int m_AD_Role_ID_To = 0;
	private int m_AD_Client_ID = 0;	
	private int m_AD_Org_ID = 0;
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Role_ID") && i == 0)
				m_AD_Role_ID_From = para[i].getParameterAsInt();
			else if (name.equals("AD_Role_ID")&& i == 1)
				m_AD_Role_ID_To = para[i].getParameterAsInt();
			else if (name.equals("AD_Client_ID"))
				m_AD_Client_ID = para[i].getParameterAsInt();
			else if (name.equals("AD_Org_ID"))
				m_AD_Org_ID = para[i].getParameterAsInt();
		}		
	}	//	prepare

	/**
	 * 	Copy the role access records
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt() throws Exception
	{	
		String[] tables = new String[] {"AD_Window_Access", "AD_Process_Access", "AD_Form_Access",
				"AD_Workflow_Access", "AD_Task_Access", "AD_Document_Action_Access",
				I_AD_Role_Included.Table_Name,
		};
		String[] keycolumns = new String[] {"AD_Window_ID", "AD_Process_ID", "AD_Form_ID",
				"AD_Workflow_ID", "AD_Task_ID", "C_DocType_ID, AD_Ref_List_ID",
				I_AD_Role_Included.COLUMNNAME_Included_Role_ID,
		};
		
		int action = 0;
		
		for ( int i = 0; i < tables.length; i++ )
		{
			String table = tables[i];
			String keycolumn = keycolumns[i];
			
			StringBuilder sql = new StringBuilder("DELETE FROM ").append(table).append(" WHERE AD_Role_ID = ").append(m_AD_Role_ID_To);
			int no = DB.executeUpdateEx(sql.toString(), get_TrxName());
			addLog(action++, null, BigDecimal.valueOf(no), "Old records deleted from " + table );
			
			final boolean column_IsReadWrite =
				!table.equals("AD_Document_Action_Access")
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
			sql.append("SELECT ").append(m_AD_Client_ID)
				.append(", ").append(m_AD_Org_ID)
				.append(", getdate(), ").append(Env.getAD_User_ID(Env.getCtx()))
				.append(", getdate(), ").append(Env.getAD_User_ID(Env.getCtx()))
				.append(", ").append(m_AD_Role_ID_To)
				.append(", ").append(keycolumn)
				.append(", IsActive ");
			if (column_SeqNo)
				sql.append(", SeqNo ");
			if (column_IsReadWrite)
				sql.append(", isReadWrite ");
			sql.append("FROM ").append(table).append(" WHERE AD_Role_ID = ").append(m_AD_Role_ID_From);

			no = DB.executeUpdateEx (sql.toString(), get_TrxName());

			addLog(action++, null, new BigDecimal(no), "New records inserted into " + table );
		}
	
		return "Role copied";
	}	//	doIt
			}	//	CopyRole
