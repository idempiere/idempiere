/******************************************************************************
 * Copyright (C) 2017 Diego Ruiz                                              *
 * Copyright (C) 2017 Trek Global                 							  *
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
package org.adempiere.plugin.utils;

import java.io.File;
import java.util.logging.Level;

import org.adempiere.base.IDictionaryService;
import org.compiere.model.MSysConfig;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.util.tracker.ServiceTracker;
import org.osgi.util.tracker.ServiceTrackerCustomizer;

public abstract class AbstractActivator implements BundleActivator, ServiceTrackerCustomizer<IDictionaryService, IDictionaryService> {

	protected final static CLogger logger = CLogger.getCLogger(AbstractActivator.class.getName());
	protected BundleContext context;
	protected ServiceTracker<IDictionaryService, IDictionaryService> serviceTracker;
	protected IDictionaryService service;
	private   String trxName = "";

	protected boolean merge(File zipfile, String version) throws Exception {
		boolean success = false;

		if (!installedPackage(version)) {
			service.merge(context, zipfile);
			success = true;
		} else {
			logger.log(Level.SEVERE, "The file was already installed: " + zipfile.getName());
		}

		return success;
	}

	protected boolean installedPackage(String version) {
		StringBuilder where = new StringBuilder("Name=? AND PK_Status = 'Completed successfully'");
		Object[] params;
		if (version != null) {
			where.append(" AND PK_Version LIKE ?");
			params = new Object[] { getName(), version +  "%" };
		} else {
			params = new Object[] {getName()};
		}
		Query q = new Query(Env.getCtx(), X_AD_Package_Imp.Table_Name,
				where.toString(), null);
		q.setParameters(params);
		return q.match();
	}

	public abstract String getName();

	public boolean getDBLock() throws AdempiereSystemError {
		int timeout = MSysConfig.getIntValue(MSysConfig.AUTOMATIC_PACKIN_TIMEOUT, 120);
		int maxAttempts = MSysConfig.getIntValue(MSysConfig.AUTOMATIC_PACKIN_RETRIES, 5);
		boolean lockAcquired = false;

		while(maxAttempts > 0 && !lockAcquired) {
			maxAttempts --;
			if (getDBLock(timeout))
				lockAcquired = true;
		}

		return lockAcquired;
	}

	public void releaseLock() {
		Trx.get(trxName, false).close();
	}

	private boolean getDBLock(int timeout) throws AdempiereSystemError {
		return DB.getDatabase().forUpdate(getLockPO(), timeout);
	}

	private PO getLockPO() throws AdempiereSystemError {
		MSysConfig sysconfig = new Query(Env.getCtx(), MSysConfig.Table_Name, 
				"Name=? AND AD_Client_ID=0", null)
				.setParameters(MSysConfig.AUTOMATIC_PACKIN_PROCESSING)
				.firstOnly();
		if (sysconfig == null) {
			 throw new AdempiereSystemError(MSysConfig.AUTOMATIC_PACKIN_PROCESSING + " SysConfig does not exist");
		}
		
		trxName = Trx.createTrxName("ActSysTrx");
		Trx.get(trxName, true).setDisplayName(getClass().getName()+"_getLockPO");
		sysconfig.set_TrxName(trxName);
		return sysconfig;
	}
}
