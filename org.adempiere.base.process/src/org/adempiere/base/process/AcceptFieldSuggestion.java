/**
 * 
 */
package org.adempiere.base.process;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MField;
import org.compiere.model.M_Element;
import org.compiere.model.X_AD_FieldSuggestion;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * @author hengsin
 *
 */
public class AcceptFieldSuggestion extends SvrProcess {

	private boolean p_updateBaseLanguage;
	private String p_fieldSuggestionTarget;

	/**
	 * 
	 */
	public AcceptFieldSuggestion() {
	}

	/* (non-Javadoc)
	 * @see org.compiere.process.SvrProcess#prepare()
	 */
	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter())
		{
			String name = para.getParameterName();
			if (para.getParameter() == null)
				;
			else if (name.equals("IsUpdateBaseLanguage"))
				p_updateBaseLanguage = para.getParameterAsBoolean();
			else if (name.equals("FieldSuggestionTarget"))
				p_fieldSuggestionTarget = para.getParameterAsString();
			else
				log.log(Level.WARNING, "Unknown Parameter: " + name);
		}

	}

	/* (non-Javadoc)
	 * @see org.compiere.process.SvrProcess#doIt()
	 */
	@Override
	protected String doIt() throws Exception {
		X_AD_FieldSuggestion suggestion = new X_AD_FieldSuggestion(Env.getCtx(), getRecord_ID(), get_TrxName());
		if (X_AD_FieldSuggestion.FIELDSUGGESTIONTARGET_Element.equals(p_fieldSuggestionTarget))
			return updateElement(suggestion);
		else if (X_AD_FieldSuggestion.FIELDSUGGESTIONTARGET_Field.equals(p_fieldSuggestionTarget))
			return updateField(suggestion);
		else {
			addLog("Invalid target for application of changes: " + p_fieldSuggestionTarget);
			return "@Error@";
		}
	}

	private String updateField(X_AD_FieldSuggestion suggestion) {
		boolean changed = false;
		if (p_updateBaseLanguage) {
			MField field = new MField(getCtx(), suggestion.getAD_Field_ID(), get_TrxName());
			if (!Util.isEmpty(suggestion.getName())) {
				field.setName(suggestion.getName());
			}
			if (!Util.isEmpty(suggestion.getDescription())) {
				field.setDescription(suggestion.getDescription());
			}
			if (!Util.isEmpty(suggestion.getHelp())) {
				field.setHelp(suggestion.getHelp());
			}
			if (field.is_Changed()) {
				field.setIsCentrallyMaintained(false);
				field.saveEx();
				changed = true;
			}									
		}
		List<Object> params = new ArrayList<Object>();
		StringBuilder update = new StringBuilder("UPDATE AD_Field_Trl SET ");
		if (!Util.isEmpty(suggestion.getName())) {
			update.append("Name=? ");
			params.add(suggestion.getName());
		}
		if (!Util.isEmpty(suggestion.getDescription())) {
			if (!params.isEmpty())
				update.append(", ");
			update.append("Description=? ");
			params.add(suggestion.getDescription());
		}
		if (!Util.isEmpty(suggestion.getHelp())) {
			if (!params.isEmpty())
				update.append(", ");
			update.append("Help=? ");
			params.add(suggestion.getHelp());
		}
		
		if (!params.isEmpty()) {
			update.append("WHERE AD_Field_ID=? AND AD_Language=?");
			params.add(suggestion.getAD_Field_ID());
			params.add(suggestion.getAD_Language());
			DB.executeUpdateEx(update.toString(), params.toArray(), get_TrxName());
			changed = true;
		}
		
		suggestion.setIsApproved(true);
		suggestion.setIsUpdateBaseLanguage(p_updateBaseLanguage);
		suggestion.setProcessed(true);
		suggestion.saveEx();
		
		if (changed) {
			return "Suggestion accepted and applied to field";
		} else {
			return "No changes found";
		}
	}

	private String updateElement(X_AD_FieldSuggestion suggestion) {
		boolean changed = false;
		MField mField = new MField(getCtx(), suggestion.getAD_Field_ID(), get_TrxName());
		M_Element element = new M_Element(getCtx(), mField.getAD_Column().getAD_Element_ID(), get_TrxName());
		if (p_updateBaseLanguage) {			
			if (!Util.isEmpty(suggestion.getName())) {
				element.setName(suggestion.getName());
			}
			if (!Util.isEmpty(suggestion.getDescription())) {
				element.setDescription(suggestion.getDescription());
			}
			if (!Util.isEmpty(suggestion.getHelp())) {
				element.setHelp(suggestion.getHelp());
			}
			if (element.is_Changed()) {
				element.saveEx();
				changed = true;
			}									
		}
		List<Object> params = new ArrayList<Object>();
		StringBuilder update = new StringBuilder("UPDATE AD_Element_Trl SET ");
		if (!Util.isEmpty(suggestion.getName())) {
			update.append("Name=? ");
			params.add(suggestion.getName());
		}
		if (!Util.isEmpty(suggestion.getDescription())) {
			if (!params.isEmpty())
				update.append(", ");
			update.append("Description=? ");
			params.add(suggestion.getDescription());
		}
		if (!Util.isEmpty(suggestion.getHelp())) {
			if (!params.isEmpty())
				update.append(", ");
			update.append("Help=? ");
			params.add(suggestion.getHelp());
		}
		
		if (!params.isEmpty()) {
			update.append("WHERE AD_Element_ID=? AND AD_Language=?");
			params.add(element.getAD_Element_ID());
			params.add(suggestion.getAD_Language());
			DB.executeUpdateEx(update.toString(), params.toArray(), get_TrxName());
			changed = true;
		}
		
		suggestion.setIsApproved(true);
		suggestion.setIsUpdateBaseLanguage(p_updateBaseLanguage);
		suggestion.setProcessed(true);
		suggestion.saveEx();
		
		if (changed) {
			return "Suggestion accepted and applied to element";
		} else {
			return "No changes found";
		}				
	}

}
