package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MShipperPackaging extends X_M_ShipperPackaging 
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6403993556547324865L;

    /**
    * UUID based Constructor
    * @param ctx  Context
    * @param M_ShipperPackaging_UU  UUID key
    * @param trxName Transaction
    */
    public MShipperPackaging(Properties ctx, String M_ShipperPackaging_UU, String trxName) {
        super(ctx, M_ShipperPackaging_UU, trxName);
    }

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
		return getM_ShipperPackagingCfg().getValue();
	}
}
