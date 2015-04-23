package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;

public class MUserPreference extends X_AD_UserPreference{
	
	/** Auto Commit */
	public static final String P_AUTO_COMMIT = "AutoCommit";	
	public static final String P_AUTO_NEW = "AutoNew";
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2406291562249262021L;
	
	public MUserPreference(Properties ctx, int AD_UserPreference_ID,
			String trxName) {
		super(ctx, AD_UserPreference_ID, trxName);

	} //MUserPreference
	
	public MUserPreference(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	} //MUserPreference
	
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID == 0) 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, AD_User_ID);
		else 
			super.setAD_User_ID(AD_User_ID);
	} //setAD_User_ID
	
	private static MUserPreference createUserPreferences(int AD_User_ID, int AD_Client_ID){
		MUserPreference preferences = new MUserPreference(Env.getCtx(), 0, null);
		preferences.setAD_User_ID(AD_User_ID);
		preferences.setAD_Client_ID(AD_Client_ID);
		preferences.saveEx();
		
		return preferences;
	} //createUserPreferences
	
	public static MUserPreference getUserPreference(int AD_User_ID, int AD_Client_ID){
		Query query = new Query(Env.getCtx(), MUserPreference.Table_Name, "NVL(AD_User_ID,0) = ? AND NVL(AD_Client_ID,0) = ?", null);
		MUserPreference preferences = query.setParameters(new Object[]{AD_User_ID, AD_Client_ID}).firstOnly();
		
		if(preferences==null){
			preferences = createUserPreferences(AD_User_ID, AD_Client_ID);
		}
		
		return preferences;
	}
	
	private static String convert(boolean value) {
		return value ? "Y" : "N";
	}
	
	public String getPreference(String key){
		Object value = get_Value(key);
		if( value!=null ){
			if(value instanceof Boolean)
				value = convert((boolean) value);
			
			return value.toString();
		}

		return "";
	}
	
	public void fillPreferences(){
		MTable t = new MTable(Env.getCtx(), MUserPreference.Table_ID, null);
		for (MColumn c: t.getColumns(false)){
			if( !c.getColumnName().equals("AD_Client_ID") && !c.getColumnName().equals("AD_Org_ID") &&
			          !c.getColumnName().equals("AD_User_ID") && !c.getColumnName().equals("AD_UserPreference_ID") &&
   			          !c.getColumnName().equals("AD_UserPreference_UU") && !c.getColumnName().equals("Created") &&
			          !c.getColumnName().equals("CreatedBy") && !c.getColumnName().equals("Updated") &&
			          !c.getColumnName().equals("UpdatedBy") && !c.getColumnName().equals("IsActive") )

				Env.getCtx().setProperty(c.getColumnName(), getPreference(c.getColumnName()));
		}
	}
	
}
