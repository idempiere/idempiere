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
 **********************************************************************/
package org.idempiere.extension.manager.process;

import org.adempiere.base.annotation.Process;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MExtension;
import org.compiere.process.SvrProcess;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.extension.manager.form.ExtensionBrowserService;
import org.idempiere.extension.manager.form.ExtensionMetadata;

import com.google.gson.JsonParser;

@Process
public class UninstallExtension extends SvrProcess {

	public UninstallExtension() {
	}

	@Override
	protected void prepare() {
	}

	@Override
	protected String doIt() throws Exception {
		MExtension extension = new MExtension(Env.getCtx(), getRecord_ID(), get_TrxName());
		if (extension.getAD_Extension_ID() != getRecord_ID() || getRecord_ID() == 0) {
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FillMandatory") + Msg.getElement(Env.getCtx(), "AD_Extension_ID"));
		}
		ExtensionMetadata metadata = new ExtensionMetadata(JsonParser.parseString(extension.getExtensionMetadata()).getAsJsonObject());
		ExtensionBrowserService service = new ExtensionBrowserService();
		service.validateNoDependentExtensions(metadata);
		service.uninstallExtension(metadata);
		return "@ExtensionUninstallSuccessfully@";
	}

}
