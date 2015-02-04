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
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.MBPartner;
import org.compiere.model.MConversionRate;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPO;
import org.compiere.model.MProduction;
import org.compiere.model.MProject;
import org.compiere.model.MProjectLine;
import org.compiere.util.Env;

/**
 *  Generate Purchase Order from Project.
 *
 *	@author Jorg Janke
 *	@version $Id: ProjectGenPO.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
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
			MProjectLine[] lines = project.getPhaseLines(m_C_ProjectPhase_ID);
			for (int i = 0; i < lines.length; i++)
				createProduction (project, lines[i]);
		}
		else
		{
			MProject project = new MProject (getCtx(), m_C_Project_ID, get_TrxName());
			MProjectLine[] lines = project.getLines();
			for (int i = 0; i < lines.length; i++)
				createProduction (project, lines[i]);
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
		
//		TODO - need to add C_ProjectLine.M_Production_ID
//		if (projectLine.getM_Production_ID() != 0)
//		{
//			addLog (projectLine.getLine() ,null,null, "Line was produced previously");
//			return;
//		}

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
		//TODO - need to add C_ProjectLine.M_Production_ID
		//projectLine.setM_Production_ID(production.getM_Production_ID());
		//projectLine.saveEx();

		addLog (production.getM_Production_ID(),
				production.getMovementDate(),
				new BigDecimal(0), 
				"Production:"+production.getDocumentNo(), 
				production.get_Table_ID(), 
				production.getM_Production_ID());
	}	//	createProductionfromProjectLine

}	//	ProjectGenProduction
