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
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *  List Values for {@link X_AD_Reference#VALIDATIONTYPE_ListValidation}
 *
 *  @author Jorg Janke
 *  @version $Id: MRefList.java,v 1.3 2006/07/30 00:58:18 jjanke Exp $
 *  
 *  @author Teo Sarca, www.arhipac.ro
 *  		<li>BF [ 1748449 ] Info Account - Posting Type is not translated
 *  		<li>FR [ 2694043 ] Query. first/firstOnly usage best practice
 */
public class MRefList extends X_AD_Ref_List implements ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -2704284822855131148L;
	/**	RefList Value Cache						*/
	private static ImmutablePOCache<String,MRefList> s_ref_value_cache	= new ImmutablePOCache<String,MRefList>(Table_Name, 40, 0, false, 0);

	/**
	 * 	Get Reference List 
	 *	@param ctx context
	 *	@param AD_Reference_ID reference
	 *	@param Value value
	 *	@param trxName transaction
	 *	@return List or null
	 */
	public static synchronized MRefList get (Properties ctx, int AD_Reference_ID, String Value, String trxName)
	{
		StringBuilder sb = new StringBuilder(String.valueOf(AD_Reference_ID))
								.append("|")
								.append(Value);
		String key = sb.toString();
		MRefList rl = s_ref_value_cache.get(ctx, key, e -> new MRefList(ctx, e));
		if (rl == null)
		{
			rl = new Query(ctx, Table_Name, "AD_Reference_ID=? AND Value=?", trxName)
					.setParameters(AD_Reference_ID, Value)
					.first();
			if (rl != null)
			{
				s_ref_value_cache.put(key, rl, e -> new MRefList(Env.getCtx(), e));
			}
		}
		return rl;
	}	//	get

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MRefList(Properties ctx, MRefList copy) 
	{
		this(ctx, copy, (String) null);
	}
	
	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MRefList(Properties ctx, MRefList copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * Get Reference List Value Name (cached)
	 * @param ctx context
	 * @param AD_Reference_ID reference
	 * @param Value value
	 * @return List or ""
	 */
	public static String getListName (Properties ctx, int AD_Reference_ID, String Value)
	{
		String AD_Language = Env.getAD_Language(ctx);
		return getListName (AD_Language, AD_Reference_ID, Value);
	}

	/**
	 * Get Reference List Name for Value (cached)
	 * @param AD_Language
	 * @param AD_Reference_ID reference
	 * @param Value list value
	 * @return List Name or ""
	 */
	public static String getListName (String AD_Language, int AD_Reference_ID, String Value)
	{
		String key = AD_Language + "_" + AD_Reference_ID + "_" + Value;
		String retValue = (String)s_cache.get(key);
		if (retValue != null)
			return retValue;

		boolean isBaseLanguage = Env.isBaseLanguage(AD_Language, "AD_Ref_List");
		String sql = isBaseLanguage ?
			"SELECT Name, IsActive FROM AD_Ref_List "
			+ "WHERE AD_Reference_ID=? AND Value=?" :
			"SELECT t.Name, r.IsActive FROM AD_Ref_List_Trl t"
			+ " INNER JOIN AD_Ref_List r ON (r.AD_Ref_List_ID=t.AD_Ref_List_ID) "
			+ "WHERE r.AD_Reference_ID=? AND r.Value=? AND t.AD_Language=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_Reference_ID);
			pstmt.setString(2, Value);
			if (!isBaseLanguage)
				pstmt.setString(3, AD_Language);
			rs = pstmt.executeQuery ();
			if (rs.next ()) {
				retValue = rs.getString(1);
				String isActive = rs.getString(2);
				if (!"Y".equals(isActive))
					retValue = MLookup.INACTIVE_S + retValue + MLookup.INACTIVE_E;
			}
		}
		catch (SQLException ex)
		{
			s_log.log(Level.SEVERE, sql + " -- " + key, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		//	Save into Cache
		if (retValue == null)
		{
			retValue = "";
			s_log.warning("Not found " + key);
		}
		s_cache.put(key, retValue);
		//
		return retValue;
	}	//	getListName
		
	/**
	 * Get Reference List Description (cached) for Value
	 * @param ctx context
	 * @param ListName list name
	 * @param Value list value
	 * @return List Description or null
	 */
	public static String getListDescription (Properties ctx, String ListName, String Value)
	{
		String AD_Language = Env.getAD_Language(ctx);
		return getListDescription (AD_Language, ListName, Value);
	}

	/**
	 * Get Reference List Description (cached) for Value
	 * @param AD_Language
	 * @param ListName list name
	 * @param Value list value
	 * @return List Description or null
	 */
	public static String getListDescription (String AD_Language, String ListName, String Value)
	{
		String key = AD_Language + "_" + ListName + "_" + Value;
		String retValue = s_cache.get(key);
		if (retValue != null)
			return retValue;

		boolean isBaseLanguage = Env.isBaseLanguage(AD_Language, "AD_Ref_List");
		String sql = isBaseLanguage ?
			"SELECT a.Description FROM AD_Ref_List a, AD_Reference b"
			+ " WHERE b.Name=? AND a.Value=?" 
			+ " AND a.AD_Reference_ID = b.AD_Reference_ID"
			: 				
			"SELECT t.Description FROM AD_Reference r"
			+" INNER JOIN AD_Ref_List rl ON (r.AD_Reference_ID=rl.AD_Reference_ID)"
			+" INNER JOIN AD_Ref_List_Trl t ON (t.AD_Ref_List_ID=rl.AD_Ref_List_ID)"
			+" WHERE r.Name=? AND rl.Value=? AND t.AD_Language=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql,null);
			pstmt.setString (1, ListName);
			pstmt.setString(2, Value);			
			if (!isBaseLanguage)
				pstmt.setString(3, AD_Language);
			rs = pstmt.executeQuery ();
			if (rs.next ())
				retValue = rs.getString(1);
		}
		catch (SQLException ex)
		{
			s_log.log(Level.SEVERE, sql + " -- " + key, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		//	Save into Cache
		if (retValue == null)
		{
			retValue = "";
			if (s_log.isLoggable(Level.INFO)) s_log.info("getListDescription - Not found " + key);
		}
		s_cache.put(key, retValue);
		//
		return retValue;
	}	//	getListDescription
	
	/**
	 * Get Reference List (translated name) entries
	 * @param ctx context
	 * @param AD_Reference_ID reference
	 * @param optional if true add ValueNamePair("","") to list entries return
	 * @return Array of ValueNamePair(list value, translated list name) or null
	 */
	public static ValueNamePair[] getList (Properties ctx, int AD_Reference_ID, boolean optional)
	{
		return getList(ctx, AD_Reference_ID, optional, "");
	} // getList

	/**
	 * Get Reference List (translated name) entries
	 * @param ctx context
	 * @param AD_Reference_ID reference
	 * @param optional if true add ValueNamePair("","") to list entries return
	 * @param orderBy (Null,"" or N)-Name, V-Value, D-Default (IsOrderByValue)
	 * @return Array of ValueNamePair(list value, translated list name) or null
	 */
	public static ValueNamePair[] getList (Properties ctx, int AD_Reference_ID, boolean optional, String orderBy) {
		return getList(ctx, AD_Reference_ID, optional, "", orderBy);
	}
	
	/**
	 * Get Reference List (translated name) entries
	 * @param ctx context
	 * @param AD_Reference_ID reference
	 * @param optional if true add ValueNamePair("","") to list entries return
	 * @param additionalWhereClause
	 * @param orderBy (Null,"" or N)-Name, V-Value, D-Default (IsOrderByValue)
	 * @return Array of ValueNamePair(list value, translated list name) or null
	 */
	public static ValueNamePair[] getList (Properties ctx, int AD_Reference_ID, boolean optional, String additionalWhereClause, String orderBy) {

		String language = Env.getAD_Language(ctx);
		boolean orderByValue = MReference.get(AD_Reference_ID).isOrderByValue();
		boolean isShowInactive = MReference.get(AD_Reference_ID).isShowInactiveRecords();
		if (Util.isEmpty(orderBy) || "N".equals(orderBy))
			orderByValue = false;
		else if ("V".equals(orderBy))
			orderByValue = true;
		StringBuilder sql = new StringBuilder ("SELECT AD_Ref_List.Value,");
		MClient client = MClient.get(Env.getCtx());
		StringBuilder AspFilter = new StringBuilder();
		if ( client.isUseASP() ) {
			AspFilter.append(" AND AD_Ref_List.AD_Ref_List_ID NOT IN ( ")
			.append(" SELECT li.AD_Ref_List_ID")
			.append(" FROM ASP_Ref_List li")
			.append(" INNER JOIN ASP_Level l ON ( li.ASP_Level_ID = l.ASP_Level_ID)")
			.append(" INNER JOIN ASP_ClientLevel cl on (l.ASP_Level_ID = cl.ASP_Level_ID)")
			.append(" INNER JOIN AD_Client c on (cl.AD_Client_ID = c.AD_Client_ID)")
			.append(" WHERE li.AD_Reference_ID=").append(AD_Reference_ID)
			.append(" AND li.IsActive='Y'")
			.append(" AND c.AD_Client_ID=").append(client.getAD_Client_ID())
			.append(" AND li.ASP_Status='H')");
		}

		if (Env.isBaseLanguage(language, "AD_Ref_List"))
			sql.append("AD_Ref_List.Name,AD_Ref_List.IsActive FROM AD_Ref_List ");
		else
			sql.append("trl.Name, AD_Ref_List.IsActive ")
			.append("FROM AD_Ref_List INNER JOIN AD_Ref_List_Trl trl ")
			.append(" ON (AD_Ref_List.AD_Ref_List_ID=trl.AD_Ref_List_ID AND trl.AD_Language='")
			.append(language).append("')");
		sql.append(" WHERE AD_Ref_List.AD_Reference_ID=").append(AD_Reference_ID);
		
		if(!isShowInactive)
			sql.append(" AND AD_Ref_List.IsActive='Y'");

		if (!Util.isEmpty(additionalWhereClause, true))
			sql.append(" AND (").append(additionalWhereClause).append(")");

		sql.append(AspFilter.toString());
		if (orderByValue)
			sql.append(" ORDER BY 1");
		else
			sql.append(" ORDER BY 2");

		ArrayList<ValueNamePair> list = new ArrayList<ValueNamePair>();
        if (optional)
            list.add (ValueNamePair.EMPTY);
        List<List<Object>> rows = DB.getSQLArrayObjectsEx(null, sql.toString());
        if (rows != null) {
            for (List<Object> row : rows) {
            	String value = row.get(0).toString();
            	StringBuilder name = new StringBuilder(row.get(1).toString());
            	String isActive = row.get(2).toString();
            	if (! "Y".equals(isActive))
            		name.insert(0, MLookup.INACTIVE_S).append(MLookup.INACTIVE_E);
            	list.add(new ValueNamePair(value, name.toString()));
            }
        }

		return list.toArray(new ValueNamePair[list.size()]);
	}	//	getList

	/**	Logger							*/
	private static CLogger		s_log = CLogger.getCLogger (MRefList.class);
	/** Value Cache						*/
	private static CCache<String,String> s_cache = new CCache<String,String>(Table_Name, 20, 0, false, 0);

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Ref_List_UU  UUID key
     * @param trxName Transaction
     */
    public MRefList(Properties ctx, String AD_Ref_List_UU, String trxName) {
        super(ctx, AD_Ref_List_UU, trxName);
		if (Util.isEmpty(AD_Ref_List_UU))
			setInitialDefaults();
    }

	/**
	 *	@param ctx context
	 *	@param AD_Ref_List_ID id
	 *	@param trxName transaction
	 */
	public MRefList (Properties ctx, int AD_Ref_List_ID, String trxName)
	{
		super (ctx, AD_Ref_List_ID, trxName);
		if (AD_Ref_List_ID == 0)
			setInitialDefaults();
	}	//	MRef_List

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setEntityType (ENTITYTYPE_UserMaintained);	// U
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result
	 *	@param trxName transaction
	 */
	public MRefList (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRef_List

	/**
	 *	String Representation
	 * 	@return Name
	 */
	@Override
	public String toString()
	{
		return getName();
	}	//	toString

	@Override
	public PO markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MRef_List
