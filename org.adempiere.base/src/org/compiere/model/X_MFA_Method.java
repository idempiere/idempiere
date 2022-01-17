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
import org.compiere.util.KeyNamePair;

/** Generated Model for MFA_Method
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="MFA_Method")
public class X_MFA_Method extends PO implements I_MFA_Method, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_MFA_Method (Properties ctx, int MFA_Method_ID, String trxName)
    {
      super (ctx, MFA_Method_ID, trxName);
      /** if (MFA_Method_ID == 0)
        {
			setMethod (null);
			setMFA_Method_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_MFA_Method (Properties ctx, int MFA_Method_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, MFA_Method_ID, trxName, virtualColumns);
      /** if (MFA_Method_ID == 0)
        {
			setMethod (null);
			setMFA_Method_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_MFA_Method (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 4 - System 
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
      StringBuilder sb = new StringBuilder ("X_MFA_Method[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Expire in Minutes.
		@param ExpireInMinutes Expire in Minutes
	*/
	public void setExpireInMinutes (int ExpireInMinutes)
	{
		set_Value (COLUMNNAME_ExpireInMinutes, Integer.valueOf(ExpireInMinutes));
	}

	/** Get Expire in Minutes.
		@return Expire in Minutes	  */
	public int getExpireInMinutes()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ExpireInMinutes);
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

	/** Method AD_Reference_ID=200187 */
	public static final int METHOD_AD_Reference_ID=200187;
	/** EMail = EMail */
	public static final String METHOD_EMail = "EMail";
	/** Time-Based One-Time Password = TOTP */
	public static final String METHOD_Time_BasedOne_TimePassword = "TOTP";
	/** Set Method.
		@param Method Method
	*/
	public void setMethod (String Method)
	{

		set_Value (COLUMNNAME_Method, Method);
	}

	/** Get Method.
		@return Method	  */
	public String getMethod()
	{
		return (String)get_Value(COLUMNNAME_Method);
	}

	/** Set Allowed Time Period Discrepancy.
		@param MFAAllowedTimeDiscrepancy Allowed Time Period Discrepancy
	*/
	public void setMFAAllowedTimeDiscrepancy (int MFAAllowedTimeDiscrepancy)
	{
		set_Value (COLUMNNAME_MFAAllowedTimeDiscrepancy, Integer.valueOf(MFAAllowedTimeDiscrepancy));
	}

	/** Get Allowed Time Period Discrepancy.
		@return Allowed Time Period Discrepancy	  */
	public int getMFAAllowedTimeDiscrepancy()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MFAAllowedTimeDiscrepancy);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Element getMFA_ElementPrm() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Element)MTable.get(getCtx(), org.compiere.model.I_AD_Element.Table_ID)
			.getPO(getMFA_ElementPrm_ID(), get_TrxName());
	}

	/** Set Parameter Element.
		@param MFA_ElementPrm_ID Parameter Element
	*/
	public void setMFA_ElementPrm_ID (int MFA_ElementPrm_ID)
	{
		if (MFA_ElementPrm_ID < 1)
			set_Value (COLUMNNAME_MFA_ElementPrm_ID, null);
		else
			set_Value (COLUMNNAME_MFA_ElementPrm_ID, Integer.valueOf(MFA_ElementPrm_ID));
	}

	/** Get Parameter Element.
		@return Parameter Element	  */
	public int getMFA_ElementPrm_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MFA_ElementPrm_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Issuer.
		@param MFAIssuer Issuer
	*/
	public void setMFAIssuer (String MFAIssuer)
	{
		set_Value (COLUMNNAME_MFAIssuer, MFAIssuer);
	}

	/** Get Issuer.
		@return Issuer	  */
	public String getMFAIssuer()
	{
		return (String)get_Value(COLUMNNAME_MFAIssuer);
	}

	/** Set MFA Method.
		@param MFA_Method_ID Multi-factor Authentication Method
	*/
	public void setMFA_Method_ID (int MFA_Method_ID)
	{
		if (MFA_Method_ID < 1)
			set_ValueNoCheck (COLUMNNAME_MFA_Method_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_MFA_Method_ID, Integer.valueOf(MFA_Method_ID));
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

	/** Set MFA_Method_UU.
		@param MFA_Method_UU MFA_Method_UU
	*/
	public void setMFA_Method_UU (String MFA_Method_UU)
	{
		set_Value (COLUMNNAME_MFA_Method_UU, MFA_Method_UU);
	}

	/** Get MFA_Method_UU.
		@return MFA_Method_UU	  */
	public String getMFA_Method_UU()
	{
		return (String)get_Value(COLUMNNAME_MFA_Method_UU);
	}

	/** MFATimeProvider AD_Reference_ID=200189 */
	public static final int MFATIMEPROVIDER_AD_Reference_ID=200189;
	/** Ntp = N */
	public static final String MFATIMEPROVIDER_Ntp = "N";
	/** System = S */
	public static final String MFATIMEPROVIDER_System = "S";
	/** Set Time Provider.
		@param MFATimeProvider Time Provider
	*/
	public void setMFATimeProvider (String MFATimeProvider)
	{

		set_Value (COLUMNNAME_MFATimeProvider, MFATimeProvider);
	}

	/** Get Time Provider.
		@return Time Provider	  */
	public String getMFATimeProvider()
	{
		return (String)get_Value(COLUMNNAME_MFATimeProvider);
	}

	/** Set Time Server.
		@param MFATimeServer Time Server
	*/
	public void setMFATimeServer (String MFATimeServer)
	{
		set_Value (COLUMNNAME_MFATimeServer, MFATimeServer);
	}

	/** Get Time Server.
		@return Time Server	  */
	public String getMFATimeServer()
	{
		return (String)get_Value(COLUMNNAME_MFATimeServer);
	}

	/** MFAType AD_Reference_ID=200188 */
	public static final int MFATYPE_AD_Reference_ID=200188;
	/** Something you Are (Biometrics) = A */
	public static final String MFATYPE_SomethingYouAreBiometrics = "A";
	/** Something you Have = H */
	public static final String MFATYPE_SomethingYouHave = "H";
	/** Something you Know = K */
	public static final String MFATYPE_SomethingYouKnow = "K";
	/** Location = L */
	public static final String MFATYPE_Location = "L";
	/** Set MFA Type.
		@param MFAType Multi-factor authentication type (Something you Know/Have/Are, Location)
	*/
	public void setMFAType (String MFAType)
	{

		set_Value (COLUMNNAME_MFAType, MFAType);
	}

	/** Get MFA Type.
		@return Multi-factor authentication type (Something you Know/Have/Are, Location)
	  */
	public String getMFAType()
	{
		return (String)get_Value(COLUMNNAME_MFAType);
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

	public org.compiere.model.I_R_MailText getR_MailText() throws RuntimeException
	{
		return (org.compiere.model.I_R_MailText)MTable.get(getCtx(), org.compiere.model.I_R_MailText.Table_ID)
			.getPO(getR_MailText_ID(), get_TrxName());
	}

	/** Set Mail Template.
		@param R_MailText_ID Text templates for mailings
	*/
	public void setR_MailText_ID (int R_MailText_ID)
	{
		if (R_MailText_ID < 1)
			set_Value (COLUMNNAME_R_MailText_ID, null);
		else
			set_Value (COLUMNNAME_R_MailText_ID, Integer.valueOf(R_MailText_ID));
	}

	/** Get Mail Template.
		@return Text templates for mailings
	  */
	public int getR_MailText_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_R_MailText_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}