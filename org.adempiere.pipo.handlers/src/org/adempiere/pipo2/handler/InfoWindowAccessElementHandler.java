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
 * - Carlos Ruiz (globalqss) - sponsored by FH                         *
 **********************************************************************/

package org.adempiere.pipo2.handler;

import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.compiere.model.I_AD_InfoWindow_Access;
import org.compiere.model.Query;
import org.compiere.model.X_AD_InfoWindow;
import org.compiere.model.X_AD_InfoWindow_Access;
import org.compiere.model.X_AD_Role;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class InfoWindowAccessElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_InfoWindow_Access.Table_Name);

		X_AD_InfoWindow_Access po = findPO(ctx, element);
		if (po == null) {
			po = new X_AD_InfoWindow_Access(ctx.ctx, 0, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, po, element, this);
		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}
		po.saveEx();
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_InfoWindow_ID = Env.getContextAsInt(ctx.ctx, X_AD_InfoWindow.COLUMNNAME_AD_InfoWindow_ID);
		int AD_Role_ID = Env.getContextAsInt(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID);
		Query query = new Query(ctx.ctx, "AD_InfoWindow_Access", "AD_Role_ID=? AND AD_InfoWindow_ID=?", getTrxName(ctx));
		X_AD_InfoWindow_Access po = query.setParameters(AD_Role_ID, AD_InfoWindow_ID).first();
		if (po != null) {
			if (!isPackOutElement(ctx, po))
				return;
			verifyPackOutRequirement(po);
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_InfoWindow_Access.Table_Name, atts);
			createInfoWindowAccessBinding(ctx, document, po);
			document.endElement("", "", I_AD_InfoWindow_Access.Table_Name);
		}
	}

	private void createInfoWindowAccessBinding(PIPOContext ctx, TransformerHandler document, X_AD_InfoWindow_Access po) {
		PoExporter filler = new PoExporter(ctx, document, po);
		List<String> excludes = defaultExcludeList(X_AD_InfoWindow_Access.Table_Name);
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId)
			throws Exception {
		throw new AdempiereException("AD_InfoWindow_Access doesn't have ID, use method with UUID");
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId, String uuid) throws Exception {
		X_AD_InfoWindow_Access po = new Query(packout.getCtx().ctx, X_AD_InfoWindow_Access.Table_Name, "AD_InfoWindow_Access_UU=?", getTrxName(packout.getCtx()))
				.setParameters(uuid)
				.first();
		if (po != null) {
			Env.setContext(packout.getCtx().ctx, X_AD_InfoWindow.COLUMNNAME_AD_InfoWindow_ID, po.getAD_InfoWindow_ID());
			Env.setContext(packout.getCtx().ctx, X_AD_Role.COLUMNNAME_AD_Role_ID, po.getAD_Role_ID());
			this.create(packout.getCtx(), packoutHandler);
			packout.getCtx().ctx.remove(X_AD_InfoWindow.COLUMNNAME_AD_InfoWindow_ID);
			packout.getCtx().ctx.remove(X_AD_Role.COLUMNNAME_AD_Role_ID);
		} else {
			throw new AdempiereException("AD_InfoWindow_Access_UU not found = " + uuid);
		}
	}
}
