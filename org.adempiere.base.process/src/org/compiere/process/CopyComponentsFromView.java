/**********************************************************************
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
 *                                                                     *
 * Contributors:                                                       *
 * - Diego Ruiz                                                        *
 **********************************************************************/
package org.compiere.process;

import java.util.logging.Level;

import org.compiere.model.MTable;
import org.compiere.model.MViewColumn;
import org.compiere.model.MViewComponent;
import org.compiere.model.PO;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *	Copy components from one view to other
 *	
 *  @author Diego Ruiz - Bx Service GmbH
 *  @version $Id: CopyComponentsFromView
 */
public class CopyComponentsFromView extends SvrProcess {
	
	/** Target Table		*/
	private int		p_target_AD_Table_ID = 0;
	/** Source Table		*/
	private int		p_source_AD_Table_ID = 0;
	
	/** Column Count	*/
	private int 	m_count = 0;
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Table_ID"))
				p_source_AD_Table_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_target_AD_Table_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		if (p_target_AD_Table_ID == 0)
			throw new AdempiereSystemError("@NotFound@ @AD_Table_ID@ " + p_target_AD_Table_ID);
		if (p_source_AD_Table_ID == 0)
			throw new AdempiereSystemError("@NotFound@ @AD_Table_ID@ " + p_source_AD_Table_ID);
		if (log.isLoggable(Level.INFO)) log.info("Source AD_Table_ID=" + p_source_AD_Table_ID
				+ ", Target AD_Table_ID=" + p_target_AD_Table_ID);
		
		MTable targetTable = new MTable(getCtx(), p_target_AD_Table_ID, get_TrxName());
		MViewComponent[] targetViewComponents = targetTable.getViewComponent(true);
		if (targetViewComponents.length > 0)
			throw new AdempiereSystemError(Msg.getMsg(Env.getCtx(), "ErrorCopyView"));
		
		MTable sourceTable = new MTable(getCtx(), p_source_AD_Table_ID, get_TrxName());
		MViewComponent[] sourceViewComponents = sourceTable.getViewComponent(true);
		
		for (int i = 0; i < sourceViewComponents.length; i++)
		{
			MViewComponent viewComponentTarget = new MViewComponent(targetTable);
			PO.copyValues(sourceViewComponents[i], viewComponentTarget);
			viewComponentTarget.setAD_Table_ID (targetTable.getAD_Table_ID());
			viewComponentTarget.setEntityType(targetTable.getEntityType());

			viewComponentTarget.setIsActive(sourceViewComponents[i].isActive());
			viewComponentTarget.saveEx(get_TrxName());
			
			copyViewColumns(sourceViewComponents[i] ,viewComponentTarget);
			
			m_count++;
		}
		
		//
		return "#" + m_count;
	}	//	doIt
	
	/**
	 * Copy view columns from one component to another
	 */
	public void copyViewColumns(MViewComponent sourceComponent, MViewComponent targetComponent) {
		
		MViewColumn[] sourceColumns = sourceComponent.getColumns(true);
		
		for (int i = 0; i < sourceColumns.length; i++)
		{
			MViewColumn columnTarget = new MViewColumn(targetComponent);
			PO.copyValues(sourceColumns[i], columnTarget);
			columnTarget.setAD_ViewComponent_ID(targetComponent.getAD_ViewComponent_ID());
			columnTarget.setEntityType(targetComponent.getEntityType());

			columnTarget.setIsActive(sourceColumns[i].isActive());
			columnTarget.saveEx(get_TrxName());			
		}
		
	}

}
