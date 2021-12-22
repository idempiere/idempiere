/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.db;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.base.ServiceQuery;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.Util;

/**
 *  General Database Constants and Utilities
 *
 *  @author     Jorg Janke
 *  @version    $Id: Database.java,v 1.3 2006/07/30 00:55:13 jjanke Exp $
 */
public class Database
{
	/**	Logger							*/
	private static final CLogger			log = CLogger.getCLogger (Database.class);
	
	/** Oracle ID       */
	public static String        DB_ORACLE   = "Oracle";               	
    /** PostgreSQL ID   */
	public static String        DB_POSTGRESQL = "PostgreSQL";

	/** Connection Timeout in seconds   */
	public static int           CONNECTION_TIMEOUT = 10;
	
	/** Default Port                */
    public static final int         DB_ORACLE_DEFAULT_PORT = 1521;
    /** Default Connection Manager Port */
    public static final int         DB_ORACLE_DEFAULT_CM_PORT = 1630;
    
    /** Default Port            */
	public static final int         DB_POSTGRESQL_DEFAULT_PORT = 5432;
	
	private static final CCache<String, IServiceReferenceHolder<AdempiereDatabase>> s_databaseReferenceCache = new CCache<>(null, "IDatabase", 2, false);
	
	/**
	 *  Get Database by database Id.
	 *  @return database
	 */
	public static AdempiereDatabase getDatabase (String type)
	{
		AdempiereDatabase db = null;
		IServiceReferenceHolder<AdempiereDatabase> cache = s_databaseReferenceCache.get(type);
		if (cache != null) {
			db = cache.getService();
			if (db != null)
				return db;
			s_databaseReferenceCache.remove(type);
		}
		ServiceQuery query = new ServiceQuery();
		query.put("id", type);
		IServiceReferenceHolder<AdempiereDatabase> serviceReference = Service.locator().locate(AdempiereDatabase.class, query).getServiceReference();
		if (serviceReference != null) {
			db = serviceReference.getService();
			s_databaseReferenceCache.put(type, serviceReference);
		}
		return db;
	}
	
	public static String[] getDatabaseNames()
	{
		List<String> names = new ArrayList<String>();
		List<AdempiereDatabase> services = Service.locator().list(AdempiereDatabase.class).getServices();
		for (AdempiereDatabase db : services) {
			names.add(db.getName());
		}
		return names.toArray(new String[0]);
	}
	
	/**
	 *  Get Database Driver by url string.
	 *  Access to database specific functionality.
	 *  @param url JDBC connection url
	 *  @return iDempiere Database Driver
	 */
	public static AdempiereDatabase getDatabaseFromURL(String url)
	{
		if (url == null)
		{
			log.severe("No Database URL");
			return null;
		}
		if (url.indexOf("oracle") != -1)
			return getDatabase(DB_ORACLE);
        if (url.indexOf("postgresql") != -1)
			return getDatabase(DB_POSTGRESQL);

		log.severe("No Database for " + url);
		return null;
	}

	/**
	 *  Apply common validations for database object names
	 *  @param identifier String
	 *  @return String error-code - null if not error
	 */
	public static String isValidIdentifier(String identifier)
	{
		if (Util.isEmpty(identifier))
			return "InvalidIdentifierEmpty";
		// unquoted identifiers cannot contain spaces
		if (identifier.contains(" "))
			return "InvalidIdentifierSpaces";
		// first character of identifier must be alphabetic
		if (! identifier.substring(0,  1).matches("[a-zA-Z]"))
			return "InvalidIdentifierFirstCharAlpha";
		// names must contain just alphanumeric and underscore
		if (! identifier.matches("^[a-zA-Z0-9_]*$"))
			return "InvalidIdentifierJustAlpha";
		return null;
	}

}   //  Database
