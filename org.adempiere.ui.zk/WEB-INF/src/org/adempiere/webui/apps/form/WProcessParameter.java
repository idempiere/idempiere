/******************************************************************************
 * Copyright (C) 2013 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.adempiere.webui.apps.form;

import org.adempiere.model.GenericPO;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.panel.WProcessParameterForm;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessDrillRule;
import org.compiere.model.MProcessDrillRulePara;
import org.compiere.model.MProcessPara;
import org.compiere.model.MScheduler;
import org.compiere.model.MSchedulerPara;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
@org.idempiere.ui.zk.annotation.Form
public class WProcessParameter implements IFormController {

	private WProcessParameterForm parameterForm = null;
	
	/**
	 * default constructor
	 */
	public WProcessParameter() {
		parameterForm = new WProcessParameterForm(this);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.IFormController#getForm()
	 */
	@Override
	public ADForm getForm() {
		return parameterForm;
	}

	/**
	 * Save parameters to AD_Scheduler_Para
	 * @param paras
	 */
	public void saveParameters(MPInstancePara[] paras, String tableName) {
		
		GenericPO po = new GenericPO(tableName, Env.getCtx(), parameterForm.getProcessInfo().getRecord_ID(), null);// PO(Env.getCtx(), parameterForm.getProcessInfo().getRecord_ID(), null); //MScheduler scheduler = new MScheduler(Env.getCtx(), parameterForm.getProcessInfo().getRecord_ID(), null);
		String idColumn = "";
		
		int AD_Process_ID = po.get_ValueAsInt("AD_Process_ID"); //scheduler.getAD_Process_ID();
		if (AD_Process_ID > 0 && paras.length > 0) {
			MProcess process = MProcess.get(Env.getCtx(), AD_Process_ID);
			MProcessPara[] processParameters = process.getParameters();
			
			//delete parameters
			if(tableName.equalsIgnoreCase(MScheduler.Table_Name)) {
				idColumn = "AD_Scheduler_ID";
				MScheduler scheduler = new MScheduler(Env.getCtx(), po.get_ID(), null);
				MSchedulerPara[] schedulerParas = scheduler.getParameters(true);
				for(MSchedulerPara para : schedulerParas) {
					para.deleteEx(true);
				}
			}
			else if(tableName.equalsIgnoreCase(MProcessDrillRule.Table_Name)) {
				idColumn = "AD_Process_DrillRule_ID";
				MProcessDrillRule drillRule = new MProcessDrillRule(Env.getCtx(), po.get_ID(), null);
				MProcessDrillRulePara[] drillRuleParas = drillRule.getParameters(true);
				for(MProcessDrillRulePara para : drillRuleParas) {
					para.deleteEx(true);
				}
			}
			//
			//child table always must have "_Para" suffix
			for(MPInstancePara para : paras) {
				GenericPO poPara = new GenericPO(tableName+"_Para", Env.getCtx(), 0, null);	
				poPara.set_ValueOfColumn(idColumn, (po.get_ValueAsInt(idColumn))); 
				for(MProcessPara processPara : processParameters) {
					if (processPara.getColumnName().equals(para.getParameterName())) {
						poPara.set_ValueOfColumn("AD_Process_Para_ID", processPara.getAD_Process_Para_ID());
						if (DisplayType.isNumeric(processPara.getAD_Reference_ID())) {
							if (para.get_Value(MPInstancePara.COLUMNNAME_P_Number) != null)
								poPara.set_ValueOfColumn("ParameterDefault", para.getP_Number().toString());
							if (processPara.isRange() && para.get_Value(MPInstancePara.COLUMNNAME_P_Number_To) != null) 
								poPara.set_ValueOfColumn("ParameterToDefault", para.getP_Number_To().toString());
						} else if (DisplayType.isID(processPara.getAD_Reference_ID())) {
							if (para.get_Value(MPInstancePara.COLUMNNAME_P_Number) != null)
								poPara.set_ValueOfColumn("ParameterDefault", Integer.toString(para.getP_Number().intValue()));
							if (processPara.isRange() && para.get_Value(MPInstancePara.COLUMNNAME_P_Number_To) != null)
								poPara.set_ValueOfColumn("ParameterToDefault", Integer.toString(para.getP_Number_To().intValue()));
						} else if (DisplayType.isDate(processPara.getAD_Reference_ID())) {
							if (para.getP_Date() != null)
								poPara.set_ValueOfColumn("ParameterDefault", para.getP_Date().toString());
							if (processPara.isRange() && para.getP_Date_To() != null)
								poPara.set_ValueOfColumn("ParameterToDefault", para.getP_Date_To().toString());
						} else {
							poPara.set_ValueOfColumn("ParameterDefault", para.getP_String());
							if (processPara.isRange() && para.getP_String_To() != null)
								poPara.set_ValueOfColumn("ParameterToDefault", para.getP_String_To());
						}
						if (!Util.isEmpty(para.getInfo())) {
							poPara.set_ValueOfColumn("Description", para.getInfo());
						}
						if (!Util.isEmpty(para.getInfo_To())) {
							String s = poPara.get_ValueAsString("Description");
							if (Util.isEmpty(s))
								s = para.getInfo_To();
							else
								s = s + ", " + para.getInfo_To();
							poPara.set_ValueOfColumn("Description", s);
						}
						break;
					}
				}
				poPara.saveEx();
			}
		}		
	}
}
