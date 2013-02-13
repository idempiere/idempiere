/******************************************************************************
 * This file is part of Adempiere ERP Bazaar                                  *
 * http://www.adempiere.org                                                   *
 *                                                                            *
 * Copyright (C) Jorg Viola			                                          *
 * Copyright (C) Contributors												  *
 *                                                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * Contributors:                                                              *
 * - Heng Sin Low                                                             *
 *****************************************************************************/
package org.adempiere.client;

import java.util.List;

import org.adempiere.base.Service;
import org.adempiere.ui.swing.factory.IFormFactory;
import org.compiere.apps.form.FormPanel;

/**
 *
 * @author viola
 * @author hengsin
 */
public class Client {

	/**
	 * @param formId
	 * @return new form instance
	 */
	public static FormPanel getFormPanel(String formId) {
		List<IFormFactory> factories = Service.locator().list(IFormFactory.class).getServices();
		if (factories != null) {
			for(IFormFactory factory : factories) {
				FormPanel form = factory.newFormInstance(formId);
				if (form != null)
					return form;
			}
		}
		return null;
	}

}
