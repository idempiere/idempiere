/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;

public class MTableAttribute extends X_AD_TableAttribute
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2624557341374329315L;

	public MTableAttribute(Properties ctx, int AD_TableAttribute_ID, String trxName)
	{
		super(ctx, AD_TableAttribute_ID, trxName);
	}

	public MTableAttribute(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	public static MTableAttribute get(int tableID, int recordID, int attrID)
	{
		String whereClause = MTableAttribute.COLUMNNAME_AD_Table_ID + " = ? AND " + MTableAttribute.COLUMNNAME_Record_ID + " = ? AND " + MTableAttribute.COLUMNNAME_M_Attribute_ID + " = ? ";
		return new Query(Env.getCtx(), MTableAttribute.Table_Name, whereClause, null).setParameters(tableID, recordID, attrID).first();
	}
}
