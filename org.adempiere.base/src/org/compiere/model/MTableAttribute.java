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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Table Attribute Model
 * @author DPansheriya
 *
 */
public class MTableAttribute extends X_AD_TableAttribute
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2624557341374329315L;

	/** Get Default value of the attribute **/
	private static final String TABLE_ATTRIBUTE_DEFAULTVALUE_SQL = """
														SELECT a.Name, a.AttributeValueType, a.AD_Reference_ID, COALESCE(atsu.DefaultValue , a.DefaultValue)
																FROM AD_TableAttributeSet tas
																INNER JOIN M_AttributeUse atsu ON (atsu.M_AttributeSet_ID = tas.M_AttributeSet_ID)
																INNER JOIN M_Attribute a ON (a.M_Attribute_ID = atsu.M_Attribute_ID)
																WHERE a.Name = ? AND a.IsActive = 'Y' AND tas.AD_Table_ID = ?	""";

	private static CCache<String, Object> s_tableAttributeDefault = new CCache<String, Object>("AD_TableAttribute_Default", 30);	
	
	public MTableAttribute(Properties ctx, int AD_TableAttribute_ID, String trxName)
	{
		super(ctx, AD_TableAttribute_ID, trxName);
	}

	public MTableAttribute(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	public static List<MTableAttribute> get(int tableID, int recordID)
	{
		final String whereClause = "AD_Table_ID=? AND Record_ID=? ";
		return new Query(Env.getCtx(), MTableAttribute.Table_Name, whereClause, null).setParameters(tableID, recordID).list();
	}

	public static MTableAttribute get(int tableID, int recordID, int attrID)
	{
		final String whereClause = "AD_Table_ID=? AND Record_ID=? AND M_Attribute_ID=? ";
		return new Query(Env.getCtx(), MTableAttribute.Table_Name, whereClause, null).setParameters(tableID, recordID, attrID).firstOnly();
	}

	/**
	 * Return attribute default value for table.
	 *  
	 * @param  attributeName
	 * @param tableID 
	 * @param  table_ID
	 * @return
	 */
	public static Object getAttributeDefaultValue(String attributeName, int tableID)
	{
		String key = tableID + "_" + attributeName;
		if (!s_tableAttributeDefault.containsKey(key))
		{
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Object value = null;
			try
			{
				pstmt = DB.prepareStatement(TABLE_ATTRIBUTE_DEFAULTVALUE_SQL, null);
				pstmt.setString(1, attributeName);
				pstmt.setInt(2, tableID);
				rs = pstmt.executeQuery();
				if(rs.next())
				{
					String attType = rs.getString(2);
					int reference_ID = rs.getInt(3);
					String DefaultValue = rs.getString(4);

					if (Util.isEmpty(DefaultValue))
						return null;

					if (MAttribute.ATTRIBUTEVALUETYPE_Number.equalsIgnoreCase(attType)
						|| MAttribute.ATTRIBUTEVALUETYPE_List.equalsIgnoreCase(attType))
					{
						value = Integer.valueOf(DefaultValue);
					}
					else if (MAttribute.ATTRIBUTEVALUETYPE_Date.equalsIgnoreCase(attType))
					{
						value = Timestamp.valueOf(DefaultValue);
					}
					else if (MAttribute.ATTRIBUTEVALUETYPE_StringMax40.equalsIgnoreCase(attType))
					{
						value = DefaultValue;
					}
					else if (MAttribute.ATTRIBUTEVALUETYPE_Reference.equalsIgnoreCase(attType))
					{
						if (reference_ID == DisplayType.YesNo)
						{
							value = Util.isEmpty(DefaultValue) ? null: DefaultValue.equalsIgnoreCase("Y");
						}
						else if (DisplayType.isText(reference_ID))
						{
							value = DefaultValue;
						}
						else if (DisplayType.isDate(reference_ID))
						{
							value = Timestamp.valueOf(DefaultValue);
						}
						else if (DisplayType.isNumeric(reference_ID) || DisplayType.isID(reference_ID))
						{
							value = Integer.valueOf(DefaultValue);
						}
						else
						{
							value = DefaultValue;
						}
					}
					else
					{
						value = DefaultValue;
					}
					s_tableAttributeDefault.put(key, value);
				}
			}
			catch (Exception e)
			{
				throw new AdempiereException("Failed: Get Attribute = " + attributeName, e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
		}

		if (s_tableAttributeDefault.containsKey(key))
			return s_tableAttributeDefault.get(key);
		return null;
	} // getAttributeDefaultValue
	
}
