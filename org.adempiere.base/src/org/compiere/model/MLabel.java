/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Nicolas Micoud (TGI)                                              *
 * - Alan Lescano                                                      *
 * - Norbert Bede                                                      *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;
import java.util.UUID;

import org.compiere.util.Env;

/**
 * Label Model
 */
public class MLabel extends X_AD_Label {
	private static final long serialVersionUID = -964945898771768568L;	
	private static final String[] VIVID_COLORS = {
			"#FFB300",
			"#FF6800",
			"#A6BDD7",
			"#CEA262",
			"#007D34",
			"#F6768E",
			"#00538A",
			"#FF7A5C",
			"#53377A",
			"#FF8E00",
			"#B32851",
			"#F4C800",
			"#93AA00",
			"#F13A13",
			"#1EABAF",
			"#3178C1",
			"#B83140",
			"#0C1326",
			"#C71BEF",
			"#4600AE",
			"#21AA1F",
			"#1238C1",
			"#0C8077",
			"#3F5CE3",
			"#1A5300",
			"#0CA452",
			"#A77A42",
			"#293C8D",
			"#F8155D",
			"#49C600",
			"#803120",
			"#8C0D22"
	};

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Label_ID id
	 *	@param trxName transaction
	 */
	public MLabel(Properties ctx, int AD_Label_ID, String trxName) {
		super(ctx, AD_Label_ID, trxName);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MLabel(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}	

	/**
	 * Calculates the label css style based on priorities:
	 * 1- Label style;
	 * 2- Category style;
	 * 3- Label Hash to Hex 
	 * @return css style
	 */
	public String buildStyle() {
		StringBuilder result = new StringBuilder();

		// Calculated hex color
		if (MSysConfig.getBooleanValue(MSysConfig.LABEL_AUTOMATIC_COLOR, true, getAD_Client_ID())) {
			result.append("color: ").append(MLabel.calculateHexColor(getName())).append(";");
		}
		
		// Category style
		if (getAD_LabelCategory() != null && getAD_LabelCategory().getAD_LabelStyle_ID() > 0)
			result.append(buildStyle(getAD_LabelCategory().getAD_LabelStyle_ID()));

		// Label style
		if (getAD_LabelStyle_ID() > 0)
			result.append(buildStyle(getAD_LabelStyle_ID()));
		
		return result.toString();
	}
	
	private String buildStyle(int AD_Style_ID) {
		StringBuilder result = new StringBuilder();
		
		if (AD_Style_ID > 0) {
			MStyle style = new MStyle(getCtx(), AD_Style_ID, get_TrxName());
			MStyleLine[] lines = style.getStyleLines();

			for (MStyleLine line : lines) 
			{
				String inlineStyle = line.getInlineStyle().trim();

				if (result.length() > 0 && !(result.charAt(result.length()-1)==';'))
					result.append("; ");
				
				result.append(inlineStyle);
			}
			
			result.append(";");
		}
		
		return result.toString();
	}
	
	/**
	 * Calculates a color for a given text
	 * @param text
	 * @return hex color
	 */
	public static String calculateHexColor(String text) {
		int colorIndex = Math.abs(UUID.nameUUIDFromBytes(text.getBytes()).toString().hashCode() % VIVID_COLORS.length);
		return VIVID_COLORS[colorIndex];
	}
	
	public static MLabel getByName(Properties ctx, String name, String trxName) {
		String sqlWhere = " AD_Client_ID=? AND UPPER(Name) LIKE ?";

		return new Query(ctx, Table_Name, sqlWhere, trxName)
				.setParameters(Env.getAD_Client_ID(ctx), name.toUpperCase())
				.setOnlyActiveRecords(true)
				.setOrderBy("Name")
				.first();
	}
}
