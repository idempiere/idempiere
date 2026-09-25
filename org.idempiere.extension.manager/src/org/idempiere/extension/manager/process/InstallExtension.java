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
import org.adempiere.util.Callback;
import org.compiere.model.MExtension;
import org.compiere.model.MExtensionEntity;
import org.compiere.model.Query;
import org.compiere.process.SvrProcess;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.extension.manager.ExtensionManagerActivator;
import org.idempiere.extension.manager.form.ExtensionBrowserService;
import org.idempiere.extension.manager.form.ExtensionMetadata;
import org.osgi.framework.BundleContext;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Process
public class InstallExtension extends SvrProcess {
	

	public InstallExtension() {
	}

	@Override
	protected void prepare() {
	}

	@Override
	protected String doIt() throws Exception {
		MExtension extension = new MExtension(Env.getCtx(), getRecord_ID(), null);
		if (extension.getAD_Extension_ID() != getRecord_ID() || getRecord_ID() == 0) {
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FillMandatory") + Msg.getElement(Env.getCtx(), "AD_Extension_ID"));
		}
		
		JsonObject metadata = JsonParser.parseString(extension.getExtensionMetadata()).getAsJsonObject();
		var extensionMetadata = new ExtensionMetadata(metadata);
		var service = new ExtensionBrowserService();		
		
		// Check whether the extension have been uninstall earlier
		Query query = new Query(Env.getCtx(), MExtensionEntity.Table_Name, "AD_Extension_ID=?", null);
		int count = query.setParameters(extension.getAD_Extension_ID())
			.setOnlyActiveRecords(true)
			.count();
		if (count > 0) {
			service.enableExtensionEntities(extension);
		}

		// Validate Required Fields
		if (!extensionMetadata.hasVersion() || !extensionMetadata.hasIDempiereVersion()
				|| !extensionMetadata.hasName() || !extensionMetadata.hasBundles()) {
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "ExtensionMetadataMissingRequiredFields"));
		}
		
		JsonArray bundlesJson = extensionMetadata.getBundles();
		if (bundlesJson.size() == 0) {
			//No bundles found in metadata.json
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NoBundlesInExtensionMetadata")); 
		}
		
		// Compatibility Check
		service.validateIDempiereVersion(extensionMetadata);
		service.validateDependencies(extensionMetadata);
				
		String dbError = service.validateDatabaseRequirement(extensionMetadata);
		if (dbError != null) {
			throw new AdempiereException(dbError);
		}
						
		BundleContext context = ExtensionManagerActivator.context;
		if (context == null) {
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "BundleContextNotFound"));
		}
		
		if (!extension.getExtensionState().equals(MExtension.EXTENSIONSTATE_Installing)) {
			extension.setExtensionState(MExtension.EXTENSIONSTATE_Installing);
			extension.saveEx();
		}

		Callback<String> statusCallback = (msg) -> {
			if (processUI != null)
				processUI.statusUpdate(msg);
			addLog(msg);
		};
			
		try {
			service.installExtension(extensionMetadata, statusCallback);
		} finally {
			extension.load(null);
			if (extension.getExtensionState().equals(MExtension.EXTENSIONSTATE_Installing)) {
				extension.setExtensionState(MExtension.EXTENSIONSTATE_Error);
				extension.saveEx();
			}
		}

		return "@ExtensionInstallSuccessfully@";
	}	
}
