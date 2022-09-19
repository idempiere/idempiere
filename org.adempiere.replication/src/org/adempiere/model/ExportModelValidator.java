/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Trifon Trifonov.                                      *
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
* - Trifon Trifonov (trifonnt@users.sourceforge.net)                  *
*                                                                     *
* Sponsors:                                                           *
* - e-Evolution (http://www.e-evolution.com)                          *
**********************************************************************/

package org.adempiere.model;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.process.rpl.exp.ExportHelper;
import org.compiere.model.MClient;
import org.compiere.model.MOrg;
import org.compiere.model.MReplicationStrategy;
import org.compiere.model.MTable;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_AD_ReplicationDocument;
import org.compiere.model.X_AD_ReplicationTable;
import org.compiere.util.CLogger;
import org.compiere.util.Env;


/**
 *	Export Validator which is responsible to create XML document.
 *	
 *	@author Trifon Trifonov
 *	@author victor.perez@e-evolution.com, www.e-evolution.com
 * <li> BF2875989 Deactivate replication records are include to replication
 * <li> https://sourceforge.net/p/adempiere/bugs/2167/
 * <li>[ 2195090 ] Stabilization of replication
 * <li>https://sourceforge.net/p/adempiere/bugs/2294/
 * <li> BF2947615 The document recplicacion not working
 * <li> https://sourceforge.net/p/adempiere/bugs/2307/
 * <li> The Replication should can use the Strategy from the org
 * <li> https://sourceforge.net/p/adempiere/feature-requests/979/
 *
 *	@version $Id$
 */
public class ExportModelValidator implements ModelValidator {
	/** Context variable which says if replication is enabled */
	public static final String CTX_IsReplicationEnabled = "#IsReplicationEnabled";

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(ExportModelValidator.class);

	/** Client			*/
	private int		m_AD_Client_ID = -1;

	/** ModelValidationEngine engine **/
	List<String> modelTables = new ArrayList<String>();
	List<String> docTables = new ArrayList<String>();

	/* The Export Helpers per each replication strategy */
	Hashtable<Integer, ExportHelper> helpers = new Hashtable<Integer, ExportHelper>();

	/**
	 *	Constructor.
	 *	The class is instantiated when logging in and client is selected/known
	 */
	public ExportModelValidator () {
		super ();
	}

	/**
	 *	Initialize Validation
	 *	@param engine validation engine
	 *	@param client client
	 */
	public void initialize (ModelValidationEngine engine, MClient client) {
		if (client != null) {
			m_AD_Client_ID = client.getAD_Client_ID();
			if (log.isLoggable(Level.INFO)) log.info(client.toString());
			loadReplicationStrategy(engine);
		} else {
			log.warning("Export Model Validator cannot be used as a global validator, it needs to be defined in a per-tenant basis");
			return;
		}
	}

	public void loadReplicationStrategy(ModelValidationEngine engine) {
		MClient client = MClient.get(Env.getCtx(), m_AD_Client_ID);
		String where = "AD_ReplicationStrategy_ID IN (" +
				"SELECT AD_ReplicationStrategy_ID FROM AD_Client WHERE AD_Client_ID=? " +
				"UNION " +
				"SELECT AD_ReplicationStrategy_ID FROM AD_Org WHERE AD_Client_ID=?)";
		List<MReplicationStrategy> rss = new Query(Env.getCtx(), MReplicationStrategy.Table_Name, where, null)
			.setOnlyActiveRecords(true)
			.setParameters(m_AD_Client_ID, m_AD_Client_ID)
			.list();
		for (MReplicationStrategy rplStrategy : rss) {
			ExportHelper expClientHelper = new ExportHelper(client, rplStrategy);
			helpers.put(rplStrategy.getAD_ReplicationStrategy_ID(), expClientHelper);
			// Add Tables
			// We want to be informed when records in Replication tables are created/updated/deleted!
			for (X_AD_ReplicationTable rplTable : rplStrategy.getReplicationTables()) {
				if (   X_AD_ReplicationTable.REPLICATIONTYPE_Merge.equals(rplTable.getReplicationType())
					|| X_AD_ReplicationTable.REPLICATIONTYPE_Broadcast.equals(rplTable.getReplicationType())
					|| X_AD_ReplicationTable.REPLICATIONTYPE_Reference.equals(rplTable.getReplicationType()))
				{
					String tableName = MTable.getTableName(client.getCtx(), rplTable.getAD_Table_ID());
					if (! modelTables.contains(tableName)) {
						engine.addModelChange(tableName, this);
						modelTables.add(tableName);
					}
				}
			}
			// Add Documents
			// We want to be informed when Replication documents are created/updated/deleted!
			for (X_AD_ReplicationDocument rplDocument : rplStrategy.getReplicationDocuments()) {
				if (   X_AD_ReplicationDocument.REPLICATIONTYPE_Merge.equals(rplDocument.getReplicationType())
					|| X_AD_ReplicationDocument.REPLICATIONTYPE_Reference.equals(rplDocument.getReplicationType()))
				{
					String tableName = MTable.getTableName(client.getCtx(), rplDocument.getAD_Table_ID());
					if (! docTables.contains(tableName)) {
						engine.addDocValidate(tableName, this);
						docTables.add(tableName);
					}
				}
			}
		}
	}

	/**
	 *	Model Change of a monitored Table.
	 *	Called after PO.beforeSave/PO.beforeDelete
	 *	@param po persistent object
	 *	@param type TYPE_
	 *	@return error message or null
	 *	@exception Exception if the recipient wishes the change to be not accept.
	 */
	public String modelChange (PO po, int type) throws Exception {
		if (log.isLoggable(Level.INFO)) log.info("po.get_TableName() = " + po.get_TableName());
		int rsID = getReplicationStrategy(po);
		if (rsID > 0) {
			ExportHelper expHelper = helpers.get(rsID);
			if (expHelper != null) {
				if (   type == TYPE_AFTER_CHANGE
						|| type == TYPE_AFTER_NEW
						|| type == TYPE_BEFORE_DELETE) {
					X_AD_ReplicationTable replicationTable = MReplicationStrategy.getReplicationTable(
							po.getCtx(), rsID, po.get_Table_ID());
					if (replicationTable != null) {
						expHelper.exportRecord(
								po,
								MReplicationStrategy.REPLICATION_TABLE,
								replicationTable.getReplicationType(),
								type);
					}
				}
			}
		}
		return null;
	}

	/**
	 *	Validate Document.
	 *	Called as first step of DocAction.prepareIt
	 *	when you called addDocValidate for the table.
	 *	@param po persistent object
	 *	@param type see TIMING_ constants
	 *	@return error message or null
	 * @throws Exception
	 */
	public String docValidate (PO po, int type) {
		if (log.isLoggable(Level.INFO)) log.info("Replicate the Document = " + po.get_TableName() + " with Type = " + type);
		String result = null;
		int rsID = getReplicationStrategy(po);
		if (rsID > 0) {
			ExportHelper expHelper = helpers.get(rsID);
			if (expHelper != null) {
				try {
					if (   type == TIMING_AFTER_COMPLETE
						|| type == TIMING_AFTER_CLOSE
						|| type == TIMING_AFTER_REVERSECORRECT
						|| type == TIMING_AFTER_VOID
						|| type == TIMING_AFTER_REACTIVATE
						//|| type == TIMING_AFTER_PREPARE
						) {
						X_AD_ReplicationDocument replicationDocument = null;
						int C_DocType_ID = po.get_ValueAsInt("C_DocType_ID");
						if (C_DocType_ID > 0) {
							replicationDocument = MReplicationStrategy.getReplicationDocument(
									po.getCtx(), rsID, po.get_Table_ID(), C_DocType_ID);
						} else {
							replicationDocument = MReplicationStrategy.getReplicationDocument(
									po.getCtx(), rsID, po.get_Table_ID());
						}

						if (replicationDocument != null) {
							expHelper.exportRecord(
									po,
									MReplicationStrategy.REPLICATION_DOCUMENT,
									replicationDocument.getReplicationType(),
									type);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
					result = e.toString();
				}
			}
		}
		return result;
	}

	private int getReplicationStrategy(PO po) {
		int rsID = -1;
		int orgID = po.getAD_Org_ID();
		if (orgID > 0) {
			rsID = MOrg.get(po.getCtx(), orgID).getAD_ReplicationStrategy_ID();
		}
		if (rsID <= 0) {
			int clientID = po.getAD_Client_ID();
			rsID =  MClient.get(Env.getCtx(), clientID).getAD_ReplicationStrategy_ID();
		}
		return rsID;
	}

	/**
	 *	User Login.
	 *	Called when preferences are set
	 *	@param AD_Org_ID org
	 *	@param AD_Role_ID role
	 *	@param AD_User_ID user
	 *	@return error message or null
	 */
	public String login (int AD_Org_ID, int AD_Role_ID, int AD_User_ID) {
		Env.setContext(Env.getCtx(), CTX_IsReplicationEnabled, true);
		return null;
	}

	/**
	 *	Get Client to be monitored
	 *	@return AD_Client_ID client
	 */
	public int getAD_Client_ID() {
		return m_AD_Client_ID;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString () {
		StringBuilder sb = new StringBuilder (ExportModelValidator.class.getName());
		return sb.toString();
	}

}
