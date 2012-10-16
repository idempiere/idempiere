package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MStorageReservation extends X_M_StorageReservation {

	public MStorageReservation(Properties ctx, int M_StorageReservation_ID,
			String trxName) {
		super(ctx, M_StorageReservation_ID, trxName);
		// TODO Auto-generated constructor stub
	}
	
	public MStorageReservation(Properties ctx, ResultSet rs,
			String trxName) {
		super(ctx, rs, trxName);
		// TODO Auto-generated constructor stub
	}

}
