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

/** Generated Interface for GL_JournalGeneratorLine
 *  @author iDempiere (generated) 
 *  @version Release 1.0a
 */
public interface I_GL_JournalGeneratorLine 
{

    /** TableName=GL_JournalGeneratorLine */
    public static final String Table_Name = "GL_JournalGeneratorLine";

    /** AD_Table_ID=200022 */
    public static final int Table_ID = 200022;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 3 - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(3);

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

    /** Column name AmtMultiplier */
    public static final String COLUMNNAME_AmtMultiplier = "AmtMultiplier";

	/** Set Multiplier Amount.
	  * Multiplier Amount for generating commissions
	  */
	public void setAmtMultiplier (BigDecimal AmtMultiplier);

	/** Get Multiplier Amount.
	  * Multiplier Amount for generating commissions
	  */
	public BigDecimal getAmtMultiplier();

    /** Column name BPColumn */
    public static final String COLUMNNAME_BPColumn = "BPColumn";

	/** Set BP Column	  */
	public void setBPColumn (String BPColumn);

	/** Get BP Column	  */
	public String getBPColumn();

    /** Column name BPDimensionType */
    public static final String COLUMNNAME_BPDimensionType = "BPDimensionType";

	/** Set Type of BP Dimension	  */
	public void setBPDimensionType (String BPDimensionType);

	/** Get Type of BP Dimension	  */
	public String getBPDimensionType();

    /** Column name C_BPartner_ID */
    public static final String COLUMNNAME_C_BPartner_ID = "C_BPartner_ID";

	/** Set Business Partner .
	  * Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID);

	/** Get Business Partner .
	  * Identifies a Business Partner
	  */
	public int getC_BPartner_ID();

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException;

    /** Column name C_ElementValueCR_ID */
    public static final String COLUMNNAME_C_ElementValueCR_ID = "C_ElementValueCR_ID";

	/** Set Account CR	  */
	public void setC_ElementValueCR_ID (int C_ElementValueCR_ID);

	/** Get Account CR	  */
	public int getC_ElementValueCR_ID();

	public org.compiere.model.I_C_ElementValue getC_ElementValueCR() throws RuntimeException;

    /** Column name C_ElementValueDR_ID */
    public static final String COLUMNNAME_C_ElementValueDR_ID = "C_ElementValueDR_ID";

	/** Set Account DR	  */
	public void setC_ElementValueDR_ID (int C_ElementValueDR_ID);

	/** Get Account DR	  */
	public int getC_ElementValueDR_ID();

	public org.compiere.model.I_C_ElementValue getC_ElementValueDR() throws RuntimeException;

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

    /** Column name Description */
    public static final String COLUMNNAME_Description = "Description";

	/** Set Description.
	  * Optional short description of the record
	  */
	public void setDescription (String Description);

	/** Get Description.
	  * Optional short description of the record
	  */
	public String getDescription();

    /** Column name GL_JournalGenerator_ID */
    public static final String COLUMNNAME_GL_JournalGenerator_ID = "GL_JournalGenerator_ID";

	/** Set GL Journal Generator	  */
	public void setGL_JournalGenerator_ID (int GL_JournalGenerator_ID);

	/** Get GL Journal Generator	  */
	public int getGL_JournalGenerator_ID();

	public org.compiere.model.I_GL_JournalGenerator getGL_JournalGenerator() throws RuntimeException;

    /** Column name GL_JournalGeneratorLine_ID */
    public static final String COLUMNNAME_GL_JournalGeneratorLine_ID = "GL_JournalGeneratorLine_ID";

	/** Set Generator Line	  */
	public void setGL_JournalGeneratorLine_ID (int GL_JournalGeneratorLine_ID);

	/** Get Generator Line	  */
	public int getGL_JournalGeneratorLine_ID();

    /** Column name GL_JournalGeneratorLine_UU */
    public static final String COLUMNNAME_GL_JournalGeneratorLine_UU = "GL_JournalGeneratorLine_UU";

	/** Set GL_JournalGeneratorLine_UU	  */
	public void setGL_JournalGeneratorLine_UU (String GL_JournalGeneratorLine_UU);

	/** Get GL_JournalGeneratorLine_UU	  */
	public String getGL_JournalGeneratorLine_UU();

    /** Column name Help */
    public static final String COLUMNNAME_Help = "Help";

	/** Set Comment/Help.
	  * Comment or Hint
	  */
	public void setHelp (String Help);

	/** Get Comment/Help.
	  * Comment or Hint
	  */
	public String getHelp();

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

    /** Column name IsCopyAllDimensions */
    public static final String COLUMNNAME_IsCopyAllDimensions = "IsCopyAllDimensions";

	/** Set Copy All Dimensions	  */
	public void setIsCopyAllDimensions (boolean IsCopyAllDimensions);

	/** Get Copy All Dimensions	  */
	public boolean isCopyAllDimensions();

    /** Column name IsSameProduct */
    public static final String COLUMNNAME_IsSameProduct = "IsSameProduct";

	/** Set Same Product	  */
	public void setIsSameProduct (boolean IsSameProduct);

	/** Get Same Product	  */
	public boolean isSameProduct();

    /** Column name RoundFactor */
    public static final String COLUMNNAME_RoundFactor = "RoundFactor";

	/** Set Round Factor	  */
	public void setRoundFactor (int RoundFactor);

	/** Get Round Factor	  */
	public int getRoundFactor();

    /** Column name SeqNo */
    public static final String COLUMNNAME_SeqNo = "SeqNo";

	/** Set Sequence.
	  * Method of ordering records;
 lowest number comes first
	  */
	public void setSeqNo (int SeqNo);

	/** Get Sequence.
	  * Method of ordering records;
 lowest number comes first
	  */
	public int getSeqNo();

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
}
