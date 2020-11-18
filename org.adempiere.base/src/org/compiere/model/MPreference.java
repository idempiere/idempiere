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

/**
 *	Preference Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MPreference.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MPreference extends X_AD_Preference
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8935876328996934527L;

	/**	Null Indicator				*/
	public static String		NULL = "null";
	
	/**
	 * 	Standatrd Constructor
	 *	@param ctx ctx
	 *	@param AD_Preference_ID id
	 *	@param trxName transaction
	 */
	public MPreference(Properties ctx, int AD_Preference_ID, String trxName)
	{
		super(ctx, AD_Preference_ID, trxName);
		if (AD_Preference_ID == 0)
		{
		//	setAD_Preference_ID (0);
		//	setAttribute (null);
		//	setValue (null);
		}
	}	//	MPreference

	/**
	 * 	Load Contsructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPreference(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPreference

	/**
	 * 	Full Constructor
	 *	@param ctx context
	 *	@param Attribute attribute
	 *	@param Value value
	 *	@param trxName trx
	 */
	public MPreference (Properties ctx, String Attribute, String Value, String trxName)
	{
		this (ctx, 0, trxName);
		setAttribute (Attribute);
		setValue (Value);
	}	//	MPreference

	/**
	 * 	Before Save
	 *	@param newRecord
	 *	@return true if can be saved
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		String value = getValue();
		if (value == null)
			value = "";
		if (value.equals("-1"))
			setValue("");
		return true;
	}	//	beforeSave

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MPreference[");
		sb.append (get_ID()).append("-")
			.append(getAttribute()).append("-").append(getValue())
			.append ("]");
		return sb.toString ();
	}	//	toString

	/** Set User/Contact.
        @param AD_User_ID
        User within the system - Internal or Business Partner Contact
        Overridden to allow saving System record (zero ID)
	 */
	@Override
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID == 0) 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, AD_User_ID);
		else 
			super.setAD_User_ID(AD_User_ID);
	} //setAD_User_ID

}	//	MPreference
