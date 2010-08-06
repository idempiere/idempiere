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

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Process;
import org.compiere.model.I_AD_Process_Para;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Process_Para;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ProcessParaElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Process_Para.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {
			if (isParentDefer(element, I_AD_Process.Table_Name)) {
				element.defer = true;
				return;
			}

			X_AD_Process_Para mProcessPara = findPO(ctx, element);
			if (mProcessPara == null) {
				String name = getStringValue(element, "Name");

				int id = 0;
				int masterId = 0;
				if (getParentId(element, I_AD_Process.Table_Name) > 0) {
					masterId = getParentId(element, "process");
				} else {
					Element processElement = element.properties.get(I_AD_Process_Para.COLUMNNAME_AD_Process_ID);
					masterId = ReferenceUtils.resolveReference(ctx, processElement);
				}
				if (masterId <= 0) {
					element.defer = true;
					element.unresolved = "AD_Process: " + getStringValue(element, I_AD_Process_Para.COLUMNNAME_AD_Process_ID);
					return;
				}

				id = findIdByColumnAndParentId(ctx, "AD_Process_Para", "Name", name, "AD_Process", masterId);
				mProcessPara = new X_AD_Process_Para(ctx, id > 0 ? id : 0, getTrxName(ctx));
				mProcessPara.setAD_Process_ID(masterId);
				excludes.add(I_AD_Process_Para.COLUMNNAME_AD_Process_ID);
			}
									
			if (mProcessPara.getAD_Process_Para_ID() == 0 && isOfficialId(element, "AD_Process_Para_ID"))
				mProcessPara.setAD_Process_Para_ID(Integer.parseInt(getStringValue(element, "AD_Process_Para_ID")));
			
			PoFiller filler = new PoFiller(ctx, mProcessPara, element, this);
			
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}

			if (mProcessPara.is_new() || mProcessPara.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Process_Para.Table_Name,
						X_AD_Process_Para.Table_ID);
				String action = null;
				if (!mProcessPara.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Process_Para.Table_Name,
							mProcessPara);
					action = "Update";
				} else {
					action = "New";
				}
				if (mProcessPara.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mProcessPara.getName(),
							mProcessPara.get_ID(), action);
				} else {
					logImportDetail(ctx, impDetail, 0, mProcessPara.getName(),
							mProcessPara.get_ID(), action);
					throw new POSaveFailedException("ProcessPara");
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_Process_Para_ID = Env.getContextAsInt(ctx,
				X_AD_Process_Para.COLUMNNAME_AD_Process_Para_ID);
		X_AD_Process_Para m_Processpara = new X_AD_Process_Para(ctx,
				AD_Process_Para_ID, getTrxName(ctx));

		if (m_Processpara.getAD_Element_ID() > 0) {
			PackOut packOut = getPackOutProcess(ctx);
			ElementHandler handler = packOut.getHandler("ELE");
			try {
				handler.packOut(packOut,document,null,m_Processpara.getAD_Element_ID());
			} catch (Exception e) {
				throw new AdempiereException(e);
			}
		}
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_Process_Para.Table_Name, atts);
		createProcessParaBinding(ctx, document, m_Processpara);
		document.endElement("", "", I_AD_Process_Para.Table_Name);
	}

	private void createProcessParaBinding(Properties ctx, TransformerHandler document,
			X_AD_Process_Para m_Processpara) {

		PoExporter filler = new PoExporter(ctx, document, m_Processpara);
		List<String> excludes = defaultExcludeList(X_AD_Process_Para.Table_Name);

		if (m_Processpara.getAD_Process_Para_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_Process_Para_ID", new AttributesImpl());
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		// TODO Auto-generated method stub
		
	}
}
