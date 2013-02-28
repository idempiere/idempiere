/**********************************************************************
 * This file is part of Adempiere ERP Bazaar                           *
 * http://www.adempiere.org                                            *
 *                                                                     *
 * Copyright (C) Fernando Lucktemberg - fer_luck                       *
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
 * - Fernando Lucktemberg - fer_luck                                   *
 *                                                                     *
 * Sponsors:                                                           *
 * - Company (http://www.faire.com.br)                                 *
 ***********************************************************************/
package org.adempiere.process;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;

import org.compiere.process.SvrProcess;
import org.compiere.util.CLogger;
import org.compiere.util.DB;

public class ApplyMigrationScripts extends SvrProcess {

	/** Logger */
	private static CLogger log = CLogger.getCLogger(ApplyMigrationScripts.class);

	@Override
	protected String doIt() throws Exception {
		log.info("Applying migrations scripts");
		StringBuilder sql = new StringBuilder()
			.append("select ad_migrationscript_id, script, name from ad_migrationscript where isApply = 'Y' and status = 'IP' order by name, created");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql.toString(), this.get_TrxName());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				byte[] scriptArray = rs.getBytes(2);
				int seqID = rs.getInt(1);
				boolean execOk = true;
				try {
					StringBuilder tmpSql = new StringBuilder(new String(scriptArray));

					if (tmpSql.length() > 0) {
						if (log.isLoggable(Level.INFO)) log.info("Executing script " + rs.getString(3));
						execOk = executeScript(tmpSql.toString(), rs.getString(3));
						System.out.println();
					}
				} catch (SQLException e) {
					execOk = false;
					e.printStackTrace();
					StringBuilder msglog = new StringBuilder("Script: ").append(rs.getString(3)).append(" - ").append(e.getMessage());
					log.saveError("Error", msglog.toString());
					log.severe(e.getMessage());
				} finally {
					sql = new StringBuilder("UPDATE ad_migrationscript SET status = ? , isApply = 'N' WHERE ad_migrationscript_id = ? ");
					PreparedStatement pstmtu = DB.prepareStatement(sql.toString(), this.get_TrxName());
					if (execOk) {
						pstmtu.setString(1, "CO");
						pstmtu.setInt(2, seqID);
					} else {
						pstmtu.setString(1, "ER");
						pstmtu.setInt(2, seqID);
					}
					try {
						pstmtu.executeUpdate();
						if (!execOk) {
							return null;
						}
					} catch (SQLException e) {
						e.printStackTrace();
						StringBuilder msglog = new StringBuilder("Script: ").append(rs.getString(3)).append(" - ").append(e.getMessage());
						log.saveError("Error", msglog.toString());
						log.severe(e.getMessage());
					} finally {
						DB.close(pstmtu);
						pstmtu = null;
					}
				}
			}
		} catch (SQLException e) {
			throw e;
		} finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return null;
	}

	@Override
	protected void prepare() {

	}

	public boolean executeScript(String sql, String fileName) {
		BufferedReader reader = new BufferedReader(new StringReader(sql));
		StringBuilder sqlBuf = new StringBuilder();
		String line;
		boolean statementReady = false;
		boolean execOk = true;
		boolean longComment = false;
		try {
			while ((line = reader.readLine()) != null) {
				// different continuation for oracle and postgres
				line = line.trim();
				//Check if it's a comment
				if (line.startsWith("--") || line.length() == 0){
					continue;
				} else if (line.endsWith(";") && !longComment) {
					sqlBuf.append(' ');
					sqlBuf.append(line.substring(0, line.length() - 1));
					statementReady = true;
				} else if(line.startsWith("/*")){
					longComment = true;
				} else if(line.endsWith("*/")){
					longComment = false;
				} else {
					if(longComment)
						continue;
					sqlBuf.append(' ');
					sqlBuf.append(line);
					statementReady = false;
				}

				if (statementReady) {
					if (sqlBuf.length() == 0)
						continue;
					Connection conn = DB.getConnectionRW();
					conn.setAutoCommit(false);
					Statement stmt = null;
					try {
						stmt = conn.createStatement();
						stmt.execute(sqlBuf.toString());
						System.out.print(".");
					} catch (SQLException e) {
						e.printStackTrace();
						execOk = false;
						StringBuilder msglog = new StringBuilder("Script: ").append(fileName).append(" - ")
								.append(e.getMessage()).append(". The line that caused the error is the following ==> ").append(sqlBuf);
						log.saveError("Error", msglog.toString());
						log.severe(e.getMessage());
					} finally {
						DB.close(stmt);
						stmt = null;
						if(execOk)
							conn.commit();
						else
							conn.rollback();
						conn.setAutoCommit(true);
						conn.close();
						if(!execOk)
							return false;
					}
					sqlBuf.setLength(0);					
				}
			}
		} catch(SQLException e){
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return true;
	}

}
