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
		return getX_ShippingProcessor().getShippingProcessorClass();
	}
	
	public String getHostAddress()
	{
		return getX_ShippingProcessor().getHostAddress();
	}
	
	public int getHostPort()
	{
		return getX_ShippingProcessor().getHostPort();
	}
	
	public String getProxyAddress()
	{
		return getX_ShippingProcessor().getProxyAddress();
	}
	
	public int getProxyPort()
	{
		return getX_ShippingProcessor().getProxyPort();
	}
	
	public String getProxyLogon()
	{
		return getX_ShippingProcessor().getProxyLogon();
	}
	
	public String getProxyPassword()
	{
		return getX_ShippingProcessor().getProxyPassword();
	}
	
	public String getServicePath()
	{
		return getX_ShippingProcessor().getServicePath();
	}
	
}
