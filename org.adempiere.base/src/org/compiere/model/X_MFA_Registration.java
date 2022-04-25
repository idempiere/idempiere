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
import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.util.KeyNamePair;

/** Generated Model for MFA_Registration
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="MFA_Registration")
public class X_MFA_Registration extends PO implements I_MFA_Registration, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_MFA_Registration (Properties ctx, int MFA_Registration_ID, String trxName)
    {
      super (ctx, MFA_Registration_ID, trxName);
      /** if (MFA_Registration_ID == 0)
        {
			setAD_User_ID (0);
			setIsUserMFAPreferred (false);
// N
			setIsValid (false);
// N
			setMFA_Method_ID (0);
			setMFA_Registration_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_MFA_Registration (Properties ctx, int MFA_Registration_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, MFA_Registration_ID, trxName, virtualColumns);
      /** if (MFA_Registration_ID == 0)
        {
			setAD_User_ID (0);
			setIsUserMFAPreferred (false);
// N
			setIsValid (false);
// N
			setMFA_Method_ID (0);
			setMFA_Registration_ID (0);
        } */
    }

    /** Load Constructor */
    public X_MFA_Registration (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 6 - System - Client 
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
      StringBuilder sb = new StringBuilder ("X_MFA_Registration[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
	{
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_ID)
			.getPO(getAD_User_ID(), get_TrxName());
	}

	/** Set User/Contact.
		@param AD_User_ID User within the system - Internal or Business Partner Contact
	*/
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1)
			set_Value (COLUMNNAME_AD_User_ID, null);
		else
			set_Value (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
	}

	/** Get User/Contact.
		@return User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Expire On.
		@param Expiration Expire On
	*/
	public void setExpiration (Timestamp Expiration)
	{
		set_Value (COLUMNNAME_Expiration, Expiration);
	}

	/** Get Expire On.
		@return Expire On
	  */
	public Timestamp getExpiration()
	{
		return (Timestamp)get_Value(COLUMNNAME_Expiration);
	}

	/** Set Failed Login Count.
		@param FailedLoginCount Failed Login Count
	*/
	public void setFailedLoginCount (int FailedLoginCount)
	{
		set_ValueNoCheck (COLUMNNAME_FailedLoginCount, Integer.valueOf(FailedLoginCount));
	}

	/** Get Failed Login Count.
		@return Failed Login Count	  */
	public int getFailedLoginCount()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_FailedLoginCount);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Comment/Help.
		@param Help Comment or Hint
	*/
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp()
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** Set Preferred.
		@param IsUserMFAPreferred Preferred
	*/
	public void setIsUserMFAPreferred (boolean IsUserMFAPreferred)
	{
		set_Value (COLUMNNAME_IsUserMFAPreferred, Boolean.valueOf(IsUserMFAPreferred));
	}

	/** Get Preferred.
		@return Preferred	  */
	public boolean isUserMFAPreferred()
	{
		Object oo = get_Value(COLUMNNAME_IsUserMFAPreferred);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Valid.
		@param IsValid Element is valid
	*/
	public void setIsValid (boolean IsValid)
	{
		set_Value (COLUMNNAME_IsValid, Boolean.valueOf(IsValid));
	}

	/** Get Valid.
		@return Element is valid
	  */
	public boolean isValid()
	{
		Object oo = get_Value(COLUMNNAME_IsValid);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Last Failure.
		@param LastFailure Last Failure
	*/
	public void setLastFailure (Timestamp LastFailure)
	{
		set_Value (COLUMNNAME_LastFailure, LastFailure);
	}

	/** Get Last Failure.
		@return Last Failure	  */
	public Timestamp getLastFailure()
	{
		return (Timestamp)get_Value(COLUMNNAME_LastFailure);
	}

	/** Set Last Success.
		@param LastSuccess Last Success
	*/
	public void setLastSuccess (Timestamp LastSuccess)
	{
		set_Value (COLUMNNAME_LastSuccess, LastSuccess);
	}

	/** Get Last Success.
		@return Last Success	  */
	public Timestamp getLastSuccess()
	{
		return (Timestamp)get_Value(COLUMNNAME_LastSuccess);
	}

	/** Set Last MFA Secret.
		@param MFALastSecret Last MFA Secret
	*/
	public void setMFALastSecret (String MFALastSecret)
	{
		set_Value (COLUMNNAME_MFALastSecret, MFALastSecret);
	}

	/** Get Last MFA Secret.
		@return Last MFA Secret	  */
	public String getMFALastSecret()
	{
		return (String)get_Value(COLUMNNAME_MFALastSecret);
	}

	public org.compiere.model.I_MFA_Method getMFA_Method() throws RuntimeException
	{
		return (org.compiere.model.I_MFA_Method)MTable.get(getCtx(), org.compiere.model.I_MFA_Method.Table_ID)
			.getPO(getMFA_Method_ID(), get_TrxName());
	}

	/** Set MFA Method.
		@param MFA_Method_ID Multi-factor Authentication Method
	*/
	public void setMFA_Method_ID (int MFA_Method_ID)
	{
		if (MFA_Method_ID < 1)
			set_Value (COLUMNNAME_MFA_Method_ID, null);
		else
			set_Value (COLUMNNAME_MFA_Method_ID, Integer.valueOf(MFA_Method_ID));
	}

	/** Get MFA Method.
		@return Multi-factor Authentication Method
	  */
	public int getMFA_Method_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MFA_Method_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set MFA Registration.
		@param MFA_Registration_ID MFA Registration
	*/
	public void setMFA_Registration_ID (int MFA_Registration_ID)
	{
		if (MFA_Registration_ID < 1)
			set_ValueNoCheck (COLUMNNAME_MFA_Registration_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_MFA_Registration_ID, Integer.valueOf(MFA_Registration_ID));
	}

	/** Get MFA Registration.
		@return MFA Registration	  */
	public int getMFA_Registration_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MFA_Registration_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set MFA_Registration_UU.
		@param MFA_Registration_UU MFA_Registration_UU
	*/
	public void setMFA_Registration_UU (String MFA_Registration_UU)
	{
		set_Value (COLUMNNAME_MFA_Registration_UU, MFA_Registration_UU);
	}

	/** Get MFA_Registration_UU.
		@return MFA_Registration_UU	  */
	public String getMFA_Registration_UU()
	{
		return (String)get_Value(COLUMNNAME_MFA_Registration_UU);
	}

	/** Set MFA Secret.
		@param MFASecret Multi-factor Authentication Secret
	*/
	public void setMFASecret (String MFASecret)
	{
		set_Value (COLUMNNAME_MFASecret, MFASecret);
	}

	/** Get MFA Secret.
		@return Multi-factor Authentication Secret
	  */
	public String getMFASecret()
	{
		return (String)get_Value(COLUMNNAME_MFASecret);
	}

	/** Set Unregistered at.
		@param MFAUnregisteredAt Unregistered at
	*/
	public void setMFAUnregisteredAt (Timestamp MFAUnregisteredAt)
	{
		set_Value (COLUMNNAME_MFAUnregisteredAt, MFAUnregisteredAt);
	}

	/** Get Unregistered at.
		@return Unregistered at	  */
	public Timestamp getMFAUnregisteredAt()
	{
		return (Timestamp)get_Value(COLUMNNAME_MFAUnregisteredAt);
	}

	/** Set Validated at.
		@param MFAValidatedAt Validated at
	*/
	public void setMFAValidatedAt (Timestamp MFAValidatedAt)
	{
		set_Value (COLUMNNAME_MFAValidatedAt, MFAValidatedAt);
	}

	/** Get Validated at.
		@return Validated at	  */
	public Timestamp getMFAValidatedAt()
	{
		return (Timestamp)get_Value(COLUMNNAME_MFAValidatedAt);
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Parameter Value.
		@param ParameterValue Parameter Value
	*/
	public void setParameterValue (String ParameterValue)
	{
		set_Value (COLUMNNAME_ParameterValue, ParameterValue);
	}

	/** Get Parameter Value.
		@return Parameter Value	  */
	public String getParameterValue()
	{
		return (String)get_Value(COLUMNNAME_ParameterValue);
	}
}