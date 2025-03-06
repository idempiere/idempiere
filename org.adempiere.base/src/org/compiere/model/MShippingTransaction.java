/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.IShipmentProcessor;
import org.adempiere.model.MShipperFacade;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * Online shipping transaction model
 */
public class MShippingTransaction extends X_M_ShippingTransaction 
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -2444841696998774096L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_ShippingTransaction_UU  UUID key
     * @param trxName Transaction
     */
    public MShippingTransaction(Properties ctx, String M_ShippingTransaction_UU, String trxName) {
        super(ctx, M_ShippingTransaction_UU, trxName);
    }

    /**
     * @param ctx
     * @param M_ShippingTransaction_ID
     * @param trxName
     */
	public MShippingTransaction(Properties ctx, int M_ShippingTransaction_ID, String trxName) 
	{
		super(ctx, M_ShippingTransaction_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MShippingTransaction(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * @param whereClause
	 * @return array of MShippingTransactionLine
	 */
	public MShippingTransactionLine[] getLines(String whereClause)
	{
		StringBuilder whereClauseFinal = new StringBuilder(MShippingTransactionLine.COLUMNNAME_M_ShippingTransaction_ID + "=? ");
		if (!Util.isEmpty(whereClause, true))
			whereClauseFinal.append(whereClause);
		//
		List<MShippingTransactionLine> list = new Query(getCtx(), MShippingTransactionLine.Table_Name, whereClauseFinal.toString(), get_TrxName())
				.setParameters(get_ID())
				.setOrderBy(MShippingTransactionLine.COLUMNNAME_SeqNo)
				.list();
		//
		return list.toArray(new MShippingTransactionLine[list.size()]);		
	}
	
	/** Error Message						*/
	private String				m_errorMessage = null;
	
	/**
	 * Set error message 
	 * @param errorMessage
	 */
	public void setErrorMessage(String errorMessage)
	{
		m_errorMessage = errorMessage;
	}
	
	/**
	 * @return error message
	 */
	public String getErrorMessage()
	{
		return m_errorMessage;
	}
	
	/**
	 * Submit online shipping request (shipment, rate inquiry or void shipment)
	 * @return true if success
	 */
	public boolean processOnline()
	{
		setErrorMessage(null);

		boolean processed = false;		
		try
		{
			MShipperFacade sf = new MShipperFacade(getMShipper());
			IShipmentProcessor processor = Core.getShipmentProcessor(sf);
			if (processor == null)
			{
				setErrorMessage(Msg.getMsg(Env.getCtx(), "ShippingNoProcessor"));
				return false;
			}
			else
			{
				if (getAction().equals(ACTION_ProcessShipment))
					processed = processor.processShipment(getCtx(), this, get_TrxName());
				else if (getAction().equals(ACTION_RateInquiry))
					processed = processor.rateInquiry(getCtx(), this, isPriviledgedRate(), get_TrxName());
				else if (getAction().equals(ACTION_VoidShipment))
					processed = processor.voidShipment(getCtx(), this, get_TrxName());
				else
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ActionNotSupported"));
				
				if (!processed)
					setErrorMessage(Msg.parseTranslation(getCtx(), "** @Error@ ** @From@ ") + getMShipper().getName() + ": " + getShippingRespMessage());
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "processOnline", e);
			setErrorMessage(Msg.getMsg(Env.getCtx(), "ShippingNotProcessed") + ":\n" + e.getMessage());
		}
		
		MOnlineTrxHistory history = new MOnlineTrxHistory(getCtx(), 0, null); // out of transaction - save history even if the process fails
		history.setAD_Table_ID(MShippingTransaction.Table_ID);
		history.setRecord_ID(getM_ShippingTransaction_ID());
		history.setIsError(!processed);
		history.setProcessed(processed);
		
		StringBuilder msg = new StringBuilder();
		if (processed)
			msg.append(getShippingRespMessage());
		else
			msg.append(getErrorMessage());
		msg.append("\nAction: " + getAction());
		history.setTextMsg(msg.toString());
		history.saveCrossTenantSafeEx();

		setProcessed(processed);
		return processed;
	}
	
	/**
	 * @return shipper
	 */
	public MShipper getMShipper()
	{
		return new MShipper(getCtx(), getM_Shipper_ID(), get_TrxName());
	}
	
	/**
	 * @return true if this is an international shipment
	 */
	public boolean isInternational()
	{
		MShipperFacade facade = new MShipperFacade(getMShipper());
		return facade.isInternational();
	}
	
	/**
	 * @return currency ISO code
	 */
	public String getCurrencyCode() 
	{
		MCurrency currency = MCurrency.get(getCtx(), getC_Currency_ID());
		return currency.getISO_Code();
	}
	
	/**
	 * @return true if freight charges will be pay by sender
	 */
	public boolean isPayBySender() 
	{
		// Payment Type must be SENDER or THIRD_PARTY when COD is requested		
		if (MShippingTransaction.FREIGHTCHARGES_Prepaid.equals(getFreightCharges()) || MShippingTransaction.FREIGHTCHARGES_PrepaidAndBill.equals(getFreightCharges()))
			return true;
		else if (!MShippingTransaction.FREIGHTCHARGES_3rdParty.equals(getFreightCharges()) && isCashOnDelivery())
			return true;
		else
			return false;
	}
	
	/**
	 * @return product id for freight charges
	 */
	public int getProductFreightID()
	{
		return DB.getSQLValue(null, "SELECT M_ProductFreight_ID FROM AD_Clientinfo WHERE AD_Client_ID = ?", getAD_Client_ID());
	}
	
	/**
	 * @return true if shipping label is print as image
	 */
	public boolean isPrintLabelAsImage() 
	{
		MShipperLabels label = new MShipperLabels(getCtx(), getM_ShipperLabels_ID(), get_TrxName());
		return MShipperLabels.LABELPRINTMETHOD_Image.equals(label.getLabelPrintMethod());
	}
	
	/**
	 * @return true if shipping label is for printing via Zebra label printer 
	 */
	public boolean isPrintZebraLabel() 
	{
		MShipperLabels label = new MShipperLabels(getCtx(), getM_ShipperLabels_ID(), get_TrxName());
		return MShipperLabels.LABELPRINTMETHOD_Zebra.equals(label.getLabelPrintMethod());
	}
	
	/**
	 * @return true if shipping label is for printing via Eltron label printer
	 */
	public boolean isPrintEltronLabel() 
	{
		MShipperLabels label = new MShipperLabels(getCtx(), getM_ShipperLabels_ID(), get_TrxName());
		return MShipperLabels.LABELPRINTMETHOD_Eltron.equals(label.getLabelPrintMethod());
	}
	
	/**
	 * @return payor account
	 */
	public String getPayorAccount() 
	{
		if (isPayBySender()) 
		{
			MShipperFacade sf = new MShipperFacade(getMShipper());
			return sf.getShipperAccount(getAD_Org_ID());
		} 
		else 
		{
			String ac = getShipperAccount();
			if (ac != null) 
			{
				ac = ac.replaceAll("[-]", "");
				ac = ac.replace(" ", "");
			}
			return ac;
		}
	}
	
	/**
	 * @return payor account for duties
	 */
	public String getDutiesPayorAccount() 
	{
		if (isPayBySender()) 
		{
			MShipperFacade sf = new MShipperFacade(getMShipper());
			String dutiesShipperAccount = sf.getDutiesShipperAccount(getAD_Org_ID());
			if(dutiesShipperAccount == null)
				dutiesShipperAccount = sf.getShipperAccount(getAD_Org_ID());
			return dutiesShipperAccount;
		} 
		else 
		{
			String ac = getDutiesShipperAccount();
			if (ac == null)
				ac = getShipperAccount();
			
			if (ac != null) 
			{
				ac = ac.replaceAll("[-]", "");
				ac = ac.replace(" ", "");
			}
			return ac;
		}
	}
	
	/**
	 * @return country code of payor
	 */
	public String getPayorCountryCode() 
	{
		if (!isPayBySender()) 
		{
			MBPartnerLocation partnerLocation = new MBPartnerLocation(getCtx(), getC_BPartner_Location_ID(), get_TrxName());
			MLocation location = new MLocation(getCtx(), partnerLocation.getC_Location_ID(), get_TrxName());
			X_C_Country country = new X_C_Country(getCtx(), location.getC_Country_ID(), get_TrxName());
			return country.getCountryCode();
		} 
		else 
		{
			MOrg org = new MOrg(getCtx(), getAD_Org_ID(), get_TrxName());
			MOrgInfo info = new MOrgInfo(org);
			MLocation location = new MLocation(getCtx(), info.getC_Location_ID(), get_TrxName());
			X_C_Country country = new X_C_Country(getCtx(), location.getC_Country_ID(), get_TrxName());
			return country.getCountryCode();
		}
	}
	
	/**
	 * @return true if freight charges is to be collected from receiver
	 */
	public boolean isCollect() 
	{
		return MShippingTransaction.FREIGHTCHARGES_Collect.equals(getFreightCharges());
	}
	
	/**
	 * @return true if freight charges is pay by third party
	 */
	public boolean is3rdParty() 
	{
		return MShippingTransaction.FREIGHTCHARGES_3rdParty.equals(getFreightCharges());
	}
	
	/**
	 * @param M_Product_ID
	 * @return X_M_CommodityShipment
	 */
	public X_M_CommodityShipment getCommodityShipment(int M_Product_ID)
	{
		X_M_CommodityShipment commodityShipment = null;
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM M_CommodityShipment ");
		sql.append("WHERE M_Product_ID IN (0, ?) OR M_Product_ID IS NULL ");
		sql.append("AND AD_Client_ID IN (0, ?) ");
		sql.append("AND AD_Org_ID IN (0, ?) ");
		sql.append("ORDER BY M_Product_ID, AD_Org_ID, AD_Client_ID");

		PreparedStatement stmt = null;
		ResultSet rs = null;
			
		try {
			stmt = DB.prepareStatement(sql.toString(), null);
			stmt.setInt(1, M_Product_ID);
			stmt.setInt(2, getAD_Client_ID());
			stmt.setInt(3, getAD_Org_ID());
			rs = stmt.executeQuery();
			
			if(rs.next())
			{
				commodityShipment = new X_M_CommodityShipment(getCtx(), rs, null);
			}
		} 
		catch (Exception e) 
		{
			 log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		} 
		finally 
		{
			DB.close(rs, stmt);
		}
		
		if(commodityShipment == null)
			commodityShipment = new X_M_CommodityShipment(getCtx(), 0, null);
		
		return commodityShipment;
	}
	
	/**
	 * @param M_Product_ID
	 * @return M_CommodityShipment_ID
	 */
	public int getCommodityShipmentID(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		return commodityShipment.getM_CommodityShipment_ID();
	}

	/**
	 * @param M_Product_ID
	 * @return commodity shipment description
	 */
	public String getCommodityDescription(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		return commodityShipment.getDescription();		
	}

	/**
	 * @param M_Product_ID
	 * @return harmonized code of community shipment
	 */
	public String getHarmonizedCode(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		return commodityShipment.getHarmonizedCode();
	}
	
	/**
	 * @param M_Product_ID
	 * @return export license number of commodity shipment
	 */
	public String getExportLicenseNum(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		return commodityShipment.getExportLicenseNum();
	}
	
	/**
	 * @param M_Product_ID
	 * @return country code of manufacture country (from commodity shipment)
	 */
	public String getCountryOfManufacture(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		int countryId = commodityShipment.getCountryOfManufacture_ID();
		X_C_Country c = new X_C_Country(getCtx(), countryId, null);
		return c.getCountryCode();
	}
	
	private PartyInfo senderInfo, recipientInfo;
	
	/**
	 * @return sender details
	 */
	public PartyInfo getSenderInfo()
	{
		if (senderInfo != null)
			return senderInfo;
		
		PartyInfo partyInfo = null;
		
		if (partyInfo == null)
		{
			MOrg sender = new MOrg(getCtx(), getAD_Org_ID(), get_TrxName());
		    MUser senderContact = new MUser(getCtx(), getSalesRep_ID(), get_TrxName());
		    MWarehouse warehouse = new MWarehouse(getCtx(), getM_Warehouse_ID(), get_TrxName());
		    
			partyInfo = new PartyInfo();
			partyInfo.setCompanyName(sender.getName());						
		    partyInfo.setContactName(senderContact.getName());
		    partyInfo.setPhoneNumber(sender.getInfo().getPhone());
			partyInfo.setEmail(senderContact.getEMail());
			partyInfo.setLocationId(warehouse.getC_Location_ID());
		}
		
		senderInfo = partyInfo;
		
		return partyInfo;
	}
	
	/**
	 * @return recipient details
	 */
	public PartyInfo getRecipientInfo()
	{
		if (recipientInfo != null)
			return recipientInfo;

		PartyInfo partyInfo = null;
		if (partyInfo == null)
		{
			MBPartner recipient = new MBPartner(getCtx(), getC_BPartner_ID(), get_TrxName());
		    MBPartnerLocation ra = new MBPartnerLocation(getCtx(), getC_BPartner_Location_ID(), get_TrxName());
		    MUser contact = new MUser(getCtx(), getAD_User_ID(), get_TrxName());
		    
		    partyInfo = new PartyInfo();
			partyInfo.setCompanyName(recipient.getName());						
		    partyInfo.setContactName(contact.getName());
		    partyInfo.setPhoneNumber(contact.getPhone());
			partyInfo.setEmail(contact.getEMail());
			partyInfo.setLocationId(ra.getC_Location_ID());
		}
		
		recipientInfo = partyInfo;
		
		return partyInfo;
	}
	
	/**
	 * Sender/Recipient party value object
	 */
	public class PartyInfo
	{
		private String companyName;
		private String contactName;
		private String phoneNumber;
		private String email;
		private int locationId;
		
		public String getCompanyName() {
			return companyName;
		}
		public void setCompanyName(String companyName) {
			this.companyName = companyName;
		}
		public String getContactName() {
			return contactName;
		}
		public void setContactName(String contactName) {
			this.contactName = contactName;
		}
		public String getPhoneNumber() {
			return phoneNumber;
		}
		public void setPhoneNumber(String phoneNumber) {
			this.phoneNumber = phoneNumber;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public int getLocationId() {
			return locationId;
		}
		public void setLocationId(int locationId) {
			this.locationId = locationId;
		}
	}

}