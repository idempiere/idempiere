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
import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

/** Generated Model for A_Asset_Addition
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="A_Asset_Addition")
public class X_A_Asset_Addition extends PO implements I_A_Asset_Addition, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250307L;

    /** Standard Constructor */
    public X_A_Asset_Addition (Properties ctx, int A_Asset_Addition_ID, String trxName)
    {
      super (ctx, A_Asset_Addition_ID, trxName);
      /** if (A_Asset_Addition_ID == 0)
        {
			setA_Asset_Addition_ID (0);
			setA_Asset_ID (0);
			setA_CapvsExp (null);
// 'Cap'
			setA_CreateAsset (false);
// 'N'
			setA_QTY_Current (Env.ZERO);
// 0
			setA_SourceType (null);
// 'INV'
			setAssetAmtEntered (Env.ZERO);
// 0
			setAssetValueAmt (Env.ZERO);
			setC_ConversionType_ID (0);
			setC_Currency_ID (0);
			setDateDoc (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setDocStatus (null);
// 'DR'
			setIsApproved (false);
// @#IsCanApproveOwnDoc@
			setPosted (false);
// N
			setPostingType (null);
// A
			setProcessed (false);
// 'N'
        } */
    }

    /** Standard Constructor */
    public X_A_Asset_Addition (Properties ctx, int A_Asset_Addition_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, A_Asset_Addition_ID, trxName, virtualColumns);
      /** if (A_Asset_Addition_ID == 0)
        {
			setA_Asset_Addition_ID (0);
			setA_Asset_ID (0);
			setA_CapvsExp (null);
// 'Cap'
			setA_CreateAsset (false);
// 'N'
			setA_QTY_Current (Env.ZERO);
// 0
			setA_SourceType (null);
// 'INV'
			setAssetAmtEntered (Env.ZERO);
// 0
			setAssetValueAmt (Env.ZERO);
			setC_ConversionType_ID (0);
			setC_Currency_ID (0);
			setDateDoc (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setDocStatus (null);
// 'DR'
			setIsApproved (false);
// @#IsCanApproveOwnDoc@
			setPosted (false);
// N
			setPostingType (null);
// A
			setProcessed (false);
// 'N'
        } */
    }

    /** Standard Constructor */
    public X_A_Asset_Addition (Properties ctx, String A_Asset_Addition_UU, String trxName)
    {
      super (ctx, A_Asset_Addition_UU, trxName);
      /** if (A_Asset_Addition_UU == null)
        {
			setA_Asset_Addition_ID (0);
			setA_Asset_ID (0);
			setA_CapvsExp (null);
// 'Cap'
			setA_CreateAsset (false);
// 'N'
			setA_QTY_Current (Env.ZERO);
// 0
			setA_SourceType (null);
// 'INV'
			setAssetAmtEntered (Env.ZERO);
// 0
			setAssetValueAmt (Env.ZERO);
			setC_ConversionType_ID (0);
			setC_Currency_ID (0);
			setDateDoc (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setDocStatus (null);
// 'DR'
			setIsApproved (false);
// @#IsCanApproveOwnDoc@
			setPosted (false);
// N
			setPostingType (null);
// A
			setProcessed (false);
// 'N'
        } */
    }

    /** Standard Constructor */
    public X_A_Asset_Addition (Properties ctx, String A_Asset_Addition_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, A_Asset_Addition_UU, trxName, virtualColumns);
      /** if (A_Asset_Addition_UU == null)
        {
			setA_Asset_Addition_ID (0);
			setA_Asset_ID (0);
			setA_CapvsExp (null);
// 'Cap'
			setA_CreateAsset (false);
// 'N'
			setA_QTY_Current (Env.ZERO);
// 0
			setA_SourceType (null);
// 'INV'
			setAssetAmtEntered (Env.ZERO);
// 0
			setAssetValueAmt (Env.ZERO);
			setC_ConversionType_ID (0);
			setC_Currency_ID (0);
			setDateDoc (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setDocStatus (null);
// 'DR'
			setIsApproved (false);
// @#IsCanApproveOwnDoc@
			setPosted (false);
// N
			setPostingType (null);
// A
			setProcessed (false);
// 'N'
        } */
    }

    /** Load Constructor */
    public X_A_Asset_Addition (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org
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
      StringBuilder sb = new StringBuilder ("X_A_Asset_Addition[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Asset Addition.
		@param A_Asset_Addition_ID Asset Addition
	*/
	public void setA_Asset_Addition_ID (int A_Asset_Addition_ID)
	{
		if (A_Asset_Addition_ID < 1)
			set_ValueNoCheck (COLUMNNAME_A_Asset_Addition_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_A_Asset_Addition_ID, Integer.valueOf(A_Asset_Addition_ID));
	}

	/** Get Asset Addition.
		@return Asset Addition	  */
	public int getA_Asset_Addition_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_A_Asset_Addition_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set A_Asset_Addition_UU.
		@param A_Asset_Addition_UU A_Asset_Addition_UU
	*/
	public void setA_Asset_Addition_UU (String A_Asset_Addition_UU)
	{
		set_Value (COLUMNNAME_A_Asset_Addition_UU, A_Asset_Addition_UU);
	}

	/** Get A_Asset_Addition_UU.
		@return A_Asset_Addition_UU	  */
	public String getA_Asset_Addition_UU()
	{
		return (String)get_Value(COLUMNNAME_A_Asset_Addition_UU);
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

	/** A_CapvsExp AD_Reference_ID=53277 */
	public static final int A_CAPVSEXP_AD_Reference_ID=53277;
	/** Capital = Cap */
	public static final String A_CAPVSEXP_Capital = "Cap";
	/** Expense = Exp */
	public static final String A_CAPVSEXP_Expense = "Exp";
	/** Set Capital/Expense.
		@param A_CapvsExp Capital/Expense
	*/
	public void setA_CapvsExp (String A_CapvsExp)
	{

		set_Value (COLUMNNAME_A_CapvsExp, A_CapvsExp);
	}

	/** Get Capital/Expense.
		@return Capital/Expense	  */
	public String getA_CapvsExp()
	{
		return (String)get_Value(COLUMNNAME_A_CapvsExp);
	}

	/** Set Create Asset.
		@param A_CreateAsset Create Asset
	*/
	public void setA_CreateAsset (boolean A_CreateAsset)
	{
		set_Value (COLUMNNAME_A_CreateAsset, Boolean.valueOf(A_CreateAsset));
	}

	/** Get Create Asset.
		@return Create Asset	  */
	public boolean isA_CreateAsset()
	{
		Object oo = get_Value(COLUMNNAME_A_CreateAsset);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Life periods (max).
		@param A_Life_Period_Max Life periods (max)
	*/
	public void setA_Life_Period_Max (int A_Life_Period_Max)
	{
		throw new IllegalArgumentException ("A_Life_Period_Max is virtual column");	}

	/** Get Life periods (max).
		@return Life periods (max)	  */
	public int getA_Life_Period_Max()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_A_Life_Period_Max);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Life periods (min).
		@param A_Life_Period_Min Life periods (min)
	*/
	public void setA_Life_Period_Min (int A_Life_Period_Min)
	{
		throw new IllegalArgumentException ("A_Life_Period_Min is virtual column");	}

	/** Get Life periods (min).
		@return Life periods (min)	  */
	public int getA_Life_Period_Min()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_A_Life_Period_Min);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Current Qty.
		@param A_QTY_Current Current Qty
	*/
	public void setA_QTY_Current (BigDecimal A_QTY_Current)
	{
		set_Value (COLUMNNAME_A_QTY_Current, A_QTY_Current);
	}

	/** Get Current Qty.
		@return Current Qty	  */
	public BigDecimal getA_QTY_Current()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_A_QTY_Current);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Asset Salvage Value.
		@param A_Salvage_Value Asset Salvage Value
	*/
	public void setA_Salvage_Value (BigDecimal A_Salvage_Value)
	{
		set_Value (COLUMNNAME_A_Salvage_Value, A_Salvage_Value);
	}

	/** Get Asset Salvage Value.
		@return Asset Salvage Value	  */
	public BigDecimal getA_Salvage_Value()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_A_Salvage_Value);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** A_SourceType AD_Reference_ID=53276 */
	public static final int A_SOURCETYPE_AD_Reference_ID=53276;
	/** Imported = IMP */
	public static final String A_SOURCETYPE_Imported = "IMP";
	/** Invoice = INV */
	public static final String A_SOURCETYPE_Invoice = "INV";
	/** Journal Entry = JRN */
	public static final String A_SOURCETYPE_JournalEntry = "JRN";
	/** Manual = MAN */
	public static final String A_SOURCETYPE_Manual = "MAN";
	/** Project = PRJ */
	public static final String A_SOURCETYPE_Project = "PRJ";
	/** Set Source Type.
		@param A_SourceType Source Type
	*/
	public void setA_SourceType (String A_SourceType)
	{

		set_Value (COLUMNNAME_A_SourceType, A_SourceType);
	}

	/** Get Source Type.
		@return Source Type	  */
	public String getA_SourceType()
	{
		return (String)get_Value(COLUMNNAME_A_SourceType);
	}

	/** Set Entered Amount.
		@param AssetAmtEntered Entered Amount
	*/
	public void setAssetAmtEntered (BigDecimal AssetAmtEntered)
	{
		set_Value (COLUMNNAME_AssetAmtEntered, AssetAmtEntered);
	}

	/** Get Entered Amount.
		@return Entered Amount	  */
	public BigDecimal getAssetAmtEntered()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AssetAmtEntered);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Source Amount.
		@param AssetSourceAmt Source Amount
	*/
	public void setAssetSourceAmt (BigDecimal AssetSourceAmt)
	{
		set_Value (COLUMNNAME_AssetSourceAmt, AssetSourceAmt);
	}

	/** Get Source Amount.
		@return Source Amount	  */
	public BigDecimal getAssetSourceAmt()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AssetSourceAmt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Asset value.
		@param AssetValueAmt Book Value of the asset
	*/
	public void setAssetValueAmt (BigDecimal AssetValueAmt)
	{
		set_Value (COLUMNNAME_AssetValueAmt, AssetValueAmt);
	}

	/** Get Asset value.
		@return Book Value of the asset
	  */
	public BigDecimal getAssetValueAmt()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_AssetValueAmt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
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
			set_Value (COLUMNNAME_C_Charge_ID, null);
		else
			set_Value (COLUMNNAME_C_Charge_ID, Integer.valueOf(C_Charge_ID));
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

	public org.compiere.model.I_C_ConversionType getC_ConversionType() throws RuntimeException
	{
		return (org.compiere.model.I_C_ConversionType)MTable.get(getCtx(), org.compiere.model.I_C_ConversionType.Table_ID)
			.getPO(getC_ConversionType_ID(), get_TrxName());
	}

	/** Set Currency Type.
		@param C_ConversionType_ID Currency Conversion Rate Type
	*/
	public void setC_ConversionType_ID (int C_ConversionType_ID)
	{
		if (C_ConversionType_ID < 1)
			set_Value (COLUMNNAME_C_ConversionType_ID, null);
		else
			set_Value (COLUMNNAME_C_ConversionType_ID, Integer.valueOf(C_ConversionType_ID));
	}

	/** Get Currency Type.
		@return Currency Conversion Rate Type
	  */
	public int getC_ConversionType_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ConversionType_ID);
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

	public org.compiere.model.I_C_Currency getC_Currency() throws RuntimeException
	{
		return (org.compiere.model.I_C_Currency)MTable.get(getCtx(), org.compiere.model.I_C_Currency.Table_ID)
			.getPO(getC_Currency_ID(), get_TrxName());
	}

	/** Set Currency.
		@param C_Currency_ID The Currency for this record
	*/
	public void setC_Currency_ID (int C_Currency_ID)
	{
		if (C_Currency_ID < 1)
			set_Value (COLUMNNAME_C_Currency_ID, null);
		else
			set_Value (COLUMNNAME_C_Currency_ID, Integer.valueOf(C_Currency_ID));
	}

	/** Get Currency.
		@return The Currency for this record
	  */
	public int getC_Currency_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Currency_ID);
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

	public org.compiere.model.I_C_DocType getC_DocType() throws RuntimeException
	{
		return (org.compiere.model.I_C_DocType)MTable.get(getCtx(), org.compiere.model.I_C_DocType.Table_ID)
			.getPO(getC_DocType_ID(), get_TrxName());
	}

	/** Set Document Type.
		@param C_DocType_ID Document type or rules
	*/
	public void setC_DocType_ID (int C_DocType_ID)
	{
		if (C_DocType_ID < 0)
			set_Value (COLUMNNAME_C_DocType_ID, null);
		else
			set_Value (COLUMNNAME_C_DocType_ID, Integer.valueOf(C_DocType_ID));
	}

	/** Get Document Type.
		@return Document type or rules
	  */
	public int getC_DocType_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_DocType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_InvoiceLine getC_InvoiceLine() throws RuntimeException
	{
		return (org.compiere.model.I_C_InvoiceLine)MTable.get(getCtx(), org.compiere.model.I_C_InvoiceLine.Table_ID)
			.getPO(getC_InvoiceLine_ID(), get_TrxName());
	}

	/** Set Invoice Line.
		@param C_InvoiceLine_ID Invoice Detail Line
	*/
	public void setC_InvoiceLine_ID (int C_InvoiceLine_ID)
	{
		if (C_InvoiceLine_ID < 1)
			set_Value (COLUMNNAME_C_InvoiceLine_ID, null);
		else
			set_Value (COLUMNNAME_C_InvoiceLine_ID, Integer.valueOf(C_InvoiceLine_ID));
	}

	/** Get Invoice Line.
		@return Invoice Detail Line
	  */
	public int getC_InvoiceLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_InvoiceLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Invoice getC_Invoice() throws RuntimeException
	{
		return (org.compiere.model.I_C_Invoice)MTable.get(getCtx(), org.compiere.model.I_C_Invoice.Table_ID)
			.getPO(getC_Invoice_ID(), get_TrxName());
	}

	/** Set Invoice.
		@param C_Invoice_ID Invoice Identifier
	*/
	public void setC_Invoice_ID (int C_Invoice_ID)
	{
		if (C_Invoice_ID < 1)
			set_Value (COLUMNNAME_C_Invoice_ID, null);
		else
			set_Value (COLUMNNAME_C_Invoice_ID, Integer.valueOf(C_Invoice_ID));
	}

	/** Get Invoice.
		@return Invoice Identifier
	  */
	public int getC_Invoice_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Invoice_ID);
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

	/** Set Rate.
		@param CurrencyRate Currency Conversion Rate
	*/
	public void setCurrencyRate (BigDecimal CurrencyRate)
	{
		set_Value (COLUMNNAME_CurrencyRate, CurrencyRate);
	}

	/** Get Rate.
		@return Currency Conversion Rate
	  */
	public BigDecimal getCurrencyRate()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_CurrencyRate);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Account Date.
		@param DateAcct Accounting Date
	*/
	public void setDateAcct (Timestamp DateAcct)
	{
		set_Value (COLUMNNAME_DateAcct, DateAcct);
	}

	/** Get Account Date.
		@return Accounting Date
	  */
	public Timestamp getDateAcct()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateAcct);
	}

	/** Set Document Date.
		@param DateDoc Date of the Document
	*/
	public void setDateDoc (Timestamp DateDoc)
	{
		set_Value (COLUMNNAME_DateDoc, DateDoc);
	}

	/** Get Document Date.
		@return Date of the Document
	  */
	public Timestamp getDateDoc()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateDoc);
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

	/** DocAction AD_Reference_ID=135 */
	public static final int DOCACTION_AD_Reference_ID=135;
	/** &lt;None&gt; = -- */
	public static final String DOCACTION_None = "--";
	/** Approve = AP */
	public static final String DOCACTION_Approve = "AP";
	/** Close = CL */
	public static final String DOCACTION_Close = "CL";
	/** Complete = CO */
	public static final String DOCACTION_Complete = "CO";
	/** Invalidate = IN */
	public static final String DOCACTION_Invalidate = "IN";
	/** Post = PO */
	public static final String DOCACTION_Post = "PO";
	/** Prepare = PR */
	public static final String DOCACTION_Prepare = "PR";
	/** Reverse - Accrual = RA */
	public static final String DOCACTION_Reverse_Accrual = "RA";
	/** Reverse - Correct = RC */
	public static final String DOCACTION_Reverse_Correct = "RC";
	/** Re-activate = RE */
	public static final String DOCACTION_Re_Activate = "RE";
	/** Reject = RJ */
	public static final String DOCACTION_Reject = "RJ";
	/** Void = VO */
	public static final String DOCACTION_Void = "VO";
	/** Wait Complete = WC */
	public static final String DOCACTION_WaitComplete = "WC";
	/** Unlock = XL */
	public static final String DOCACTION_Unlock = "XL";
	/** Set Document Action.
		@param DocAction The targeted status of the document
	*/
	public void setDocAction (String DocAction)
	{

		set_Value (COLUMNNAME_DocAction, DocAction);
	}

	/** Get Document Action.
		@return The targeted status of the document
	  */
	public String getDocAction()
	{
		return (String)get_Value(COLUMNNAME_DocAction);
	}

	/** DocStatus AD_Reference_ID=131 */
	public static final int DOCSTATUS_AD_Reference_ID=131;
	/** Unknown = ?? */
	public static final String DOCSTATUS_Unknown = "??";
	/** Approved = AP */
	public static final String DOCSTATUS_Approved = "AP";
	/** Closed = CL */
	public static final String DOCSTATUS_Closed = "CL";
	/** Completed = CO */
	public static final String DOCSTATUS_Completed = "CO";
	/** Drafted = DR */
	public static final String DOCSTATUS_Drafted = "DR";
	/** Invalid = IN */
	public static final String DOCSTATUS_Invalid = "IN";
	/** In Progress = IP */
	public static final String DOCSTATUS_InProgress = "IP";
	/** Not Approved = NA */
	public static final String DOCSTATUS_NotApproved = "NA";
	/** Reversed = RE */
	public static final String DOCSTATUS_Reversed = "RE";
	/** Voided = VO */
	public static final String DOCSTATUS_Voided = "VO";
	/** Waiting Confirmation = WC */
	public static final String DOCSTATUS_WaitingConfirmation = "WC";
	/** Waiting Payment = WP */
	public static final String DOCSTATUS_WaitingPayment = "WP";
	/** Set Document Status.
		@param DocStatus The current status of the document
	*/
	public void setDocStatus (String DocStatus)
	{

		set_Value (COLUMNNAME_DocStatus, DocStatus);
	}

	/** Get Document Status.
		@return The current status of the document
	  */
	public String getDocStatus()
	{
		return (String)get_Value(COLUMNNAME_DocStatus);
	}

	/** DocumentNo AD_Reference_ID=53274 */
	public static final int DOCUMENTNO_AD_Reference_ID=53274;
	/** Set Document No.
		@param DocumentNo Document sequence number of the document
	*/
	public void setDocumentNo (String DocumentNo)
	{

		set_Value (COLUMNNAME_DocumentNo, DocumentNo);
	}

	/** Get Document No.
		@return Document sequence number of the document
	  */
	public String getDocumentNo()
	{
		return (String)get_Value(COLUMNNAME_DocumentNo);
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair()
    {
        return new KeyNamePair(get_ID(), getDocumentNo());
    }

	public org.compiere.model.I_GL_JournalBatch getGL_JournalBatch() throws RuntimeException
	{
		return (org.compiere.model.I_GL_JournalBatch)MTable.get(getCtx(), org.compiere.model.I_GL_JournalBatch.Table_ID)
			.getPO(getGL_JournalBatch_ID(), get_TrxName());
	}

	/** Set Journal Batch.
		@param GL_JournalBatch_ID General Ledger Journal Batch
	*/
	public void setGL_JournalBatch_ID (int GL_JournalBatch_ID)
	{
		if (GL_JournalBatch_ID < 1)
			set_Value (COLUMNNAME_GL_JournalBatch_ID, null);
		else
			set_Value (COLUMNNAME_GL_JournalBatch_ID, Integer.valueOf(GL_JournalBatch_ID));
	}

	/** Get Journal Batch.
		@return General Ledger Journal Batch
	  */
	public int getGL_JournalBatch_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_GL_JournalBatch_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_I_FixedAsset getI_FixedAsset() throws RuntimeException
	{
		return (org.compiere.model.I_I_FixedAsset)MTable.get(getCtx(), org.compiere.model.I_I_FixedAsset.Table_ID)
			.getPO(getI_FixedAsset_ID(), get_TrxName());
	}

	/** Set Imported Fixed Asset.
		@param I_FixedAsset_ID Imported Fixed Asset
	*/
	public void setI_FixedAsset_ID (int I_FixedAsset_ID)
	{
		if (I_FixedAsset_ID < 1)
			set_Value (COLUMNNAME_I_FixedAsset_ID, null);
		else
			set_Value (COLUMNNAME_I_FixedAsset_ID, Integer.valueOf(I_FixedAsset_ID));
	}

	/** Get Imported Fixed Asset.
		@return Imported Fixed Asset	  */
	public int getI_FixedAsset_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_I_FixedAsset_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Approved.
		@param IsApproved Indicates if this document requires approval
	*/
	public void setIsApproved (boolean IsApproved)
	{
		set_Value (COLUMNNAME_IsApproved, Boolean.valueOf(IsApproved));
	}

	/** Get Approved.
		@return Indicates if this document requires approval
	  */
	public boolean isApproved()
	{
		Object oo = get_Value(COLUMNNAME_IsApproved);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
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

	public I_M_AttributeSetInstance getM_AttributeSetInstance() throws RuntimeException
	{
		return (I_M_AttributeSetInstance)MTable.get(getCtx(), I_M_AttributeSetInstance.Table_ID)
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

	public org.compiere.model.I_M_InOutLine getM_InOutLine() throws RuntimeException
	{
		return (org.compiere.model.I_M_InOutLine)MTable.get(getCtx(), org.compiere.model.I_M_InOutLine.Table_ID)
			.getPO(getM_InOutLine_ID(), get_TrxName());
	}

	/** Set Shipment/Receipt Line.
		@param M_InOutLine_ID Line on Shipment or Receipt document
	*/
	public void setM_InOutLine_ID (int M_InOutLine_ID)
	{
		if (M_InOutLine_ID < 1)
			set_Value (COLUMNNAME_M_InOutLine_ID, null);
		else
			set_Value (COLUMNNAME_M_InOutLine_ID, Integer.valueOf(M_InOutLine_ID));
	}

	/** Get Shipment/Receipt Line.
		@return Line on Shipment or Receipt document
	  */
	public int getM_InOutLine_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_InOutLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public I_M_Locator getM_Locator() throws RuntimeException
	{
		return (I_M_Locator)MTable.get(getCtx(), I_M_Locator.Table_ID)
			.getPO(getM_Locator_ID(), get_TrxName());
	}

	/** Set Locator.
		@param M_Locator_ID Warehouse Locator
	*/
	public void setM_Locator_ID (int M_Locator_ID)
	{
		if (M_Locator_ID < 1)
			set_Value (COLUMNNAME_M_Locator_ID, null);
		else
			set_Value (COLUMNNAME_M_Locator_ID, Integer.valueOf(M_Locator_ID));
	}

	/** Get Locator.
		@return Warehouse Locator
	  */
	public int getM_Locator_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Locator_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_MatchInv getM_MatchInv() throws RuntimeException
	{
		return (org.compiere.model.I_M_MatchInv)MTable.get(getCtx(), org.compiere.model.I_M_MatchInv.Table_ID)
			.getPO(getM_MatchInv_ID(), get_TrxName());
	}

	/** Set Match Invoice.
		@param M_MatchInv_ID Match Shipment/Receipt to Invoice
	*/
	public void setM_MatchInv_ID (int M_MatchInv_ID)
	{
		if (M_MatchInv_ID < 1)
			set_Value (COLUMNNAME_M_MatchInv_ID, null);
		else
			set_Value (COLUMNNAME_M_MatchInv_ID, Integer.valueOf(M_MatchInv_ID));
	}

	/** Get Match Invoice.
		@return Match Shipment/Receipt to Invoice
	  */
	public int getM_MatchInv_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_MatchInv_ID);
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

	/** Set Posted.
		@param Posted Posting status
	*/
	public void setPosted (boolean Posted)
	{
		set_Value (COLUMNNAME_Posted, Boolean.valueOf(Posted));
	}

	/** Get Posted.
		@return Posting status
	  */
	public boolean isPosted()
	{
		Object oo = get_Value(COLUMNNAME_Posted);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** PostingType AD_Reference_ID=125 */
	public static final int POSTINGTYPE_AD_Reference_ID=125;
	/** Actual = A */
	public static final String POSTINGTYPE_Actual = "A";
	/** Budget = B */
	public static final String POSTINGTYPE_Budget = "B";
	/** Commitment = E */
	public static final String POSTINGTYPE_Commitment = "E";
	/** Reservation = R */
	public static final String POSTINGTYPE_Reservation = "R";
	/** Statistical = S */
	public static final String POSTINGTYPE_Statistical = "S";
	/** Set Posting Type.
		@param PostingType The type of posted amount for the transaction
	*/
	public void setPostingType (String PostingType)
	{

		set_Value (COLUMNNAME_PostingType, PostingType);
	}

	/** Get Posting Type.
		@return The type of posted amount for the transaction
	  */
	public String getPostingType()
	{
		return (String)get_Value(COLUMNNAME_PostingType);
	}

	/** Set Processed.
		@param Processed The document has been processed
	*/
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed()
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null)
		{
			 if (oo instanceof Boolean)
				 return ((Boolean)oo).booleanValue();
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Processed On.
		@param ProcessedOn The date+time (expressed in decimal format) when the document has been processed
	*/
	public void setProcessedOn (BigDecimal ProcessedOn)
	{
		set_Value (COLUMNNAME_ProcessedOn, ProcessedOn);
	}

	/** Get Processed On.
		@return The date+time (expressed in decimal format) when the document has been processed
	  */
	public BigDecimal getProcessedOn()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_ProcessedOn);
		if (bd == null)
			 return Env.ZERO;
		return bd;
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