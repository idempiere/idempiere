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

/** Generated Model for GL_DistributionLine
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="GL_DistributionLine")
public class X_GL_DistributionLine extends PO implements I_GL_DistributionLine, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250307L;

    /** Standard Constructor */
    public X_GL_DistributionLine (Properties ctx, int GL_DistributionLine_ID, String trxName)
    {
      super (ctx, GL_DistributionLine_ID, trxName);
      /** if (GL_DistributionLine_ID == 0)
        {
			setGL_DistributionLine_ID (0);
			setGL_Distribution_ID (0);
			setLine (0);
// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM GL_DistributionLine WHERE GL_Distribution_ID=@GL_Distribution_ID@
			setOverwriteAcct (false);
			setOverwriteActivity (false);
			setOverwriteAsset (false);
// N
			setOverwriteAttributeSetInstance (false);
// N
			setOverwriteBPartner (false);
			setOverwriteCampaign (false);
			setOverwriteCharge (false);
// N
			setOverwriteCostCenter (false);
// N
			setOverwriteDepartment (false);
// N
			setOverwriteEmployee (false);
// N
			setOverwriteLocFrom (false);
			setOverwriteLocTo (false);
			setOverwriteOrg (false);
			setOverwriteOrgTrx (false);
			setOverwriteProduct (false);
			setOverwriteProject (false);
			setOverwriteSalesRegion (false);
			setOverwriteUser1 (false);
			setOverwriteUser2 (false);
			setOverwriteWarehouse (false);
// N
			setPercent (Env.ZERO);
        } */
    }

    /** Standard Constructor */
    public X_GL_DistributionLine (Properties ctx, int GL_DistributionLine_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, GL_DistributionLine_ID, trxName, virtualColumns);
      /** if (GL_DistributionLine_ID == 0)
        {
			setGL_DistributionLine_ID (0);
			setGL_Distribution_ID (0);
			setLine (0);
// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM GL_DistributionLine WHERE GL_Distribution_ID=@GL_Distribution_ID@
			setOverwriteAcct (false);
			setOverwriteActivity (false);
			setOverwriteAsset (false);
// N
			setOverwriteAttributeSetInstance (false);
// N
			setOverwriteBPartner (false);
			setOverwriteCampaign (false);
			setOverwriteCharge (false);
// N
			setOverwriteCostCenter (false);
// N
			setOverwriteDepartment (false);
// N
			setOverwriteEmployee (false);
// N
			setOverwriteLocFrom (false);
			setOverwriteLocTo (false);
			setOverwriteOrg (false);
			setOverwriteOrgTrx (false);
			setOverwriteProduct (false);
			setOverwriteProject (false);
			setOverwriteSalesRegion (false);
			setOverwriteUser1 (false);
			setOverwriteUser2 (false);
			setOverwriteWarehouse (false);
// N
			setPercent (Env.ZERO);
        } */
    }

    /** Standard Constructor */
    public X_GL_DistributionLine (Properties ctx, String GL_DistributionLine_UU, String trxName)
    {
      super (ctx, GL_DistributionLine_UU, trxName);
      /** if (GL_DistributionLine_UU == null)
        {
			setGL_DistributionLine_ID (0);
			setGL_Distribution_ID (0);
			setLine (0);
// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM GL_DistributionLine WHERE GL_Distribution_ID=@GL_Distribution_ID@
			setOverwriteAcct (false);
			setOverwriteActivity (false);
			setOverwriteAsset (false);
// N
			setOverwriteAttributeSetInstance (false);
// N
			setOverwriteBPartner (false);
			setOverwriteCampaign (false);
			setOverwriteCharge (false);
// N
			setOverwriteCostCenter (false);
// N
			setOverwriteDepartment (false);
// N
			setOverwriteEmployee (false);
// N
			setOverwriteLocFrom (false);
			setOverwriteLocTo (false);
			setOverwriteOrg (false);
			setOverwriteOrgTrx (false);
			setOverwriteProduct (false);
			setOverwriteProject (false);
			setOverwriteSalesRegion (false);
			setOverwriteUser1 (false);
			setOverwriteUser2 (false);
			setOverwriteWarehouse (false);
// N
			setPercent (Env.ZERO);
        } */
    }

    /** Standard Constructor */
    public X_GL_DistributionLine (Properties ctx, String GL_DistributionLine_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, GL_DistributionLine_UU, trxName, virtualColumns);
      /** if (GL_DistributionLine_UU == null)
        {
			setGL_DistributionLine_ID (0);
			setGL_Distribution_ID (0);
			setLine (0);
// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM GL_DistributionLine WHERE GL_Distribution_ID=@GL_Distribution_ID@
			setOverwriteAcct (false);
			setOverwriteActivity (false);
			setOverwriteAsset (false);
// N
			setOverwriteAttributeSetInstance (false);
// N
			setOverwriteBPartner (false);
			setOverwriteCampaign (false);
			setOverwriteCharge (false);
// N
			setOverwriteCostCenter (false);
// N
			setOverwriteDepartment (false);
// N
			setOverwriteEmployee (false);
// N
			setOverwriteLocFrom (false);
			setOverwriteLocTo (false);
			setOverwriteOrg (false);
			setOverwriteOrgTrx (false);
			setOverwriteProduct (false);
			setOverwriteProject (false);
			setOverwriteSalesRegion (false);
			setOverwriteUser1 (false);
			setOverwriteUser2 (false);
			setOverwriteWarehouse (false);
// N
			setPercent (Env.ZERO);
        } */
    }

    /** Load Constructor */
    public X_GL_DistributionLine (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 2 - Client
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
      StringBuilder sb = new StringBuilder ("X_GL_DistributionLine[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Trx Organization.
		@param AD_OrgTrx_ID Performing or initiating organization
	*/
	public void setAD_OrgTrx_ID (int AD_OrgTrx_ID)
	{
		if (AD_OrgTrx_ID < 1)
			set_Value (COLUMNNAME_AD_OrgTrx_ID, null);
		else
			set_Value (COLUMNNAME_AD_OrgTrx_ID, Integer.valueOf(AD_OrgTrx_ID));
	}

	/** Get Trx Organization.
		@return Performing or initiating organization
	  */
	public int getAD_OrgTrx_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_OrgTrx_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_A_Asset getA_Asset() throws RuntimeException
	{
		return (org.compiere.model.I_A_Asset)MTable.get(getCtx(), org.compiere.model.I_A_Asset.Table_ID)
			.getPO(getA_Asset_ID(), get_TrxName());
	}

	/** Set Asset.
		@param A_Asset_ID Asset used internally or by customers
	*/
	public void setA_Asset_ID (int A_Asset_ID)
	{
		if (A_Asset_ID < 1)
			set_Value (COLUMNNAME_A_Asset_ID, null);
		else
			set_Value (COLUMNNAME_A_Asset_ID, Integer.valueOf(A_Asset_ID));
	}

	/** Get Asset.
		@return Asset used internally or by customers
	  */
	public int getA_Asset_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_A_Asset_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Account.
		@param Account_ID Account used
	*/
	public void setAccount_ID (int Account_ID)
	{
		if (Account_ID < 1)
			set_Value (COLUMNNAME_Account_ID, null);
		else
			set_Value (COLUMNNAME_Account_ID, Integer.valueOf(Account_ID));
	}

	/** Get Account.
		@return Account used
	  */
	public int getAccount_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Account_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Activity getC_Activity() throws RuntimeException
	{
		return (org.compiere.model.I_C_Activity)MTable.get(getCtx(), org.compiere.model.I_C_Activity.Table_ID)
			.getPO(getC_Activity_ID(), get_TrxName());
	}

	/** Set Activity.
		@param C_Activity_ID Business Activity
	*/
	public void setC_Activity_ID (int C_Activity_ID)
	{
		if (C_Activity_ID < 1)
			set_Value (COLUMNNAME_C_Activity_ID, null);
		else
			set_Value (COLUMNNAME_C_Activity_ID, Integer.valueOf(C_Activity_ID));
	}

	/** Get Activity.
		@return Business Activity
	  */
	public int getC_Activity_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Activity_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException
	{
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_ID)
			.getPO(getC_BPartner_ID(), get_TrxName());
	}

	/** Set Business Partner.
		@param C_BPartner_ID Identifies a Business Partner
	*/
	public void setC_BPartner_ID (int C_BPartner_ID)
	{
		if (C_BPartner_ID < 1)
			set_Value (COLUMNNAME_C_BPartner_ID, null);
		else
			set_Value (COLUMNNAME_C_BPartner_ID, Integer.valueOf(C_BPartner_ID));
	}

	/** Get Business Partner.
		@return Identifies a Business Partner
	  */
	public int getC_BPartner_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Campaign getC_Campaign() throws RuntimeException
	{
		return (org.compiere.model.I_C_Campaign)MTable.get(getCtx(), org.compiere.model.I_C_Campaign.Table_ID)
			.getPO(getC_Campaign_ID(), get_TrxName());
	}

	/** Set Campaign.
		@param C_Campaign_ID Marketing Campaign
	*/
	public void setC_Campaign_ID (int C_Campaign_ID)
	{
		if (C_Campaign_ID < 1)
			set_Value (COLUMNNAME_C_Campaign_ID, null);
		else
			set_Value (COLUMNNAME_C_Campaign_ID, Integer.valueOf(C_Campaign_ID));
	}

	/** Get Campaign.
		@return Marketing Campaign
	  */
	public int getC_Campaign_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Campaign_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Charge getC_Charge() throws RuntimeException
	{
		return (org.compiere.model.I_C_Charge)MTable.get(getCtx(), org.compiere.model.I_C_Charge.Table_ID)
			.getPO(getC_Charge_ID(), get_TrxName());
	}

	/** Set Charge.
		@param C_Charge_ID Additional document charges
	*/
	public void setC_Charge_ID (int C_Charge_ID)
	{
		if (C_Charge_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_Charge_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_Charge_ID, Integer.valueOf(C_Charge_ID));
	}

	/** Get Charge.
		@return Additional document charges
	  */
	public int getC_Charge_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Charge_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_CostCenter getC_CostCenter() throws RuntimeException
	{
		return (org.compiere.model.I_C_CostCenter)MTable.get(getCtx(), org.compiere.model.I_C_CostCenter.Table_ID)
			.getPO(getC_CostCenter_ID(), get_TrxName());
	}

	/** Set Cost Center.
		@param C_CostCenter_ID Cost Center
	*/
	public void setC_CostCenter_ID (int C_CostCenter_ID)
	{
		if (C_CostCenter_ID < 1)
			set_Value (COLUMNNAME_C_CostCenter_ID, null);
		else
			set_Value (COLUMNNAME_C_CostCenter_ID, Integer.valueOf(C_CostCenter_ID));
	}

	/** Get Cost Center.
		@return Cost Center	  */
	public int getC_CostCenter_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_CostCenter_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Department getC_Department() throws RuntimeException
	{
		return (org.compiere.model.I_C_Department)MTable.get(getCtx(), org.compiere.model.I_C_Department.Table_ID)
			.getPO(getC_Department_ID(), get_TrxName());
	}

	/** Set Department.
		@param C_Department_ID Department
	*/
	public void setC_Department_ID (int C_Department_ID)
	{
		if (C_Department_ID < 1)
			set_Value (COLUMNNAME_C_Department_ID, null);
		else
			set_Value (COLUMNNAME_C_Department_ID, Integer.valueOf(C_Department_ID));
	}

	/** Get Department.
		@return Department	  */
	public int getC_Department_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Department_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner getC_Employee() throws RuntimeException
	{
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_ID)
			.getPO(getC_Employee_ID(), get_TrxName());
	}

	/** Set Employee.
		@param C_Employee_ID Identifies a Business Partner
	*/
	public void setC_Employee_ID (int C_Employee_ID)
	{
		if (C_Employee_ID < 1)
			set_Value (COLUMNNAME_C_Employee_ID, null);
		else
			set_Value (COLUMNNAME_C_Employee_ID, Integer.valueOf(C_Employee_ID));
	}

	/** Get Employee.
		@return Identifies a Business Partner
	  */
	public int getC_Employee_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Employee_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Location getC_LocFrom() throws RuntimeException
	{
		return (org.compiere.model.I_C_Location)MTable.get(getCtx(), org.compiere.model.I_C_Location.Table_ID)
			.getPO(getC_LocFrom_ID(), get_TrxName());
	}

	/** Set Location From.
		@param C_LocFrom_ID Location that inventory was moved from
	*/
	public void setC_LocFrom_ID (int C_LocFrom_ID)
	{
		if (C_LocFrom_ID < 1)
			set_Value (COLUMNNAME_C_LocFrom_ID, null);
		else
			set_Value (COLUMNNAME_C_LocFrom_ID, Integer.valueOf(C_LocFrom_ID));
	}

	/** Get Location From.
		@return Location that inventory was moved from
	  */
	public int getC_LocFrom_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_LocFrom_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Location getC_LocTo() throws RuntimeException
	{
		return (org.compiere.model.I_C_Location)MTable.get(getCtx(), org.compiere.model.I_C_Location.Table_ID)
			.getPO(getC_LocTo_ID(), get_TrxName());
	}

	/** Set Location To.
		@param C_LocTo_ID Location that inventory was moved to
	*/
	public void setC_LocTo_ID (int C_LocTo_ID)
	{
		if (C_LocTo_ID < 1)
			set_Value (COLUMNNAME_C_LocTo_ID, null);
		else
			set_Value (COLUMNNAME_C_LocTo_ID, Integer.valueOf(C_LocTo_ID));
	}

	/** Get Location To.
		@return Location that inventory was moved to
	  */
	public int getC_LocTo_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_LocTo_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Project getC_Project() throws RuntimeException
	{
		return (org.compiere.model.I_C_Project)MTable.get(getCtx(), org.compiere.model.I_C_Project.Table_ID)
			.getPO(getC_Project_ID(), get_TrxName());
	}

	/** Set Project.
		@param C_Project_ID Financial Project
	*/
	public void setC_Project_ID (int C_Project_ID)
	{
		if (C_Project_ID < 1)
			set_Value (COLUMNNAME_C_Project_ID, null);
		else
			set_Value (COLUMNNAME_C_Project_ID, Integer.valueOf(C_Project_ID));
	}

	/** Get Project.
		@return Financial Project
	  */
	public int getC_Project_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Project_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_SalesRegion getC_SalesRegion() throws RuntimeException
	{
		return (org.compiere.model.I_C_SalesRegion)MTable.get(getCtx(), org.compiere.model.I_C_SalesRegion.Table_ID)
			.getPO(getC_SalesRegion_ID(), get_TrxName());
	}

	/** Set Sales Region.
		@param C_SalesRegion_ID Sales coverage region
	*/
	public void setC_SalesRegion_ID (int C_SalesRegion_ID)
	{
		if (C_SalesRegion_ID < 1)
			set_Value (COLUMNNAME_C_SalesRegion_ID, null);
		else
			set_Value (COLUMNNAME_C_SalesRegion_ID, Integer.valueOf(C_SalesRegion_ID));
	}

	/** Get Sales Region.
		@return Sales coverage region
	  */
	public int getC_SalesRegion_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_SalesRegion_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set GL Distribution Line.
		@param GL_DistributionLine_ID General Ledger Distribution Line
	*/
	public void setGL_DistributionLine_ID (int GL_DistributionLine_ID)
	{
		if (GL_DistributionLine_ID < 1)
			set_ValueNoCheck (COLUMNNAME_GL_DistributionLine_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_GL_DistributionLine_ID, Integer.valueOf(GL_DistributionLine_ID));
	}

	/** Get GL Distribution Line.
		@return General Ledger Distribution Line
	  */
	public int getGL_DistributionLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_GL_DistributionLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set GL_DistributionLine_UU.
		@param GL_DistributionLine_UU GL_DistributionLine_UU
	*/
	public void setGL_DistributionLine_UU (String GL_DistributionLine_UU)
	{
		set_Value (COLUMNNAME_GL_DistributionLine_UU, GL_DistributionLine_UU);
	}

	/** Get GL_DistributionLine_UU.
		@return GL_DistributionLine_UU	  */
	public String getGL_DistributionLine_UU()
	{
		return (String)get_Value(COLUMNNAME_GL_DistributionLine_UU);
	}

	public org.compiere.model.I_GL_Distribution getGL_Distribution() throws RuntimeException
	{
		return (org.compiere.model.I_GL_Distribution)MTable.get(getCtx(), org.compiere.model.I_GL_Distribution.Table_ID)
			.getPO(getGL_Distribution_ID(), get_TrxName());
	}

	/** Set GL Distribution.
		@param GL_Distribution_ID General Ledger Distribution
	*/
	public void setGL_Distribution_ID (int GL_Distribution_ID)
	{
		if (GL_Distribution_ID < 1)
			set_ValueNoCheck (COLUMNNAME_GL_Distribution_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_GL_Distribution_ID, Integer.valueOf(GL_Distribution_ID));
	}

	/** Get GL Distribution.
		@return General Ledger Distribution
	  */
	public int getGL_Distribution_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_GL_Distribution_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Line No.
		@param Line Unique line for this document
	*/
	public void setLine (int Line)
	{
		set_Value (COLUMNNAME_Line, Integer.valueOf(Line));
	}

	/** Get Line No.
		@return Unique line for this document
	  */
	public int getLine()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Line);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair()
    {
        return new KeyNamePair(get_ID(), String.valueOf(getLine()));
    }

	public org.compiere.model.I_M_AttributeSetInstance getM_AttributeSetInstance() throws RuntimeException
	{
		return (org.compiere.model.I_M_AttributeSetInstance)MTable.get(getCtx(), org.compiere.model.I_M_AttributeSetInstance.Table_ID)
			.getPO(getM_AttributeSetInstance_ID(), get_TrxName());
	}

	/** Set Attribute Set Instance.
		@param M_AttributeSetInstance_ID Product Attribute Set Instance
	*/
	public void setM_AttributeSetInstance_ID (int M_AttributeSetInstance_ID)
	{
		if (M_AttributeSetInstance_ID < 0)
			set_Value (COLUMNNAME_M_AttributeSetInstance_ID, null);
		else
			set_Value (COLUMNNAME_M_AttributeSetInstance_ID, Integer.valueOf(M_AttributeSetInstance_ID));
	}

	/** Get Attribute Set Instance.
		@return Product Attribute Set Instance
	  */
	public int getM_AttributeSetInstance_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_AttributeSetInstance_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException
	{
		return (org.compiere.model.I_M_Product)MTable.get(getCtx(), org.compiere.model.I_M_Product.Table_ID)
			.getPO(getM_Product_ID(), get_TrxName());
	}

	/** Set Product.
		@param M_Product_ID Product, Service, Item
	*/
	public void setM_Product_ID (int M_Product_ID)
	{
		if (M_Product_ID < 1)
			set_Value (COLUMNNAME_M_Product_ID, null);
		else
			set_Value (COLUMNNAME_M_Product_ID, Integer.valueOf(M_Product_ID));
	}

	/** Get Product.
		@return Product, Service, Item
	  */
	public int getM_Product_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Product_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Warehouse getM_Warehouse() throws RuntimeException
	{
		return (org.compiere.model.I_M_Warehouse)MTable.get(getCtx(), org.compiere.model.I_M_Warehouse.Table_ID)
			.getPO(getM_Warehouse_ID(), get_TrxName());
	}

	/** Set Warehouse.
		@param M_Warehouse_ID Storage Warehouse and Service Point
	*/
	public void setM_Warehouse_ID (int M_Warehouse_ID)
	{
		if (M_Warehouse_ID < 1)
			set_Value (COLUMNNAME_M_Warehouse_ID, null);
		else
			set_Value (COLUMNNAME_M_Warehouse_ID, Integer.valueOf(M_Warehouse_ID));
	}

	/** Get Warehouse.
		@return Storage Warehouse and Service Point
	  */
	public int getM_Warehouse_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Warehouse_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Organization.
		@param Org_ID Organizational entity within tenant
	*/
	public void setOrg_ID (int Org_ID)
	{
		if (Org_ID < 1)
			set_Value (COLUMNNAME_Org_ID, null);
		else
			set_Value (COLUMNNAME_Org_ID, Integer.valueOf(Org_ID));
	}

	/** Get Organization.
		@return Organizational entity within tenant
	  */
	public int getOrg_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Org_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Overwrite Account.
		@param OverwriteAcct Overwrite the account segment Account with the value specified
	*/
	public void setOverwriteAcct (boolean OverwriteAcct)
	{
		set_Value (COLUMNNAME_OverwriteAcct, Boolean.valueOf(OverwriteAcct));
	}

	/** Get Overwrite Account.
		@return Overwrite the account segment Account with the value specified
	  */
	public boolean isOverwriteAcct()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteAcct);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Activity.
		@param OverwriteActivity Overwrite the account segment Activity with the value specified
	*/
	public void setOverwriteActivity (boolean OverwriteActivity)
	{
		set_Value (COLUMNNAME_OverwriteActivity, Boolean.valueOf(OverwriteActivity));
	}

	/** Get Overwrite Activity.
		@return Overwrite the account segment Activity with the value specified
	  */
	public boolean isOverwriteActivity()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteActivity);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Asset.
		@param OverwriteAsset Overwrite the account segment Asset with the value specified
	*/
	public void setOverwriteAsset (boolean OverwriteAsset)
	{
		set_Value (COLUMNNAME_OverwriteAsset, Boolean.valueOf(OverwriteAsset));
	}

	/** Get Overwrite Asset.
		@return Overwrite the account segment Asset with the value specified
	  */
	public boolean isOverwriteAsset()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteAsset);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Attribute Set Instance.
		@param OverwriteAttributeSetInstance Overwrite the account segment Attribute Set Instance with the value specified
	*/
	public void setOverwriteAttributeSetInstance (boolean OverwriteAttributeSetInstance)
	{
		set_Value (COLUMNNAME_OverwriteAttributeSetInstance, Boolean.valueOf(OverwriteAttributeSetInstance));
	}

	/** Get Overwrite Attribute Set Instance.
		@return Overwrite the account segment Attribute Set Instance with the value specified
	  */
	public boolean isOverwriteAttributeSetInstance()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteAttributeSetInstance);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Bus.Partner.
		@param OverwriteBPartner Overwrite the account segment Business Partner with the value specified
	*/
	public void setOverwriteBPartner (boolean OverwriteBPartner)
	{
		set_Value (COLUMNNAME_OverwriteBPartner, Boolean.valueOf(OverwriteBPartner));
	}

	/** Get Overwrite Bus.Partner.
		@return Overwrite the account segment Business Partner with the value specified
	  */
	public boolean isOverwriteBPartner()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteBPartner);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Campaign.
		@param OverwriteCampaign Overwrite the account segment Campaign with the value specified
	*/
	public void setOverwriteCampaign (boolean OverwriteCampaign)
	{
		set_Value (COLUMNNAME_OverwriteCampaign, Boolean.valueOf(OverwriteCampaign));
	}

	/** Get Overwrite Campaign.
		@return Overwrite the account segment Campaign with the value specified
	  */
	public boolean isOverwriteCampaign()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteCampaign);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Charge.
		@param OverwriteCharge Overwrite the account segment Charge with the value specified
	*/
	public void setOverwriteCharge (boolean OverwriteCharge)
	{
		set_Value (COLUMNNAME_OverwriteCharge, Boolean.valueOf(OverwriteCharge));
	}

	/** Get Overwrite Charge.
		@return Overwrite the account segment Charge with the value specified
	  */
	public boolean isOverwriteCharge()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteCharge);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Cost Center.
		@param OverwriteCostCenter Overwrite the account segment Cost Center with the value specified
	*/
	public void setOverwriteCostCenter (boolean OverwriteCostCenter)
	{
		set_Value (COLUMNNAME_OverwriteCostCenter, Boolean.valueOf(OverwriteCostCenter));
	}

	/** Get Overwrite Cost Center.
		@return Overwrite the account segment Cost Center with the value specified
	  */
	public boolean isOverwriteCostCenter()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteCostCenter);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Department.
		@param OverwriteDepartment Overwrite the account segment Department with the value specified
	*/
	public void setOverwriteDepartment (boolean OverwriteDepartment)
	{
		set_Value (COLUMNNAME_OverwriteDepartment, Boolean.valueOf(OverwriteDepartment));
	}

	/** Get Overwrite Department.
		@return Overwrite the account segment Department with the value specified
	  */
	public boolean isOverwriteDepartment()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteDepartment);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Employee.
		@param OverwriteEmployee Overwrite the account segment Employee with the value specified
	*/
	public void setOverwriteEmployee (boolean OverwriteEmployee)
	{
		set_Value (COLUMNNAME_OverwriteEmployee, Boolean.valueOf(OverwriteEmployee));
	}

	/** Get Overwrite Employee.
		@return Overwrite the account segment Employee with the value specified
	  */
	public boolean isOverwriteEmployee()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteEmployee);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Location From.
		@param OverwriteLocFrom Overwrite the account segment Location From with the value specified
	*/
	public void setOverwriteLocFrom (boolean OverwriteLocFrom)
	{
		set_Value (COLUMNNAME_OverwriteLocFrom, Boolean.valueOf(OverwriteLocFrom));
	}

	/** Get Overwrite Location From.
		@return Overwrite the account segment Location From with the value specified
	  */
	public boolean isOverwriteLocFrom()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteLocFrom);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Location To.
		@param OverwriteLocTo Overwrite the account segment Location From with the value specified
	*/
	public void setOverwriteLocTo (boolean OverwriteLocTo)
	{
		set_Value (COLUMNNAME_OverwriteLocTo, Boolean.valueOf(OverwriteLocTo));
	}

	/** Get Overwrite Location To.
		@return Overwrite the account segment Location From with the value specified
	  */
	public boolean isOverwriteLocTo()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteLocTo);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Organization.
		@param OverwriteOrg Overwrite the account segment Organization with the value specified
	*/
	public void setOverwriteOrg (boolean OverwriteOrg)
	{
		set_Value (COLUMNNAME_OverwriteOrg, Boolean.valueOf(OverwriteOrg));
	}

	/** Get Overwrite Organization.
		@return Overwrite the account segment Organization with the value specified
	  */
	public boolean isOverwriteOrg()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteOrg);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Trx Organization.
		@param OverwriteOrgTrx Overwrite the account segment Transaction Organization with the value specified
	*/
	public void setOverwriteOrgTrx (boolean OverwriteOrgTrx)
	{
		set_Value (COLUMNNAME_OverwriteOrgTrx, Boolean.valueOf(OverwriteOrgTrx));
	}

	/** Get Overwrite Trx Organization.
		@return Overwrite the account segment Transaction Organization with the value specified
	  */
	public boolean isOverwriteOrgTrx()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteOrgTrx);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Product.
		@param OverwriteProduct Overwrite the account segment Product with the value specified
	*/
	public void setOverwriteProduct (boolean OverwriteProduct)
	{
		set_Value (COLUMNNAME_OverwriteProduct, Boolean.valueOf(OverwriteProduct));
	}

	/** Get Overwrite Product.
		@return Overwrite the account segment Product with the value specified
	  */
	public boolean isOverwriteProduct()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteProduct);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Project.
		@param OverwriteProject Overwrite the account segment Project with the value specified
	*/
	public void setOverwriteProject (boolean OverwriteProject)
	{
		set_Value (COLUMNNAME_OverwriteProject, Boolean.valueOf(OverwriteProject));
	}

	/** Get Overwrite Project.
		@return Overwrite the account segment Project with the value specified
	  */
	public boolean isOverwriteProject()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteProject);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Sales Region.
		@param OverwriteSalesRegion Overwrite the account segment Sales Region with the value specified
	*/
	public void setOverwriteSalesRegion (boolean OverwriteSalesRegion)
	{
		set_Value (COLUMNNAME_OverwriteSalesRegion, Boolean.valueOf(OverwriteSalesRegion));
	}

	/** Get Overwrite Sales Region.
		@return Overwrite the account segment Sales Region with the value specified
	  */
	public boolean isOverwriteSalesRegion()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteSalesRegion);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite User1.
		@param OverwriteUser1 Overwrite the account segment User 1 with the value specified
	*/
	public void setOverwriteUser1 (boolean OverwriteUser1)
	{
		set_Value (COLUMNNAME_OverwriteUser1, Boolean.valueOf(OverwriteUser1));
	}

	/** Get Overwrite User1.
		@return Overwrite the account segment User 1 with the value specified
	  */
	public boolean isOverwriteUser1()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteUser1);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite User2.
		@param OverwriteUser2 Overwrite the account segment User 2 with the value specified
	*/
	public void setOverwriteUser2 (boolean OverwriteUser2)
	{
		set_Value (COLUMNNAME_OverwriteUser2, Boolean.valueOf(OverwriteUser2));
	}

	/** Get Overwrite User2.
		@return Overwrite the account segment User 2 with the value specified
	  */
	public boolean isOverwriteUser2()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteUser2);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Overwrite Warehouse.
		@param OverwriteWarehouse Overwrite the account segment Warehouse with the value specified
	*/
	public void setOverwriteWarehouse (boolean OverwriteWarehouse)
	{
		set_Value (COLUMNNAME_OverwriteWarehouse, Boolean.valueOf(OverwriteWarehouse));
	}

	/** Get Overwrite Warehouse.
		@return Overwrite the account segment Warehouse with the value specified
	  */
	public boolean isOverwriteWarehouse()
	{
		Object oo = get_Value(COLUMNNAME_OverwriteWarehouse);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Percent.
		@param Percent Percentage
	*/
	public void setPercent (BigDecimal Percent)
	{
		set_Value (COLUMNNAME_Percent, Percent);
	}

	/** Get Percent.
		@return Percentage
	  */
	public BigDecimal getPercent()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Percent);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_C_ElementValue getUser1() throws RuntimeException
	{
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_ID)
			.getPO(getUser1_ID(), get_TrxName());
	}

	/** Set User Element List 1.
		@param User1_ID User defined list element #1
	*/
	public void setUser1_ID (int User1_ID)
	{
		if (User1_ID < 1)
			set_Value (COLUMNNAME_User1_ID, null);
		else
			set_Value (COLUMNNAME_User1_ID, Integer.valueOf(User1_ID));
	}

	/** Get User Element List 1.
		@return User defined list element #1
	  */
	public int getUser1_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_User1_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_ElementValue getUser2() throws RuntimeException
	{
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_ID)
			.getPO(getUser2_ID(), get_TrxName());
	}

	/** Set User Element List 2.
		@param User2_ID User defined list element #2
	*/
	public void setUser2_ID (int User2_ID)
	{
		if (User2_ID < 1)
			set_Value (COLUMNNAME_User2_ID, null);
		else
			set_Value (COLUMNNAME_User2_ID, Integer.valueOf(User2_ID));
	}

	/** Get User Element List 2.
		@return User defined list element #2
	  */
	public int getUser2_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_User2_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}