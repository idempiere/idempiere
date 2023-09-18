package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

public class MPasswordHistory extends X_AD_Password_History {
	/**
	 * 
	 */
    private static final long serialVersionUID = -5199700193821111847L;

	/**
    * UUID based Constructor
    * @param ctx  Context
    * @param AD_Password_History_UU  UUID key
    * @param trxName Transaction
    */
    public MPasswordHistory(Properties ctx, String AD_Password_History_UU, String trxName) {
        super(ctx, AD_Password_History_UU, trxName);
    }

	public MPasswordHistory(Properties ctx, int AD_Password_History_ID, String trxName) {
		super(ctx, AD_Password_History_ID, trxName);
	}

	public MPasswordHistory(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	public MPasswordHistory(String salt, String password) {
		super(Env.getCtx(), 0, null);
		this.setSalt(salt);
		this.setPassword(password);
	}
	
	/**
	 * get list password history has age &lt;= passwordMaxDay + daysReuse
	 * @param daysReuse max day can't reuse password, get from password rule
	 * @param userId
	 * @return
	 */
	public static List<MPasswordHistory> getPasswordHistoryForCheck (int daysReuse, int userId){
		if (daysReuse <= 0) {
			return new ArrayList<MPasswordHistory>();
		}
		StringBuilder whereClause = new StringBuilder()
				.append("getDate()-")
				.append(daysReuse)
				.append("<=DatePasswordChanged AND AD_User_ID=")
				.append(userId);
		
		Query query = new Query(Env.getCtx(), MPasswordHistory.Table_Name, whereClause.toString(), null);
		query.setClient_ID(true);
		
		return query.list();
	}

}
