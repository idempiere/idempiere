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

/**
 *	Expense Type Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MExpenseType.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MExpenseType extends X_S_ExpenseType
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -5721855125106737886L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param S_ExpenseType_UU  UUID key
     * @param trxName Transaction
     */
    public MExpenseType(Properties ctx, String S_ExpenseType_UU, String trxName) {
        super(ctx, S_ExpenseType_UU, trxName);
    }

	/**
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param S_ExpenseType_ID id
	 *	@param trxName transaction
	 */
	public MExpenseType (Properties ctx, int S_ExpenseType_ID, String trxName)
	{
		super (ctx, S_ExpenseType_ID, trxName);
	}	//	MExpenseType

	/**
	 * 	MExpenseType
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MExpenseType (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MExpenseType
	
	/** Cached Product			*/
	private MProduct	m_product = null;
	
	/**
	 * 	Get Product
	 *	@return first product that uses this expense type
	 */
	public MProduct getProduct()
	{
		if (m_product == null)
		{
			StringBuilder msgmp = new StringBuilder("S_ExpenseType_ID=").append(getS_ExpenseType_ID());
			MProduct[] products = MProduct.get(getCtx(), msgmp.toString(), get_TrxName());
			if (products.length > 0)
				m_product = products[0];
		}
		return m_product;
	}	//	getProduct
		
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		// Create new expense product for new record.
		if (newRecord)
		{
			if (getValue() == null || getValue().length() == 0)
				setValue(getName());
			m_product = new MProduct(this);
			return m_product.save(get_TrxName());
		}
		return true;
	}	//	beforeSave
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
				
		MProduct prod = getProduct();
		if (prod.setExpenseType(this))
			prod.saveEx(get_TrxName());
		
		return success;
	}	//	afterSave
		
}	//	MExpenseType
