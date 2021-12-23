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
 * Contributor(s): Carlos Ruiz - globalqss                                    *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import org.apache.commons.collections.keyvalue.MultiKey;
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Table Validator Scripts
 *  @author Carlos Ruiz
 *  @version $Id: MTableScriptValidator.java
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1885496 ] Performance NEEDS
 * 			<li>BF [ 2819654 ] Table Script Validator SeqNo is not set
 * 				https://sourceforge.net/p/adempiere/bugs/1978/
 */
public class MTableScriptValidator extends X_AD_Table_ScriptValidator implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6776991549481106111L;

	/**
	 * 	Get table script validator from cache (immutable)
	 *	@param AD_Table_ScriptValidator_ID id
	 *	@return MTableScriptValidator
	 */
	public static MTableScriptValidator get (int AD_Table_ScriptValidator_ID)
	{
		return get(Env.getCtx(), AD_Table_ScriptValidator_ID);
	}
	
	/**
	 * 	Get table script validator from cache (immutable)
	 *	@param ctx context
	 *	@param AD_Table_ScriptValidator_ID id
	 *	@return MTableScriptValidator
	 */
	public static MTableScriptValidator get (Properties ctx, int AD_Table_ScriptValidator_ID)
	{
		final Integer key = AD_Table_ScriptValidator_ID;
		MTableScriptValidator retValue = s_cache.get (ctx, key, e -> new MTableScriptValidator(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MTableScriptValidator (ctx, AD_Table_ScriptValidator_ID, (String)null);
		if (retValue.get_ID () == AD_Table_ScriptValidator_ID)
		{
			s_cache.put (key, retValue, e -> new MTableScriptValidator(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get
	
	/**
	 * 	Get Model Validation Script Rules for a table/event
	 *	@param ctx context
	 *	@param ad_table_id AD_Table_ID
	 *	@param event Event
	 *	@return array of MTableScriptValidator or null if error or no validators found
	 */
	public static List<MTableScriptValidator> getModelValidatorRules (Properties ctx, int ad_table_id, String event)
	{
		// Try cache
		final MultiKey key = new MultiKey(ad_table_id, event);
		List<MTableScriptValidator> mvrs = s_cacheTableEvent.get(key);
		if (mvrs != null)
		{
			return mvrs;
		}
		//
		// Fetch now
		final String whereClause = "AD_Table_ID=? AND EventModelValidator=?";
		mvrs = new Query(ctx, Table_Name, whereClause, null)
		.setParameters(ad_table_id, event)
		.setOnlyActiveRecords(true)
		.setOrderBy(COLUMNNAME_SeqNo)
		.list();
		// Store to cache
		for (MTableScriptValidator rule : mvrs)
		{
			s_cache.put(rule.get_ID(), rule, e -> new MTableScriptValidator(Env.getCtx(), e));
		}
		
		// Store to cache
		if (mvrs != null)
		{
			if (ctx == Env.getCtx())
				s_cacheTableEvent.put(key, mvrs.stream().collect(Collectors.toCollection(ArrayList::new)));
			else
				s_cacheTableEvent.put(key, mvrs.stream().map(e ->{return (MTableScriptValidator)new MTableScriptValidator(Env.getCtx(), e).markImmutable();}).collect(Collectors.toCollection(ArrayList::new)));
		}
		//
		if (mvrs != null && mvrs.size() > 0)
			return mvrs;
		else
			return null;
	}	//	getModelValidatorRules

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MTableScriptValidator> s_cache
					= new ImmutableIntPOCache<Integer,MTableScriptValidator>(Table_Name, 20);
	/** Cache / Table Event			*/
	private static CCache<MultiKey,List<MTableScriptValidator>> s_cacheTableEvent
					= new CCache<MultiKey,List<MTableScriptValidator>>(null, Table_Name+"_TableEvent", 20, false);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Table_ScriptValidator_ID id
	 *	@param trxName transaction
	 */
	public MTableScriptValidator (Properties ctx, int AD_Table_ScriptValidator_ID, String trxName)
	{
		super (ctx, AD_Table_ScriptValidator_ID, trxName);
	}	//	MTableScriptValidator

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MTableScriptValidator (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MTableScriptValidator
	
	/**
	 * 
	 * @param copy
	 */
	public MTableScriptValidator(MTableScriptValidator copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MTableScriptValidator(Properties ctx, MTableScriptValidator copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MTableScriptValidator(Properties ctx, MTableScriptValidator copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord)
	{
		if (getSeqNo() == 0)
		{
			final String sql = "SELECT COALESCE(MAX(SeqNo),0) + 10 FROM "+Table_Name
								+" WHERE AD_Table_ID=? AND EventModelValidator=?";
			int seqNo = DB.getSQLValueEx(get_TrxName(), sql, getAD_Table_ID(), getEventModelValidator());
			setSeqNo(seqNo);
		}
		//
		return true;
	}
	
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MTableScriptValidator[");
		sb.append(get_ID()).append("-").append(getAD_Table_ID()).append("-")
				.append(getEventModelValidator()).append("]");
		return sb.toString ();
	}	//	toString
	
	@Override
	public MTableScriptValidator markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MTableScriptValidator