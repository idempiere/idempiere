package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Util;


public class MWListboxCustomization extends X_AD_WListboxCustomization {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6976679424355871192L;

	
	public MWListboxCustomization(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
		// TODO Auto-generated constructor stub
	}
	
	public MWListboxCustomization(Properties ctx, int AD_WListboxCustomization_ID, String trxName) {
		super(ctx, AD_WListboxCustomization_ID, trxName);
		// TODO Auto-generated constructor stub
	} 


	public static MWListboxCustomization get(Properties ctx, 
											 int AD_User_ID, 
											 int AD_Window_ID,
											 int AD_InfoWindow_ID,
											 int AD_Form_ID,
											 String AD_WListboxName, 
											 String trxName) {
		Query query = new Query(ctx, Table_Name, "AD_User_ID=? AND WListboxName=? AND AD_Window_ID=? AND AD_Infowindow_ID=? AND AD_Form_ID=?", trxName);
		
		return query.setClient_ID().setOnlyActiveRecords(true).setParameters(new Object[] { AD_User_ID, AD_WListboxName, AD_Window_ID, AD_InfoWindow_ID, AD_Form_ID}).first();
	}
	
	
	public static ArrayList removeLenght (String[] _custNew)
	{
		for (int i = 0; i < _custNew.length; i++ )
		{
			_custNew[i] = _custNew[i].substring(0, _custNew[i].indexOf("=") );
		}
		return new ArrayList<String>(Arrays.asList(_custNew)); 
	}	
	
	// only use columnList without the width assigned, only the columnname.
	// return the position of the record
	public static int columnExists(String 				searchColumnName, 
								   ArrayList<String> 	columnList)
	{
		for (int i = 0; i < columnList.size(); i++)
		{
			if (columnList.get(i).toString().equals(searchColumnName))
			{
				return i;
			}
		}
		return -1;
	}

	public static boolean saveData(Properties 	ctx,  
								   String 		AD_WListboxName, 
								   int 			AD_User_ID, 
								   int 			AD_Window_ID, 
								   int 			AD_InfoWindow_ID,
								   int 			AD_Form_ID,
								   String 		Custom, 
								   String 		trxName) {	
		
	MWListboxCustomization listBoxCust = get(ctx, AD_User_ID, AD_Window_ID, AD_InfoWindow_ID, AD_Form_ID, AD_WListboxName, trxName);

	if (listBoxCust != null && listBoxCust.getAD_WListboxCustomization_ID() > 0)
	{

		String[] custNew = Custom.trim().split(",");
		String[] custOrg = listBoxCust.getCustom().split(",");
		
		
		ArrayList<String> newColumnList = new ArrayList<>( Arrays.asList(Custom.trim().split(",")) );
		ArrayList<String> orgColumnList  = new ArrayList<>( Arrays.asList(listBoxCust.getCustom().trim().split(",")) );

		//only run through this if the with has changed for a column
		if (!orgColumnList.equals(newColumnList))
		{
			ArrayList<String> columnSearch = removeLenght (custOrg);
			ArrayList<String> addColumn = new ArrayList<String>();
			
			for (int i = 0; i < newColumnList.size(); i++)
			{
				String searchColumnName = newColumnList.get(i).toString().substring(0,newColumnList.get(i).toString().indexOf("="));

				 
				int n = columnExists(searchColumnName, columnSearch);
				if(n > -1)
				{
					orgColumnList.set(n, newColumnList.get(i).toString().stripLeading());
				}
				else
				{ 
					addColumn.add(newColumnList.get(i).toString().stripLeading());
				}
			}
			if (addColumn.size() > 0)
				orgColumnList.addAll(addColumn);
			listBoxCust.setCustom(orgColumnList.toString().substring(1, orgColumnList.toString().length() -1).replaceAll("\\s", "") );
		}
	}
	else
	{
		listBoxCust = new MWListboxCustomization(ctx, 0, trxName);
		listBoxCust.setwlistboxname(AD_WListboxName);
		listBoxCust.setAD_User_ID(AD_User_ID);
		listBoxCust.setAD_Window_ID(AD_Window_ID);
		listBoxCust.setAD_InfoWindow_ID(AD_InfoWindow_ID);
		listBoxCust.setAD_Form_ID(AD_Form_ID);
		listBoxCust.setCustom(Custom);
	}
	
	if (Util.isEmpty(listBoxCust.getCustom(), true))
		return listBoxCust.delete(true);

	return listBoxCust.save();
}
	

	//cph::erp override the x class
	
	public void setAD_Form_ID (int AD_Form_ID)
	{
		if (AD_Form_ID < 0) 
			set_Value (COLUMNNAME_AD_Form_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Form_ID, Integer.valueOf(AD_Form_ID));
	}

	public void setAD_InfoWindow_ID (int AD_InfoWindow_ID)
	{
		if (AD_InfoWindow_ID < 0) 
			set_ValueNoCheck (COLUMNNAME_AD_InfoWindow_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_InfoWindow_ID, Integer.valueOf(AD_InfoWindow_ID));
	}
	
	
	
	
	

}
