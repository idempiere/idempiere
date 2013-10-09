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

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.compiere.model.I_AD_Role_OrgAccess;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Role;
import org.compiere.model.X_AD_Role_OrgAccess;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class OrgRoleElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Role_OrgAccess.Table_Name);

		X_AD_Role_OrgAccess po = findPO(ctx, element);
		if (po == null) {
			po = new X_AD_Role_OrgAccess(ctx.ctx, 0, getTrxName(ctx));
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

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_Org_ID = Env.getContextAsInt(ctx.ctx, "AD_Org_ID");
		int AD_Role_ID = Env.getContextAsInt(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID);
		
		Query query = new Query(ctx.ctx, "AD_Role_OrgAccess", "AD_Role_ID=? and AD_Org_ID=?", getTrxName(ctx));
		X_AD_Role_OrgAccess po = query.setParameters(new Object[]{AD_Role_ID, AD_Org_ID}).<X_AD_Role_OrgAccess>first();
		if (po != null) {
			if (!isPackOutElement(ctx, po))
				return;
			
			verifyPackOutRequirement(po);
			
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_Role_OrgAccess.Table_Name, atts);
			createOrgAccessBinding(ctx, document, po);
			document.endElement("", "", I_AD_Role_OrgAccess.Table_Name);
		}
	}

	private void createOrgAccessBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Role_OrgAccess po) {
		PoExporter filler = new PoExporter(ctx, document, po);

		List<String> excludes = defaultExcludeList(X_AD_Role_OrgAccess.Table_Name);
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		create(packout.getCtx(), packoutHandler);
	}
}
