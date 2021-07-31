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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.report.jasper;

import java.util.Collections;
import java.util.Enumeration;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.Set;

import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Resource bundle wrapper for {@link Msg#translate(String, boolean, String)}
 * @author hengsin
 *
 */
public class MsgResourceBundle extends ResourceBundle {

	private ResourceBundle overridingResourceBundle;
	private Locale locale;
	private String adLanguage;
	private boolean isSOTrx;
	
	/**
	 * 
	 * @param overridingResourceBundle
	 */
	public MsgResourceBundle(ResourceBundle overridingResourceBundle) {
		this(overridingResourceBundle, Env.getLocale(Env.getCtx()), Env.getAD_Language(Env.getCtx()), Env.isSOTrx(Env.getCtx()));
	}

	/**
	 * 
	 * @param overridingResourceBundle
	 * @param locale
	 * @param adLanguage
	 * @param isSOTrx
	 */
	public MsgResourceBundle(ResourceBundle overridingResourceBundle, Locale locale, String adLanguage, boolean isSOTrx) {
		this.overridingResourceBundle = overridingResourceBundle;
		this.locale = locale;
		this.adLanguage = adLanguage;
		this.isSOTrx = isSOTrx;
	}
	
	@Override
	protected Object handleGetObject(String key) {
		if (overridingResourceBundle != null && overridingResourceBundle.containsKey(key)) {
			return overridingResourceBundle.getObject(key);
		}
		return Msg.translate(adLanguage, isSOTrx, key);
	}

	@Override
	public Enumeration<String> getKeys() {	
		Set<String> set = null;
		if (overridingResourceBundle != null) {
			set = overridingResourceBundle.keySet();
		}
		if (set == null)
			set = Msg.get().getMsgMap(adLanguage).keySet();
		else			
			set.addAll(Msg.get().getMsgMap(adLanguage).keySet());
		set.addAll(Msg.get().getElementMap(adLanguage).keySet());
		return Collections.enumeration(set);
	}

	@Override
	public Locale getLocale() {
		return this.locale;
	}

	@Override
	public String getBaseBundleName() {
		return getClass().getName();
	}

	@Override
	public boolean containsKey(String key) {
		if (overridingResourceBundle != null) {
			if (overridingResourceBundle.containsKey(key))
				return true;
		}
		return Msg.hasTranslation(adLanguage, key);
	}	
}
