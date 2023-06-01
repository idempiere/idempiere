/******************************************************************************
 * Copyright (C) 2019 devCoffee - #3858                                       *
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


/**
 *	Process Customization Callout
 *
 * @author raphael.gildo (devCoffee, www.devcoffee.com.br)
 */
public class CalloutProcessCustomization extends CalloutEngine
{

	/**
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return
	 */
	@Deprecated // removed from the column definition
	public String process (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if(value == null)
			return "";

		MProcess pp = new MProcess(ctx, (Integer) value, null);

		mTab.setValue("Name", pp.get_Translation("Name"));
		mTab.setValue("Description", pp.get_Translation("Description"));
		mTab.setValue("Help", pp.get_Translation("Help"));

		return NO_ERROR;
	}	//	proc parameter

	/**
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return
	 */
	public String processParameter (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		if(value == null)
			return "";

		MProcessPara pp = new MProcessPara(ctx, (Integer) value, null);
		mTab.setValue("IsRange", pp.isRange());

		return NO_ERROR;
	}	//	proc parameter

}	//	CalloutClient
