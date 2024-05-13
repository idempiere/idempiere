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

import org.compiere.util.Env;
import org.compiere.util.Util;


/**
 *	Commission Line Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MCommissionLine.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MCommissionLine extends X_C_CommissionLine
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2167566875518334780L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_CommissionLine_UU  UUID key
     * @param trxName Transaction
     */
    public MCommissionLine(Properties ctx, String C_CommissionLine_UU, String trxName) {
        super(ctx, C_CommissionLine_UU, trxName);
		if (Util.isEmpty(C_CommissionLine_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_CommissionLine_ID id
	 *	@param trxName transaction
	 */
	public MCommissionLine(Properties ctx, int C_CommissionLine_ID, String trxName)
	{
		super(ctx, C_CommissionLine_ID, trxName);
		if (C_CommissionLine_ID == 0)
			setInitialDefaults();
	}	//	MCommissionLine

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setLine (0);	// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM C_CommissionLine WHERE C_Commission_ID=@C_Commission_ID@
		setAmtMultiplier (Env.ZERO);
		setAmtSubtract (Env.ZERO);
		setCommissionOrders (false);
		setIsPositiveOnly (false);
		setQtyMultiplier (Env.ZERO);
		setQtySubtract (Env.ZERO);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCommissionLine(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCommissionLine

	/**
	 * @param ctx
	 * @param C_CommissionLine_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MCommissionLine(Properties ctx, int C_CommissionLine_ID, String trxName, String... virtualColumns) {
		super(ctx, C_CommissionLine_ID, trxName, virtualColumns);
	}

}	//	MCommissionLine
