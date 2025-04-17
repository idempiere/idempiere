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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.osgi.framework.Bundle;

/**
 * Persistence model for required plugins
 * 
 * @author Carlos Ruiz - globalqss - bxservice
 */
public class MRequiredPlugin extends X_AD_RequiredPlugin {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8909551474970259697L;

	/** Static Logger */
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MRequiredPlugin.class);

	/**
	 * UUID based Constructor
	 * 
	 * @param ctx            Context
	 * @param AD_RequiredPlugin_UU UUID key
	 * @param trxName        Transaction
	 */
	public MRequiredPlugin(Properties ctx, String AD_RequiredPlugin_UU, String trxName) {
		super(ctx, AD_RequiredPlugin_UU, trxName);
	}

	/**
	 * Load Constructor
	 * 
	 * @param ctx     context
	 * @param rs      result set
	 * @param trxName transaction
	 */
	public MRequiredPlugin(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MRequiredPlugin

	/**
	 * Get Required Plugins
	 * @return List of MRequiredPlugin
	 */
	public static List<MRequiredPlugin> get() {
		List<MRequiredPlugin> retValue = new Query(Env.getCtx(), Table_Name, null, null)
				.setOnlyActiveRecords(true)
				.list();
		return retValue;
	}

	@Override
	public String toString() {
		return getPluginName();
	}

	/**
	 * @param bundle
	 * @return
	 */
	public static String getBundleState(Bundle bundle) {
		switch (bundle.getState()) {
		case Bundle.ACTIVE:
			return "ACTIVE";
		case Bundle.INSTALLED:
			return "INSTALLED";
		case Bundle.RESOLVED:
			return "RESOLVED";
		case Bundle.STARTING:
			return "STARTING";
		case Bundle.STOPPING:
			return "STOPPING";
		case Bundle.UNINSTALLED:
			return "UNINSTALLED";
		default:
			return "UNKNOWN";

		}
	}

} // MRequiredPlugin