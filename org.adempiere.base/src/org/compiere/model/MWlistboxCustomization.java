/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Properties;
import org.compiere.util.Util;

public class MWlistboxCustomization extends X_AD_Wlistbox_Customization {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3220641197739038436L;

	public MWlistboxCustomization(Properties ctx, int AD_Wlistbox_Customization_ID, String trxName) {
		super(ctx, AD_Wlistbox_Customization_ID, trxName);
		// TODO Auto-generated constructor stub
	}

	public MWlistboxCustomization(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
		// TODO Auto-generated constructor stub
	}
	
	public static MWlistboxCustomization get(Properties 	ctx, 
											 int 			AD_User_ID, 
											 String 		AD_WListboxName, 
											 String 		trxName)
	{
		Query query = new Query(ctx, Table_Name, "AD_User_ID=? AND WListboxName=?", trxName);
		return query.setClient_ID().setOnlyActiveRecords(true).setParameters(new Object[] { AD_User_ID, AD_WListboxName}).first();
	}


	private static ArrayList<String> cleanCustomization (String[] CustomizationNew)
	{
		for (int i = 0; i < CustomizationNew.length; i++ )
		{
			CustomizationNew[i] = CustomizationNew[i].substring(0, CustomizationNew[i].indexOf("=") );
		}
		return new ArrayList<String>(Arrays.asList(CustomizationNew)); 
	}	

	private static int columnExists(String 				searchColumnName, 
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
								   String 		Custom, 
								   String 		trxName) 
	{	
		MWlistboxCustomization WlistBoxCust = get(ctx, AD_User_ID, AD_WListboxName, trxName);
	
		if (WlistBoxCust != null && WlistBoxCust.getAD_Wlistbox_Customization_ID()> 0)
		{
			String[] custOrg = WlistBoxCust.getCustom().split(",");
			ArrayList<String> newColumnList = new ArrayList<>( Arrays.asList(Custom.trim().split(",")) );
			ArrayList<String> orgColumnList  = new ArrayList<>( Arrays.asList(WlistBoxCust.getCustom().trim().split(",")) );
			//only run through this if the with has changed for a column
			if (!orgColumnList.equals(newColumnList))
			{
				ArrayList<String> columnSearch = cleanCustomization (custOrg);
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
				{
					orgColumnList.addAll(addColumn);
				}
				WlistBoxCust.setCustom(orgColumnList.toString().substring(1, orgColumnList.toString().length() -1).replaceAll("\\s", "") );
			}
		}
		else
		{
			WlistBoxCust = new MWlistboxCustomization(ctx, 0, trxName); 
			WlistBoxCust.setWlistboxName(AD_WListboxName);
			WlistBoxCust.setAD_User_ID(AD_User_ID);
			WlistBoxCust.setCustom(Custom);
		}
		if (Util.isEmpty(WlistBoxCust.getCustom(), true)) {
			return WlistBoxCust.delete(true);
		}
		return WlistBoxCust.save();
	}  // saveData
}
