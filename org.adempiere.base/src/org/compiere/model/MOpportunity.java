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
 * Business Opportunity model
 */
public class MOpportunity extends X_C_Opportunity {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 9052544341602655427L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_Opportunity_UU  UUID key
     * @param trxName Transaction
     */
    public MOpportunity(Properties ctx, String C_Opportunity_UU, String trxName) {
        super(ctx, C_Opportunity_UU, trxName);
    }

    /**
     * @param ctx
     * @param C_Opportunity_ID
     * @param trxName
     */
	public MOpportunity(Properties ctx, int C_Opportunity_ID, String trxName) {
		super(ctx, C_Opportunity_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MOpportunity(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * @param ctx
	 * @param C_Opportunity_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MOpportunity(Properties ctx, int C_Opportunity_ID, String trxName, String... virtualColumns) {
		super(ctx, C_Opportunity_ID, trxName, virtualColumns);
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Set OpportunityAmt to GrandTotal of order.
		if ( getC_Order_ID() > 0 )
		{
			I_C_Order order = getC_Order();
			if ( order != null )
				setOpportunityAmt(order.getGrandTotal());
		}
		return true;
	}

}