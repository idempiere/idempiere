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

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.logging.Level;

import org.compiere.model.MCashPlan;
import org.compiere.model.MCashPlanLine;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

public class GeneratePeriodicCashPlanLines  extends SvrProcess {

	private int p_C_Project_ID = 0;
	private int p_C_Activity_ID = 0;
	private String p_Name = null;
	private int p_M_Product_ID = 0;
	private int p_C_Charge_ID = 0;
	private int p_C_BPartner_ID = 0;
	private String p_Periodicity = null;
	private int p_Repetitions = 0;
	private BigDecimal p_Amount = null;
	private Timestamp p_DateFrom = null;
	private BigDecimal p_Probability = null;
	private int p_C_CashPlan_ID = 0;

	/**	Logger							*/
	CLogger log = CLogger.getCLogger (getClass());

	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (name.equals("C_Project_ID"))
				p_C_Project_ID = para[i].getParameterAsInt();
			else if (name.equals("C_Activity_ID"))
				p_C_Activity_ID = para[i].getParameterAsInt();
			else if (name.equals("Name"))
				p_Name = (String) para[i].getParameter();
			else if (name.equals("M_Product_ID"))
				p_M_Product_ID = para[i].getParameterAsInt();
			else if (name.equals("C_Charge_ID"))
				p_C_Charge_ID = para[i].getParameterAsInt();
			else if (name.equals("C_BPartner_ID"))
				p_C_BPartner_ID = para[i].getParameterAsInt();
			else if (name.equals("Periodicity"))
				p_Periodicity = (String) para[i].getParameter();
			else if (name.equals("Repetitions"))
				p_Repetitions = para[i].getParameterAsInt();
			else if (name.equals("Amount"))
				p_Amount = (BigDecimal) para[i].getParameter();
			else if (name.equals("DateFrom"))
				p_DateFrom = (Timestamp) para[i].getParameter();
			else if (name.equals("Probability"))
				p_Probability = (BigDecimal) para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_C_CashPlan_ID = getRecord_ID();
	}

	protected String doIt() throws Exception
	{
		boolean usename = (p_Name != null && p_Name.trim().length() > 0);
   		boolean useproduct = (p_M_Product_ID > 0);
   		boolean usecharge = (p_C_Charge_ID > 0);
   		if (!usename && !useproduct && !usecharge)
    		throw new IllegalArgumentException ("Required at least one of the fields Name, Product, Charge");
   		if (useproduct && usecharge)
    		throw new IllegalArgumentException ("Product and charge are exclusive, you can use just one of them");
   		if (p_Amount.signum() == 0)
    		throw new IllegalArgumentException ("Amount must be different than zero");
   		if (p_Repetitions <= 0)
    		return "@Inserted@=0";
    	
    	if (p_Probability == null)
    		p_Probability = Env.ONEHUNDRED;
    	
    	/* Periodicity */
    	int days = 0;
    	int months = 0;
    	int years = 0;
    	if ("001_D".equals(p_Periodicity)) // 001_D - Daily
    		days = 1;
    	else if ("007_W".equals(p_Periodicity)) // 007_W - Weekly
    		days = 7;
   		else if ("014_F".equals(p_Periodicity)) // 014_F - Fortnightly
   			days = 14;
   		else if ("015_B".equals(p_Periodicity)) // 015_B - Biweekly
   			days = 15;
   		else if ("030_M".equals(p_Periodicity)) // 030_M - Monthly
   			months = 1;
   		else if ("060_2".equals(p_Periodicity)) // 060_2 - Bimonthly
   			months = 2;
   		else if ("090_Q".equals(p_Periodicity)) // 090_Q - Quarterly
   			months = 3;
   		else if ("180_S".equals(p_Periodicity)) // 180_S - Semiannual
   			months = 6;
   		else if ("365_Y".equals(p_Periodicity)) // 365_Y - Yearly
   			years = 1;
   		else
   			throw new IllegalArgumentException ("Wrong periodicity " + p_Periodicity);
    	
    	MCashPlan cp = new MCashPlan(getCtx(), p_C_CashPlan_ID, get_TrxName());
    	if (cp.get_ID() <= 0)
    		throw new IllegalArgumentException ("Cash Plan does not exist");
    	
    	int insertNo = 0;
    	int lineNo = DB.getSQLValue(get_TrxName(), "SELECT NVL(MAX(Line),0)+10 FROM C_CashPlanLine WHERE C_CashPlan_ID=?", p_C_CashPlan_ID);
    	
    	for (int cnt = 0; cnt < p_Repetitions; cnt++) {
        	MCashPlanLine cpl = new MCashPlanLine(getCtx(), 0, get_TrxName());
        	cpl.setC_CashPlan_ID(cp.getC_CashPlan_ID());
        	cpl.setAD_Org_ID(cp.getAD_Org_ID());
        	cpl.setProcessed(false);
        	cpl.setIsActive(true);
        	cpl.setQtyEntered(Env.ONE);
        	cpl.setAD_OrgTrx_ID(cp.getAD_OrgTrx_ID());
        	cpl.setC_Campaign_ID(cp.getC_Campaign_ID());
        	cpl.setUser1_ID(cp.getUser1_ID());
        	cpl.setUser2_ID(cp.getUser2_ID());
        	// cpl.setC_ProjectPhase_ID(cp.getC_ProjectPhase_ID());
        	// cpl.setC_ProjectTask_ID(cp.getC_ProjectTask_ID());
        	// cpl.setDescription(cp.getDescription());
        	cpl.setC_Activity_ID(p_C_Activity_ID);
        	cpl.setC_Project_ID(p_C_Project_ID);
        	cpl.setC_Charge_ID(p_C_Charge_ID);
        	cpl.setM_Product_ID(p_M_Product_ID);
        	cpl.setName(p_Name);
        	cpl.setLineTotalAmt(p_Amount);
        	cpl.setC_BPartner_ID(p_C_BPartner_ID);
        	cpl.setProbability(p_Probability);
        	cpl.setLine(lineNo);
        	// calculate new date from
        	Calendar cal = Calendar.getInstance();
        	cal.setTime(p_DateFrom);
        	if (days == 15) {
        		// special case Biweekly
        		// add months
        		int bwmonths = cnt / 2; // integer division -> 1/2=0  2/2=1  3/2=1
            	cal.add(Calendar.MONTH, bwmonths);
            	// if odd add 15 additional days
        		if ((cnt % 2) != 0) {
               		cal.add(Calendar.DAY_OF_MONTH, days);
        		}
        	} else {
            	cal.add(Calendar.DAY_OF_MONTH, days*cnt);
            	cal.add(Calendar.MONTH, months*cnt);
            	cal.add(Calendar.YEAR, years*cnt);
        	}
        	Timestamp datetrx = new Timestamp(cal.getTimeInMillis());
        	cpl.setDateTrx(datetrx);
        	lineNo += 10;
        	
        	if (!cpl.save())
        		throw new AdempiereSystemError("Error saving cash plan line");
        	insertNo++;
        }

    	return "@Inserted@=" + insertNo;
	}

} // GeneratePeriodicCashPlanLines
