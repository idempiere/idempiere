package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MExtensionEntity extends X_AD_ExtensionEntity {

    private static final long serialVersionUID = -2836060838296308018L;

	public MExtensionEntity(Properties ctx, int AD_ExtensionEntity_ID, String trxName) {
        super(ctx, AD_ExtensionEntity_ID, trxName);
    }

    public MExtensionEntity(Properties ctx, int AD_ExtensionEntity_ID, String trxName, String... virtualColumns) {
        super(ctx, AD_ExtensionEntity_ID, trxName, virtualColumns);
    }

    public MExtensionEntity(Properties ctx, String AD_ExtensionEntity_UU, String trxName) {
        super(ctx, AD_ExtensionEntity_UU, trxName);
    }

    public MExtensionEntity(Properties ctx, String AD_ExtensionEntity_UU, String trxName, String... virtualColumns) {
        super(ctx, AD_ExtensionEntity_UU, trxName, virtualColumns);
    }

    public MExtensionEntity(Properties ctx, ResultSet rs, String trxName) {
        super(ctx, rs, trxName);
    }

}
