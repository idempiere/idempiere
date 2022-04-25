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
import java.util.List;
import java.util.logging.Level;

import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;


/**
 *	POS Terminal definition
 *	
 *  @author Jorg Janke
 *  @version $Id: MPOS.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MPOS extends X_C_POS implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2499679269059812831L;

	/**
	 * 	Get POS from Cache (immutable)
	 *	@param C_POS_ID id
	 *	@return MPOS
	 */
	public static MPOS get (int C_POS_ID)
	{
		return get(Env.getCtx(), C_POS_ID);
	}
	
	/**
	 * 	Get POS from Cache (immutable)
	 *	@param ctx context
	 *	@param C_POS_ID id
	 *	@return MPOS
	 */
	public static MPOS get (Properties ctx, int C_POS_ID)
	{
		Integer key = Integer.valueOf(C_POS_ID);
		MPOS retValue = (MPOS) s_cache.get (ctx, key, e -> new MPOS(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MPOS (ctx, C_POS_ID, (String)null);
		if (retValue.get_ID () == C_POS_ID)
		{
			s_cache.put (key, retValue, e -> new MPOS(Env.getCtx(), e));
			return retValue;
		}
		return null;
	} //	get

	/**
	 * 	Get POSes for passed argument
	 *	@param ctx context
	 *  @param field
	 *  @param ID
	 *	@return POSes
	 */
	public static MPOS[] getAll (Properties ctx, String field, int ID)
	{
		String whereClause = field+"=?";
		List<MPOS> list = new Query(ctx, Table_Name, whereClause, null)
										.setParameters(ID)
										.setOnlyActiveRecords(true)
										.setOrderBy(COLUMNNAME_Name)
										.list();
		return list.toArray(new MPOS[list.size()]);
	}	//	get
	
	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MPOS> s_cache = new ImmutableIntPOCache<Integer,MPOS>(Table_Name, 20);

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_POS_ID id
	 *	@param trxName transaction
	 */
	public MPOS (Properties ctx, int C_POS_ID, String trxName)
	{
		super (ctx, C_POS_ID, trxName);
		if (C_POS_ID == 0)
		{
			setIsModifyPrice (false);	// N
		}	
	}	//	MPOS

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPOS (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPOS
	
	/**
	 * 
	 * @param copy
	 */
	public MPOS(MPOS copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MPOS(Properties ctx, MPOS copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MPOS(Properties ctx, MPOS copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_template = copy.m_template != null ? new MBPartner(ctx, copy.m_template, trxName) : null;
	}
	
	/**	Cash Business Partner			*/
	private MBPartner	m_template = null;
	
	
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		//	Org Consistency
		if (newRecord || is_ValueChanged("C_BankAccount_ID"))
		{
			MBankAccount cb = MBankAccount.get(getCtx(), getC_BankAccount_ID());
			if (cb.getAD_Org_ID() != getAD_Org_ID())
			{
				log.saveError("Error", Msg.parseTranslation(getCtx(), "@AD_Org_ID@: @C_BankAccount_ID@"));
				return false;
			}
		}
		if (newRecord || is_ValueChanged("M_Warehouse_ID"))
		{
			MWarehouse wh = MWarehouse.get(getCtx(), getM_Warehouse_ID(), get_TrxName());
			if (wh.getAD_Org_ID() != getAD_Org_ID())
			{
				log.saveError("Error", Msg.parseTranslation(getCtx(), "@AD_Org_ID@: @M_Warehouse_ID@"));
				return false;
			}
		}
		return true;
	}	//	beforeSave

	
	/**
	 * 	Get default Cash BPartner
	 *	@return BPartner
	 */
	public MBPartner getBPartner()
	{
		if (m_template == null)
		{
			if (getC_BPartnerCashTrx_ID() == 0)
				m_template = MBPartner.getBPartnerCashTrx (getCtx(), getAD_Client_ID());
			else
				m_template = new MBPartner(getCtx(), getC_BPartnerCashTrx_ID(), get_TrxName());
			if (is_Immutable() && m_template != null)
				m_template.markImmutable();
			if (log.isLoggable(Level.FINE)) log.fine("getBPartner - " + m_template);
		}
		return m_template;
	}	//	getBPartner

	@Override
	public MPOS markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_template != null)
			m_template.markImmutable();
		return this;
	}

	@Override
	public String toString() {
		return super.getName();
	}
	
}	//	MPOS
