package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

public class MWFActivityApprover extends X_AD_WF_ActivityApprover {

    private static final long serialVersionUID = -7135169624317070006L;

    public MWFActivityApprover(Properties ctx, int AD_WF_ActivityApprover_ID, String trxName) {
        super(ctx, AD_WF_ActivityApprover_ID, trxName);
    }

    public MWFActivityApprover(Properties ctx, ResultSet rs, String trxName) {
        super(ctx, rs, trxName);
    }

    public static MWFActivityApprover[] getOfActivity(Properties ctx, int ad_WF_Activity_ID, String trxName) {
        final String whereClause = I_AD_WF_ActivityApprover.COLUMNNAME_AD_WF_Activity_ID+"=?";  
        List<MWFActivityApprover> list = new Query(ctx,I_AD_WF_ActivityApprover.Table_Name,whereClause,trxName)
        .setParameters(ad_WF_Activity_ID)
        .list();
        MWFActivityApprover[] retValue = new MWFActivityApprover[list.size ()];
        list.toArray (retValue);
        return retValue;
    }
}
