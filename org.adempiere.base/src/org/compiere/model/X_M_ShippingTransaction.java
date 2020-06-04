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

/** Generated Model for M_ShippingTransaction
 *  @author iDempiere (generated) 
 *  @version Release 7.1 - $Id$ */
public class X_M_ShippingTransaction extends PO implements I_M_ShippingTransaction, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20200413L;

    /** Standard Constructor */
    public X_M_ShippingTransaction (Properties ctx, int M_ShippingTransaction_ID, String trxName)
    {
      super (ctx, M_ShippingTransaction_ID, trxName);
      /** if (M_ShippingTransaction_ID == 0)
        {
			setAction (null);
			setCashOnDelivery (false);
// N
			setDeliveryConfirmation (false);
// N
			setIsAccessible (false);
// N
			setIsAddedHandling (false);
// N
			setIsAlternateReturnAddress (false);
// N
			setIsCargoAircraftOnly (false);
// N
			setIsDryIce (false);
// N
			setIsDutiable (false);
// N
			setIsFutureDayShipment (false);
// N
			setIsHazMat (false);
// N
			setIsHoldAtLocation (false);
// N
			setIsIgnoreZipNotFound (false);
// N
			setIsIgnoreZipStateNotMatch (false);
// N
			setIsPriviledgedRate (false);
// N
			setIsResidential (true);
// Y
			setIsSaturdayDelivery (false);
// N
			setIsSaturdayPickup (false);
// N
			setIsVerbalConfirmation (false);
// N
			setM_Shipper_ID (0);
			setM_ShippingTransaction_ID (0);
			setProcessed (false);
// N
        } */
    }

    /** Load Constructor */
    public X_M_ShippingTransaction (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_M_ShippingTransaction[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Action AD_Reference_ID=200042 */
	public static final int ACTION_AD_Reference_ID=200042;
	/** Rate Inquiry = RI */
	public static final String ACTION_RateInquiry = "RI";
	/** Void Shipment = VS */
	public static final String ACTION_VoidShipment = "VS";
	/** Process Shipment = PS */
	public static final String ACTION_ProcessShipment = "PS";
	/** Set Action.
		@param Action 
		Indicates the Action to be performed
	  */
	public void setAction (String Action)
	{

		set_Value (COLUMNNAME_Action, Action);
	}

	/** Get Action.
		@return Indicates the Action to be performed
	  */
	public String getAction () 
	{
		return (String)get_Value(COLUMNNAME_Action);
	}

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getAD_User_ID(), get_TrxName());	}

	/** Set User/Contact.
		@param AD_User_ID 
		User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1) 
			set_Value (COLUMNNAME_AD_User_ID, null);
		else 
			set_Value (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
	}

	/** Get User/Contact.
		@return User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner_Location getBill_Location() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner_Location)MTable.get(getCtx(), org.compiere.model.I_C_BPartner_Location.Table_Name)
			.getPO(getBill_Location_ID(), get_TrxName());	}

	/** Set Invoice Location.
		@param Bill_Location_ID 
		Business Partner Location for invoicing
	  */
	public void setBill_Location_ID (int Bill_Location_ID)
	{
		if (Bill_Location_ID < 1) 
			set_Value (COLUMNNAME_Bill_Location_ID, null);
		else 
			set_Value (COLUMNNAME_Bill_Location_ID, Integer.valueOf(Bill_Location_ID));
	}

	/** Get Invoice Location.
		@return Business Partner Location for invoicing
	  */
	public int getBill_Location_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Bill_Location_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Box Count.
		@param BoxCount Box Count	  */
	public void setBoxCount (int BoxCount)
	{
		set_Value (COLUMNNAME_BoxCount, Integer.valueOf(BoxCount));
	}

	/** Get Box Count.
		@return Box Count	  */
	public int getBoxCount () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_BoxCount);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set COD.
		@param CashOnDelivery COD	  */
	public void setCashOnDelivery (boolean CashOnDelivery)
	{
		set_Value (COLUMNNAME_CashOnDelivery, Boolean.valueOf(CashOnDelivery));
	}

	/** Get COD.
		@return COD	  */
	public boolean isCashOnDelivery () 
	{
		Object oo = get_Value(COLUMNNAME_CashOnDelivery);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_Name)
			.getPO(getC_BPartner_ID(), get_TrxName());	}

	/** Set Business Partner .
		@param C_BPartner_ID 
		Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID)
	{
		if (C_BPartner_ID < 1) 
			set_Value (COLUMNNAME_C_BPartner_ID, null);
		else 
			set_Value (COLUMNNAME_C_BPartner_ID, Integer.valueOf(C_BPartner_ID));
	}

	/** Get Business Partner .
		@return Identifies a Business Partner
	  */
	public int getC_BPartner_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner_Location getC_BPartner_Location() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner_Location)MTable.get(getCtx(), org.compiere.model.I_C_BPartner_Location.Table_Name)
			.getPO(getC_BPartner_Location_ID(), get_TrxName());	}

	/** Set Partner Location.
		@param C_BPartner_Location_ID 
		Identifies the (ship to) address for this Business Partner
	  */
	public void setC_BPartner_Location_ID (int C_BPartner_Location_ID)
	{
		if (C_BPartner_Location_ID < 1) 
			set_Value (COLUMNNAME_C_BPartner_Location_ID, null);
		else 
			set_Value (COLUMNNAME_C_BPartner_Location_ID, Integer.valueOf(C_BPartner_Location_ID));
	}

	/** Get Partner Location.
		@return Identifies the (ship to) address for this Business Partner
	  */
	public int getC_BPartner_Location_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_Location_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BP_ShippingAcct getC_BP_ShippingAcct() throws RuntimeException
    {
		return (org.compiere.model.I_C_BP_ShippingAcct)MTable.get(getCtx(), org.compiere.model.I_C_BP_ShippingAcct.Table_Name)
			.getPO(getC_BP_ShippingAcct_ID(), get_TrxName());	}

	/** Set Business Partner Shipping Account.
		@param C_BP_ShippingAcct_ID Business Partner Shipping Account	  */
	public void setC_BP_ShippingAcct_ID (int C_BP_ShippingAcct_ID)
	{
		if (C_BP_ShippingAcct_ID < 1) 
			set_Value (COLUMNNAME_C_BP_ShippingAcct_ID, null);
		else 
			set_Value (COLUMNNAME_C_BP_ShippingAcct_ID, Integer.valueOf(C_BP_ShippingAcct_ID));
	}

	/** Get Business Partner Shipping Account.
		@return Business Partner Shipping Account	  */
	public int getC_BP_ShippingAcct_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BP_ShippingAcct_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Currency getC_Currency() throws RuntimeException
    {
		return (org.compiere.model.I_C_Currency)MTable.get(getCtx(), org.compiere.model.I_C_Currency.Table_Name)
			.getPO(getC_Currency_ID(), get_TrxName());	}

	/** Set Currency.
		@param C_Currency_ID 
		The Currency for this record
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
	public int getC_Currency_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Currency_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Invoice getC_Invoice() throws RuntimeException
    {
		return (org.compiere.model.I_C_Invoice)MTable.get(getCtx(), org.compiere.model.I_C_Invoice.Table_Name)
			.getPO(getC_Invoice_ID(), get_TrxName());	}

	/** Set Invoice.
		@param C_Invoice_ID 
		Invoice Identifier
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
	public int getC_Invoice_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Invoice_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set COD Amount.
		@param CODAmount COD Amount	  */
	public void setCODAmount (BigDecimal CODAmount)
	{
		set_Value (COLUMNNAME_CODAmount, CODAmount);
	}

	/** Get COD Amount.
		@return COD Amount	  */
	public BigDecimal getCODAmount () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_CODAmount);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_C_Order getC_Order() throws RuntimeException
    {
		return (org.compiere.model.I_C_Order)MTable.get(getCtx(), org.compiere.model.I_C_Order.Table_Name)
			.getPO(getC_Order_ID(), get_TrxName());	}

	/** Set Order.
		@param C_Order_ID 
		Order
	  */
	public void setC_Order_ID (int C_Order_ID)
	{
		if (C_Order_ID < 1) 
			set_Value (COLUMNNAME_C_Order_ID, null);
		else 
			set_Value (COLUMNNAME_C_Order_ID, Integer.valueOf(C_Order_ID));
	}

	/** Get Order.
		@return Order
	  */
	public int getC_Order_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Order_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_UOM getC_UOM_Length() throws RuntimeException
    {
		return (org.compiere.model.I_C_UOM)MTable.get(getCtx(), org.compiere.model.I_C_UOM.Table_Name)
			.getPO(getC_UOM_Length_ID(), get_TrxName());	}

	/** Set UOM for Length.
		@param C_UOM_Length_ID 
		Standard Unit of Measure for Length
	  */
	public void setC_UOM_Length_ID (int C_UOM_Length_ID)
	{
		if (C_UOM_Length_ID < 1) 
			set_Value (COLUMNNAME_C_UOM_Length_ID, null);
		else 
			set_Value (COLUMNNAME_C_UOM_Length_ID, Integer.valueOf(C_UOM_Length_ID));
	}

	/** Get UOM for Length.
		@return Standard Unit of Measure for Length
	  */
	public int getC_UOM_Length_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_UOM_Length_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_UOM getC_UOM_Weight() throws RuntimeException
    {
		return (org.compiere.model.I_C_UOM)MTable.get(getCtx(), org.compiere.model.I_C_UOM.Table_Name)
			.getPO(getC_UOM_Weight_ID(), get_TrxName());	}

	/** Set UOM for Weight.
		@param C_UOM_Weight_ID 
		Standard Unit of Measure for Weight
	  */
	public void setC_UOM_Weight_ID (int C_UOM_Weight_ID)
	{
		if (C_UOM_Weight_ID < 1) 
			set_Value (COLUMNNAME_C_UOM_Weight_ID, null);
		else 
			set_Value (COLUMNNAME_C_UOM_Weight_ID, Integer.valueOf(C_UOM_Weight_ID));
	}

	/** Get UOM for Weight.
		@return Standard Unit of Measure for Weight
	  */
	public int getC_UOM_Weight_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_UOM_Weight_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Customs Value.
		@param CustomsValue Customs Value	  */
	public void setCustomsValue (BigDecimal CustomsValue)
	{
		set_Value (COLUMNNAME_CustomsValue, CustomsValue);
	}

	/** Get Customs Value.
		@return Customs Value	  */
	public BigDecimal getCustomsValue () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_CustomsValue);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Date received.
		@param DateReceived 
		Date a product was received
	  */
	public void setDateReceived (Timestamp DateReceived)
	{
		set_Value (COLUMNNAME_DateReceived, DateReceived);
	}

	/** Get Date received.
		@return Date a product was received
	  */
	public Timestamp getDateReceived () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DateReceived);
	}

	/** Set Delivery Confirmation.
		@param DeliveryConfirmation 
		EMail Delivery confirmation
	  */
	public void setDeliveryConfirmation (boolean DeliveryConfirmation)
	{
		set_Value (COLUMNNAME_DeliveryConfirmation, Boolean.valueOf(DeliveryConfirmation));
	}

	/** Get Delivery Confirmation.
		@return EMail Delivery confirmation
	  */
	public boolean isDeliveryConfirmation () 
	{
		Object oo = get_Value(COLUMNNAME_DeliveryConfirmation);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** DeliveryConfirmationType AD_Reference_ID=200031 */
	public static final int DELIVERYCONFIRMATIONTYPE_AD_Reference_ID=200031;
	/** Adult = ADULT */
	public static final String DELIVERYCONFIRMATIONTYPE_Adult = "ADULT";
	/** Direct = DIRECT */
	public static final String DELIVERYCONFIRMATIONTYPE_Direct = "DIRECT";
	/** Indirect = INDIRECT */
	public static final String DELIVERYCONFIRMATIONTYPE_Indirect = "INDIRECT";
	/** Service Default = SERVICE_DEFAULT */
	public static final String DELIVERYCONFIRMATIONTYPE_ServiceDefault = "SERVICE_DEFAULT";
	/** Set Delivery Confirmation Type.
		@param DeliveryConfirmationType Delivery Confirmation Type	  */
	public void setDeliveryConfirmationType (String DeliveryConfirmationType)
	{

		set_Value (COLUMNNAME_DeliveryConfirmationType, DeliveryConfirmationType);
	}

	/** Get Delivery Confirmation Type.
		@return Delivery Confirmation Type	  */
	public String getDeliveryConfirmationType () 
	{
		return (String)get_Value(COLUMNNAME_DeliveryConfirmationType);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** DotHazardClassOrDivision AD_Reference_ID=200024 */
	public static final int DOTHAZARDCLASSORDIVISION_AD_Reference_ID=200024;
	/** Class 1 - Explosives = 1 */
	public static final String DOTHAZARDCLASSORDIVISION_Class1_Explosives = "1";
	/** Class 2 - Gases = 2 */
	public static final String DOTHAZARDCLASSORDIVISION_Class2_Gases = "2";
	/** 2.1 - Flammable Gas = 2.1 */
	public static final String DOTHAZARDCLASSORDIVISION_21_FlammableGas = "2.1";
	/** 2.2 - Nonflammable Gas = 2.2 */
	public static final String DOTHAZARDCLASSORDIVISION_22_NonflammableGas = "2.2";
	/** Class 3 - Flammable Liquids = 3 */
	public static final String DOTHAZARDCLASSORDIVISION_Class3_FlammableLiquids = "3";
	/** Class 4 = 4 */
	public static final String DOTHAZARDCLASSORDIVISION_Class4 = "4";
	/** 4.1 - Flammable Solids = 4.1 */
	public static final String DOTHAZARDCLASSORDIVISION_41_FlammableSolids = "4.1";
	/** 4.2 - Spontaneous Combustibles = 4.2 */
	public static final String DOTHAZARDCLASSORDIVISION_42_SpontaneousCombustibles = "4.2";
	/** 4.3 - Dangerous When Wet = 4.3 */
	public static final String DOTHAZARDCLASSORDIVISION_43_DangerousWhenWet = "4.3";
	/** Class 5 - Oxidizing Substances and Organic Peroxides = 5 */
	public static final String DOTHAZARDCLASSORDIVISION_Class5_OxidizingSubstancesAndOrganicPeroxides = "5";
	/** 5.1 - Oxidizers = 5.1 */
	public static final String DOTHAZARDCLASSORDIVISION_51_Oxidizers = "5.1";
	/** 5.2 - Organic Peroxides = 5.2 */
	public static final String DOTHAZARDCLASSORDIVISION_52_OrganicPeroxides = "5.2";
	/** Class 6 - Toxic (Poisonous) and Infectious Substances = 6 */
	public static final String DOTHAZARDCLASSORDIVISION_Class6_ToxicPoisonousAndInfectiousSubstances = "6";
	/** 6.1 - Toxic Substances = 6.1 */
	public static final String DOTHAZARDCLASSORDIVISION_61_ToxicSubstances = "6.1";
	/** 6.2 - Infectious Substances = 6.2 */
	public static final String DOTHAZARDCLASSORDIVISION_62_InfectiousSubstances = "6.2";
	/** Class 7 - Radioactive Material = 7 */
	public static final String DOTHAZARDCLASSORDIVISION_Class7_RadioactiveMaterial = "7";
	/** Class 8 - Corrosives = 8 */
	public static final String DOTHAZARDCLASSORDIVISION_Class8_Corrosives = "8";
	/** Class 9 - Miscellaneous Dangerous Goods = 9 */
	public static final String DOTHAZARDCLASSORDIVISION_Class9_MiscellaneousDangerousGoods = "9";
	/** Set Dot Hazard Class or Division.
		@param DotHazardClassOrDivision Dot Hazard Class or Division	  */
	public void setDotHazardClassOrDivision (String DotHazardClassOrDivision)
	{

		set_Value (COLUMNNAME_DotHazardClassOrDivision, DotHazardClassOrDivision);
	}

	/** Get Dot Hazard Class or Division.
		@return Dot Hazard Class or Division	  */
	public String getDotHazardClassOrDivision () 
	{
		return (String)get_Value(COLUMNNAME_DotHazardClassOrDivision);
	}

	/** Set Dry Ice Weight.
		@param DryIceWeight Dry Ice Weight	  */
	public void setDryIceWeight (BigDecimal DryIceWeight)
	{
		set_Value (COLUMNNAME_DryIceWeight, DryIceWeight);
	}

	/** Get Dry Ice Weight.
		@return Dry Ice Weight	  */
	public BigDecimal getDryIceWeight () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_DryIceWeight);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Duties Shipper Account.
		@param DutiesShipperAccount Duties Shipper Account	  */
	public void setDutiesShipperAccount (String DutiesShipperAccount)
	{
		set_Value (COLUMNNAME_DutiesShipperAccount, DutiesShipperAccount);
	}

	/** Get Duties Shipper Account.
		@return Duties Shipper Account	  */
	public String getDutiesShipperAccount () 
	{
		return (String)get_Value(COLUMNNAME_DutiesShipperAccount);
	}

	/** FOB AD_Reference_ID=200030 */
	public static final int FOB_AD_Reference_ID=200030;
	/** FOB Origin = A_DFOBO */
	public static final String FOB_FOBOrigin = "A_DFOBO";
	/** Ex Works = B_EXW */
	public static final String FOB_ExWorks = "B_EXW";
	/** CFR - Cost and Freight = CFR */
	public static final String FOB_CFR_CostAndFreight = "CFR";
	/** CIF - Cost, Insurance, and Freight (FedEx) = CIF */
	public static final String FOB_CIF_CostInsuranceAndFreightFedEx = "CIF";
	/** CIP - Carriage and Insurance Paid To (FedEx) = CIP */
	public static final String FOB_CIP_CarriageAndInsurancePaidToFedEx = "CIP";
	/** CPT - Carriage Paid To = CPT */
	public static final String FOB_CPT_CarriagePaidTo = "CPT";
	/** DAF - Delivered at Frontier = DAF */
	public static final String FOB_DAF_DeliveredAtFrontier = "DAF";
	/** DDP - Delivered Duty Paid (FedEx) = DDP */
	public static final String FOB_DDP_DeliveredDutyPaidFedEx = "DDP";
	/** DDU - Delivered Duty Unpaid (FedEx) = DDU */
	public static final String FOB_DDU_DeliveredDutyUnpaidFedEx = "DDU";
	/** DEQ - Delivered Ex Quay = DEQ */
	public static final String FOB_DEQ_DeliveredExQuay = "DEQ";
	/** DES - Delivered Ex Ship = DES */
	public static final String FOB_DES_DeliveredExShip = "DES";
	/** Domestic FOB Destination = DFOBD */
	public static final String FOB_DomesticFOBDestination = "DFOBD";
	/** EXW - Ex Works (FedEx) = EXW */
	public static final String FOB_EXW_ExWorksFedEx = "EXW";
	/** FAS - Free Alongside Ship = FAS */
	public static final String FOB_FAS_FreeAlongsideShip = "FAS";
	/** FCA - Free Carrier (FedEx) = FCA */
	public static final String FOB_FCA_FreeCarrierFedEx = "FCA";
	/** FOB - Free on Board (FedEx) = FOB */
	public static final String FOB_FOB_FreeOnBoardFedEx = "FOB";
	/** Set Freight Terms.
		@param FOB Freight Terms	  */
	public void setFOB (String FOB)
	{

		set_ValueNoCheck (COLUMNNAME_FOB, FOB);
	}

	/** Get Freight Terms.
		@return Freight Terms	  */
	public String getFOB () 
	{
		return (String)get_Value(COLUMNNAME_FOB);
	}

	/** Set Freight Amount.
		@param FreightAmt 
		Freight Amount 
	  */
	public void setFreightAmt (BigDecimal FreightAmt)
	{
		set_Value (COLUMNNAME_FreightAmt, FreightAmt);
	}

	/** Get Freight Amount.
		@return Freight Amount 
	  */
	public BigDecimal getFreightAmt () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_FreightAmt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** FreightCharges AD_Reference_ID=200028 */
	public static final int FREIGHTCHARGES_AD_Reference_ID=200028;
	/** Collect = A_Col */
	public static final String FREIGHTCHARGES_Collect = "A_Col";
	/** 3rd Party = B_3P */
	public static final String FREIGHTCHARGES_3rdParty = "B_3P";
	/** Consignee = C_Con */
	public static final String FREIGHTCHARGES_Consignee = "C_Con";
	/** Prepaid = D_PP */
	public static final String FREIGHTCHARGES_Prepaid = "D_PP";
	/** Prepaid and Bill = E_PPB */
	public static final String FREIGHTCHARGES_PrepaidAndBill = "E_PPB";
	/** Set Freight Charges.
		@param FreightCharges Freight Charges	  */
	public void setFreightCharges (String FreightCharges)
	{

		set_ValueNoCheck (COLUMNNAME_FreightCharges, FreightCharges);
	}

	/** Get Freight Charges.
		@return Freight Charges	  */
	public String getFreightCharges () 
	{
		return (String)get_Value(COLUMNNAME_FreightCharges);
	}

	/** Set Handling Charge.
		@param HandlingCharge Handling Charge	  */
	public void setHandlingCharge (BigDecimal HandlingCharge)
	{
		set_Value (COLUMNNAME_HandlingCharge, HandlingCharge);
	}

	/** Get Handling Charge.
		@return Handling Charge	  */
	public BigDecimal getHandlingCharge () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_HandlingCharge);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Height.
		@param Height Height	  */
	public void setHeight (BigDecimal Height)
	{
		set_Value (COLUMNNAME_Height, Height);
	}

	/** Get Height.
		@return Height	  */
	public BigDecimal getHeight () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Height);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_C_BPartner_Location getHoldAddress() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner_Location)MTable.get(getCtx(), org.compiere.model.I_C_BPartner_Location.Table_Name)
			.getPO(getHoldAddress_ID(), get_TrxName());	}

	/** Set Hold Address.
		@param HoldAddress_ID Hold Address	  */
	public void setHoldAddress_ID (int HoldAddress_ID)
	{
		if (HoldAddress_ID < 1) 
			set_Value (COLUMNNAME_HoldAddress_ID, null);
		else 
			set_Value (COLUMNNAME_HoldAddress_ID, Integer.valueOf(HoldAddress_ID));
	}

	/** Get Hold Address.
		@return Hold Address	  */
	public int getHoldAddress_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_HoldAddress_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Date.
		@param HomeDeliveryPremiumDate Date	  */
	public void setHomeDeliveryPremiumDate (Timestamp HomeDeliveryPremiumDate)
	{
		set_Value (COLUMNNAME_HomeDeliveryPremiumDate, HomeDeliveryPremiumDate);
	}

	/** Get Date.
		@return Date	  */
	public Timestamp getHomeDeliveryPremiumDate () 
	{
		return (Timestamp)get_Value(COLUMNNAME_HomeDeliveryPremiumDate);
	}

	/** Set Phone Number.
		@param HomeDeliveryPremiumPhone Phone Number	  */
	public void setHomeDeliveryPremiumPhone (String HomeDeliveryPremiumPhone)
	{
		set_Value (COLUMNNAME_HomeDeliveryPremiumPhone, HomeDeliveryPremiumPhone);
	}

	/** Get Phone Number.
		@return Phone Number	  */
	public String getHomeDeliveryPremiumPhone () 
	{
		return (String)get_Value(COLUMNNAME_HomeDeliveryPremiumPhone);
	}

	/** HomeDeliveryPremiumType AD_Reference_ID=200025 */
	public static final int HOMEDELIVERYPREMIUMTYPE_AD_Reference_ID=200025;
	/** Appointment = APPOINTMENT */
	public static final String HOMEDELIVERYPREMIUMTYPE_Appointment = "APPOINTMENT";
	/** Date Certain = DATE_CERTAIN */
	public static final String HOMEDELIVERYPREMIUMTYPE_DateCertain = "DATE_CERTAIN";
	/** Evening = EVENING */
	public static final String HOMEDELIVERYPREMIUMTYPE_Evening = "EVENING";
	/** Set Home Delivery Premium Type.
		@param HomeDeliveryPremiumType Home Delivery Premium Type	  */
	public void setHomeDeliveryPremiumType (String HomeDeliveryPremiumType)
	{

		set_Value (COLUMNNAME_HomeDeliveryPremiumType, HomeDeliveryPremiumType);
	}

	/** Get Home Delivery Premium Type.
		@return Home Delivery Premium Type	  */
	public String getHomeDeliveryPremiumType () 
	{
		return (String)get_Value(COLUMNNAME_HomeDeliveryPremiumType);
	}

	/** Insurance AD_Reference_ID=200029 */
	public static final int INSURANCE_AD_Reference_ID=200029;
	/** Insure = 1 */
	public static final String INSURANCE_Insure = "1";
	/** Do Not Insure = 2 */
	public static final String INSURANCE_DoNotInsure = "2";
	/** Set Insurance.
		@param Insurance Insurance	  */
	public void setInsurance (String Insurance)
	{

		set_ValueNoCheck (COLUMNNAME_Insurance, Insurance);
	}

	/** Get Insurance.
		@return Insurance	  */
	public String getInsurance () 
	{
		return (String)get_Value(COLUMNNAME_Insurance);
	}

	/** Set Insured Amount.
		@param InsuredAmount Insured Amount	  */
	public void setInsuredAmount (BigDecimal InsuredAmount)
	{
		set_Value (COLUMNNAME_InsuredAmount, InsuredAmount);
	}

	/** Get Insured Amount.
		@return Insured Amount	  */
	public BigDecimal getInsuredAmount () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_InsuredAmount);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Accessible.
		@param IsAccessible Accessible	  */
	public void setIsAccessible (boolean IsAccessible)
	{
		set_Value (COLUMNNAME_IsAccessible, Boolean.valueOf(IsAccessible));
	}

	/** Get Accessible.
		@return Accessible	  */
	public boolean isAccessible () 
	{
		Object oo = get_Value(COLUMNNAME_IsAccessible);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Added Handling.
		@param IsAddedHandling Added Handling	  */
	public void setIsAddedHandling (boolean IsAddedHandling)
	{
		set_Value (COLUMNNAME_IsAddedHandling, Boolean.valueOf(IsAddedHandling));
	}

	/** Get Added Handling.
		@return Added Handling	  */
	public boolean isAddedHandling () 
	{
		Object oo = get_Value(COLUMNNAME_IsAddedHandling);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Alternate Return Address.
		@param IsAlternateReturnAddress Alternate Return Address	  */
	public void setIsAlternateReturnAddress (boolean IsAlternateReturnAddress)
	{
		set_Value (COLUMNNAME_IsAlternateReturnAddress, Boolean.valueOf(IsAlternateReturnAddress));
	}

	/** Get Alternate Return Address.
		@return Alternate Return Address	  */
	public boolean isAlternateReturnAddress () 
	{
		Object oo = get_Value(COLUMNNAME_IsAlternateReturnAddress);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Cargo Aircraft Only.
		@param IsCargoAircraftOnly Cargo Aircraft Only	  */
	public void setIsCargoAircraftOnly (boolean IsCargoAircraftOnly)
	{
		set_Value (COLUMNNAME_IsCargoAircraftOnly, Boolean.valueOf(IsCargoAircraftOnly));
	}

	/** Get Cargo Aircraft Only.
		@return Cargo Aircraft Only	  */
	public boolean isCargoAircraftOnly () 
	{
		Object oo = get_Value(COLUMNNAME_IsCargoAircraftOnly);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Dry Ice.
		@param IsDryIce Dry Ice	  */
	public void setIsDryIce (boolean IsDryIce)
	{
		set_Value (COLUMNNAME_IsDryIce, Boolean.valueOf(IsDryIce));
	}

	/** Get Dry Ice.
		@return Dry Ice	  */
	public boolean isDryIce () 
	{
		Object oo = get_Value(COLUMNNAME_IsDryIce);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Dutiable.
		@param IsDutiable Dutiable	  */
	public void setIsDutiable (boolean IsDutiable)
	{
		set_Value (COLUMNNAME_IsDutiable, Boolean.valueOf(IsDutiable));
	}

	/** Get Dutiable.
		@return Dutiable	  */
	public boolean isDutiable () 
	{
		Object oo = get_Value(COLUMNNAME_IsDutiable);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Future Day Shipment.
		@param IsFutureDayShipment Future Day Shipment	  */
	public void setIsFutureDayShipment (boolean IsFutureDayShipment)
	{
		set_Value (COLUMNNAME_IsFutureDayShipment, Boolean.valueOf(IsFutureDayShipment));
	}

	/** Get Future Day Shipment.
		@return Future Day Shipment	  */
	public boolean isFutureDayShipment () 
	{
		Object oo = get_Value(COLUMNNAME_IsFutureDayShipment);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Hazardous Materials.
		@param IsHazMat Hazardous Materials	  */
	public void setIsHazMat (boolean IsHazMat)
	{
		set_Value (COLUMNNAME_IsHazMat, Boolean.valueOf(IsHazMat));
	}

	/** Get Hazardous Materials.
		@return Hazardous Materials	  */
	public boolean isHazMat () 
	{
		Object oo = get_Value(COLUMNNAME_IsHazMat);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Hold At Location.
		@param IsHoldAtLocation Hold At Location	  */
	public void setIsHoldAtLocation (boolean IsHoldAtLocation)
	{
		set_Value (COLUMNNAME_IsHoldAtLocation, Boolean.valueOf(IsHoldAtLocation));
	}

	/** Get Hold At Location.
		@return Hold At Location	  */
	public boolean isHoldAtLocation () 
	{
		Object oo = get_Value(COLUMNNAME_IsHoldAtLocation);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Ignore Zip Not Found.
		@param IsIgnoreZipNotFound Ignore Zip Not Found	  */
	public void setIsIgnoreZipNotFound (boolean IsIgnoreZipNotFound)
	{
		set_Value (COLUMNNAME_IsIgnoreZipNotFound, Boolean.valueOf(IsIgnoreZipNotFound));
	}

	/** Get Ignore Zip Not Found.
		@return Ignore Zip Not Found	  */
	public boolean isIgnoreZipNotFound () 
	{
		Object oo = get_Value(COLUMNNAME_IsIgnoreZipNotFound);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Ignore Zip State Not Match.
		@param IsIgnoreZipStateNotMatch Ignore Zip State Not Match	  */
	public void setIsIgnoreZipStateNotMatch (boolean IsIgnoreZipStateNotMatch)
	{
		set_Value (COLUMNNAME_IsIgnoreZipStateNotMatch, Boolean.valueOf(IsIgnoreZipStateNotMatch));
	}

	/** Get Ignore Zip State Not Match.
		@return Ignore Zip State Not Match	  */
	public boolean isIgnoreZipStateNotMatch () 
	{
		Object oo = get_Value(COLUMNNAME_IsIgnoreZipStateNotMatch);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Priviledged Rate.
		@param IsPriviledgedRate Priviledged Rate	  */
	public void setIsPriviledgedRate (boolean IsPriviledgedRate)
	{
		set_Value (COLUMNNAME_IsPriviledgedRate, Boolean.valueOf(IsPriviledgedRate));
	}

	/** Get Priviledged Rate.
		@return Priviledged Rate	  */
	public boolean isPriviledgedRate () 
	{
		Object oo = get_Value(COLUMNNAME_IsPriviledgedRate);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Residential.
		@param IsResidential Residential	  */
	public void setIsResidential (boolean IsResidential)
	{
		set_Value (COLUMNNAME_IsResidential, Boolean.valueOf(IsResidential));
	}

	/** Get Residential.
		@return Residential	  */
	public boolean isResidential () 
	{
		Object oo = get_Value(COLUMNNAME_IsResidential);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Saturday Delivery.
		@param IsSaturdayDelivery Saturday Delivery	  */
	public void setIsSaturdayDelivery (boolean IsSaturdayDelivery)
	{
		set_Value (COLUMNNAME_IsSaturdayDelivery, Boolean.valueOf(IsSaturdayDelivery));
	}

	/** Get Saturday Delivery.
		@return Saturday Delivery	  */
	public boolean isSaturdayDelivery () 
	{
		Object oo = get_Value(COLUMNNAME_IsSaturdayDelivery);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Saturday Pickup.
		@param IsSaturdayPickup Saturday Pickup	  */
	public void setIsSaturdayPickup (boolean IsSaturdayPickup)
	{
		set_Value (COLUMNNAME_IsSaturdayPickup, Boolean.valueOf(IsSaturdayPickup));
	}

	/** Get Saturday Pickup.
		@return Saturday Pickup	  */
	public boolean isSaturdayPickup () 
	{
		Object oo = get_Value(COLUMNNAME_IsSaturdayPickup);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Verbal Confirmation.
		@param IsVerbalConfirmation Verbal Confirmation	  */
	public void setIsVerbalConfirmation (boolean IsVerbalConfirmation)
	{
		set_Value (COLUMNNAME_IsVerbalConfirmation, Boolean.valueOf(IsVerbalConfirmation));
	}

	/** Get Verbal Confirmation.
		@return Verbal Confirmation	  */
	public boolean isVerbalConfirmation () 
	{
		Object oo = get_Value(COLUMNNAME_IsVerbalConfirmation);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Latest Pickup Time.
		@param LatestPickupTime Latest Pickup Time	  */
	public void setLatestPickupTime (Timestamp LatestPickupTime)
	{
		set_Value (COLUMNNAME_LatestPickupTime, LatestPickupTime);
	}

	/** Get Latest Pickup Time.
		@return Latest Pickup Time	  */
	public Timestamp getLatestPickupTime () 
	{
		return (Timestamp)get_Value(COLUMNNAME_LatestPickupTime);
	}

	/** Set Length.
		@param Length Length	  */
	public void setLength (BigDecimal Length)
	{
		set_Value (COLUMNNAME_Length, Length);
	}

	/** Get Length.
		@return Length	  */
	public BigDecimal getLength () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Length);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_M_InOut getM_InOut() throws RuntimeException
    {
		return (org.compiere.model.I_M_InOut)MTable.get(getCtx(), org.compiere.model.I_M_InOut.Table_Name)
			.getPO(getM_InOut_ID(), get_TrxName());	}

	/** Set Shipment/Receipt.
		@param M_InOut_ID 
		Material Shipment Document
	  */
	public void setM_InOut_ID (int M_InOut_ID)
	{
		if (M_InOut_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_InOut_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_InOut_ID, Integer.valueOf(M_InOut_ID));
	}

	/** Get Shipment/Receipt.
		@return Material Shipment Document
	  */
	public int getM_InOut_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_InOut_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Package getM_Package() throws RuntimeException
    {
		return (org.compiere.model.I_M_Package)MTable.get(getCtx(), org.compiere.model.I_M_Package.Table_Name)
			.getPO(getM_Package_ID(), get_TrxName());	}

	/** Set Package.
		@param M_Package_ID 
		Shipment Package
	  */
	public void setM_Package_ID (int M_Package_ID)
	{
		if (M_Package_ID < 1) 
			set_Value (COLUMNNAME_M_Package_ID, null);
		else 
			set_Value (COLUMNNAME_M_Package_ID, Integer.valueOf(M_Package_ID));
	}

	/** Get Package.
		@return Shipment Package
	  */
	public int getM_Package_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Package_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Shipper getM_Shipper() throws RuntimeException
    {
		return (org.compiere.model.I_M_Shipper)MTable.get(getCtx(), org.compiere.model.I_M_Shipper.Table_Name)
			.getPO(getM_Shipper_ID(), get_TrxName());	}

	/** Set Shipper.
		@param M_Shipper_ID 
		Method or manner of product delivery
	  */
	public void setM_Shipper_ID (int M_Shipper_ID)
	{
		if (M_Shipper_ID < 1) 
			set_Value (COLUMNNAME_M_Shipper_ID, null);
		else 
			set_Value (COLUMNNAME_M_Shipper_ID, Integer.valueOf(M_Shipper_ID));
	}

	/** Get Shipper.
		@return Method or manner of product delivery
	  */
	public int getM_Shipper_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Shipper_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_ShipperLabels getM_ShipperLabels() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShipperLabels)MTable.get(getCtx(), org.compiere.model.I_M_ShipperLabels.Table_Name)
			.getPO(getM_ShipperLabels_ID(), get_TrxName());	}

	/** Set Shipper Labels.
		@param M_ShipperLabels_ID Shipper Labels	  */
	public void setM_ShipperLabels_ID (int M_ShipperLabels_ID)
	{
		if (M_ShipperLabels_ID < 1) 
			set_Value (COLUMNNAME_M_ShipperLabels_ID, null);
		else 
			set_Value (COLUMNNAME_M_ShipperLabels_ID, Integer.valueOf(M_ShipperLabels_ID));
	}

	/** Get Shipper Labels.
		@return Shipper Labels	  */
	public int getM_ShipperLabels_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperLabels_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_ShipperPackaging getM_ShipperPackaging() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShipperPackaging)MTable.get(getCtx(), org.compiere.model.I_M_ShipperPackaging.Table_Name)
			.getPO(getM_ShipperPackaging_ID(), get_TrxName());	}

	/** Set Shipper Packaging.
		@param M_ShipperPackaging_ID Shipper Packaging	  */
	public void setM_ShipperPackaging_ID (int M_ShipperPackaging_ID)
	{
		if (M_ShipperPackaging_ID < 1) 
			set_Value (COLUMNNAME_M_ShipperPackaging_ID, null);
		else 
			set_Value (COLUMNNAME_M_ShipperPackaging_ID, Integer.valueOf(M_ShipperPackaging_ID));
	}

	/** Get Shipper Packaging.
		@return Shipper Packaging	  */
	public int getM_ShipperPackaging_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperPackaging_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_ShipperPickupTypes getM_ShipperPickupTypes() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShipperPickupTypes)MTable.get(getCtx(), org.compiere.model.I_M_ShipperPickupTypes.Table_Name)
			.getPO(getM_ShipperPickupTypes_ID(), get_TrxName());	}

	/** Set Shipper Pickup Types.
		@param M_ShipperPickupTypes_ID Shipper Pickup Types	  */
	public void setM_ShipperPickupTypes_ID (int M_ShipperPickupTypes_ID)
	{
		if (M_ShipperPickupTypes_ID < 1) 
			set_Value (COLUMNNAME_M_ShipperPickupTypes_ID, null);
		else 
			set_Value (COLUMNNAME_M_ShipperPickupTypes_ID, Integer.valueOf(M_ShipperPickupTypes_ID));
	}

	/** Get Shipper Pickup Types.
		@return Shipper Pickup Types	  */
	public int getM_ShipperPickupTypes_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperPickupTypes_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_ShippingProcessor getM_ShippingProcessor() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShippingProcessor)MTable.get(getCtx(), org.compiere.model.I_M_ShippingProcessor.Table_Name)
			.getPO(getM_ShippingProcessor_ID(), get_TrxName());	}

	/** Set Shipping Processor.
		@param M_ShippingProcessor_ID Shipping Processor	  */
	public void setM_ShippingProcessor_ID (int M_ShippingProcessor_ID)
	{
		if (M_ShippingProcessor_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShippingProcessor_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShippingProcessor_ID, Integer.valueOf(M_ShippingProcessor_ID));
	}

	/** Get Shipping Processor.
		@return Shipping Processor	  */
	public int getM_ShippingProcessor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShippingProcessor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Shipping Transaction.
		@param M_ShippingTransaction_ID Shipping Transaction	  */
	public void setM_ShippingTransaction_ID (int M_ShippingTransaction_ID)
	{
		if (M_ShippingTransaction_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShippingTransaction_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShippingTransaction_ID, Integer.valueOf(M_ShippingTransaction_ID));
	}

	/** Get Shipping Transaction.
		@return Shipping Transaction	  */
	public int getM_ShippingTransaction_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShippingTransaction_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_ShippingTransaction_UU.
		@param M_ShippingTransaction_UU M_ShippingTransaction_UU	  */
	public void setM_ShippingTransaction_UU (String M_ShippingTransaction_UU)
	{
		set_Value (COLUMNNAME_M_ShippingTransaction_UU, M_ShippingTransaction_UU);
	}

	/** Get M_ShippingTransaction_UU.
		@return M_ShippingTransaction_UU	  */
	public String getM_ShippingTransaction_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_ShippingTransaction_UU);
	}

	public org.compiere.model.I_M_Warehouse getM_Warehouse() throws RuntimeException
    {
		return (org.compiere.model.I_M_Warehouse)MTable.get(getCtx(), org.compiere.model.I_M_Warehouse.Table_Name)
			.getPO(getM_Warehouse_ID(), get_TrxName());	}

	/** Set Warehouse.
		@param M_Warehouse_ID 
		Storage Warehouse and Service Point
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
	public int getM_Warehouse_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Warehouse_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Notification Message.
		@param NotificationMessage Notification Message	  */
	public void setNotificationMessage (String NotificationMessage)
	{
		set_Value (COLUMNNAME_NotificationMessage, NotificationMessage);
	}

	/** Get Notification Message.
		@return Notification Message	  */
	public String getNotificationMessage () 
	{
		return (String)get_Value(COLUMNNAME_NotificationMessage);
	}

	/** NotificationType AD_Reference_ID=200026 */
	public static final int NOTIFICATIONTYPE_AD_Reference_ID=200026;
	/** Recipient = RE */
	public static final String NOTIFICATIONTYPE_Recipient = "RE";
	/** Recipient / Sender = RS */
	public static final String NOTIFICATIONTYPE_RecipientSender = "RS";
	/** Sender = SE */
	public static final String NOTIFICATIONTYPE_Sender = "SE";
	/** Set Notification Type.
		@param NotificationType 
		Type of Notifications
	  */
	public void setNotificationType (String NotificationType)
	{

		set_Value (COLUMNNAME_NotificationType, NotificationType);
	}

	/** Get Notification Type.
		@return Type of Notifications
	  */
	public String getNotificationType () 
	{
		return (String)get_Value(COLUMNNAME_NotificationType);
	}

	/** PaymentRule AD_Reference_ID=195 */
	public static final int PAYMENTRULE_AD_Reference_ID=195;
	/** Cash = B */
	public static final String PAYMENTRULE_Cash = "B";
	/** Credit Card = K */
	public static final String PAYMENTRULE_CreditCard = "K";
	/** Direct Deposit = T */
	public static final String PAYMENTRULE_DirectDeposit = "T";
	/** Check = S */
	public static final String PAYMENTRULE_Check = "S";
	/** On Credit = P */
	public static final String PAYMENTRULE_OnCredit = "P";
	/** Direct Debit = D */
	public static final String PAYMENTRULE_DirectDebit = "D";
	/** Mixed POS Payment = M */
	public static final String PAYMENTRULE_MixedPOSPayment = "M";
	/** Set Payment Rule.
		@param PaymentRule 
		How you pay the invoice
	  */
	public void setPaymentRule (String PaymentRule)
	{

		set_Value (COLUMNNAME_PaymentRule, PaymentRule);
	}

	/** Get Payment Rule.
		@return How you pay the invoice
	  */
	public String getPaymentRule () 
	{
		return (String)get_Value(COLUMNNAME_PaymentRule);
	}

	/** Set Order Reference.
		@param POReference 
		Transaction Reference Number (Sales Order, Purchase Order) of your Business Partner
	  */
	public void setPOReference (String POReference)
	{
		set_Value (COLUMNNAME_POReference, POReference);
	}

	/** Get Order Reference.
		@return Transaction Reference Number (Sales Order, Purchase Order) of your Business Partner
	  */
	public String getPOReference () 
	{
		return (String)get_Value(COLUMNNAME_POReference);
	}

	/** Set Price.
		@param Price 
		Price
	  */
	public void setPrice (BigDecimal Price)
	{
		set_Value (COLUMNNAME_Price, Price);
	}

	/** Get Price.
		@return Price
	  */
	public BigDecimal getPrice () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Price);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Unit Price.
		@param PriceActual 
		Actual Price 
	  */
	public void setPriceActual (BigDecimal PriceActual)
	{
		set_Value (COLUMNNAME_PriceActual, PriceActual);
	}

	/** Get Unit Price.
		@return Actual Price 
	  */
	public BigDecimal getPriceActual () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_PriceActual);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Processed.
		@param Processed 
		The document has been processed
	  */
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed () 
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

	/** Set Info Received.
		@param ReceivedInfo 
		Information of the receipt of the package (acknowledgement)
	  */
	public void setReceivedInfo (String ReceivedInfo)
	{
		set_Value (COLUMNNAME_ReceivedInfo, ReceivedInfo);
	}

	/** Get Info Received.
		@return Information of the receipt of the package (acknowledgement)
	  */
	public String getReceivedInfo () 
	{
		return (String)get_Value(COLUMNNAME_ReceivedInfo);
	}

	public org.compiere.model.I_C_BPartner getReturnBPartner() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_Name)
			.getPO(getReturnBPartner_ID(), get_TrxName());	}

	/** Set Return Partner.
		@param ReturnBPartner_ID Return Partner	  */
	public void setReturnBPartner_ID (int ReturnBPartner_ID)
	{
		if (ReturnBPartner_ID < 1) 
			set_Value (COLUMNNAME_ReturnBPartner_ID, null);
		else 
			set_Value (COLUMNNAME_ReturnBPartner_ID, Integer.valueOf(ReturnBPartner_ID));
	}

	/** Get Return Partner.
		@return Return Partner	  */
	public int getReturnBPartner_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ReturnBPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner_Location getReturnLocation() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner_Location)MTable.get(getCtx(), org.compiere.model.I_C_BPartner_Location.Table_Name)
			.getPO(getReturnLocation_ID(), get_TrxName());	}

	/** Set Return Location.
		@param ReturnLocation_ID Return Location	  */
	public void setReturnLocation_ID (int ReturnLocation_ID)
	{
		if (ReturnLocation_ID < 1) 
			set_Value (COLUMNNAME_ReturnLocation_ID, null);
		else 
			set_Value (COLUMNNAME_ReturnLocation_ID, Integer.valueOf(ReturnLocation_ID));
	}

	/** Get Return Location.
		@return Return Location	  */
	public int getReturnLocation_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ReturnLocation_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_User getReturnUser() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getReturnUser_ID(), get_TrxName());	}

	/** Set Return User/Contact.
		@param ReturnUser_ID Return User/Contact	  */
	public void setReturnUser_ID (int ReturnUser_ID)
	{
		if (ReturnUser_ID < 1) 
			set_Value (COLUMNNAME_ReturnUser_ID, null);
		else 
			set_Value (COLUMNNAME_ReturnUser_ID, Integer.valueOf(ReturnUser_ID));
	}

	/** Get Return User/Contact.
		@return Return User/Contact	  */
	public int getReturnUser_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ReturnUser_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_User getSalesRep() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getSalesRep_ID(), get_TrxName());	}

	/** Set Sales Representative.
		@param SalesRep_ID 
		Sales Representative or Company Agent
	  */
	public void setSalesRep_ID (int SalesRep_ID)
	{
		if (SalesRep_ID < 1) 
			set_Value (COLUMNNAME_SalesRep_ID, null);
		else 
			set_Value (COLUMNNAME_SalesRep_ID, Integer.valueOf(SalesRep_ID));
	}

	/** Get Sales Representative.
		@return Sales Representative or Company Agent
	  */
	public int getSalesRep_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SalesRep_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Ship Date.
		@param ShipDate 
		Shipment Date/Time
	  */
	public void setShipDate (Timestamp ShipDate)
	{
		set_Value (COLUMNNAME_ShipDate, ShipDate);
	}

	/** Get Ship Date.
		@return Shipment Date/Time
	  */
	public Timestamp getShipDate () 
	{
		return (Timestamp)get_Value(COLUMNNAME_ShipDate);
	}

	/** Set Shipper Account Number.
		@param ShipperAccount Shipper Account Number	  */
	public void setShipperAccount (String ShipperAccount)
	{
		set_Value (COLUMNNAME_ShipperAccount, ShipperAccount);
	}

	/** Get Shipper Account Number.
		@return Shipper Account Number	  */
	public String getShipperAccount () 
	{
		return (String)get_Value(COLUMNNAME_ShipperAccount);
	}

	/** Set Response Message.
		@param ShippingRespMessage Response Message	  */
	public void setShippingRespMessage (String ShippingRespMessage)
	{
		set_Value (COLUMNNAME_ShippingRespMessage, ShippingRespMessage);
	}

	/** Get Response Message.
		@return Response Message	  */
	public String getShippingRespMessage () 
	{
		return (String)get_Value(COLUMNNAME_ShippingRespMessage);
	}

	/** Set Surcharges.
		@param Surcharges Surcharges	  */
	public void setSurcharges (BigDecimal Surcharges)
	{
		set_Value (COLUMNNAME_Surcharges, Surcharges);
	}

	/** Get Surcharges.
		@return Surcharges	  */
	public BigDecimal getSurcharges () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Surcharges);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Tracking Info.
		@param TrackingInfo Tracking Info	  */
	public void setTrackingInfo (String TrackingInfo)
	{
		set_Value (COLUMNNAME_TrackingInfo, TrackingInfo);
	}

	/** Get Tracking Info.
		@return Tracking Info	  */
	public String getTrackingInfo () 
	{
		return (String)get_Value(COLUMNNAME_TrackingInfo);
	}

	/** Set Tracking No.
		@param TrackingNo 
		Number to track the shipment
	  */
	public void setTrackingNo (String TrackingNo)
	{
		set_Value (COLUMNNAME_TrackingNo, TrackingNo);
	}

	/** Get Tracking No.
		@return Number to track the shipment
	  */
	public String getTrackingNo () 
	{
		return (String)get_Value(COLUMNNAME_TrackingNo);
	}

	/** Set Weight.
		@param Weight 
		Weight of a product
	  */
	public void setWeight (BigDecimal Weight)
	{
		set_Value (COLUMNNAME_Weight, Weight);
	}

	/** Get Weight.
		@return Weight of a product
	  */
	public BigDecimal getWeight () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Weight);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Width.
		@param Width Width	  */
	public void setWidth (BigDecimal Width)
	{
		set_Value (COLUMNNAME_Width, Width);
	}

	/** Get Width.
		@return Width	  */
	public BigDecimal getWidth () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Width);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}
}