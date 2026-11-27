/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2026 iDempiere Contributors. All Rights Reserved.            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.compiere.util.DB;

/**
 * Manual Cost Detail Model ({@code M_ManualCostDetail}).
 * <p>
 * Records posted manual (non-material, charge-mapped) cost element absorptions and their
 * reversals per document line and accounting schema so reversals can restore exact
 * historical manual cost amounts and charge accounts without parsing {@code Fact_Acct}.
 * <p>
 * Sign convention for {@link #getAmt()}: positive when the Charge account is credited
 * (manual cost absorbed into COGS, Production WIP/FG, or Project WIP), negative when
 * the Charge account is debited (absorption reversed or Customer Return).
 */
public class MManualCostDetail extends X_M_ManualCostDetail
{
	private static final long serialVersionUID = -2847591038472619405L;

	/**
	 * UUID based Constructor
	 * @param ctx Context
	 * @param M_ManualCostDetail_UU UUID key
	 * @param trxName Transaction
	 */
	public MManualCostDetail(Properties ctx, String M_ManualCostDetail_UU, String trxName)
	{
		super(ctx, M_ManualCostDetail_UU, trxName);
	}

	/**
	 * Standard Constructor
	 * @param ctx Context
	 * @param M_ManualCostDetail_ID ID
	 * @param trxName Transaction
	 */
	public MManualCostDetail(Properties ctx, int M_ManualCostDetail_ID, String trxName)
	{
		super(ctx, M_ManualCostDetail_ID, trxName);
	}

	/**
	 * Load Constructor
	 * @param ctx Context
	 * @param rs ResultSet
	 * @param trxName Transaction
	 */
	public MManualCostDetail(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	/**
	 * Build an unsaved {@link MManualCostDetail} instance populated with the given values.
	 *
	 * @param ctx context
	 * @param AD_Org_ID organization ID
	 * @param C_AcctSchema_ID accounting schema ID
	 * @param AD_Table_ID source document table ID
	 * @param Record_ID source document record ID
	 * @param Line_ID source document line ID (0 if none)
	 * @param M_CostElement_ID manual cost element ID
	 * @param C_Charge_ID charge ID mapped on the cost element
	 * @param M_Product_ID product ID (0 if none)
	 * @param M_AttributeSetInstance_ID attribute set instance ID (0 if none)
	 * @param C_ValidCombination_ID charge account valid combination ID
	 * @param DateAcct accounting date
	 * @param Amt signed amount (Charge CR minus Charge DR)
	 * @param Qty document line quantity (optional)
	 * @param Description optional description
	 * @param trxName transaction name
	 * @return populated (unsaved) {@link MManualCostDetail} record
	 */
	public static MManualCostDetail build(Properties ctx, int AD_Org_ID, int C_AcctSchema_ID,
			int AD_Table_ID, int Record_ID, int Line_ID,
			int M_CostElement_ID, int C_Charge_ID,
			int M_Product_ID, int M_AttributeSetInstance_ID,
			int C_ValidCombination_ID, Timestamp DateAcct,
			BigDecimal Amt, BigDecimal Qty, String Description, String trxName)
	{
		MManualCostDetail detail = new MManualCostDetail(ctx, 0, trxName);
		detail.setAD_Org_ID(AD_Org_ID);
		detail.setC_AcctSchema_ID(C_AcctSchema_ID);
		detail.setAD_Table_ID(AD_Table_ID);
		detail.setRecord_ID(Record_ID);
		if (Line_ID > 0)
			detail.setLine_ID(Line_ID);
		detail.setM_CostElement_ID(M_CostElement_ID);
		detail.setC_Charge_ID(C_Charge_ID);
		if (M_Product_ID > 0)
			detail.setM_Product_ID(M_Product_ID);
		if (M_AttributeSetInstance_ID > 0)
			detail.setM_AttributeSetInstance_ID(M_AttributeSetInstance_ID);
		detail.setC_ValidCombination_ID(C_ValidCombination_ID);
		detail.setDateAcct(DateAcct);
		detail.setAmt(Amt);
		if (Qty != null)
			detail.setQty(Qty);
		if (Description != null)
			detail.setDescription(Description);
		return detail;
	}

	/**
	 * Create and save a {@link MManualCostDetail} record.
	 *
	 * @param ctx context
	 * @param AD_Org_ID organization ID
	 * @param C_AcctSchema_ID accounting schema ID
	 * @param AD_Table_ID source document table ID
	 * @param Record_ID source document record ID
	 * @param Line_ID source document line ID (0 if none)
	 * @param M_CostElement_ID manual cost element ID
	 * @param C_Charge_ID charge ID mapped on the cost element
	 * @param M_Product_ID product ID (0 if none)
	 * @param M_AttributeSetInstance_ID attribute set instance ID (0 if none)
	 * @param C_ValidCombination_ID charge account valid combination ID
	 * @param DateAcct accounting date
	 * @param Amt signed amount (Charge CR minus Charge DR)
	 * @param Qty document line quantity (optional)
	 * @param Description optional description
	 * @param trxName transaction name
	 * @return saved {@link MManualCostDetail} record
	 */
	public static MManualCostDetail create(Properties ctx, int AD_Org_ID, int C_AcctSchema_ID,
			int AD_Table_ID, int Record_ID, int Line_ID,
			int M_CostElement_ID, int C_Charge_ID,
			int M_Product_ID, int M_AttributeSetInstance_ID,
			int C_ValidCombination_ID, Timestamp DateAcct,
			BigDecimal Amt, BigDecimal Qty, String Description, String trxName)
	{
		MManualCostDetail detail = build(ctx, AD_Org_ID, C_AcctSchema_ID,
				AD_Table_ID, Record_ID, Line_ID,
				M_CostElement_ID, C_Charge_ID,
				M_Product_ID, M_AttributeSetInstance_ID,
				C_ValidCombination_ID, DateAcct,
				Amt, Qty, Description, trxName);
		detail.saveEx(trxName);
		return detail;
	}

	/**
	 * Retrieve all {@link MManualCostDetail} records for a document and accounting schema.
	 *
	 * @param ctx context
	 * @param C_AcctSchema_ID accounting schema ID
	 * @param AD_Table_ID source document table ID
	 * @param Record_ID source document record ID
	 * @param trxName transaction name
	 * @return list of records ordered by {@code M_ManualCostDetail_ID}
	 */
	public static List<MManualCostDetail> getByRecord(Properties ctx, int C_AcctSchema_ID,
			int AD_Table_ID, int Record_ID, String trxName)
	{
		return new Query(ctx, Table_Name,
				"C_AcctSchema_ID=? AND AD_Table_ID=? AND Record_ID=?", trxName)
				.setParameters(C_AcctSchema_ID, AD_Table_ID, Record_ID)
				.setOrderBy(COLUMNNAME_M_ManualCostDetail_ID)
				.list();
	}

	/**
	 * Retrieve all {@link MManualCostDetail} records for a document line and accounting schema.
	 *
	 * @param ctx context
	 * @param C_AcctSchema_ID accounting schema ID
	 * @param AD_Table_ID source document table ID
	 * @param Record_ID source document record ID
	 * @param Line_ID source document line ID (0 matches {@code Line_ID IS NULL})
	 * @param trxName transaction name
	 * @return list of records ordered by {@code M_ManualCostDetail_ID}
	 */
	public static List<MManualCostDetail> getByLine(Properties ctx, int C_AcctSchema_ID,
			int AD_Table_ID, int Record_ID, int Line_ID, String trxName)
	{
		if (Line_ID > 0)
		{
			return new Query(ctx, Table_Name,
					"C_AcctSchema_ID=? AND AD_Table_ID=? AND Record_ID=? AND Line_ID=?", trxName)
					.setParameters(C_AcctSchema_ID, AD_Table_ID, Record_ID, Line_ID)
					.setOrderBy(COLUMNNAME_M_ManualCostDetail_ID)
					.list();
		}
		return new Query(ctx, Table_Name,
				"C_AcctSchema_ID=? AND AD_Table_ID=? AND Record_ID=? AND Line_ID IS NULL", trxName)
				.setParameters(C_AcctSchema_ID, AD_Table_ID, Record_ID)
				.setOrderBy(COLUMNNAME_M_ManualCostDetail_ID)
				.list();
	}

	/**
	 * Check whether any {@link MManualCostDetail} records exist for a document and accounting schema.
	 *
	 * @param C_AcctSchema_ID accounting schema ID
	 * @param AD_Table_ID source document table ID
	 * @param Record_ID source document record ID
	 * @param trxName transaction name
	 * @return true if at least one record exists
	 */
	public static boolean hasForRecord(int C_AcctSchema_ID, int AD_Table_ID, int Record_ID, String trxName)
	{
		final String sql = "SELECT COUNT(*) FROM M_ManualCostDetail "
				+ "WHERE C_AcctSchema_ID=? AND AD_Table_ID=? AND Record_ID=?";
		return DB.getSQLValueEx(trxName, sql, C_AcctSchema_ID, AD_Table_ID, Record_ID) > 0;
	}

	/**
	 * Delete {@link MManualCostDetail} records for a document and accounting schema.
	 *
	 * @param AD_Table_ID source document table ID
	 * @param Record_ID source document record ID
	 * @param C_AcctSchema_ID accounting schema ID
	 * @param trxName transaction name
	 * @return number of deleted rows
	 */
	public static int delete(int AD_Table_ID, int Record_ID, int C_AcctSchema_ID, String trxName)
	{
		final String sql = "DELETE FROM M_ManualCostDetail "
				+ "WHERE AD_Table_ID=? AND Record_ID=? AND C_AcctSchema_ID=?";
		return DB.executeUpdateEx(sql, new Object[] { AD_Table_ID, Record_ID, C_AcctSchema_ID }, trxName);
	}

	/**
	 * Delete {@link MManualCostDetail} records for a document across all accounting schemas.
	 *
	 * @param AD_Table_ID source document table ID
	 * @param Record_ID source document record ID
	 * @param trxName transaction name
	 * @return number of deleted rows
	 */
	public static int delete(int AD_Table_ID, int Record_ID, String trxName)
	{
		final String sql = "DELETE FROM M_ManualCostDetail WHERE AD_Table_ID=? AND Record_ID=?";
		return DB.executeUpdateEx(sql, new Object[] { AD_Table_ID, Record_ID }, trxName);
	}

	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MManualCostDetail[")
				.append(get_ID())
				.append("-Table=").append(getAD_Table_ID())
				.append(",Record=").append(getRecord_ID())
				.append(",Line=").append(getLine_ID())
				.append(",CE=").append(getM_CostElement_ID())
				.append(",Charge=").append(getC_Charge_ID())
				.append(",Amt=").append(getAmt())
				.append("]");
		return sb.toString();
	}
}
