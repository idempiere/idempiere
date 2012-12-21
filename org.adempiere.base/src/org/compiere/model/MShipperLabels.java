package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

public class MShipperLabels extends X_M_ShipperLabels 
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3903237243862044930L;

	public MShipperLabels(Properties ctx, int M_ShipperLabels_ID, String trxName) 
	{
		super(ctx, M_ShipperLabels_ID, trxName);
	}
	
	public MShipperLabels(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	public String getValue()
	{
		return getX_ShipperLabels().getValue();
	}
	
	public String getName()
	{
		return getX_ShipperLabels().getName();
	}
	
	public BigDecimal getHeight()
	{
		return getX_ShipperLabels().getHeight();
	}
	
	public BigDecimal getWidth()
	{
		return getX_ShipperLabels().getWidth();
	}
	
}
