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
 * - Nicolas Micoud (TGI)		                                       *
 **********************************************************************/

package org.adempiere.webui.util;


import java.util.HashMap;
import java.util.Map;

import org.adempiere.webui.ClientInfo;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.zkforge.ckez.CKeditor;

/**
 * Helper class for {@link CKeditor}
 * @author Nicolas Micoud (TGI)
 *
 */
public class CKEditor
{
	public static CKeditor get() {
		return get(ClientInfo.isMobile());
	}

	public static CKeditor get(boolean isMobile) {
		CKeditor editor = new CKeditor();
		editor.setCustomConfigurationsPath(getCustomConfigurationsPath(isMobile));
		editor.setToolbar(getToolbar());
		editor.setConfig(getLanguage());
		return editor;
	}

	public static String getCustomConfigurationsPath(boolean isMobile) {
		if (isMobile)
			return MSysConfig.getValue(MSysConfig.CKEDITOR_FILE_CONFIG_MIN, "/js/ckeditor/config-min.js", Env.getAD_Client_ID(Env.getCtx()));
		else
			return MSysConfig.getValue(MSysConfig.CKEDITOR_FILE_CONFIG, "/js/ckeditor/config.js", Env.getAD_Client_ID(Env.getCtx()));
	}

	public static Map<String,Object> getLanguage() {
		Map<String,Object> lang = new HashMap<String,Object>();
		lang.put("language", Language.getLoginLanguage().getAD_Language());
		return lang;
	}

	public static String getToolbar() {
		return "MyToolbar";
	}
}