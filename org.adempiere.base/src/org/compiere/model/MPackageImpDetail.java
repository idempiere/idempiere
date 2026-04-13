package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MPackageImpDetail extends X_AD_Package_Imp_Detail {

	private static final long serialVersionUID = 124203258234563897L;
	/**
	 * Insert new record
	 */
	public static final String ACTION_INSERT = "New";
	/**
	 * Update existing record
	 */
	public static final String ACTION_UPDATE = "Update";
	/**
	 * Execute SQL statement
	 */
 	public static final String ACTION_EXECUTE = "Execute";
 	
	/**
	 * Validate DB Index
	 */
 	public static final String ACTION_VALIDATE = "Validate";

	/**
	 * Success value for the "Success" column
	 */
	public static final String ACTION_STATUS_SUCCESS = "Success";
	/**
	 * Failure value for the "Failure" column
	 */
	public static final String ACTION_STATUS_FAILURE = "Failure";

	
	public MPackageImpDetail(Properties ctx, int AD_Package_Imp_Detail_ID, String trxName) {
		super(ctx, AD_Package_Imp_Detail_ID, trxName);
	}

	public MPackageImpDetail(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	public MPackageImpDetail(Properties ctx, int AD_Package_Imp_Detail_ID, String trxName, String... virtualColumns) {
		super(ctx, AD_Package_Imp_Detail_ID, trxName, virtualColumns);
	}

	public MPackageImpDetail(Properties ctx, String AD_Package_Imp_Detail_UU, String trxName) {
		super(ctx, AD_Package_Imp_Detail_UU, trxName);
	}

	public MPackageImpDetail(Properties ctx, String AD_Package_Imp_Detail_UU, String trxName,
			String... virtualColumns) {
		super(ctx, AD_Package_Imp_Detail_UU, trxName, virtualColumns);
	}

	
}
