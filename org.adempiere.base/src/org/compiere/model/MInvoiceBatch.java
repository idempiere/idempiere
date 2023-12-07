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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *	Invoice Batch Header Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MInvoiceBatch.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class MInvoiceBatch extends X_C_InvoiceBatch
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 3449653049236263604L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_InvoiceBatch_UU  UUID key
     * @param trxName Transaction
     */
    public MInvoiceBatch(Properties ctx, String C_InvoiceBatch_UU, String trxName) {
        super(ctx, C_InvoiceBatch_UU, trxName);
		if (Util.isEmpty(C_InvoiceBatch_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_InvoiceBatch_ID id
	 *	@param trxName trx
	 */
	public MInvoiceBatch (Properties ctx, int C_InvoiceBatch_ID, String trxName)
	{
		super (ctx, C_InvoiceBatch_ID, trxName);
		if (C_InvoiceBatch_ID == 0)
			setInitialDefaults();
	}	//	MInvoiceBatch

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setControlAmt (Env.ZERO);	// 0
		setDateDoc (new Timestamp(System.currentTimeMillis()));	// @#Date@
		setDocumentAmt (Env.ZERO);
		setIsSOTrx (false);	// N
		setProcessed (false);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MInvoiceBatch (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MInvoiceBatch
	
	/**	The Lines						*/
	private MInvoiceBatchLine[]	m_lines	= null;
	
	/**
	 * 	Get Lines
	 *	@param reload reload data
	 *	@return array of lines
	 */
	public MInvoiceBatchLine[] getLines (boolean reload)
	{
		if (m_lines != null && !reload) {
			set_TrxName(m_lines, get_TrxName());
			return m_lines;
		}
		String sql = "SELECT * FROM C_InvoiceBatchLine WHERE C_InvoiceBatch_ID=? ORDER BY Line";
		ArrayList<MInvoiceBatchLine> list = new ArrayList<MInvoiceBatchLine>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, getC_InvoiceBatch_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				list.add (new MInvoiceBatchLine (getCtx(), rs, get_TrxName()));
			}
		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//
		m_lines = new MInvoiceBatchLine[list.size ()];
		list.toArray (m_lines);
		return m_lines;
	}	//	getLines
	
	/**
	 * 	Set Processed.
	 *  Propagate to lines.
	 *	@param processed processed
	 */
	@Override
	public void setProcessed (boolean processed)
	{
		super.setProcessed (processed);
		if (get_ID() == 0)
			return;
		StringBuilder set = new StringBuilder("SET Processed='")
			.append((processed ? "Y" : "N"))
			.append("' WHERE C_InvoiceBatch_ID=").append(getC_InvoiceBatch_ID());
		int noLine = DB.executeUpdate("UPDATE C_InvoiceBatchLine " + set, get_TrxName());
		m_lines = null;
		if (log.isLoggable(Level.FINE)) log.fine(processed + " - Lines=" + noLine);
	}	//	setProcessed
	
}	//	MInvoiceBatch
