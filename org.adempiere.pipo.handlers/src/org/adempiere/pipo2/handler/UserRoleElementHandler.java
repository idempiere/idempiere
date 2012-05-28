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
import org.adempiere.pipo2.ReferenceUtils;
import org.compiere.model.I_AD_User_Roles;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Role;
import org.compiere.model.X_AD_User;
import org.compiere.model.X_AD_User_Roles;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class UserRoleElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		int roleid =0;
		int userid =0;
		int orgid =0;

		List<String> excludes = defaultExcludeList(X_AD_User_Roles.Table_Name);

		X_AD_User_Roles po = findPO(ctx, element);
		if (po == null) {
			Element userElement = element.properties.get(I_AD_User_Roles.COLUMNNAME_AD_User_ID);
			userid = ReferenceUtils.resolveReference(ctx.ctx, userElement, getTrxName(ctx));
			if (userid <= 0) {
				element.defer = true;
				element.unresolved = "AD_User_ID " + (userElement.contents != null ? userElement.contents.toString() : "");
				return;
			}
			if (getParentId(element, X_AD_Role.Table_Name) > 0) {
				roleid = getParentId(element, X_AD_Role.Table_Name);
			} else {
				Element roleElement = element.properties.get("AD_Role_ID");
				roleid = ReferenceUtils.resolveReference(ctx.ctx, roleElement,
						getTrxName(ctx));
			}
			
			if (roleid <= 0) 
			{
				element.defer = true;
				element.unresolved = "AD_Role_ID";
				return;
			}

			Element orgElement = element.properties.get(I_AD_User_Roles.COLUMNNAME_AD_Org_ID);
			orgid = ReferenceUtils.resolveReference(ctx.ctx, orgElement, getTrxName(ctx));

			Query query = new Query(ctx.ctx, "AD_User_Roles", "AD_User_ID = ? AND AD_Role_ID = ? AND AD_Org_ID = ?", getTrxName(ctx));
			po = query.setParameters(new Object[]{userid, roleid, orgid}).first();
			if (po == null) {
				po = new X_AD_User_Roles(ctx.ctx, 0, getTrxName(ctx));
				po.setAD_Org_ID(orgid);
				po.setAD_Role_ID(roleid);
				po.setAD_User_ID(userid);
			}
			excludes.add(I_AD_User_Roles.COLUMNNAME_AD_User_ID);
			excludes.add(I_AD_User_Roles.COLUMNNAME_AD_Role_ID);
			excludes.add(I_AD_User_Roles.COLUMNNAME_AD_Org_ID);
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

	public void endElement(PIPOContext ctx, Element element)
			throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_User_ID = Env.getContextAsInt(ctx.ctx, X_AD_User.COLUMNNAME_AD_User_ID);
		int AD_Role_ID = Env.getContextAsInt(ctx.ctx, X_AD_Role.COLUMNNAME_AD_Role_ID);
		int AD_Org_ID = Env.getContextAsInt(ctx.ctx, "AD_Org_ID");
		Query query = new Query(ctx.ctx, "AD_User_Roles",
				"AD_User_ID = ? AND AD_Role_ID = ? AND AD_Org_ID = ?", getTrxName(ctx));
		X_AD_User_Roles po = query.setParameters(
				new Object[] { AD_User_ID, AD_Role_ID, AD_Org_ID }).first();
		if (po != null) {
			if (ctx.packOut.getFromDate() != null) {
				if (po.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
					return;
				}
			}
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_User_Roles.Table_Name, atts);
			createUserAssignBinding(ctx, document, po);
			document.endElement("", "", I_AD_User_Roles.Table_Name);
		}
	}

	private void createUserAssignBinding(PIPOContext ctx,
			TransformerHandler document, X_AD_User_Roles po) {
		PoExporter filler = new PoExporter(ctx, document, po);
		
		AttributesImpl orgRefAtts = new AttributesImpl();
		String orgReference = ReferenceUtils.getTableReference("AD_Org", "Name", po.getAD_Org_ID(), orgRefAtts);
		filler.addString("AD_Org_ID", orgReference, orgRefAtts);

		List<String> excludes = defaultExcludeList(X_AD_User_Roles.Table_Name);
		excludes.add("AD_Org_ID");

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		create(packout.getCtx(), packoutHandler);
	}
}
