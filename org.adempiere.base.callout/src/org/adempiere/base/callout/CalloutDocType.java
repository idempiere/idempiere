/**
 * 
 */
package org.adempiere.base.callout;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.annotation.Callout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MDocType;

/**
 * 
 * Callout for the C_DocType table.
 * 
 * @author Peter Takacs, Cloudempiere
 * 
 */
@Callout(tableName = MDocType.Table_Name,columnName = MDocType.COLUMNNAME_DocSubTypeSO)
public class CalloutDocType implements IColumnCallout {

private static final Map<String, IColumnCallout> calloutMap = new HashMap<String, IColumnCallout>();
	
	static {
		calloutMap.put(MDocType.COLUMNNAME_DocSubTypeSO, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> isAutogenerateInOutInvoice(ctx, windowNo, mTab, mField, value));
	}
	
	@Override
	public String start(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		IColumnCallout callout = calloutMap.get(mField.getColumnName());
		return callout != null ? callout.start(ctx, windowNo, mTab, mField, value, oldValue) : "";
	}

	/**
	 * Set AutogenerateInout and AutogenerateInvoice based on DocSubTypeSO
	 * @param ctx
	 * @param windowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return
	 */
	private static String isAutogenerateInOutInvoice(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value) {
		String docSubTypeSO = Objects.toString(value);
		GridField isGenerateInOutField = mTab.getField("IsAutogenerateInout");
		if(isGenerateInOutField != null) {
			mTab.setValue(isGenerateInOutField, MDocType.getIsAutoGenerateInout(docSubTypeSO));
		}
		GridField isGenerateInvoiceField = mTab.getField("IsAutogenerateInvoice");
		if(isGenerateInvoiceField != null) {
			mTab.setValue(isGenerateInvoiceField, MDocType.getIsAutoGenerateInvoice(docSubTypeSO));
		}
		return "";
	}
}
