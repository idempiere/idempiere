/******************************************************************************
 * Copyright (C) 2012 Carlos Ruiz                                             *
 * Copyright (C) 2012 Trek Global                                             *
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

package org.adempiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.Query;
import org.compiere.model.X_AD_WizardProcess;

public class MWizardProcess extends X_AD_WizardProcess {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7713151820360928310L;

	public MWizardProcess(Properties ctx, int AD_WizardProcess_ID, String trxName) {
		super(ctx, AD_WizardProcess_ID, trxName);
		if (AD_WizardProcess_ID == 0)
		{
			setIsActive(true); 
			
		}		
	}

	public MWizardProcess(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * Get the wizard notes for a node in the context client
	 *
	 * @param ctx
	 * @param AD_WF_Node_ID
	 * @param AD_Client_ID
	 * @param trxName
	 */
	public static MWizardProcess get(Properties ctx, int AD_WF_Node_ID, int AD_Client_ID) {
		Query query = new Query(ctx, Table_Name, "AD_WF_Node_ID=? AND AD_Client_ID=?", null);
		MWizardProcess wp = query.setParameters(new Object[]{AD_WF_Node_ID, AD_Client_ID}).first();
		if (wp == null) {
			wp = new MWizardProcess(ctx, 0, null);
			wp.setAD_WF_Node_ID(AD_WF_Node_ID);
			wp.setAD_Client_ID(AD_Client_ID);
		}
		return wp;
	}

} // MWizardProcess
