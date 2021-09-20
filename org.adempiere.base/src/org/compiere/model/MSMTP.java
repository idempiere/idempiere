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

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * SMTP servers
 */
public class MSMTP extends X_AD_SMTP implements ImmutablePOSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3645639750095013941L;

	/**	Cache */
	private static ImmutablePOCache<String,MSMTP>	s_cache = new ImmutablePOCache<String,MSMTP>(Table_Name, 20);

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
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MSMTP(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MSMTP

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MSMTP(Properties ctx, MSMTP copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MSMTP(Properties ctx, MSMTP copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	/** Search a SMTP server for the sender (1st try with the full address, 2nd try with domain only) */
	public static MSMTP get (Properties ctx, int clientID, String from) {
		return get(ctx, clientID, from, null);
	}

	/** Search a SMTP server for the sender (1st try with the full address, 2nd try with domain only) */
	public static MSMTP get (Properties ctx, int clientID, String from, String trxName) {

		String key = new StringBuilder().append(clientID).append("_").append(from).toString();

		MSMTP retValue = null;
		if (s_cache.containsKey(key) ) {
			retValue = s_cache.get(ctx, key, e -> new MSMTP(ctx, e));
			return retValue;
		}

		Query query = new Query(ctx, MSMTP.Table_Name, "AD_Client_ID IN (0, ?) AND UPPER(UsedByEmailOrDomain) = UPPER(?)", trxName)
				.setOnlyActiveRecords(true)
				.setOrderBy("AD_Client_ID DESC, AD_SMTP_ID");
		retValue = query.setParameters(clientID, from).first();

		if (retValue == null) {
			String domain = from.substring(from.indexOf("@") + 1);
			retValue = query.setParameters(clientID, domain).first();
		}

		if (retValue == null) {
			s_cache.put (key, null);
		} else {
			final MSMTP smtp = retValue;
			s_cache.put (key, retValue, e -> new MSMTP(Env.getCtx(), smtp));
		}

		return retValue;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString() {
		return new StringBuilder ("MSMTP[").append(get_ID()).append(" - Name=").append(getName()).append(" - Host=").append(getSMTPHost()).append("]").toString();
	}	//	toString

	@Override
	public MSMTP markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

} // MSMTP
