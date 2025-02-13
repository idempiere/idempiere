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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Discount Schema Break Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MDiscountSchemaBreak.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 * 
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 2012439 ] DiscountSchemaBreak: setting product and category is allowed
 */
public class MDiscountSchemaBreak extends X_M_DiscountSchemaBreak implements ImmutablePOSupport
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -5405425697628869517L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_DiscountSchemaBreak_UU  UUID key
     * @param trxName Transaction
     */
    public MDiscountSchemaBreak(Properties ctx, String M_DiscountSchemaBreak_UU, String trxName) {
        super(ctx, M_DiscountSchemaBreak_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_DiscountSchemaBreak_ID id
	 *	@param trxName transaction
	 */
	public MDiscountSchemaBreak (Properties ctx, int M_DiscountSchemaBreak_ID, String trxName)
	{
		super (ctx, M_DiscountSchemaBreak_ID, trxName);
	}	//	MDiscountSchemaBreak

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MDiscountSchemaBreak (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MDiscountSchemaBreak

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MDiscountSchemaBreak(MDiscountSchemaBreak copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MDiscountSchemaBreak(Properties ctx, MDiscountSchemaBreak copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MDiscountSchemaBreak(Properties ctx, MDiscountSchemaBreak copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Check if criteria apply
	 *	@param Value amt or qty
	 *	@param M_Product_ID product
	 *	@param M_Product_Category_ID category
	 *	@return true if criteria is applicable for this break record
	 */
	public boolean applies (BigDecimal Value, int M_Product_ID, int M_Product_Category_ID)
	{
		if (!isActive())
			return false;
		
		//	below break value
		if (Value.compareTo(getBreakValue()) < 0)
			return false;
		
		//	No Product / Category 
		if (getM_Product_ID() == 0 
			&& getM_Product_Category_ID() == 0)
			return true;
		
		//	Product
		if (getM_Product_ID() == M_Product_ID)
			return true;
		
		//	Category
		if (M_Product_Category_ID != 0)
			return getM_Product_Category_ID() == M_Product_Category_ID;

		//	Look up Category of Product
		return MProductCategory.isCategory(getM_Product_Category_ID(), M_Product_ID);
	}	//	applies
	
	@Override
	protected boolean beforeSave(boolean newRecord) {
		// If both M_Product_ID and M_Product_Category_ID is set, reset M_Product_Category_ID to 0 
		if (getM_Product_ID() > 0 && getM_Product_Category_ID() > 0)
			setM_Product_Category_ID(I_ZERO);
		//
		return true;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MDiscountSchemaBreak[");
		sb.append(get_ID()).append("-Seq=").append(getSeqNo());
		if (getM_Product_Category_ID() != 0)
			sb.append(",M_Product_Category_ID=").append(getM_Product_Category_ID());
		if (getM_Product_ID() != 0)
			sb.append(",M_Product_ID=").append(getM_Product_ID());
		sb.append(",Break=").append(getBreakValue());
		if (isBPartnerFlatDiscount())
		{
			sb.append(",FlatDiscount");
		}
		else
		{
			sb.append(",Discount=").append(getBreakDiscount());
			sb.append(",FixedPrice=").append(getFixedPrice());
		}
		sb.append ("]");
		return sb.toString ();
	}	//	toString

	@Override
	public MDiscountSchemaBreak markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MDiscountSchemaBreak
