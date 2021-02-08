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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base;

import java.sql.ResultSet;
import java.util.function.Function;

import org.compiere.acct.Doc;
import org.compiere.model.MAcctSchema;

/**
 * 
 * @author hengsin
 *
 */
public interface IMappedDocumentFactory {

	/**
	 * add table name + gaap (optional) to Doc mapping
	 * @param gaap map to c_acctschema.gaap (optional)
	 * @param tableName
	 * @param supplier
	 */
	public void addMapping(String gaap, String tableName, Function<Parameter, ? extends Doc> supplier);

	/**
	 * 
	 * @param gaap
	 * @param tableName
	 */
	public void removeMapping(String gaap, String tableName);

	/**
	 * 
	 * parameter class for doc supplier
	 *
	 */
	public final static class Parameter {
		public MAcctSchema as;
		public ResultSet rs;
		public String trxName;
		
		public Parameter(MAcctSchema as, ResultSet rs, String trxName) {
			this.as = as;
			this.rs = rs;
			this.trxName = trxName;
		}				
	}
}