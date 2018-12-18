/**********************************************************************
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
* - Trek Global                                                       *
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package org.compiere.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MSysConfig;
import org.compiere.model.MSystem;

public class DBReadReplica {

	private static String m_user = null;
	private static String m_pass = null;
	final private static String sqlValidateSync = "SELECT lastupdate FROM dbreplicasyncverifier";
	final private static String sqlUpdateSync = "UPDATE dbreplicasyncverifier SET lastupdate=SYSDATE";
	final private static String sqlValidateDBAddress = "SELECT DBAddress FROM AD_System";
	private volatile static int shift = 0; // for load balancing between different replicas

	/**	Logger							*/
	private static CLogger			log = CLogger.getCLogger (DBReadReplica.class);

	/**
	 *	Prepare Normal Read Replica Statement
	 *  @param sql sql statement
	 *  @param resultSetType - ResultSet.TYPE_FORWARD_ONLY, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.TYPE_SCROLL_SENSITIVE
	 *  @param resultSetConcurrency - ResultSet.CONCUR_READ_ONLY or ResultSet.CONCUR_UPDATABLE
	 * 	@param trxName transaction
	 *  @return Prepared Statement (from replica if possible, otherwise null)
	 *
	 *  @TODO: Add profiles fast and slow for other read replica statements
	 * 
	 */
	public static PreparedStatement prepareNormalReadReplicaStatement(String sql, int resultSetType, int resultSetConcurrency, String trxName) {
		String replicaURLsConfig = MSysConfig.getValue(MSysConfig.DB_READ_REPLICA_URLS); // list of JDBC URLs separated by |
		if (Util.isEmpty(replicaURLsConfig, true))
			return null;
		int DB_READ_REPLICA_NORMAL_TIMEOUT_IN_MILLISECONDS = MSysConfig.getIntValue(MSysConfig.DB_READ_REPLICA_NORMAL_TIMEOUT_IN_MILLISECONDS, 5000); 
		int DB_READ_REPLICA_NORMAL_MAX_ITERATIONS = MSysConfig.getIntValue(MSysConfig.DB_READ_REPLICA_NORMAL_MAX_ITERATIONS, 3);

		setUserPass();

		Timestamp lastTs = setMasterVerificationTimestamp();
		String masterDBAddress = MSystem.get(Env.getCtx()).getDBAddress();

		List<URLReplicaConnection> urlConnList = new ArrayList<URLReplicaConnection>();

		String[] replicaURLs = replicaURLsConfig.split("\\|");
		int index = 0;
		int length = replicaURLs.length;
		for (int i = 0; i < length; i++) {
			String replicaURL = replicaURLs[i].trim();
			index = (i + shift) % length;
			URLReplicaConnection urc = new URLReplicaConnection(replicaURL, index);
			urlConnList.add(urc);
		}
		shift++;
		if (shift >= length)
			shift = 0;

		// sort URLs by index - for load balancing
		Collections.sort(urlConnList);

		PreparedStatement statementToReturn = null;
		String usedReplicaURL = null;
		for (int i = 0; i < DB_READ_REPLICA_NORMAL_MAX_ITERATIONS; i++) {

			for (URLReplicaConnection urlConn : urlConnList) {

				if (! urlConn.isUsable())
					continue; // next urlConn

				String replicaURL = urlConn.getReplicaURL();

				Connection conn = urlConn.getConnection();
				if (conn == null && urlConn.isUsable()) {
					conn = tryConnect(replicaURL);
				}
				if (conn == null) {
					urlConn.setUsable(false);
					continue; // next urlConn
				}
				urlConn.setConnection(conn);

				String replicaDBAddress = getReplicaDBAddress(conn);
				if (!masterDBAddress.equals(replicaDBAddress)) {
					log.warning("Replica DB Address doesn't match with master DB Address -> " + replicaURL);
					urlConn.setUsable(false);
					continue; // next urlConn
				}

				Timestamp replicaTs = getReplicaVerificationTimestamp(conn);
				if (replicaTs == null) {
					log.warning("Could not get replica verification timestamp -> " + replicaURL);
					urlConn.setUsable(false);
					continue; // next urlConn
				}

				if (replicaTs.before(lastTs)) {
					// not usable yet
					continue; // next urlConn
				}
				try {
					sql = DB.getDatabase().convertStatement(sql);
					statementToReturn = conn.prepareStatement(sql, resultSetType, resultSetConcurrency);
					usedReplicaURL = urlConn.getReplicaURL();
				} catch (SQLException e) {
					log.warning("Error preparing statement in replica -> " + replicaURL + " / SQL = " + sql);
					statementToReturn = null;
					urlConn.setUsable(false);
				}
			} // end for urlConnList

			if (statementToReturn != null)
				break; // break iterations

			boolean noMoreUsables = true;
			for (URLReplicaConnection urlConn : urlConnList) {
				if (urlConn.isUsable()) {
					noMoreUsables = false;
					break;
				}
			}

			if (noMoreUsables)
				break;

			if (i < DB_READ_REPLICA_NORMAL_MAX_ITERATIONS-1) {
				try {
					log.warning("Waiting " + DB_READ_REPLICA_NORMAL_TIMEOUT_IN_MILLISECONDS + " milliseconds for replication to sync");
					Thread.sleep(DB_READ_REPLICA_NORMAL_TIMEOUT_IN_MILLISECONDS);
				} catch (InterruptedException e) {
					;
				}
			}
		} // end for iterations

		if (statementToReturn == null)
			log.warning("Abandoning replicas: none usable or max wait reached without sync");

		// close any connection not used in the statement to return
		for (URLReplicaConnection urlConn : urlConnList) {
			Connection conn = urlConn.getConnection();
			if (conn == null)
				continue;
			try {
				if (statementToReturn != null && conn == statementToReturn.getConnection())
					continue; // next connection
			} catch (SQLException e) {
				log.warning("Error getting connection from statement on replica, URL = " + urlConn.getReplicaURL() + ", cause = " + e.getLocalizedMessage());
			}
			try {
				conn.close();
			} catch (SQLException e) {
				log.warning("Could not close connection statement on replica, URL = " + urlConn.getReplicaURL() + ", cause = " + e.getLocalizedMessage());
			}
		}

		if (statementToReturn != null)
			log.warning("Using replica for statement, URL = " + usedReplicaURL + " / SQL = " + sql); // WARNING during test phase, change to info before moving to production
		return statementToReturn;
	}

	private static Timestamp getReplicaVerificationTimestamp(Connection conn) {
		PreparedStatement stVerifySync = null;
		ResultSet rsVerifySync = null;
		Timestamp replicaTs = null;
		try {
			stVerifySync = conn.prepareStatement(sqlValidateSync);
			rsVerifySync = stVerifySync.executeQuery();
			if (rsVerifySync.next())
				replicaTs = rsVerifySync.getTimestamp("lastupdate");
		} catch (SQLException e) {
			replicaTs = null;
		} finally {
			DB.close(rsVerifySync, stVerifySync);
		}
		return replicaTs;
	}

	private static String getReplicaDBAddress(Connection conn) {
		PreparedStatement stVerifyAddr = null;
		ResultSet rsVerifyAddr = null;
		String dbAddr = null;
		try {
			stVerifyAddr = conn.prepareStatement(sqlValidateDBAddress);
			rsVerifyAddr = stVerifyAddr.executeQuery();
			if (rsVerifyAddr.next())
				dbAddr = rsVerifyAddr.getString("DBAddress");
		} catch (SQLException e) {
			dbAddr = null;
		} finally {
			DB.close(rsVerifyAddr, stVerifyAddr);
		}
		return dbAddr;
	}

	private static Connection tryConnect(String replicaURL) {
		// open connection to replica
		Connection conn = null;
		try {
			conn = DB.getDatabase(replicaURL).getDriverConnection(replicaURL, m_user, m_pass);
		} catch (SQLException e) {
			log.warning("Could not get a connection to " + replicaURL + ", cause = " + e.getLocalizedMessage());
			conn = null;
		}
		return conn;
	}

	private static Timestamp setMasterVerificationTimestamp() {
		// update time in master database to verify synchronization of replicas
		Timestamp lastTs = null;
		try {
			DB.executeUpdateEx(sqlUpdateSync, null);
			lastTs = DB.getSQLValueTSEx(null, sqlValidateSync);
		} catch (DBException e1) {
			log.warning("Could not sync dbreplicasyncverifier, cause = " + e1.getLocalizedMessage());
			lastTs = null;
		}
		return lastTs;
	}

	public static void closeReadReplicaStatement(Statement st) {
		// close the connection associated to the statement
		try {
			st.getConnection().close();
		} catch (SQLException e) {
			log.warning("Error closing the read replica statement, cause = " + e.getLocalizedMessage());
		}
	}

	/**
	 *  Set Attributes from String (pares toStringLong())
	 *  @param attributes attributes
	 */
	private static void setUserPass() {
		if (m_user != null || m_pass != null)
			return;
		String attributes = Ini.getProperty (Ini.P_CONNECTION);
		try {
			attributes = attributes.substring(attributes.indexOf("[")+1, attributes.length() - 1);
			String[] pairs= attributes.split("[,]");
			for(String pair : pairs)
			{
				String[] pairComponents = pair.split("[=]");
				String key = pairComponents[0];
				String value = pairComponents.length == 2 ? unescape(pairComponents[1]) : "";
				if ("UID".equalsIgnoreCase(key)) {
					m_user = value;
				} else if ("PWD".equalsIgnoreCase(key)) {
					m_pass = value;
				}
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, attributes + " - " + e.toString (), e);
		}
	}	//  setAttributes

	private static String unescape(String value) {
		value = value.replace("&eq;", "=");
		value = value.replace("&comma;", ",");
		return value;
	}

	/**
	 * URL connection class for DB Read Replica
	 *
	 */
	private static class URLReplicaConnection implements Comparable<URLReplicaConnection> {

		private String replicaURL;
		private int index;
		private boolean usable = true;
		private Connection conn = null;

		public URLReplicaConnection(String replicaURL, int index) {
			this.replicaURL = replicaURL;
			this.index = index;
		}

		public String getReplicaURL() {
			return replicaURL;
		}

		public boolean isUsable() {
			return usable;
		}

		public void setUsable(boolean usable) {
			this.usable = usable;
		}

		public Connection getConnection() {
			return conn;
		}

		public void setConnection(Connection conn) {
			this.conn = conn;
		}

		@Override
		public int compareTo(URLReplicaConnection o) {
			if (index > o.index)
				return 1;
			else if (index < o.index)
				return -1;
			return 0;
		}

		@Override
		public String toString() {
			return "replicaURL=" + replicaURL
					+ " index=" + index
					+ " usable=" + usable
					+ " connection=" + conn;
		}

	}

}
