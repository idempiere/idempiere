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
 **********************************************************************/
package org.adempiere.process;

import java.util.Properties;

import org.compiere.process.ProcessInfo;

/**
 * All processes that are importing data should implement this interface.
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>FR [ 2788276 ] Data Import Validator
 * 				https://sourceforge.net/p/adempiere/feature-requests/712/
 */
public interface ImportProcess
{
	/**
	 * 
	 * @return The Name of Import Table (e.g. I_BPartner)
	 */
	public String getImportTableName();
	
	/**
	 * 
	 * @return SQL WHERE clause to filter records that are candidates for import
	 */
	public String getWhereClause();
	
	/**
	 * Get Process Context
	 * @return context
	 */
	public Properties getCtx();
	
	/**
	 * Get Process Transaction Name 
	 * @return transaction name
	 */
	public String get_TrxName();

	/**
	 * Get Process Info
	 * @return Process Info
	 * @see org.compiere.process.SvrProcess#getProcessInfo()
	 */
	public ProcessInfo getProcessInfo();
}
