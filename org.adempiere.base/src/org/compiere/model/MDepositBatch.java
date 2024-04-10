/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Alejandro Falcone                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Alejandro Falcone (afalcone@users.sourceforge.net)                *
*                      http://www.openbiz.com.ar                      *
*                                                                     * 
* Sponsors:                                                           *
* - Idalica Inc. (http://www.idalica.com)                             *
***********************************************************************/

package org.compiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *  Deposit Batch Model
 *
 *	@author Alejandro Falcone
 *	@version $Id: MDepositBatch.java,v 1.3 2007/06/28 00:51:03 afalcone Exp $
 */
public class MDepositBatch extends X_C_DepositBatch
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7691820074981291939L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_DepositBatch_UU  UUID key
     * @param trxName Transaction
     */
    public MDepositBatch(Properties ctx, String C_DepositBatch_UU, String trxName) {
        super(ctx, C_DepositBatch_UU, trxName);
		if (Util.isEmpty(C_DepositBatch_UU))
			setInitialDefaults();
    }

	/**
	 *  Create and Load existing Persistent Object
	 *  @param ctx context
	 *  @param C_DepositBatch_ID  The unique ID of the object
	 *  @param trxName transaction name	
	 */
	public MDepositBatch (Properties ctx, int C_DepositBatch_ID, String trxName)
	{
		super (ctx, C_DepositBatch_ID, trxName);
		if (C_DepositBatch_ID == 0)
			setInitialDefaults();
	}	//	MDepositBatch
	
	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setDocStatus (DOCSTATUS_Drafted);
		setProcessed (false);
		setProcessing (false);
		setDepositAmt(Env.ZERO);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MDepositBatch (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MDepositBatch

	/**
	 * 	Create new deposit batch from original.<br/> 
	 *  Copy over ad_client_id, ad_org_id, c_depositbatch_id, description, c_doctype_id, datedoc, datedeposit and depositamt.
	 *	@param original original
	 */
	public MDepositBatch (MDepositBatch original)
	{
		this (original.getCtx(), 0, original.get_TrxName());
		setClientOrg(original);
		setC_DepositBatch_ID(original.getC_DepositBatch_ID());

		setDescription(original.getDescription());
		setC_DocType_ID(original.getC_DocType_ID());
		
		setDateDoc(original.getDateDoc());
		setDateDeposit(original.getDateDeposit());
		setDepositAmt(original.getDepositAmt());
	}	//	MDepositBatch

	/**
	 * 	Overwrite Client/Org if required
	 * 	@param AD_Client_ID client
	 * 	@param AD_Org_ID org
	 */
	@Override
	public void setClientOrg (int AD_Client_ID, int AD_Org_ID)
	{
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
	}	//	setClientOrg

	/**
	 * 	Set Date Deposit
	 *	@param DateAcct date
	 */
	public void setDateAcct (Timestamp DateAcct)
	{
		super.setDateDeposit(DateAcct);
		if (DateAcct == null)
			return;
	}	//	setDateAcct

	/**	Process Message 			*/
	private String		m_processMsg = null;

	/**
	 * 	Unlock Document.
	 * 	@return true if success
	 *  @deprecated incomplete/abandon implementation of DocAction interface 
	 */
	@Deprecated
	public boolean unlockIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("unlockIt - " + toString());
		setProcessing(false);
		return true;
	}	//	unlockIt
	
	/**
	 * 	Invalidate Document
	 * 	@return true if success 
	 *  @deprecated incomplete/abandon implementation of DocAction interface
	 */
	@Deprecated
	public boolean invalidateIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("invalidateIt - " + toString());
		return true;
	}	//	invalidateIt
	
	/**
	 * 	Void Document.
	 * 	@return false
	 *  @deprecated incomplete/abandon implementation of DocAction interface 
	 */
	@Deprecated
	public boolean voidIt()
	{
		if (log.isLoggable(Level.INFO)) log.info("voidIt - " + toString());
		// Before Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_VOID);
		if (m_processMsg != null)
			return false;
		// After Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_VOID);
		if (m_processMsg != null)
			return false;
		
		return false;
	}	//	voidIt

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MDepositBatch[");
		sb.append(get_ID()).append(",").append(getDescription())
			.append(",Amount=").append(getDepositAmt())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	/**
	 * 	Get Document Info
	 *	@return document info (untranslated)
	 *  @deprecated incomplete/abandon implementation of DocAction interface
	 */
	@Deprecated
	public String getDocumentInfo()
	{
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		return dt.getName() + " " + getDocumentNo();
	}	//	getDocumentInfo

	/**
	 * 	Create PDF
	 *	@return File or null
	 *  @deprecated incomplete/abandon implementation of DocAction interface
	 */
	@Deprecated
	public File createPDF ()
	{
		try
		{
			File temp = File.createTempFile(get_TableName()+get_ID()+"_", ".pdf");
			return createPDF (temp);
		}
		catch (Exception e)
		{
			log.severe("Could not create PDF - " + e.getMessage());
		}
		return null;
	}	//	getPDF

	/**
	 * 	Create PDF file
	 *	@param file output file
	 *	@return file if success
	 *  @deprecated incomplete/abandon implementation of DocAction interface
	 */
	@Deprecated
	public File createPDF (File file)
	{
		return null;
	}	//	createPDF

	
	/**
	 * 	Get Process Message
	 *	@return clear text error message
	 *  @deprecated incomplete/abandon implementation of DocAction interface
	 */
	@Deprecated
	public String getProcessMsg()
	{
		return m_processMsg;
	}	//	getProcessMsg
	
	/**
	 * 	Get Document Owner (Responsible)
	 *	@return AD_User_ID (Created By)
	 *  @deprecated incomplete/abandon implementation of DocAction interface
	 */
	@Deprecated
	public int getDoc_User_ID()
	{
		return getCreatedBy();
	}	//	getDoc_User_ID

	/**
	 * 	Get Document Approval Amount
	 *	@return DR amount
	 *  @deprecated incomplete/abandon implementation of DocAction interface
	 */
	@Deprecated	
	public BigDecimal getApprovalAmt()
	{
		return getDepositAmt();
	}	//	getApprovalAmt
			
	@Override
	protected boolean afterDelete (boolean success)
	{
		// Remove reference from C_Payment
		if (getC_DepositBatch_ID() != 0 )
		{
			String sql = "UPDATE C_Payment p SET C_DepositBatch_ID= 0  WHERE p.C_DepositBatch_ID=?";			
			DB.executeUpdateEx(sql, new Object[] {getC_DepositBatch_ID()}, get_TrxName());
		}
		
		return success;
	}	//	afterDelete
		
	/**
	 * 	Get Deposit Batch Lines
	 *	@return Array of lines (MDepositBatchLine)
	 */
	public MDepositBatchLine[] getLines()
	{
		ArrayList<MDepositBatchLine> list = new ArrayList<MDepositBatchLine>();
		String sql = "SELECT * FROM C_DepositBatchLine WHERE C_DepositBatch_ID=? ORDER BY Line,C_DepositBatchLine_ID";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getC_DepositBatch_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
				list.add(new MDepositBatchLine (getCtx(), rs, get_TrxName()));
		}
		catch (SQLException ex)
		{
			log.log(Level.SEVERE, sql, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		
		//
		MDepositBatchLine[] retValue = new MDepositBatchLine[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getLines

	/**
	 * 	Document Status is Complete or Closed
	 *	@return true if CO, CL or RE
	 *  @deprecated incomplete/abandon implementation of DocAction interface
	 */
	@Deprecated
	public boolean isComplete()
	{
		String ds = getDocStatus();
		return DOCSTATUS_Completed.equals(ds)
			|| DOCSTATUS_Closed.equals(ds)
			|| DOCSTATUS_Reversed.equals(ds);
	}	//	isComplete

}	//	MDepositBatch