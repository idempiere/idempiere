/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz - globalqss                               *
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
* - Carlos Ruiz - globalqss                                           *
*                                                                     *
* Sponsors:                                                           *
* - Company (http://www.globalqss.com)                                *
***********************************************************************/

package org.adempiere.process;

import java.io.File;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.Adempiere;
import org.compiere.model.MCity;
import org.compiere.model.MCurrency;
import org.compiere.model.MSetup;
import org.compiere.model.MSysConfig;
import org.compiere.print.PrintUtil;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * 	Process to create a new client (tenant)
 *	
 *  @author Carlos Ruiz
 *    [ 2598506 ] FR - Implement Initial Client Setup
 */
public class InitialClientSetup extends SvrProcess
{
	
	// Process Parameters
	private String p_ClientName = null;
	private String p_OrgValue = null;
	private String p_OrgName = null;
	private String p_AdminUserName = null;
	private String p_NormalUserName = null;
	private boolean p_IsSetInitialPassword = true;
	private int p_C_Currency_ID = 0;
	private int p_C_Country_ID = 0;
	private int p_C_Region_ID = 0;
	private String p_CityName = null;
	private String p_Postal = null;
	private String p_Address1 = null;
	private String p_Phone = null;
	private String p_Phone2 = null;
	private String p_Fax = null;
	private String p_EMail = null;
	private String p_TaxID = null;
	private int p_C_City_ID = 0;
	private boolean p_IsUseBPDimension = true;
	private boolean p_IsUseProductDimension = true;
	private boolean p_IsUseProjectDimension = false;
	private boolean p_IsUseCampaignDimension = false;
	private boolean p_IsUseSalesRegionDimension = false;
	private boolean p_IsUseActivityDimension;
	private boolean p_UseDefaultCoA = false;
	private String p_CoAFile = null;
	private boolean p_InactivateDefaults = false;
	private String p_AdminUserEmail = null;
	private String p_NormalUserEmail = null;

	/** WindowNo for this process */
	public static final int     WINDOW_THIS_PROCESS = 9999;

	/**
	 * 	Prepare
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("ClientName"))
				p_ClientName = (String) para[i].getParameter();
			else if (name.equals("OrgValue"))
				p_OrgValue = (String) para[i].getParameter();
			else if (name.equals("OrgName"))
				p_OrgName = (String) para[i].getParameter();
			else if (name.equals("AdminUserName"))
				p_AdminUserName = (String) para[i].getParameter();
			else if (name.equals("NormalUserName"))
				p_NormalUserName = (String) para[i].getParameter();
			else if (name.equals("IsSetInitialPassword"))
				p_IsSetInitialPassword = para[i].getParameterAsBoolean();
			else if (name.equals("C_Currency_ID"))
				p_C_Currency_ID = para[i].getParameterAsInt();
			else if (name.equals("C_Country_ID"))
				p_C_Country_ID = para[i].getParameterAsInt();
			else if (name.equals("C_Region_ID"))
				p_C_Region_ID = para[i].getParameterAsInt();
			else if (name.equals("CityName"))
				p_CityName = (String) para[i].getParameter();
			else if (name.equals("C_City_ID"))
				p_C_City_ID = para[i].getParameterAsInt();
			else if (name.equals("Postal"))
				p_Postal = (String) para[i].getParameter();
			else if (name.equals("Address1"))
				p_Address1 = (String) para[i].getParameter();
			else if (name.equals("IsUseBPDimension"))
				p_IsUseBPDimension = para[i].getParameterAsBoolean();
			else if (name.equals("IsUseProductDimension"))
				p_IsUseProductDimension = para[i].getParameterAsBoolean();
			else if (name.equals("IsUseProjectDimension"))
				p_IsUseProjectDimension = para[i].getParameterAsBoolean();
			else if (name.equals("IsUseCampaignDimension"))
				p_IsUseCampaignDimension = para[i].getParameterAsBoolean();
			else if (name.equals("IsUseSalesRegionDimension"))
				p_IsUseSalesRegionDimension = para[i].getParameterAsBoolean();
			else if (name.equals("IsUseActivityDimension"))
				p_IsUseActivityDimension = para[i].getParameterAsBoolean();
			else if (name.equals("UseDefaultCoA"))
				p_UseDefaultCoA = para[i].getParameterAsBoolean();
			else if (name.equals("CoAFile"))
				p_CoAFile = (String) para[i].getParameter();
			else if (name.equals("InactivateDefaults"))
				p_InactivateDefaults = para[i].getParameterAsBoolean();
			else if (name.equals("Phone"))
				p_Phone = (String) para[i].getParameter();
			else if (name.equals("Phone2"))
				p_Phone2 = (String) para[i].getParameter();
			else if (name.equals("Fax"))
				p_Fax = (String) para[i].getParameter();
			else if (name.equals("EMail"))
				p_EMail = (String) para[i].getParameter();
			else if (name.equals("TaxID"))
				p_TaxID = (String) para[i].getParameter();
			else if (name.equals("AdminUserEmail"))
				p_AdminUserEmail = (String) para[i].getParameter();
			else if (name.equals("NormalUserEmail"))
				p_NormalUserEmail = (String) para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		boolean isDryRun = "Y".equalsIgnoreCase(Env.getContext(Env.getCtx(), Env.RUNNING_UNIT_TESTING_TEST_CASE));
		
		StringBuilder msglog = new StringBuilder("InitialClientSetup")
								.append(": ClientName=").append(p_ClientName)
								.append(", OrgValue=").append(p_OrgValue)
								.append(", OrgName=").append(p_OrgName)
								.append(", AdminUserName=").append(p_AdminUserName)
								.append(", NormalUserName=").append(p_NormalUserName)
								.append(", IsSetInitialPassword=").append(p_IsSetInitialPassword)
								.append(", C_Currency_ID=").append(p_C_Currency_ID)
								.append(", C_Country_ID=").append(p_C_Country_ID)
								.append(", C_Region_ID=").append(p_C_Region_ID)
								.append(", CityName=").append(p_CityName)
								.append(", C_City_ID=").append(p_C_City_ID)
								.append(", IsUseBPDimension=").append(p_IsUseBPDimension)
								.append(", IsUseProductDimension=").append(p_IsUseProductDimension)
								.append(", IsUseProjectDimension=").append(p_IsUseProjectDimension)
								.append(", IsUseCampaignDimension=").append(p_IsUseCampaignDimension)
								.append(", IsUseSalesRegionDimension=").append(p_IsUseSalesRegionDimension)
								.append(", IsUseActivityDimension=").append(p_IsUseActivityDimension)
								.append(", UseDefaultCoA=").append(p_UseDefaultCoA)
								.append(", InactivateDefaults=").append(p_InactivateDefaults)
								.append(", CoAFile=").append(p_CoAFile);
		
		if (log.isLoggable(Level.INFO)) log.info(msglog.toString());

		// Validations
		if (p_UseDefaultCoA)
			p_CoAFile = null;

		// Validate Mandatory parameters
		if (   p_ClientName == null || p_ClientName.length() == 0
			|| p_OrgName == null || p_OrgName.length() == 0
			|| p_AdminUserName == null || p_AdminUserName.length() == 0
			|| p_NormalUserName == null || p_NormalUserName.length() == 0
			|| p_C_Currency_ID <= 0
			|| p_C_Country_ID <= 0
			|| (!p_UseDefaultCoA && (p_CoAFile == null || p_CoAFile.length() == 0))
			)
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "Missing required parameters"));

		// Validate Uniqueness of client and users name
		//	Unique Client Name
		if (DB.executeUpdate("UPDATE AD_Client SET CreatedBy=0 WHERE Name=?", new Object[] {p_ClientName}, false, null) != 0)
			throw new AdempiereException("@" + Msg.getMsg(Env.getCtx(), "NotUnique") + "@ " + p_ClientName);

		//	Unique User Names
		if (DB.executeUpdate("UPDATE AD_User SET CreatedBy=0 WHERE Name=?", new Object[] {p_AdminUserName}, false, null) != 0)
			throw new AdempiereException("@" + Msg.getMsg(Env.getCtx(), "NotUnique") + "@ " + p_AdminUserName);
		if (DB.executeUpdate("UPDATE AD_User SET CreatedBy=0 WHERE Name=?", new Object[] {p_NormalUserName}, false, null) != 0)
			throw new AdempiereException("@" + Msg.getMsg(Env.getCtx(), "NotUnique") + "@ " + p_NormalUserName);

		// City_ID overrides CityName if both used
		if (p_C_City_ID > 0) {
			MCity city = MCity.get(getCtx(), p_C_City_ID);
			if (! city.getName().equals(p_CityName)) {
				msglog = new StringBuilder("City name changed from ").append(p_CityName).append(" to ").append(city.getName());
				if (log.isLoggable(Level.INFO)) log.info(msglog.toString());
				p_CityName = city.getName();
			}
		}

		// Validate existence and read permissions on CoA file
		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
		if (email_login) {
			if (Util.isEmpty(p_AdminUserEmail)) 
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "AdminUserEmail is required"));
			if (! EMail.validate(p_AdminUserEmail)) 
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "AdminUserEmail") + " "  + p_AdminUserEmail + " " + Msg.getMsg(Env.getCtx(), "is incorrect") );
			if (Util.isEmpty(p_NormalUserEmail)) 
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NormalUserEmail is required") );
			if (! EMail.validate(p_NormalUserEmail)) 
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NormalUserEmail") + " " + p_NormalUserEmail + " " + Msg.getMsg(Env.getCtx(), "is incorrect"));
		}
		if (Util.isEmpty(p_CoAFile, true))
			p_CoAFile = MSysConfig.getValue(MSysConfig.DEFAULT_COA_PATH,
					Adempiere.getAdempiereHome() + File.separator + "data"
							+ File.separator + "import"
							+ File.separator + "AccountingDefaultsOnly.csv");
		File coaFile = new File(p_CoAFile);
		if (!coaFile.exists())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "CoaFile") + " " + p_CoAFile + " " + Msg.getMsg(Env.getCtx(), "does not exist") );
		if (!coaFile.canRead())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "Cannot read CoaFile") + " " + p_CoAFile);
		if (!coaFile.isFile())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "CoaFile") + " " + p_CoAFile + " " + Msg.getMsg(Env.getCtx(), "is not a file"));
		if (coaFile.length() <= 0L)
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "CoaFile") +  " " + p_CoAFile + " " + Msg.getMsg(Env.getCtx(), "is empty"));

		// Process
		MSetup ms = new MSetup(Env.getCtx(), WINDOW_THIS_PROCESS, isDryRun);
		try {
			if (! ms.createClient(p_ClientName, p_OrgValue, p_OrgName, p_AdminUserName, p_NormalUserName
					, p_Phone, p_Phone2, p_Fax, p_EMail, p_TaxID, p_AdminUserEmail, p_NormalUserEmail, p_IsSetInitialPassword)) {
				ms.rollback();
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "Create client failed"));
			}
				
			addLog(ms.getInfo());

			//  Generate Accounting
			MCurrency currency = MCurrency.get(getCtx(), p_C_Currency_ID);
			KeyNamePair currency_kp = new KeyNamePair(p_C_Currency_ID, currency.getDescription());
			if (!ms.createAccounting(currency_kp,
				p_IsUseProductDimension, p_IsUseBPDimension, p_IsUseProjectDimension, p_IsUseCampaignDimension, p_IsUseSalesRegionDimension, p_IsUseActivityDimension,
				coaFile, p_UseDefaultCoA, p_InactivateDefaults)) {
				ms.rollback();
				throw new AdempiereException("@" + Msg.getMsg(Env.getCtx(), "AccountSetupError")+ "@");
			}

			//  Generate Entities
			if (!ms.createEntities(p_C_Country_ID, p_CityName, p_C_Region_ID, p_C_Currency_ID, p_Postal, p_Address1)) {
				ms.rollback();
				throw new AdempiereException("@" +  Msg.getMsg(Env.getCtx(), "AccountSetupError") + "@");
			}
			addLog(ms.getInfo());

			//	Create Print Documents
			PrintUtil.setupPrintForm(ms.getAD_Client_ID(), isDryRun ? ms.getTrxName() : null);
			if (isDryRun)
				ms.rollback();
		} catch (Exception e) {
			ms.rollback();
			throw e;
		}

		return "@OK@";
	}

}
