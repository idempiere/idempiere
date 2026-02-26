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
 **********************************************************************/
package org.idempiere.acct.service;

import java.util.Properties;

import org.adempiere.base.acct.AcctModelService;
import org.adempiere.base.acct.model.IElementModel;
import org.adempiere.base.acct.service.IElementModelService;
import org.compiere.model.MClient;
import org.idempiere.acct.model.MElement;
import org.idempiere.base.acct.ElementModel;

/**
 * Implementation of {@link IElementModelService}.
 * 
 * @author etantg
 */
@AcctModelService(IElementModelService.class)
public class ElementModelService implements IElementModelService {

	@Override
	public IElementModel create(Properties ctx, int C_Element_ID, String trxName) {
		MElement element = new MElement(ctx, C_Element_ID, trxName);
		return ElementModel.wrap(element);
	}

	@Override
	public IElementModel create(MClient client, String Name, String ElementType, int AD_Tree_ID) {
		MElement element = new MElement(client, Name, ElementType, AD_Tree_ID);
		return ElementModel.wrap(element);
	}

}
