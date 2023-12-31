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
 * - Elaine Tan - etantg       								   		   *
 **********************************************************************/
package org.compiere.db.partition;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_TablePartition;
import org.compiere.process.ProcessInfo;

/**
 * Interface to support partition table
 */
public interface ITablePartitionService {
	/**
	 * Is table already a partitioned table in DB
	 * @param table
	 * @param trxName
	 * @return true if table have been partition in DB
	 */
	public boolean isPartitionedTable(MTable table, String trxName);
	
	/**
	 * Make existing table a partition table
	 * @param table
	 * @param trxName
	 * @param processInfo
	 * @return true if success
	 */
	public boolean createPartitionedTable(MTable table, String trxName, ProcessInfo processInfo);
	
	/**
	 * Add new partition for new data and migrate data to new partition (if needed by DB)
	 * @param table
	 * @param trxName
	 * @param processInfo
	 * @return true if success
	 */
	public boolean addPartitionAndMigrateData(MTable table, String trxName, ProcessInfo processInfo);
	
	/**
	 * Run post partition process (if needed)
	 * @param table
	 * @param trxName
	 * @param processInfo
	 * @return true if success
	 */
	public boolean runPostPartitionProcess(MTable table, String trxName, ProcessInfo processInfo);
	
	/**
	 * Validate partition configuration for table object
	 * @param table
	 * @return String error-code - null if not error
	 */
	public String isValidConfiguration(MTable table);
	
	/**
	 * Validate partition configuration for column object
	 * @param column
	 * @return String error-code - null if not error
	 */
	public String isValidConfiguration(MColumn column);
	
	/**
	 * Detach an attached table partition
	 * @param table
	 * @param partition
	 * @param trxName
	 * @param processInfo
	 */
	public void detachPartition(MTable table, X_AD_TablePartition partition, String trxName, ProcessInfo processInfo);
	
	/**
	 * Re-attach a detached table partition
	 * @param table
	 * @param partition
	 * @param trxName
	 * @param processInfo
	 */
	public void reattachPartition(MTable table, X_AD_TablePartition partition, String trxName, ProcessInfo processInfo);
}
