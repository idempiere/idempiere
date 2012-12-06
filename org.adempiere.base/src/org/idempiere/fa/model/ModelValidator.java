/**
 * 
 */
package org.idempiere.fa.model;

import java.util.List;

import org.adempiere.exceptions.FillMandatoryException;
import org.compiere.acct.Fact;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAssetAddition;
import org.compiere.model.MAssetDisposed;
import org.compiere.model.MClient;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MProduct;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.PO;
import org.compiere.model.SetGetModel;
import org.compiere.model.SetGetUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.idempiere.fa.exceptions.AssetInvoiceWithMixedLines_LRO;
import org.idempiere.fa.exceptions.AssetProductStockedException;



/**
 * Fixed Assets Model Validator
 * @author Teo_Sarca, SC ARHIPAC SERVICE SRL
 *
 */
public class ModelValidator
implements org.compiere.model.ModelValidator, org.compiere.model.FactsValidator
{
	/** Logger */
	private static CLogger log = CLogger.getCLogger(ModelValidator.class);
	/** Client */
	private int m_AD_Client_ID = -1;

	
	public int getAD_Client_ID() {
		return m_AD_Client_ID;
	}

	
	public void initialize(ModelValidationEngine engine, MClient client)
	{
		if (client != null)
		{
			m_AD_Client_ID = client.getAD_Client_ID();
		}

		engine.addModelChange(MInvoiceLine.Table_Name, this);		
		engine.addDocValidate(MInvoice.Table_Name, this);
		engine.addModelChange(MMatchInv.Table_Name, this);
		//
//		engine.addFactsValidate(MDepreciationEntry.Table_Name, this);
	}

	public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID)
	{
		return null;
	}

	public String modelChange(PO po, int type) throws Exception
	{
		if (po instanceof MMatchInv
				&& (TYPE_AFTER_NEW == type 
						|| (TYPE_AFTER_CHANGE == type && po.is_ValueChanged(MMatchInv.COLUMNNAME_Processed))))
		{
			MMatchInv mi = (MMatchInv)po;
			if (mi.isProcessed())
			{
				MInvoiceLine invoiceLine = new MInvoiceLine(mi.getCtx(), mi.getC_InvoiceLine_ID(), mi.get_TrxName());
				if (invoiceLine.isA_CreateAsset()
						&& !invoiceLine.isA_Processed()
						/* commented by @win
						&& MAssetType.isFixedAssetGroup(mi.getCtx(), invoiceLine.getA_Asset_Group_ID())
						*/
					)
				{
					MAssetAddition.createAsset(mi);
				}
			}
		}
		//
		// Invoice Line
		else if (po instanceof MInvoiceLine)
		{
			modelChange_InvoiceLine(SetGetUtil.wrap(po), type);
		}
		return null;
		
	}

	public String docValidate(PO po, int timing)
	{
			
		log.info(po.get_TableName() + " Timing: " + timing);
		String result = null;
		
		// TABLE C_Invoice
		String tableName = po.get_TableName();
		if(tableName.equals(MInvoice.Table_Name)){
			// Invoice - Validate Fixed Assets Invoice (LRO)
			if (timing==TIMING_AFTER_PREPARE)
			{
				MInvoice invoice = (MInvoice)po;
				validateFixedAssetsInvoice_LRO(invoice);
			}
			
			if(timing==TIMING_AFTER_COMPLETE){
				MInvoice mi = (MInvoice)po;
				if (mi.isSOTrx()) {
					MInvoiceLine[] mils = mi.getLines();
					for (MInvoiceLine mil: mils) {
						if (mil.isA_CreateAsset() && !mil.isA_Processed()) {
							MAssetDisposed.createAssetDisposed(mil);
						}
					}
				}
			} //end MInvoice TIMING_AFTER_COMPLETE
		}
		
		return result;
	} // docValidate
	
	/**
	 * Model Change Invoice Line
	 * @param ctx
	 * @param m model 
	 * @param changeType set when called from model validator (See TYPE_*); else -1, when called from callout
	 */
	public static void modelChange_InvoiceLine(SetGetModel m, int changeType) {
		//
		// Set Asset Related Fields:
		if (-1 == changeType || TYPE_BEFORE_NEW == changeType || TYPE_BEFORE_CHANGE == changeType) {
			int invoice_id = SetGetUtil.get_AttrValueAsInt(m, MInvoiceLine.COLUMNNAME_C_Invoice_ID);
			@SuppressWarnings("unused")
			boolean isSOTrx = DB.isSOTrx(MInvoice.Table_Name, MInvoice.COLUMNNAME_C_Invoice_ID+"="+invoice_id);
			boolean isAsset = false;
			/* comment by @win
			boolean isFixedAsset = false;
			*/
			int assetGroup_ID = 0;
			//@win commenting this out to enable relating AR Invoice to Asset Disposal
			/*
			if (!isSOTrx) {
				int product_id = SetGetUtil.get_AttrValueAsInt(m, MInvoiceLine.COLUMNNAME_M_Product_ID);
				if (product_id > 0) {
					MProduct prod = MProduct.get(m.getCtx(), product_id);
					isAsset = (prod != null && prod.get_ID() > 0 && prod.isCreateAsset());
					assetGroup_ID = prod.getA_Asset_Group_ID();
					
					//isFixedAsset = MAssetType.isFixedAssetGroup(m.getCtx(), assetGroup_ID); //commented by @win - remove asset type
					
				}
			}
			*/
			int product_id = SetGetUtil.get_AttrValueAsInt(m, MInvoiceLine.COLUMNNAME_M_Product_ID);
			if (product_id > 0) {
				MProduct prod = MProduct.get(m.getCtx(), product_id);
				isAsset = (prod != null && prod.get_ID() > 0 && prod.isCreateAsset());
				assetGroup_ID = prod.getA_Asset_Group_ID();
			}
				
			// end modification by @win
				
			m.set_AttrValue(MInvoiceLine.COLUMNNAME_A_CreateAsset, isAsset);
			if (isAsset) {
				m.set_AttrValue(MInvoiceLine.COLUMNNAME_A_Asset_Group_ID, assetGroup_ID);
				/* comment by @win
				m.set_AttrValue(MInvoiceLine.COLUMNNAME_IsFixedAssetInvoice, isFixedAsset);
				*/
				m.set_AttrValue("IsFixedAssetInvoice", isAsset);
				m.set_AttrValue(MInvoiceLine.COLUMNNAME_A_CreateAsset, "Y");
				
			}
			else {
				m.set_AttrValue(MInvoiceLine.COLUMNNAME_A_Asset_Group_ID, null);
				m.set_AttrValue(MInvoiceLine.COLUMNNAME_A_Asset_ID, null);
				m.set_AttrValue("IsFixedAssetInvoice", false);
			}
			//
			// Validate persistent object: 
			if (isAsset && (m instanceof MInvoiceLine)) {
				MInvoiceLine line = (MInvoiceLine)m;
				//
				// If is expense, then asset is mandatory
				if (MInvoiceLine.A_CAPVSEXP_Expense.equals(line.getA_CapvsExp()) && line.getA_Asset_ID() <= 0) {
					throw new FillMandatoryException(MInvoiceLine.COLUMNNAME_A_Asset_ID);
				}
				//
				// Check Amounts & Qty
				if (line.getLineNetAmt().signum() == 0) {
					throw new FillMandatoryException(MInvoiceLine.COLUMNNAME_QtyEntered, MInvoiceLine.COLUMNNAME_PriceEntered);
				}
				//
				// Check Product - fixed assets products shouldn't be stocked (but inventory objects are allowed)
				MProduct product = line.getProduct();
				if (product.isStocked() && line.get_ValueAsBoolean("IsFixedAssetInvoice")) {
					throw new AssetProductStockedException(product);
				}
			}
		}
		
		//
		// Update Invoice Header:
		if (TYPE_AFTER_NEW == changeType || TYPE_AFTER_CHANGE == changeType || TYPE_AFTER_DELETE == changeType) {
			int invoice_id = SetGetUtil.get_AttrValueAsInt(m, MInvoiceLine.COLUMNNAME_C_Invoice_ID);
			String sql =
				"UPDATE C_Invoice i SET IsFixedAssetInvoice"
						+"=(SELECT COALESCE(MAX(il.IsFixedAssetInvoice),'N')"
								+" FROM C_InvoiceLine il"
								+" WHERE il.C_Invoice_ID=i.C_Invoice_ID"
									+" AND il."+MInvoiceLine.COLUMNNAME_IsDescription+"='N'"
						+")"
				+" WHERE C_Invoice_ID=?";
			DB.executeUpdateEx(sql, new Object[]{invoice_id}, m.get_TrxName());
		}
	}
	
	/**
	 * Check if is a valid fixed asset related invoice (LRO)
	 * @param invoice
	 */
	private void validateFixedAssetsInvoice_LRO(MInvoice invoice)
	{
		if (invoice.get_ValueAsBoolean("IsFixedAssetInvoice"))
		{
			boolean hasFixedAssetLines = false;
			boolean hasNormalLines = false;
			for (MInvoiceLine line : invoice.getLines())
			{
				if (line.get_ValueAsBoolean("IsFixedAssetInvoice"))
				{
					hasFixedAssetLines = true;
				}
				else if (line.getM_Product_ID() > 0)
				{
					MProduct product = MProduct.get(line.getCtx(), line.getM_Product_ID());
					if (product.isItem())
					{
						// Only items are forbiden for FA invoices because in Romania these should use
						// V_Liability vendor account and not V_Liability_FixedAssets vendor account
						hasNormalLines = true;
					}
				}
				//
				// No mixed lines are allowed
				if (hasFixedAssetLines && hasNormalLines)
				{
					throw new AssetInvoiceWithMixedLines_LRO();
				}
			}
		}
	}

	

	
	public String factsValidate(MAcctSchema schema, List<Fact> facts, PO po) {
		// TODO: implement it
		return null;
	}
}
