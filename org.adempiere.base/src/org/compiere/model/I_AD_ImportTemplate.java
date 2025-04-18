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

/** Generated Interface for AD_ImportTemplate
 *  @author iDempiere (generated) 
 *  @version Release 12
 */
public interface I_AD_ImportTemplate 
{

    /** TableName=AD_ImportTemplate */
    public static final String Table_Name = "AD_ImportTemplate";

    /** AD_Table_ID=200153 */
    public static final int Table_ID = 200153;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 7 - System - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(7);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_ImportTemplate_ID */
    public static final String COLUMNNAME_AD_ImportTemplate_ID = "AD_ImportTemplate_ID";

	/** Set Import Template	  */
	public void setAD_ImportTemplate_ID (int AD_ImportTemplate_ID);

	/** Get Import Template	  */
	public int getAD_ImportTemplate_ID();

    /** Column name AD_ImportTemplate_UU */
    public static final String COLUMNNAME_AD_ImportTemplate_UU = "AD_ImportTemplate_UU";

	/** Set AD_ImportTemplate_UU	  */
	public void setAD_ImportTemplate_UU (String AD_ImportTemplate_UU);

	/** Get AD_ImportTemplate_UU	  */
	public String getAD_ImportTemplate_UU();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within tenant
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
	  */
	public int getAD_Org_ID();

    /** Column name AD_Tab_ID */
    public static final String COLUMNNAME_AD_Tab_ID = "AD_Tab_ID";

	/** Set Tab.
	  * Tab within a Window
	  */
	public void setAD_Tab_ID (int AD_Tab_ID);

	/** Get Tab.
	  * Tab within a Window
	  */
	public int getAD_Tab_ID();

	public org.compiere.model.I_AD_Tab getAD_Tab() throws RuntimeException;

    /** Column name AD_Window_ID */
    public static final String COLUMNNAME_AD_Window_ID = "AD_Window_ID";

	/** Set Window.
	  * Data entry or display window
	  */
	public void setAD_Window_ID (int AD_Window_ID);

	/** Get Window.
	  * Data entry or display window
	  */
	public int getAD_Window_ID();

	public org.compiere.model.I_AD_Window getAD_Window() throws RuntimeException;

    /** Column name CSVAliasHeader */
    public static final String COLUMNNAME_CSVAliasHeader = "CSVAliasHeader";

	/** Set CSV Alias Header	  */
	public void setCSVAliasHeader (String CSVAliasHeader);

	/** Get CSV Alias Header	  */
	public String getCSVAliasHeader();

    /** Column name CSVHeader */
    public static final String COLUMNNAME_CSVHeader = "CSVHeader";

	/** Set CSV Header	  */
	public void setCSVHeader (String CSVHeader);

	/** Get CSV Header	  */
	public String getCSVHeader();

    /** Column name CharacterSet */
    public static final String COLUMNNAME_CharacterSet = "CharacterSet";

	/** Set Character Set	  */
	public void setCharacterSet (String CharacterSet);

	/** Get Character Set	  */
	public String getCharacterSet();

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

    /** Column name ImportTemplateType */
    public static final String COLUMNNAME_ImportTemplateType = "ImportTemplateType";

	/** Set Import Template Type	  */
	public void setImportTemplateType (String ImportTemplateType);

	/** Get Import Template Type	  */
	public String getImportTemplateType();

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

    /** Column name QuoteChar */
    public static final String COLUMNNAME_QuoteChar = "QuoteChar";

	/** Set Quote Char	  */
	public void setQuoteChar (String QuoteChar);

	/** Get Quote Char	  */
	public String getQuoteChar();

    /** Column name SeparatorChar */
    public static final String COLUMNNAME_SeparatorChar = "SeparatorChar";

	/** Set Separator Character	  */
	public void setSeparatorChar (String SeparatorChar);

	/** Get Separator Character	  */
	public String getSeparatorChar();

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
