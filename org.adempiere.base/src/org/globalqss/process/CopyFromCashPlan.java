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

package org.globalqss.process;

import java.util.logging.Level;

import org.compiere.model.MCashPlan;
import org.compiere.model.MCashPlanLine;
import org.compiere.model.PO;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;

public class CopyFromCashPlan  extends SvrProcess {

	private int p_C_CashPlanSource_ID = 0;
	private int p_C_CashPlanTarget_ID = 0;

	/**	Logger							*/
	CLogger log = CLogger.getCLogger (getClass());

	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (name.equals("C_CashPlan_ID"))
				p_C_CashPlanSource_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_C_CashPlanTarget_ID = getRecord_ID();
	}

	protected String doIt() throws Exception
	{
    	MCashPlan cptarget = new MCashPlan(getCtx(), p_C_CashPlanTarget_ID, get_TrxName());
    	if (cptarget.get_ID() <= 0)
    		throw new IllegalArgumentException ("Target Cash Plan does not exist");
    	MCashPlan cpsource = new MCashPlan(getCtx(), p_C_CashPlanSource_ID, get_TrxName());
    	if (cptarget.get_ID() <= 0)
    		throw new IllegalArgumentException ("Source Cash Plan does not exist");
    	
    	int insertNo = 0;
    	int lineNo = DB.getSQLValue(get_TrxName(), "SELECT NVL(MAX(Line),0)+10 FROM C_CashPlanLine WHERE C_CashPlan_ID=?", p_C_CashPlanTarget_ID);
    	
    	for (MCashPlanLine cpls : cpsource.getLines()) {
        	MCashPlanLine cplt = new MCashPlanLine(getCtx(), 0, get_TrxName());
        	PO.copyValues(cpls, cplt);
        	cplt.setAD_Org_ID(cptarget.getAD_Org_ID());
        	cplt.setLine(lineNo);
        	cplt.setC_CashPlan_ID(cptarget.getC_CashPlan_ID());
        	lineNo += 10;
        	
        	if (!cplt.save())
        		throw new AdempiereSystemError("Error saving cash plan line");
        	insertNo++;
        }

    	return "@Inserted@=" + insertNo;
	}

} // CopyFromCashPlan
