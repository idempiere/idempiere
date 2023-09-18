package org.adempiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.Query;
import org.compiere.model.X_AD_Tab_Customization;
import org.compiere.util.Util;

public class MTabCustomization extends X_AD_Tab_Customization {
    /**
	 * 
	 */
	private static final long serialVersionUID = 7401493734354775112L;

	/**
    * UUID based Constructor
    * @param ctx  Context
    * @param AD_Tab_Customization_UU  UUID key
    * @param trxName Transaction
    */
    public MTabCustomization(Properties ctx, String AD_Tab_Customization_UU, String trxName) {
        super(ctx, AD_Tab_Customization_UU, trxName);
    }

	public MTabCustomization(Properties ctx, int AD_Tab_Customization_ID, String trxName) {
		super(ctx, AD_Tab_Customization_ID, trxName);
	}

	public MTabCustomization(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * 
	 * @param ctx
	 * @param AD_User_ID
	 * @param AD_Tab_ID
	 * @param trxName
	 */
	public static MTabCustomization get(Properties ctx, int AD_User_ID, int AD_Tab_ID, String trxName) {
		return get(ctx, AD_User_ID, AD_Tab_ID, trxName, false);
	}

	/**
	 * @param ctx
	 * @param AD_User_ID
	 * @param AD_Tab_ID
	 * @param trxName
	 * @param isQuickForm
	 * @return
	 */
	public static MTabCustomization get(Properties ctx, int AD_User_ID, int AD_Tab_ID, String trxName, boolean isQuickForm) {
		Query query = new Query(ctx, Table_Name, "AD_User_ID=? AND AD_Tab_ID=? AND IsQuickForm=?", trxName);
		return query.setClient_ID().setParameters(new Object[] { AD_User_ID, AD_Tab_ID, (isQuickForm ? "Y" : "N") }).first();
	}

	/**
	 * Save Tab Customization Data
	 *
	 * @param ctx - Context
	 * @param AD_Tab_ID - Tab ID
	 * @param AD_User_ID - User ID
	 * @param Custom - Customized Field IDs with it's Size
	 * @param DisplayedGrid - Default preference of Grid view
	 * @param trxName - Transaction
	 * @param isQuickForm - Is Quick Form
	 * @return True if save successfully
	 */
	public static boolean saveData(Properties ctx, int AD_Tab_ID, int AD_User_ID, String Custom, String DisplayedGrid, String trxName, boolean isQuickForm) {
		return saveData(ctx, AD_Tab_ID, AD_User_ID, Custom, DisplayedGrid, trxName, isQuickForm, null);
	}
	
	/**
	 * Save Tab Customization Data
	 *
	 * @param ctx - Context
	 * @param AD_Tab_ID - Tab ID
	 * @param AD_User_ID - User ID
	 * @param Custom - Customized Field IDs with it's Size
	 * @param DisplayedGrid - Default preference of Grid view
	 * @param trxName - Transaction
	 * @param isQuickForm - Is Quick Form
	 * @param isAutoHide - is auto hide empty column
	 * @return True if save successfully
	 */
	public static boolean saveData(Properties ctx, int AD_Tab_ID, int AD_User_ID, String Custom, String DisplayedGrid, String trxName, boolean isQuickForm, String isAutoHide) {
		MTabCustomization tabCust = get(ctx, AD_User_ID, AD_Tab_ID, trxName, isQuickForm);

		if (tabCust != null && tabCust.getAD_Tab_Customization_ID() > 0)
		{
			tabCust.setCustom(Custom);
			tabCust.setIsDisplayedGrid(DisplayedGrid);
			tabCust.setIsAutoHideEmptyColumn(isAutoHide);
		}
		else
		{
			tabCust = new MTabCustomization(ctx, 0, trxName);
			tabCust.setAD_Tab_ID(AD_Tab_ID);
			tabCust.setAD_User_ID(AD_User_ID);
			tabCust.setCustom(Custom);
			tabCust.setIsDisplayedGrid(DisplayedGrid);
			tabCust.setIsQuickForm(isQuickForm);
			tabCust.setIsAutoHideEmptyColumn(isAutoHide);
		}

		if (Util.isEmpty(tabCust.getCustom(), true))
			return tabCust.delete(true);
		return tabCust.save();
	} // saveTabCustomization

}
