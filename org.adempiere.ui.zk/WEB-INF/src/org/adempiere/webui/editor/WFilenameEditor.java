/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin  All Rights Reserved.                      *
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


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.component.FilenameBox;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.GridField;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.zkoss.util.media.Media;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.UploadEvent;

/**
 * Default editor for {@link DisplayType#FileName}.<br/>
 * Implemented with {@link FilenameBox} component with upload enabled.
 * @author Low Heng Sin
 *
 */
public class WFilenameEditor extends WEditor
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK, Events.ON_CHANGE, Events.ON_OK};

	private static final CLogger log = CLogger.getCLogger(WFilenameEditor.class);

	/** absolute folder path + file name */
	private String oldValue;

	/**
	 * 
	 * @param gridField
	 */
	public WFilenameEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WFilenameEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
	{
		super(new FilenameBox(), gridField, tableEditor, editorConfiguration);
		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-Open");
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/Open16.png"));
		getComponent().addEventListener(Events.ON_UPLOAD, this);
		getComponent().getButton().setUpload(AdempiereWebUI.getUploadSetting());
		getComponent().getButton().setAttribute("org.zkoss.zul.image.preload", Boolean.TRUE);
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

	@Override
	public void onEvent(Event event)
	{
		String newValue = null;

		if (Events.ON_CHANGE.equals(event.getName()) || Events.ON_OK.equals(event.getName()))
		{
			newValue = getComponent().getText();

		}
		else if (event instanceof UploadEvent)
		{
			UploadEvent ue = (UploadEvent) event;
			processUploadMedia(ue.getMedia());
			return;
		}
		else
		{
			return;
		}

		processNewValue(newValue);
	}

	/**
	 * Process newValue from user input
	 * @param newValue
	 */
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
	 * Process uploaded file from file selection dialog
	 * @param file {@link Media}
	 */
	private void processUploadMedia(Media file) {
		if (file == null)
			return;

		FileOutputStream fos = null;
		String fileName = null;
		try {

			File tempFile = File.createTempFile("adempiere_", "_"+file.getName());
			fileName = tempFile.getAbsolutePath();

			fos = new FileOutputStream(tempFile);
			byte[] bytes = null;
			if (file.inMemory()) {
				bytes = file.getByteData();
			} else {
				InputStream is = null;
				try {
					is = file.getStreamData();
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					byte[] buf = new byte[ 1000 ];
					int byteread = 0;
					while (( byteread=is.read(buf) )!=-1)
						baos.write(buf,0,byteread);
					bytes = baos.toByteArray();
				} finally {
					if (is != null)
						is.close();
				}
			}

			fos.write(bytes);
			fos.flush();
			fos.close();
		} catch (IOException e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			return;
		} finally {
			if (fos != null)
				try {
					fos.close();
				} catch (IOException e) {}
		}

		getComponent().setText(fileName);
		
		processNewValue(getComponent().getText());
	}

	@Override
	public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}
	
}
