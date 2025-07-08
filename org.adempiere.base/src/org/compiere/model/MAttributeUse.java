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

import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *	Attribute Use Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MAttributeUse.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MAttributeUse extends X_M_AttributeUse
{
	/**
	 * generated serial id 
	 */
	private static final long	serialVersionUID				= -9159120094145438975L;

	public static final String	SQL_GET_TA_DUPLICATE_ATTRIBUTE	= """
					SELECT st.Name FROM M_Attribute a
					INNER JOIN M_AttributeUse u  ON (u.M_Attribute_ID = a.M_Attribute_ID)
					INNER JOIN M_AttributeSet st ON (st.M_AttributeSet_ID = u.M_AttributeSet_ID AND st.M_AttributeSet_Type = 'TA' )
					WHERE a.AD_Client_ID IN (0, ?) AND UPPER(a.Name) = UPPER(?) """;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_AttributeUse_UU  UUID key
     * @param trxName Transaction
     */
    public MAttributeUse(Properties ctx, String M_AttributeUse_UU, String trxName) {
        super(ctx, M_AttributeUse_UU, trxName);
    }

	/**
	 *	@param ctx context
	 *	@param ignored ignored
	 *	@param trxName transaction
	 */
	public MAttributeUse (Properties ctx, int ignored, String trxName)
	{
		super (ctx, ignored, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}	//	MAttributeUse

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MAttributeUse (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MAttributeUse

	@Override
	protected boolean beforeSave(boolean newRecord) {
		// Not advanced roles cannot assign for use a reference attribute
		if ((newRecord || is_ValueChanged(COLUMNNAME_M_Attribute_ID))
				&& ! MRole.getDefault().isAccessAdvanced()) {			
			MAttribute att = MAttribute.get(getCtx(), getM_Attribute_ID());
			if (MAttribute.ATTRIBUTEVALUETYPE_Reference.equals(att.getAttributeValueType())) {
				log.saveError("Error", Msg.getMsg(getCtx(), "ActionNotAllowedHere"));
				return false;
			}
		}
		
		// Set Sequence No
		if (getSeqNo() == 0) {
			String sql = "SELECT COALESCE(MAX(SeqNo),0)+10 FROM M_AttributeUse WHERE M_AttributeSet_ID=?";
			int seqNo = DB.getSQLValue (get_TrxName(), sql, getM_AttributeSet_ID());
			setSeqNo(seqNo);
		}

		if (getM_AttributeSet_ID() > 0
			&& getM_Attribute_ID() > 0 && is_ValueChanged(COLUMNNAME_M_Attribute_ID)
			&& MAttributeSet.M_ATTRIBUTESET_TYPE_TableAttribute.equals(getM_AttributeSet().getM_AttributeSet_Type()))
		{
			String dupAttribSetName = DB.getSQLValueString(get_TrxName(), SQL_GET_TA_DUPLICATE_ATTRIBUTE, getAD_Client_ID(), getM_Attribute().getName());
			if (!Util.isEmpty(dupAttribSetName, true))
			{
				log.saveError("Error", Msg.getMsg(getCtx(), "UniqueAttribute", new Object[] { getM_Attribute().getName(), dupAttribSetName }));
				return false;
			}
		}
		return true;
	}

	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		// Update M_AttributeSet IsInstanceAttribute to Y if conditions are met 
		StringBuilder sql = new StringBuilder("UPDATE M_AttributeSet mas")
			.append(" SET IsInstanceAttribute='Y' ")
			.append("WHERE M_AttributeSet_ID=").append(getM_AttributeSet_ID())
			.append(" AND IsInstanceAttribute='N'")
			.append(" AND (IsSerNo='Y' OR IsLot='Y' OR IsGuaranteeDate='Y'")
				.append(" OR EXISTS (SELECT * FROM M_AttributeUse mau")
					.append(" INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) ")
					.append("WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID")
					.append(" AND mau.IsActive='Y' AND ma.IsActive='Y'")
					.append(" AND ma.IsInstanceAttribute='Y')")
					.append(")");
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("afterSave - Set Instance Attribute");
		// Update M_AttributeSet IsInstanceAttribute to N if conditions are met
		sql = new StringBuilder("UPDATE M_AttributeSet mas")
			.append(" SET IsInstanceAttribute='N' ")
			.append("WHERE M_AttributeSet_ID=").append(getM_AttributeSet_ID())
			.append(" AND IsInstanceAttribute='Y'")
			.append("	AND IsSerNo='N' AND IsLot='N' AND IsGuaranteeDate='N'")
			.append(" AND NOT EXISTS (SELECT * FROM M_AttributeUse mau")
				.append(" INNER JOIN M_Attribute ma ON (mau.M_Attribute_ID=ma.M_Attribute_ID) ")
				.append("WHERE mau.M_AttributeSet_ID=mas.M_AttributeSet_ID")
				.append(" AND mau.IsActive='Y' AND ma.IsActive='Y'")
				.append(" AND ma.IsInstanceAttribute='Y')");
		no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 0)
			log.fine("afterSave - Reset Instance Attribute");
		
		return success;
	}	//	afterSave
		
	@Override
	protected boolean afterDelete (boolean success)
	{
		afterSave(false, success);
		return success;
	}	//	afterDelete
	
}	//	MAttributeUse
