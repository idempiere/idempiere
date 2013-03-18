package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MShipperPickupTypes extends X_M_ShipperPickupTypes 
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2836350317204286835L;

	public MShipperPickupTypes(Properties ctx, int M_ShipperPickupTypes_ID, String trxName) 
	{
		super(ctx, M_ShipperPickupTypes_ID, trxName);
	}
	
	public MShipperPickupTypes(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	public String getValue()
	{
		return getM_ShipperPickupTypesCfg().getValue();
	}
	
}
