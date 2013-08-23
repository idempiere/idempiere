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
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PoFiller;
import org.compiere.model.I_AD_Form_Access;
import org.compiere.model.MFormAccess;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Form;
import org.compiere.model.X_AD_Form_Access;
import org.compiere.model.X_AD_Role;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class FormAccessElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Form_Access.Table_Name);

		MFormAccess po = findPO(ctx, element);
		if (po == null) {
			po = new MFormAccess(ctx.ctx, 0, getTrxName(ctx));
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
		int AD_Form_ID = Env.getContextAsInt(ctx.ctx, X_AD_Form.COLUMNNAME_AD_Form_ID);
		int AD_Role_ID = Env.getContextAsInt(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID);
		
		MFormAccess po = null;
		Query query = new Query(ctx.ctx, "AD_Form_Access", "AD_Form_ID = ? AND AD_Role_ID = ?", getTrxName(ctx));
		po = query.setParameters(new Object[]{AD_Form_ID, AD_Role_ID}).<MFormAccess>first();

		if (po != null) {

			if (ctx.packOut.getFromDate() != null) {
				if (po.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
					return;
				}
			}
			
			verifyPackOutRequirement(po);
			
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_Form_Access.Table_Name, atts);
			createFormAccessBinding(ctx, document, po);
			document.endElement("", "", I_AD_Form_Access.Table_Name);
		}
	}

	private void createFormAccessBinding(PIPOContext ctx, TransformerHandler document,
			MFormAccess po) {
		PoExporter filler = new PoExporter(ctx, document, po);
		List<String> excludes = defaultExcludeList(X_AD_Form_Access.Table_Name);
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
	}

}
