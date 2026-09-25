package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

public class MExtension extends X_AD_Extension {

    private static final long serialVersionUID = -1869100025607142643L;

	public MExtension(Properties ctx, int AD_Extension_ID, String trxName) {
        super(ctx, AD_Extension_ID, trxName);
    }

    public MExtension(Properties ctx, int AD_Extension_ID, String trxName, String... virtualColumns) {
        super(ctx, AD_Extension_ID, trxName, virtualColumns);
    }

    public MExtension(Properties ctx, String AD_Extension_UU, String trxName) {
        super(ctx, AD_Extension_UU, trxName);
    }

    public MExtension(Properties ctx, String AD_Extension_UU, String trxName, String... virtualColumns) {
        super(ctx, AD_Extension_UU, trxName, virtualColumns);
    }

    public MExtension(Properties ctx, ResultSet rs, String trxName) {
        super(ctx, rs, trxName);
    }

}
