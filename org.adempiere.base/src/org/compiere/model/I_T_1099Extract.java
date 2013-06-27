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

/** Generated Interface for T_1099Extract
 *  @author iDempiere (generated) 
 *  @version Release 1.0c
 */
public interface I_T_1099Extract 
{

    /** TableName=T_1099Extract */
    public static final String Table_Name = "T_1099Extract";

    /** AD_Table_ID=200067 */
    public static final int Table_ID = 200067;

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

    /** Column name AD_PInstance_ID */
    public static final String COLUMNNAME_AD_PInstance_ID = "AD_PInstance_ID";

	/** Set Process Instance.
	  * Instance of the process
	  */
	public void setAD_PInstance_ID (int AD_PInstance_ID);

	/** Get Process Instance.
	  * Instance of the process
	  */
	public int getAD_PInstance_ID();

	public org.compiere.model.I_AD_PInstance getAD_PInstance() throws RuntimeException;

    /** Column name AmtBucket01 */
    public static final String COLUMNNAME_AmtBucket01 = "AmtBucket01";

	/** Set Amount Bucket 1	  */
	public void setAmtBucket01 (BigDecimal AmtBucket01);

	/** Get Amount Bucket 1	  */
	public BigDecimal getAmtBucket01();

    /** Column name AmtBucket02 */
    public static final String COLUMNNAME_AmtBucket02 = "AmtBucket02";

	/** Set Amount Bucket 2	  */
	public void setAmtBucket02 (BigDecimal AmtBucket02);

	/** Get Amount Bucket 2	  */
	public BigDecimal getAmtBucket02();

    /** Column name AmtBucket03 */
    public static final String COLUMNNAME_AmtBucket03 = "AmtBucket03";

	/** Set Amount Bucket 3	  */
	public void setAmtBucket03 (BigDecimal AmtBucket03);

	/** Get Amount Bucket 3	  */
	public BigDecimal getAmtBucket03();

    /** Column name AmtBucket04 */
    public static final String COLUMNNAME_AmtBucket04 = "AmtBucket04";

	/** Set Amount Bucket 4	  */
	public void setAmtBucket04 (BigDecimal AmtBucket04);

	/** Get Amount Bucket 4	  */
	public BigDecimal getAmtBucket04();

    /** Column name AmtBucket05 */
    public static final String COLUMNNAME_AmtBucket05 = "AmtBucket05";

	/** Set Amount Bucket 5	  */
	public void setAmtBucket05 (BigDecimal AmtBucket05);

	/** Get Amount Bucket 5	  */
	public BigDecimal getAmtBucket05();

    /** Column name AmtBucket06 */
    public static final String COLUMNNAME_AmtBucket06 = "AmtBucket06";

	/** Set Amount Bucket 6	  */
	public void setAmtBucket06 (BigDecimal AmtBucket06);

	/** Get Amount Bucket 6	  */
	public BigDecimal getAmtBucket06();

    /** Column name AmtBucket07 */
    public static final String COLUMNNAME_AmtBucket07 = "AmtBucket07";

	/** Set Amount Bucket 7	  */
	public void setAmtBucket07 (BigDecimal AmtBucket07);

	/** Get Amount Bucket 7	  */
	public BigDecimal getAmtBucket07();

    /** Column name AmtBucket08 */
    public static final String COLUMNNAME_AmtBucket08 = "AmtBucket08";

	/** Set Amount Bucket 8	  */
	public void setAmtBucket08 (BigDecimal AmtBucket08);

	/** Get Amount Bucket 8	  */
	public BigDecimal getAmtBucket08();

    /** Column name AmtBucket09 */
    public static final String COLUMNNAME_AmtBucket09 = "AmtBucket09";

	/** Set Amount Bucket 9	  */
	public void setAmtBucket09 (BigDecimal AmtBucket09);

	/** Get Amount Bucket 9	  */
	public BigDecimal getAmtBucket09();

    /** Column name AmtBucket10 */
    public static final String COLUMNNAME_AmtBucket10 = "AmtBucket10";

	/** Set Amount Bucket 10	  */
	public void setAmtBucket10 (BigDecimal AmtBucket10);

	/** Get Amount Bucket 10	  */
	public BigDecimal getAmtBucket10();

    /** Column name AmtBucket11 */
    public static final String COLUMNNAME_AmtBucket11 = "AmtBucket11";

	/** Set Amount Bucket 11	  */
	public void setAmtBucket11 (BigDecimal AmtBucket11);

	/** Get Amount Bucket 11	  */
	public BigDecimal getAmtBucket11();

    /** Column name AmtBucket12 */
    public static final String COLUMNNAME_AmtBucket12 = "AmtBucket12";

	/** Set Amount Bucket 12	  */
	public void setAmtBucket12 (BigDecimal AmtBucket12);

	/** Get Amount Bucket 12	  */
	public BigDecimal getAmtBucket12();

    /** Column name AmtBucket13 */
    public static final String COLUMNNAME_AmtBucket13 = "AmtBucket13";

	/** Set Amount Bucket 13	  */
	public void setAmtBucket13 (BigDecimal AmtBucket13);

	/** Get Amount Bucket 13	  */
	public BigDecimal getAmtBucket13();

    /** Column name AmtBucket14 */
    public static final String COLUMNNAME_AmtBucket14 = "AmtBucket14";

	/** Set Amount Bucket 14	  */
	public void setAmtBucket14 (BigDecimal AmtBucket14);

	/** Get Amount Bucket 14	  */
	public BigDecimal getAmtBucket14();

    /** Column name AmtBucket15 */
    public static final String COLUMNNAME_AmtBucket15 = "AmtBucket15";

	/** Set Amount Bucket 15	  */
	public void setAmtBucket15 (BigDecimal AmtBucket15);

	/** Get Amount Bucket 15	  */
	public BigDecimal getAmtBucket15();

    /** Column name AmtBucket16 */
    public static final String COLUMNNAME_AmtBucket16 = "AmtBucket16";

	/** Set Amount Bucket 16	  */
	public void setAmtBucket16 (BigDecimal AmtBucket16);

	/** Get Amount Bucket 16	  */
	public BigDecimal getAmtBucket16();

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

    /** Column name C_Location_ID */
    public static final String COLUMNNAME_C_Location_ID = "C_Location_ID";

	/** Set Address.
	  * Location or Address
	  */
	public void setC_Location_ID (int C_Location_ID);

	/** Get Address.
	  * Location or Address
	  */
	public int getC_Location_ID();

	public I_C_Location getC_Location() throws RuntimeException;

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

    /** Column name Cut_Date */
    public static final String COLUMNNAME_Cut_Date = "Cut_Date";

	/** Set Cut Date	  */
	public void setCut_Date (Timestamp Cut_Date);

	/** Get Cut Date	  */
	public Timestamp getCut_Date();

    /** Column name Cut_Year */
    public static final String COLUMNNAME_Cut_Year = "Cut_Year";

	/** Set Cut Year	  */
	public void setCut_Year (int Cut_Year);

	/** Get Cut Year	  */
	public int getCut_Year();

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

    /** Column name T_1099Extract_UU */
    public static final String COLUMNNAME_T_1099Extract_UU = "T_1099Extract_UU";

	/** Set T_1099Extract_UU	  */
	public void setT_1099Extract_UU (String T_1099Extract_UU);

	/** Get T_1099Extract_UU	  */
	public String getT_1099Extract_UU();

    /** Column name TaxID */
    public static final String COLUMNNAME_TaxID = "TaxID";

	/** Set Tax ID.
	  * Tax Identification
	  */
	public void setTaxID (String TaxID);

	/** Get Tax ID.
	  * Tax Identification
	  */
	public String getTaxID();

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

    /** Column name Value */
    public static final String COLUMNNAME_Value = "Value";

	/** Set Search Key.
	  * Search key for the record in the format required - must be unique
	  */
	public void setValue (String Value);

	/** Get Search Key.
	  * Search key for the record in the format required - must be unique
	  */
	public String getValue();
}
