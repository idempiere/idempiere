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
import org.compiere.util.AdempiereSystemError;
import org.compiere.util.DB;

/**
 * 	Copy Product Catergory Default Accounts
 *	
 *  @author Jorg Janke
 *  @version $Id: ProductCategoryAcctCopy.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class ProductCategoryAcctCopy extends SvrProcess
{
	/** Product Categpory			*/
	private int 		p_M_Product_Category_ID = 0;
	/**	Acct Schema					*/
	private int			p_C_AcctSchema_ID = 0;


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
			else if (name.equals("M_Product_Category_ID"))
				p_M_Product_Category_ID = para[i].getParameterAsInt();
			else if (name.equals("C_AcctSchema_ID"))
				p_C_AcctSchema_ID = para[i].getParameterAsInt();
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
		log.info("C_AcctSchema_ID=" + p_C_AcctSchema_ID);
		if (p_C_AcctSchema_ID == 0)
			throw new AdempiereSystemError("C_AcctSchema_ID=0");
		MAcctSchema as = MAcctSchema.get(getCtx(), p_C_AcctSchema_ID);
		if (as.get_ID() == 0)
			throw new AdempiereSystemError("Not Found - C_AcctSchema_ID=" + p_C_AcctSchema_ID);

		//	Update
		StringBuilder sql = new StringBuilder("UPDATE M_Product_Acct pa ")
			.append("SET (P_Revenue_Acct,P_Expense_Acct,P_CostAdjustment_Acct,P_InventoryClearing_Acct,P_Asset_Acct,P_COGS_Acct,")
			.append(" P_PurchasePriceVariance_Acct,P_InvoicePriceVariance_Acct,P_AverageCostVariance_Acct,")
			.append(" P_TradeDiscountRec_Acct,P_TradeDiscountGrant_Acct,") 
			.append(" P_RateVariance_Acct)=")
		    .append(" (SELECT P_Revenue_Acct,P_Expense_Acct,P_CostAdjustment_Acct,P_InventoryClearing_Acct,P_Asset_Acct,P_COGS_Acct,")
			.append(" P_PurchasePriceVariance_Acct,P_InvoicePriceVariance_Acct,P_AverageCostVariance_Acct,")
			.append(" P_TradeDiscountRec_Acct,P_TradeDiscountGrant_Acct,")
			.append(" P_RateVariance_Acct")
			.append(" FROM M_Product_Category_Acct pca")
			.append(" WHERE pca.M_Product_Category_ID=").append(p_M_Product_Category_ID)
			.append(" AND pca.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append("), Updated=SysDate, UpdatedBy=0 ")
			.append("WHERE pa.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)
			.append(" AND EXISTS (SELECT * FROM M_Product p ")
			.append("WHERE p.M_Product_ID=pa.M_Product_ID")
			.append(" AND p.M_Product_Category_ID=").append(p_M_Product_Category_ID).append(")");
		int updated = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(updated), "@Updated@");

		//	Insert new Products
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
			.append(" acct.P_TradeDiscountRec_Acct, acct.P_TradeDiscountGrant_Acct, ")
			.append(" acct.P_RateVariance_Acct ")
			.append("FROM M_Product p")
			.append(" INNER JOIN M_Product_Category_Acct acct ON (acct.M_Product_Category_ID=p.M_Product_Category_ID)")
			.append("WHERE acct.C_AcctSchema_ID=").append(p_C_AcctSchema_ID)			//	#
			.append(" AND p.M_Product_Category_ID=").append(p_M_Product_Category_ID)	//	#
			.append(" AND NOT EXISTS (SELECT * FROM M_Product_Acct pa ")
				.append("WHERE pa.M_Product_ID=p.M_Product_ID")
				.append(" AND pa.C_AcctSchema_ID=acct.C_AcctSchema_ID)");
		int created = DB.executeUpdate(sql.toString(), get_TrxName());
		addLog(0, null, new BigDecimal(created), "@Created@");

		StringBuilder msgreturn = new StringBuilder("@Created@=").append(created).append(", @Updated@=").append(updated);
		return msgreturn.toString();
	}	//	doIt
	
}	//	ProductCategoryAcctCopy
