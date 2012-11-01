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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

/** Generated Model for GL_JournalGeneratorLine
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_GL_JournalGeneratorLine extends PO implements I_GL_JournalGeneratorLine, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121031L;

    /** Standard Constructor */
    public X_GL_JournalGeneratorLine (Properties ctx, int GL_JournalGeneratorLine_ID, String trxName)
    {
      super (ctx, GL_JournalGeneratorLine_ID, trxName);
      /** if (GL_JournalGeneratorLine_ID == 0)
        {
			setGL_JournalGenerator_ID (0);
			setGL_JournalGeneratorLine_ID (0);
			setIsCopyAllDimensions (false);
// N
			setIsSameProduct (false);
// N
			setSeqNo (0);
// @SQL=SELECT NVL(MAX(SeqNo),0)+10 AS DefaultValue FROM GL_JournalGeneratorLine WHERE GL_JournalGenerator_ID=@GL_JournalGenerator_ID@
        } */
    }

    /** Load Constructor */
    public X_GL_JournalGeneratorLine (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_GL_JournalGeneratorLine[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Multiplier Amount.
		@param AmtMultiplier 
		Multiplier Amount for generating commissions
	  */
	public void setAmtMultiplier (BigDecimal AmtMultiplier)
	{
		set_Value (COLUMNNAME_AmtMultiplier, AmtMultiplier);
	}

	/** Get Multiplier Amount.
		@return Multiplier Amount for generating commissions
	  */
	public BigDecimal getAmtMultiplier () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AmtMultiplier);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set BP Column.
		@param BPColumn BP Column	  */
	public void setBPColumn (String BPColumn)
	{
		set_Value (COLUMNNAME_BPColumn, BPColumn);
	}

	/** Get BP Column.
		@return BP Column	  */
	public String getBPColumn () 
	{
		return (String)get_Value(COLUMNNAME_BPColumn);
	}

	/** BPDimensionType AD_Reference_ID=200008 */
	public static final int BPDIMENSIONTYPE_AD_Reference_ID=200008;
	/** Column = C */
	public static final String BPDIMENSIONTYPE_Column = "C";
	/** Fixed = F */
	public static final String BPDIMENSIONTYPE_Fixed = "F";
	/** Same = S */
	public static final String BPDIMENSIONTYPE_Same = "S";
	/** Set Type of BP Dimension.
		@param BPDimensionType Type of BP Dimension	  */
	public void setBPDimensionType (String BPDimensionType)
	{

		set_Value (COLUMNNAME_BPDimensionType, BPDimensionType);
	}

	/** Get Type of BP Dimension.
		@return Type of BP Dimension	  */
	public String getBPDimensionType () 
	{
		return (String)get_Value(COLUMNNAME_BPDimensionType);
	}

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_Name)
			.getPO(getC_BPartner_ID(), get_TrxName());	}

	/** Set Business Partner .
		@param C_BPartner_ID 
		Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID)
	{
		if (C_BPartner_ID < 1) 
			set_Value (COLUMNNAME_C_BPartner_ID, null);
		else 
			set_Value (COLUMNNAME_C_BPartner_ID, Integer.valueOf(C_BPartner_ID));
	}

	/** Get Business Partner .
		@return Identifies a Business Partner
	  */
	public int getC_BPartner_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_ElementValue getC_ElementValueCR() throws RuntimeException
    {
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_Name)
			.getPO(getC_ElementValueCR_ID(), get_TrxName());	}

	/** Set Account CR.
		@param C_ElementValueCR_ID Account CR	  */
	public void setC_ElementValueCR_ID (int C_ElementValueCR_ID)
	{
		if (C_ElementValueCR_ID < 1) 
			set_Value (COLUMNNAME_C_ElementValueCR_ID, null);
		else 
			set_Value (COLUMNNAME_C_ElementValueCR_ID, Integer.valueOf(C_ElementValueCR_ID));
	}

	/** Get Account CR.
		@return Account CR	  */
	public int getC_ElementValueCR_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ElementValueCR_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_ElementValue getC_ElementValueDR() throws RuntimeException
    {
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_Name)
			.getPO(getC_ElementValueDR_ID(), get_TrxName());	}

	/** Set Account DR.
		@param C_ElementValueDR_ID Account DR	  */
	public void setC_ElementValueDR_ID (int C_ElementValueDR_ID)
	{
		if (C_ElementValueDR_ID < 1) 
			set_Value (COLUMNNAME_C_ElementValueDR_ID, null);
		else 
			set_Value (COLUMNNAME_C_ElementValueDR_ID, Integer.valueOf(C_ElementValueDR_ID));
	}

	/** Get Account DR.
		@return Account DR	  */
	public int getC_ElementValueDR_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ElementValueDR_ID);
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

	public org.compiere.model.I_GL_JournalGenerator getGL_JournalGenerator() throws RuntimeException
    {
		return (org.compiere.model.I_GL_JournalGenerator)MTable.get(getCtx(), org.compiere.model.I_GL_JournalGenerator.Table_Name)
			.getPO(getGL_JournalGenerator_ID(), get_TrxName());	}

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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getGL_JournalGenerator_ID()));
    }

	/** Set Generator Line.
		@param GL_JournalGeneratorLine_ID Generator Line	  */
	public void setGL_JournalGeneratorLine_ID (int GL_JournalGeneratorLine_ID)
	{
		if (GL_JournalGeneratorLine_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_GL_JournalGeneratorLine_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_GL_JournalGeneratorLine_ID, Integer.valueOf(GL_JournalGeneratorLine_ID));
	}

	/** Get Generator Line.
		@return Generator Line	  */
	public int getGL_JournalGeneratorLine_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_GL_JournalGeneratorLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set GL_JournalGeneratorLine_UU.
		@param GL_JournalGeneratorLine_UU GL_JournalGeneratorLine_UU	  */
	public void setGL_JournalGeneratorLine_UU (String GL_JournalGeneratorLine_UU)
	{
		set_Value (COLUMNNAME_GL_JournalGeneratorLine_UU, GL_JournalGeneratorLine_UU);
	}

	/** Get GL_JournalGeneratorLine_UU.
		@return GL_JournalGeneratorLine_UU	  */
	public String getGL_JournalGeneratorLine_UU () 
	{
		return (String)get_Value(COLUMNNAME_GL_JournalGeneratorLine_UU);
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

	/** Set Copy All Dimensions.
		@param IsCopyAllDimensions Copy All Dimensions	  */
	public void setIsCopyAllDimensions (boolean IsCopyAllDimensions)
	{
		set_Value (COLUMNNAME_IsCopyAllDimensions, Boolean.valueOf(IsCopyAllDimensions));
	}

	/** Get Copy All Dimensions.
		@return Copy All Dimensions	  */
	public boolean isCopyAllDimensions () 
	{
		Object oo = get_Value(COLUMNNAME_IsCopyAllDimensions);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Same Product.
		@param IsSameProduct Same Product	  */
	public void setIsSameProduct (boolean IsSameProduct)
	{
		set_Value (COLUMNNAME_IsSameProduct, Boolean.valueOf(IsSameProduct));
	}

	/** Get Same Product.
		@return Same Product	  */
	public boolean isSameProduct () 
	{
		Object oo = get_Value(COLUMNNAME_IsSameProduct);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Round Factor.
		@param RoundFactor Round Factor	  */
	public void setRoundFactor (int RoundFactor)
	{
		set_Value (COLUMNNAME_RoundFactor, Integer.valueOf(RoundFactor));
	}

	/** Get Round Factor.
		@return Round Factor	  */
	public int getRoundFactor () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_RoundFactor);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
}