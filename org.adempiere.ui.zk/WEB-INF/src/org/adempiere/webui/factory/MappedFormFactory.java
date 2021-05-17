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
 * - matheus.marcelino                								   *
 **********************************************************************/

package org.adempiere.webui.factory;

/**
 *
 * @author matheus.marcelino
 *
 */
import org.adempiere.base.MappedByNameFactory;
import org.adempiere.webui.panel.ADForm;
import org.osgi.service.component.annotations.Component;

@Component(name = "org.adempiere.webui.factory.MappedFormFactory",
immediate = true,
service = {IFormFactory.class, IMappedFormFactory.class},
property = {"service.ranking:Integer=1"})
public class MappedFormFactory extends MappedByNameFactory<ADForm> implements IFormFactory, IMappedFormFactory {

	public MappedFormFactory() {
	}

	@Override
	public ADForm newFormInstance(String formName) {
		return newInstance(formName);
	}

}
