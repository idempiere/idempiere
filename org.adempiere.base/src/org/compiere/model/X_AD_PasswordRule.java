/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2007 ComPiere, Inc. All Rights Reserved.                *
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

/** Generated Model for AD_PasswordRule
 *  @author Adempiere (generated) 
 *  @version Release 3.6.0LTS - $Id$ */
public class X_AD_PasswordRule extends PO implements I_AD_PasswordRule, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20120802L;

    /** Standard Constructor */
    public X_AD_PasswordRule (Properties ctx, int AD_PasswordRule_ID, String trxName)
    {
      super (ctx, AD_PasswordRule_ID, trxName);
      /** if (AD_PasswordRule_ID == 0)
        {
			setAD_PasswordRule_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_PasswordRule (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_PasswordRule[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set AD_PasswordRule.
		@param AD_PasswordRule_ID AD_PasswordRule	  */
	public void setAD_PasswordRule_ID (int AD_PasswordRule_ID)
	{
		if (AD_PasswordRule_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_PasswordRule_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_PasswordRule_ID, Integer.valueOf(AD_PasswordRule_ID));
	}

	/** Get AD_PasswordRule.
		@return AD_PasswordRule	  */
	public int getAD_PasswordRule_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PasswordRule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_PasswordRule_UU.
		@param AD_PasswordRule_UU AD_PasswordRule_UU	  */
	public void setAD_PasswordRule_UU (String AD_PasswordRule_UU)
	{
		set_Value (COLUMNNAME_AD_PasswordRule_UU, AD_PasswordRule_UU);
	}

	/** Get AD_PasswordRule_UU.
		@return AD_PasswordRule_UU	  */
	public String getAD_PasswordRule_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_PasswordRule_UU);
	}

	/** Set Alphabetical Character.
		@param AlphabeticalCharacter Alphabetical Character	  */
	public void setAlphabeticalCharacter (int AlphabeticalCharacter)
	{
		set_Value (COLUMNNAME_AlphabeticalCharacter, Integer.valueOf(AlphabeticalCharacter));
	}

	/** Get Alphabetical Character.
		@return Alphabetical Character	  */
	public int getAlphabeticalCharacter () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AlphabeticalCharacter);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Alphabetical Sequence.
		@param AlphabeticalSequence 
		Allow alphabetical sequences
	  */
	public void setAlphabeticalSequence (boolean AlphabeticalSequence)
	{
		set_Value (COLUMNNAME_AlphabeticalSequence, Boolean.valueOf(AlphabeticalSequence));
	}

	/** Get Alphabetical Sequence.
		@return Allow alphabetical sequences
	  */
	public boolean isAlphabeticalSequence () 
	{
		Object oo = get_Value(COLUMNNAME_AlphabeticalSequence);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Match Backwards of Dictionary.
		@param DictMatchBackwards 
		Match dictionary words backwards
	  */
	public void setDictMatchBackwards (boolean DictMatchBackwards)
	{
		set_Value (COLUMNNAME_DictMatchBackwards, Boolean.valueOf(DictMatchBackwards));
	}

	/** Get Match Backwards of Dictionary.
		@return Match dictionary words backwards
	  */
	public boolean isDictMatchBackwards () 
	{
		Object oo = get_Value(COLUMNNAME_DictMatchBackwards);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Word Length Dictionary.
		@param DictWordLength Word Length Dictionary	  */
	public void setDictWordLength (int DictWordLength)
	{
		set_Value (COLUMNNAME_DictWordLength, Integer.valueOf(DictWordLength));
	}

	/** Get Word Length Dictionary.
		@return Word Length Dictionary	  */
	public int getDictWordLength () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_DictWordLength);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Digit Character.
		@param DigitCharacter 
		Require at least # digit in passwords
	  */
	public void setDigitCharacter (int DigitCharacter)
	{
		set_Value (COLUMNNAME_DigitCharacter, Integer.valueOf(DigitCharacter));
	}

	/** Get Digit Character.
		@return Require at least # digit in passwords
	  */
	public int getDigitCharacter () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_DigitCharacter);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Lowercase Character.
		@param LowercaseCharacter 
		Require at least # lower case char
	  */
	public void setLowercaseCharacter (int LowercaseCharacter)
	{
		set_Value (COLUMNNAME_LowercaseCharacter, Integer.valueOf(LowercaseCharacter));
	}

	/** Get Lowercase Character.
		@return Require at least # lower case char
	  */
	public int getLowercaseCharacter () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_LowercaseCharacter);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Maximum Length.
		@param MaxLength 
		Maximum Length of Data
	  */
	public void setMaxLength (int MaxLength)
	{
		set_Value (COLUMNNAME_MaxLength, Integer.valueOf(MaxLength));
	}

	/** Get Maximum Length.
		@return Maximum Length of Data
	  */
	public int getMaxLength () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MaxLength);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Min Length.
		@param MinLength Min Length	  */
	public void setMinLength (int MinLength)
	{
		set_Value (COLUMNNAME_MinLength, Integer.valueOf(MinLength));
	}

	/** Get Min Length.
		@return Min Length	  */
	public int getMinLength () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_MinLength);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set Non Alpha Numeric Character.
		@param NonAlphaNumericCharacter 
		Require at least # non-alphanumeric char
	  */
	public void setNonAlphaNumericCharacter (int NonAlphaNumericCharacter)
	{
		set_Value (COLUMNNAME_NonAlphaNumericCharacter, Integer.valueOf(NonAlphaNumericCharacter));
	}

	/** Get Non Alpha Numeric Character.
		@return Require at least # non-alphanumeric char
	  */
	public int getNonAlphaNumericCharacter () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_NonAlphaNumericCharacter);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Numerical Sequence.
		@param NumericalSequence 
		Allow numerical sequences of length #
	  */
	public void setNumericalSequence (int NumericalSequence)
	{
		set_Value (COLUMNNAME_NumericalSequence, Integer.valueOf(NumericalSequence));
	}

	/** Get Numerical Sequence.
		@return Allow numerical sequences of length #
	  */
	public int getNumericalSequence () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_NumericalSequence);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Path Dictionary.
		@param PathDictionary Path Dictionary	  */
	public void setPathDictionary (String PathDictionary)
	{
		set_Value (COLUMNNAME_PathDictionary, PathDictionary);
	}

	/** Get Path Dictionary.
		@return Path Dictionary	  */
	public String getPathDictionary () 
	{
		return (String)get_Value(COLUMNNAME_PathDictionary);
	}

	/** Set QWERTY Sequence.
		@param QWERTYSequence 
		Allow QWERTY sequences
	  */
	public void setQWERTYSequence (boolean QWERTYSequence)
	{
		set_Value (COLUMNNAME_QWERTYSequence, Boolean.valueOf(QWERTYSequence));
	}

	/** Get QWERTY Sequence.
		@return Allow QWERTY sequences
	  */
	public boolean isQWERTYSequence () 
	{
		Object oo = get_Value(COLUMNNAME_QWERTYSequence);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Repeat Character Regex.
		@param RepeatCharacterRegex Repeat Character Regex	  */
	public void setRepeatCharacterRegex (int RepeatCharacterRegex)
	{
		set_Value (COLUMNNAME_RepeatCharacterRegex, Integer.valueOf(RepeatCharacterRegex));
	}

	/** Get Repeat Character Regex.
		@return Repeat Character Regex	  */
	public int getRepeatCharacterRegex () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_RepeatCharacterRegex);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Uppercase Character.
		@param UppercaseCharacter 
		Require at least # upper case char
	  */
	public void setUppercaseCharacter (int UppercaseCharacter)
	{
		set_Value (COLUMNNAME_UppercaseCharacter, Integer.valueOf(UppercaseCharacter));
	}

	/** Get Uppercase Character.
		@return Require at least # upper case char
	  */
	public int getUppercaseCharacter () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_UppercaseCharacter);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Registered EMail.
		@param UserName 
		Email of the responsible for the System
	  */
	public void setUserName (boolean UserName)
	{
		set_Value (COLUMNNAME_UserName, Boolean.valueOf(UserName));
	}

	/** Get Registered EMail.
		@return Email of the responsible for the System
	  */
	public boolean isUserName () 
	{
		Object oo = get_Value(COLUMNNAME_UserName);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Using Dictionary.
		@param UsingDictionary Using Dictionary	  */
	public void setUsingDictionary (boolean UsingDictionary)
	{
		set_Value (COLUMNNAME_UsingDictionary, Boolean.valueOf(UsingDictionary));
	}

	/** Get Using Dictionary.
		@return Using Dictionary	  */
	public boolean isUsingDictionary () 
	{
		Object oo = get_Value(COLUMNNAME_UsingDictionary);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set whitespace.
		@param whitespace whitespace	  */
	public void setwhitespace (boolean whitespace)
	{
		set_Value (COLUMNNAME_whitespace, Boolean.valueOf(whitespace));
	}

	/** Get whitespace.
		@return whitespace	  */
	public boolean iswhitespace () 
	{
		Object oo = get_Value(COLUMNNAME_whitespace);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}
}