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
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;

import org.compiere.acct.Doc;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MTable;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.osgi.service.component.annotations.Component;

@Component(name = "org.adempiere.base.MappedDocumentFactory", 
	service = {IDocFactory.class, IMappedDocumentFactory.class}, 
	immediate = true,
	property = {"service.ranking:Integer=1", "gaap=*"})
/**
 * 
 * Document factory backed by map between tablename + gaap and lambda function object.
 * If you create a subclass of this and register it as osgi service, don't register for the IMappedDocumentFactory interface.
 * @author hengsin
 *
 */
public class MappedDocumentFactory implements IDocFactory, IMappedDocumentFactory {

	private final ConcurrentHashMap<String, Function<Parameter, ? extends Doc>> documentMap = new ConcurrentHashMap<>();
	
	/**
	 * default constructor
	 */
	public MappedDocumentFactory() {
	}

	@Override
	public Doc getDocument(MAcctSchema as, int AD_Table_ID, ResultSet rs, String trxName) {
		String tableName = MTable.getTableName(Env.getCtx(), AD_Table_ID);
		String key = tableName + "|" + as.getGAAP();
		Function<Parameter, ? extends Doc> function = documentMap.get(key);
		if (function != null) {
			return function.apply(new Parameter(as, rs, trxName));
		}
		
		key = tableName + "|*";
		function = documentMap.get(key);
		if (function != null) {
			return function.apply(new Parameter(as, rs, trxName));
		}
		
		return null;
	}

	@Override
	public void addMapping(String gaap, String tableName, Function<Parameter, ? extends Doc> supplier) {		
		StringBuilder key = new StringBuilder();
		key.append(tableName).append("|");
		if (Util.isEmpty(gaap, true))
			key.append("*");
		else
			key.append(gaap);
		documentMap.put(key.toString(), supplier);
	}
	
	@Override
	public void removeMapping(String gaap, String tableName) {
		StringBuilder key = new StringBuilder();
		key.append(tableName).append("|");
		if (Util.isEmpty(gaap, true))
			key.append("*");
		else
			key.append(gaap);
		documentMap.remove(key.toString());
	}	
}
