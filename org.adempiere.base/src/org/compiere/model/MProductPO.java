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

import org.adempiere.exceptions.DBException;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *	Product Purchasing Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MProductPO.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MProductPO extends X_M_Product_PO
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1883198806060209516L;

	/**
	 * 	Get current MProductPO of Product
	 * 	@param ctx context
	 *	@param M_Product_ID product
	 *	@param trxName transaction
	 *	@return array of MProductPO - current vendor first
	 */
	public static MProductPO[] getOfProduct (Properties ctx, int M_Product_ID, String trxName)
	{
		final String whereClause = "M_Product_ID=?";
		List<MProductPO> list = new Query(ctx, Table_Name, whereClause, trxName)
									.setParameters(M_Product_ID)
									.setOnlyActiveRecords(true)
									.setOrderBy("IsCurrentVendor DESC")
									.list();
		return list.toArray(new MProductPO[list.size()]);
	}	//	getOfProduct

	/**
	 * Test whether a vendor has an active, non-discontinued approval for a product.
	 *
	 * @param ctx context
	 * @param M_Product_ID product
	 * @param C_BPartner_ID vendor
	 * @param trxName transaction
	 * @return {@code true} if the vendor is approved for the product
	 */
	public static boolean isApprovedVendor(Properties ctx, int M_Product_ID, int C_BPartner_ID, String trxName)
	{
		if (M_Product_ID <= 0 || C_BPartner_ID <= 0)
			return false;

		String whereClause = COLUMNNAME_M_Product_ID + "=? AND "
				+ COLUMNNAME_C_BPartner_ID + "=? AND " + COLUMNNAME_IsApprovedVendor + "='Y' AND COALESCE("
				+ COLUMNNAME_Discontinued + ",'N')='N'";
		return new Query(ctx, Table_Name, whereClause, trxName)
				.setParameters(M_Product_ID, C_BPartner_ID)
				.setOnlyActiveRecords(true)
				.match();
	}

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_Product_PO_UU  UUID key
     * @param trxName Transaction
     */
    public MProductPO(Properties ctx, String M_Product_PO_UU, String trxName) {
        super(ctx, M_Product_PO_UU, trxName);
		if (Util.isEmpty(M_Product_PO_UU))
			setInitialDefaults();
    }

	/**
	 * 	Persistency Constructor
	 *	@param ctx context
	 *	@param ignored ignored
	 *	@param trxName transaction
	 */
	public MProductPO (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
		else
			setInitialDefaults();
	}	//	MProduct_PO

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsApprovedVendor(false);
		setIsCurrentVendor (true);	// Y
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MProductPO(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MProductPO

	@Override
	protected boolean beforeSave(boolean newRecord) 
	{
		// Can only have one current vendor for a product
		if (isActive() && isCurrentVendor())
		{
			int cnt = DB.getSQLValue(get_TrxName(),
							"SELECT COUNT(*) FROM M_Product_PO WHERE IsActive='Y' AND IsCurrentVendor='Y' AND C_BPartner_ID!=? AND M_Product_ID=?",
							getC_BPartner_ID(), getM_Product_ID());
			if (cnt > 0) {
				log.saveError("SaveError", Msg.getMsg(getCtx(), DBException.SAVE_ERROR_NOT_UNIQUE_MSG, true) + Msg.getElement(getCtx(), COLUMNNAME_IsCurrentVendor));
				return false;
			}
		}
		
		return true;
	}

}	//	MProductPO
