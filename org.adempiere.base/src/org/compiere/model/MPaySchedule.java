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
import java.util.logging.Level;

import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *	Payment Term Schedule Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MPaySchedule.java,v 1.3 2006/07/30 00:51:04 jjanke Exp $
 */
public class MPaySchedule extends X_C_PaySchedule
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7773501661681911294L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_PaySchedule_UU  UUID key
     * @param trxName Transaction
     */
    public MPaySchedule(Properties ctx, String C_PaySchedule_UU, String trxName) {
        super(ctx, C_PaySchedule_UU, trxName);
		if (Util.isEmpty(C_PaySchedule_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_PaySchedule_ID id
	 *	@param trxName transaction
	 */
	public MPaySchedule(Properties ctx, int C_PaySchedule_ID, String trxName)
	{
		super(ctx, C_PaySchedule_ID, trxName);
		if (C_PaySchedule_ID == 0)
			setInitialDefaults();
	}	//	MPaySchedule

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setPercentage (Env.ZERO);
		setDiscount (Env.ZERO);
		setDiscountDays (0);
		setGraceDays (0);
		setNetDays (0);
		setIsValid (false);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPaySchedule(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPaySchedule

	/**	Parent					*/
	public MPaymentTerm		m_parent = null;
	
	/**
	 * @return MPaymentTerm
	 */
	public MPaymentTerm getParent ()
	{
		if (m_parent == null)
			m_parent = new MPaymentTerm (getCtx(), getC_PaymentTerm_ID(), get_TrxName());
		return m_parent;
	}	//	getParent
	
	/**
	 * @param parent The parent to set.
	 */
	public void setParent (MPaymentTerm parent)
	{
		m_parent = parent;
	}	//	setParent
	
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		// Reset IsValid to false after change of Percentage or IsActive field
		if (is_ValueChanged("Percentage") || is_ValueChanged("IsActive"))
		{
			if (log.isLoggable(Level.FINE)) log.fine("beforeSave");
			setIsValid(false);
		}
		return true;
	}	//	beforeSave

	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		// Validate payment term for new record or after change of Percentage/IsActive
		if (newRecord || is_ValueChanged("Percentage") || is_ValueChanged("IsActive"))
		{
			if (log.isLoggable(Level.FINE)) log.fine("afterSave");
			// Load m_parent
			getParent();
			m_parent.validate();
			m_parent.saveEx();
		}
		return success;
	}	//	afterSave

	@Override
	protected boolean afterDelete(boolean success) {
		if (!success)
			return false;
		// Load m_parent and validate schedule
		getParent();
		m_parent.validate();
		m_parent.saveEx();
		return true;
	}
		
}	//	MPaySchedule
