/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Dirk Niemeyer                                           *
 * Copyright (C) 2012 action 42 GmbH                                          *
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

import java.util.Properties;

import org.adempiere.model.GridTabWrapper;
import org.compiere.util.Env;


/**
 *	Window Customization Callout
 *	
 *  @author Dirk Niemeyer, action42 GmbH
 */
public class CalloutWindowCustomization extends CalloutEngine
{
	/**
	 *	Set fields to current values from DB for selected window.
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String window (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer AD_Window_ID = (Integer)value;
		if (AD_Window_ID == null || AD_Window_ID.intValue() == 0)
			return "";

		I_AD_UserDef_Win ud_win = GridTabWrapper.create(mTab, I_AD_UserDef_Win.class);
		
		MWindow window = new MWindow(Env.getCtx(),AD_Window_ID, null);
		String lang = (String)mTab.getValue("AD_Language");

		ud_win.setName(window.get_Translation("Name", lang));
		ud_win.setDescription(window.get_Translation("Description", lang));
		ud_win.setHelp(window.get_Translation("Help", lang));
		
		//  what for?
		ud_win.setIsDefault(window.isDefault()); 
		
		// default from menu, actual from role
		//  Read Only
		//  User updateable
		
		return NO_ERROR;
	}	//	window
	
	/**
	 *	Set fields to current values from DB for selected Tab
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String tab (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer p_AD_Tab_ID = (Integer)value;
		if (p_AD_Tab_ID == null || p_AD_Tab_ID.intValue() == 0)
			return "";

		I_AD_UserDef_Tab ud_tab = GridTabWrapper.create(mTab, I_AD_UserDef_Tab.class);
		
		MTab tab = new MTab(Env.getCtx(),p_AD_Tab_ID, null);
		String lang = Env.getContext(ctx, WindowNo, "AD_Language");

		ud_tab.setName(tab.get_Translation("Name", lang));
		ud_tab.setDescription(tab.get_Translation("Description", lang));
		ud_tab.setHelp(tab.get_Translation("Help", lang));
		
		ud_tab.setIsSingleRow(tab.isSingleRow()); 
		ud_tab.setIsReadOnly(tab.isReadOnly()); 

		return NO_ERROR;
	}	//	tab
	
	/**
	 *	Set fields to current values from DB for selected Tab
	 *	@param ctx context
	 *	@param WindowNo window no
	 *	@param mTab tab
	 *	@param mField field
	 *	@param value value
	 *	@return null or error message
	 */
	public String field (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer p_AD_Field_ID = (Integer)value;
		if (p_AD_Field_ID == null || p_AD_Field_ID.intValue() == 0)
			return "";

		I_AD_UserDef_Field ud_field = GridTabWrapper.create(mTab, I_AD_UserDef_Field.class);

		MField field = new MField(ctx, p_AD_Field_ID, null);
		String lang = Env.getContext(ctx, WindowNo, "AD_Language");

		ud_field.setName(field.get_Translation("Name", lang));
		ud_field.setDescription(field.get_Translation("Description", lang));
		ud_field.setHelp(field.get_Translation("Help", lang));
		//IDEMPIERE-163 / do not inherit configuration from field - all configuration was made nullable, if null it inherit the field/column config

		return NO_ERROR;
	}	//	field

}	//	CalloutClient
