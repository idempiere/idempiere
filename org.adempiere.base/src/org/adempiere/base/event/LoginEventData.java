/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.base.event;

/**
 *
 * @author hengsin
 *
 */
public class LoginEventData {
	private int AD_Client_ID;
	private int AD_Org_ID;
	private int AD_Role_ID;
	private int AD_User_ID;

	/**
	 * @param aD_Client_ID
	 * @param aD_Org_ID
	 * @param aD_Role_ID
	 * @param aD_User_ID
	 */
	public LoginEventData(int aD_Client_ID, int aD_Org_ID, int aD_Role_ID,
			int aD_User_ID) {
		super();
		AD_Client_ID = aD_Client_ID;
		AD_Org_ID = aD_Org_ID;
		AD_Role_ID = aD_Role_ID;
		AD_User_ID = aD_User_ID;
	}

	/**
	 * @return the aD_Client_ID
	 */
	public int getAD_Client_ID() {
		return AD_Client_ID;
	}

	/**
	 * @return the aD_Org_ID
	 */
	public int getAD_Org_ID() {
		return AD_Org_ID;
	}

	/**
	 * @return the aD_Role_ID
	 */
	public int getAD_Role_ID() {
		return AD_Role_ID;
	}

	/**
	 * @return the aD_User_ID
	 */
	public int getAD_User_ID() {
		return AD_User_ID;
	}

}
