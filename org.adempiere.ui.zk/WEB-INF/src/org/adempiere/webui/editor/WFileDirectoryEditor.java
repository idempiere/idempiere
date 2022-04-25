/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.editor;


import org.adempiere.webui.component.FilenameBox;
import org.adempiere.webui.component.FolderBrowser;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.GridField;
import org.compiere.util.CLogger;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 *
 * @author Low Heng Sin
 *
 */
public class WFileDirectoryEditor extends WEditor
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK, Events.ON_CHANGE, Events.ON_OK};

	@SuppressWarnings("unused")
	private static final CLogger log = CLogger.getCLogger(WFileDirectoryEditor.class);

	private String oldValue;

	/**
	 * 
	 * @param gridField
	 */
	public WFileDirectoryEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WFileDirectoryEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
	{
		super(new FilenameBox(), gridField, tableEditor, editorConfiguration);
		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-Open");
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/Open16.png"));
		getComponent().getButton().setUpload("false");
		if (gridField != null)
			getComponent().getTextbox().setPlaceholder(gridField.getPlaceholder());
	}

	@Override
	public FilenameBox getComponent()
	{
		return (FilenameBox) component;
	}

	@Override
	public void setValue(Object value)
	{
        if (value == null)
        {
        	oldValue = null;
            getComponent().setText("");
        }
        else
        {
        	oldValue = String.valueOf(value);
            getComponent().setText(oldValue);
        }
	}

	@Override
	public Object getValue()
	{
		return getComponent().getText();
	}

	@Override
	public String getDisplay()
	{
		return getComponent().getText();
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
	}

	public void onEvent(Event event)
	{
		String newValue = null;
		if (Events.ON_CHANGE.equals(event.getName()) || Events.ON_OK.equals(event.getName()))
		{
			newValue = getComponent().getText();
		}
		else if (Events.ON_CLICK.equals(event.getName()))
		{
			cmd_file();
		}
		else
		{
			return;
		}

		if (oldValue != null && newValue != null && oldValue.equals(newValue)) {
    	    return;
    	}
        if (oldValue == null && newValue == null) {
        	return;
        }
		processNewValue(newValue);
	}

	protected void processNewValue(String newValue) {
		if (oldValue != null && newValue != null && oldValue.equals(newValue)) {
    	    return;
    	}
        if (oldValue == null && newValue == null) {
        	return;
        }
		ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
		fireValueChange(changeEvent);
	}

	/**
	 *  Load file
	 */
	private void cmd_file()
	{
		final FolderBrowser directoryDialog = new FolderBrowser(true);
		directoryDialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				String directory = directoryDialog.getPath();
				getComponent().setText(directory);
				getComponent().getTextbox().focus();
				processNewValue(getComponent().getText());
			}
		});
	}   //  cmd_file

	public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }
}
