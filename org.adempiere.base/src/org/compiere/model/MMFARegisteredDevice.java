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
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * Multi-factor Authentication Registered Device
 */
public class MMFARegisteredDevice extends X_MFA_RegisteredDevice {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7913538709234444407L;

	/**
	 * Read/Create empty MFA Registered Device
	 *
	 * @param ctx              context
	 * @param MFA_RegisteredDevice_ID ID
	 * @param trxName          transaction
	 */
	public MMFARegisteredDevice(Properties ctx, int MFA_RegisteredDevice_ID, String trxName) {
		super(ctx, MFA_RegisteredDevice_ID, trxName);
	} // MMFARegisteredDevice

	/**
	 * Read MFA Registered Device from current row in ResultSet
	 *
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MMFARegisteredDevice(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MMFARegisteredDevice

	/**
	 * Validate if there is a non-expired device registered with that code
	 * @param registerCookie
	 * @return true if device is valid
	 */
	public static boolean isValid(String identifier) {
		final String where = "AD_User_ID=? AND MFADeviceIdentifier=? AND Expiration>SYSDATE";
		MMFARegisteredDevice rd = new Query(Env.getCtx(), Table_Name, where, null)
				.setParameters(Env.getAD_User_ID(Env.getCtx()), identifier)
				.setClient_ID()
				.setOnlyActiveRecords(true)
				.first();
		return (rd != null);
	}

	/**
	 * 	Set User/Contact.
     * @param AD_User_ID
     * User within the system - Internal or Business Partner Contact
     * Overridden to allow saving System record (zero ID)
	 */
	@Override
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID == 0) 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, AD_User_ID);
		else 
			super.setAD_User_ID(AD_User_ID);
	} //setAD_User_ID

} // MMFARegisteredDevice
