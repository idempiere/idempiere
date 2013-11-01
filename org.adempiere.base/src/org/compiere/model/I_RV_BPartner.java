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

/** Generated Interface for RV_BPartner
 *  @author iDempiere (generated) 
 *  @version Release 2.0
 */
public interface I_RV_BPartner 
{

    /** TableName=RV_BPartner */
    public static final String Table_Name = "RV_BPartner";

    /** AD_Table_ID=520 */
    public static final int Table_ID = 520;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 3 - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(3);

    /** Load Meta Data */

    /** Column name AcqusitionCost */
    public static final String COLUMNNAME_AcqusitionCost = "AcqusitionCost";

	/** Set Acquisition Cost.
	  * The cost of gaining the prospect as a customer
	  */
	public void setAcqusitionCost (BigDecimal AcqusitionCost);

	/** Get Acquisition Cost.
	  * The cost of gaining the prospect as a customer
	  */
	public BigDecimal getAcqusitionCost();

    /** Column name ActualLifeTimeValue */
    public static final String COLUMNNAME_ActualLifeTimeValue = "ActualLifeTimeValue";

	/** Set Actual Life Time Value.
	  * Actual Life Time Revenue
	  */
	public void setActualLifeTimeValue (BigDecimal ActualLifeTimeValue);

	/** Get Actual Life Time Value.
	  * Actual Life Time Revenue
	  */
	public BigDecimal getActualLifeTimeValue();

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name Address1 */
    public static final String COLUMNNAME_Address1 = "Address1";

	/** Set Address 1.
	  * Address line 1 for this location
	  */
	public void setAddress1 (String Address1);

	/** Get Address 1.
	  * Address line 1 for this location
	  */
	public String getAddress1();

    /** Column name Address2 */
    public static final String COLUMNNAME_Address2 = "Address2";

	/** Set Address 2.
	  * Address line 2 for this location
	  */
	public void setAddress2 (String Address2);

	/** Get Address 2.
	  * Address line 2 for this location
	  */
	public String getAddress2();

    /** Column name Address3 */
    public static final String COLUMNNAME_Address3 = "Address3";

	/** Set Address 3.
	  * Address Line 3 for the location
	  */
	public void setAddress3 (String Address3);

	/** Get Address 3.
	  * Address Line 3 for the location
	  */
	public String getAddress3();

    /** Column name Address4 */
    public static final String COLUMNNAME_Address4 = "Address4";

	/** Set Address 4.
	  * Address Line 4 for the location
	  */
	public void setAddress4 (String Address4);

	/** Get Address 4.
	  * Address Line 4 for the location
	  */
	public String getAddress4();

    /** Column name AD_Language */
    public static final String COLUMNNAME_AD_Language = "AD_Language";

	/** Set Language.
	  * Language for this entity
	  */
	public void setAD_Language (String AD_Language);

	/** Get Language.
	  * Language for this entity
	  */
	public String getAD_Language();

    /** Column name AD_OrgBP_ID */
    public static final String COLUMNNAME_AD_OrgBP_ID = "AD_OrgBP_ID";

	/** Set Linked Organization.
	  * The Business Partner is another Organization for explicit Inter-Org transactions
	  */
	public void setAD_OrgBP_ID (int AD_OrgBP_ID);

	/** Get Linked Organization.
	  * The Business Partner is another Organization for explicit Inter-Org transactions
	  */
	public int getAD_OrgBP_ID();

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

    /** Column name AD_OrgTrx_ID */
    public static final String COLUMNNAME_AD_OrgTrx_ID = "AD_OrgTrx_ID";

	/** Set Trx Organization.
	  * Performing or initiating organization
	  */
	public void setAD_OrgTrx_ID (int AD_OrgTrx_ID);

	/** Get Trx Organization.
	  * Performing or initiating organization
	  */
	public int getAD_OrgTrx_ID();

    /** Column name AD_User_AD_Org_ID */
    public static final String COLUMNNAME_AD_User_AD_Org_ID = "AD_User_AD_Org_ID";

	/** Set AD_User_AD_Org_ID	  */
	public void setAD_User_AD_Org_ID (int AD_User_AD_Org_ID);

	/** Get AD_User_AD_Org_ID	  */
	public int getAD_User_AD_Org_ID();

    /** Column name AD_User_C_BPartner_ID */
    public static final String COLUMNNAME_AD_User_C_BPartner_ID = "AD_User_C_BPartner_ID";

	/** Set AD_User_C_BPartner_ID	  */
	public void setAD_User_C_BPartner_ID (int AD_User_C_BPartner_ID);

	/** Get AD_User_C_BPartner_ID	  */
	public int getAD_User_C_BPartner_ID();

	public org.compiere.model.I_C_BPartner getAD_User_C_BPartner() throws RuntimeException;

    /** Column name AD_User_C_BPartner_Location_ID */
    public static final String COLUMNNAME_AD_User_C_BPartner_Location_ID = "AD_User_C_BPartner_Location_ID";

	/** Set AD_User_C_BPartner_Location_ID	  */
	public void setAD_User_C_BPartner_Location_ID (int AD_User_C_BPartner_Location_ID);

	/** Get AD_User_C_BPartner_Location_ID	  */
	public int getAD_User_C_BPartner_Location_ID();

	public org.compiere.model.I_C_BPartner_Location getAD_User_C_BPartner_Location() throws RuntimeException;

    /** Column name ad_user_created */
    public static final String COLUMNNAME_ad_user_created = "ad_user_created";

	/** Set ad_user_created	  */
	public void setad_user_created (Timestamp ad_user_created);

	/** Get ad_user_created	  */
	public Timestamp getad_user_created();

    /** Column name AD_User_CreatedBy */
    public static final String COLUMNNAME_AD_User_CreatedBy = "AD_User_CreatedBy";

	/** Set ad_user_createdby	  */
	public void setAD_User_CreatedBy (int AD_User_CreatedBy);

	/** Get ad_user_createdby	  */
	public int getAD_User_CreatedBy();

	public org.compiere.model.I_AD_User getAD_User_Create() throws RuntimeException;

    /** Column name AD_User_ID */
    public static final String COLUMNNAME_AD_User_ID = "AD_User_ID";

	/** Set User/Contact.
	  * User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID);

	/** Get User/Contact.
	  * User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID();

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException;

    /** Column name ad_user_isactive */
    public static final String COLUMNNAME_ad_user_isactive = "ad_user_isactive";

	/** Set ad_user_isactive	  */
	public void setad_user_isactive (boolean ad_user_isactive);

	/** Get ad_user_isactive	  */
	public boolean isad_user_isactive();

    /** Column name ad_user_updated */
    public static final String COLUMNNAME_ad_user_updated = "ad_user_updated";

	/** Set ad_user_updated	  */
	public void setad_user_updated (Timestamp ad_user_updated);

	/** Get ad_user_updated	  */
	public Timestamp getad_user_updated();

    /** Column name AD_User_UpdatedBy */
    public static final String COLUMNNAME_AD_User_UpdatedBy = "AD_User_UpdatedBy";

	/** Set ad_user_updatedby	  */
	public void setAD_User_UpdatedBy (int AD_User_UpdatedBy);

	/** Get ad_user_updatedby	  */
	public int getAD_User_UpdatedBy();

	public org.compiere.model.I_AD_User getAD_User_Update() throws RuntimeException;

    /** Column name ad_user_value */
    public static final String COLUMNNAME_ad_user_value = "ad_user_value";

	/** Set ad_user_value	  */
	public void setad_user_value (String ad_user_value);

	/** Get ad_user_value	  */
	public String getad_user_value();

    /** Column name Birthday */
    public static final String COLUMNNAME_Birthday = "Birthday";

	/** Set Birthday.
	  * Birthday or Anniversary day
	  */
	public void setBirthday (Timestamp Birthday);

	/** Get Birthday.
	  * Birthday or Anniversary day
	  */
	public Timestamp getBirthday();

    /** Column name BPartner_Parent_ID */
    public static final String COLUMNNAME_BPartner_Parent_ID = "BPartner_Parent_ID";

	/** Set Partner Parent.
	  * Business Partner Parent
	  */
	public void setBPartner_Parent_ID (int BPartner_Parent_ID);

	/** Get Partner Parent.
	  * Business Partner Parent
	  */
	public int getBPartner_Parent_ID();

	public org.compiere.model.I_C_BPartner getBPartner_Parent() throws RuntimeException;

    /** Column name BPContactGreeting */
    public static final String COLUMNNAME_BPContactGreeting = "BPContactGreeting";

	/** Set BP Contact Greeting.
	  * Greeting for Business Partner Contact
	  */
	public void setBPContactGreeting (int BPContactGreeting);

	/** Get BP Contact Greeting.
	  * Greeting for Business Partner Contact
	  */
	public int getBPContactGreeting();

	public org.compiere.model.I_C_Greeting getBPContactGreet() throws RuntimeException;

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

    /** Column name C_BPartner_Location_ID */
    public static final String COLUMNNAME_C_BPartner_Location_ID = "C_BPartner_Location_ID";

	/** Set Partner Location.
	  * Identifies the (ship to) address for this Business Partner
	  */
	public void setC_BPartner_Location_ID (int C_BPartner_Location_ID);

	/** Get Partner Location.
	  * Identifies the (ship to) address for this Business Partner
	  */
	public int getC_BPartner_Location_ID();

	public org.compiere.model.I_C_BPartner_Location getC_BPartner_Location() throws RuntimeException;

    /** Column name C_BP_C_TaxGroup_ID */
    public static final String COLUMNNAME_C_BP_C_TaxGroup_ID = "C_BP_C_TaxGroup_ID";

	/** Set c_bp_c_taxgroup_id	  */
	public void setC_BP_C_TaxGroup_ID (int C_BP_C_TaxGroup_ID);

	/** Get c_bp_c_taxgroup_id	  */
	public int getC_BP_C_TaxGroup_ID();

	public org.eevolution.model.I_C_TaxGroup getC_BP_C_TaxGroup() throws RuntimeException;

    /** Column name c_bp_dunninggrace */
    public static final String COLUMNNAME_c_bp_dunninggrace = "c_bp_dunninggrace";

	/** Set c_bp_dunninggrace	  */
	public void setc_bp_dunninggrace (Timestamp c_bp_dunninggrace);

	/** Get c_bp_dunninggrace	  */
	public Timestamp getc_bp_dunninggrace();

    /** Column name C_BP_Group_ID */
    public static final String COLUMNNAME_C_BP_Group_ID = "C_BP_Group_ID";

	/** Set Business Partner Group.
	  * Business Partner Group
	  */
	public void setC_BP_Group_ID (int C_BP_Group_ID);

	/** Get Business Partner Group.
	  * Business Partner Group
	  */
	public int getC_BP_Group_ID();

	public org.compiere.model.I_C_BP_Group getC_BP_Group() throws RuntimeException;

    /** Column name c_bp_ismanufacturer */
    public static final String COLUMNNAME_c_bp_ismanufacturer = "c_bp_ismanufacturer";

	/** Set c_bp_ismanufacturer	  */
	public void setc_bp_ismanufacturer (boolean c_bp_ismanufacturer);

	/** Get c_bp_ismanufacturer	  */
	public boolean isc_bp_ismanufacturer();

    /** Column name c_bp_ispotaxexempt */
    public static final String COLUMNNAME_c_bp_ispotaxexempt = "c_bp_ispotaxexempt";

	/** Set c_bp_ispotaxexempt	  */
	public void setc_bp_ispotaxexempt (boolean c_bp_ispotaxexempt);

	/** Get c_bp_ispotaxexempt	  */
	public boolean isc_bp_ispotaxexempt();

    /** Column name C_BP_Location_AD_Org_ID */
    public static final String COLUMNNAME_C_BP_Location_AD_Org_ID = "C_BP_Location_AD_Org_ID";

	/** Set c_bp_location_ad_org_id	  */
	public void setC_BP_Location_AD_Org_ID (int C_BP_Location_AD_Org_ID);

	/** Get c_bp_location_ad_org_id	  */
	public int getC_BP_Location_AD_Org_ID();

    /** Column name C_BP_Location_C_BPartner_ID */
    public static final String COLUMNNAME_C_BP_Location_C_BPartner_ID = "C_BP_Location_C_BPartner_ID";

	/** Set c_bpartner_location_c_bpartner_id	  */
	public void setC_BP_Location_C_BPartner_ID (int C_BP_Location_C_BPartner_ID);

	/** Get c_bpartner_location_c_bpartner_id	  */
	public int getC_BP_Location_C_BPartner_ID();

	public org.compiere.model.I_C_BPartner getC_BP_Location_C_BPartner() throws RuntimeException;

    /** Column name C_BP_Location_C_Location_ID */
    public static final String COLUMNNAME_C_BP_Location_C_Location_ID = "C_BP_Location_C_Location_ID";

	/** Set c_bp_location_c_location_id	  */
	public void setC_BP_Location_C_Location_ID (int C_BP_Location_C_Location_ID);

	/** Get c_bp_location_c_location_id	  */
	public int getC_BP_Location_C_Location_ID();

	public I_C_Location getC_BP_Location_C_Location() throws RuntimeException;

    /** Column name c_bp_location_created */
    public static final String COLUMNNAME_c_bp_location_created = "c_bp_location_created";

	/** Set c_bp_location_created	  */
	public void setc_bp_location_created (Timestamp c_bp_location_created);

	/** Get c_bp_location_created	  */
	public Timestamp getc_bp_location_created();

    /** Column name C_BP_Location_CreatedBy */
    public static final String COLUMNNAME_C_BP_Location_CreatedBy = "C_BP_Location_CreatedBy";

	/** Set c_bp_location_createdby	  */
	public void setC_BP_Location_CreatedBy (int C_BP_Location_CreatedBy);

	/** Get c_bp_location_createdby	  */
	public int getC_BP_Location_CreatedBy();

	public org.compiere.model.I_AD_User getC_BP_Location_Create() throws RuntimeException;

    /** Column name c_bp_location_fax */
    public static final String COLUMNNAME_c_bp_location_fax = "c_bp_location_fax";

	/** Set c_bp_location_fax	  */
	public void setc_bp_location_fax (String c_bp_location_fax);

	/** Get c_bp_location_fax	  */
	public String getc_bp_location_fax();

    /** Column name c_bp_location_isactive */
    public static final String COLUMNNAME_c_bp_location_isactive = "c_bp_location_isactive";

	/** Set c_bp_location_isactive	  */
	public void setc_bp_location_isactive (boolean c_bp_location_isactive);

	/** Get c_bp_location_isactive	  */
	public boolean isc_bp_location_isactive();

    /** Column name c_bp_location_isbillto */
    public static final String COLUMNNAME_c_bp_location_isbillto = "c_bp_location_isbillto";

	/** Set c_bp_location_isbillto	  */
	public void setc_bp_location_isbillto (boolean c_bp_location_isbillto);

	/** Get c_bp_location_isbillto	  */
	public boolean isc_bp_location_isbillto();

    /** Column name c_bp_location_isdn */
    public static final String COLUMNNAME_c_bp_location_isdn = "c_bp_location_isdn";

	/** Set c_bp_location_isdn	  */
	public void setc_bp_location_isdn (String c_bp_location_isdn);

	/** Get c_bp_location_isdn	  */
	public String getc_bp_location_isdn();

    /** Column name c_bp_location_ispayfrom */
    public static final String COLUMNNAME_c_bp_location_ispayfrom = "c_bp_location_ispayfrom";

	/** Set c_bp_location_ispayfrom	  */
	public void setc_bp_location_ispayfrom (boolean c_bp_location_ispayfrom);

	/** Get c_bp_location_ispayfrom	  */
	public boolean isc_bp_location_ispayfrom();

    /** Column name c_bp_location_isremitto */
    public static final String COLUMNNAME_c_bp_location_isremitto = "c_bp_location_isremitto";

	/** Set c_bp_location_isremitto	  */
	public void setc_bp_location_isremitto (boolean c_bp_location_isremitto);

	/** Get c_bp_location_isremitto	  */
	public boolean isc_bp_location_isremitto();

    /** Column name c_bp_location_isshipto */
    public static final String COLUMNNAME_c_bp_location_isshipto = "c_bp_location_isshipto";

	/** Set c_bp_location_isshipto	  */
	public void setc_bp_location_isshipto (boolean c_bp_location_isshipto);

	/** Get c_bp_location_isshipto	  */
	public boolean isc_bp_location_isshipto();

    /** Column name c_bp_location_name */
    public static final String COLUMNNAME_c_bp_location_name = "c_bp_location_name";

	/** Set c_bp_location_name	  */
	public void setc_bp_location_name (String c_bp_location_name);

	/** Get c_bp_location_name	  */
	public String getc_bp_location_name();

    /** Column name c_bp_location_phone */
    public static final String COLUMNNAME_c_bp_location_phone = "c_bp_location_phone";

	/** Set c_bp_location_phone	  */
	public void setc_bp_location_phone (String c_bp_location_phone);

	/** Get c_bp_location_phone	  */
	public String getc_bp_location_phone();

    /** Column name c_bp_location_phone2 */
    public static final String COLUMNNAME_c_bp_location_phone2 = "c_bp_location_phone2";

	/** Set c_bp_location_phone2	  */
	public void setc_bp_location_phone2 (String c_bp_location_phone2);

	/** Get c_bp_location_phone2	  */
	public String getc_bp_location_phone2();

    /** Column name C_BP_Location_SalesRegion_ID */
    public static final String COLUMNNAME_C_BP_Location_SalesRegion_ID = "C_BP_Location_SalesRegion_ID";

	/** Set c_bp_location_salesregion_id	  */
	public void setC_BP_Location_SalesRegion_ID (int C_BP_Location_SalesRegion_ID);

	/** Get c_bp_location_salesregion_id	  */
	public int getC_BP_Location_SalesRegion_ID();

	public org.compiere.model.I_C_SalesRegion getC_BP_Location_SalesRegion() throws RuntimeException;

    /** Column name c_bp_location_updated */
    public static final String COLUMNNAME_c_bp_location_updated = "c_bp_location_updated";

	/** Set c_bp_location_updated	  */
	public void setc_bp_location_updated (Timestamp c_bp_location_updated);

	/** Get c_bp_location_updated	  */
	public Timestamp getc_bp_location_updated();

    /** Column name C_BP_Location_UpdatedBy */
    public static final String COLUMNNAME_C_BP_Location_UpdatedBy = "C_BP_Location_UpdatedBy";

	/** Set c_bp_location_updatedby	  */
	public void setC_BP_Location_UpdatedBy (int C_BP_Location_UpdatedBy);

	/** Get c_bp_location_updatedby	  */
	public int getC_BP_Location_UpdatedBy();

	public org.compiere.model.I_AD_User getC_BP_Location_Update() throws RuntimeException;

    /** Column name C_BP_Logo_ID */
    public static final String COLUMNNAME_C_BP_Logo_ID = "C_BP_Logo_ID";

	/** Set c_bp_logo_id	  */
	public void setC_BP_Logo_ID (int C_BP_Logo_ID);

	/** Get c_bp_logo_id	  */
	public int getC_BP_Logo_ID();

    /** Column name C_City_ID */
    public static final String COLUMNNAME_C_City_ID = "C_City_ID";

	/** Set City.
	  * City
	  */
	public void setC_City_ID (int C_City_ID);

	/** Get City.
	  * City
	  */
	public int getC_City_ID();

	public org.compiere.model.I_C_City getC_City() throws RuntimeException;

    /** Column name c_country_ad_language */
    public static final String COLUMNNAME_c_country_ad_language = "c_country_ad_language";

	/** Set c_country_ad_language	  */
	public void setc_country_ad_language (String c_country_ad_language);

	/** Get c_country_ad_language	  */
	public String getc_country_ad_language();

    /** Column name C_Country_C_Currency_ID */
    public static final String COLUMNNAME_C_Country_C_Currency_ID = "C_Country_C_Currency_ID";

	/** Set c_country_c_currency_id	  */
	public void setC_Country_C_Currency_ID (int C_Country_C_Currency_ID);

	/** Get c_country_c_currency_id	  */
	public int getC_Country_C_Currency_ID();

	public org.compiere.model.I_C_Currency getC_Country_C_Currency() throws RuntimeException;

    /** Column name c_country_description */
    public static final String COLUMNNAME_c_country_description = "c_country_description";

	/** Set c_country_description	  */
	public void setc_country_description (String c_country_description);

	/** Get c_country_description	  */
	public String getc_country_description();

    /** Column name C_Country_ID */
    public static final String COLUMNNAME_C_Country_ID = "C_Country_ID";

	/** Set Country.
	  * Country 
	  */
	public void setC_Country_ID (int C_Country_ID);

	/** Get Country.
	  * Country 
	  */
	public int getC_Country_ID();

	public org.compiere.model.I_C_Country getC_Country() throws RuntimeException;

    /** Column name c_country_isactive */
    public static final String COLUMNNAME_c_country_isactive = "c_country_isactive";

	/** Set c_country_isactive	  */
	public void setc_country_isactive (boolean c_country_isactive);

	/** Get c_country_isactive	  */
	public boolean isc_country_isactive();

    /** Column name C_Dunning_ID */
    public static final String COLUMNNAME_C_Dunning_ID = "C_Dunning_ID";

	/** Set Dunning.
	  * Dunning Rules for overdue invoices
	  */
	public void setC_Dunning_ID (int C_Dunning_ID);

	/** Get Dunning.
	  * Dunning Rules for overdue invoices
	  */
	public int getC_Dunning_ID();

	public org.compiere.model.I_C_Dunning getC_Dunning() throws RuntimeException;

    /** Column name C_Greeting_ID */
    public static final String COLUMNNAME_C_Greeting_ID = "C_Greeting_ID";

	/** Set Greeting.
	  * Greeting to print on correspondence
	  */
	public void setC_Greeting_ID (int C_Greeting_ID);

	/** Get Greeting.
	  * Greeting to print on correspondence
	  */
	public int getC_Greeting_ID();

	public org.compiere.model.I_C_Greeting getC_Greeting() throws RuntimeException;

    /** Column name C_InvoiceSchedule_ID */
    public static final String COLUMNNAME_C_InvoiceSchedule_ID = "C_InvoiceSchedule_ID";

	/** Set Invoice Schedule.
	  * Schedule for generating Invoices
	  */
	public void setC_InvoiceSchedule_ID (int C_InvoiceSchedule_ID);

	/** Get Invoice Schedule.
	  * Schedule for generating Invoices
	  */
	public int getC_InvoiceSchedule_ID();

	public org.compiere.model.I_C_InvoiceSchedule getC_InvoiceSchedule() throws RuntimeException;

    /** Column name City */
    public static final String COLUMNNAME_City = "City";

	/** Set City.
	  * Identifies a City
	  */
	public void setCity (String City);

	/** Get City.
	  * Identifies a City
	  */
	public String getCity();

    /** Column name C_Location_AD_Org_ID */
    public static final String COLUMNNAME_C_Location_AD_Org_ID = "C_Location_AD_Org_ID";

	/** Set c_location_ad_org_id	  */
	public void setC_Location_AD_Org_ID (int C_Location_AD_Org_ID);

	/** Get c_location_ad_org_id	  */
	public int getC_Location_AD_Org_ID();

    /** Column name c_location_created */
    public static final String COLUMNNAME_c_location_created = "c_location_created";

	/** Set c_location_created	  */
	public void setc_location_created (Timestamp c_location_created);

	/** Get c_location_created	  */
	public Timestamp getc_location_created();

    /** Column name C_Location_CreatedBy */
    public static final String COLUMNNAME_C_Location_CreatedBy = "C_Location_CreatedBy";

	/** Set c_location_createdby	  */
	public void setC_Location_CreatedBy (int C_Location_CreatedBy);

	/** Get c_location_createdby	  */
	public int getC_Location_CreatedBy();

	public org.compiere.model.I_AD_User getC_Location_Create() throws RuntimeException;

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

    /** Column name c_location_isactive */
    public static final String COLUMNNAME_c_location_isactive = "c_location_isactive";

	/** Set c_location_isactive	  */
	public void setc_location_isactive (boolean c_location_isactive);

	/** Get c_location_isactive	  */
	public boolean isc_location_isactive();

    /** Column name c_location_updated */
    public static final String COLUMNNAME_c_location_updated = "c_location_updated";

	/** Set c_location_updated	  */
	public void setc_location_updated (Timestamp c_location_updated);

	/** Get c_location_updated	  */
	public Timestamp getc_location_updated();

    /** Column name C_Location_UpdatedBy */
    public static final String COLUMNNAME_C_Location_UpdatedBy = "C_Location_UpdatedBy";

	/** Set c_location_updatedby	  */
	public void setC_Location_UpdatedBy (int C_Location_UpdatedBy);

	/** Get c_location_updatedby	  */
	public int getC_Location_UpdatedBy();

	public org.compiere.model.I_AD_User getC_Location_Update() throws RuntimeException;

    /** Column name Comments */
    public static final String COLUMNNAME_Comments = "Comments";

	/** Set Comments.
	  * Comments or additional information
	  */
	public void setComments (String Comments);

	/** Get Comments.
	  * Comments or additional information
	  */
	public String getComments();

    /** Column name ContactDescription */
    public static final String COLUMNNAME_ContactDescription = "ContactDescription";

	/** Set Contact Description.
	  * Description of Contact
	  */
	public void setContactDescription (String ContactDescription);

	/** Get Contact Description.
	  * Description of Contact
	  */
	public String getContactDescription();

    /** Column name ContactName */
    public static final String COLUMNNAME_ContactName = "ContactName";

	/** Set Contact Name.
	  * Business Partner Contact Name
	  */
	public void setContactName (String ContactName);

	/** Get Contact Name.
	  * Business Partner Contact Name
	  */
	public String getContactName();

    /** Column name CountryCode */
    public static final String COLUMNNAME_CountryCode = "CountryCode";

	/** Set ISO Country Code.
	  * Upper-case two-letter alphanumeric ISO Country code according to ISO 3166-1 - http://www.chemie.fu-berlin.de/diverse/doc/ISO_3166.html
	  */
	public void setCountryCode (String CountryCode);

	/** Get ISO Country Code.
	  * Upper-case two-letter alphanumeric ISO Country code according to ISO 3166-1 - http://www.chemie.fu-berlin.de/diverse/doc/ISO_3166.html
	  */
	public String getCountryCode();

    /** Column name CountryName */
    public static final String COLUMNNAME_CountryName = "CountryName";

	/** Set Country.
	  * Country Name
	  */
	public void setCountryName (String CountryName);

	/** Get Country.
	  * Country Name
	  */
	public String getCountryName();

    /** Column name C_PaymentTerm_ID */
    public static final String COLUMNNAME_C_PaymentTerm_ID = "C_PaymentTerm_ID";

	/** Set Payment Term.
	  * The terms of Payment (timing, discount)
	  */
	public void setC_PaymentTerm_ID (int C_PaymentTerm_ID);

	/** Get Payment Term.
	  * The terms of Payment (timing, discount)
	  */
	public int getC_PaymentTerm_ID();

	public org.compiere.model.I_C_PaymentTerm getC_PaymentTerm() throws RuntimeException;

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

    /** Column name C_Region_AD_Org_ID */
    public static final String COLUMNNAME_C_Region_AD_Org_ID = "C_Region_AD_Org_ID";

	/** Set c_region_ad_org_id	  */
	public void setC_Region_AD_Org_ID (int C_Region_AD_Org_ID);

	/** Get c_region_ad_org_id	  */
	public int getC_Region_AD_Org_ID();

    /** Column name C_Region_C_Country_ID */
    public static final String COLUMNNAME_C_Region_C_Country_ID = "C_Region_C_Country_ID";

	/** Set c_region_c_country_id	  */
	public void setC_Region_C_Country_ID (int C_Region_C_Country_ID);

	/** Get c_region_c_country_id	  */
	public int getC_Region_C_Country_ID();

    /** Column name c_region_description */
    public static final String COLUMNNAME_c_region_description = "c_region_description";

	/** Set c_region_description	  */
	public void setc_region_description (String c_region_description);

	/** Get c_region_description	  */
	public String getc_region_description();

    /** Column name C_Region_ID */
    public static final String COLUMNNAME_C_Region_ID = "C_Region_ID";

	/** Set Region.
	  * Identifies a geographical Region
	  */
	public void setC_Region_ID (int C_Region_ID);

	/** Get Region.
	  * Identifies a geographical Region
	  */
	public int getC_Region_ID();

	public org.compiere.model.I_C_Region getC_Region() throws RuntimeException;

    /** Column name c_region_isactive */
    public static final String COLUMNNAME_c_region_isactive = "c_region_isactive";

	/** Set c_region_isactive	  */
	public void setc_region_isactive (boolean c_region_isactive);

	/** Get c_region_isactive	  */
	public boolean isc_region_isactive();

    /** Column name DeliveryRule */
    public static final String COLUMNNAME_DeliveryRule = "DeliveryRule";

	/** Set Delivery Rule.
	  * Defines the timing of Delivery
	  */
	public void setDeliveryRule (String DeliveryRule);

	/** Get Delivery Rule.
	  * Defines the timing of Delivery
	  */
	public String getDeliveryRule();

    /** Column name DeliveryViaRule */
    public static final String COLUMNNAME_DeliveryViaRule = "DeliveryViaRule";

	/** Set Delivery Via.
	  * How the order will be delivered
	  */
	public void setDeliveryViaRule (String DeliveryViaRule);

	/** Get Delivery Via.
	  * How the order will be delivered
	  */
	public String getDeliveryViaRule();

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

    /** Column name DocumentCopies */
    public static final String COLUMNNAME_DocumentCopies = "DocumentCopies";

	/** Set Document Copies.
	  * Number of copies to be printed
	  */
	public void setDocumentCopies (int DocumentCopies);

	/** Get Document Copies.
	  * Number of copies to be printed
	  */
	public int getDocumentCopies();

    /** Column name DUNS */
    public static final String COLUMNNAME_DUNS = "DUNS";

	/** Set D-U-N-S.
	  * Dun & Bradstreet Number
	  */
	public void setDUNS (String DUNS);

	/** Get D-U-N-S.
	  * Dun & Bradstreet Number
	  */
	public String getDUNS();

    /** Column name EMail */
    public static final String COLUMNNAME_EMail = "EMail";

	/** Set EMail Address.
	  * Electronic Mail Address
	  */
	public void setEMail (String EMail);

	/** Get EMail Address.
	  * Electronic Mail Address
	  */
	public String getEMail();

    /** Column name EMailUser */
    public static final String COLUMNNAME_EMailUser = "EMailUser";

	/** Set EMail User ID.
	  * User Name (ID) in the Mail System
	  */
	public void setEMailUser (String EMailUser);

	/** Get EMail User ID.
	  * User Name (ID) in the Mail System
	  */
	public String getEMailUser();

    /** Column name EMailVerify */
    public static final String COLUMNNAME_EMailVerify = "EMailVerify";

	/** Set Verification Info.
	  * Verification information of EMail Address
	  */
	public void setEMailVerify (String EMailVerify);

	/** Get Verification Info.
	  * Verification information of EMail Address
	  */
	public String getEMailVerify();

    /** Column name EMailVerifyDate */
    public static final String COLUMNNAME_EMailVerifyDate = "EMailVerifyDate";

	/** Set EMail Verify.
	  * Date Email was verified
	  */
	public void setEMailVerifyDate (Timestamp EMailVerifyDate);

	/** Get EMail Verify.
	  * Date Email was verified
	  */
	public Timestamp getEMailVerifyDate();

    /** Column name Fax */
    public static final String COLUMNNAME_Fax = "Fax";

	/** Set Fax.
	  * Facsimile number
	  */
	public void setFax (String Fax);

	/** Get Fax.
	  * Facsimile number
	  */
	public String getFax();

    /** Column name FirstSale */
    public static final String COLUMNNAME_FirstSale = "FirstSale";

	/** Set First Sale.
	  * Date of First Sale
	  */
	public void setFirstSale (Timestamp FirstSale);

	/** Get First Sale.
	  * Date of First Sale
	  */
	public Timestamp getFirstSale();

    /** Column name FlatDiscount */
    public static final String COLUMNNAME_FlatDiscount = "FlatDiscount";

	/** Set Flat Discount %.
	  * Flat discount percentage 
	  */
	public void setFlatDiscount (BigDecimal FlatDiscount);

	/** Get Flat Discount %.
	  * Flat discount percentage 
	  */
	public BigDecimal getFlatDiscount();

    /** Column name FreightCostRule */
    public static final String COLUMNNAME_FreightCostRule = "FreightCostRule";

	/** Set Freight Cost Rule.
	  * Method for charging Freight
	  */
	public void setFreightCostRule (String FreightCostRule);

	/** Get Freight Cost Rule.
	  * Method for charging Freight
	  */
	public String getFreightCostRule();

    /** Column name Invoice_PrintFormat_ID */
    public static final String COLUMNNAME_Invoice_PrintFormat_ID = "Invoice_PrintFormat_ID";

	/** Set Invoice Print Format.
	  * Print Format for printing Invoices
	  */
	public void setInvoice_PrintFormat_ID (int Invoice_PrintFormat_ID);

	/** Get Invoice Print Format.
	  * Print Format for printing Invoices
	  */
	public int getInvoice_PrintFormat_ID();

	public org.compiere.model.I_AD_PrintFormat getInvoice_PrintFormat() throws RuntimeException;

    /** Column name InvoiceRule */
    public static final String COLUMNNAME_InvoiceRule = "InvoiceRule";

	/** Set Invoice Rule.
	  * Frequency and method of invoicing 
	  */
	public void setInvoiceRule (String InvoiceRule);

	/** Get Invoice Rule.
	  * Frequency and method of invoicing 
	  */
	public String getInvoiceRule();

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

    /** Column name IsCustomer */
    public static final String COLUMNNAME_IsCustomer = "IsCustomer";

	/** Set Customer.
	  * Indicates if this Business Partner is a Customer
	  */
	public void setIsCustomer (boolean IsCustomer);

	/** Get Customer.
	  * Indicates if this Business Partner is a Customer
	  */
	public boolean isCustomer();

    /** Column name IsDefault */
    public static final String COLUMNNAME_IsDefault = "IsDefault";

	/** Set Default.
	  * Default value
	  */
	public void setIsDefault (boolean IsDefault);

	/** Get Default.
	  * Default value
	  */
	public boolean isDefault();

    /** Column name IsDiscountPrinted */
    public static final String COLUMNNAME_IsDiscountPrinted = "IsDiscountPrinted";

	/** Set Discount Printed.
	  * Print Discount on Invoice and Order
	  */
	public void setIsDiscountPrinted (boolean IsDiscountPrinted);

	/** Get Discount Printed.
	  * Print Discount on Invoice and Order
	  */
	public boolean isDiscountPrinted();

    /** Column name IsEmployee */
    public static final String COLUMNNAME_IsEmployee = "IsEmployee";

	/** Set Employee.
	  * Indicates if  this Business Partner is an employee
	  */
	public void setIsEmployee (boolean IsEmployee);

	/** Get Employee.
	  * Indicates if  this Business Partner is an employee
	  */
	public boolean isEmployee();

    /** Column name IsOneTime */
    public static final String COLUMNNAME_IsOneTime = "IsOneTime";

	/** Set One time transaction	  */
	public void setIsOneTime (boolean IsOneTime);

	/** Get One time transaction	  */
	public boolean isOneTime();

    /** Column name IsProspect */
    public static final String COLUMNNAME_IsProspect = "IsProspect";

	/** Set Prospect.
	  * Indicates this is a Prospect
	  */
	public void setIsProspect (boolean IsProspect);

	/** Get Prospect.
	  * Indicates this is a Prospect
	  */
	public boolean isProspect();

    /** Column name IsSalesRep */
    public static final String COLUMNNAME_IsSalesRep = "IsSalesRep";

	/** Set Sales Representative.
	  * Indicates if  the business partner is a sales representative or company agent
	  */
	public void setIsSalesRep (boolean IsSalesRep);

	/** Get Sales Representative.
	  * Indicates if  the business partner is a sales representative or company agent
	  */
	public boolean isSalesRep();

    /** Column name IsSummary */
    public static final String COLUMNNAME_IsSummary = "IsSummary";

	/** Set Summary Level.
	  * This is a summary entity
	  */
	public void setIsSummary (boolean IsSummary);

	/** Get Summary Level.
	  * This is a summary entity
	  */
	public boolean isSummary();

    /** Column name IsTaxExempt */
    public static final String COLUMNNAME_IsTaxExempt = "IsTaxExempt";

	/** Set SO Tax exempt.
	  * Business partner is exempt from tax on sales
	  */
	public void setIsTaxExempt (boolean IsTaxExempt);

	/** Get SO Tax exempt.
	  * Business partner is exempt from tax on sales
	  */
	public boolean isTaxExempt();

    /** Column name IsVendor */
    public static final String COLUMNNAME_IsVendor = "IsVendor";

	/** Set Vendor.
	  * Indicates if this Business Partner is a Vendor
	  */
	public void setIsVendor (boolean IsVendor);

	/** Get Vendor.
	  * Indicates if this Business Partner is a Vendor
	  */
	public boolean isVendor();

    /** Column name LastContact */
    public static final String COLUMNNAME_LastContact = "LastContact";

	/** Set Last Contact.
	  * Date this individual was last contacted
	  */
	public void setLastContact (Timestamp LastContact);

	/** Get Last Contact.
	  * Date this individual was last contacted
	  */
	public Timestamp getLastContact();

    /** Column name LastResult */
    public static final String COLUMNNAME_LastResult = "LastResult";

	/** Set Last Result.
	  * Result of last contact
	  */
	public void setLastResult (String LastResult);

	/** Get Last Result.
	  * Result of last contact
	  */
	public String getLastResult();

    /** Column name LDAPUser */
    public static final String COLUMNNAME_LDAPUser = "LDAPUser";

	/** Set LDAP User Name.
	  * User Name used for authorization via LDAP (directory) services
	  */
	public void setLDAPUser (boolean LDAPUser);

	/** Get LDAP User Name.
	  * User Name used for authorization via LDAP (directory) services
	  */
	public boolean isLDAPUser();

    /** Column name M_DiscountSchema_ID */
    public static final String COLUMNNAME_M_DiscountSchema_ID = "M_DiscountSchema_ID";

	/** Set Discount Schema.
	  * Schema to calculate the trade discount percentage
	  */
	public void setM_DiscountSchema_ID (int M_DiscountSchema_ID);

	/** Get Discount Schema.
	  * Schema to calculate the trade discount percentage
	  */
	public int getM_DiscountSchema_ID();

	public org.compiere.model.I_M_DiscountSchema getM_DiscountSchema() throws RuntimeException;

    /** Column name M_PriceList_ID */
    public static final String COLUMNNAME_M_PriceList_ID = "M_PriceList_ID";

	/** Set Price List.
	  * Unique identifier of a Price List
	  */
	public void setM_PriceList_ID (int M_PriceList_ID);

	/** Get Price List.
	  * Unique identifier of a Price List
	  */
	public int getM_PriceList_ID();

	public org.compiere.model.I_M_PriceList getM_PriceList() throws RuntimeException;

    /** Column name NAICS */
    public static final String COLUMNNAME_NAICS = "NAICS";

	/** Set NAICS/SIC.
	  * Standard Industry Code or its successor NAIC - http://www.osha.gov/oshstats/sicser.html
	  */
	public void setNAICS (String NAICS);

	/** Get NAICS/SIC.
	  * Standard Industry Code or its successor NAIC - http://www.osha.gov/oshstats/sicser.html
	  */
	public String getNAICS();

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

    /** Column name Name2 */
    public static final String COLUMNNAME_Name2 = "Name2";

	/** Set Name 2.
	  * Additional Name
	  */
	public void setName2 (String Name2);

	/** Get Name 2.
	  * Additional Name
	  */
	public String getName2();

    /** Column name NotificationType */
    public static final String COLUMNNAME_NotificationType = "NotificationType";

	/** Set Notification Type.
	  * Type of Notifications
	  */
	public void setNotificationType (String NotificationType);

	/** Get Notification Type.
	  * Type of Notifications
	  */
	public String getNotificationType();

    /** Column name NumberEmployees */
    public static final String COLUMNNAME_NumberEmployees = "NumberEmployees";

	/** Set Employees.
	  * Number of employees
	  */
	public void setNumberEmployees (int NumberEmployees);

	/** Get Employees.
	  * Number of employees
	  */
	public int getNumberEmployees();

    /** Column name PaymentRule */
    public static final String COLUMNNAME_PaymentRule = "PaymentRule";

	/** Set Payment Rule.
	  * How you pay the invoice
	  */
	public void setPaymentRule (String PaymentRule);

	/** Get Payment Rule.
	  * How you pay the invoice
	  */
	public String getPaymentRule();

    /** Column name PaymentRulePO */
    public static final String COLUMNNAME_PaymentRulePO = "PaymentRulePO";

	/** Set Payment Rule.
	  * Purchase payment option
	  */
	public void setPaymentRulePO (String PaymentRulePO);

	/** Get Payment Rule.
	  * Purchase payment option
	  */
	public String getPaymentRulePO();

    /** Column name Phone */
    public static final String COLUMNNAME_Phone = "Phone";

	/** Set Phone.
	  * Identifies a telephone number
	  */
	public void setPhone (String Phone);

	/** Get Phone.
	  * Identifies a telephone number
	  */
	public String getPhone();

    /** Column name Phone2 */
    public static final String COLUMNNAME_Phone2 = "Phone2";

	/** Set 2nd Phone.
	  * Identifies an alternate telephone number.
	  */
	public void setPhone2 (String Phone2);

	/** Get 2nd Phone.
	  * Identifies an alternate telephone number.
	  */
	public String getPhone2();

    /** Column name PO_DiscountSchema_ID */
    public static final String COLUMNNAME_PO_DiscountSchema_ID = "PO_DiscountSchema_ID";

	/** Set PO Discount Schema.
	  * Schema to calculate the purchase trade discount percentage
	  */
	public void setPO_DiscountSchema_ID (int PO_DiscountSchema_ID);

	/** Get PO Discount Schema.
	  * Schema to calculate the purchase trade discount percentage
	  */
	public int getPO_DiscountSchema_ID();

	public org.compiere.model.I_M_DiscountSchema getPO_DiscountSchema() throws RuntimeException;

    /** Column name PO_PaymentTerm_ID */
    public static final String COLUMNNAME_PO_PaymentTerm_ID = "PO_PaymentTerm_ID";

	/** Set PO Payment Term.
	  * Payment rules for a purchase order
	  */
	public void setPO_PaymentTerm_ID (int PO_PaymentTerm_ID);

	/** Get PO Payment Term.
	  * Payment rules for a purchase order
	  */
	public int getPO_PaymentTerm_ID();

	public org.compiere.model.I_C_PaymentTerm getPO_PaymentTerm() throws RuntimeException;

    /** Column name PO_PriceList_ID */
    public static final String COLUMNNAME_PO_PriceList_ID = "PO_PriceList_ID";

	/** Set Purchase Pricelist.
	  * Price List used by this Business Partner
	  */
	public void setPO_PriceList_ID (int PO_PriceList_ID);

	/** Get Purchase Pricelist.
	  * Price List used by this Business Partner
	  */
	public int getPO_PriceList_ID();

	public org.compiere.model.I_M_PriceList getPO_PriceList() throws RuntimeException;

    /** Column name POReference */
    public static final String COLUMNNAME_POReference = "POReference";

	/** Set Order Reference.
	  * Transaction Reference Number (Sales Order, Purchase Order) of your Business Partner
	  */
	public void setPOReference (String POReference);

	/** Get Order Reference.
	  * Transaction Reference Number (Sales Order, Purchase Order) of your Business Partner
	  */
	public String getPOReference();

    /** Column name Postal */
    public static final String COLUMNNAME_Postal = "Postal";

	/** Set ZIP.
	  * Postal code
	  */
	public void setPostal (String Postal);

	/** Get ZIP.
	  * Postal code
	  */
	public String getPostal();

    /** Column name Postal_Add */
    public static final String COLUMNNAME_Postal_Add = "Postal_Add";

	/** Set Additional Zip.
	  * Additional ZIP or Postal code
	  */
	public void setPostal_Add (String Postal_Add);

	/** Get Additional Zip.
	  * Additional ZIP or Postal code
	  */
	public String getPostal_Add();

    /** Column name PotentialLifeTimeValue */
    public static final String COLUMNNAME_PotentialLifeTimeValue = "PotentialLifeTimeValue";

	/** Set Potential Life Time Value.
	  * Total Revenue expected
	  */
	public void setPotentialLifeTimeValue (BigDecimal PotentialLifeTimeValue);

	/** Get Potential Life Time Value.
	  * Total Revenue expected
	  */
	public BigDecimal getPotentialLifeTimeValue();

    /** Column name Rating */
    public static final String COLUMNNAME_Rating = "Rating";

	/** Set Rating.
	  * Classification or Importance
	  */
	public void setRating (String Rating);

	/** Get Rating.
	  * Classification or Importance
	  */
	public String getRating();

    /** Column name ReferenceNo */
    public static final String COLUMNNAME_ReferenceNo = "ReferenceNo";

	/** Set Reference No.
	  * Your customer or vendor number at the Business Partner's site
	  */
	public void setReferenceNo (String ReferenceNo);

	/** Get Reference No.
	  * Your customer or vendor number at the Business Partner's site
	  */
	public String getReferenceNo();

    /** Column name RegionName */
    public static final String COLUMNNAME_RegionName = "RegionName";

	/** Set Region.
	  * Name of the Region
	  */
	public void setRegionName (String RegionName);

	/** Get Region.
	  * Name of the Region
	  */
	public String getRegionName();

    /** Column name SalesRep_ID */
    public static final String COLUMNNAME_SalesRep_ID = "SalesRep_ID";

	/** Set Sales Representative.
	  * Sales Representative or Company Agent
	  */
	public void setSalesRep_ID (int SalesRep_ID);

	/** Get Sales Representative.
	  * Sales Representative or Company Agent
	  */
	public int getSalesRep_ID();

	public org.compiere.model.I_AD_User getSalesRep() throws RuntimeException;

    /** Column name SalesVolume */
    public static final String COLUMNNAME_SalesVolume = "SalesVolume";

	/** Set Sales Volume in 1.000.
	  * Total Volume of Sales in Thousands of Currency
	  */
	public void setSalesVolume (BigDecimal SalesVolume);

	/** Get Sales Volume in 1.000.
	  * Total Volume of Sales in Thousands of Currency
	  */
	public BigDecimal getSalesVolume();

    /** Column name SendEMail */
    public static final String COLUMNNAME_SendEMail = "SendEMail";

	/** Set Send EMail.
	  * Enable sending Document EMail
	  */
	public void setSendEMail (boolean SendEMail);

	/** Get Send EMail.
	  * Enable sending Document EMail
	  */
	public boolean isSendEMail();

    /** Column name ShareOfCustomer */
    public static final String COLUMNNAME_ShareOfCustomer = "ShareOfCustomer";

	/** Set Share.
	  * Share of Customer's business as a percentage
	  */
	public void setShareOfCustomer (int ShareOfCustomer);

	/** Get Share.
	  * Share of Customer's business as a percentage
	  */
	public int getShareOfCustomer();

    /** Column name ShelfLifeMinPct */
    public static final String COLUMNNAME_ShelfLifeMinPct = "ShelfLifeMinPct";

	/** Set Min Shelf Life %.
	  * Minimum Shelf Life in percent based on Product Instance Guarantee Date
	  */
	public void setShelfLifeMinPct (int ShelfLifeMinPct);

	/** Get Min Shelf Life %.
	  * Minimum Shelf Life in percent based on Product Instance Guarantee Date
	  */
	public int getShelfLifeMinPct();

    /** Column name SO_CreditAvailable */
    public static final String COLUMNNAME_SO_CreditAvailable = "SO_CreditAvailable";

	/** Set Credit Available.
	  * Available Credit based on Credit Limit (not Total Open Balance) and Credit Used
	  */
	public void setSO_CreditAvailable (BigDecimal SO_CreditAvailable);

	/** Get Credit Available.
	  * Available Credit based on Credit Limit (not Total Open Balance) and Credit Used
	  */
	public BigDecimal getSO_CreditAvailable();

    /** Column name SO_CreditLimit */
    public static final String COLUMNNAME_SO_CreditLimit = "SO_CreditLimit";

	/** Set Credit Limit.
	  * Total outstanding invoice amounts allowed
	  */
	public void setSO_CreditLimit (BigDecimal SO_CreditLimit);

	/** Get Credit Limit.
	  * Total outstanding invoice amounts allowed
	  */
	public BigDecimal getSO_CreditLimit();

    /** Column name SOCreditStatus */
    public static final String COLUMNNAME_SOCreditStatus = "SOCreditStatus";

	/** Set Credit Status.
	  * Business Partner Credit Status
	  */
	public void setSOCreditStatus (String SOCreditStatus);

	/** Get Credit Status.
	  * Business Partner Credit Status
	  */
	public String getSOCreditStatus();

    /** Column name SO_CreditUsed */
    public static final String COLUMNNAME_SO_CreditUsed = "SO_CreditUsed";

	/** Set Credit Used.
	  * Current open balance
	  */
	public void setSO_CreditUsed (BigDecimal SO_CreditUsed);

	/** Get Credit Used.
	  * Current open balance
	  */
	public BigDecimal getSO_CreditUsed();

    /** Column name SO_Description */
    public static final String COLUMNNAME_SO_Description = "SO_Description";

	/** Set Order Description.
	  * Description to be used on orders
	  */
	public void setSO_Description (String SO_Description);

	/** Get Order Description.
	  * Description to be used on orders
	  */
	public String getSO_Description();

    /** Column name Supervisor_ID */
    public static final String COLUMNNAME_Supervisor_ID = "Supervisor_ID";

	/** Set Supervisor.
	  * Supervisor for this user/organization - used for escalation and approval
	  */
	public void setSupervisor_ID (int Supervisor_ID);

	/** Get Supervisor.
	  * Supervisor for this user/organization - used for escalation and approval
	  */
	public int getSupervisor_ID();

	public org.compiere.model.I_AD_User getSupervisor() throws RuntimeException;

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

    /** Column name Title */
    public static final String COLUMNNAME_Title = "Title";

	/** Set Title.
	  * Name this entity is referred to as
	  */
	public void setTitle (String Title);

	/** Get Title.
	  * Name this entity is referred to as
	  */
	public String getTitle();

    /** Column name TotalOpenBalance */
    public static final String COLUMNNAME_TotalOpenBalance = "TotalOpenBalance";

	/** Set Open Balance.
	  * Total Open Balance Amount in primary Accounting Currency
	  */
	public void setTotalOpenBalance (BigDecimal TotalOpenBalance);

	/** Get Open Balance.
	  * Total Open Balance Amount in primary Accounting Currency
	  */
	public BigDecimal getTotalOpenBalance();

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

    /** Column name URL */
    public static final String COLUMNNAME_URL = "URL";

	/** Set URL.
	  * Full URL address - e.g. http://www.idempiere.org
	  */
	public void setURL (String URL);

	/** Get URL.
	  * Full URL address - e.g. http://www.idempiere.org
	  */
	public String getURL();

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
