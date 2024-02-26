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
 * Extended model class for AD_ToolBarButton
 * @author hengsin
 */
public class MToolBarButton extends X_AD_ToolBarButton {
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -7909388573996489685L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_ToolBarButton_UU  UUID key
     * @param trxName Transaction
     */
    public MToolBarButton(Properties ctx, String AD_ToolBarButton_UU, String trxName) {
        super(ctx, AD_ToolBarButton_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param AD_ToolBarButton_ID
	 * @param trxName
	 */
	public MToolBarButton(Properties ctx, int AD_ToolBarButton_ID, String trxName) {
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

	/**
	 * Get process buttons (toolbar button with AD_Process_ID) of tab
	 * @param AD_Tab_ID
	 * @param trxName
	 * @return array of toolbar button model
	 */
	public static MToolBarButton[] getProcessButtonOfTab(int AD_Tab_ID, String trxName) {
		MToolBarButton[] buttons = new MToolBarButton[0];

		Query query = new Query(Env.getCtx(), MTable.get(Env.getCtx(), Table_ID), "AD_ToolBarButton.AD_Tab_ID=? AND AD_ToolBarButton.Action=? AND AD_ToolBarButton.AD_Process_ID IS NOT NULL", trxName)
				.addJoinClause("INNER JOIN AD_Process p ON (p.AD_Process_ID = AD_ToolBarButton.AD_Process_ID AND p.IsActive = 'Y')");

		List<MToolBarButton> list = query.setParameters(AD_Tab_ID, "W").setOnlyActiveRecords(true)
				.setOrderBy("CASE WHEN COALESCE(AD_ToolBarButton.SeqNo,0)=0 THEN AD_ToolBarButton.AD_ToolBarButton_ID ELSE AD_ToolBarButton.SeqNo END").list();
		if (list != null && !list.isEmpty()) {
			buttons = list.toArray(buttons);
		}
		
		return buttons;
	}

	/**
	 * Get toolbar buttons via action name
	 * @param action action name
	 * @param trxName
	 * @return array of toolbar button model
	 */
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
	
	/**
	 * Get advanced window toolbar button (Action=W)
	 * @return array of toolbar button model
	 */
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
	
	/**
	 * Is search query button
	 * @return true if it is search query button
	 */
	public boolean isSearchQueryComponent() {
		return "b01e8ec6-1a3c-4f94-928b-4582e2c33f81".equals(getAD_ToolBarButton_UU());
	}
}
