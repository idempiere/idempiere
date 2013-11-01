/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/** Generated Model for C_TaxProvider
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_C_TaxProvider extends PO implements I_C_TaxProvider, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_C_TaxProvider (Properties ctx, int C_TaxProvider_ID, String trxName)
    {
      super (ctx, C_TaxProvider_ID, trxName);
      /** if (C_TaxProvider_ID == 0)
        {
			setC_TaxProviderCfg_ID (0);
			setC_TaxProvider_ID (0);
			setName (null);
			setSeqNo (0);
// 0
        } */
    }

    /** Load Constructor */
    public X_C_TaxProvider (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuffer sb = new StringBuffer ("X_C_TaxProvider[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Account.
		@param Account Account	  */
	public void setAccount (String Account)
	{
		set_Value (COLUMNNAME_Account, Account);
	}

	/** Get Account.
		@return Account	  */
	public String getAccount () 
	{
		return (String)get_Value(COLUMNNAME_Account);
	}

	/** Set Company Code.
		@param CompanyCode Company Code	  */
	public void setCompanyCode (String CompanyCode)
	{
		set_Value (COLUMNNAME_CompanyCode, CompanyCode);
	}

	/** Get Company Code.
		@return Company Code	  */
	public String getCompanyCode () 
	{
		return (String)get_Value(COLUMNNAME_CompanyCode);
	}

	public org.compiere.model.I_C_TaxProviderCfg getC_TaxProviderCfg() throws RuntimeException
    {
		return (org.compiere.model.I_C_TaxProviderCfg)MTable.get(getCtx(), org.compiere.model.I_C_TaxProviderCfg.Table_Name)
			.getPO(getC_TaxProviderCfg_ID(), get_TrxName());	}

	/** Set Tax Provider Configuration.
		@param C_TaxProviderCfg_ID Tax Provider Configuration	  */
	public void setC_TaxProviderCfg_ID (int C_TaxProviderCfg_ID)
	{
		if (C_TaxProviderCfg_ID < 1) 
			set_Value (COLUMNNAME_C_TaxProviderCfg_ID, null);
		else 
			set_Value (COLUMNNAME_C_TaxProviderCfg_ID, Integer.valueOf(C_TaxProviderCfg_ID));
	}

	/** Get Tax Provider Configuration.
		@return Tax Provider Configuration	  */
	public int getC_TaxProviderCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_TaxProviderCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Tax Provider.
		@param C_TaxProvider_ID Tax Provider	  */
	public void setC_TaxProvider_ID (int C_TaxProvider_ID)
	{
		if (C_TaxProvider_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_TaxProvider_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_TaxProvider_ID, Integer.valueOf(C_TaxProvider_ID));
	}

	/** Get Tax Provider.
		@return Tax Provider	  */
	public int getC_TaxProvider_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_TaxProvider_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_TaxProvider_UU.
		@param C_TaxProvider_UU C_TaxProvider_UU	  */
	public void setC_TaxProvider_UU (String C_TaxProvider_UU)
	{
		set_Value (COLUMNNAME_C_TaxProvider_UU, C_TaxProvider_UU);
	}

	/** Get C_TaxProvider_UU.
		@return C_TaxProvider_UU	  */
	public String getC_TaxProvider_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_TaxProvider_UU);
	}

	/** Set License.
		@param License License	  */
	public void setLicense (String License)
	{
		set_Value (COLUMNNAME_License, License);
	}

	/** Get License.
		@return License	  */
	public String getLicense () 
	{
		return (String)get_Value(COLUMNNAME_License);
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set Sequence.
		@param SeqNo 
		Method of ordering records; lowest number comes first
	  */
	public void setSeqNo (int SeqNo)
	{
		set_Value (COLUMNNAME_SeqNo, Integer.valueOf(SeqNo));
	}

	/** Get Sequence.
		@return Method of ordering records; lowest number comes first
	  */
	public int getSeqNo () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Validate Connection.
		@param ValidateConnection Validate Connection	  */
	public void setValidateConnection (String ValidateConnection)
	{
		set_Value (COLUMNNAME_ValidateConnection, ValidateConnection);
	}

	/** Get Validate Connection.
		@return Validate Connection	  */
	public String getValidateConnection () 
	{
		return (String)get_Value(COLUMNNAME_ValidateConnection);
	}
}