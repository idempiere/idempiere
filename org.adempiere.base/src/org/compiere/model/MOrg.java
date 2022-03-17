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
import java.util.List;
import java.util.Properties;

import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.TrxEventListener;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Organization Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MOrg.java,v 1.3 2006/07/30 00:58:04 jjanke Exp $
 */
public class MOrg extends X_AD_Org implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8501438599288536080L;

	/**
	 * 	Get Active Organizations Of Client
	 *	@param po persistent object
	 *	@return array of orgs
	 */
	public static MOrg[] getOfClient (PO po)
	{
		return getOfClient(po.getAD_Client_ID());
	}	//	getOfClient

	/**
	 * 	Get Active Organizations Of current Client
	 *	@return array of orgs
	 */
	public static MOrg[] getOfClient ()
	{
		return getOfClient(Env.getAD_Client_ID(Env.getCtx()));		
	}

	/**
	 * 	Get Active Organizations Of Client
	 *	@param ctx context
	 *	@param int clientID
	 *	@return array of orgs
	 */
	public static MOrg[] getOfClient (int clientID)
	{
		List<MOrg> list = new Query(Env.getCtx(), Table_Name, "AD_Client_ID=?", null)
								.setOrderBy(COLUMNNAME_Value)
								.setOnlyActiveRecords(true)
								.setParameters(clientID)
								.list();
		for (MOrg org : list)
		{
			s_cache.put(org.get_ID(), org);
		}
		return list.toArray(new MOrg[list.size()]);
	}	//	getOfClient

	/**
	 * 	Get Org from Cache (immutable)
	 *	@param AD_Org_ID id
	 *	@return MOrg
	 */
	public static MOrg get (int AD_Org_ID)
	{
		return get(Env.getCtx(), AD_Org_ID);
	}
	
	/**
	 * 	Get Org from Cache (immutable)
	 *	@param AD_Org_ID id
	 *	@return MOrg
	 */
	public static MOrg get (Properties ctx, int AD_Org_ID)
	{
		MOrg retValue = s_cache.get (ctx, AD_Org_ID, e -> new MOrg(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MOrg (ctx, AD_Org_ID, (String)null);
		if (retValue.get_ID () == AD_Org_ID)
		{
			s_cache.put (AD_Org_ID, retValue, e -> new MOrg(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MOrg>	s_cache	= new ImmutableIntPOCache<Integer,MOrg>(Table_Name, 50);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Org_ID id
	 *	@param trxName transaction
	 */
	public MOrg (Properties ctx, int AD_Org_ID, String trxName)
	{
		super(ctx, AD_Org_ID, trxName);
		if (AD_Org_ID == 0)
		{
		//	setValue (null);
		//	setName (null);
			setIsSummary (false);
		}
	}	//	MOrg

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MOrg (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MOrg

	/**
	 * 	Parent Constructor
	 *	@param client client
	 *	@param name name
	 */
	public MOrg (MClient client, String value, String name)
	{
		this (client.getCtx(), 0, client.get_TrxName());
		setAD_Client_ID (client.getAD_Client_ID());
		setValue (value);
		setName (name);
	}	//	MOrg

	/**
	 * 
	 * @param copy
	 */
	public MOrg(MOrg copy)
	{
		this(Env.getCtx(), copy);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MOrg(Properties ctx, MOrg copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MOrg(Properties ctx, MOrg copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_linkedBPartner = copy.m_linkedBPartner;
	}
	
	/**	Linked Business Partner			*/
	private Integer 	m_linkedBPartner = null;

	/**
	 *	Get Org Info
	 *	@return Org Info
	 */
	public MOrgInfo getInfo()
	{
		MOrgInfo orgInfo = MOrgInfo.getCopy(Env.getCtx(), getAD_Org_ID(), get_TrxName());
		return orgInfo;
	}	//	getMOrgInfo


	
	/**
	 * 	After Save
	 *	@param newRecord new Record
	 *	@param success save success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if (newRecord)
		{
			//	Info
			MOrgInfo info = new MOrgInfo (this);
			info.saveEx();
			//	Access
			MRoleOrgAccess.createForOrg (this);
			MRole role = MRole.getDefault(getCtx(), true);	//	reload
			role = new MRole(getCtx(), role, get_TrxName());
			role.loadAccess(true); // reload org access within transaction
			//	TreeNode
			insert_Tree(MTree_Base.TREETYPE_Organization);
		}
		if (newRecord || is_ValueChanged(COLUMNNAME_Value))
			update_Tree(MTree_Base.TREETYPE_Organization);
		//	Value/Name change
		if (!newRecord && (is_ValueChanged("Value") || is_ValueChanged("Name")))
		{
			MAccount.updateValueDescription(getCtx(), "AD_Org_ID=" + getAD_Org_ID(), get_TrxName());
			if ("Y".equals(Env.getContext(getCtx(), "$Element_OT"))) 
				MAccount.updateValueDescription(getCtx(), "AD_OrgTrx_ID=" + getAD_Org_ID(), get_TrxName());
		}

		Trx.get(get_TrxName(), false).addTrxEventListener(new TrxEventListener() {
			@Override
			public void afterRollback(Trx trx, boolean success) {
			}

			@Override
			public void afterCommit(Trx trx, boolean success) {
				MRole.getDefault().loadAccess(true);
				CacheMgt.get().reset();
			}

			@Override
			public void afterClose(Trx trx) {
			}
		});

		return true;
	}	//	afterSave
	
	/**
	 * 	After Delete
	 *	@param success
	 *	@return deleted
	 */
	protected boolean afterDelete (boolean success)
	{
		if (success)
			delete_Tree(MTree_Base.TREETYPE_Organization);
		return success;
	}	//	afterDelete


	/**
	 * 	Get Linked BPartner
	 *	@return C_BPartner_ID
	 */
	public int getLinkedC_BPartner_ID(String trxName)
	{
		if (m_linkedBPartner == null)
		{
			int C_BPartner_ID = DB.getSQLValue(trxName,
				"SELECT C_BPartner_ID FROM C_BPartner WHERE AD_OrgBP_ID=?",
				getAD_Org_ID());
			if (C_BPartner_ID < 0)	//	not found = -1
				C_BPartner_ID = 0;
			m_linkedBPartner = Integer.valueOf(C_BPartner_ID);
		}
		return m_linkedBPartner.intValue();
	}	//	getLinkedC_BPartner_ID

	@Override
	public MOrg markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MOrg
