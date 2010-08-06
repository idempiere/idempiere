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
import org.compiere.model.I_AD_Preference;
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

		List<String> excludes = defaultExcludeList(X_AD_Preference.Table_Name);
		MPreference mPreference = findPO(ctx, element);
		if (mPreference == null) {
			mPreference = new MPreference(ctx, 0, getTrxName(ctx));			
			PoFiller filler = new PoFiller(ctx, mPreference, element, this);
			List<String> notFounds = filler.autoFill(excludes);
			if (notFounds.size() > 0) {
				element.defer = true;
				return;
			}

			Query query = new Query(ctx, "AD_Preference", "Attribute = ? AND coalesce(AD_User_ID,0) = ? AND coalesce(AD_Window_ID,0) = ?", getTrxName(ctx));
			MPreference tmp = query
								.setParameters(new Object[]{mPreference.getAttribute(), mPreference.getAD_User_ID(), mPreference.getAD_Window_ID()})
								.first();
			if (tmp != null) {
				filler = new PoFiller(ctx, tmp, element, this);
				List<String> notfounds = filler.autoFill(excludes);
				if (notfounds.size() > 0) {
					element.defer = true;
					return;
				}
				mPreference = tmp;
			}
		} else {
			PoFiller filler = new PoFiller(ctx, mPreference, element, this);
			List<String> notFounds = filler.autoFill(excludes);
			if (notFounds.size() > 0) {
				element.defer = true;
				return;
			}
		}
				
		if (mPreference.get_ID() == 0 && isOfficialId(element, "AD_Preference_ID"))
			mPreference.setAD_Preference_ID(Integer.parseInt(getStringValue(element, "AD_Preference_ID")));

		if (mPreference.is_new() || mPreference.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Preference.Table_Name,
					X_AD_Preference.Table_ID);
			String action = null;
			if (!mPreference.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Preference.Table_Name, mPreference);
				action = "Update";
			} else {
				action = "New";
			}
	
			if (mPreference.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mPreference.getAttribute(),
						mPreference.get_ID(), action);
			} else {
				logImportDetail(ctx, impDetail, 0, mPreference.getAttribute(),
						mPreference.get_ID(), action);
				throw new POSaveFailedException("Failed to save Preference");
			}
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
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_Preference.Table_Name, atts);
		createPreferenceBinding(ctx, document, m_Preference);
		document.endElement("", "", I_AD_Preference.Table_Name);
	}

	private void createPreferenceBinding(Properties ctx, TransformerHandler document,
			X_AD_Preference m_Preference) {
		PoExporter filler  = new PoExporter(ctx, document, m_Preference);
		List<String> excludes = defaultExcludeList(X_AD_Preference.Table_Name);

		if (m_Preference.getAD_Preference_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.addString("AD_Preference_ID", Integer.toString(m_Preference.getAD_Preference_ID()), new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
