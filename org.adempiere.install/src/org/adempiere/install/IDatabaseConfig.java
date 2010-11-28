/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.install;

import org.compiere.install.ConfigurationData;

/**
 *
 * @author hengsin
 *
 */
public interface IDatabaseConfig {

	/**
	 * Get real database name from native connection profile name
	 * return from discoverDatabases
	 * @param nativeConnectioName
	 * @return Database name
	 */
	public String getDatabaseName(String nativeConnectioName);

	/**
	 * Init Configuration Data
	 * @param configurationData
	 */
	public void init(ConfigurationData configurationData);

	/**
	 * 	Discover Databases.
	 * 	To be overwritten by database configs
	 *	@param selected selected database
	 *	@return array of databases
	 */
	public String[] discoverDatabases(String selected);

	/**************************************************************************
	 * 	Test
	 *  @param monitor
	 *  @param data
	 *	@return error message or null if OK
	 */
	public String test(IDBConfigMonitor monitor, ConfigurationData data);
}
