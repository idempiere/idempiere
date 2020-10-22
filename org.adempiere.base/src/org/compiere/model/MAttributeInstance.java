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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Properties;

import org.compiere.util.DisplayType;

/**
 *  Product Attribute Set
 *
 *	@author Jorg Janke
 *	@version $Id: MAttributeInstance.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 */
public class MAttributeInstance extends X_M_AttributeInstance
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5697542928282761922L;


	/**
	 * 	Persistency Constructor
	 *	@param ctx context
	 *	@param ignored ignored
	 *	@param trxName transaction
	 */
	public MAttributeInstance (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}	//	MAttributeInstance

	/**
	 * 	Load Cosntructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MAttributeInstance (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MAttributeInstance

	/**
	 * 	String Value Constructor
	 *	@param ctx context
	 *	@param M_Attribute_ID attribute
	 *	@param M_AttributeSetInstance_ID instance
	 *	@param Value string value
	 *	@param trxName transaction
	 */
	public MAttributeInstance (Properties ctx, int M_Attribute_ID, 
		int M_AttributeSetInstance_ID, String Value, String trxName)
	{
		super(ctx, 0, trxName);
		setM_Attribute_ID (M_Attribute_ID);
		setM_AttributeSetInstance_ID (M_AttributeSetInstance_ID);
		setValue (Value);
	}	//	MAttributeInstance
	
	/**
	 * 	Number Value Constructior
	 *	@param ctx context
	 *	@param M_Attribute_ID attribute
	 *	@param M_AttributeSetInstance_ID instance
	 *	@param BDValue number value
	 *	@param trxName transaction
	 */
	public MAttributeInstance (Properties ctx, int M_Attribute_ID, 
		int M_AttributeSetInstance_ID, BigDecimal BDValue, String trxName)
	{
		super(ctx, 0, trxName);
		setM_Attribute_ID (M_Attribute_ID);
		setM_AttributeSetInstance_ID (M_AttributeSetInstance_ID);
		setValueNumber(BDValue);
	}	//	MAttributeInstance

	/**
	 * 	Selection Value Constructor
	 *	@param ctx context
	 *	@param M_Attribute_ID attribute
	 *	@param M_AttributeSetInstance_ID instance
	 *	@param M_AttributeValue_ID selection
	 * 	@param Value String representation for fast display
	 *	@param trxName transaction
	 */
	public MAttributeInstance(Properties ctx, int M_Attribute_ID, int M_AttributeSetInstance_ID,
			int M_AttributeValue_ID, String Value, String trxName)
	{
		super(ctx, 0, trxName);
		setM_Attribute_ID(M_Attribute_ID);
		setM_AttributeSetInstance_ID(M_AttributeSetInstance_ID);
		setM_AttributeValue_ID(M_AttributeValue_ID);
		setValue(Value);
	} // MAttributeInstance


	public MAttributeInstance (Properties ctx, int M_Attribute_ID, 
		int M_AttributeSetInstance_ID, int Value, String trxName)
	{
		super(ctx, 0, trxName);
		setM_Attribute_ID (M_Attribute_ID);
		setM_AttributeSetInstance_ID (M_AttributeSetInstance_ID);
		setValueNumber(BigDecimal.valueOf(Value));
	} // MAttributeInstance

	public MAttributeInstance(Properties ctx, int m_Attribute_ID, int m_AttributeSetInstance_ID, Timestamp value,
			String trxName)
	{
		super(ctx, 0, trxName);
		setM_Attribute_ID(m_Attribute_ID);
		setM_AttributeSetInstance_ID(m_AttributeSetInstance_ID);
		setValueDate(value);
	} // MAttributeInstance

	/**
	 * 	Set ValueNumber
	 *	@param ValueNumber number
	 */
	public void setValueNumber (BigDecimal ValueNumber)
	{
		super.setValueNumber (ValueNumber);
		if (ValueNumber == null)
		{
			setValue(null);
			return;
		}
		if (ValueNumber.signum() == 0)
		{
			setValue("0");
			return;
		}
		//	Display number w/o decimal 0
		char[] chars = ValueNumber.toString().toCharArray();
		StringBuilder display = new StringBuilder();
		boolean add = false;
		for (int i = chars.length-1; i >= 0; i--)
		{
			char c = chars[i];
			if (add)
				display.insert(0, c);
			else
			{
				if (c == '0')
					continue;
				else if (c == '.')	//	decimal point
					add = true;
				else
				{
					display.insert(0, c);
					add = true;
				}
			}
		}			
		setValue(display.toString());
	} // setValueNumber

	/**
	 * Set valueDate
	 * 
	 * @param valueDate
	 */
	public void setValueDate(Timestamp valueDate)
	{
		super.setValueDate(valueDate);
		if (valueDate == null)
		{
			setValue(null);
			return;
		}

		SimpleDateFormat sdf = null;
		MAttribute attribute = MAttribute.get(getCtx(), getM_Attribute_ID());
		int displayType = attribute.getAD_Reference_ID();

		if (MAttribute.ATTRIBUTEVALUETYPE_Date.equals(attribute.getAttributeValueType()))
			sdf = DisplayType.getDateFormat_JDBC();
		// Based on reference type, Format timestamp into string value
		else if (displayType == DisplayType.DateTime)
			sdf = DisplayType.getTimestampFormat_Default();
		else if (displayType == DisplayType.Time)
			sdf = DisplayType.getTimeFormat_Default();
		else
			sdf = DisplayType.getDateFormat_JDBC();

		setValue(sdf.format(valueDate));
	} // setValueDate

	/**
	 * Set ValueInt
	 * 
	 * @param valueInt
	 * @param value
	 */
	public void setValueInt(int valueInt, String value)
	{
		super.setValueNumber(BigDecimal.valueOf(valueInt));
		if (value == null)
			value = String.valueOf(valueInt);
		setValue(value);
	} // setValueInt

	/**
	 * Get Value as Integer
	 * 
	 * @return
	 */
	public int getValueInt()
	{
		if (super.getValueNumber() == null)
			return 0;
		else
			return super.getValueNumber().intValue();
	} // getValueInt

	/**
	 *	String Representation
	 * 	@return info
	 */
	public String toString()
	{
		return getValue();
	}	//	toString

}	//	MAttributeInstance
