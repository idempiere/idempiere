package org.adempiere.pipo2.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.X_AD_ModelValidator;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ModelValidatorElementHandler extends AbstractElementHandler{

	private List<Integer>validators = new ArrayList<Integer>();
	
	private static final String AD_MODELVALIDATOR = "AD_ModelValidator";
	
	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException {
	
		String action = null;

		String entitytype = getStringValue(element, "EntityType");
		String name = getStringValue(element, "Name");

		if (isProcessElement(ctx.ctx, entitytype)) {

			X_AD_ModelValidator validator = findPO(ctx, element);
			if (validator == null) {
				int id = findIdByColumn(ctx, X_AD_ModelValidator.Table_Name, X_AD_ModelValidator.COLUMNNAME_Name, name, /*ignorecase=*/true);
				validator = new X_AD_ModelValidator(ctx.ctx, id, getTrxName(ctx));
			}
			List<String> excludes = defaultExcludeList(X_AD_ModelValidator.Table_Name);
			if (validator.getAD_ModelValidator_ID() == 0 && isOfficialId(element, "AD_ModelValidator_ID"))
				validator.setAD_ModelValidator_ID(getIntValue(element, "AD_ModelValidator_ID"));
			
			if (validators.contains(validator.getAD_ModelValidator_ID())) {
				element.skip = true;
				return;
			}

			PoFiller pf = new PoFiller(ctx, validator, element, this);
			List<String> notfounds = pf.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			
			if (validator.is_new() || validator.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ModelValidator.Table_Name, X_AD_ModelValidator.Table_ID);
				if (!validator.is_new()) {				
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), AD_MODELVALIDATOR, validator);
					action = "Update";
				} else {
					action = "New";
				}
	
				if (validator.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, validator.getName(),
							validator.get_ID(), action);
	
					element.recordId = validator.getAD_ModelValidator_ID();
	
					validators.add(validator.getAD_ModelValidator_ID());
	
				} else {
					logImportDetail(ctx, impDetail, 0, validator.getName(),
							validator.get_ID(), action);
					throw new POSaveFailedException("Failed to save Model Validator " + validator.getName());
				}
			}
		} else {
			element.skip = true;
		}
		
	}

	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException {
		// TODO Auto-generated method stub
		
	}
	

	
	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int ad_modelvalidator_id = Env.getContextAsInt(ctx.ctx, X_AD_ModelValidator.COLUMNNAME_AD_ModelValidator_ID);
		
		if (validators.contains(ad_modelvalidator_id))
			return;
		
		validators.add(ad_modelvalidator_id);
		
		X_AD_ModelValidator validator = new X_AD_ModelValidator(ctx.ctx, ad_modelvalidator_id, null);
		
		if (ctx.packOut.getFromDate() != null) {
			if (validator.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", "AD_ModelValidator", atts);
		createADModelValidatorBinding(ctx, document, validator);

		PackOut packOut = ctx.packOut;
		try{
			new CommonTranslationHandler().packOut(packOut,document,null,validator.get_ID());
		}
		catch(Exception e)
		{
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}

		document.endElement("", "", "AD_ModelValidator");
	}

	private void createADModelValidatorBinding(PIPOContext ctx, TransformerHandler document, X_AD_ModelValidator validator) {
		PoExporter filler = new PoExporter(ctx, document, validator);
		if (validator.getAD_ModelValidator_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add(X_AD_ModelValidator.COLUMNNAME_AD_ModelValidator_ID, new AttributesImpl());
		List<String> excludes = defaultExcludeList(X_AD_ModelValidator.Table_Name);
		filler.export(excludes);		
	}
	
	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,	TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, X_AD_ModelValidator.COLUMNNAME_AD_ModelValidator_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_ModelValidator.COLUMNNAME_AD_ModelValidator_ID);
	}

}
