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

import static org.compiere.model.SystemIDs.ENTITYTYPE_ADEMPIERE;
import static org.compiere.model.SystemIDs.ENTITYTYPE_DICTIONARY;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.ImmutablePOCache;

/**
 * 	Enitity Type Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MEntityType.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 * 
 * @author Teo Sarca
 * 		<li>BF [ 2827777 ] MEntityType.isSystemMaintained not working well
 * 			https://sourceforge.net/p/adempiere/bugs/1993/
 * 		<li>FR [ 2827786 ] Introduce MEntityType.get(Properties ctx, String entityType)
 * 			https://sourceforge.net/p/adempiere/feature-requests/778/
 * 		<li>BF [ 2861194 ] EntityType is not using normal PO framework for getting IDs
 * 			https://sourceforge.net/p/adempiere/bugs/2103/
 */
public class MEntityType extends X_AD_EntityType implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7160389442572466581L;

	/**
	 * Get EntityType object by name (immutable)
	 * @param entityType
	 * @return entity type
	 */
	public static MEntityType get(String entityType)
	{
		return get(Env.getCtx(), entityType);
	}
	
	/**
	 * Get EntityType object by name (immutable)
	 * @param ctx
	 * @param entityType
	 * @return entity type
	 */
	public static MEntityType get(Properties ctx, String entityType)
	{
		MEntityType retValue = s_cache.get (ctx, entityType, e -> new MEntityType(ctx, e));
		if (retValue != null)
			return retValue;
		
		retValue = new Query(ctx, Table_Name, "EntityType=?", null)
			.setParameters(entityType)
			.firstOnly();
		
		if (retValue != null)
			s_cache.put (entityType, retValue, e -> new MEntityType(Env.getCtx(), e));
		
		return retValue;
	}
	
	/** Cached EntityTypes						*/
	private static ImmutablePOCache<String,MEntityType>	s_cache = new ImmutablePOCache<String,MEntityType>(Table_Name, 20);
	/**	Logger	*/
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger (MEntityType.class);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_EntityType_ID id
	 *	@param trxName transaction
	 */
	public MEntityType (Properties ctx, int AD_EntityType_ID, String trxName)
	{
		super (ctx, AD_EntityType_ID, trxName);
	}	//	MEntityType

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MEntityType (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MEntityType
	
	/**
	 * 
	 * @param copy
	 */
	public MEntityType(MEntityType copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MEntityType(Properties ctx, MEntityType copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MEntityType(Properties ctx, MEntityType copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * First Not System Entity ID
	 * 10=D, 20=C,  100=U, 110=CUST,  200=A, 210=EXT, 220=XX etc
	 */
	private static final int s_maxAD_EntityType_ID = 1000000;
	
	/**
	 * Is System Maintained.
	 * Any Entity Type with ID &lt; 1000000.
	 * @return true if D/C/U/CUST/A/EXT/XX (ID &lt; 1000000)
	 */
	public boolean isSystemMaintained()
	{
		int id = getAD_EntityType_ID();
		return id < s_maxAD_EntityType_ID;
	}	//	isSystemMaintained
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true if it can be saved
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (!newRecord)
		{
			int id = getAD_EntityType_ID();
			boolean systemMaintained = (id == ENTITYTYPE_DICTIONARY || id == ENTITYTYPE_ADEMPIERE);	//	C/D
			if (systemMaintained)
			{
				log.saveError("Error", "You cannot modify a System maintained entity");
				return false;
			}
			systemMaintained = is_ValueChanged("EntityType");
			if (systemMaintained)
			{
				log.saveError("Error", "You cannot modify EntityType");
				return false;
			}
			systemMaintained = isSystemMaintained()
				&&	(is_ValueChanged("Name") || is_ValueChanged("Description") 
					|| is_ValueChanged("Help") || is_ValueChanged("IsActive"));
			if (systemMaintained)
			{
				log.saveError("Error", "You cannot modify Name,Description,Help");
				return false;
			}
		}
		
		return true;
	}	//	beforeSave
	
	/**
	 * 	Before Delete
	 *	@return true if it can be deleted
	 */
	protected boolean beforeDelete ()
	{
		if (isSystemMaintained())	//	all pre-defined
		{
			log.saveError("Error", "You cannot delete a System maintained entity");
			return false;
		}
		return true;
	}	//	beforeDelete
	
	@Override
	public MEntityType markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MEntityType
