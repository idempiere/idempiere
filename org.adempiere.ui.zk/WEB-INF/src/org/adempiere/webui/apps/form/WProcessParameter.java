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
	public void saveParameters(MPInstancePara[] paras) {
		MScheduler scheduler = new MScheduler(Env.getCtx(), parameterForm.getProcessInfo().getRecord_ID(), null);
		int AD_Process_ID = scheduler.getAD_Process_ID();
		if (AD_Process_ID > 0 && paras.length > 0) {
			MProcess process = MProcess.get(Env.getCtx(), AD_Process_ID);
			MProcessPara[] processParameters = process.getParameters();
			MSchedulerPara[] schedulerParas = scheduler.getParameters(true);
			for(MSchedulerPara para : schedulerParas) {
				para.deleteEx(true);
			}
			
			for(MPInstancePara para : paras) {
				MSchedulerPara schedulerPara = new MSchedulerPara(Env.getCtx(), 0, null);
				schedulerPara.setAD_Scheduler_ID(scheduler.getAD_Scheduler_ID());
				for(MProcessPara processPara : processParameters) {
					if (processPara.getColumnName().equals(para.getParameterName())) {
						schedulerPara.setAD_Process_Para_ID(processPara.getAD_Process_Para_ID());
						if (DisplayType.isNumeric(processPara.getAD_Reference_ID())) {
							if (para.getP_Number() != null)
								schedulerPara.setParameterDefault(para.getP_Number().toString());
							if (para.getP_Number_To() != null) 
								schedulerPara.setParameterToDefault(para.getP_Number_To().toString());
						} else if (DisplayType.isID(processPara.getAD_Reference_ID())) {
							if (para.getP_Number() != null)
								schedulerPara.setParameterDefault(Integer.toString(para.getP_Number().intValue()));
							if (para.getP_Number_To() != null)
								schedulerPara.setParameterToDefault(Integer.toString(para.getP_Number_To().intValue()));
						} else if (DisplayType.isDate(processPara.getAD_Reference_ID())) {
							if (para.getP_Date() != null)
								schedulerPara.setParameterDefault(para.getP_Date().toString());
							if (para.getP_Date_To() != null)
								schedulerPara.setParameterToDefault(para.getP_Date_To().toString());
						} else {
							schedulerPara.setParameterDefault(para.getP_String());
							if (para.getP_String_To() != null)
								schedulerPara.setParameterToDefault(para.getP_String_To());
						}
						if (!Util.isEmpty(para.getInfo())) {
							schedulerPara.setDescription(para.getInfo());
						}
						if (!Util.isEmpty(para.getInfo_To())) {
							String s = schedulerPara.getDescription();
							if (Util.isEmpty(s))
								s = para.getInfo_To();
							else
								s = s + ", " + para.getInfo_To();
							schedulerPara.setDescription(s);
						}
						break;
					}
				}
				
				schedulerPara.saveEx();
			}
		}		
	}
}
