package org.adempiere.pipo2.handler;

import java.util.ArrayList;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MViewColumn;
import org.compiere.model.MViewComponent;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ViewComponentElementHandler extends AbstractElementHandler {

	private List<Integer> viewComponents = new ArrayList<Integer>();
	
	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {			
			MViewComponent mViewComponent = findPO(ctx, element);
			if (mViewComponent == null) {
				int id = 0;
				if (!hasUUIDKey(ctx, element)) {
					String name = getStringValue(element, "Name");
					id = findIdByColumn(ctx, "AD_ViewComponent_ID", "Name", name, true);
				}
				mViewComponent = new MViewComponent(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
			}
			PoFiller filler = new PoFiller(ctx, mViewComponent, element, this);
			List<String> excludes = defaultExcludeList(MViewComponent.Table_Name);
			if (mViewComponent.getAD_ViewComponent_ID() == 0 && isOfficialId(element, "AD_ViewComponent_ID"))
				mViewComponent.setAD_ViewComponent_ID(getIntValue(element, "AD_ViewComponent_ID"));
			
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
	
			if (mViewComponent.is_new() || mViewComponent.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, MViewComponent.Table_Name, MViewComponent.Table_ID);		
				String action = null;
				if (!mViewComponent.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), MViewComponent.Table_Name, mViewComponent);
					action = "Update";
				} else {
					action = "New";
				}
				if (mViewComponent.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mViewComponent.getName(), mViewComponent.get_ID(), action);
					element.recordId = mViewComponent.getAD_ViewComponent_ID();
				} else {
					logImportDetail(ctx, impDetail, 0, mViewComponent.getName(), mViewComponent.get_ID(), action);
					throw new POSaveFailedException("Failed to save AD_ViewComponent " + mViewComponent.getName());
				}
			}
		} else {
			element.skip = true;
		}
	}

	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}
	
	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_ViewComponent_ID = Env.getContextAsInt(ctx.ctx, MViewComponent.COLUMNNAME_AD_ViewComponent_ID);
		
		if (viewComponents.contains(AD_ViewComponent_ID))
			return;
		viewComponents.add(AD_ViewComponent_ID);
		AttributesImpl atts = new AttributesImpl();

		MViewComponent m_ViewComponent = new MViewComponent(ctx.ctx, AD_ViewComponent_ID, null);
		
		boolean createElement = true;
		if (ctx.packOut.getFromDate() != null) {
			if (m_ViewComponent.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				createElement = false;
			}
		}
		
		if (createElement) {
			addTypeName(atts, "table");
			document.startElement("", "", MViewComponent.Table_Name, atts);
			createViewComponentBinding(ctx, document, m_ViewComponent);
		}
		
		MViewColumn[] viewColumns = m_ViewComponent.getColumns(true);
		for (MViewColumn viewColumn : viewColumns) {
			createViewColumn(ctx, document, viewColumn.getAD_ViewColumn_ID());
		}

		if (createElement) {
			document.endElement("", "", MViewComponent.Table_Name);
		}
	}
	
	private void createViewColumn(PIPOContext ctx, TransformerHandler document, int AD_ViewColumn_ID) throws SAXException {
		try {
			ctx.packOut.getHandler(MViewColumn.Table_Name).packOut(ctx.packOut, document, ctx.logDocument, AD_ViewColumn_ID);
		} catch (Exception e) {
			throw new SAXException(e);
		}
	}

	private void createViewComponentBinding(PIPOContext ctx, TransformerHandler document, MViewComponent m_ViewComponent) {
		PoExporter filler = new PoExporter(ctx, document, m_ViewComponent);
		List<String>excludes = defaultExcludeList(MViewComponent.Table_Name);

		if (m_ViewComponent.getAD_ViewComponent_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_ViewComponent_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, MViewComponent.COLUMNNAME_AD_ViewComponent_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(MViewComponent.COLUMNNAME_AD_ViewComponent_ID);	
	}

}
