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
**********************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.util.logging.Level;

import org.compiere.model.MProduct;
import org.compiere.model.MProduction;
import org.compiere.model.MProject;
import org.compiere.model.MProjectLine;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *  Generate Production from Project.
 *
 *	@author Chuck Boecking
 */
@org.adempiere.base.annotation.Process
public class ProjectGenProduction extends SvrProcess
{
	/** Project Parameter			*/
	private int 		m_C_Project_ID = 0;
	/** Opt Project Line Parameter	*/
	private int 		m_C_ProjectPhase_ID = 0;
	/** Opt Project Line Parameter	*/
	private int 		m_C_ProjectLine_ID = 0;

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
			else if (name.equals("C_Project_ID"))
				m_C_Project_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_ProjectPhase_ID"))
				m_C_ProjectPhase_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else if (name.equals("C_ProjectLine_ID"))
				m_C_ProjectLine_ID = ((BigDecimal)para[i].getParameter()).intValue();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message 
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("doIt - C_Project_ID=" + m_C_Project_ID + " - C_ProjectLine_ID=" + m_C_ProjectLine_ID);
		if (m_C_ProjectLine_ID != 0)
		{
			MProjectLine projectLine = new MProjectLine(getCtx(), m_C_ProjectLine_ID, get_TrxName());
			MProject project = new MProject (getCtx(), projectLine.getC_Project_ID(), get_TrxName());
			createProduction (project, projectLine);
		}
		else if (m_C_ProjectPhase_ID != 0)
		{
			MProject project = new MProject (getCtx(), m_C_Project_ID, get_TrxName());
			for (MProjectLine line : project.getPhaseLines(m_C_ProjectPhase_ID)) {
				if (line.isActive()) {
					createProduction (project, line);
				}
			}
		}
		else
		{
			MProject project = new MProject (getCtx(), m_C_Project_ID, get_TrxName());
			for (MProjectLine line : project.getLines()) {
				if (line.isActive()) {
					createProduction (project, line);
				}
			}
		}
		return "";
	}	//	doIt

	/**
	 * 	Create PO from Planned Amt/Qty
	 * 	@param projectLine project line
	 */
	private void createProduction (MProject project, MProjectLine projectLine)
	{
		if (projectLine.getM_Product_ID() == 0)
		{
			addLog (project.getC_Project_ID(),
					project.getCreated(),
					new BigDecimal(0), 
					"ISSUE: Line has no Product - ProjectLine:"+projectLine.getLine()+" Desc:"+projectLine.getDescription(), 
					projectLine.get_Table_ID(), 
					projectLine.getC_ProjectLine_ID());
			return;
		}
		
		MProduct M_Product = new MProduct(getCtx(), projectLine.getM_Product_ID(), get_TrxName());
		if (!M_Product.isManufactured())
		{
			addLog (project.getC_Project_ID(),
					project.getCreated(),
					new BigDecimal(0), 
					"ISSUE: Product is not manufactured - ProjectLine:"+projectLine.getLine()+" Desc:"+projectLine.getDescription(), 
					projectLine.get_Table_ID(), 
					projectLine.getC_ProjectLine_ID());
			return;
		}
		
		if (projectLine.getM_Production_ID() != 0)
		{
			addLog (projectLine.getLine() ,null,null, "Line was produced previously");
			return;
		}

		//	Create to Production
		MProduction production = null;

		//	New Production Header
		production = new MProduction (projectLine);
		int AD_Org_ID = projectLine.getAD_Org_ID();
		if (AD_Org_ID == 0)
		{
			log.warning("createProductionfromProjectLine - AD_Org_ID=0");
			AD_Org_ID = Env.getAD_Org_ID(getCtx());	
			if (AD_Org_ID != 0)
				projectLine.setAD_Org_ID(AD_Org_ID);
		}
		production.setC_BPartner_ID(project.getC_BPartner_ID());
		production.saveEx();

		//	update ProjectLine
		projectLine.setM_Production_ID(production.getM_Production_ID());
		projectLine.saveEx();

		addBufferLog (production.getM_Production_ID(),
				production.getMovementDate(),
				new BigDecimal(0), 
				Msg.getElement(Env.getAD_Language(Env.getCtx()), "M_Production_ID", false)+":"+production.getDocumentNo(), 
				production.get_Table_ID(), 
				production.getM_Production_ID());
	}	//	createProductionfromProjectLine

}	//	ProjectGenProduction
