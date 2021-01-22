/******************************************************************************
 * Copyright (C) 2007 Low Heng Sin  All Rights Reserved.                      *
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


import java.util.logging.Level;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.window.WImageDialog;
import org.compiere.model.GridField;
import org.compiere.model.MImage;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.image.AImage;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Image;

/**
 * This class is based on org.compiere.grid.ed.VImage written by Jorg Janke.
 * @author Jorg Janke
 * 
 * Modifications - UI Compatibility
 * @author Low Heng Sin
 */
public class WImageEditor extends WEditor
{
    private static final String[] LISTENER_EVENTS = {Events.ON_CLICK};
    
    /** The Image Model         */
	private MImage  m_mImage = null;
	
    private boolean m_mandatory;

	private boolean readwrite;

    /**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WImageEditor.class);
    
	/**
	 * 
	 * @param gridField
	 */
	public WImageEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public WImageEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(new Image() {
			private static final long serialVersionUID = 8492629361709791256L;

			@Override
			public void onPageAttached(Page newpage, Page oldpage) {
				super.onPageAttached(newpage, oldpage);
				if (newpage != null && getParent() != null) {
					Component p = getParent();
					if (p instanceof Cell) {
						Cell cell = (Cell) p;
						LayoutUtils.addSclass("image-field-cell", cell);
					}
				}
			}        	
        }, gridField, tableEditor, editorConfiguration);
        init();
    }

    @Override
    public Image getComponent() {
    	return (Image) component;
    }
    
    private void init()
    {
    	AImage img = null;
        getComponent().setContent(img);
        getComponent().setSclass("image-field image-fit-contain");        
    }

     @Override
    public String getDisplay()
    {
    	 return m_mImage.getName();
    }

    @Override
    public Object getValue()
    {
    	if (m_mImage == null || m_mImage.get_ID() == 0)
			return null;
		return Integer.valueOf(m_mImage.get_ID());
    }

    @Override
    public boolean isMandatory()
    {
        return m_mandatory;
    }
   
    
    @Override
    public void setMandatory(boolean mandatory)
    {
        m_mandatory = mandatory;
    }
    
    @Override
	public boolean isReadWrite() {
		return readwrite;
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		this.readwrite = readWrite;
		if (readwrite) {
			LayoutUtils.removeSclass("image-field-readonly", getComponent());
		} else {
			LayoutUtils.addSclass("image-field-readonly", getComponent());
		}
	}

	@Override
    public void setValue(Object value)
    {
    	int newValue = 0;
		if (value instanceof Integer)
			newValue = ((Integer)value).intValue();
		if (newValue == 0)
		{
			m_mImage = null;
			AImage img = null;
			getComponent().setContent(img);
			return;
		}
		//  Get/Create Image
		if (m_mImage == null || newValue != m_mImage.get_ID())
			m_mImage = MImage.getCopy(Env.getCtx(), newValue, (String)null);
		//
		if (log.isLoggable(Level.FINE)) log.fine(m_mImage.toString());
		AImage img = null;
		byte[] data = m_mImage.getData();
		if (data != null && data.length > 0) {
			try {
				img = new AImage(null, data);				
			} catch (Exception e) {		
				log.log(Level.WARNING, e.getLocalizedMessage(), e);
			}
		}
		getComponent().setContent(img);
    }
    
	
    @Override
	public String getDisplayTextForGridView(Object value) {
		if (value == null) {
			return "";
		} else {
			return "...";
		}
	}

	@Override
    public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	public void onEvent(Event event) throws Exception 
	{
		if (Events.ON_CLICK.equals(event.getName()) && readwrite)
		{
			final WImageDialog vid = new WImageDialog(m_mImage);
			vid.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

				@Override
				public void onEvent(Event event) throws Exception {
					if (!vid.isCancel()) {
						int AD_Image_ID = vid.getAD_Image_ID();
						Object oldValue = getValue();
						Integer newValue = null;
						if (AD_Image_ID != 0)
							newValue = Integer.valueOf(AD_Image_ID);
						//
						m_mImage = null;	//	force reload
						setValue(newValue);	//	set explicitly
						//
						ValueChangeEvent vce = new ValueChangeEvent(WImageEditor.this, gridField.getColumnName(), oldValue, newValue);
						fireValueChange(vce);
						if (oldValue == null && newValue != null && getGridField() != null && getGridField().getGridTab() != null) {
							// save automatically when creating a new image
							getGridField().getGridTab().dataSave(false);
						}
					}
					
				}
			});			
		}
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#fillHorizontal()
	 */
	@Override
	public void fillHorizontal() {
	}		
}
