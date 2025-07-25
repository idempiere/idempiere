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

/** Generated Interface for GL_Distribution
 *  @author iDempiere (generated) 
 *  @version Release 13
 */
public interface I_GL_Distribution 
{

    /** TableName=GL_Distribution */
    public static final String Table_Name = "GL_Distribution";

    /** AD_Table_ID=708 */
    public static final int Table_ID = 708;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 2 - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(2);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

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

    /** Column name A_Asset_ID */
    public static final String COLUMNNAME_A_Asset_ID = "A_Asset_ID";

	/** Set Asset.
	  * Asset used internally or by customers
	  */
	public void setA_Asset_ID (int A_Asset_ID);

	/** Get Asset.
	  * Asset used internally or by customers
	  */
	public int getA_Asset_ID();

	public org.compiere.model.I_A_Asset getA_Asset() throws RuntimeException;

    /** Column name Account_ID */
    public static final String COLUMNNAME_Account_ID = "Account_ID";

	/** Set Account.
	  * Account used
	  */
	public void setAccount_ID (int Account_ID);

	/** Get Account.
	  * Account used
	  */
	public int getAccount_ID();

	public org.compiere.model.I_C_ElementValue getAccount() throws RuntimeException;

    /** Column name AnyAcct */
    public static final String COLUMNNAME_AnyAcct = "AnyAcct";

	/** Set Any Account.
	  * Match any value of the Account segment
	  */
	public void setAnyAcct (boolean AnyAcct);

	/** Get Any Account.
	  * Match any value of the Account segment
	  */
	public boolean isAnyAcct();

    /** Column name AnyActivity */
    public static final String COLUMNNAME_AnyActivity = "AnyActivity";

	/** Set Any Activity.
	  * Match any value of the Activity segment
	  */
	public void setAnyActivity (boolean AnyActivity);

	/** Get Any Activity.
	  * Match any value of the Activity segment
	  */
	public boolean isAnyActivity();

    /** Column name AnyAsset */
    public static final String COLUMNNAME_AnyAsset = "AnyAsset";

	/** Set Any Asset.
	  * Match any value of the Asset segment
	  */
	public void setAnyAsset (boolean AnyAsset);

	/** Get Any Asset.
	  * Match any value of the Asset segment
	  */
	public boolean isAnyAsset();

    /** Column name AnyAttributeSetInstance */
    public static final String COLUMNNAME_AnyAttributeSetInstance = "AnyAttributeSetInstance";

	/** Set Any Attribute Set Instance.
	  * Match any value of the Employee segment
	  */
	public void setAnyAttributeSetInstance (boolean AnyAttributeSetInstance);

	/** Get Any Attribute Set Instance.
	  * Match any value of the Employee segment
	  */
	public boolean isAnyAttributeSetInstance();

    /** Column name AnyBPartner */
    public static final String COLUMNNAME_AnyBPartner = "AnyBPartner";

	/** Set Any Bus.Partner.
	  * Match any value of the Business Partner segment
	  */
	public void setAnyBPartner (boolean AnyBPartner);

	/** Get Any Bus.Partner.
	  * Match any value of the Business Partner segment
	  */
	public boolean isAnyBPartner();

    /** Column name AnyCampaign */
    public static final String COLUMNNAME_AnyCampaign = "AnyCampaign";

	/** Set Any Campaign.
	  * Match any value of the Campaign segment
	  */
	public void setAnyCampaign (boolean AnyCampaign);

	/** Get Any Campaign.
	  * Match any value of the Campaign segment
	  */
	public boolean isAnyCampaign();

    /** Column name AnyCharge */
    public static final String COLUMNNAME_AnyCharge = "AnyCharge";

	/** Set Any Charge.
	  * Match any value of the Charge segment
	  */
	public void setAnyCharge (boolean AnyCharge);

	/** Get Any Charge.
	  * Match any value of the Charge segment
	  */
	public boolean isAnyCharge();

    /** Column name AnyCostCenter */
    public static final String COLUMNNAME_AnyCostCenter = "AnyCostCenter";

	/** Set Any Cost Center.
	  * Match any value of the Cost Center segment
	  */
	public void setAnyCostCenter (boolean AnyCostCenter);

	/** Get Any Cost Center.
	  * Match any value of the Cost Center segment
	  */
	public boolean isAnyCostCenter();

    /** Column name AnyDepartment */
    public static final String COLUMNNAME_AnyDepartment = "AnyDepartment";

	/** Set Any Department.
	  * Match any value of the Department segment
	  */
	public void setAnyDepartment (boolean AnyDepartment);

	/** Get Any Department.
	  * Match any value of the Department segment
	  */
	public boolean isAnyDepartment();

    /** Column name AnyEmployee */
    public static final String COLUMNNAME_AnyEmployee = "AnyEmployee";

	/** Set Any Employee.
	  * Match any value of the Employee segment
	  */
	public void setAnyEmployee (boolean AnyEmployee);

	/** Get Any Employee.
	  * Match any value of the Employee segment
	  */
	public boolean isAnyEmployee();

    /** Column name AnyLocFrom */
    public static final String COLUMNNAME_AnyLocFrom = "AnyLocFrom";

	/** Set Any Location From.
	  * Match any value of the Location From segment
	  */
	public void setAnyLocFrom (boolean AnyLocFrom);

	/** Get Any Location From.
	  * Match any value of the Location From segment
	  */
	public boolean isAnyLocFrom();

    /** Column name AnyLocTo */
    public static final String COLUMNNAME_AnyLocTo = "AnyLocTo";

	/** Set Any Location To.
	  * Match any value of the Location To segment
	  */
	public void setAnyLocTo (boolean AnyLocTo);

	/** Get Any Location To.
	  * Match any value of the Location To segment
	  */
	public boolean isAnyLocTo();

    /** Column name AnyOrg */
    public static final String COLUMNNAME_AnyOrg = "AnyOrg";

	/** Set Any Organization.
	  * Match any value of the Organization segment
	  */
	public void setAnyOrg (boolean AnyOrg);

	/** Get Any Organization.
	  * Match any value of the Organization segment
	  */
	public boolean isAnyOrg();

    /** Column name AnyOrgTrx */
    public static final String COLUMNNAME_AnyOrgTrx = "AnyOrgTrx";

	/** Set Any Trx Organization.
	  * Match any value of the Transaction Organization segment
	  */
	public void setAnyOrgTrx (boolean AnyOrgTrx);

	/** Get Any Trx Organization.
	  * Match any value of the Transaction Organization segment
	  */
	public boolean isAnyOrgTrx();

    /** Column name AnyProduct */
    public static final String COLUMNNAME_AnyProduct = "AnyProduct";

	/** Set Any Product.
	  * Match any value of the Product segment
	  */
	public void setAnyProduct (boolean AnyProduct);

	/** Get Any Product.
	  * Match any value of the Product segment
	  */
	public boolean isAnyProduct();

    /** Column name AnyProject */
    public static final String COLUMNNAME_AnyProject = "AnyProject";

	/** Set Any Project.
	  * Match any value of the Project segment
	  */
	public void setAnyProject (boolean AnyProject);

	/** Get Any Project.
	  * Match any value of the Project segment
	  */
	public boolean isAnyProject();

    /** Column name AnySalesRegion */
    public static final String COLUMNNAME_AnySalesRegion = "AnySalesRegion";

	/** Set Any Sales Region.
	  * Match any value of the Sales Region segment
	  */
	public void setAnySalesRegion (boolean AnySalesRegion);

	/** Get Any Sales Region.
	  * Match any value of the Sales Region segment
	  */
	public boolean isAnySalesRegion();

    /** Column name AnyUser1 */
    public static final String COLUMNNAME_AnyUser1 = "AnyUser1";

	/** Set Any User 1.
	  * Match any value of the User 1 segment
	  */
	public void setAnyUser1 (boolean AnyUser1);

	/** Get Any User 1.
	  * Match any value of the User 1 segment
	  */
	public boolean isAnyUser1();

    /** Column name AnyUser2 */
    public static final String COLUMNNAME_AnyUser2 = "AnyUser2";

	/** Set Any User 2.
	  * Match any value of the User 2 segment
	  */
	public void setAnyUser2 (boolean AnyUser2);

	/** Get Any User 2.
	  * Match any value of the User 2 segment
	  */
	public boolean isAnyUser2();

    /** Column name AnyWarehouse */
    public static final String COLUMNNAME_AnyWarehouse = "AnyWarehouse";

	/** Set Any Warehouse.
	  * Match any value of the Warehouse segment
	  */
	public void setAnyWarehouse (boolean AnyWarehouse);

	/** Get Any Warehouse.
	  * Match any value of the Warehouse segment
	  */
	public boolean isAnyWarehouse();

    /** Column name C_AcctSchema_ID */
    public static final String COLUMNNAME_C_AcctSchema_ID = "C_AcctSchema_ID";

	/** Set Accounting Schema.
	  * Rules for accounting
	  */
	public void setC_AcctSchema_ID (int C_AcctSchema_ID);

	/** Get Accounting Schema.
	  * Rules for accounting
	  */
	public int getC_AcctSchema_ID();

	public org.compiere.model.I_C_AcctSchema getC_AcctSchema() throws RuntimeException;

    /** Column name C_Activity_ID */
    public static final String COLUMNNAME_C_Activity_ID = "C_Activity_ID";

	/** Set Activity.
	  * Business Activity
	  */
	public void setC_Activity_ID (int C_Activity_ID);

	/** Get Activity.
	  * Business Activity
	  */
	public int getC_Activity_ID();

	public org.compiere.model.I_C_Activity getC_Activity() throws RuntimeException;

    /** Column name C_BPartner_ID */
    public static final String COLUMNNAME_C_BPartner_ID = "C_BPartner_ID";

	/** Set Business Partner.
	  * Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID);

	/** Get Business Partner.
	  * Identifies a Business Partner
	  */
	public int getC_BPartner_ID();

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException;

    /** Column name C_Campaign_ID */
    public static final String COLUMNNAME_C_Campaign_ID = "C_Campaign_ID";

	/** Set Campaign.
	  * Marketing Campaign
	  */
	public void setC_Campaign_ID (int C_Campaign_ID);

	/** Get Campaign.
	  * Marketing Campaign
	  */
	public int getC_Campaign_ID();

	public org.compiere.model.I_C_Campaign getC_Campaign() throws RuntimeException;

    /** Column name C_Charge_ID */
    public static final String COLUMNNAME_C_Charge_ID = "C_Charge_ID";

	/** Set Charge.
	  * Additional document charges
	  */
	public void setC_Charge_ID (int C_Charge_ID);

	/** Get Charge.
	  * Additional document charges
	  */
	public int getC_Charge_ID();

	public org.compiere.model.I_C_Charge getC_Charge() throws RuntimeException;

    /** Column name C_CostCenter_ID */
    public static final String COLUMNNAME_C_CostCenter_ID = "C_CostCenter_ID";

	/** Set Cost Center	  */
	public void setC_CostCenter_ID (int C_CostCenter_ID);

	/** Get Cost Center	  */
	public int getC_CostCenter_ID();

	public org.compiere.model.I_C_CostCenter getC_CostCenter() throws RuntimeException;

    /** Column name C_Department_ID */
    public static final String COLUMNNAME_C_Department_ID = "C_Department_ID";

	/** Set Department	  */
	public void setC_Department_ID (int C_Department_ID);

	/** Get Department	  */
	public int getC_Department_ID();

	public org.compiere.model.I_C_Department getC_Department() throws RuntimeException;

    /** Column name C_DocType_ID */
    public static final String COLUMNNAME_C_DocType_ID = "C_DocType_ID";

	/** Set Document Type.
	  * Document type or rules
	  */
	public void setC_DocType_ID (int C_DocType_ID);

	/** Get Document Type.
	  * Document type or rules
	  */
	public int getC_DocType_ID();

	public org.compiere.model.I_C_DocType getC_DocType() throws RuntimeException;

    /** Column name C_Employee_ID */
    public static final String COLUMNNAME_C_Employee_ID = "C_Employee_ID";

	/** Set Employee.
	  * Identifies a Business Partner
	  */
	public void setC_Employee_ID (int C_Employee_ID);

	/** Get Employee.
	  * Identifies a Business Partner
	  */
	public int getC_Employee_ID();

	public org.compiere.model.I_C_BPartner getC_Employee() throws RuntimeException;

    /** Column name C_LocFrom_ID */
    public static final String COLUMNNAME_C_LocFrom_ID = "C_LocFrom_ID";

	/** Set Location From.
	  * Location that inventory was moved from
	  */
	public void setC_LocFrom_ID (int C_LocFrom_ID);

	/** Get Location From.
	  * Location that inventory was moved from
	  */
	public int getC_LocFrom_ID();

	public org.compiere.model.I_C_Location getC_LocFrom() throws RuntimeException;

    /** Column name C_LocTo_ID */
    public static final String COLUMNNAME_C_LocTo_ID = "C_LocTo_ID";

	/** Set Location To.
	  * Location that inventory was moved to
	  */
	public void setC_LocTo_ID (int C_LocTo_ID);

	/** Get Location To.
	  * Location that inventory was moved to
	  */
	public int getC_LocTo_ID();

	public org.compiere.model.I_C_Location getC_LocTo() throws RuntimeException;

    /** Column name C_Project_ID */
    public static final String COLUMNNAME_C_Project_ID = "C_Project_ID";

	/** Set Project.
	  * Financial Project
	  */
	public void setC_Project_ID (int C_Project_ID);

	/** Get Project.
	  * Financial Project
	  */
	public int getC_Project_ID();

	public org.compiere.model.I_C_Project getC_Project() throws RuntimeException;

    /** Column name C_SalesRegion_ID */
    public static final String COLUMNNAME_C_SalesRegion_ID = "C_SalesRegion_ID";

	/** Set Sales Region.
	  * Sales coverage region
	  */
	public void setC_SalesRegion_ID (int C_SalesRegion_ID);

	/** Get Sales Region.
	  * Sales coverage region
	  */
	public int getC_SalesRegion_ID();

	public org.compiere.model.I_C_SalesRegion getC_SalesRegion() throws RuntimeException;

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

    /** Column name GL_Distribution_ID */
    public static final String COLUMNNAME_GL_Distribution_ID = "GL_Distribution_ID";

	/** Set GL Distribution.
	  * General Ledger Distribution
	  */
	public void setGL_Distribution_ID (int GL_Distribution_ID);

	/** Get GL Distribution.
	  * General Ledger Distribution
	  */
	public int getGL_Distribution_ID();

    /** Column name GL_Distribution_UU */
    public static final String COLUMNNAME_GL_Distribution_UU = "GL_Distribution_UU";

	/** Set GL_Distribution_UU	  */
	public void setGL_Distribution_UU (String GL_Distribution_UU);

	/** Get GL_Distribution_UU	  */
	public String getGL_Distribution_UU();

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

    /** Column name IsCreateReversal */
    public static final String COLUMNNAME_IsCreateReversal = "IsCreateReversal";

	/** Set Create Reversal.
	  * Indicates that reversal movement will be created, if disabled the original movement will be deleted.
	  */
	public void setIsCreateReversal (boolean IsCreateReversal);

	/** Get Create Reversal.
	  * Indicates that reversal movement will be created, if disabled the original movement will be deleted.
	  */
	public boolean isCreateReversal();

    /** Column name IsValid */
    public static final String COLUMNNAME_IsValid = "IsValid";

	/** Set Valid.
	  * Element is valid
	  */
	public void setIsValid (boolean IsValid);

	/** Get Valid.
	  * Element is valid
	  */
	public boolean isValid();

    /** Column name M_AttributeSetInstance_ID */
    public static final String COLUMNNAME_M_AttributeSetInstance_ID = "M_AttributeSetInstance_ID";

	/** Set Attribute Set Instance.
	  * Product Attribute Set Instance
	  */
	public void setM_AttributeSetInstance_ID (int M_AttributeSetInstance_ID);

	/** Get Attribute Set Instance.
	  * Product Attribute Set Instance
	  */
	public int getM_AttributeSetInstance_ID();

	public org.compiere.model.I_M_AttributeSetInstance getM_AttributeSetInstance() throws RuntimeException;

    /** Column name M_Product_ID */
    public static final String COLUMNNAME_M_Product_ID = "M_Product_ID";

	/** Set Product.
	  * Product, Service, Item
	  */
	public void setM_Product_ID (int M_Product_ID);

	/** Get Product.
	  * Product, Service, Item
	  */
	public int getM_Product_ID();

	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException;

    /** Column name M_Warehouse_ID */
    public static final String COLUMNNAME_M_Warehouse_ID = "M_Warehouse_ID";

	/** Set Warehouse.
	  * Storage Warehouse and Service Point
	  */
	public void setM_Warehouse_ID (int M_Warehouse_ID);

	/** Get Warehouse.
	  * Storage Warehouse and Service Point
	  */
	public int getM_Warehouse_ID();

	public org.compiere.model.I_M_Warehouse getM_Warehouse() throws RuntimeException;

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

    /** Column name Org_ID */
    public static final String COLUMNNAME_Org_ID = "Org_ID";

	/** Set Organization.
	  * Organizational entity within tenant
	  */
	public void setOrg_ID (int Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
	  */
	public int getOrg_ID();

    /** Column name PercentTotal */
    public static final String COLUMNNAME_PercentTotal = "PercentTotal";

	/** Set Total Percent.
	  * Sum of the Percent details 
	  */
	public void setPercentTotal (BigDecimal PercentTotal);

	/** Get Total Percent.
	  * Sum of the Percent details 
	  */
	public BigDecimal getPercentTotal();

    /** Column name PostingType */
    public static final String COLUMNNAME_PostingType = "PostingType";

	/** Set Posting Type.
	  * The type of posted amount for the transaction
	  */
	public void setPostingType (String PostingType);

	/** Get Posting Type.
	  * The type of posted amount for the transaction
	  */
	public String getPostingType();

    /** Column name Processing */
    public static final String COLUMNNAME_Processing = "Processing";

	/** Set Process Now	  */
	public void setProcessing (boolean Processing);

	/** Get Process Now	  */
	public boolean isProcessing();

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

    /** Column name User1_ID */
    public static final String COLUMNNAME_User1_ID = "User1_ID";

	/** Set User Element List 1.
	  * User defined list element #1
	  */
	public void setUser1_ID (int User1_ID);

	/** Get User Element List 1.
	  * User defined list element #1
	  */
	public int getUser1_ID();

	public org.compiere.model.I_C_ElementValue getUser1() throws RuntimeException;

    /** Column name User2_ID */
    public static final String COLUMNNAME_User2_ID = "User2_ID";

	/** Set User Element List 2.
	  * User defined list element #2
	  */
	public void setUser2_ID (int User2_ID);

	/** Get User Element List 2.
	  * User defined list element #2
	  */
	public int getUser2_ID();

	public org.compiere.model.I_C_ElementValue getUser2() throws RuntimeException;

    /** Column name ValidFrom */
    public static final String COLUMNNAME_ValidFrom = "ValidFrom";

	/** Set Valid from.
	  * Valid from including this date (first day)
	  */
	public void setValidFrom (Timestamp ValidFrom);

	/** Get Valid from.
	  * Valid from including this date (first day)
	  */
	public Timestamp getValidFrom();

    /** Column name ValidTo */
    public static final String COLUMNNAME_ValidTo = "ValidTo";

	/** Set Valid to.
	  * Valid to including this date (last day)
	  */
	public void setValidTo (Timestamp ValidTo);

	/** Get Valid to.
	  * Valid to including this date (last day)
	  */
	public Timestamp getValidTo();
}
