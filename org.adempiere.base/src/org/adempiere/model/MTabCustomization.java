package org.adempiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.Query;
import org.compiere.model.X_AD_Tab_Customization;

public class MTabCustomization extends X_AD_Tab_Customization {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3977886674683054829L;

	public MTabCustomization(Properties ctx, int AD_Tab_Customization_ID, String trxName) {
		super(ctx, AD_Tab_Customization_ID, trxName);
		if (AD_Tab_Customization_ID == 0)
		{
			setIsActive(true); 
			
		}		
	}

	public MTabCustomization(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param AD_Tab_ID
	 */
	public static MTabCustomization get(Properties ctx, int AD_User_ID, int AD_Tab_ID, String trxName) {
		Query query = new Query(ctx, Table_Name, "AD_User_ID=? AND AD_Tab_ID=?", trxName);
		return query.setParameters(new Object[]{AD_User_ID, AD_Tab_ID}).first();
	}
}
