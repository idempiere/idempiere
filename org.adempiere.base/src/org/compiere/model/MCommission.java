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
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *	Model for Commission.
 *	(has Lines)
 *	
 *  @author Jorg Janke
 *  @version $Id: MCommission.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 *  @author victor.perez@e-evolution.com www.e-evolution.com [ 1867477 ] https://sourceforge.net/p/adempiere/bugs/924/
 *	FR: [ 2214883 ] Remove SQL code and Replace for Query - red1
 */
public class MCommission extends X_C_Commission
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2702487404398723180L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_Commission_UU  UUID key
     * @param trxName Transaction
     */
    public MCommission(Properties ctx, String C_Commission_UU, String trxName) {
        super(ctx, C_Commission_UU, trxName);
		if (Util.isEmpty(C_Commission_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_Commission_ID id
	 *	@param trxName transaction
	 */
	public MCommission(Properties ctx, int C_Commission_ID, String trxName)
	{
		super(ctx, C_Commission_ID, trxName);
		if (C_Commission_ID == 0)
			setInitialDefaults();
	}	//	MCommission

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setDocBasisType (DOCBASISTYPE_Invoice);	// I
		setFrequencyType (FREQUENCYTYPE_Monthly);	// M
		setListDetails (false);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCommission(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCommission

	/**
	 * @param ctx
	 * @param C_Commission_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MCommission(Properties ctx, int C_Commission_ID, String trxName, String... virtualColumns) {
		super(ctx, C_Commission_ID, trxName, virtualColumns);
	}

	/**
	 * 	Get Lines
	 *	@return array of lines
	 */
	public MCommissionLine[] getLines()
	{
		//[ 1867477 ]
		//FR: [ 2214883 ] Remove SQL code and Replace for Query - red1
		final String whereClause = "IsActive='Y' AND C_Commission_ID=?";
		List<MCommissionLine> list  = new Query(getCtx(), I_C_CommissionLine.Table_Name, whereClause, get_TrxName())
		.setParameters(getC_Commission_ID())
		.setOrderBy("Line,C_CommissionLine_ID")
		.list();	
		//	Convert
		MCommissionLine[] retValue = new MCommissionLine[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getLines

	/**
	 * 	Set Date Last Run
	 *	@param DateLastRun date
	 */
	@Override
	public void setDateLastRun (Timestamp DateLastRun)
	{
		if (DateLastRun != null)
			super.setDateLastRun(DateLastRun);
	}	//	setDateLastRun

	/**
	 * 	Copy Lines From other Commission
	 *	@param otherCom commission
	 *	@return number of lines copied
	 */
	public int copyLinesFrom (MCommission otherCom)
	{
		if (otherCom == null)
			return 0;
		MCommissionLine[] fromLines = otherCom.getLines ();
		int count = 0;
		for (int i = 0; i < fromLines.length; i++)
		{
			MCommissionLine line = new MCommissionLine (getCtx(), 0, get_TrxName());
			PO.copyValues(fromLines[i], line, getAD_Client_ID(), getAD_Org_ID());
			line.setC_Commission_ID (getC_Commission_ID());
			if (line.save())
				count++;
		}
		if (fromLines.length != count)
			log.log(Level.SEVERE, "copyLinesFrom - Line difference - From=" + fromLines.length + " <> Saved=" + count);
		return count;
	}	//	copyLinesFrom

	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Must fill one of charge or product field
		if (getC_Charge_ID() == 0 && getM_Product_ID() == 0) {
			log.saveError("FillMandatory", Msg.translate(getCtx(), "ChargeOrProductMandatory"));
			return false;
		}
		return true;
	}

}	//	MCommission
