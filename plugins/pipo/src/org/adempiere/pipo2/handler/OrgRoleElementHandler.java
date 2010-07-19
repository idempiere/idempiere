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
import org.adempiere.pipo2.PoFiller;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Role;
import org.compiere.model.X_AD_Role_OrgAccess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class OrgRoleElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Role_OrgAccess.Table_Name);

		int roleId = 0;
		String roleName = getStringValue(element, "rolename", excludes);
		if (getParentId(element, "role") > 0) {
			roleId = getParentId(element, "role");
		} else {
			roleId = DB.getSQLValue(getTrxName(ctx), "SELECT AD_Role_ID FROM AD_Role WHERE Name = ? AND AD_Client_ID = ?", roleName, Env.getAD_Client_ID(ctx));
		}

		String orgName = getStringValue(element, "orgname", excludes);
		int orgId = DB.getSQLValue(getTrxName(ctx), "SELECT AD_Org_ID FROM AD_Org WHERE Name = ? AND AD_Client_ID = ?", orgName, Env.getAD_Client_ID(ctx));

		Query query = new Query(ctx, "AD_Role_OrgAccess", "AD_Role_ID=? and AD_Org_ID=?", getTrxName(ctx));
		X_AD_Role_OrgAccess po = query.setParameters(new Object[]{roleId, orgId})
									.setClient_ID()
									.<X_AD_Role_OrgAccess>first();

		if (po == null) {
			po = new X_AD_Role_OrgAccess(ctx, 0, getTrxName(ctx));
			po.setAD_Org_ID(orgId);
			po.setAD_Role_ID(roleId);
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
		int AD_Org_ID = Env.getContextAsInt(ctx, "AD_Org_ID");
		int AD_Role_ID = Env.getContextAsInt(ctx, X_AD_Role.COLUMNNAME_AD_Role_ID);
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.organization-role");
		document.startElement("", "", "OrgAccess", atts);
		createOrgAccessBinding(ctx, document, AD_Org_ID, AD_Role_ID);
		document.endElement("", "", "OrgAccess");

	}

	private void createOrgAccessBinding(Properties ctx, TransformerHandler document,
			int orgId, int roleId) {
		String sql = null;
		String name = null;

		Query query = new Query(ctx, "AD_Role_OrgAccess", "AD_Role_ID=? and AD_Org_ID=?", getTrxName(ctx));
		X_AD_Role_OrgAccess po = query.setParameters(new Object[]{roleId, orgId}).<X_AD_Role_OrgAccess>first();
		PoExporter filler = new PoExporter(ctx, document, po);
		sql = "SELECT Name FROM AD_Org WHERE AD_Org_ID=?";
		name = DB.getSQLValueString(null, sql, orgId);
		filler.addString("orgname", name, new AttributesImpl());

		sql = "SELECT Name FROM AD_Role WHERE AD_Role_ID=?";
		name = DB.getSQLValueString(null, sql, roleId);
		filler.addString("rolename", name, new AttributesImpl());

		List<String> excludes = defaultExcludeList(X_AD_Role_OrgAccess.Table_Name);
		excludes.add("AD_Org_ID");
		excludes.add("AD_Role_ID");
		filler.export(excludes);
	}
}
