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
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.model.IProcessParameter;

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
	 * Save parameters
	 * @param paras
	 * @param tableName
	 */
	public void saveParameters(MPInstancePara[] paras, String tableName) {

		MTable table = MTable.get(Env.getCtx(), tableName);
		PO po = table.getPO(parameterForm.getProcessInfo().getRecord_ID(), null);
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
				table = MTable.get(Env.getCtx(), tableName+"_Para");
				IProcessParameter poPara = null;
				if(tableName.equalsIgnoreCase(MScheduler.Table_Name))
					poPara = new MSchedulerPara(Env.getCtx(), 0, null);
				else if(tableName.equalsIgnoreCase(MProcessDrillRule.Table_Name))
					poPara = new MProcessDrillRulePara(Env.getCtx(), 0, null);
				poPara.setParentID(po.get_ValueAsInt(idColumn));
				for(MProcessPara processPara : processParameters) {
					if (processPara.getColumnName().equals(para.getParameterName())) {
						poPara.setAD_Process_Para_ID(processPara.getAD_Process_Para_ID());
						if (DisplayType.isNumeric(processPara.getAD_Reference_ID())) {
							if (para.get_Value(MPInstancePara.COLUMNNAME_P_Number) != null)
								poPara.setParameterDefault(para.getP_Number().toString());
							if (processPara.isRange() && para.get_Value(MPInstancePara.COLUMNNAME_P_Number_To) != null) 
								poPara.setParameterToDefault(para.getP_Number_To().toString());
						} else if (DisplayType.isID(processPara.getAD_Reference_ID())) {
							if (para.get_Value(MPInstancePara.COLUMNNAME_P_Number) != null)
								poPara.setParameterDefault(Integer.toString(para.getP_Number().intValue()));
							if (processPara.isRange() && para.get_Value(MPInstancePara.COLUMNNAME_P_Number_To) != null)
								poPara.setParameterToDefault(Integer.toString(para.getP_Number_To().intValue()));
						} else if (DisplayType.isDate(processPara.getAD_Reference_ID())) {
							if (para.getP_Date() != null)
								poPara.setParameterDefault(para.getP_Date().toString());
							if (processPara.isRange() && para.getP_Date_To() != null)
								poPara.setParameterToDefault(para.getP_Date_To().toString());
						} else {
							poPara.setParameterDefault(para.getP_String());
							if (processPara.isRange() && para.getP_String_To() != null)
								poPara.setParameterToDefault(para.getP_String_To());
						}
						if (!Util.isEmpty(para.getInfo())) {
							poPara.setDescription(para.getInfo());
						}
						if (!Util.isEmpty(para.getInfo_To())) {
							String s = poPara.getDescription();
							if (Util.isEmpty(s))
								s = para.getInfo_To();
							else
								s = s + ", " + para.getInfo_To();
							poPara.setDescription(s);
						}
						break;
					}
				}
				poPara.saveEx();
			}
		}		
	}
}
