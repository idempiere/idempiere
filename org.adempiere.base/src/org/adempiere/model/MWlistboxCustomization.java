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
package org.adempiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MColumn;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Wlistbox_Customization;
import org.compiere.util.Util;

public class MWlistboxCustomization extends X_AD_Wlistbox_Customization {

	/**
	 * 
	 */
	private static final long serialVersionUID = -493650011622455985L;

	/**
	 * @param ctx
	 * @param AD_Wlistbox_Customization_ID
	 * @param trxName
	 */
	public MWlistboxCustomization(Properties ctx, int AD_Wlistbox_Customization_ID, String trxName) {
		super(ctx, AD_Wlistbox_Customization_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */	
	public MWlistboxCustomization(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * @param ctx
	 * @param AD_User_ID
	 * @param AD_WListboxName
	 * @param trxName
	 * @return
	 */	
	public static MWlistboxCustomization get(Properties 	ctx, 
											 int 			AD_User_ID, 
											 String 		AD_WListboxName, 
											 String 		trxName)
	{
		Query query = new Query(ctx, Table_Name, "AD_User_ID=? AND WListboxName=?", trxName);
		return query.setClient_ID().setOnlyActiveRecords(true).setParameters(new Object[] { AD_User_ID, AD_WListboxName}).first();
	}


	private static List<String> cleanCustomization (String[] CustomizationNew)
	{
		for (int i = 0; i < CustomizationNew.length; i++ )
		{
			CustomizationNew[i] = CustomizationNew[i].substring(0, CustomizationNew[i].indexOf("=") );
		}
		return Arrays.asList(CustomizationNew); 
	}	

	private static int columnIndex(String 				searchColumnName, 
								   List<String> 	    columnList)
	{
		for (int i = 0; i < columnList.size(); i++)
		{
			if (columnList.get(i).equals(searchColumnName))
			{
				return i;
			}
		}
	return -1;
	}

	/**
	 * Save the columnWidth of the columns of the WListBox 
	 * @param ctx
	 * @param AD_WListboxName
	 * @param AD_User_ID
	 * @param Custom
	 * @param trxName
	 */
	public static void saveData(Properties  ctx,
								String      AD_WListboxName, 
								int         AD_User_ID, 
								String      Custom, 
								String      trxName) 
	{	
		MWlistboxCustomization WlistBoxCust = get(ctx, AD_User_ID, AD_WListboxName, trxName);
	
		if (WlistBoxCust != null && WlistBoxCust.getAD_Wlistbox_Customization_ID()> 0)
		{
			String[] custOrg = WlistBoxCust.getCustom().split(",");
			List<String> newColumnList =  Arrays.asList(Custom.trim().split(","));
			ArrayList<String> orgColumnList  = new ArrayList<>( Arrays.asList(WlistBoxCust.getCustom().trim().split(",")) );
			//only run through this if the with has changed for a column
			if (!orgColumnList.equals(newColumnList))
			{
				List<String> columnSearch = cleanCustomization (custOrg);
				List<String> addColumn = new ArrayList<String>();
				
				for (int i = 0; i < newColumnList.size(); i++)
				{
					String searchColumnName = newColumnList.get(i).substring(0,newColumnList.get(i).indexOf("="));
					int n = columnIndex(searchColumnName, columnSearch);
					if(n > -1)
					{
						orgColumnList.set(n, newColumnList.get(i).stripLeading());
					}
					else
					{ 
						addColumn.add(newColumnList.get(i).stripLeading());
					}
				}
				if (addColumn.size() > 0)
				{
					orgColumnList.addAll(addColumn);
				}

				int maxLength = MColumn.get(ctx, Table_Name, COLUMNNAME_Custom).getFieldLength();
				String custom = orgColumnList.toString().substring(1, orgColumnList.toString().length() -1).replaceAll("\\s", "");

				if (custom.length() > maxLength) {
					while (custom.length() > maxLength)
						custom = custom.substring(0, custom.lastIndexOf(","));
				}

				WlistBoxCust.setCustom(custom);
			}
		}
		else if (!Util.isEmpty(Custom))
		{
			WlistBoxCust = new MWlistboxCustomization(ctx, 0, trxName); 
			WlistBoxCust.setWlistboxName(AD_WListboxName);
			WlistBoxCust.set_ValueNoCheck(COLUMNNAME_AD_User_ID, AD_User_ID);
			WlistBoxCust.setCustom(Custom);
		}

		if (WlistBoxCust != null)
			WlistBoxCust.saveEx();
	}  // saveData
}
