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
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.Properties;

import org.adempiere.exceptions.DBException;
import org.compiere.util.Trx;
import org.compiere.util.Util;

/**
 *	Serial Number Control Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MSerNoCtl.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MSerNoCtl extends X_M_SerNoCtl
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -6746210722573475011L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_SerNoCtl_UU  UUID key
     * @param trxName Transaction
     */
    public MSerNoCtl(Properties ctx, String M_SerNoCtl_UU, String trxName) {
        super(ctx, M_SerNoCtl_UU, trxName);
		if (Util.isEmpty(M_SerNoCtl_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_SerNoCtl_ID id
	 *	@param trxName transaction
	 */
	public MSerNoCtl(Properties ctx, int M_SerNoCtl_ID, String trxName)
	{
		super(ctx, M_SerNoCtl_ID, trxName);
		if (M_SerNoCtl_ID == 0)
			setInitialDefaults();
	}	//	MSerNoCtl

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setStartNo (1);
		setCurrentNext (1);
		setIncrementNo (1);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MSerNoCtl(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MSerNoCtl

	/**
	 * 	Create new serial no.
	 * 	Increments Current Next and Commits
	 *	@return new serial no
	 */
	public String createSerNo ()
	{
		//use optimistic locking and try 3 time
		set_OptimisticLockingColumns(new String[]{COLUMNNAME_CurrentNext});
		set_UseOptimisticLocking(true);
		for(int i = 0; i < 3; i++)
		{
			this.load(get_TrxName());
			//create savepoint for rollback (if in trx)
			Trx trx = null;
			Savepoint savepoint = null;
			if (get_TrxName() != null)
				trx = Trx.get(get_TrxName(), false);
			if (trx != null) {
				try {
					savepoint = trx.setSavepoint(null);
				} catch (SQLException e) {
					throw new DBException(e);
				}
			}
			try {
				StringBuilder name = new StringBuilder();
				if (getPrefix() != null)
					name.append(getPrefix());
				int no = getCurrentNext();
				name.append(no);
				if (getSuffix() != null)
					name.append(getSuffix());
				//
				no += getIncrementNo();
				setCurrentNext(no);		
				saveEx();
				return name.toString();
			} catch (RuntimeException e) {
				if (savepoint != null) {
					try {
						trx.rollback(savepoint);
					} catch (SQLException e1) {
						throw new DBException(e1);
					}
					savepoint = null;
				}
				if (i == 2)
					throw e;
				//wait 500ms for other trx
				try {
					Thread.sleep(500);
				} catch (InterruptedException e1) {
				}
			} finally {
				if (savepoint != null) {
					try {
						trx.releaseSavepoint(savepoint);
					} catch (SQLException e) {
					}
				}
			}
		}
		//should never reach here
		return null;
	}	//	createSerNo

}	//	MSerNoCtl
