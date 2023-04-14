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

    /**
    * UUID based Constructor
    * @param ctx  Context
    * @param M_ShipperLabels_UU  UUID key
    * @param trxName Transaction
    */
    public MShipperLabels(Properties ctx, String M_ShipperLabels_UU, String trxName) {
        super(ctx, M_ShipperLabels_UU, trxName);
    }

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
		return getM_ShipperLabelsCfg().getValue();
	}
	
	public BigDecimal getHeight()
	{
		return getM_ShipperLabelsCfg().getHeight();
	}
	
	public BigDecimal getWidth()
	{
		return getM_ShipperLabelsCfg().getWidth();
	}
	
}
