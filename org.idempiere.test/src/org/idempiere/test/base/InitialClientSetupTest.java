/***********************************************************************
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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.sql.Timestamp;

import org.compiere.Adempiere;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Language;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;

/**
 * @author hengsin
 *
 */
public class InitialClientSetupTest extends AbstractTestCase {

	/**
	 * 
	 */
	public InitialClientSetupTest() {
	}

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		//System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, 
				new Timestamp(System.currentTimeMillis()), Language.getLanguage("en_US"));
	}
	
	@Test
	public void testSetup() {
		int AD_Process_ID = 53161;
		MProcess process = MProcess.get(AD_Process_ID);
		
		MPInstance pinstance = new MPInstance(process, 0);
		MPInstancePara[] paras = pinstance.getParameters();
		for (MPInstancePara para : paras) {
			if (para.getParameterName().equals("ClientName")) {
				para.setP_String("JUnit_InitialClientSetupTest");
				para.saveEx();
			} else if (para.getParameterName().equals("OrgValue")) {
				para.setP_String("OrgValue");
				para.saveEx();
			} else if (para.getParameterName().equals("OrgName")) {
				para.setP_String("OrgName");
				para.saveEx();
			} else if (para.getParameterName().equals("AdminUserName")) {
				para.setP_String("AdminUserName");
				para.saveEx();
			} else if (para.getParameterName().equals("NormalUserName")) {
				para.setP_String("NormalUserName");
				para.saveEx();
			} else if (para.getParameterName().equals("C_Currency_ID")) {
				para.setP_Number(100);
				para.saveEx();
			} else if (para.getParameterName().equals("C_Country_ID")) {
				para.setP_Number(100);
				para.saveEx();
			} else if (para.getParameterName().equals("CoAFile")) {
				para.setP_String(Adempiere.getAdempiereHome() + File.separator 
						+ "org.adempiere.server-feature" + File.separator
						+ "data" + File.separator + "import"
						+ File.separator + "AccountingDefaultsOnly.csv");
				para.saveEx();
			} else if (para.getParameterName().equals("AdminUserEmail")) {
				para.setP_String("admin@junit-test-idempiere.org");
				para.saveEx();
			} else if (para.getParameterName().equals("NormalUserEmail")) {
				para.setP_String("user@junit-test-idempiere.org");
				para.saveEx();
			}
		}
		
		ProcessInfo pi = new ProcessInfo(process.getName(), AD_Process_ID);
		pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		process.processIt(pi, Trx.get(getTrxName(), false), false);
		
		assertTrue(!pi.isError(), pi.getSummary());
		
		rollback();
	}
}
