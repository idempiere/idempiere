/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz                                           *
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
***********************************************************************/

package org.idempiere.fitnesse.fixture;

import org.compiere.model.MSession;
import org.compiere.model.MUser;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

import fitnesse.fixtures.TableFixture;

/**
 *	iDempiere Login fixture for use with fitnesse framework testing
 *
 *  @author Carlos Ruiz - globalqss
 */
public class Login extends TableFixture {
	private static final String LANGUAGE_EN_US = "en_US";
	private volatile static Instance adempiereInstance = null;
	private String m_user;
	private String m_password;
	private String m_language;
	private int m_client_id = -1;
	private int m_org_id = 0;
	private int m_role_id = -1;
	private int m_warehouse_id = 0;
	
	@Override
	protected void doStaticTable(int rows) {
		if (adempiereInstance == null) {
			adempiereInstance = Static_iDempiereInstance.getInstance();
		}
		boolean isErrorExpected = "*Login*Error*".equalsIgnoreCase(getText(rows-1, 0));
		String msgerror = getText(rows-1, 1);
		for (int i = 0; i < rows; i++) {
			String cell_title = getText(i, 0);
			String cell_value = getText(i, 1);
			String value_evaluated = Util.evaluate(null, 0, cell_value, getCell(i, 1));
			if (cell_title.equalsIgnoreCase("User")) {
				m_user = value_evaluated;
			} else if (cell_title.equalsIgnoreCase("Password")) {
				m_password = value_evaluated;
			} else if (cell_title.equalsIgnoreCase("Language")) {
				m_language = value_evaluated;
			} else if (cell_title.equalsIgnoreCase("AD_Role_ID")) {
				try {
					m_role_id = Integer.parseInt(value_evaluated);
				} catch (NumberFormatException e) {
					exception(getCell(i, 1), e);
					continue;
				}
			} else if (cell_title.equalsIgnoreCase("AD_Client_ID")) {
				try {
					m_client_id = Integer.parseInt(value_evaluated);
				} catch (NumberFormatException e) {
					exception(getCell(i, 1), e);
					continue;
				}
			} else if (cell_title.equalsIgnoreCase("AD_Org_ID")) {
				try {
					m_org_id = Integer.parseInt(value_evaluated);
				} catch (NumberFormatException e) {
					exception(getCell(i, 1), e);
					continue;
				}
			} else if (cell_title.equalsIgnoreCase("M_Warehouse_ID")) {
				try {
					m_warehouse_id = Integer.parseInt(value_evaluated);
				} catch (NumberFormatException e) {
					exception(getCell(i, 1), e);
					continue;
				}
			} else if (cell_title.equalsIgnoreCase("*Login*") || cell_title.equalsIgnoreCase("*Login*Error*")) {
				if (i != rows-1) {
					exception(getCell(i, 1), new Exception("*Login* must be called in last row"));
					return;
				}

				if (m_language == null || m_language.length() == 0)
					m_language = LANGUAGE_EN_US;
				if (   m_user == null || m_user.length() == 0
					|| m_password == null || m_password.length() == 0
					|| m_role_id < 0
					|| m_client_id < 0) {

					boolean ok = Util.evaluateError("Incomplete data to login, needed User|Password|AD_Role_ID|AD_Client_ID", msgerror, isErrorExpected);
					if (ok)
						right(i,1);
					else
					    exception(getCell(rows-1, 1), new Exception("Incomplete data to login, needed User|Password|AD_Role_ID|AD_Client_ID"));
				}
				else {
					String msg = modelLogin();
					if (msg == null || msg.length() == 0) {
						MSession.get (Env.getCtx(), true);//	Start Session
						if (isErrorExpected) {
							wrong(rows-1, 0);
							wrong(rows-1, 1);
						} else {
						   right(rows-1, 0);
						   right(rows-1, 1);
						}
					} else {

						boolean ok = Util.evaluateError(msg, msgerror, isErrorExpected);
						if (ok) {
							right(rows-1, 0);
						} else {
							wrong(rows-1, 0);
							exception(getCell(rows-1, 1), new Exception(msg));
						}
						
					}
				}
				
			} else {
				wrong(i, 0);
			}
		}
	} // doStaticTable

	/* Brought and then changed from 3E_WebServices */
	private String modelLogin() {
		
		Service m_ads = adempiereInstance.getAdempiereService();
		
    	// TODO: Share login between different sessions
		if (   m_ads != null
			&& m_ads.isLoggedIn()
			&& m_ads.getM_AD_Client_ID() == m_client_id
			&& m_ads.getM_AD_Org_ID() == m_org_id
			&& m_ads.getAD_Role_ID() == m_role_id
			&& m_ads.getM_Warehouse_ID() == m_warehouse_id
			&& m_ads.getUser().equals(m_user)
			)
			return null; // already logged with same data
		
		org.compiere.util.Login login = new org.compiere.util.Login(m_ads!=null ? m_ads.getCtx() : null);
		
		KeyNamePair[] clients = login.getClients(m_user, m_password);
		boolean okclient = false;
		KeyNamePair selectedClient = null;
		for (KeyNamePair client : clients) {
			if (client.getKey() == m_client_id) {
				okclient = true;
				selectedClient = client;
				break;
			}
		}
		if (!okclient)
			return "Error logging in - client not allowed for this user";

       	Env.setContext(m_ads.getCtx(), "#AD_Client_ID", (String) selectedClient.getID());
    	MUser user = MUser.get (m_ads.getCtx(), m_user);
    	if (user != null) {
    		Env.setContext(m_ads.getCtx(), "#AD_User_ID", user.getAD_User_ID() );
    		Env.setContext(m_ads.getCtx(), "#AD_User_Name", user.getName() );
    		Env.setContext(m_ads.getCtx(), "#SalesRep_ID", user.getAD_User_ID() );
    	}
		
		KeyNamePair[] roles = login.getRoles(m_user, selectedClient);
		if (roles != null)
		{
			boolean okrole = false;
			for (KeyNamePair role : roles) {
				if (role.getKey() == m_role_id) {
					okrole = true;
					break;
				}
			}
			if (!okrole)
				return "Error logging in - role not allowed for this user";

			KeyNamePair[] orgs  = login.getOrgs( new KeyNamePair(m_role_id, "" ));

			if (orgs == null)
				return "Error logging in - no organizations for this role";

			KeyNamePair orglogin = null;
			boolean okorg = false;
			for (KeyNamePair org : orgs) {
				if (org.getKey() == m_org_id) {
					okorg = true;
					orglogin = org;
					break;
				}
			}
			if (!okorg)
				return "Error logging in - org not allowed for this role";

			KeyNamePair[] warehouses = login.getWarehouses( new KeyNamePair(m_org_id, "" ) );
			boolean okwh = false;
			if (warehouses == null || warehouses.length == 0) {
				if (m_org_id == 0 && m_warehouse_id == 0)
					okwh = true;
			} else {
				for (KeyNamePair warehouse : warehouses) {
					if (warehouse.getKey() == m_warehouse_id) {
						okwh = true;
						break;
					}
				}
			}
			if (!okwh)
				return "Error logging in - warehouse not allowed for this org";
			
			String error = login.validateLogin(orglogin);
			if (error != null && error.length() > 0)
				return error;

			int m_user_id = Env.getAD_User_ID(m_ads.getCtx());
			
			if ( !m_ads.login( m_user_id, m_role_id, m_client_id, m_org_id, m_warehouse_id, m_language) )
				return "Error logging in";
		}
		else
		{
			return "Error logging in - no roles or user/pwd invalid for user " + m_user;
		}
		
		@SuppressWarnings("unused")
		int windowNo = adempiereInstance.getAdempiereService().nextWindowNo();
		
		return null;
	} // modelLogin
	
} // doStaticTable
