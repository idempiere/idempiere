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

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;


/**
 *	Form Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MForm.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 */
public class MForm extends X_AD_Form implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3617225890452735325L;
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MForm> s_cache = new ImmutableIntPOCache<Integer,MForm>(Table_Name, 20);
	
	/**
	 * 	Get MForm from Cache (immutable)
	 *	@param AD_Form_ID id
	 *	@return MForm
	 */
	public static MForm get (int AD_Form_ID)
	{
		return get(Env.getCtx(), AD_Form_ID);
	}
	
	/**
	 * 	Get MFrom from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Form_ID id
	 *	@return MForm
	 */
	public static MForm get (Properties ctx, int AD_Form_ID)
	{
		Integer key = Integer.valueOf(AD_Form_ID);
		MForm retValue = s_cache.get (ctx, key, e -> new MForm(ctx, e));
		if (retValue != null) 
			return retValue;
		
		retValue = new MForm (ctx, AD_Form_ID, (String)null);
		if (retValue.get_ID () == AD_Form_ID) {
			s_cache.put (key, retValue, e -> new MForm(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get
	
	/**
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param AD_Form_ID id
	 *	@param trxName transaction
	 */
	public MForm (Properties ctx, int AD_Form_ID, String trxName)
	{
		super (ctx, AD_Form_ID, trxName);
	}	//	MForm

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MForm (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MForm
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MForm(Properties ctx, MForm copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MForm(Properties ctx, MForm copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if (newRecord)
		{
			int AD_Role_ID = Env.getAD_Role_ID(getCtx());
			MFormAccess pa = new MFormAccess(this, AD_Role_ID);
			pa.saveEx();
		}
		//	Menu
		else if (is_ValueChanged("IsActive") || is_ValueChanged("Name") 
			|| is_ValueChanged("Description"))
		{
			MMenu[] menues = MMenu.get(getCtx(), "AD_Form_ID=" + getAD_Form_ID(), get_TrxName());
			for (int i = 0; i < menues.length; i++)
			{
				menues[i].setName(getName());
				menues[i].setDescription(getDescription());
				menues[i].setIsActive(isActive());
				menues[i].saveEx();
			}
			//
		}
		return success;
	}	//	afterSave
	
	@Override
	public MForm markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		return this;
	}
}	//	MForm
