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
import org.compiere.model.X_AD_User;
import org.compiere.model.X_AD_User_Roles;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class UserRoleElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element) throws SAXException {
		int roleid =0;
		int userid =0;
		int orgid =0;

		List<String> excludes = defaultExcludeList(X_AD_User_Roles.Table_Name);

		String userName = getStringValue(element, "AD_User.Name", excludes);
		userid = DB.getSQLValue(getTrxName(ctx), "SELECT AD_User_ID FROM AD_User WHERE Name = ? AND AD_Client_ID = ?", userName, Env.getAD_Client_ID(ctx));

		String roleName = getStringValue(element, "rolename", excludes);
		if (getParentId(element, "role") > 0) {
			roleid = getParentId(element, "role");
		} else {
			roleid = DB.getSQLValue(getTrxName(ctx), "SELECT AD_Role_ID FROM AD_Role WHERE Name= ? AND AD_Client_ID = ?", roleName, Env.getAD_Client_ID(ctx));
		}

		String orgName = getStringValue(element, "AD_Org.Name", excludes);
		orgid = DB.getSQLValue(getTrxName(ctx), "SELECT AD_Org_ID FROM AD_Org WHERE Name = ? AND AD_Client_ID = ?", orgName, Env.getAD_Client_ID(ctx));

		Query query = new Query(ctx, "AD_User_Roles", "AD_User_ID = ? AND AD_Role_ID = ? AND AD_Org_ID = ?", getTrxName(ctx));
		X_AD_User_Roles po = query.setParameters(new Object[]{userid, roleid, orgid}).first();
		if (po == null) {
			po = new X_AD_User_Roles(ctx, 0, getTrxName(ctx));
			po.setAD_Org_ID(orgid);
			po.setAD_Role_ID(roleid);
			po.setAD_User_ID(userid);
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
		int AD_User_ID = Env.getContextAsInt(ctx, X_AD_User.COLUMNNAME_AD_User_ID);
		int AD_Role_ID = Env.getContextAsInt(ctx, X_AD_Role.COLUMNNAME_AD_Role_ID);
		int AD_Org_ID = Env.getContextAsInt(ctx, "AD_Org_ID");
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.user-role");
		document.startElement("", "", "userRole", atts);
		createUserAssignBinding(ctx, document, AD_User_ID,AD_Role_ID, AD_Org_ID);
		document.endElement("", "", "userRole");
	}

	private void createUserAssignBinding(Properties ctx, TransformerHandler document,
			int user_id, int role_id, int org_id) {

		Query query = new Query(ctx, "AD_User_Roles", "AD_User_ID = ? AND AD_Role_ID = ? AND AD_Org_ID = ?", getTrxName(ctx));
		X_AD_User_Roles po = query.setParameters(new Object[]{user_id, role_id, org_id}).first();
		PoExporter filler = new PoExporter(ctx, document, po);
		List<String> excludes = defaultExcludeList(X_AD_User_Roles.Table_Name);

		filler.export(excludes);
	}
}
