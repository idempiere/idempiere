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



import static org.compiere.model.SystemIDs.COLUMN_M_PRODUCT_M_ATTRIBUTESETINSTANCE_ID;

import java.util.logging.Level;

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.PAttributebox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WPAttributeDialog;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.Lookup;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 *
 * @author Low Heng Sin
 *
 */
public class WPAttributeEditor extends WEditor implements ContextMenuListener
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK, Events.ON_CHANGE, Events.ON_OK};

	private static final CLogger log = CLogger.getCLogger(WPAttributeEditor.class);

	private int m_WindowNo;

	private Lookup m_mPAttribute;

	private int m_C_BPartner_ID;

	private Object m_value;

	private GridTab m_GridTab;

	/**	No Instance Key					*/
	private static Integer		NO_INSTANCE = Integer.valueOf(0);

	/**
	 * 
	 * @param gridTab
	 * @param gridField
	 */
	public WPAttributeEditor(GridTab gridTab, GridField gridField)
	{
		this(gridTab, gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridTab
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WPAttributeEditor(GridTab gridTab, GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
	{
		super(new PAttributebox(), gridField, tableEditor, editorConfiguration);
		m_GridTab = gridTab;
		initComponents();
	}

	private void initComponents() {
		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-PAttribute");
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/PAttribute16.png"));
		// getComponent().addEventListener(Events.ON_CLICK, this); // IDEMPIERE-426 - dup listener, already set at WEditor

		m_WindowNo = gridField.getWindowNo();
		m_mPAttribute = gridField.getLookup();
		m_C_BPartner_ID = Env.getContextAsInt(Env.getCtx(), m_WindowNo, "C_BPartner_ID");

		//	Popup
		popupMenu = new WEditorPopupMenu(true, false, false);
		addChangeLogMenu(popupMenu);
		
		getComponent().getTextbox().setReadonly(true);

		if (gridField != null)
			getComponent().getTextbox().setPlaceholder(gridField.getPlaceholder());
	}

	@Override
	public PAttributebox getComponent()
	{
		return (PAttributebox) component;
	}

	@Override
	public void setValue(Object value)
	{
		if (value == null || NO_INSTANCE.equals(value))
		{
			getComponent().setText("");
			m_value = value;
			return;
		}

		//	The same
		if (value.equals(m_value))
			return;
		//	new value
		if (log.isLoggable(Level.FINE)) log.fine("Value=" + value);
		m_value = value;
		getComponent().setText(m_mPAttribute.getDisplay(value));	//	loads value
	}

	@Override
	public Object getValue()
	{
		return m_value;
	}

	@Override
	public String getDisplay()
	{
		return getComponent().getText();
	}

	public void onEvent(Event event)
	{
		if (Events.ON_CHANGE.equals(event.getName()) || Events.ON_OK.equals(event.getName()))
		{
			String newText = getComponent().getText();
			String oldText = null;
			if (m_value != null)
			{
				oldText = m_mPAttribute.getDisplay(m_value);
			}
			if (oldText != null && newText != null && oldText.equals(newText))
			{
	    	    return;
	    	}
	        if (oldText == null && newText == null)
	        {
	        	return;
	        }
			ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldText, newText);
			fireValueChange(changeEvent);
		}
		else if (Events.ON_CLICK.equals(event.getName()))
		{
			cmd_dialog();
		}
	}

	/**
	 *  Start dialog
	 */
	private void cmd_dialog()
	{
		//
		Integer oldValue = (Integer)getValue ();
		final int oldValueInt = oldValue == null ? 0 : oldValue.intValue ();
		int M_AttributeSetInstance_ID = oldValueInt;
		int M_Product_ID = 0;
		int M_ProductBOM_ID = 0;
		if (m_GridTab != null) {
			M_Product_ID = Env.getContextAsInt (Env.getCtx (), m_WindowNo, m_GridTab.getTabNo(), "M_Product_ID");
			M_ProductBOM_ID = Env.getContextAsInt (Env.getCtx (), m_WindowNo, m_GridTab.getTabNo(), "M_ProductBOM_ID");
			//For third level tab (e.g, LineMA), should take M_Product_ID from Line instead of from Header
			if (m_GridTab.getTabLevel() > 1 && m_GridTab.getParentTab() != null && m_GridTab.getField("M_Product_ID")==null) {
				int tmp = Env.getContextAsInt (Env.getCtx (), m_WindowNo, m_GridTab.getParentTab().getTabNo(), "M_Product_ID");
				if (tmp > 0)
					M_Product_ID = tmp;
			}
		} else {
			M_Product_ID = Env.getContextAsInt (Env.getCtx (), m_WindowNo, "M_Product_ID");
			M_ProductBOM_ID = Env.getContextAsInt (Env.getCtx (), m_WindowNo, "M_ProductBOM_ID");
		}

		if (log.isLoggable(Level.CONFIG)) log.config("M_Product_ID=" + M_Product_ID + "/" + M_ProductBOM_ID
			+ ",M_AttributeSetInstance_ID=" + M_AttributeSetInstance_ID
			+ ", AD_Column_ID=" + gridField.getAD_Column_ID());

		//	M_Product.M_AttributeSetInstance_ID = 8418
		final boolean productWindow = (gridField.getAD_Column_ID() == COLUMN_M_PRODUCT_M_ATTRIBUTESETINSTANCE_ID);		//	HARDCODED

		if (M_ProductBOM_ID != 0)	//	Use BOM Component
			M_Product_ID = M_ProductBOM_ID;
		//
		if (!productWindow && (M_Product_ID == 0))
		{
			getComponent().setText(null);
			M_AttributeSetInstance_ID = 0;
			
			processChanges(oldValueInt, M_AttributeSetInstance_ID);
		}
		else
		{
			final WPAttributeDialog vad = new WPAttributeDialog (
				M_AttributeSetInstance_ID, M_Product_ID, m_C_BPartner_ID,
				productWindow, gridField.getAD_Column_ID(), m_WindowNo);
			vad.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

				@Override
				public void onEvent(Event event) throws Exception {
					boolean changed = false;
					int M_AttributeSetInstance_ID = 0;
					if (vad.isChanged())
					{
						getComponent().setText(vad.getM_AttributeSetInstanceName());
						M_AttributeSetInstance_ID = vad.getM_AttributeSetInstance_ID();
						if (m_GridTab != null && !productWindow && vad.getM_Locator_ID() > 0)
						{
							if (gridField.getColumnName().equals("M_AttributeSetInstanceTo_ID"))
								m_GridTab.setValue("M_LocatorTo_ID", vad.getM_Locator_ID());
							else
								m_GridTab.setValue("M_Locator_ID", vad.getM_Locator_ID());
							
						}
						changed = true;
					}
					
					//	Set Value
					if (changed)
					{
						processChanges(oldValueInt, M_AttributeSetInstance_ID);
					}	//	change
				}
			});
			
		}
		/** Selection
		{
			//	Get Model
			MAttributeSetInstance masi = MAttributeSetInstance.get(Env.getCtx(), M_AttributeSetInstance_ID, M_Product_ID);
			if (masi == null)
			{
				log.log(Level.SEVERE, "No Model for M_AttributeSetInstance_ID=" + M_AttributeSetInstance_ID + ", M_Product_ID=" + M_Product_ID);
			}
			else
			{
				Env.setContext(Env.getCtx(), m_WindowNo, "M_AttributeSet_ID", masi.getM_AttributeSet_ID());
				//	Get Attribute Set
				MAttributeSet as = masi.getMAttributeSet();
				//	Product has no Attribute Set
				if (as == null)
					ADialog.error(m_WindowNo, this, "PAttributeNoAttributeSet");
				//	Product has no Instance Attributes
				else if (!as.isInstanceAttribute())
					ADialog.error(m_WindowNo, this, "PAttributeNoInstanceAttribute");
				else
				{
					int M_Warehouse_ID = Env.getContextAsInt (Env.getCtx (), m_WindowNo, "M_Warehouse_ID");
					int M_Locator_ID = Env.getContextAsInt (Env.getCtx (), m_WindowNo, "M_Locator_ID");
					String title = "";
					PAttributeInstance pai = new PAttributeInstance (
						Env.getFrame(this), title,
						M_Warehouse_ID, M_Locator_ID, M_Product_ID, m_C_BPartner_ID);
					if (pai.getM_AttributeSetInstance_ID() != -1)
					{
						m_text.setText(pai.getM_AttributeSetInstanceName());
						M_AttributeSetInstance_ID = pai.getM_AttributeSetInstance_ID();
						changed = true;
					}
				}
			}
		}
		**/		
	}   //  cmd_file

	private void processChanges(int oldValueInt, int M_AttributeSetInstance_ID) {
		if (log.isLoggable(Level.FINEST)) log.finest("Changed M_AttributeSetInstance_ID=" + M_AttributeSetInstance_ID);
		m_value = new Object();				//	force re-query display
		if (M_AttributeSetInstance_ID == 0)
			setValue(null);
		else
			setValue(Integer.valueOf(M_AttributeSetInstance_ID));

		ValueChangeEvent vce = new ValueChangeEvent(this, gridField.getColumnName(), new Object(), getValue());
		fireValueChange(vce);
		if (M_AttributeSetInstance_ID == oldValueInt && m_GridTab != null && gridField != null)
		{
			//  force Change - user does not realize that embedded object is already saved.
			m_GridTab.processFieldChange(gridField);
		}
	}

	public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	public void onMenu(ContextMenuEvent evt)
	{
		if (WEditorPopupMenu.ZOOM_EVENT.equals(evt.getContextEvent()))
		{
			actionZoom();
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		}
	}

	public void actionZoom()
	{
	   	AEnv.actionZoom(m_mPAttribute, getValue());
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().getButton().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
		
		getComponent().getTextbox().setReadonly(true);
	}

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}
}
