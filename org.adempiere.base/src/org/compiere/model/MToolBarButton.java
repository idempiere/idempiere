/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class MToolBarButton extends X_AD_ToolBarButton {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7909388573996489685L;

	/**
	 * @param ctx
	 * @param AD_ToolBarButton_ID
	 * @param trxName
	 */
	public MToolBarButton(Properties ctx, int AD_ToolBarButton_ID,
			String trxName) {
		super(ctx, AD_ToolBarButton_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MToolBarButton(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	public static MToolBarButton[] getProcessButtonOfTab(int AD_Tab_ID, String trxName) {
		MToolBarButton[] buttons = new MToolBarButton[0];
		
		Query query = new Query(Env.getCtx(), MTable.get(Env.getCtx(), Table_ID), "AD_Tab_ID=? AND Action=? AND AD_Process_ID IS NOT NULL", trxName);
		List<MToolBarButton> list = query.setParameters(AD_Tab_ID, "W").setOnlyActiveRecords(true)
				.setOrderBy("CASE WHEN COALESCE(SeqNo,0)=0 THEN AD_ToolBarButton_ID ELSE SeqNo END").list();
		if (list != null && !list.isEmpty()) {
			buttons = list.toArray(buttons);
		}
		
		return buttons;
	}

	public static MToolBarButton[] getToolbarButtons(String action, String trxName) {
		MToolBarButton[] buttons = new MToolBarButton[0];

		Query query = new Query(Env.getCtx(), MTable.get(Env.getCtx(), Table_ID),
				"Action=? AND (AD_ToolbarButton_ID<=? OR ActionClassName IS NOT NULL) AND AD_Tab_ID IS NULL", trxName);
		List<MToolBarButton> list = query.setParameters(action, MTable.MAX_OFFICIAL_ID)
				.setOnlyActiveRecords(true)
				.setOrderBy("CASE WHEN COALESCE(SeqNo,0)=0 THEN AD_ToolBarButton_ID ELSE SeqNo END").list();
		if (list != null && !list.isEmpty()) {
			buttons = list.toArray(buttons);
		}
		
		return buttons;
	}
	
	public static MToolBarButton[] getWindowAdvancedButtons() {
		MToolBarButton[] buttons = new MToolBarButton[0];
		
		Query query = new Query(Env.getCtx(), MTable.get(Env.getCtx(), Table_ID), "Action=?" +
				" AND IsAdvancedButton='Y' AND AD_Client_ID=0", null);
		List<MToolBarButton> list = query.setParameters("W").setOnlyActiveRecords(true).list();
		if (list != null && !list.isEmpty()) {
			buttons = list.toArray(buttons);
		}
		
		return buttons;
	}
}
