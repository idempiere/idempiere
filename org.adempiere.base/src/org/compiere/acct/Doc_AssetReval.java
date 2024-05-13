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
package org.compiere.acct;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAssetAcct;
import org.compiere.model.MAssetReval;
import org.compiere.model.MDocType;
import org.compiere.util.Env;

/**
 * Posting for {@link MAssetReval} document. DOCBASETYPE_GLJournal.
 * @author Anca Bradau www.arhipac.ro
 */
public class Doc_AssetReval extends Doc  
{
	
	private static final String POSTINGTYPE_Actual = "A";
	
	/**
	 * @param as
	 * @param rs
	 * @param trxName
	 */
	public Doc_AssetReval (MAcctSchema as, ResultSet rs, String trxName)
	{
		super(as, MAssetReval.class, rs, MDocType.DOCBASETYPE_GLJournal, trxName);
	}

	@Override
	public ArrayList<Fact> createFacts(MAcctSchema as)
	{
		MAssetAcct assetAcct = getAssetAcct(as);
		MAssetReval assetRe = getAssetReval();
		
		ArrayList<Fact> facts = new ArrayList<Fact>();
		Fact fact = new Fact(this, as, assetAcct.getPostingType());
		facts.add(fact);
		
		MAccount dr = MAccount.get(getCtx(), assetAcct.getA_Asset_Acct());  
		MAccount cr = MAccount.get(getCtx(), assetAcct.getA_Reval_Cost_Offset_Acct());
		FactUtil.createSimpleOperation(fact, null, dr, cr, as.getC_Currency_ID(),
				assetRe.getA_Asset_Cost_Change().subtract(assetRe.getA_Asset_Cost()), false);
		
			
		MAccount drd = MAccount.get(getCtx(), assetAcct.getA_Reval_Cost_Offset_Acct());  
		MAccount crd = MAccount.get(getCtx(), assetAcct.getA_Accumdepreciation_Acct());
		FactUtil.createSimpleOperation(fact, null, drd, crd, as.getC_Currency_ID(),
				assetRe.getA_Change_Acumulated_Depr().subtract(assetRe.getA_Accumulated_Depr()), false);
		
		
		return facts;
	}

	@Override
	public BigDecimal getBalance() 
	{
		return  Env.ZERO;
	}
	
	@Override
	protected String loadDocumentDetails() 
	{
		return null;
	}
	
	/**
	 * @return POSTINGTYPE_Actual
	 */
	public String getPostingType() 
	{
		return POSTINGTYPE_Actual;
	}
	
	/**
	 * @param as
	 * @return MAssetAcct
	 */
	private MAssetAcct getAssetAcct(MAcctSchema as)
	{
		return MAssetAcct.forA_Asset_ID(getCtx(),as.get_ID(), getA_Asset_ID(), getPostingType() , getDateAcct(), null);
	}
	
	/**
	 * @return MAssetReval
	 */
	private MAssetReval getAssetReval()
	{
		return (MAssetReval)getPO();
	}
	
	/**
	 * Get A_Asset_ID
	 * @return A_Asset_ID
	 */
	public int getA_Asset_ID()
	{
		int index = p_po.get_ColumnIndex("A_Asset_ID");
		if (index != -1)
		{
			Integer ii = (Integer)p_po.get_Value(index);
			if (ii != null)
				return ii.intValue();
		}
		return 0;
	}

}
