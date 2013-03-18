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

public class MShippingTransaction extends X_M_ShippingTransaction 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2444841696998774096L;

	public MShippingTransaction(Properties ctx, int M_ShippingTransaction_ID, String trxName) 
	{
		super(ctx, M_ShippingTransaction_ID, trxName);
	}
	
	public MShippingTransaction(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
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
	
	public void setErrorMessage(String errorMessage)
	{
		m_errorMessage = errorMessage;
	}
	
	public String getErrorMessage()
	{
		return m_errorMessage;
	}
	
	public boolean processOnline()
	{
		setErrorMessage(null);

		boolean processed = false;		
		try
		{
			MShipperFacade sf = new MShipperFacade(getMShipper());
			IShipmentProcessor processor = Core.getShipmentProcessor(sf);
			if (processor == null)
				setErrorMessage(Msg.getMsg(Env.getCtx(), "ShippingNoProcessor"));
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
					setErrorMessage("From " + getMShipper().getName() + ": " + getShippingRespMessage());
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "processOnline", e);
			setErrorMessage(Msg.getMsg(Env.getCtx(), "ShippingNotProcessed") + ":\n" + e.getMessage());
		}
		
		MOnlineTrxHistory history = new MOnlineTrxHistory(getCtx(), 0, get_TrxName());
		history.setAD_Table_ID(MShippingTransaction.Table_ID);
		history.setRecord_ID(getM_ShippingTransaction_ID());
		history.setIsError(!processed);
		history.setProcessed(processed);
		
		StringBuilder msg = new StringBuilder();
		if (processed)
			msg.append(getShippingRespMessage());
		else
			msg.append("ERROR: " + getErrorMessage());
		msg.append("\nAction: " + getAction());
		history.setTextMsg(msg.toString());
		
		history.saveEx();
		
		setProcessed(processed);
		return processed;
	}
	
	public MShipper getMShipper()
	{
		return new MShipper(getCtx(), getM_Shipper_ID(), get_TrxName());
	}
	
	public boolean isInternational()
	{
		MShipperFacade facade = new MShipperFacade(getMShipper());
		return facade.isInternational();
	}
	
	public String getCurrencyCode() 
	{
		MCurrency currency = MCurrency.get(getCtx(), getC_Currency_ID());
		return currency.getISO_Code();
	}
	
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
	
	public int getProductFreightID()
	{
		return DB.getSQLValue(null, "SELECT M_ProductFreight_ID FROM AD_Clientinfo WHERE AD_Client_ID = ?", getAD_Client_ID());
	}
	
	public boolean isPrintLabelAsImage() 
	{
		MShipperLabels label = new MShipperLabels(getCtx(), getM_ShipperLabels_ID(), get_TrxName());
		return MShipperLabels.LABELPRINTMETHOD_Image.equals(label.getLabelPrintMethod());
	}
	
	public boolean isPrintZebraLabel() 
	{
		MShipperLabels label = new MShipperLabels(getCtx(), getM_ShipperLabels_ID(), get_TrxName());
		return MShipperLabels.LABELPRINTMETHOD_Zebra.equals(label.getLabelPrintMethod());
	}
	
	public boolean isPrintEltronLabel() 
	{
		MShipperLabels label = new MShipperLabels(getCtx(), getM_ShipperLabels_ID(), get_TrxName());
		return MShipperLabels.LABELPRINTMETHOD_Eltron.equals(label.getLabelPrintMethod());
	}
	
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
				ac = ac.replaceAll(" ", "");
			}
			return ac;
		}
	}
	
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
				ac = ac.replaceAll(" ", "");
			}
			return ac;
		}
	}
	
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
	
	public boolean isCollect() 
	{
		return MShippingTransaction.FREIGHTCHARGES_Collect.equals(getFreightCharges());
	}
	
	public boolean is3rdParty() 
	{
		return MShippingTransaction.FREIGHTCHARGES_3rdParty.equals(getFreightCharges());
	}
	
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
	
	public int getCommodityShipmentID(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		return commodityShipment.getM_CommodityShipment_ID();
	}

	public String getCommodityDescription(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		return commodityShipment.getDescription();		
	}

	public String getHarmonizedCode(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		return commodityShipment.getHarmonizedCode();
	}
	
	public String getExportLicenseNum(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		return commodityShipment.getExportLicenseNum();
	}
	
	public String getCountryOfManufacture(int M_Product_ID) 
	{
		X_M_CommodityShipment commodityShipment = getCommodityShipment(M_Product_ID);
		int countryId = commodityShipment.getCountryOfManufacture();
		X_C_Country c = new X_C_Country(getCtx(), countryId, null);
		return c.getCountryCode();
	}
	
	private PartyInfo senderInfo, recipientInfo;
	
	public PartyInfo getSenderInfo()
	{
		if (senderInfo != null)
			return senderInfo;
		
		PartyInfo partyInfo = null;
		
/*		StringBuilder sql = new StringBuilder();
		sql.append("SELECT CompanyName, ContactName, PhoneNumber, EMail, C_Location_ID ");
		sql.append("FROM X_ShippingSenderInfo_V ");
		sql.append("WHERE M_ShippingTransaction_ID = ?");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), null);
			pstmt.setInt(1, getM_ShippingTransaction_ID());
			rs = pstmt.executeQuery ();
			if (rs.next ())
			{
				partyInfo = new PartyInfo();
				partyInfo.setCompanyName(rs.getString("CompanyName"));
				partyInfo.setContactName(rs.getString("ContactName"));
				partyInfo.setPhoneNumber(rs.getString("PhoneNumber"));
				partyInfo.setEmail(rs.getString("EMail"));
				partyInfo.setLocationId(rs.getInt("C_Location_ID"));
			}
 		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
*/		
		if (partyInfo == null)
		{
			MOrg sender = new MOrg(getCtx(), getAD_Org_ID(), get_TrxName());
		    MUser senderContact = new MUser(getCtx(), getSalesRep_ID(), get_TrxName());
		    MWarehouse warehouse = new MWarehouse(getCtx(), getM_Warehouse_ID(), get_TrxName());
		    
			partyInfo = new PartyInfo();
			partyInfo.setCompanyName(sender.getDescription());						
		    partyInfo.setContactName(senderContact.getDescription());
		    partyInfo.setPhoneNumber(sender.getInfo().getPhone());
			partyInfo.setEmail(senderContact.getEMail());
			partyInfo.setLocationId(warehouse.getC_Location_ID());
		}
		
		senderInfo = partyInfo;
		
		return partyInfo;
	}
	
	public PartyInfo getRecipientInfo()
	{
		if (recipientInfo != null)
			return recipientInfo;

		PartyInfo partyInfo = null;
		
/*		StringBuilder sql = new StringBuilder();
		sql.append("SELECT CompanyName, ContactName, PhoneNumber, EMail, C_Location_ID ");
		sql.append("FROM X_ShippingRecipientInfo_V ");
		sql.append("WHERE M_ShippingTransaction_ID = ?");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), null);
			pstmt.setInt(1, getM_ShippingTransaction_ID());
			rs = pstmt.executeQuery ();
			if (rs.next ())
			{
				partyInfo = new PartyInfo();
				partyInfo.setCompanyName(rs.getString("CompanyName"));
				partyInfo.setContactName(rs.getString("ContactName"));
				partyInfo.setPhoneNumber(rs.getString("PhoneNumber"));
				partyInfo.setEmail(rs.getString("EMail"));
				partyInfo.setLocationId(rs.getInt("C_Location_ID"));
			}
 		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
*/		
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