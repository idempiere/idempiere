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
package org.compiere.model;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.idempiere.fa.feature.UseLife;
import org.idempiere.fa.feature.UseLifeImpl;

/**
 * Asset Group Accounting Model
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public class MAssetGroupAcct extends X_A_Asset_Group_Acct
	implements UseLife
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -2436949294592742530L;

	/**
	 * @param ctx
	 * @param A_Asset_Group_ID
	 * @return
	 * @deprecated use the version with postingType and trxName
	 */
	@Deprecated
	public static List<MAssetGroupAcct> forA_Asset_Group_ID(Properties ctx, int A_Asset_Group_ID)
	{
		return forA_Asset_Group_ID(ctx, A_Asset_Group_ID, null, null);
	}

	/**
	 * @param ctx
	 * @param A_Asset_Group_ID
	 * @param postingType
	 * @return
	 * @deprecated use the version with trxName
	 */
	@Deprecated
	public static List<MAssetGroupAcct>  forA_Asset_Group_ID(Properties ctx, int A_Asset_Group_ID, String postingType)
	{
		return forA_Asset_Group_ID(ctx, A_Asset_Group_ID, postingType, null);
	}

	/**
	 * Get Asset Group Accountings for given group
	 * @param ctx
	 * @param A_Asset_Group_ID
	 * @param postingType
	 * @param trxName
	 * @return list of MAssetGroupAcct
	 */
	public static List<MAssetGroupAcct>  forA_Asset_Group_ID(Properties ctx, int A_Asset_Group_ID, String postingType, String trxName)
	{
		List<Object> params = new ArrayList<Object>();
		StringBuilder whereClause = new StringBuilder("A_Asset_Group_ID=?");
		params.add(A_Asset_Group_ID);
		if (postingType != null) {
			whereClause.append(" AND PostingType=?");
			params.add(postingType);
		}
		return new Query(ctx, Table_Name, whereClause.toString(), trxName)
					.setParameters(params)
					.list();
	}
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Asset_Group_Acct_UU  UUID key
     * @param trxName Transaction
     */
    public MAssetGroupAcct(Properties ctx, String A_Asset_Group_Acct_UU, String trxName) {
        super(ctx, A_Asset_Group_Acct_UU, trxName);
    }

	/**
	 * 	Default ConstructorX_A_Asset_Group_Acct
	 *	@param ctx context
	 *	@param X_A_Asset_Group_Acct_ID id
	 */
	public MAssetGroupAcct (Properties ctx, int X_A_Asset_Group_Acct_ID, String trxName)
	{
		super (ctx,X_A_Asset_Group_Acct_ID, trxName);
	}	//	MAssetGroupAcct
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MAssetGroupAcct (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs,  trxName);
	}	//	MAssetGroupAcct
	
	/**	Asset Group	*/
	private MAssetGroup m_parent = null;
	
	/**
	 * Get Asset Group
	 * @return MAssetGroup
	 */
	public MAssetGroup getParent()
	{
		if (m_parent == null)
		{
			int A_Asset_Group_ID = getA_Asset_Group_ID();
			m_parent = MAssetGroup.getCopy(getCtx(), A_Asset_Group_ID, get_TrxName());
		}
		return m_parent;
	}
	
	@Override
	public Timestamp getAssetServiceDate()
	{
		return null;
	}
	
	/**
	 * Clone this object, using specified group
	 * @param grp	the new asset group
	 * @return new asset group accounting (NOTE: it's not saved)
	 */
	public MAssetGroupAcct copy(MAssetGroup grp)
	{
		MAssetGroupAcct newAcct = new MAssetGroupAcct(grp.getCtx(), 0, grp.get_TrxName());
		copyValues(this, newAcct, grp.getAD_Client_ID(), grp.getAD_Org_ID());
		newAcct.setA_Asset_Group_ID(grp.getA_Asset_Group_ID());
		return newAcct;
	}

	@Override
	public boolean beforeSave(boolean newRecord)
	{
		if (! UseLifeImpl.get(this).validate())
		{
			return false;
		}
		if (! UseLifeImpl.get(this, true).validate())
		{
			return false;
		}
		return true;
	}
	
	@Override
	public boolean set_AttrValue(String ColumnName, Object value) {
		int index = get_ColumnIndex(ColumnName);
		if (index < 0)
			return false;
		return set_ValueNoCheck(ColumnName, value);
	}
	
	@Override
	public Object get_AttrValue(String ColumnName) {
		int index = get_ColumnIndex(ColumnName);
		if (index < 0)
			return null;
		return get_Value(index);
	}
	
	@Override
	public boolean is_AttrValueChanged(String ColumnName) {
		int index = get_ColumnIndex(ColumnName);
		if (index < 0)
			return false;
		return is_ValueChanged(index);
	}
	
	/**
	 * Get Asset Group Accountings for given group
	 * @param ctx
	 * @param A_Asset_Group_ID
	 * @param postingType
	 * @param C_AcctSchema_ID
	 * @return MAssetGroupAcct
	 */
	public static MAssetGroupAcct forA_Asset_Group_ID(Properties ctx, int A_Asset_Group_ID, String postingType,
			int C_AcctSchema_ID) {
		final String whereClause = COLUMNNAME_A_Asset_Group_ID+"=? AND "+COLUMNNAME_PostingType+"=? AND " + COLUMNNAME_C_AcctSchema_ID +"=? " ;
		return new Query(ctx, Table_Name, whereClause, null)
					.setParameters(new Object[]{A_Asset_Group_ID, postingType, C_AcctSchema_ID})
					.firstOnly();
	}
	
}	//	MAssetGroupAcct
