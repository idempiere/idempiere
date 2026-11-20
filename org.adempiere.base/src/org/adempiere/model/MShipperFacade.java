/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 Low Heng Sin											  *
 * Copyright (C) 2008 Idalica              									  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.model;

import org.compiere.model.I_C_BP_ShippingAcct;
import org.compiere.model.MShipper;
import org.compiere.model.MShippingProcessor;
import org.compiere.util.DB;

/**
 * Facade for MShipper, providing accessor method for custom field
 * @author Low Heng Sin
 */
public class MShipperFacade 
{
	private MShipper m_shipper;
	private MShippingProcessor m_processor;

	/**
	 * @param shipper
	 */
	public MShipperFacade(MShipper shipper)
	{
		m_shipper = shipper;
		m_processor = getShippingProcessor();
	}
	
	/**
	 * @return wrap shipper instance
	 */
	public MShipper getMShipper()
	{
		return m_shipper;
	}
	
	/**
	 * @return shipping processor instance for wrap shipper
	 */
	private MShippingProcessor getShippingProcessor() 
	{
		if (m_shipper.getM_ShippingProcessor_ID() > 0)
			return new MShippingProcessor(m_shipper.getCtx(), m_shipper.getM_ShippingProcessor_ID(), m_shipper.get_TrxName());
		return null;
	}
	
	/**
	 * @return shipping processor class
	 */
	public String getShippingProcessorClass() 
	{
		return m_processor == null ? null : m_processor.getShippingProcessorClass();
	}
		
	/**
	 * @return connection key for shipping processor
	 */
	public String getConnectionKey() 
	{
		return m_processor == null ? null : m_processor.getConnectionKey();
	}
	
	/**
	 * @return connection password for shipping processor
	 */
	public String getConnectionPassword() 
	{
		return m_processor == null ? null : m_processor.getConnectionPassword();
	}
	
	/**
	 * @return connection user id for shipping processor
	 */
	public String getUserID() 
	{
		return m_processor == null ? null : m_processor.getUserID();
	}
	
	/**
	 * @return connection host address for shipping processor
	 */
	public String getHostAddress() 
	{
		return m_processor == null ? null : m_processor.getHostAddress();
	}
	
	/**
	 * @return optional connection proxy address for shipping processor
	 */
	public String getProxyAddress() 
	{
		return m_processor == null ? null : m_processor.getProxyAddress();
	}
	
	/**
	 * @return connection port for shipping processor
	 */
	public int getHostPort() 
	{
		return m_processor == null ? null : m_processor.getHostPort();
	}
	
	/**
	 * @return proxy user id for shipping processor
	 */
	public String getProxyLogon()
	{
		return m_processor == null ? null : m_processor.getProxyLogon();
	}
	
	/**
	 * @return proxy password for shipping processor
	 */
	public String getProxyPassword() 
	{
		return m_processor == null ? null : m_processor.getProxyPassword();
	}	
	
	/**
	 * @return proxy port for shipping processor
	 */
	public int getProxyPort() 
	{
		return m_processor == null ? null : m_processor.getProxyPort();
	}
	
	/**
	 * @return shipping service path for shipping processor
	 */
	public String getServicePath() 
	{
		return m_processor == null ? null : m_processor.getServicePath();
	}	
	
	/**
	 * @return shipping service code 
	 */
	public String getShippingServiceCode() 
	{
		return m_shipper.getShippingServiceCode();
	}
	
	/**
	 * @param AD_Org_ID 
	 * @return shipper account
	 */
	public String getShipperAccount(int AD_Org_ID) 
	{
		return stripAccountFormatting(getShippingAcctValue(I_C_BP_ShippingAcct.COLUMNNAME_ShipperAccount, AD_Org_ID));
	}
	
	/**
	 * @param AD_Org_ID
	 * @return duties shipper account
	 */
	public String getDutiesShipperAccount(int AD_Org_ID) 
	{
		return stripAccountFormatting(getShippingAcctValue(I_C_BP_ShippingAcct.COLUMNNAME_DutiesShipperAccount, AD_Org_ID));
	}
	
	/**
	 * get Meter Number associated with Account Number, use by the Fedex interface
	 * @param AD_Org_ID
	 * @return Shipper Meter Number
	 */
	public String getShipperMeter(int AD_Org_ID) 
	{
		return getShippingAcctValue(I_C_BP_ShippingAcct.COLUMNNAME_ShipperMeter, AD_Org_ID);
	}

	/**
	 * Fetch a shipping account column value for the wrapped shipper and organization.
	 * @param columnName C_BP_ShippingAcct column to select
	 * @param AD_Org_ID organization ID (matches AD_Org_ID or 0, preferring specific org)
	 * @return column value or null if not found
	 */
	private String getShippingAcctValue(String columnName, int AD_Org_ID)
	{
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT sa.").append(columnName).append(" ")
		  .append("FROM ").append(I_C_BP_ShippingAcct.Table_Name).append(" sa ")
		  .append("WHERE (sa.M_ShippingProcessor_ID IS NULL OR sa.M_ShippingProcessor_ID = ?) ")
		  .append("AND sa.IsActive = 'Y' ")
		  .append("AND sa.C_BPartner_ID = ? ")
		  .append("AND sa.AD_Org_ID IN (0, ?) ")
		  .append("ORDER BY sa.AD_Org_ID DESC, sa.M_ShippingProcessor_ID NULLS LAST ");
		return DB.getSQLValueStringEx(m_shipper.get_TrxName(), sb.toString(), m_shipper.getM_ShippingProcessor_ID(), m_shipper.getC_BPartner_ID(), AD_Org_ID);
	}

	private static String stripAccountFormatting(String account)
	{
		if (account == null)
			return null;
		return account.replace("-", "").replace(" ", "");
	}
	
	/**
	 * @return true if residential delivery service is supported
	 */
	public boolean isResidential() 
	{
		return m_shipper.isResidential();
	}
	
	/**
	 * @return true if saturday delivery service is supported
	 */
	public boolean isSaturdayDelivery()
	{
		return m_shipper.isSaturdayDelivery();
	}
	
	/**
	 * @return true if international delivery service is supported
	 */
	public boolean isInternational()
	{
		return m_shipper.isInternational();
	}
}