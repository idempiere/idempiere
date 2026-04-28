package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MPackageImp extends X_AD_Package_Imp {

    private static final long serialVersionUID = -3309800166132173761L;
	public static final String PACKAGE_STATUS_INSTALLING = "Installing";
    public static final String PACKAGE_STATUS_UNRESOLVED = "Completed - unresolved";
    public static final String PACKAGE_STATUS_COMPLETED = "Completed successfully";
    public static final String PACKAGE_STATUS_IMPORT_FAILED = "Import Failed";

	public MPackageImp(Properties ctx, int AD_Package_Imp_ID, String trxName) {
		super(ctx, AD_Package_Imp_ID, trxName);
	}

    public MPackageImp(Properties ctx, ResultSet rs, String trxName) {
        super(ctx, rs, trxName);
    }

    public MPackageImp(Properties ctx, int AD_Package_Imp_ID, String trxName, String... virtualColumns) {
        super(ctx, AD_Package_Imp_ID, trxName, virtualColumns);
    }

    public MPackageImp(Properties ctx, String AD_Package_Imp_UU, String trxName) {
        super(ctx, AD_Package_Imp_UU, trxName);
    }

    public MPackageImp(Properties ctx, String AD_Package_Imp_UU, String trxName, String... virtualColumns) {
        super(ctx, AD_Package_Imp_UU, trxName, virtualColumns);
    }

}
