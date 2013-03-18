package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MShippingProcessor extends X_M_ShippingProcessor 
{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7635817773750467895L;

	public MShippingProcessor(Properties ctx, int M_ShippingProcessor_ID, String trxName) 
	{
		super(ctx, M_ShippingProcessor_ID, trxName);
	}
	
	public MShippingProcessor(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	public String getShippingProcessorClass()
	{
		return getM_ShippingProcessorCfg().getShippingProcessorClass();
	}
	
	public String getHostAddress()
	{
		return getM_ShippingProcessorCfg().getHostAddress();
	}
	
	public int getHostPort()
	{
		return getM_ShippingProcessorCfg().getHostPort();
	}
	
	public String getProxyAddress()
	{
		return getM_ShippingProcessorCfg().getProxyAddress();
	}
	
	public int getProxyPort()
	{
		return getM_ShippingProcessorCfg().getProxyPort();
	}
	
	public String getProxyLogon()
	{
		return getM_ShippingProcessorCfg().getProxyLogon();
	}
	
	public String getProxyPassword()
	{
		return getM_ShippingProcessorCfg().getProxyPassword();
	}
	
	public String getServicePath()
	{
		return getM_ShippingProcessorCfg().getServicePath();
	}
	
}
