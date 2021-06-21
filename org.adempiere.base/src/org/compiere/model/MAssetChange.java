/******************************************************************************
 * The contents of this file are subject to the   Compiere License  Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * You may obtain a copy of the License at http://www.compiere.org/license.html
 * Software distributed under the License is distributed on an  "AS IS"  basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 * The Original Code is             Compiere  ERP & CRM Smart Business Solution
 * The Initial Developer of the Original Code is Jorg Janke  and ComPiere, Inc.
 * Portions created by Jorg Janke are Copyright (C) 1999-2003 Jorg Janke, parts
 * created by ComPiere are Copyright (C) ComPiere, Inc.;   All Rights Reserved.
 * Contributor(s): ______________________________________.
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;

/**
 *  Asset Addition Model
 *	@author Teo Sarca, SC ARHIPAC SERVICE SRL
 *
 */
public class MAssetChange extends X_A_Asset_Change
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4083373951793617528L;

	/**	Static Logger */
	private static CLogger s_log = CLogger.getCLogger(MAssetChange.class);
	
	/**
	 * 	Default Constructor
	 *	@param ctx context
	 *	@param M_InventoryLine_ID line
	 */
	public MAssetChange (Properties ctx, int A_Asset_Change_ID, String trxName)
	{
		super (ctx, A_Asset_Change_ID, trxName);
	}	//	MAssetChange
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 */
	public MAssetChange (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MInventoryLine

		/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		String textDetails = getTextDetails();
		if (textDetails == null || textDetails.length() == 0) {
			setTextDetails(MRefList.getListDescription (getCtx(),"A_Update_Type" , getChangeType()));
		}
		return true;
	}	//	beforeSave

	public static MAssetChange createAddition(MAssetAddition assetAdd, MDepreciationWorkfile assetwk) {
		MAssetChange change = new MAssetChange (assetAdd.getCtx(), 0, assetAdd.get_TrxName());
		change.setAD_Org_ID(assetAdd.getAD_Org_ID()); //@win added
		change.setA_Asset_ID(assetAdd.getA_Asset_ID());
		change.setA_QTY_Current(assetAdd.getA_QTY_Current());
		change.setChangeType("ADD");
		change.setTextDetails(MRefList.getListDescription (assetAdd.getCtx(),"A_Update_Type" , "ADD"));
		change.setPostingType(assetwk.getPostingType());
		change.setAssetValueAmt(assetAdd.getAssetValueAmt());
		change.setA_QTY_Current(assetAdd.getA_QTY_Current());	            
		change.saveEx();
		
		return change;
	}
	
	public static MAssetChange create(Properties ctx, String changeType, PO[] pos, String trxName) {
		return create(ctx, changeType, pos, false, trxName);
	}
	
	/**
	 * TODO
	 * @param ctx
	 * @param changeType
	 * @param pos
	 * @param trxName
	 * @return
	 */
	public static MAssetChange createAndSave(Properties ctx, String changeType, PO[] pos, String trxName) {
		return null;
	}
	
	public static MAssetChange create(Properties ctx, String changeType, PO[] pos, boolean save, String trxName) {
		if (s_log.isLoggable(Level.FINE)) s_log.fine("Entering: changeType=" + changeType);
		if (pos == null || pos.length == 0) {
			s_log.fine("Entering/Leaving: POs is empty");
			return null;
		}
		MAssetChange change = new MAssetChange (ctx, 0, trxName);
		change.setChangeType(changeType);
		for (PO po : pos) {
			change.addChanges(po);
		}
		if (save) {
			change.saveEx();
		}
		//
		if (s_log.isLoggable(Level.FINE)) s_log.fine("Leaving: change=" + change);
		return change;
	}
	
	public void addChanges(PO po) {
		if (log.isLoggable(Level.FINE)) log.fine("Entering: po=" + po);
		if (po == null) {
			return;
		}
		//
		if (log.isLoggable(Level.FINE)) log.fine("Leaving: po=" + po);
	}
	/** ARHIPAC: TEO: END ------------------------------------------------------------------ */
	
	/**
	 * 
	 * @param ctx
	 * @param A_Asset_ID
	 * @param postingType
	 * @param trxName
	 * @param Account Schema
	 * @return assetChange
	 * @see #get(Properties, int, String, String)
	 */
	public static MAssetChange get (Properties ctx, int A_Asset_ID, String changeType,  String trxName, int C_AcctSchema_ID)
	{
		if (A_Asset_ID <= 0 || changeType == null)
		{
			return null;
		}
		
	
		final String whereClause = COLUMNNAME_A_Asset_ID+"=? AND "
								  +COLUMNNAME_ChangeType+"=? AND " 
								  +COLUMNNAME_C_AcctSchema_ID + "=?" ;

		
		MAssetChange ac = new Query(ctx, MAssetChange.Table_Name, whereClause, trxName)
				.setParameters(new Object[]{A_Asset_ID, changeType,C_AcctSchema_ID})
				.firstOnly();
		
		
	
		return ac;
	}
}	//	MAssetChange