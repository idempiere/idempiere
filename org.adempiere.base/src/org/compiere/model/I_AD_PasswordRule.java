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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import org.compiere.util.KeyNamePair;

/** Generated Interface for AD_PasswordRule
 *  @author iDempiere (generated) 
 *  @version Release 1.0c
 */
public interface I_AD_PasswordRule 
{

    /** TableName=AD_PasswordRule */
    public static final String Table_Name = "AD_PasswordRule";

    /** AD_Table_ID=200005 */
    public static final int Table_ID = 200005;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 4 - System 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(4);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within client
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within client
	  */
	public int getAD_Org_ID();

    /** Column name AD_PasswordRule_ID */
    public static final String COLUMNNAME_AD_PasswordRule_ID = "AD_PasswordRule_ID";

	/** Set Password Policies	  */
	public void setAD_PasswordRule_ID (int AD_PasswordRule_ID);

	/** Get Password Policies	  */
	public int getAD_PasswordRule_ID();

    /** Column name AD_PasswordRule_UU */
    public static final String COLUMNNAME_AD_PasswordRule_UU = "AD_PasswordRule_UU";

	/** Set AD_PasswordRule_UU	  */
	public void setAD_PasswordRule_UU (String AD_PasswordRule_UU);

	/** Get AD_PasswordRule_UU	  */
	public String getAD_PasswordRule_UU();

    /** Column name AlphabeticalCharacter */
    public static final String COLUMNNAME_AlphabeticalCharacter = "AlphabeticalCharacter";

	/** Set Alphabetical Character.
	  * Require at least # alphabetical in passwords
	  */
	public void setAlphabeticalCharacter (int AlphabeticalCharacter);

	/** Get Alphabetical Character.
	  * Require at least # alphabetical in passwords
	  */
	public int getAlphabeticalCharacter();

    /** Column name AlphabeticalSequence */
    public static final String COLUMNNAME_AlphabeticalSequence = "AlphabeticalSequence";

	/** Set Alphabetical Sequence.
	  * Lenght of alphabetical sequence to validate
	  */
	public void setAlphabeticalSequence (int AlphabeticalSequence);

	/** Get Alphabetical Sequence.
	  * Lenght of alphabetical sequence to validate
	  */
	public int getAlphabeticalSequence();

    /** Column name Created */
    public static final String COLUMNNAME_Created = "Created";

	/** Get Created.
	  * Date this record was created
	  */
	public Timestamp getCreated();

    /** Column name CreatedBy */
    public static final String COLUMNNAME_CreatedBy = "CreatedBy";

	/** Get Created By.
	  * User who created this records
	  */
	public int getCreatedBy();

    /** Column name DictWordLength */
    public static final String COLUMNNAME_DictWordLength = "DictWordLength";

	/** Set Word Length Dictionary	  */
	public void setDictWordLength (int DictWordLength);

	/** Get Word Length Dictionary	  */
	public int getDictWordLength();

    /** Column name DigitCharacter */
    public static final String COLUMNNAME_DigitCharacter = "DigitCharacter";

	/** Set Digit Character.
	  * Require at least # digit in passwords
	  */
	public void setDigitCharacter (int DigitCharacter);

	/** Get Digit Character.
	  * Require at least # digit in passwords
	  */
	public int getDigitCharacter();

    /** Column name IsActive */
    public static final String COLUMNNAME_IsActive = "IsActive";

	/** Set Active.
	  * The record is active in the system
	  */
	public void setIsActive (boolean IsActive);

	/** Get Active.
	  * The record is active in the system
	  */
	public boolean isActive();

    /** Column name IsDictMatchBackwards */
    public static final String COLUMNNAME_IsDictMatchBackwards = "IsDictMatchBackwards";

	/** Set Match Backwards of Dictionary.
	  * Match dictionary words backwards
	  */
	public void setIsDictMatchBackwards (boolean IsDictMatchBackwards);

	/** Get Match Backwards of Dictionary.
	  * Match dictionary words backwards
	  */
	public boolean isDictMatchBackwards();

    /** Column name IsUserNameRule */
    public static final String COLUMNNAME_IsUserNameRule = "IsUserNameRule";

	/** Set User Name Rule.
	  * Validate the password doesn't contain user name (ignore case and match backwards)
	  */
	public void setIsUserNameRule (boolean IsUserNameRule);

	/** Get User Name Rule.
	  * Validate the password doesn't contain user name (ignore case and match backwards)
	  */
	public boolean isUserNameRule();

    /** Column name IsUsingDictionary */
    public static final String COLUMNNAME_IsUsingDictionary = "IsUsingDictionary";

	/** Set Using Dictionary	  */
	public void setIsUsingDictionary (boolean IsUsingDictionary);

	/** Get Using Dictionary	  */
	public boolean isUsingDictionary();

    /** Column name IsWhitespace */
    public static final String COLUMNNAME_IsWhitespace = "IsWhitespace";

	/** Set Whitespace.
	  * Whitespace validation
	  */
	public void setIsWhitespace (boolean IsWhitespace);

	/** Get Whitespace.
	  * Whitespace validation
	  */
	public boolean isWhitespace();

    /** Column name LowercaseCharacter */
    public static final String COLUMNNAME_LowercaseCharacter = "LowercaseCharacter";

	/** Set Lowercase Character.
	  * Require at least # lower case char
	  */
	public void setLowercaseCharacter (int LowercaseCharacter);

	/** Get Lowercase Character.
	  * Require at least # lower case char
	  */
	public int getLowercaseCharacter();

    /** Column name MaxLength */
    public static final String COLUMNNAME_MaxLength = "MaxLength";

	/** Set Maximum Length.
	  * Maximum Length of Data
	  */
	public void setMaxLength (int MaxLength);

	/** Get Maximum Length.
	  * Maximum Length of Data
	  */
	public int getMaxLength();

    /** Column name MinLength */
    public static final String COLUMNNAME_MinLength = "MinLength";

	/** Set Minimum Length	  */
	public void setMinLength (int MinLength);

	/** Get Minimum Length	  */
	public int getMinLength();

    /** Column name Name */
    public static final String COLUMNNAME_Name = "Name";

	/** Set Name.
	  * Alphanumeric identifier of the entity
	  */
	public void setName (String Name);

	/** Get Name.
	  * Alphanumeric identifier of the entity
	  */
	public String getName();

    /** Column name NonAlphaNumericCharacter */
    public static final String COLUMNNAME_NonAlphaNumericCharacter = "NonAlphaNumericCharacter";

	/** Set Non Alpha Numeric Character.
	  * Require at least # non-alphanumeric char
	  */
	public void setNonAlphaNumericCharacter (int NonAlphaNumericCharacter);

	/** Get Non Alpha Numeric Character.
	  * Require at least # non-alphanumeric char
	  */
	public int getNonAlphaNumericCharacter();

    /** Column name NumericalSequence */
    public static final String COLUMNNAME_NumericalSequence = "NumericalSequence";

	/** Set Numerical Sequence.
	  * Length of numerical sequence to validate
	  */
	public void setNumericalSequence (int NumericalSequence);

	/** Get Numerical Sequence.
	  * Length of numerical sequence to validate
	  */
	public int getNumericalSequence();

    /** Column name PathDictionary */
    public static final String COLUMNNAME_PathDictionary = "PathDictionary";

	/** Set Path Dictionary	  */
	public void setPathDictionary (String PathDictionary);

	/** Get Path Dictionary	  */
	public String getPathDictionary();

    /** Column name QWERTYSequence */
    public static final String COLUMNNAME_QWERTYSequence = "QWERTYSequence";

	/** Set QWERTY Sequence.
	  * Lenght of QWERTY sequences to validate
	  */
	public void setQWERTYSequence (int QWERTYSequence);

	/** Get QWERTY Sequence.
	  * Lenght of QWERTY sequences to validate
	  */
	public int getQWERTYSequence();

    /** Column name RepeatCharacterRegex */
    public static final String COLUMNNAME_RepeatCharacterRegex = "RepeatCharacterRegex";

	/** Set Repeat Character Regex.
	  * Length of repeated characters to validate
	  */
	public void setRepeatCharacterRegex (int RepeatCharacterRegex);

	/** Get Repeat Character Regex.
	  * Length of repeated characters to validate
	  */
	public int getRepeatCharacterRegex();

    /** Column name Updated */
    public static final String COLUMNNAME_Updated = "Updated";

	/** Get Updated.
	  * Date this record was updated
	  */
	public Timestamp getUpdated();

    /** Column name UpdatedBy */
    public static final String COLUMNNAME_UpdatedBy = "UpdatedBy";

	/** Get Updated By.
	  * User who updated this records
	  */
	public int getUpdatedBy();

    /** Column name UppercaseCharacter */
    public static final String COLUMNNAME_UppercaseCharacter = "UppercaseCharacter";

	/** Set Uppercase Character.
	  * Require at least # upper case char
	  */
	public void setUppercaseCharacter (int UppercaseCharacter);

	/** Get Uppercase Character.
	  * Require at least # upper case char
	  */
	public int getUppercaseCharacter();
}
