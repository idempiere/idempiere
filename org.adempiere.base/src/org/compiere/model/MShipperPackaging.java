package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MShipperPackaging extends X_M_ShipperPackaging 
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6403993556547324865L;

	public MShipperPackaging(Properties ctx, int M_ShipperPackaging_ID, String trxName) 
	{
		super(ctx, M_ShipperPackaging_ID, trxName);
	}
	
	public MShipperPackaging(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	public String getValue()
	{
		return getX_ShipperPackaging().getValue();
	}
}
