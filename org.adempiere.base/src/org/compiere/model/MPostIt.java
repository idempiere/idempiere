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
import java.text.SimpleDateFormat;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * 	PostIt Note Model
 *	
 *  @author Nicolas Micoud
 *  @version $Id: MPostIt.java
 */
public class MPostIt extends X_AD_PostIt
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7817778632231317976L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_PostIt_UU  UUID key
     * @param trxName Transaction
     */
    public MPostIt(Properties ctx, String AD_PostIt_UU, String trxName) {
        super(ctx, AD_PostIt_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_PostIt_ID id
	 *	@param trxName transaction
	 */
	public MPostIt (Properties ctx, int AD_PostIt_ID, String trxName)
	{
		super (ctx, AD_PostIt_ID, trxName);
	}	//	MPostIt

	/**
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param trxName transaction
	 */
	public MPostIt (Properties ctx, int AD_Table_ID, int Record_ID, String trxName)
	{
		this (ctx, 0, trxName);
		setAD_Table_ID (AD_Table_ID);
		setRecord_ID (Record_ID);
	}	//	MPostIt

	/**
	 *	@param ctx context
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param trxName transaction
	 */
	public MPostIt (Properties ctx, int AD_Table_ID, int Record_ID, String Record_UU, String trxName)
	{
		this (ctx, 0, trxName);
		setAD_Table_ID (AD_Table_ID);
		setRecord_ID (Record_ID);
		setRecord_UU (Record_UU);
	}	//	MPostIt

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPostIt (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MPostIt

	/**
	 * @return created text
	 */
	public String getCreatedString()
	{
		MUser user = MUser.get(getCtx(), getCreatedBy());
		String date = new SimpleDateFormat("d MMM yyyy (HH:mm)").format(getCreated());
		Object[] args = new Object[] {user.getName(), date};
		return Msg.getMsg(getCtx(), "PostItCreated", args);
	}	//	getCreated

	/**
	 * @return updated text
	 */
	public String getUpdatedString()
	{
		String retValue = "";
		if (getUpdated().getTime() != getCreated().getTime())
		{
			MUser user = MUser.get(getCtx(), getUpdatedBy());
			String date = new SimpleDateFormat("d MMM yyyy (HH:mm)").format(getUpdated());
			Object[] args = new Object[] {user.getName(), date};
			retValue = Msg.getMsg(getCtx(), "PostItUpdated", args);	
		}

		return retValue;
	}	//	getUpdatedString

	/**
	 * @param Table_ID
	 * @param Record_ID
	 * @return AD_PostIt_ID
 	 * @deprecated Use {@link MPostIt#getID(int, int, String)} instead
	 */
	@Deprecated
	public static int getID(int Table_ID, int Record_ID) {
		String sql="SELECT AD_PostIt_ID FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID=?";
		int postItID = DB.getSQLValueEx(null, sql, Table_ID, Record_ID);
		return postItID;
	}

	/**
	 * @param Table_ID
	 * @param Record_ID
	 * @param Record_UU
	 * @return AD_PostIt_ID
	 */
	public static int getID(int Table_ID, int Record_ID, String Record_UU) {
		if (Util.isEmpty(Record_UU))
			return getID(Table_ID, Record_ID);
		String sql="SELECT AD_PostIt_ID FROM AD_PostIt WHERE AD_Table_ID=? AND Record_UU=?";
		int postItID = DB.getSQLValueEx(null, sql, Table_ID, Record_UU);
		return postItID;
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Update Record_UU from Record_ID
		if (getRecord_ID() > 0 && getAD_Table_ID() > 0 && Util.isEmpty(getRecord_UU())) {
			MTable table = MTable.get(getAD_Table_ID());
			PO po = table.getPO(getRecord_ID(), get_TrxName());
			if (po != null)
				setRecord_UU(po.get_UUID());
		}
		return true;
	}

}	//	MPostIt
