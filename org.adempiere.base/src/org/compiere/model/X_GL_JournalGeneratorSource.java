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

/** Generated Model for GL_JournalGeneratorSource
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_GL_JournalGeneratorSource extends PO implements I_GL_JournalGeneratorSource, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130626L;

    /** Standard Constructor */
    public X_GL_JournalGeneratorSource (Properties ctx, int GL_JournalGeneratorSource_ID, String trxName)
    {
      super (ctx, GL_JournalGeneratorSource_ID, trxName);
      /** if (GL_JournalGeneratorSource_ID == 0)
        {
			setAmtMultiplier (Env.ZERO);
// 1
			setC_ElementValue_ID (0);
			setGL_JournalGeneratorLine_ID (0);
			setGL_JournalGeneratorSource_ID (0);
        } */
    }

    /** Load Constructor */
    public X_GL_JournalGeneratorSource (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_GL_JournalGeneratorSource[")
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

	public org.compiere.model.I_C_ElementValue getC_ElementValue() throws RuntimeException
    {
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_Name)
			.getPO(getC_ElementValue_ID(), get_TrxName());	}

	/** Set Account Element.
		@param C_ElementValue_ID 
		Account Element
	  */
	public void setC_ElementValue_ID (int C_ElementValue_ID)
	{
		if (C_ElementValue_ID < 1) 
			set_Value (COLUMNNAME_C_ElementValue_ID, null);
		else 
			set_Value (COLUMNNAME_C_ElementValue_ID, Integer.valueOf(C_ElementValue_ID));
	}

	/** Get Account Element.
		@return Account Element
	  */
	public int getC_ElementValue_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ElementValue_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	public org.compiere.model.I_GL_JournalGeneratorLine getGL_JournalGeneratorLine() throws RuntimeException
    {
		return (org.compiere.model.I_GL_JournalGeneratorLine)MTable.get(getCtx(), org.compiere.model.I_GL_JournalGeneratorLine.Table_Name)
			.getPO(getGL_JournalGeneratorLine_ID(), get_TrxName());	}

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

	/** Set Generator Source.
		@param GL_JournalGeneratorSource_ID Generator Source	  */
	public void setGL_JournalGeneratorSource_ID (int GL_JournalGeneratorSource_ID)
	{
		if (GL_JournalGeneratorSource_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_GL_JournalGeneratorSource_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_GL_JournalGeneratorSource_ID, Integer.valueOf(GL_JournalGeneratorSource_ID));
	}

	/** Get Generator Source.
		@return Generator Source	  */
	public int getGL_JournalGeneratorSource_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_GL_JournalGeneratorSource_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set GL_JournalGeneratorSource_UU.
		@param GL_JournalGeneratorSource_UU GL_JournalGeneratorSource_UU	  */
	public void setGL_JournalGeneratorSource_UU (String GL_JournalGeneratorSource_UU)
	{
		set_Value (COLUMNNAME_GL_JournalGeneratorSource_UU, GL_JournalGeneratorSource_UU);
	}

	/** Get GL_JournalGeneratorSource_UU.
		@return GL_JournalGeneratorSource_UU	  */
	public String getGL_JournalGeneratorSource_UU () 
	{
		return (String)get_Value(COLUMNNAME_GL_JournalGeneratorSource_UU);
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
}