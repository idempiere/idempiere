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
 * - Nicolas Micoud (TGI)		                                       *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * SMTP servers
 */
public class MSMTP extends X_AD_SMTP {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3645639750095013941L;

	/**
	 * SMTP constructor
	 * @param ctx			context
	 * @param X_AD_SMTP_ID	ID
	 * @param trxName		transaction
	 */
	public MSMTP(Properties ctx, int X_AD_SMTP_ID, String trxName) {
		super(ctx, X_AD_SMTP_ID, trxName);
	} // MSMTP

	/**
	 * SMTP constructor
	 *
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MSMTP(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MSMTP
	
	/** Search a SMTP server for the sender (1st try with the full address, 2nd try with domain only) */
	public static int getSmtpID(int clientID, String from, String trxName) {
		
		System.out.println("getSmtpID : clientID=" + clientID + " / from=" + from);
		
		String sql = "SELECT AD_SMTP_ID FROM AD_SMTP WHERE AD_Client_ID IN (0, ?) AND IsActive = 'Y' AND UPPER(UsedByEmailOrDomain) LIKE ? ORDER BY AD_Client_ID DESC, AD_SMTP_ID";
		
		int smtpID = DB.getSQLValueEx(trxName, sql, clientID, "%" + from.toUpperCase() + "%");

		if (smtpID <= 0)
			DB.getSQLValueEx(trxName, sql, clientID, "%" + from.substring(from.indexOf("@")).toUpperCase() + "%");

		System.out.println("getSmtpID : " + new MSMTP(Env.getCtx(), smtpID, trxName).toString());
		
		return smtpID;
	}
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString() {
		return new StringBuilder ("MSMTP[").append(get_ID()).append(" - Name=").append(getName()).append(" - Host=").append(getSMTPHost()).append("]").toString();
	}	//	toString
	
} // MSMTP
