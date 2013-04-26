/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.util.ShippingUtil;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;


/**
 *	Package Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MPackage.java,v 1.3 2006/07/30 00:51:04 jjanke Exp $
 */
public class MPackage extends X_M_Package
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6082002551560148518L;

	/**
	 * 	Create one Package for Shipment 
	 *	@param shipment shipment
	 *	@param shipper shipper
	 *	@param shipDate null for today
	 *	@return package
	 */
	public static MPackage create (MInOut shipment, MShipper shipper, Timestamp shipDate)
	{
		MPackage retValue = createPackage (shipment, shipper, shipDate);
		
		MPackageMPS packageMPS = new MPackageMPS(shipment.getCtx(), 0, shipment.get_TrxName());
		packageMPS.setSeqNo(10);
		packageMPS.setM_Package_ID(retValue.getM_Package_ID());		
		packageMPS.saveEx();
		
		MClientInfo ci = MClientInfo.get(shipment.getCtx(), shipment.getAD_Client_ID(), shipment.get_TrxName());
		
		//	Lines
		MInOutLine[] lines = shipment.getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MInOutLine sLine = lines[i];
			if(sLine.getM_Product_ID() > 0 && sLine.getM_Product_ID() != ci.getM_ProductFreight_ID())
			{
				MProduct product = new MProduct(shipment.getCtx(), sLine.getM_Product_ID(), shipment.get_TrxName());
				if(product.isBOM() && product.isVerified() && product.isPickListPrintDetails())
				{
					MProductBOM[] bomLines = MProductBOM.getBOMLines(product);
					for(MProductBOM bomLine : bomLines)
					{
						MPackageLine pLine = new MPackageLine(retValue);
						pLine.setInOutLine(sLine);
						pLine.setM_Product_ID(bomLine.getM_ProductBOM_ID());
						pLine.setQty(sLine.getQtyEntered().multiply(bomLine.getBOMQty()));
						pLine.setM_PackageMPS_ID(packageMPS.getM_PackageMPS_ID());
						pLine.saveEx();
					}
				}
				else
				{
					MPackageLine pLine = new MPackageLine (retValue);
					pLine.setInOutLine(sLine);
					pLine.setM_Product_ID(sLine.getM_Product_ID());
					pLine.setM_PackageMPS_ID(packageMPS.getM_PackageMPS_ID());
					pLine.saveEx();
				}
			}
		}	//	lines
		
		retValue.setBoxCount(1);
		retValue.save();
		
		return retValue;
	}	//	create

	
	public static MPackage createPackage (MInOut shipment, MShipper shipper, Timestamp shipDate)
	{
		MPackage retValue = new MPackage (shipment, shipper);
		if (shipDate != null)
			retValue.setShipDate(shipDate);
		retValue.setBoxCount(0);
		retValue.saveEx();
		
		return retValue;
	}
	
	/**************************************************************************
	 * 	MPackage
	 *	@param ctx context
	 *	@param M_Package_ID id
	 *	@param trxName transaction
	 */
	public MPackage (Properties ctx, int M_Package_ID, String trxName)
	{
		super (ctx, M_Package_ID, trxName);
		if (M_Package_ID == 0)
		{
		//	setM_Shipper_ID (0);
		//	setDocumentNo (null);
		//	setM_InOut_ID (0);
			setShipDate (new Timestamp(System.currentTimeMillis()));
			
			MClientInfo clientInfo = MClientInfo.get(ctx, getAD_Client_ID());
			setC_UOM_Weight_ID(clientInfo.getC_UOM_Weight_ID());
			setC_UOM_Length_ID(clientInfo.getC_UOM_Length_ID());
		}
	}	//	MPackage

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPackage (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPackage
	
	/**
	 * 	Shipment Constructor
	 *	@param shipment shipment
	 *	@param shipper shipper
	 */
	public MPackage (MInOut shipment, MShipper shipper)
	{
		this (shipment.getCtx(), 0, shipment.get_TrxName());
		setClientOrg(shipment);
		setM_InOut_ID(shipment.getM_InOut_ID());
		setM_Shipper_ID(shipper.getM_Shipper_ID());
		
		MOrder order = null;
		if (shipment.getC_Order_ID() > 0)
			order = new MOrder(getCtx(), shipment.getC_Order_ID(), get_TrxName());
		else
		{
			MMatchPO[] mos = MMatchPO.getInOut(getCtx(), shipment.getM_InOut_ID(), get_TrxName());
			for (MMatchPO mo : mos)
			{
				MOrderLine ol = new MOrderLine(getCtx(), mo.getC_OrderLine_ID(), get_TrxName());
				if (ol.getC_Order_ID() > 0)
				{
					order = new MOrder(getCtx(), ol.getC_Order_ID(), get_TrxName());
					break;
				}
			}
		}		
		StringBuilder msg = new StringBuilder();
		msg.append("Notification for shipment " + shipment.getDocumentNo());
		if (order != null)
			msg.append(" / order " + order.getDocumentNo());
		setNotificationMessage(msg.toString());
		
		setC_Currency_ID(shipment.getC_Currency_ID());
		
		String whereClause = "M_Shipper_ID = " + shipper.getM_Shipper_ID() + " AND IsDefault='Y' AND IsActive='Y'";
		int[] ids = MShipperLabels.getAllIDs(MShipperLabels.Table_Name, whereClause, shipment.get_TrxName());
		if (ids.length > 0)
			setM_ShipperLabels_ID(ids[0]);

		ids = MShipperPackaging.getAllIDs(MShipperPackaging.Table_Name, whereClause, shipment.get_TrxName());
		if (ids.length > 0)
			setM_ShipperPackaging_ID(ids[0]);

		ids = MShipperPickupTypes.getAllIDs(MShipperPickupTypes.Table_Name, whereClause, shipment.get_TrxName());
		if (ids.length > 0)
			setM_ShipperPickupTypes_ID(ids[0]);
		
		int InvoiceLocationID = ShippingUtil.findRecipientAccountLocationId(shipper.getM_Shipper_ID(), shipment.getC_BPartner_ID(), shipper.getAD_Org_ID(), shipment.getM_InOut_ID(), 0);
		if (InvoiceLocationID > 0)
			setC_BPartner_Location_ID(InvoiceLocationID);
    	
		setIsResidential(shipper.isResidential());
		setIsSaturdayDelivery(shipper.isSaturdayDelivery());
		setTrackingInfo(shipper.getTrackingURL());

		String shipperAccount = null;
		String dutiesShipperAccount = null;
		if (shipment.getFreightCharges().equals(MInOut.FREIGHTCHARGES_Prepaid) || shipment.getFreightCharges().equals(MInOut.FREIGHTCHARGES_PrepaidAndBill))
		{
			shipperAccount = ShippingUtil.getSenderShipperAccount(shipper.getM_Shipper_ID(), shipper.getAD_Org_ID());
			dutiesShipperAccount = ShippingUtil.getSenderDutiesShipperAccount(shipper.getM_Shipper_ID(), shipper.getAD_Org_ID());
		}
		else
			shipperAccount = shipment.getShipperAccount();
		if (shipperAccount != null)
			setShipperAccount(shipperAccount);
		if (dutiesShipperAccount != null)
			setDutiesShipperAccount(dutiesShipperAccount);
	}	//	MPackage
	
	protected boolean beforeSave(boolean newRecord)
	{
		if (getWeight() == null || getWeight().compareTo(BigDecimal.ZERO) == 0)
		{
			String sql = "SELECT SUM(LineWeight) FROM X_PackageLineWeight plw WHERE plw.M_Package_ID=?";
			BigDecimal weight = DB.getSQLValueBD(get_TrxName(), sql, getM_Package_ID());
			if (weight == null)
				weight = BigDecimal.ZERO;
			setWeight(weight);
		}
		
		return true;
	}
	
	protected boolean afterSave(boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT COUNT(*) FROM M_PackageMPS ");
		sb.append("WHERE M_Package_ID = ?");
		int packageMPSCount = DB.getSQLValue(get_TrxName(), sb.toString(), getM_Package_ID());
		
		if (getBoxCount() > 0 && getBoxCount() - packageMPSCount > 0)
		{
			MPackageMPS packageMPS = new MPackageMPS(getCtx(), 0, get_TrxName());
			packageMPS.setM_Package_ID(getM_Package_ID());
			packageMPS.saveEx();
		}
		
		return success;
	}
	
	protected boolean beforeDelete()
	{
		String sql = "DELETE FROM M_PackageLine WHERE M_PackageMPS_ID IN (SELECT M_PackageMPS_ID FROM M_PackageMPS WHERE M_Package_ID = ?)";
		DB.executeUpdate(sql, getM_Package_ID(), get_TrxName());
		
		sql = "DELETE FROM M_PackageMPS WHERE M_Package_ID = ?";
		DB.executeUpdate(sql, getM_Package_ID(), get_TrxName());
		return true;
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
	
	public boolean processOnline(String action, boolean isPriviledgedRate)
	{
		setErrorMessage(null);

		Trx trx = Trx.get(Trx.createTrxName("spt-"), true);
		boolean ok = false;
		try
		{			
			MShippingTransaction st = createShippingTransaction(action, isPriviledgedRate, trx.getTrxName());
			ok = st.processOnline();
			st.saveEx();
			
			if (action.equals(MShippingTransaction.ACTION_ProcessShipment))
			{
				setShippingRespMessage(st.getShippingRespMessage());
				
				if (ok)
				{
					setPrice(st.getPrice());
					setSurcharges(st.getSurcharges());
					setTrackingNo(st.getTrackingNo());
					setProcessed(true);
					
					MAttachment stAttachment = st.getAttachment(true);
					if (stAttachment != null && stAttachment.getEntryCount() > 0)
					{
						MAttachment attachment = getAttachment(true);
						if (attachment == null)
							attachment = createAttachment();
						
						for (int i = 0; i < stAttachment.getEntryCount(); i++)
						{
							if (stAttachment.getEntry(i).getName().startsWith("shipping_label") 
									|| stAttachment.getEntry(i).getName().startsWith("commercial_invoice")
									|| stAttachment.getEntry(i).getName().startsWith("auxiliary_label")
									|| stAttachment.getEntry(i).getName().endsWith("_cod"))
								attachment.addEntry(stAttachment.getEntry(i));
						}
						attachment.saveEx();
					}
					
					MShippingTransactionLine[] lines = st.getLines("");
					for (MShippingTransactionLine line : lines)
					{
						if (line.getM_PackageMPS_ID() == 0)
							continue;
						
						MPackageMPS packageMPS = new MPackageMPS(getCtx(), line.getM_PackageMPS_ID(), get_TrxName());
						packageMPS.setMasterTrackingNo(line.getMasterTrackingNo());
						packageMPS.setTrackingNo(line.getTrackingNo());
						packageMPS.setPrice(line.getPrice());
						packageMPS.setProcessed(line.isProcessed());
						packageMPS.saveEx();
					}
				}
			}
			else if (action.equals(MShippingTransaction.ACTION_RateInquiry))
			{
				setRateInquiryMessage(st.getShippingRespMessage());
			}
			else if (action.equals(MShippingTransaction.ACTION_VoidShipment))
			{
				setShippingRespMessage(st.getShippingRespMessage());
				
				if (ok)
				{
					setProcessed(false);
					
					MAttachment attachment = getAttachment(true);
					if (attachment != null)
					{
						for (int i = attachment.getEntryCount() - 1; i >= 0; i--) 
						{
							if (attachment.getEntry(i).getName().startsWith("shipping_label") 
									|| attachment.getEntry(i).getName().startsWith("commercial_invoice")
									|| attachment.getEntry(i).getName().startsWith("auxiliary_label")
									|| attachment.getEntry(i).getName().endsWith("_cod"))
								attachment.deleteEntry(i);
						}
						if (attachment.getTitle() != null)
							attachment.setTitle(attachment.getTitle());
						else
							attachment.setTitle(MAttachment.ZIP);
						attachment.saveEx();
					}
				}
				
			}
				
			if (!ok)
				setErrorMessage(st.getErrorMessage());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "processOnline", e);
			setErrorMessage(Msg.getMsg(Env.getCtx(), "ShippingNotProcessed") + ": " + e.getMessage());
		}
		
		if (trx != null)
		{
			trx.commit();
			trx.close();
		}

		return ok;
	}
	
	public MShippingTransaction createShippingTransaction(String action, boolean isPriviledgedRate, String trxName)
	{
		MInOut ioOut = null;
		MInvoice invoice = null;
		MOrder order = null;
		
		if (getM_InOut_ID() > 0)
		{
			ioOut = new MInOut(getCtx(), getM_InOut_ID(), get_TrxName());
			if (ioOut.getC_Invoice_ID() > 0)
				invoice = new MInvoice(getCtx(), ioOut.getC_Invoice_ID(), get_TrxName());
			else
			{
				MMatchInv[] mis = MMatchInv.getInOut(getCtx(), ioOut.getM_InOut_ID(), get_TrxName());
				for (MMatchInv mi : mis)
				{
					MInvoiceLine iol = new MInvoiceLine(getCtx(), mi.getC_InvoiceLine_ID(), get_TrxName());
					if (iol.getC_Invoice_ID() > 0)
					{
						invoice = new MInvoice(getCtx(), iol.getC_Invoice_ID(), get_TrxName());
						break;
					}
				}
				
				if (invoice == null)
				{
					StringBuilder sb = new StringBuilder();
					sb.append("SELECT C_Invoice_ID ");
					sb.append("FROM C_InvoiceLine ");
					sb.append("WHERE M_InOutLine_ID IN (");
					sb.append("SELECT M_InOutLine_ID ");
					sb.append("FROM M_InOutLine ");
					sb.append("WHERE M_InOut_ID = ?) ");
					sb.append("ORDER BY C_InvoiceLine_ID DESC");
					int C_Invoice_ID = DB.getSQLValue(get_TrxName(), sb.toString(), getM_InOut_ID());
					if (C_Invoice_ID > 0)
						invoice = new MInvoice(getCtx(), C_Invoice_ID, get_TrxName());
				}
			}

			if (ioOut.getC_Order_ID() > 0)
				order = new MOrder(getCtx(), ioOut.getC_Order_ID(), get_TrxName());
			else
			{
				MMatchPO[] mos = MMatchPO.getInOut(getCtx(), ioOut.getM_InOut_ID(), get_TrxName());
				for (MMatchPO mo : mos)
				{
					MOrderLine ol = new MOrderLine(getCtx(), mo.getC_OrderLine_ID(), get_TrxName());
					if (ol.getC_Order_ID() > 0)
					{
						order = new MOrder(getCtx(), ol.getC_Order_ID(), get_TrxName());
						break;
					}
				}
				
				if (order == null)
				{
					StringBuilder sb = new StringBuilder();
					sb.append("SELECT C_Order_ID ");
					sb.append("FROM C_OrderLine ");
					sb.append("WHERE C_OrderLine_ID IN (");
					sb.append("SELECT C_OrderLine_ID ");
					sb.append("FROM M_InOutLine ");
					sb.append("WHERE M_InOut_ID = ?) ");
					sb.append("ORDER BY C_OrderLine_ID DESC");
					int C_Order_ID = DB.getSQLValue(get_TrxName(), sb.toString(), getM_InOut_ID());
					if (C_Order_ID > 0)
						order = new MOrder(getCtx(), C_Order_ID, get_TrxName());
				}
			}
			
			if (invoice == null && order != null)
			{
				StringBuilder sb = new StringBuilder();
				sb.append("SELECT C_Invoice_ID ");
				sb.append("FROM C_Invoice ");
				sb.append("WHERE C_Order_ID = ? ");
				sb.append("ORDER BY C_Invoice_ID DESC");
				int C_Invoice_ID = DB.getSQLValue(get_TrxName(), sb.toString(), order.getC_Order_ID());
				if (C_Invoice_ID > 0)
					invoice = new MInvoice(getCtx(), C_Invoice_ID, get_TrxName());
			}
		}
		
		MClientInfo ci = MClientInfo.get(getCtx(), getAD_Client_ID(), get_TrxName());
		BigDecimal CODAmount = BigDecimal.ZERO;
		BigDecimal CustomsValue = BigDecimal.ZERO;
		BigDecimal FreightAmt = BigDecimal.ZERO;
		if (invoice != null)
		{
			CODAmount = invoice.getGrandTotal();
			MInvoiceLine[] ils = invoice.getLines();
			for (MInvoiceLine il : ils)
			{
				if (il.getM_Product_ID() == ci.getM_ProductFreight_ID() || il.getC_Charge_ID() == ci.getC_ChargeFreight_ID())
					FreightAmt = FreightAmt.add(il.getLineNetAmt());
			}
			CustomsValue = CODAmount.subtract(FreightAmt);
		}
		else if (order != null)
		{
			CODAmount = order.getGrandTotal();
			MOrderLine[] ols = order.getLines();
			for (MOrderLine ol : ols)
			{
				if ((ol.getM_Product_ID() > 0 && ol.getM_Product_ID() == ci.getM_ProductFreight_ID()) ||
						(ol.getC_Charge_ID() > 0 && ol.getC_Charge_ID() == ci.getC_ChargeFreight_ID()))
					FreightAmt = FreightAmt.add(ol.getLineNetAmt());
			}
			CustomsValue = CODAmount.subtract(FreightAmt);			
		}
		
		MShippingTransaction st = new MShippingTransaction(getCtx(), 0, trxName);
		st.setAction(action);
		st.setAD_Client_ID(getAD_Client_ID());
		st.setAD_Org_ID(getAD_Org_ID());
		st.setAD_User_ID(ioOut.getAD_User_ID() > 0 ? ioOut.getAD_User_ID() : order.getAD_User_ID());
		st.setBill_Location_ID(getC_BPartner_Location_ID());
		st.setBoxCount(getBoxCount());
		st.setC_BP_ShippingAcct_ID(getC_BP_ShippingAcct_ID());
		st.setC_BPartner_ID(ioOut.getC_BPartner_ID());
		st.setC_BPartner_Location_ID(ioOut.getC_BPartner_Location_ID());
		st.setC_Currency_ID(getC_Currency_ID());
		st.setC_Invoice_ID(invoice != null ? invoice.getC_Invoice_ID() : 0);
		st.setC_Order_ID(order != null ? order.getC_Order_ID() : 0);
		st.setC_UOM_Length_ID(getC_UOM_Length_ID());
		st.setC_UOM_Weight_ID(getC_UOM_Weight_ID());
		st.setCashOnDelivery(isCashOnDelivery());
		st.setCODAmount(CODAmount);
		st.setCustomsValue(CustomsValue);
		st.setDateReceived(getDateReceived());
		st.setDeliveryConfirmation(isDeliveryConfirmation());
		st.setDeliveryConfirmationType(getDeliveryConfirmationType());
		st.setDescription(getDescription());
		st.setDotHazardClassOrDivision(getDotHazardClassOrDivision());
		st.setDryIceWeight(getDryIceWeight());
		st.setDutiesShipperAccount(getDutiesShipperAccount());
		st.setFOB(getFOB());
		st.setFreightAmt(FreightAmt);
		st.setFreightCharges(getFreightCharges());
		st.setHandlingCharge(getHandlingCharge());
		st.setHeight(getHeight());
		st.setHoldAddress_ID(getHoldAddress_ID());
		st.setHomeDeliveryPremiumDate(getHomeDeliveryPremiumDate());
		st.setHomeDeliveryPremiumPhone(getHomeDeliveryPremiumPhone());
		st.setHomeDeliveryPremiumType(getHomeDeliveryPremiumType());
		st.setInsurance(getInsurance());
		st.setInsuredAmount(getInsuredAmount());
		st.setIsAccessible(isAccessible());
		st.setIsActive(isActive());
		st.setIsAddedHandling(isAddedHandling());
		st.setIsAlternateReturnAddress(ioOut.isAlternateReturnAddress());
		st.setIsCargoAircraftOnly(isCargoAircraftOnly());
		st.setIsDryIce(isDryIce());
		st.setIsDutiable(isDutiable());
		st.setIsFutureDayShipment(isFutureDayShipment());
		st.setIsHazMat(isHazMat());
		st.setIsHoldAtLocation(isHoldAtLocation());
		st.setIsIgnoreZipNotFound(isIgnoreZipNotFound());
		st.setIsIgnoreZipStateNotMatch(isIgnoreZipStateNotMatch());
		st.setIsPriviledgedRate(isPriviledgedRate);
		st.setIsResidential(isResidential());
		st.setIsSaturdayDelivery(isSaturdayDelivery());
		st.setIsSaturdayPickup(isSaturdayPickup());
		st.setIsVerbalConfirmation(isVerbalConfirmation());
		st.setLatestPickupTime(getLatestPickupTime());
		st.setLength(getLength());
		st.setM_InOut_ID(getM_InOut_ID());
		st.setM_Package_ID(getM_Package_ID());
		st.setM_Shipper_ID(getM_Shipper_ID());
		st.setM_ShipperLabels_ID(getM_ShipperLabels_ID());
		st.setM_ShipperPackaging_ID(getM_ShipperPackaging_ID());
		st.setM_ShipperPickupTypes_ID(getM_ShipperPickupTypes_ID());
		st.setM_ShippingProcessor_ID(getM_ShippingProcessor_ID());
		st.setM_Warehouse_ID(ioOut.getM_Warehouse_ID());
		st.setNotificationMessage(getNotificationMessage());
		st.setNotificationType(getNotificationType());
		st.setPaymentRule(getPaymentRule());
		st.setPOReference(ioOut.getPOReference() != null ? ioOut.getPOReference() : order.getPOReference());
		st.setPrice(getPrice());
		st.setPriceActual(getPriceActual());
		st.setProcessed(isProcessed());
		st.setReceivedInfo(getReceivedInfo());
		st.setReturnBPartner_ID(ioOut.getReturnBPartner_ID());
		st.setReturnLocation_ID(ioOut.getReturnLocation_ID());
		st.setReturnUser_ID(ioOut.getReturnUser_ID());
		st.setSalesRep_ID(ioOut.getSalesRep_ID());
		st.setShipDate(getShipDate());
		st.setShipperAccount(getShipperAccount());
//		st.setShippingRespMessage(ShippingRespMessage);
		st.setSurcharges(getSurcharges());
		st.setTrackingInfo(getTrackingInfo());
		st.setTrackingNo(getTrackingNo());
		st.setWeight(getWeight());
		st.setWidth(getWidth());
		st.saveEx();
		
		int[] ids = MPackageMPS.getAllIDs(MPackageMPS.Table_Name, "M_Package_ID = " + getM_Package_ID(), get_TrxName());
		for (int i = 0; i < ids.length; i++)
		{
			MPackageMPS packageMPS = new MPackageMPS(getCtx(), ids[i], null);
			if (packageMPS.getWeight() == null || packageMPS.getWeight().compareTo(BigDecimal.ZERO) == 0)
			{
				String sql = "SELECT SUM(LineWeight) FROM X_PackageLineWeight plw WHERE plw.M_PackageMPS_ID=?";
				BigDecimal weight = DB.getSQLValueBD(get_TrxName(), sql, packageMPS.getM_PackageMPS_ID());
				if (weight == null)
					weight = BigDecimal.ZERO;
				packageMPS.setWeight(weight);
				packageMPS.saveEx();
			}
			
			MShippingTransactionLine stl = new MShippingTransactionLine(st.getCtx(), 0, st.get_TrxName());
			stl.setAD_Client_ID(packageMPS.getAD_Client_ID());
			stl.setAD_Org_ID(packageMPS.getAD_Org_ID());
			stl.setC_UOM_Length_ID(packageMPS.getC_UOM_Length_ID());
			stl.setC_UOM_Weight_ID(packageMPS.getC_UOM_Weight_ID());
			stl.setDescription(packageMPS.getDescription());
			stl.setHeight(packageMPS.getHeight());
			stl.setIsActive(packageMPS.isActive());
			stl.setLength(packageMPS.getLength());
			stl.setM_PackageMPS_ID(packageMPS.getM_PackageMPS_ID());
			stl.setM_ShippingTransaction_ID(st.getM_ShippingTransaction_ID());
			stl.setMasterTrackingNo(packageMPS.getMasterTrackingNo());
			stl.setPrice(packageMPS.getPrice());
			stl.setProcessed(packageMPS.isProcessed());
			stl.setSeqNo(packageMPS.getSeqNo());
			stl.setTrackingNo(packageMPS.getTrackingNo());
			stl.setWeight(packageMPS.getWeight());
			stl.setWidth(packageMPS.getWidth());
			stl.saveEx();
		}
		
		return st;
	}
	
}	//	MPackage
