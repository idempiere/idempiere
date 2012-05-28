
/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com
 * Contributor(s): Carlos Ruiz - globalqss
 *****************************************************************************/
package org.adempiere.pipo2;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Imp_Backup;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Reverse Package Install.
 *
 * @author Robert Klein
 *
 */
public class PackRollProcess extends SvrProcess {
	/** Package from Record */
	private int m_AD_Package_Imp_ID = 0;
	StringBuffer sql = null;
	StringBuffer sqlB = null;
	String columnIDName = null;
	StringBuffer sqlC = null;
	StringBuffer sqlD = null;

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		m_AD_Package_Imp_ID = getRecord_ID();
	} // prepare

	/**
	 * Perform process.
	 *
	 * @return Message (translated text)
	 * @throws Exception
	 *             if not successful
	 */
	protected String doIt() throws Exception
	{

		DB.executeUpdateEx("UPDATE AD_Package_Imp SET PK_Status = 'Uninstalling' WHERE AD_Package_Imp_ID = ?", new Object[]{m_AD_Package_Imp_ID}, get_TrxName());

		log.info("Starting Package Reversal");
		// select all records that are new or have been updated by package
		// install
		try {
			Query query = new Query(getCtx(), X_AD_Package_Imp_Detail.Table_Name, "AD_Package_Imp_ID=?", get_TrxName());
			List<X_AD_Package_Imp_Detail> packageImpDetails = query.setParameters(new Object[]{m_AD_Package_Imp_ID}).list();
			for (X_AD_Package_Imp_Detail packageImpDetail : packageImpDetails) {

				if (packageImpDetail.getType().equals("file")) {

					Query query2 = new Query(getCtx(), X_AD_Package_Imp_Backup.Table_Name, "AD_Package_Imp_Detail_ID=? AND AD_Package_Imp_ID=?", get_TrxName());
					List<X_AD_Package_Imp_Backup> backups = query2.setParameters(new Object[]{packageImpDetail.getAD_Package_Imp_Detail_ID(), packageImpDetail.getAD_Package_Imp_ID()}).list();

					for (X_AD_Package_Imp_Backup backup : backups) {
						if (backup.getAD_Package_Imp_Bck_Dir() != null
								&& backup.getAD_Package_Imp_Org_Dir() != null) {
							copyFile(backup.getAD_Package_Imp_Bck_Dir(),backup.getAD_Package_Imp_Org_Dir());
						}

						// Update uninstall field for column
						backup.setUninstall(true);
						backup.saveEx();

						// Update uninstall field for record
						packageImpDetail.setUninstall(true);
						packageImpDetail.saveEx();
					}

				} else {

					String tableName = packageImpDetail.getTableName();

					int recordID = packageImpDetail.getAD_Original_ID();

					// determine if record is an update to the original
					// if record is an update then update record with backup
					// settings
					// else inactivate record
					if (packageImpDetail.getAction().equalsIgnoreCase("update")) {
						// select all backed up columns for the record

						try {
							Query query2 = new Query(getCtx(), X_AD_Package_Imp_Backup.Table_Name, "AD_Package_Imp_Detail_ID=? AND AD_Package_Imp_ID=?", get_TrxName());
							List<X_AD_Package_Imp_Backup> backups = query2.setParameters(new Object[]{packageImpDetail.getAD_Package_Imp_Detail_ID(), packageImpDetail.getAD_Package_Imp_ID()}).list();

							String IsKey = null;
							String columnName = null;

							for (X_AD_Package_Imp_Backup backup : backups) {

								PreparedStatement pstmt =null;
								ResultSet rs=null;
								try {
									pstmt = DB.prepareStatement("SELECT IsKey,ColumnName FROM AD_Column WHERE AD_Column_ID = ?",get_TrxName());
									pstmt.setInt(1,backup.getAD_Column_ID());
									rs = pstmt.executeQuery();
									if(rs.next())
									{
										IsKey = rs.getString(1);
										columnName = rs.getString(2);
									}
								} finally {
									DB.close(rs, pstmt);
								}
								// Get Table value
								tableName = MTable.getTableName(getCtx(), backup.getAD_Table_ID());

								// Get Column Name
								// Adjust for Column reference table
								if (tableName.equals("AD_Ref_Table"))
								{
									columnIDName = "AD_Reference_ID";
								}
								else if (tableName.equals("AD_TreeNodeMM"))
								{
									columnIDName = "Node_ID";
								}
								else
								{
									columnIDName = tableName + "_ID";
								}

								// Update columns for record
								// TODO make process more efficient!

								if (IsKey.equals("Y")
										|| columnName.startsWith("Created"))
									; // ignore is a Key Column or if it
										// references a Created(By) Column
								// Update "Updated" field with current date
								else if (columnName.equals("Updated"))
								{
									// Format Date
									sqlC = new StringBuffer("UPDATE "
											+ tableName + " SET " + columnName
											+ " = SYSDATE WHERE "
											+ columnIDName + " = " + recordID);

									DB.executeUpdateEx(sqlC.toString(), get_TrxName());
									// Update uninstall field
									backup.setUninstall(true);
									backup.saveEx();
								}
								// Update "UpdatedBy" field with current user
								else if (columnName.equals("UpdatedBy")) {

									sqlC = new StringBuffer("UPDATE "
											+ tableName + " SET " + columnName
											+ " = '"
											+ Env.getAD_User_ID(Env.getCtx())
											+ "' WHERE " + columnIDName + " = "
											+ recordID);
									DB.executeUpdateEx(sqlC.toString(), get_TrxName());
									backup.setUninstall(true);
									backup.saveEx();
								}
								// Update all other fields with backup
								// information
								else {
									Object[] parameters = null;
									int v_AD_Reference_ID = backup.getAD_Reference_ID();
									// Update columns that are Strings adjusting
									// for single quotes
									if (v_AD_Reference_ID == 10
											|| v_AD_Reference_ID == 14
											|| v_AD_Reference_ID == 34
											|| v_AD_Reference_ID == 17
											// Carlos Ruiz globalqss, special
											// treatment for EntityType
											// it's a Table reference but must
											// be treated as String
											|| (v_AD_Reference_ID == 18 && columnName
													.equalsIgnoreCase("EntityType"))) {
										if (backup.getColValue().toString().equals("null")) {
											;// Ignore null values
										} else {
											sqlC = new StringBuffer("UPDATE "
													+ tableName
													+ " SET "
													+ columnName
													+ " = ?"
													+ " WHERE " + columnIDName
													+ " = " + recordID);
											parameters = new Object[]{backup.getColValue()};
										}
									// Update true/false columns
									} else if (v_AD_Reference_ID == 20
											|| v_AD_Reference_ID == 28) {

										sqlC = new StringBuffer("UPDATE "
												+ tableName
												+ " SET "
												+ columnName
												+ " = ? "
												+ " WHERE "
												+ columnIDName + " = "
												+ recordID);
										parameters = new Object[]{backup.getColValue().equals("true") ? "Y" : "N"};
									}
									// Update columns that are Strings adjusting
									// for single quotes
									else if (v_AD_Reference_ID == 13
											|| v_AD_Reference_ID == 18
											|| v_AD_Reference_ID == 19
											|| v_AD_Reference_ID == 21
											|| v_AD_Reference_ID == 25
											|| v_AD_Reference_ID == 27
											|| v_AD_Reference_ID == 30
											|| v_AD_Reference_ID == 31
											|| v_AD_Reference_ID == 35)
									{

										sqlC = new StringBuffer("UPDATE "
												+ tableName
												+ " SET "
												+ columnName
												+ " = ?"
												+ " WHERE " + columnIDName
												+ " = " + recordID);
										parameters = new Object[]{backup.getColValue()};
									}
									// Update columns that are numbers
									else if (v_AD_Reference_ID == 11
											|| v_AD_Reference_ID == 12
											|| v_AD_Reference_ID == 22
											|| v_AD_Reference_ID == 29)
									{
										sqlC = new StringBuffer("UPDATE "
												+ tableName
												+ " SET "
												+ columnName
												+ " = ?"
												+ " WHERE " + columnIDName
												+ " = " + recordID);
										parameters = new Object[]{backup.getColValue()};
									}
									// Update columns that are dates
									else if (v_AD_Reference_ID == 15
											|| v_AD_Reference_ID == 16)
									{
										Timestamp ts = null;
										try {
											ts = Timestamp.valueOf(backup.getColValue());
										} catch (Exception e) {}
										if (ts != null) 
										{
											sqlC = new StringBuffer("UPDATE "
													+ tableName
													+ " SET "
													+ columnName
													+ " = ?"
													+ " WHERE " + columnIDName
													+ " = " + recordID);
											parameters = new Object[]{ts};
										}
									}
									else
										// 23-Binary, 24-Radio, 26-RowID,
										// 32-Image not supported
										;// ignore
									// execute update

									if(sqlC!=null)
									{
										DB.executeUpdateEx(sqlC.toString(), parameters, get_TrxName());
									}

									// Update uninstall field for column
									backup.setUninstall(true);
									backup.saveEx();

									// Update uninstall field for record
									packageImpDetail.setUninstall(true);
									packageImpDetail.saveEx();
								}
							}

						} catch (Exception e) {
							log.log(Level.SEVERE, "doIt", e);
							//System.exit(0);
						}
					} // ********* Update Loop
					// Inactivate new records
					else if (packageImpDetail.getAction().equalsIgnoreCase("new")) {
						if (tableName.equals("AD_Ref_Table"))
							columnIDName = "AD_Reference_ID";
						else if (tableName.equals("AD_TreeNodeMM"))
							columnIDName = "Node_ID";
						else
							columnIDName = tableName + "_ID";
						sqlC=new StringBuffer(" UPDATE ")
						.append(tableName)
						.append(" SET IsActive = 'N' WHERE ")
						.append(columnIDName)
						.append(" = ? ");
						DB.executeUpdateEx(sqlC.toString(), new Object[]{recordID}, get_TrxName());

						// Update uninstall field for record
						packageImpDetail.setUninstall(true);
						packageImpDetail.saveEx();
					}
				}

			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "doIt", e);
		}

		// Update uninstall field for package
		DB.executeUpdateEx("UPDATE AD_Package_Imp SET Uninstall = 'Y', PK_Status = 'Uninstalled' WHERE AD_Package_Imp_ID = ?", new Object[]{m_AD_Package_Imp_ID}, get_TrxName());

		log.info("Package Reversal Completed");
		return "";
	} // doIt

	/**
	 * Open input file for processing
	 *
	 * @param String
	 *            file with path
	 *
	 */
	public FileInputStream OpenInputfile(String filePath) {

		FileInputStream fileTarget = null;

		try {
			fileTarget = new FileInputStream(filePath);
		} catch (FileNotFoundException e) {
			System.out.println("Can't find file ");

			return null;
		}
		return fileTarget;
	}

	/**
	 * Open output file for processing
	 *
	 * @param String
	 *            file with path
	 *
	 */
	public OutputStream OpenOutputfile(String filePath) {

		OutputStream fileTarget = null;

		try {
			fileTarget = new FileOutputStream(filePath);
		} catch (FileNotFoundException e) {
			System.out.println("Can't find file ");

			return null;
		}
		return fileTarget;
	}

	/**
	 * Copyfile
	 *
	 * @param String
	 *            file with path
	 *
	 */
	public int copyFile(String sourceFile, String targetFile) {

		OutputStream target = OpenOutputfile(targetFile);
		InputStream source = OpenInputfile(sourceFile);

		int byteCount = 0;
		int success = 0;
		try {
			while (true) {
				int data = source.read();
				if (data < 0)
					break;
				target.write(data);
				byteCount++;
			}
			source.close();
			target.close();

			System.out.println("Successfully copied " + byteCount + " bytes.");
		} catch (Exception e) {
			System.out.println("Error occurred while copying.  " + byteCount
					+ " bytes copied.");
			System.out.println(e.toString());

			success = -1;
		}
		return success;
	}

} // PackRoll
