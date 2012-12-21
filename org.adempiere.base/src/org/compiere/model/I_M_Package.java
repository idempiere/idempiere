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

/** Generated Interface for M_Package
 *  @author iDempiere (generated) 
 *  @version Release 1.0a
 */
public interface I_M_Package 
{

    /** TableName=M_Package */
    public static final String Table_Name = "M_Package";

    /** AD_Table_ID=664 */
    public static final int Table_ID = 664;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 1 - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(1);

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

    /** Column name BoxCount */
    public static final String COLUMNNAME_BoxCount = "BoxCount";

	/** Set Box Count	  */
	public void setBoxCount (int BoxCount);

	/** Get Box Count	  */
	public int getBoxCount();

    /** Column name C_BP_ShippingAcct_ID */
    public static final String COLUMNNAME_C_BP_ShippingAcct_ID = "C_BP_ShippingAcct_ID";

	/** Set Business Partner Shipping Account	  */
	public void setC_BP_ShippingAcct_ID (int C_BP_ShippingAcct_ID);

	/** Get Business Partner Shipping Account	  */
	public int getC_BP_ShippingAcct_ID();

	public org.compiere.model.I_C_BP_ShippingAcct getC_BP_ShippingAcct() throws RuntimeException;

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

    /** Column name C_Currency_ID */
    public static final String COLUMNNAME_C_Currency_ID = "C_Currency_ID";

	/** Set Currency.
	  * The Currency for this record
	  */
	public void setC_Currency_ID (int C_Currency_ID);

	/** Get Currency.
	  * The Currency for this record
	  */
	public int getC_Currency_ID();

	public org.compiere.model.I_C_Currency getC_Currency() throws RuntimeException;

    /** Column name C_UOM_Length_ID */
    public static final String COLUMNNAME_C_UOM_Length_ID = "C_UOM_Length_ID";

	/** Set UOM for Length.
	  * Standard Unit of Measure for Length
	  */
	public void setC_UOM_Length_ID (int C_UOM_Length_ID);

	/** Get UOM for Length.
	  * Standard Unit of Measure for Length
	  */
	public int getC_UOM_Length_ID();

	public org.compiere.model.I_C_UOM getC_UOM_Length() throws RuntimeException;

    /** Column name C_UOM_Weight_ID */
    public static final String COLUMNNAME_C_UOM_Weight_ID = "C_UOM_Weight_ID";

	/** Set UOM for Weight.
	  * Standard Unit of Measure for Weight
	  */
	public void setC_UOM_Weight_ID (int C_UOM_Weight_ID);

	/** Get UOM for Weight.
	  * Standard Unit of Measure for Weight
	  */
	public int getC_UOM_Weight_ID();

	public org.compiere.model.I_C_UOM getC_UOM_Weight() throws RuntimeException;

    /** Column name CashOnDelivery */
    public static final String COLUMNNAME_CashOnDelivery = "CashOnDelivery";

	/** Set COD	  */
	public void setCashOnDelivery (boolean CashOnDelivery);

	/** Get COD	  */
	public boolean isCashOnDelivery();

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

    /** Column name DateReceived */
    public static final String COLUMNNAME_DateReceived = "DateReceived";

	/** Set Date received.
	  * Date a product was received
	  */
	public void setDateReceived (Timestamp DateReceived);

	/** Get Date received.
	  * Date a product was received
	  */
	public Timestamp getDateReceived();

    /** Column name DeliveryConfirmation */
    public static final String COLUMNNAME_DeliveryConfirmation = "DeliveryConfirmation";

	/** Set Delivery Confirmation.
	  * EMail Delivery confirmation
	  */
	public void setDeliveryConfirmation (boolean DeliveryConfirmation);

	/** Get Delivery Confirmation.
	  * EMail Delivery confirmation
	  */
	public boolean isDeliveryConfirmation();

    /** Column name DeliveryConfirmationType */
    public static final String COLUMNNAME_DeliveryConfirmationType = "DeliveryConfirmationType";

	/** Set Delivery Confirmation Type	  */
	public void setDeliveryConfirmationType (String DeliveryConfirmationType);

	/** Get Delivery Confirmation Type	  */
	public String getDeliveryConfirmationType();

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

    /** Column name DocumentNo */
    public static final String COLUMNNAME_DocumentNo = "DocumentNo";

	/** Set Document No.
	  * Document sequence number of the document
	  */
	public void setDocumentNo (String DocumentNo);

	/** Get Document No.
	  * Document sequence number of the document
	  */
	public String getDocumentNo();

    /** Column name DotHazardClassOrDivision */
    public static final String COLUMNNAME_DotHazardClassOrDivision = "DotHazardClassOrDivision";

	/** Set Dot Hazard Class or Division	  */
	public void setDotHazardClassOrDivision (String DotHazardClassOrDivision);

	/** Get Dot Hazard Class or Division	  */
	public String getDotHazardClassOrDivision();

    /** Column name DryIceWeight */
    public static final String COLUMNNAME_DryIceWeight = "DryIceWeight";

	/** Set Dry Ice Weight	  */
	public void setDryIceWeight (BigDecimal DryIceWeight);

	/** Get Dry Ice Weight	  */
	public BigDecimal getDryIceWeight();

    /** Column name DutiesShipperAccount */
    public static final String COLUMNNAME_DutiesShipperAccount = "DutiesShipperAccount";

	/** Set Duties Shipper Account	  */
	public void setDutiesShipperAccount (String DutiesShipperAccount);

	/** Get Duties Shipper Account	  */
	public String getDutiesShipperAccount();

    /** Column name EstimatedWeight */
    public static final String COLUMNNAME_EstimatedWeight = "EstimatedWeight";

	/** Set Estimated Weight	  */
	public void setEstimatedWeight (BigDecimal EstimatedWeight);

	/** Get Estimated Weight	  */
	public BigDecimal getEstimatedWeight();

    /** Column name FOB */
    public static final String COLUMNNAME_FOB = "FOB";

	/** Set Freight Terms	  */
	public void setFOB (String FOB);

	/** Get Freight Terms	  */
	public String getFOB();

    /** Column name FreightCharges */
    public static final String COLUMNNAME_FreightCharges = "FreightCharges";

	/** Set Freight Charges	  */
	public void setFreightCharges (String FreightCharges);

	/** Get Freight Charges	  */
	public String getFreightCharges();

    /** Column name HandlingCharge */
    public static final String COLUMNNAME_HandlingCharge = "HandlingCharge";

	/** Set Handling Charge	  */
	public void setHandlingCharge (BigDecimal HandlingCharge);

	/** Get Handling Charge	  */
	public BigDecimal getHandlingCharge();

    /** Column name Height */
    public static final String COLUMNNAME_Height = "Height";

	/** Set Height	  */
	public void setHeight (BigDecimal Height);

	/** Get Height	  */
	public BigDecimal getHeight();

    /** Column name HoldAddress */
    public static final String COLUMNNAME_HoldAddress = "HoldAddress";

	/** Set Hold Address	  */
	public void setHoldAddress (int HoldAddress);

	/** Get Hold Address	  */
	public int getHoldAddress();

	public org.compiere.model.I_C_BPartner_Location getHoldAddr() throws RuntimeException;

    /** Column name HomeDeliveryPremiumDate */
    public static final String COLUMNNAME_HomeDeliveryPremiumDate = "HomeDeliveryPremiumDate";

	/** Set Date	  */
	public void setHomeDeliveryPremiumDate (Timestamp HomeDeliveryPremiumDate);

	/** Get Date	  */
	public Timestamp getHomeDeliveryPremiumDate();

    /** Column name HomeDeliveryPremiumPhone */
    public static final String COLUMNNAME_HomeDeliveryPremiumPhone = "HomeDeliveryPremiumPhone";

	/** Set Phone Number	  */
	public void setHomeDeliveryPremiumPhone (String HomeDeliveryPremiumPhone);

	/** Get Phone Number	  */
	public String getHomeDeliveryPremiumPhone();

    /** Column name HomeDeliveryPremiumType */
    public static final String COLUMNNAME_HomeDeliveryPremiumType = "HomeDeliveryPremiumType";

	/** Set Home Delivery Premium Type	  */
	public void setHomeDeliveryPremiumType (String HomeDeliveryPremiumType);

	/** Get Home Delivery Premium Type	  */
	public String getHomeDeliveryPremiumType();

    /** Column name Insurance */
    public static final String COLUMNNAME_Insurance = "Insurance";

	/** Set Insurance	  */
	public void setInsurance (String Insurance);

	/** Get Insurance	  */
	public String getInsurance();

    /** Column name InsuredAmount */
    public static final String COLUMNNAME_InsuredAmount = "InsuredAmount";

	/** Set Insured Amount	  */
	public void setInsuredAmount (BigDecimal InsuredAmount);

	/** Get Insured Amount	  */
	public BigDecimal getInsuredAmount();

    /** Column name IsAccessible */
    public static final String COLUMNNAME_IsAccessible = "IsAccessible";

	/** Set Accessible	  */
	public void setIsAccessible (boolean IsAccessible);

	/** Get Accessible	  */
	public boolean isAccessible();

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

    /** Column name IsAddedHandling */
    public static final String COLUMNNAME_IsAddedHandling = "IsAddedHandling";

	/** Set Added Handling	  */
	public void setIsAddedHandling (boolean IsAddedHandling);

	/** Get Added Handling	  */
	public boolean isAddedHandling();

    /** Column name IsCargoAircraftOnly */
    public static final String COLUMNNAME_IsCargoAircraftOnly = "IsCargoAircraftOnly";

	/** Set Cargo Aircraft Only	  */
	public void setIsCargoAircraftOnly (boolean IsCargoAircraftOnly);

	/** Get Cargo Aircraft Only	  */
	public boolean isCargoAircraftOnly();

    /** Column name IsDryIce */
    public static final String COLUMNNAME_IsDryIce = "IsDryIce";

	/** Set Dry Ice	  */
	public void setIsDryIce (boolean IsDryIce);

	/** Get Dry Ice	  */
	public boolean isDryIce();

    /** Column name IsDutiable */
    public static final String COLUMNNAME_IsDutiable = "IsDutiable";

	/** Set Dutiable	  */
	public void setIsDutiable (boolean IsDutiable);

	/** Get Dutiable	  */
	public boolean isDutiable();

    /** Column name IsFutureDayShipment */
    public static final String COLUMNNAME_IsFutureDayShipment = "IsFutureDayShipment";

	/** Set Future Day Shipment	  */
	public void setIsFutureDayShipment (boolean IsFutureDayShipment);

	/** Get Future Day Shipment	  */
	public boolean isFutureDayShipment();

    /** Column name IsHazMat */
    public static final String COLUMNNAME_IsHazMat = "IsHazMat";

	/** Set Hazardous Materials	  */
	public void setIsHazMat (boolean IsHazMat);

	/** Get Hazardous Materials	  */
	public boolean isHazMat();

    /** Column name IsHoldAtLocation */
    public static final String COLUMNNAME_IsHoldAtLocation = "IsHoldAtLocation";

	/** Set Hold At Location	  */
	public void setIsHoldAtLocation (boolean IsHoldAtLocation);

	/** Get Hold At Location	  */
	public boolean isHoldAtLocation();

    /** Column name IsIgnoreZipNotFound */
    public static final String COLUMNNAME_IsIgnoreZipNotFound = "IsIgnoreZipNotFound";

	/** Set Ignore Zip Not Found	  */
	public void setIsIgnoreZipNotFound (boolean IsIgnoreZipNotFound);

	/** Get Ignore Zip Not Found	  */
	public boolean isIgnoreZipNotFound();

    /** Column name IsIgnoreZipStateNotMatch */
    public static final String COLUMNNAME_IsIgnoreZipStateNotMatch = "IsIgnoreZipStateNotMatch";

	/** Set Ignore Zip State Not Match	  */
	public void setIsIgnoreZipStateNotMatch (boolean IsIgnoreZipStateNotMatch);

	/** Get Ignore Zip State Not Match	  */
	public boolean isIgnoreZipStateNotMatch();

    /** Column name IsResidential */
    public static final String COLUMNNAME_IsResidential = "IsResidential";

	/** Set Residential	  */
	public void setIsResidential (boolean IsResidential);

	/** Get Residential	  */
	public boolean isResidential();

    /** Column name IsSaturdayDelivery */
    public static final String COLUMNNAME_IsSaturdayDelivery = "IsSaturdayDelivery";

	/** Set Saturday Delivery	  */
	public void setIsSaturdayDelivery (boolean IsSaturdayDelivery);

	/** Get Saturday Delivery	  */
	public boolean isSaturdayDelivery();

    /** Column name IsSaturdayPickup */
    public static final String COLUMNNAME_IsSaturdayPickup = "IsSaturdayPickup";

	/** Set Saturday Pickup	  */
	public void setIsSaturdayPickup (boolean IsSaturdayPickup);

	/** Get Saturday Pickup	  */
	public boolean isSaturdayPickup();

    /** Column name IsVerbalConfirmation */
    public static final String COLUMNNAME_IsVerbalConfirmation = "IsVerbalConfirmation";

	/** Set Verbal Confirmation	  */
	public void setIsVerbalConfirmation (boolean IsVerbalConfirmation);

	/** Get Verbal Confirmation	  */
	public boolean isVerbalConfirmation();

    /** Column name LabelPrint */
    public static final String COLUMNNAME_LabelPrint = "LabelPrint";

	/** Set Label Print	  */
	public void setLabelPrint (String LabelPrint);

	/** Get Label Print	  */
	public String getLabelPrint();

    /** Column name LatestPickupTime */
    public static final String COLUMNNAME_LatestPickupTime = "LatestPickupTime";

	/** Set Latest Pickup Time	  */
	public void setLatestPickupTime (Timestamp LatestPickupTime);

	/** Get Latest Pickup Time	  */
	public Timestamp getLatestPickupTime();

    /** Column name Length */
    public static final String COLUMNNAME_Length = "Length";

	/** Set Length	  */
	public void setLength (BigDecimal Length);

	/** Get Length	  */
	public BigDecimal getLength();

    /** Column name M_InOut_ID */
    public static final String COLUMNNAME_M_InOut_ID = "M_InOut_ID";

	/** Set Shipment/Receipt.
	  * Material Shipment Document
	  */
	public void setM_InOut_ID (int M_InOut_ID);

	/** Get Shipment/Receipt.
	  * Material Shipment Document
	  */
	public int getM_InOut_ID();

	public org.compiere.model.I_M_InOut getM_InOut() throws RuntimeException;

    /** Column name M_Package_ID */
    public static final String COLUMNNAME_M_Package_ID = "M_Package_ID";

	/** Set Package.
	  * Shipment Package
	  */
	public void setM_Package_ID (int M_Package_ID);

	/** Get Package.
	  * Shipment Package
	  */
	public int getM_Package_ID();

    /** Column name M_Package_UU */
    public static final String COLUMNNAME_M_Package_UU = "M_Package_UU";

	/** Set M_Package_UU	  */
	public void setM_Package_UU (String M_Package_UU);

	/** Get M_Package_UU	  */
	public String getM_Package_UU();

    /** Column name M_Shipper_ID */
    public static final String COLUMNNAME_M_Shipper_ID = "M_Shipper_ID";

	/** Set Shipper.
	  * Method or manner of product delivery
	  */
	public void setM_Shipper_ID (int M_Shipper_ID);

	/** Get Shipper.
	  * Method or manner of product delivery
	  */
	public int getM_Shipper_ID();

	public org.compiere.model.I_M_Shipper getM_Shipper() throws RuntimeException;

    /** Column name M_ShipperLabels_ID */
    public static final String COLUMNNAME_M_ShipperLabels_ID = "M_ShipperLabels_ID";

	/** Set Shipper Labels	  */
	public void setM_ShipperLabels_ID (int M_ShipperLabels_ID);

	/** Get Shipper Labels	  */
	public int getM_ShipperLabels_ID();

	public org.compiere.model.I_M_ShipperLabels getM_ShipperLabels() throws RuntimeException;

    /** Column name M_ShipperPackaging_ID */
    public static final String COLUMNNAME_M_ShipperPackaging_ID = "M_ShipperPackaging_ID";

	/** Set Shipper Packaging	  */
	public void setM_ShipperPackaging_ID (int M_ShipperPackaging_ID);

	/** Get Shipper Packaging	  */
	public int getM_ShipperPackaging_ID();

	public org.compiere.model.I_M_ShipperPackaging getM_ShipperPackaging() throws RuntimeException;

    /** Column name M_ShipperPickupTypes_ID */
    public static final String COLUMNNAME_M_ShipperPickupTypes_ID = "M_ShipperPickupTypes_ID";

	/** Set Shipper Pickup Types	  */
	public void setM_ShipperPickupTypes_ID (int M_ShipperPickupTypes_ID);

	/** Get Shipper Pickup Types	  */
	public int getM_ShipperPickupTypes_ID();

	public org.compiere.model.I_M_ShipperPickupTypes getM_ShipperPickupTypes() throws RuntimeException;

    /** Column name M_ShippingProcessor_ID */
    public static final String COLUMNNAME_M_ShippingProcessor_ID = "M_ShippingProcessor_ID";

	/** Set Shipping Processor	  */
	public void setM_ShippingProcessor_ID (int M_ShippingProcessor_ID);

	/** Get Shipping Processor	  */
	public int getM_ShippingProcessor_ID();

	public org.compiere.model.I_M_ShippingProcessor getM_ShippingProcessor() throws RuntimeException;

    /** Column name NotificationMessage */
    public static final String COLUMNNAME_NotificationMessage = "NotificationMessage";

	/** Set Notification Message	  */
	public void setNotificationMessage (String NotificationMessage);

	/** Get Notification Message	  */
	public String getNotificationMessage();

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

    /** Column name OProcessing */
    public static final String COLUMNNAME_OProcessing = "OProcessing";

	/** Set Online Processing.
	  * This payment can be processed online
	  */
	public void setOProcessing (String OProcessing);

	/** Get Online Processing.
	  * This payment can be processed online
	  */
	public String getOProcessing();

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

    /** Column name Price */
    public static final String COLUMNNAME_Price = "Price";

	/** Set Price.
	  * Price
	  */
	public void setPrice (BigDecimal Price);

	/** Get Price.
	  * Price
	  */
	public BigDecimal getPrice();

    /** Column name PriceActual */
    public static final String COLUMNNAME_PriceActual = "PriceActual";

	/** Set Unit Price.
	  * Actual Price 
	  */
	public void setPriceActual (BigDecimal PriceActual);

	/** Get Unit Price.
	  * Actual Price 
	  */
	public BigDecimal getPriceActual();

    /** Column name Processed */
    public static final String COLUMNNAME_Processed = "Processed";

	/** Set Processed.
	  * The document has been processed
	  */
	public void setProcessed (boolean Processed);

	/** Get Processed.
	  * The document has been processed
	  */
	public boolean isProcessed();

    /** Column name RateInquiryMessage */
    public static final String COLUMNNAME_RateInquiryMessage = "RateInquiryMessage";

	/** Set Rate Inquiry Message	  */
	public void setRateInquiryMessage (String RateInquiryMessage);

	/** Get Rate Inquiry Message	  */
	public String getRateInquiryMessage();

    /** Column name ReceivedInfo */
    public static final String COLUMNNAME_ReceivedInfo = "ReceivedInfo";

	/** Set Info Received.
	  * Information of the receipt of the package (acknowledgement)
	  */
	public void setReceivedInfo (String ReceivedInfo);

	/** Get Info Received.
	  * Information of the receipt of the package (acknowledgement)
	  */
	public String getReceivedInfo();

    /** Column name ShipDate */
    public static final String COLUMNNAME_ShipDate = "ShipDate";

	/** Set Ship Date.
	  * Shipment Date/Time
	  */
	public void setShipDate (Timestamp ShipDate);

	/** Get Ship Date.
	  * Shipment Date/Time
	  */
	public Timestamp getShipDate();

    /** Column name ShipperAccount */
    public static final String COLUMNNAME_ShipperAccount = "ShipperAccount";

	/** Set Shipper Account Number	  */
	public void setShipperAccount (String ShipperAccount);

	/** Get Shipper Account Number	  */
	public String getShipperAccount();

    /** Column name ShippingRateInquiry */
    public static final String COLUMNNAME_ShippingRateInquiry = "ShippingRateInquiry";

	/** Set Rate Inquiry	  */
	public void setShippingRateInquiry (String ShippingRateInquiry);

	/** Get Rate Inquiry	  */
	public String getShippingRateInquiry();

    /** Column name ShippingRespMessage */
    public static final String COLUMNNAME_ShippingRespMessage = "ShippingRespMessage";

	/** Set Response Message	  */
	public void setShippingRespMessage (String ShippingRespMessage);

	/** Get Response Message	  */
	public String getShippingRespMessage();

    /** Column name Surcharges */
    public static final String COLUMNNAME_Surcharges = "Surcharges";

	/** Set Surcharges	  */
	public void setSurcharges (BigDecimal Surcharges);

	/** Get Surcharges	  */
	public BigDecimal getSurcharges();

    /** Column name TotalPrice */
    public static final String COLUMNNAME_TotalPrice = "TotalPrice";

	/** Set Total Price	  */
	public void setTotalPrice (BigDecimal TotalPrice);

	/** Get Total Price	  */
	public BigDecimal getTotalPrice();

    /** Column name TrackingInfo */
    public static final String COLUMNNAME_TrackingInfo = "TrackingInfo";

	/** Set Tracking Info	  */
	public void setTrackingInfo (String TrackingInfo);

	/** Get Tracking Info	  */
	public String getTrackingInfo();

    /** Column name TrackingNo */
    public static final String COLUMNNAME_TrackingNo = "TrackingNo";

	/** Set Tracking No.
	  * Number to track the shipment
	  */
	public void setTrackingNo (String TrackingNo);

	/** Get Tracking No.
	  * Number to track the shipment
	  */
	public String getTrackingNo();

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

    /** Column name VoidIt */
    public static final String COLUMNNAME_VoidIt = "VoidIt";

	/** Set Void It	  */
	public void setVoidIt (String VoidIt);

	/** Get Void It	  */
	public String getVoidIt();

    /** Column name Weight */
    public static final String COLUMNNAME_Weight = "Weight";

	/** Set Weight.
	  * Weight of a product
	  */
	public void setWeight (BigDecimal Weight);

	/** Get Weight.
	  * Weight of a product
	  */
	public BigDecimal getWeight();

    /** Column name Width */
    public static final String COLUMNNAME_Width = "Width";

	/** Set Width	  */
	public void setWidth (BigDecimal Width);

	/** Get Width	  */
	public BigDecimal getWidth();
}
