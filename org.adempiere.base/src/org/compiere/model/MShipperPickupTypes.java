package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MShipperPickupTypes extends X_M_ShipperPickupTypes 
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2836350317204286835L;

    /**
    * UUID based Constructor
    * @param ctx  Context
    * @param M_ShipperPickupTypes_UU  UUID key
    * @param trxName Transaction
    */
    public MShipperPickupTypes(Properties ctx, String M_ShipperPickupTypes_UU, String trxName) {
        super(ctx, M_ShipperPickupTypes_UU, trxName);
    }

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
