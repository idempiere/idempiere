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
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.compiere.model.I_AD_Role;
import org.compiere.model.I_AD_Window_Access;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Role;
import org.compiere.model.X_AD_Window;
import org.compiere.model.X_AD_Window_Access;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class WindowAccessElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element) throws SAXException {
		int roleid =0;
		int windowid =0;
		List<String> excludes = defaultExcludeList(X_AD_Window_Access.Table_Name);

		X_AD_Window_Access po = findPO(ctx, element);
		if (po == null) {			
			if (getParentId(element, I_AD_Role.Table_Name) > 0) {
				roleid = getParentId(element, I_AD_Role.Table_Name);
			} else {
				Element roleElement = element.properties.get(I_AD_Window_Access.COLUMNNAME_AD_Role_ID);
				roleid = ReferenceUtils.resolveReference(ctx, roleElement);
			}
			if (roleid <= 0) {
				element.defer = true;
				return;
			}
	
			Element windowElement = element.properties.get(I_AD_Window_Access.COLUMNNAME_AD_Window_ID);
			windowid = ReferenceUtils.resolveReference(ctx, windowElement);
			if (windowid <= 0)  {
				element.defer = true;
				return;
			}
	
			Query query = new Query(ctx, "AD_Window_Access", "AD_Role_ID=? and AD_Window_ID=?", getTrxName(ctx));
			po = query.setParameters(new Object[]{roleid, windowid}).first();
			if (po == null) {
				po = new X_AD_Window_Access(ctx, 0, getTrxName(ctx));
				po.setAD_Role_ID(roleid);
				po.setAD_Window_ID(windowid);
			}
		}
		PoFiller filler = new PoFiller(ctx, po, element, this);
		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			return;
		}
		po.saveEx();
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_Window_ID = Env.getContextAsInt(ctx, X_AD_Window.COLUMNNAME_AD_Window_ID);
		int AD_Role_ID = Env.getContextAsInt(ctx, X_AD_Role.COLUMNNAME_AD_Role_ID);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_Window_Access.Table_Name, atts);
		createWindowAccessBinding(ctx, document, AD_Window_ID, AD_Role_ID);
		document.endElement("", "", I_AD_Window_Access.Table_Name);
	}

	private void createWindowAccessBinding(Properties ctx, TransformerHandler document,
			int window_id, int role_id) {

		Query query = new Query(ctx, "AD_Window_Access", "AD_Role_ID=? and AD_Window_ID=?", getTrxName(ctx));
		X_AD_Window_Access po = query.setParameters(new Object[]{role_id, window_id}).first();
		PoExporter filler = new PoExporter(ctx, document, po);
		List<String> excludes = defaultExcludeList(X_AD_Window_Access.Table_Name);

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
