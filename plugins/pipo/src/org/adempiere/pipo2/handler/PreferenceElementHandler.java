/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com
 * Contributor(s): Low Heng Sin hengsin@avantz.com
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.util.List;
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MPreference;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Preference;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class PreferenceElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {

		MPreference m_Preference = new MPreference(ctx, 0, getTrxName(ctx));
		List<String> excludes = defaultExcludeList(X_AD_Preference.Table_Name);
		PoFiller filler = new PoFiller(ctx, m_Preference, element, this);
		List<String> notFounds = filler.autoFill(excludes);
		if (notFounds.size() > 0) {
			element.defer = true;
			return;
		}

		Query query = new Query(ctx, "AD_Preference", "Attribute = ? AND coalesce(AD_User_ID,0) = ? AND coalesce(AD_Window_ID,0) = ?", getTrxName(ctx));
		MPreference tmp = query
							.setParameters(new Object[]{m_Preference.getAttribute(), m_Preference.getAD_User_ID(), m_Preference.getAD_Window_ID()})
							.first();
		if (tmp != null) {
			filler = new PoFiller(ctx, tmp, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}
			m_Preference = tmp;
		}

		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Preference.Table_Name,
				X_AD_Preference.Table_ID);
		String Object_Status = null;
		int id = m_Preference.get_ID();
		if (id <= 0 && isOfficialId(element, "AD_Preference_ID"))
			m_Preference.setAD_Preference_ID(Integer.parseInt(getStringValue(element, "AD_Preference_ID")));

		if (id > 0) {
			backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Preference.Table_Name, m_Preference);
			Object_Status = "Update";
		} else {
			Object_Status = "New";
		}

		if (m_Preference.save(getTrxName(ctx)) == true) {
			logImportDetail(ctx, impDetail, 1, m_Preference.getAttribute(),
					m_Preference.get_ID(), Object_Status);
		} else {
			logImportDetail(ctx, impDetail, 0, m_Preference.getAttribute(),
					m_Preference.get_ID(), Object_Status);
			throw new POSaveFailedException("Failed to save Preference");
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_Preference_ID = Env.getContextAsInt(ctx,
				X_AD_Preference.COLUMNNAME_AD_Preference_ID);
		X_AD_Preference m_Preference = new X_AD_Preference(ctx,
				AD_Preference_ID, getTrxName(ctx));
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.preference");
		document.startElement("", "", "preference", atts);
		createPreferenceBinding(ctx, document, m_Preference);
		document.endElement("", "", "preference");
	}

	private void createPreferenceBinding(Properties ctx, TransformerHandler document,
			X_AD_Preference m_Preference) {
		PoExporter filler  = new PoExporter(ctx, document, m_Preference);
		List<String> excludes = defaultExcludeList(X_AD_Preference.Table_Name);

		if (m_Preference.getAD_Preference_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.addString("AD_Preference_ID", Integer.toString(m_Preference.getAD_Preference_ID()), new AttributesImpl());

		filler.export(excludes);
	}
}
