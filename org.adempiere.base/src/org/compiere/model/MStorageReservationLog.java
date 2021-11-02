package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MStorageReservationLog extends X_M_StorageReservationLog {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4527538966135474314L;

	public MStorageReservationLog(Properties ctx, int M_StorageReservationLog_ID, String trxName) {
		super(ctx, M_StorageReservationLog_ID, trxName);
	}

	public MStorageReservationLog(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

}
