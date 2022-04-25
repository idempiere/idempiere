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
import org.compiere.util.KeyNamePair;

/** Generated Model for C_PeriodControl
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="C_PeriodControl")
public class X_C_PeriodControl extends PO implements I_C_PeriodControl, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_C_PeriodControl (Properties ctx, int C_PeriodControl_ID, String trxName)
    {
      super (ctx, C_PeriodControl_ID, trxName);
      /** if (C_PeriodControl_ID == 0)
        {
			setC_PeriodControl_ID (0);
			setC_Period_ID (0);
			setDocBaseType (null);
			setPeriodAction (null);
// N
        } */
    }

    /** Standard Constructor */
    public X_C_PeriodControl (Properties ctx, int C_PeriodControl_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_PeriodControl_ID, trxName, virtualColumns);
      /** if (C_PeriodControl_ID == 0)
        {
			setC_PeriodControl_ID (0);
			setC_Period_ID (0);
			setDocBaseType (null);
			setPeriodAction (null);
// N
        } */
    }

    /** Load Constructor */
    public X_C_PeriodControl (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_PeriodControl[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Period Control.
		@param C_PeriodControl_ID Period Control
	*/
	public void setC_PeriodControl_ID (int C_PeriodControl_ID)
	{
		if (C_PeriodControl_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_PeriodControl_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_PeriodControl_ID, Integer.valueOf(C_PeriodControl_ID));
	}

	/** Get Period Control.
		@return Period Control	  */
	public int getC_PeriodControl_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_PeriodControl_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getC_PeriodControl_ID()));
    }

	/** Set C_PeriodControl_UU.
		@param C_PeriodControl_UU C_PeriodControl_UU
	*/
	public void setC_PeriodControl_UU (String C_PeriodControl_UU)
	{
		set_Value (COLUMNNAME_C_PeriodControl_UU, C_PeriodControl_UU);
	}

	/** Get C_PeriodControl_UU.
		@return C_PeriodControl_UU	  */
	public String getC_PeriodControl_UU()
	{
		return (String)get_Value(COLUMNNAME_C_PeriodControl_UU);
	}

	public org.compiere.model.I_C_Period getC_Period() throws RuntimeException
	{
		return (org.compiere.model.I_C_Period)MTable.get(getCtx(), org.compiere.model.I_C_Period.Table_ID)
			.getPO(getC_Period_ID(), get_TrxName());
	}

	/** Set Period.
		@param C_Period_ID Period of the Calendar
	*/
	public void setC_Period_ID (int C_Period_ID)
	{
		if (C_Period_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_Period_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_Period_ID, Integer.valueOf(C_Period_ID));
	}

	/** Get Period.
		@return Period of the Calendar
	  */
	public int getC_Period_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Period_ID);
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
	/** Set Document BaseType.
		@param DocBaseType Logical type of document
	*/
	public void setDocBaseType (String DocBaseType)
	{

		set_ValueNoCheck (COLUMNNAME_DocBaseType, DocBaseType);
	}

	/** Get Document BaseType.
		@return Logical type of document
	  */
	public String getDocBaseType()
	{
		return (String)get_Value(COLUMNNAME_DocBaseType);
	}

	/** PeriodAction AD_Reference_ID=176 */
	public static final int PERIODACTION_AD_Reference_ID=176;
	/** Close Period = C */
	public static final String PERIODACTION_ClosePeriod = "C";
	/** &lt;No Action&gt; = N */
	public static final String PERIODACTION_NoAction = "N";
	/** Open Period = O */
	public static final String PERIODACTION_OpenPeriod = "O";
	/** Permanently Close Period = P */
	public static final String PERIODACTION_PermanentlyClosePeriod = "P";
	/** Set Period Action.
		@param PeriodAction Action taken for this period
	*/
	public void setPeriodAction (String PeriodAction)
	{

		set_Value (COLUMNNAME_PeriodAction, PeriodAction);
	}

	/** Get Period Action.
		@return Action taken for this period
	  */
	public String getPeriodAction()
	{
		return (String)get_Value(COLUMNNAME_PeriodAction);
	}

	/** PeriodStatus AD_Reference_ID=177 */
	public static final int PERIODSTATUS_AD_Reference_ID=177;
	/** Closed = C */
	public static final String PERIODSTATUS_Closed = "C";
	/** Never opened = N */
	public static final String PERIODSTATUS_NeverOpened = "N";
	/** Open = O */
	public static final String PERIODSTATUS_Open = "O";
	/** Permanently closed = P */
	public static final String PERIODSTATUS_PermanentlyClosed = "P";
	/** Set Period Status.
		@param PeriodStatus Current state of this period
	*/
	public void setPeriodStatus (String PeriodStatus)
	{

		set_ValueNoCheck (COLUMNNAME_PeriodStatus, PeriodStatus);
	}

	/** Get Period Status.
		@return Current state of this period
	  */
	public String getPeriodStatus()
	{
		return (String)get_Value(COLUMNNAME_PeriodStatus);
	}

	/** Set Process Now.
		@param Processing Process Now
	*/
	public void setProcessing (boolean Processing)
	{
		set_Value (COLUMNNAME_Processing, Boolean.valueOf(Processing));
	}

	/** Get Process Now.
		@return Process Now	  */
	public boolean isProcessing()
	{
		Object oo = get_Value(COLUMNNAME_Processing);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}
}