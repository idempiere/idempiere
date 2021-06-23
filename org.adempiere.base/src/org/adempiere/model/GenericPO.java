/*******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution * Copyright (C)
 * 1999-2006 Adempiere, Inc. All Rights Reserved. * This program is free
 * software; you can redistribute it and/or modify it * under the terms version
 * 2 of the GNU General Public License as published * by the Free Software
 * Foundation. This program is distributed in the hope * that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied * warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. * See the GNU General
 * Public License for more details. * You should have received a copy of the GNU
 * General Public License along * with this program; if not, write to the Free
 * Software Foundation, Inc., * 59 Temple Place, Suite 330, Boston, MA
 * 02111-1307 USA. *
 * 
 * Copyright (C) 2004 Marco LOMBARDO. lombardo@mayking.com 
 * Contributor(s): Low Heng Sin hengsin@avantz.com
 * __________________________________________
 ******************************************************************************/

// ----------------------------------------------------------------------
// Generic PO.
package org.adempiere.model;

import java.io.File;
import java.math.BigDecimal;
// import for GenericPO
import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.process.DocAction;

/**
 * Generic PO implementation, this can be use together with ModelValidator as alternative to the classic 
 * generated model class and extend ( X_ & M_ ) approach.
 * 
 * Originally for used to insert/update data from adempieredata.xml file in 2pack.
 * @author Marco LOMBARDO
 * @contributor Low Heng Sin
 */
public class GenericPO extends PO implements DocAction {	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3180937588404433030L;
	
	private DocActionDelegate<GenericPO> docActionDelegate = new DocActionDelegate<>(this);
	
	/**
	 * @param tableName
	 * @param ctx
	 * @param ID
	 */
	public GenericPO(String tableName, Properties ctx, int ID) {
		super(new PropertiesWrapper(ctx, tableName), ID, null, null);
	}

	/**
	 * @param tableName
	 * @param ctx
	 * @param rs
	 */
	public GenericPO(String tableName, Properties ctx, ResultSet rs) {
		super(new PropertiesWrapper(ctx, tableName), 0, null, rs);
	}

	/**
	 * @param tableName
	 * @param ctx
	 * @param ID
	 * @param trxName
	 */
	public GenericPO(String tableName, Properties ctx, int ID, String trxName) {
		super(new PropertiesWrapper(ctx, tableName), ID, trxName, null);
	}

	/**
	 * @param tableName
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public GenericPO(String tableName, Properties ctx, ResultSet rs, String trxName) {
		super(new PropertiesWrapper(ctx, tableName), 0, trxName, rs);
	}

	/**
	 * We must not use variable initializer here since the 2 variable below will be initialize inside
	 * the initPO method called by the parent constructor.  
	 */
	private int tableID;	
	private String tableName;

	/** Load Meta Data */
	protected POInfo initPO(Properties ctx) {
		PropertiesWrapper wrapper = (PropertiesWrapper)ctx;
		p_ctx = wrapper.source;
		tableName = wrapper.tableName;
		tableID = MTable.getTable_ID(tableName, this.get_TrxName());
		// log.info("Table_ID: "+Table_ID);
		POInfo poi = POInfo.getPOInfo(ctx, tableID, this.get_TrxName());
		return poi;
	}

	public String toString() {
		StringBuilder sb = new StringBuilder("GenericPO[Table=").append(
				"" + tableID + ",ID=").append(get_ID()).append("]");
		return sb.toString();
	}

	public static final int AD_ORGTRX_ID_AD_Reference_ID = 130;

	/**
	 * Set Trx Organization. Performing or initiating organization
	 */
	public void setAD_OrgTrx_ID(int AD_OrgTrx_ID) {
		if (AD_OrgTrx_ID == 0)
			set_Value("AD_OrgTrx_ID", null);
		else
			set_Value("AD_OrgTrx_ID", Integer.valueOf(AD_OrgTrx_ID));
	}

	/**
	 * Get Trx Organization. Performing or initiating organization
	 */
	public int getAD_OrgTrx_ID() {
		Integer ii = (Integer) get_Value("AD_OrgTrx_ID");
		if (ii == null)
			return 0;
		return ii.intValue();
	}

	@Override
	protected int get_AccessLevel() {
		return Integer.parseInt(p_info.getAccessLevel());
	}



	/* METHODS TO USE GenericPO in Documents */

	/**
	 * Set Document Status.
	 *	@param DocStatus The current status of the document
	 */
	@Override
	public void setDocStatus(String DocStatus) {
		docActionDelegate.setDocStatus(DocStatus);
	}

	/**
	 * Get Document Status.
	 * @return The current status of the document
	 */
	@Override
	public String getDocStatus() {
		return docActionDelegate.getDocStatus();
	}

	/**************************************************************************
	 * 	Process document
	 *	@param processAction document action
	 *	@return true if performed
	 */
	@Override
	public boolean processIt (String processAction) {
		return docActionDelegate.processIt(processAction);
	}	//	process

	/**
	 * 	Unlock Document.
	 * 	@return true if success
	 */
	@Override
	public boolean unlockIt()
	{
		return docActionDelegate.unlockIt();
	}	//	unlockIt

	/**
	 * Get Document Action.
	 * @return The targeted status of the document
	 */
	@Override
	public String getDocAction() {
		return docActionDelegate.getDocAction();
	}

	/**
	 * 	Invalidate Document
	 * 	@return true if success
	 */
	@Override
	public boolean invalidateIt()
	{
		return docActionDelegate.invalidateIt();
	}	//	invalidateIt

	/**
	 *	Prepare Document
	 * 	@return new status (In Progress or Invalid)
	 */
	@Override
	public String prepareIt() {
		return docActionDelegate.prepareIt();
	}	//	prepareIt

	/**
	 * 	Approve Document
	 * 	@return true if success
	 */
	@Override
	public boolean approveIt() {
		return docActionDelegate.approveIt();
	}	//	approveIt

	/**
	 * 	Reject Approval
	 * 	@return true if success
	 */
	@Override
	public boolean rejectIt() {
		return docActionDelegate.rejectIt();
	}	//	rejectIt

	/**
	 * 	Complete Document
	 * 	@return new status (Complete, In Progress, Invalid, Waiting ..)
	 */
	@Override
	public String completeIt() {
		return docActionDelegate.completeIt();
	}	//	completeIt

	/**
	 * 	Void Document.
	 * 	@return true if success
	 */
	@Override
	public boolean voidIt()
	{
		return docActionDelegate.voidIt();
	}	//	voidIt

	/**
	 * 	Close Document.
	 * 	@return true if success
	 */
	@Override
	public boolean closeIt()
	{
		return docActionDelegate.closeIt();
	}	//	closeIt

	/**
	 * 	Reverse Correction - same date
	 * 	@return true if success
	 */
	@Override
	public boolean reverseCorrectIt()
	{
		return docActionDelegate.reverseCorrectIt();
	}	//	reverseCorrectIt

	/**
	 * 	Reverse Accrual - none
	 * 	@return false
	 */
	@Override
	public boolean reverseAccrualIt()
	{
		return docActionDelegate.reverseAccrualIt();
	}	//	reverseAccrualIt

	/**
	 * 	Re-activate.
	 * 	@return true if success 
	 */
	@Override
	public boolean reActivateIt()
	{
		return docActionDelegate.reActivateIt();
	}	//	reActivateIt

	/*************************************************************************
	 * 	Get Summary
	 *	@return Summary of Document
	 */
	@Override
	public String getSummary() {
		return docActionDelegate.getSummary();
	}	//	getSummary

	@Override
	public String getDocumentNo() {
		return docActionDelegate.getDocumentNo();
	}

	/**
	 * 	Get Document Info
	 *	@return document info (untranslated)
	 */
	@Override
	public String getDocumentInfo() {
		return docActionDelegate.getDocumentInfo();
	}	//	getDocumentInfo

	@Override
	public File createPDF() {
		return docActionDelegate.createPDF();
	}

	/**
	 * 	Get Process Message
	 *	@return clear text error message
	 */
	@Override
	public String getProcessMsg() {
		return docActionDelegate.getProcessMsg();
	}	//	getProcessMsg

	@Override
	public int getDoc_User_ID() {
		return docActionDelegate.getDoc_User_ID();
	}

	/**
	 * Get Currency.
	 * @return The Currency for this record
	 */
	@Override
	public int getC_Currency_ID() {
		return docActionDelegate.getC_Currency_ID();
	}


	@Override
	public BigDecimal getApprovalAmt() {
		return docActionDelegate.getApprovalAmt();
	}

} // GenericPO

/**
 * Wrapper class to workaround the limit of PO constructor that doesn't take a tableName or
 * tableID parameter. Note that in the generated class scenario ( X_ ), tableName and tableId
 * is generated as a static field.
 * @author Low Heng Sin
 *
 */
class PropertiesWrapper extends Properties {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8887531951501323594L;
	protected Properties source;
	protected String tableName;

	PropertiesWrapper(Properties source, String tableName) {
		this.source = source;
		this.tableName = tableName;
	}
}
