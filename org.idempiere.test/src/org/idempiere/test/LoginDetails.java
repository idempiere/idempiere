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
package org.idempiere.test;

import java.sql.Timestamp;

import org.compiere.util.Language;

/**
 * 
 * @author hengsin
 *
 */
public class LoginDetails {
	private int clientId;
	private int organizationId;
	private int userId;
	private int roleId;
	private int warehouseId;
	private Timestamp loginDate;
	private Language loginLanguage;
	
	public LoginDetails(int clientId, int organizationId, int userId, int roleId, int warehouseId, Timestamp loginDate,
			Language loginLanguage) {
		super();
		this.clientId = clientId;
		this.organizationId = organizationId;
		this.userId = userId;
		this.roleId = roleId;
		this.warehouseId = warehouseId;
		this.loginDate = loginDate;
		this.loginLanguage = loginLanguage;
	}

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public int getOrganizationId() {
		return organizationId;
	}

	public void setOrganizationId(int organizationId) {
		this.organizationId = organizationId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public int getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(int warehouseId) {
		this.warehouseId = warehouseId;
	}

	public Timestamp getLoginDate() {
		return loginDate;
	}

	public void setLoginDate(Timestamp loginDate) {
		this.loginDate = loginDate;
	}

	public Language getLoginLanguage() {
		return loginLanguage;
	}

	public void setLoginLanguage(Language loginLanguage) {
		this.loginLanguage = loginLanguage;
	}
	
	
}
