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

/** Generated Model for GL_JournalGenerator
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_GL_JournalGenerator extends PO implements I_GL_JournalGenerator, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121031L;

    /** Standard Constructor */
    public X_GL_JournalGenerator (Properties ctx, int GL_JournalGenerator_ID, String trxName)
    {
      super (ctx, GL_JournalGenerator_ID, trxName);
      /** if (GL_JournalGenerator_ID == 0)
        {
			setGL_JournalGenerator_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_GL_JournalGenerator (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_GL_JournalGenerator[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_C_AcctSchema getC_AcctSchema() throws RuntimeException
    {
		return (org.compiere.model.I_C_AcctSchema)MTable.get(getCtx(), org.compiere.model.I_C_AcctSchema.Table_Name)
			.getPO(getC_AcctSchema_ID(), get_TrxName());	}

	/** Set Accounting Schema.
		@param C_AcctSchema_ID 
		Rules for accounting
	  */
	public void setC_AcctSchema_ID (int C_AcctSchema_ID)
	{
		if (C_AcctSchema_ID < 1) 
			set_Value (COLUMNNAME_C_AcctSchema_ID, null);
		else 
			set_Value (COLUMNNAME_C_AcctSchema_ID, Integer.valueOf(C_AcctSchema_ID));
	}

	/** Get Accounting Schema.
		@return Rules for accounting
	  */
	public int getC_AcctSchema_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_AcctSchema_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_DocType getC_DocType() throws RuntimeException
    {
		return (org.compiere.model.I_C_DocType)MTable.get(getCtx(), org.compiere.model.I_C_DocType.Table_Name)
			.getPO(getC_DocType_ID(), get_TrxName());	}

	/** Set Document Type.
		@param C_DocType_ID 
		Document type or rules
	  */
	public void setC_DocType_ID (int C_DocType_ID)
	{
		if (C_DocType_ID < 0) 
			set_Value (COLUMNNAME_C_DocType_ID, null);
		else 
			set_Value (COLUMNNAME_C_DocType_ID, Integer.valueOf(C_DocType_ID));
	}

	/** Get Document Type.
		@return Document type or rules
	  */
	public int getC_DocType_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_DocType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_ElementValue getC_ElementValueAdjustCR() throws RuntimeException
    {
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_Name)
			.getPO(getC_ElementValueAdjustCR_ID(), get_TrxName());	}

	/** Set Account Adjust CR.
		@param C_ElementValueAdjustCR_ID Account Adjust CR	  */
	public void setC_ElementValueAdjustCR_ID (int C_ElementValueAdjustCR_ID)
	{
		if (C_ElementValueAdjustCR_ID < 1) 
			set_Value (COLUMNNAME_C_ElementValueAdjustCR_ID, null);
		else 
			set_Value (COLUMNNAME_C_ElementValueAdjustCR_ID, Integer.valueOf(C_ElementValueAdjustCR_ID));
	}

	/** Get Account Adjust CR.
		@return Account Adjust CR	  */
	public int getC_ElementValueAdjustCR_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ElementValueAdjustCR_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_ElementValue getC_ElementValueAdjustDR() throws RuntimeException
    {
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_Name)
			.getPO(getC_ElementValueAdjustDR_ID(), get_TrxName());	}

	/** Set Account Adjust DR.
		@param C_ElementValueAdjustDR_ID Account Adjust DR	  */
	public void setC_ElementValueAdjustDR_ID (int C_ElementValueAdjustDR_ID)
	{
		if (C_ElementValueAdjustDR_ID < 1) 
			set_Value (COLUMNNAME_C_ElementValueAdjustDR_ID, null);
		else 
			set_Value (COLUMNNAME_C_ElementValueAdjustDR_ID, Integer.valueOf(C_ElementValueAdjustDR_ID));
	}

	/** Get Account Adjust DR.
		@return Account Adjust DR	  */
	public int getC_ElementValueAdjustDR_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ElementValueAdjustDR_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Generate GL Journal.
		@param GenerateGLJournal Generate GL Journal	  */
	public void setGenerateGLJournal (String GenerateGLJournal)
	{
		set_Value (COLUMNNAME_GenerateGLJournal, GenerateGLJournal);
	}

	/** Get Generate GL Journal.
		@return Generate GL Journal	  */
	public String getGenerateGLJournal () 
	{
		return (String)get_Value(COLUMNNAME_GenerateGLJournal);
	}

	public org.compiere.model.I_GL_Category getGL_Category() throws RuntimeException
    {
		return (org.compiere.model.I_GL_Category)MTable.get(getCtx(), org.compiere.model.I_GL_Category.Table_Name)
			.getPO(getGL_Category_ID(), get_TrxName());	}

	/** Set GL Category.
		@param GL_Category_ID 
		General Ledger Category
	  */
	public void setGL_Category_ID (int GL_Category_ID)
	{
		if (GL_Category_ID < 1) 
			set_Value (COLUMNNAME_GL_Category_ID, null);
		else 
			set_Value (COLUMNNAME_GL_Category_ID, Integer.valueOf(GL_Category_ID));
	}

	/** Get GL Category.
		@return General Ledger Category
	  */
	public int getGL_Category_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_GL_Category_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set GL Journal Generator.
		@param GL_JournalGenerator_ID GL Journal Generator	  */
	public void setGL_JournalGenerator_ID (int GL_JournalGenerator_ID)
	{
		if (GL_JournalGenerator_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_GL_JournalGenerator_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_GL_JournalGenerator_ID, Integer.valueOf(GL_JournalGenerator_ID));
	}

	/** Get GL Journal Generator.
		@return GL Journal Generator	  */
	public int getGL_JournalGenerator_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_GL_JournalGenerator_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set GL_JournalGenerator_UU.
		@param GL_JournalGenerator_UU GL_JournalGenerator_UU	  */
	public void setGL_JournalGenerator_UU (String GL_JournalGenerator_UU)
	{
		set_Value (COLUMNNAME_GL_JournalGenerator_UU, GL_JournalGenerator_UU);
	}

	/** Get GL_JournalGenerator_UU.
		@return GL_JournalGenerator_UU	  */
	public String getGL_JournalGenerator_UU () 
	{
		return (String)get_Value(COLUMNNAME_GL_JournalGenerator_UU);
	}

	/** Set Comment/Help.
		@param Help 
		Comment or Hint
	  */
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp () 
	{
		return (String)get_Value(COLUMNNAME_Help);
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** PostingType AD_Reference_ID=125 */
	public static final int POSTINGTYPE_AD_Reference_ID=125;
	/** Actual = A */
	public static final String POSTINGTYPE_Actual = "A";
	/** Budget = B */
	public static final String POSTINGTYPE_Budget = "B";
	/** Commitment = E */
	public static final String POSTINGTYPE_Commitment = "E";
	/** Statistical = S */
	public static final String POSTINGTYPE_Statistical = "S";
	/** Reservation = R */
	public static final String POSTINGTYPE_Reservation = "R";
	/** Set PostingType.
		@param PostingType 
		The type of posted amount for the transaction
	  */
	public void setPostingType (String PostingType)
	{

		set_Value (COLUMNNAME_PostingType, PostingType);
	}

	/** Get PostingType.
		@return The type of posted amount for the transaction
	  */
	public String getPostingType () 
	{
		return (String)get_Value(COLUMNNAME_PostingType);
	}
}