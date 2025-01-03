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

import java.sql.ResultSet;
import java.util.Properties;

/** Generated Model for C_DocBaseGroupLine
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="C_DocBaseGroupLine")
public class X_C_DocBaseGroupLine extends PO implements I_C_DocBaseGroupLine, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_C_DocBaseGroupLine (Properties ctx, int C_DocBaseGroupLine_ID, String trxName)
    {
      super (ctx, C_DocBaseGroupLine_ID, trxName);
      /** if (C_DocBaseGroupLine_ID == 0)
        {
			setC_DocBaseGroupLine_ID (0);
			setC_DocBaseGroup_ID (0);
			setDocBaseType (null);
        } */
    }

    /** Standard Constructor */
    public X_C_DocBaseGroupLine (Properties ctx, int C_DocBaseGroupLine_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_DocBaseGroupLine_ID, trxName, virtualColumns);
      /** if (C_DocBaseGroupLine_ID == 0)
        {
			setC_DocBaseGroupLine_ID (0);
			setC_DocBaseGroup_ID (0);
			setDocBaseType (null);
        } */
    }

    /** Standard Constructor */
    public X_C_DocBaseGroupLine (Properties ctx, String C_DocBaseGroupLine_UU, String trxName)
    {
      super (ctx, C_DocBaseGroupLine_UU, trxName);
      /** if (C_DocBaseGroupLine_UU == null)
        {
			setC_DocBaseGroupLine_ID (0);
			setC_DocBaseGroup_ID (0);
			setDocBaseType (null);
        } */
    }

    /** Standard Constructor */
    public X_C_DocBaseGroupLine (Properties ctx, String C_DocBaseGroupLine_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, C_DocBaseGroupLine_UU, trxName, virtualColumns);
      /** if (C_DocBaseGroupLine_UU == null)
        {
			setC_DocBaseGroupLine_ID (0);
			setC_DocBaseGroup_ID (0);
			setDocBaseType (null);
        } */
    }

    /** Load Constructor */
    public X_C_DocBaseGroupLine (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 6 - System - Client
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
      StringBuilder sb = new StringBuilder ("X_C_DocBaseGroupLine[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Document Base Type Group Line.
		@param C_DocBaseGroupLine_ID Line Items of a Document Base Type Group
	*/
	public void setC_DocBaseGroupLine_ID (int C_DocBaseGroupLine_ID)
	{
		if (C_DocBaseGroupLine_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_DocBaseGroupLine_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_DocBaseGroupLine_ID, Integer.valueOf(C_DocBaseGroupLine_ID));
	}

	/** Get Document Base Type Group Line.
		@return Line Items of a Document Base Type Group
	  */
	public int getC_DocBaseGroupLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_DocBaseGroupLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_DocBaseGroupLine_UU.
		@param C_DocBaseGroupLine_UU C_DocBaseGroupLine_UU
	*/
	public void setC_DocBaseGroupLine_UU (String C_DocBaseGroupLine_UU)
	{
		set_Value (COLUMNNAME_C_DocBaseGroupLine_UU, C_DocBaseGroupLine_UU);
	}

	/** Get C_DocBaseGroupLine_UU.
		@return C_DocBaseGroupLine_UU	  */
	public String getC_DocBaseGroupLine_UU()
	{
		return (String)get_Value(COLUMNNAME_C_DocBaseGroupLine_UU);
	}

	public org.compiere.model.I_C_DocBaseGroup getC_DocBaseGroup() throws RuntimeException
	{
		return (org.compiere.model.I_C_DocBaseGroup)MTable.get(getCtx(), org.compiere.model.I_C_DocBaseGroup.Table_ID)
			.getPO(getC_DocBaseGroup_ID(), get_TrxName());
	}

	/** Set Document Base Type Group.
		@param C_DocBaseGroup_ID Group of Document Base Type for Period Control
	*/
	public void setC_DocBaseGroup_ID (int C_DocBaseGroup_ID)
	{
		if (C_DocBaseGroup_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_DocBaseGroup_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_DocBaseGroup_ID, Integer.valueOf(C_DocBaseGroup_ID));
	}

	/** Get Document Base Type Group.
		@return Group of Document Base Type for Period Control
	  */
	public int getC_DocBaseGroup_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_DocBaseGroup_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** DocBaseType AD_Reference_ID=183 */
	public static final int DOCBASETYPE_AD_Reference_ID=183;
	/** AP Credit Memo = APC */
	public static final String DOCBASETYPE_APCreditMemo = "APC";
	/** AP Invoice = API */
	public static final String DOCBASETYPE_APInvoice = "API";
	/** AP Payment = APP */
	public static final String DOCBASETYPE_APPayment = "APP";
	/** AR Credit Memo = ARC */
	public static final String DOCBASETYPE_ARCreditMemo = "ARC";
	/** AR Pro Forma Invoice = ARF */
	public static final String DOCBASETYPE_ARProFormaInvoice = "ARF";
	/** AR Invoice = ARI */
	public static final String DOCBASETYPE_ARInvoice = "ARI";
	/** AR Receipt = ARR */
	public static final String DOCBASETYPE_ARReceipt = "ARR";
	/** Payment Allocation = CMA */
	public static final String DOCBASETYPE_PaymentAllocation = "CMA";
	/** Bank Statement = CMB */
	public static final String DOCBASETYPE_BankStatement = "CMB";
	/** Cash Journal = CMC */
	public static final String DOCBASETYPE_CashJournal = "CMC";
	/** Distribution Order = DOO */
	public static final String DOCBASETYPE_DistributionOrder = "DOO";
	/** Fixed Assets Addition = FAA */
	public static final String DOCBASETYPE_FixedAssetsAddition = "FAA";
	/** Fixed Assets Disposal = FAD */
	public static final String DOCBASETYPE_FixedAssetsDisposal = "FAD";
	/** Fixed Assets Depreciation = FDP */
	public static final String DOCBASETYPE_FixedAssetsDepreciation = "FDP";
	/** GL Document = GLD */
	public static final String DOCBASETYPE_GLDocument = "GLD";
	/** GL Journal = GLJ */
	public static final String DOCBASETYPE_GLJournal = "GLJ";
	/** Payroll = HRP */
	public static final String DOCBASETYPE_Payroll = "HRP";
	/** Manufacturing Cost Collector = MCC */
	public static final String DOCBASETYPE_ManufacturingCostCollector = "MCC";
	/** Material Physical Inventory = MMI */
	public static final String DOCBASETYPE_MaterialPhysicalInventory = "MMI";
	/** Material Movement = MMM */
	public static final String DOCBASETYPE_MaterialMovement = "MMM";
	/** Material Production = MMP */
	public static final String DOCBASETYPE_MaterialProduction = "MMP";
	/** Material Receipt = MMR */
	public static final String DOCBASETYPE_MaterialReceipt = "MMR";
	/** Material Delivery = MMS */
	public static final String DOCBASETYPE_MaterialDelivery = "MMS";
	/** Maintenance Order = MOF */
	public static final String DOCBASETYPE_MaintenanceOrder = "MOF";
	/** Manufacturing Order = MOP */
	public static final String DOCBASETYPE_ManufacturingOrder = "MOP";
	/** Quality Order = MQO */
	public static final String DOCBASETYPE_QualityOrder = "MQO";
	/** Match Invoice = MXI */
	public static final String DOCBASETYPE_MatchInvoice = "MXI";
	/** Match PO = MXP */
	public static final String DOCBASETYPE_MatchPO = "MXP";
	/** Project Issue = PJI */
	public static final String DOCBASETYPE_ProjectIssue = "PJI";
	/** Purchase Order = POO */
	public static final String DOCBASETYPE_PurchaseOrder = "POO";
	/** Purchase Requisition = POR */
	public static final String DOCBASETYPE_PurchaseRequisition = "POR";
	/** Sales Order = SOO */
	public static final String DOCBASETYPE_SalesOrder = "SOO";
	/** Set Document Base Type.
		@param DocBaseType Logical type of document
	*/
	public void setDocBaseType (String DocBaseType)
	{

		set_ValueNoCheck (COLUMNNAME_DocBaseType, DocBaseType);
	}

	/** Get Document Base Type.
		@return Logical type of document
	  */
	public String getDocBaseType()
	{
		return (String)get_Value(COLUMNNAME_DocBaseType);
	}
}