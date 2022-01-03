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

/**
 * 	PostIt Model
 *	
 *  @author Nicolas Micoud
 *  @version $Id: MPostIt.java
 */
public class MPostIt extends X_AD_PostIt
{
	private static final long serialVersionUID = -5053130533036069784L;

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param XXA_PostIt_ID id
	 *	@param trxName transcation
	 */
	public MPostIt (Properties ctx, int XXA_PostIt_ID, String trxName)
	{
		super (ctx, XXA_PostIt_ID, trxName);
	}	//	MPostIt

	/**
	 * 	Full Constructor
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
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPostIt (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MPostIt


	public String getCreatedString()
	{
		MUser user = MUser.get(getCtx(), getCreatedBy());
		String date = new SimpleDateFormat("d MMM yyyy (HH:mm)").format(getCreated());
		Object[] args = new Object[] {user.getName(), date};
		return Msg.getMsg(getCtx(), "PostItCreated", args);
	}	//	getCreated

	
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

	public static int getID(int Table_ID, int Record_ID) {
		String sql="SELECT AD_PostIt_ID FROM AD_PostIt WHERE AD_Table_ID=? AND Record_ID=?";
		int postItID = DB.getSQLValueEx(null, sql, Table_ID, Record_ID);
		return postItID;
	}
}	//	MPostIt
