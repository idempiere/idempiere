package org.compiere.acct;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAssetAcct;
import org.compiere.model.MAssetChange;
import org.compiere.model.MAssetDisposed;
import org.compiere.model.MDocType;
import org.compiere.util.Env;


/**
 * @author Teo_Sarca, SC ARHIPAC SERVICE SRL
 */
public class Doc_AssetDisposed extends Doc
{
	/**
	 * @param as
	 * @param rs
	 * @param trxName
	 */
	public Doc_AssetDisposed (MAcctSchema as, ResultSet rs, String trxName)
	{
		super(as, MAssetDisposed.class, rs, MDocType.DOCBASETYPE_GLDocument, trxName);
	}

	
	protected String loadDocumentDetails()
	{
		return null;
	}
	
	
	public BigDecimal getBalance()
	{
		return Env.ZERO;
	}

	
	public ArrayList<Fact> createFacts(MAcctSchema as)
	{
		MAssetDisposed assetDisp = (MAssetDisposed)getPO();
		
		ArrayList<Fact> facts = new ArrayList<Fact>();
		Fact fact = new Fact(this, as, assetDisp.getPostingType());
		facts.add(fact);
		MAssetChange ac = MAssetChange.get(getCtx(), assetDisp.getA_Asset_ID(), MAssetChange.CHANGETYPE_Disposal,getTrxName(), as.getC_AcctSchema_ID());
		//
		fact.createLine(null, getAccount(MAssetAcct.COLUMNNAME_A_Asset_Acct, as)
				, ac.getC_AcctSchema().getC_Currency_ID()
				, Env.ZERO, ac.getAssetValueAmt());
		fact.createLine(null, getAccount(MAssetAcct.COLUMNNAME_A_Accumdepreciation_Acct, as)
				, ac.getC_AcctSchema().getC_Currency_ID()
				, ac.getAssetAccumDepreciationAmt(), Env.ZERO);
		fact.createLine(null, getAccount(MAssetAcct.COLUMNNAME_A_Disposal_Loss_Acct, as)
				, ac.getC_AcctSchema().getC_Currency_ID()
				, ac.getAssetBookValueAmt(), Env.ZERO);
		//
		return facts;
	}
	
	private MAccount getAccount(String accountName, MAcctSchema as)
	{
		MAssetDisposed assetDisp = (MAssetDisposed)getPO();
		MAssetAcct assetAcct = MAssetAcct.forA_Asset_ID(getCtx(), as.get_ID(), assetDisp.getA_Asset_ID(), assetDisp.getPostingType(), assetDisp.getDateAcct(),null);
		int account_id = (Integer)assetAcct.get_Value(accountName);
		return MAccount.get(getCtx(), account_id);
	}

}
