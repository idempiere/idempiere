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
package org.compiere.process;

import java.math.BigDecimal;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaDefault;
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.DB;

/**
 * 	Add or Copy Acct Schema Default Accounts
 *	
 *  @author Jorg Janke
 *  @version $Id: AcctSchemaDefaultCopy.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class AcctSchemaDefaultCopy extends SvrProcess
{
	/**	Acct Schema					*/
	private int			p_C_AcctSchema_ID = 0;
	/** Copy & Overwrite			*/
	private boolean 	p_CopyOverwriteAcct = false;
	
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare ()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("C_AcctSchema_ID"))
				p_C_AcctSchema_ID = para[i].getParameterAsInt();
			else if (name.equals("CopyOverwriteAcct"))
				p_CopyOverwriteAcct = "Y".equals(para[i].getParameter());
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare
		
	/**
	 * 	Process
	 *	@return message
	 *	@throws Exception
	 */
	protected String doIt () throws Exception
	{
		log.info("C_AcctSchema_ID=" + p_C_AcctSchema_ID
			+ ", CopyOverwriteAcct=" + p_CopyOverwriteAcct);
		if (p_C_AcctSchema_ID == 0)
			throw new AdempiereSystemError("C_AcctSchema_ID=0");
		MAcctSchema as = MAcctSchema.get(getCtx(), p_C_AcctSchema_ID);
		if (as.get_ID() == 0)
			throw new AdempiereSystemError("Not Found - C_AcctSchema_ID=" + p_C_AcctSchema_ID);
		MAcctSchemaDefault acct = MAcctSchemaDefault.get (getCtx(), p_C_AcctSchema_ID);
		if (acct == null || acct.get_ID() == 0)
			throw new AdempiereSystemError("Default Not Found - C_AcctSchema_ID=" + p_C_AcctSchema_ID);
		
		StringBuilder sql;
		int updated = 0;
		int created = 0;
		int updatedTotal = 0;
		int createdTotal = 0;
		
		//	Update existing Product Category
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE M_Product_Category_Acct pa ")
				.append("SET P_Revenue_Acct=").append(acct.getP_Revenue_Acct())
				.append(", P_Expense_Acct=").append(acct.getP_Expense_Acct())
				.append(", P_CostAdjustment_Acct=").append(acct.getP_CostAdjustment_Acct())
				.append(", P_InventoryClearing_Acct=").append(acct.getP_InventoryClearing_Acct())
				.append(", P_Asset_Acct=").append(acct.getP_Asset_Acct())
				.append(", P_COGS_Acct=").append(acct.getP_COGS_Acct())
				.append(", P_PurchasePriceVariance_Acct=").append(acct.getP_PurchasePriceVariance_Acct())
				.append(", P_InvoicePriceVariance_Acct=").append(acct.getP_InvoicePriceVariance_Acct())
				.append(", P_AverageCostVariance_Acct=").append(acct.getP_AverageCostVariance_Acct())
				.append(", P_TradeDiscountRec_Acct=").append(acct.getP_TradeDiscountRec_Acct())
				.append(", P_TradeDiscountGrant_Acct=").append(acct.getP_TradeDiscountGrant_Acct())
				.append(", P_RateVariance_Acct=").append(acct.getP_RateVariance_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE pa.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM M_Product_Category p ")
					.append("WHERE p.M_Product_Category_ID=pa.M_Product_Category_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @M_Product_Category_ID@");
			updatedTotal += updated;
		}
		//	Insert new Product Category
		sql = new StringBuilder("INSERT INTO M_Product_Category_Acct ")
			.append("(M_Product_Category_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" P_Revenue_Acct, P_Expense_Acct, P_CostAdjustment_Acct, P_InventoryClearing_Acct, P_Asset_Acct, P_CoGs_Acct,")
			.append(" P_PurchasePriceVariance_Acct, P_InvoicePriceVariance_Acct, P_AverageCostVariance_Acct,")
			.append(" P_TradeDiscountRec_Acct, P_TradeDiscountGrant_Acct," )
			.append(" P_RateVariance_Acct) ")
			.append(" SELECT p.M_Product_Category_ID, acct.C_AcctSchema_ID,")
			.append(" p.AD_Client_ID, p.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.P_Revenue_Acct, acct.P_Expense_Acct, acct.P_CostAdjustment_Acct, acct.P_InventoryClearing_Acct, acct.P_Asset_Acct, acct.P_CoGs_Acct,")
			.append(" acct.P_PurchasePriceVariance_Acct, acct.P_InvoicePriceVariance_Acct, acct.P_AverageCostVariance_Acct,")
			.append(" acct.P_TradeDiscountRec_Acct, acct.P_TradeDiscountGrant_Acct,")
			.append(" acct.P_RateVariance_Acct ") 
			.append("FROM M_Product_Category p")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (p.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM M_Product_Category_Acct pa ")
				.append("WHERE pa.M_Product_Category_ID=p.M_Product_Category_ID")
				.append(" AND pa.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @M_Product_Category_ID@");
		createdTotal += created;
		if (!p_CopyOverwriteAcct)	//	Insert new Products
		{
			sql = new StringBuilder("INSERT INTO M_Product_Acct ")
				.append("(M_Product_ID, C_AcctSchema_ID,")
				.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
				.append(" P_Revenue_Acct, P_Expense_Acct, P_CostAdjustment_Acct, P_InventoryClearing_Acct, P_Asset_Acct, P_CoGs_Acct,")
				.append(" P_PurchasePriceVariance_Acct, P_InvoicePriceVariance_Acct, P_AverageCostVariance_Acct,")
				.append(" P_TradeDiscountRec_Acct, P_TradeDiscountGrant_Acct, ")
				.append(" P_RateVariance_Acct) ") 
				.append("SELECT p.M_Product_ID, acct.C_AcctSchema_ID,")
				.append(" p.AD_Client_ID, p.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
				.append(" acct.P_Revenue_Acct, acct.P_Expense_Acct, acct.P_CostAdjustment_Acct, acct.P_InventoryClearing_Acct, acct.P_Asset_Acct, acct.P_CoGs_Acct,")
				.append(" acct.P_PurchasePriceVariance_Acct, acct.P_InvoicePriceVariance_Acct, acct.P_AverageCostVariance_Acct,")
				.append(" acct.P_TradeDiscountRec_Acct, acct.P_TradeDiscountGrant_Acct,")
				.append(" acct.P_RateVariance_Acct ") 
				.append("FROM M_Product p")
				.append(" INNER JOIN M_Product_Category_Acct acct ON (acct.M_Product_Category_ID=p.M_Product_Category_ID)")
				.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND p.M_Product_Category_ID=acct.M_Product_Category_ID")
				.append(" AND NOT EXISTS (SELECT * FROM M_Product_Acct pa ")
					.append("WHERE pa.M_Product_ID=p.M_Product_ID")
					.append(" AND pa.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
			created = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(created), "@Created@ @M_Product_ID@");
			createdTotal += created;
		}
		
		
		//	Update Business Partner Group
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE C_BP_Group_Acct a ")
				.append("SET C_Receivable_Acct=").append(acct.getC_Receivable_Acct())
				.append(", C_Receivable_Services_Acct=").append(acct.getC_Receivable_Services_Acct())
				.append(", C_Prepayment_Acct=").append(acct.getC_Prepayment_Acct())
				.append(", V_Liability_Acct=").append(acct.getV_Liability_Acct())
				.append(", V_Liability_Services_Acct=").append(acct.getV_Liability_Services_Acct())
				.append(", V_Prepayment_Acct=").append(acct.getV_Prepayment_Acct())
				.append(", PayDiscount_Exp_Acct=").append(acct.getPayDiscount_Exp_Acct())
				.append(", PayDiscount_Rev_Acct=").append(acct.getPayDiscount_Rev_Acct())
				.append(", WriteOff_Acct=").append(acct.getWriteOff_Acct())
				.append(", NotInvoicedReceipts_Acct=").append(acct.getNotInvoicedReceipts_Acct())
				.append(", UnEarnedRevenue_Acct=").append(acct.getUnEarnedRevenue_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM C_BP_Group_Acct x ")
					.append("WHERE x.C_BP_Group_ID=a.C_BP_Group_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @C_BP_Group_ID@");
			updatedTotal += updated;
		}
		// Insert Business Partner Group
		sql = new StringBuilder("INSERT INTO C_BP_Group_Acct ")
			.append("(C_BP_Group_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" C_Receivable_Acct, C_Receivable_Services_Acct, C_PrePayment_Acct,")
			.append(" V_Liability_Acct, V_Liability_Services_Acct, V_PrePayment_Acct,")
			.append(" PayDiscount_Exp_Acct, PayDiscount_Rev_Acct, WriteOff_Acct,")
			.append(" NotInvoicedReceipts_Acct, UnEarnedRevenue_Acct) ")
			.append("SELECT x.C_BP_Group_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.C_Receivable_Acct, acct.C_Receivable_Services_Acct, acct.C_PrePayment_Acct,")
			.append(" acct.V_Liability_Acct, acct.V_Liability_Services_Acct, acct.V_PrePayment_Acct,")
			.append(" acct.PayDiscount_Exp_Acct, acct.PayDiscount_Rev_Acct, acct.WriteOff_Acct,")
			.append(" acct.NotInvoicedReceipts_Acct, acct.UnEarnedRevenue_Acct ")
			.append("FROM C_BP_Group x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM C_BP_Group_Acct a ")
				.append("WHERE a.C_BP_Group_ID=x.C_BP_Group_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @C_BP_Group_ID@");
		createdTotal += created;

//IDEMPIERE-362 Hide things that don't work on iDempiere		
		//	Update Business Partner - Employee
		/*
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE C_BP_Employee_Acct a ")
				.append("SET E_Expense_Acct=").append(acct.getE_Expense_Acct())
				.append(", E_Prepayment_Acct=").append(acct.getE_Prepayment_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM C_BP_Employee_Acct x ")
					.append("WHERE x.C_BPartner_ID=a.C_BPartner_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @C_BPartner_ID@ @IsEmployee@");
			updatedTotal += updated;
		}
		//	Insert new Business Partner - Employee
		sql = new StringBuilder("INSERT INTO C_BP_Employee_Acct ")
			.append("(C_BPartner_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" E_Expense_Acct, E_Prepayment_Acct) ")
			.append("SELECT x.C_BPartner_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.E_Expense_Acct, acct.E_Prepayment_Acct ")
			.append("FROM C_BPartner x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM C_BP_Employee_Acct a ")
				.append("WHERE a.C_BPartner_ID=x.C_BPartner_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @C_BPartner_ID@ @IsEmployee@");
		createdTotal += created;
		*/
		//
		if (!p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("INSERT INTO C_BP_Customer_Acct ")
				.append("(C_BPartner_ID, C_AcctSchema_ID,")
				.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
				.append(" C_Receivable_Acct, C_Receivable_Services_Acct, C_PrePayment_Acct) ")
				.append("SELECT p.C_BPartner_ID, acct.C_AcctSchema_ID,")
				.append(" p.AD_Client_ID, p.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
				.append(" acct.C_Receivable_Acct, acct.C_Receivable_Services_Acct, acct.C_PrePayment_Acct ")
				.append("FROM C_BPartner p")
				.append(" INNER JOIN C_BP_Group_Acct acct ON (acct.C_BP_Group_ID=p.C_BP_Group_ID)")
				.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)			//	#
				.append(" AND p.C_BP_Group_ID=acct.C_BP_Group_ID")
				.append(" AND NOT EXISTS (SELECT * FROM C_BP_Customer_Acct ca ")
					.append("WHERE ca.C_BPartner_ID=p.C_BPartner_ID")
					.append(" AND ca.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
			created = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(created), "@Created@ @C_BPartner_ID@ @IsCustomer@");
			createdTotal += created;
			//
			sql = new StringBuilder("INSERT INTO C_BP_Vendor_Acct ")
				.append("(C_BPartner_ID, C_AcctSchema_ID,")
				.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
				.append(" V_Liability_Acct, V_Liability_Services_Acct, V_PrePayment_Acct) ")
				.append("SELECT p.C_BPartner_ID, acct.C_AcctSchema_ID,")
				.append(" p.AD_Client_ID, p.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
				.append(" acct.V_Liability_Acct, acct.V_Liability_Services_Acct, acct.V_PrePayment_Acct ")
				.append("FROM C_BPartner p")
				.append(" INNER JOIN C_BP_Group_Acct acct ON (acct.C_BP_Group_ID=p.C_BP_Group_ID)")
				.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)			//	#
				.append(" AND p.C_BP_Group_ID=acct.C_BP_Group_ID")
				.append(" AND NOT EXISTS (SELECT * FROM C_BP_Vendor_Acct va ")
					.append("WHERE va.C_BPartner_ID=p.C_BPartner_ID AND va.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
			created = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(created), "@Created@ @C_BPartner_ID@ @IsVendor@");
			createdTotal += created;
		}
//IDEMPIERE-362 Hide things that don't work on iDempiere
		//	Update Warehouse
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE M_Warehouse_Acct a ")
				.append("SET W_Differences_Acct=").append(acct.getW_Differences_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM M_Warehouse_Acct x ")
					.append("WHERE x.M_Warehouse_ID=a.M_Warehouse_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @M_Warehouse_ID@");
			updatedTotal += updated;
		}
		//	Insert new Warehouse
		sql = new StringBuilder("INSERT INTO M_Warehouse_Acct ")
			.append("(M_Warehouse_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" W_Differences_Acct) ")
			.append("SELECT x.M_Warehouse_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.W_Differences_Acct ")
			.append("FROM M_Warehouse x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM M_Warehouse_Acct a ")
				.append("WHERE a.M_Warehouse_ID=x.M_Warehouse_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @M_Warehouse_ID@");
		createdTotal += created;


		//	Update Project
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE C_Project_Acct a ")
				.append("SET PJ_Asset_Acct=").append(acct.getPJ_Asset_Acct())
				.append(", PJ_WIP_Acct=").append(acct.getPJ_Asset_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM C_Project_Acct x ")
					.append("WHERE x.C_Project_ID=a.C_Project_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @C_Project_ID@");
			updatedTotal += updated;
		}
		//	Insert new Projects
		sql = new StringBuilder("INSERT INTO C_Project_Acct ")
			.append("(C_Project_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" PJ_Asset_Acct, PJ_WIP_Acct) ")
			.append("SELECT x.C_Project_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.PJ_Asset_Acct, acct.PJ_WIP_Acct ")
			.append("FROM C_Project x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM C_Project_Acct a ")
				.append("WHERE a.C_Project_ID=x.C_Project_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @C_Project_ID@");
		createdTotal += created;

//IDEMPIERE-362 Hide things that don't work on iDempiere
		//	Update Tax
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE C_Tax_Acct a ")
				.append("SET T_Due_Acct=").append(acct.getT_Due_Acct())
				.append(", T_Credit_Acct=").append(acct.getT_Credit_Acct())
				.append(", T_Expense_Acct=").append(acct.getT_Expense_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM C_Tax_Acct x ")
					.append("WHERE x.C_Tax_ID=a.C_Tax_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @C_Tax_ID@");
			updatedTotal += updated;
		}
		//	Insert new Tax
		sql = new StringBuilder("INSERT INTO C_Tax_Acct ")
			.append("(C_Tax_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" T_Due_Acct, T_Credit_Acct, T_Expense_Acct) ")
			.append("SELECT x.C_Tax_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.T_Due_Acct, acct.T_Credit_Acct, acct.T_Expense_Acct ")
			.append("FROM C_Tax x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM C_Tax_Acct a ")
				.append("WHERE a.C_Tax_ID=x.C_Tax_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @C_Tax_ID@");
		createdTotal += created;


		//	Update BankAccount
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE C_BankAccount_Acct a ")
				.append("SET B_InTransit_Acct=").append(acct.getB_InTransit_Acct())
				.append(", B_Asset_Acct=").append(acct.getB_Asset_Acct())
				.append(", B_InterestRev_Acct=").append(acct.getB_InterestRev_Acct())
				.append(", B_InterestExp_Acct=").append(acct.getB_InterestExp_Acct())
				.append(", B_UnallocatedCash_Acct=").append(acct.getB_UnallocatedCash_Acct())
				.append(", B_PaymentSelect_Acct=").append(acct.getB_PaymentSelect_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM C_BankAccount_Acct x ")
					.append("WHERE x.C_BankAccount_ID=a.C_BankAccount_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @C_BankAccount_ID@");
			updatedTotal += updated;
		}
		//	Insert new BankAccount
		sql = new StringBuilder("INSERT INTO C_BankAccount_Acct ")
			.append("(C_BankAccount_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" B_InTransit_Acct, B_Asset_Acct, B_InterestRev_Acct, B_InterestExp_Acct,")
			.append(" B_UnallocatedCash_Acct, B_PaymentSelect_Acct) ")
			.append("SELECT x.C_BankAccount_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.B_InTransit_Acct, acct.B_Asset_Acct, acct.B_InterestRev_Acct, acct.B_InterestExp_Acct,")
			.append(" acct.B_UnallocatedCash_Acct, acct.B_PaymentSelect_Acct ")
			.append("FROM C_BankAccount x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM C_BankAccount_Acct a ")
				.append("WHERE a.C_BankAccount_ID=x.C_BankAccount_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @C_BankAccount_ID@");
		createdTotal += created;

//IDEMPIERE-362 Hide things that don't work on iDempiere
		//	Update Withholding
		/*
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE C_Withholding_Acct a ")
				.append("SET Withholding_Acct=").append(acct.getWithholding_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID) 
				.append(" AND EXISTS (SELECT * FROM C_Withholding_Acct x ")
					.append("WHERE x.C_Withholding_ID=a.C_Withholding_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @C_Withholding_ID@");
			updatedTotal += updated;
		}
		//	Insert new Withholding
		sql = new StringBuilder("INSERT INTO C_Withholding_Acct ")
			.append("(C_Withholding_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append("	Withholding_Acct) ")
			.append("SELECT x.C_Withholding_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.Withholding_Acct ")
			.append("FROM C_Withholding x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM C_Withholding_Acct a ")
				.append("WHERE a.C_Withholding_ID=x.C_Withholding_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @C_Withholding_ID@");
		createdTotal += created;
		*/
		
		//	Update Charge
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE C_Charge_Acct a ")
				.append("SET Ch_Expense_Acct=").append(acct.getCh_Expense_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM C_Charge_Acct x ")
					.append("WHERE x.C_Charge_ID=a.C_Charge_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @C_Charge_ID@");
			updatedTotal += updated;
		}
		//	Insert new Charge
		sql = new StringBuilder("INSERT INTO C_Charge_Acct ")
			.append("(C_Charge_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" Ch_Expense_Acct) ")
			.append("SELECT x.C_Charge_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.Ch_Expense_Acct ")
			.append("FROM C_Charge x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM C_Charge_Acct a ")
				.append("WHERE a.C_Charge_ID=x.C_Charge_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @C_Charge_ID@");
		createdTotal += created;


		//	Update Cashbook
		if (p_CopyOverwriteAcct)
		{
			sql = new StringBuilder("UPDATE C_Cashbook_Acct a ")
				.append("SET CB_Asset_Acct=").append(acct.getCB_Asset_Acct())
				.append(", CB_Differences_Acct=").append(acct.getCB_Differences_Acct())
				.append(", CB_CashTransfer_Acct=").append(acct.getCB_CashTransfer_Acct())
				.append(", CB_Expense_Acct=").append(acct.getCB_Expense_Acct())
				.append(", CB_Receipt_Acct=").append(acct.getCB_Receipt_Acct())
				.append(", Updated=SysDate, UpdatedBy=0 ")
				.append("WHERE a.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
				.append(" AND EXISTS (SELECT * FROM C_Cashbook_Acct x ")
					.append("WHERE x.C_Cashbook_ID=a.C_Cashbook_ID)");
			updated = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(updated), "@Updated@ @C_Cashbook_ID@");
			updatedTotal += updated;
		}
		//	Insert new Cashbook
		sql = new StringBuilder("INSERT INTO C_Cashbook_Acct ")
			.append("(C_Cashbook_ID, C_AcctSchema_ID,")
			.append(" AD_Client_ID, AD_Org_ID, IsActive, Created, CreatedBy, Updated, UpdatedBy,")
			.append(" CB_Asset_Acct, CB_Differences_Acct, CB_CashTransfer_Acct,")
			.append(" CB_Expense_Acct, CB_Receipt_Acct) ")
			.append("SELECT x.C_Cashbook_ID, acct.C_AcctSchema_ID,")
			.append(" x.AD_Client_ID, x.AD_Org_ID, 'Y', SysDate, 0, SysDate, 0,")
			.append(" acct.CB_Asset_Acct, acct.CB_Differences_Acct, acct.CB_CashTransfer_Acct,")
			.append(" acct.CB_Expense_Acct, acct.CB_Receipt_Acct ")
			.append("FROM C_Cashbook x")
			.append(" INNER JOIN C_AcctSchema_Default acct ON (x.AD_Client_ID=acct.AD_Client_ID) ")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND NOT EXISTS (SELECT * FROM C_Cashbook_Acct a ")
				.append("WHERE a.C_Cashbook_ID=x.C_Cashbook_ID")
				.append(" AND a.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@ @C_Cashbook_ID@");
		createdTotal += created;
		
		StringBuilder msgreturn = new StringBuilder("@Created@=").append(createdTotal).append(", @Updated@=").append(updatedTotal);
		return msgreturn.toString();
	}	//	doIt
	
}	//	AcctSchemaDefaultCopy
