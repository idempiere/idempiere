package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MOnlineTrxHistory extends X_X_OnlineTrxHistory {

	public MOnlineTrxHistory(Properties ctx, int X_OnlineTrxHistory_ID, String trxName)
	{
		super(ctx, X_OnlineTrxHistory_ID, trxName);
	}
	
	public MOnlineTrxHistory(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
}
