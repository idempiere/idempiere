package org.adempiere.webui.editor;

import org.compiere.model.GridField;
import org.compiere.util.Util;


public class WJsonEditor extends WStringEditor {
	
	/**
	 * 
	 * @param gridField
	 */
	public WJsonEditor(GridField gridField) {
		super(gridField);
		getComponent().setMultiline(true);
		setChangeEventWhenEditing(false);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public WJsonEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
        super(gridField, tableEditor, editorConfiguration);
        getComponent().setMultiline(true);
        setChangeEventWhenEditing(false);
    }
    
    @Override
    public void setValue(Object value) {
    	super.setValue(value);

    	String prettyValue = null;
    	if (value != null && !Util.isEmpty(value.toString())) {
    		prettyValue = Util.prettifyJSONString(value.toString());
    		if (! prettyValue.equals(value)) {
        		getComponent().setText(prettyValue);
    		}
    	}
    }
    
}
