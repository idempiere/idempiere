/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.adempiere.webui.info;

import java.util.Properties;

import org.adempiere.webui.component.Button;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.panel.InfoPAttributePanel;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.GridField;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 * @author hengsin
 *
 */
public class WInfoPAttributeEditor extends WEditor implements IWhereClauseEditor {

	private String m_pAttributeWhere;
	private Properties ctx;
	private int windowNo;

	/**
	 * @param comp
	 * @param gridField
	 */
	public WInfoPAttributeEditor(Properties ctx, int windowNo, GridField gridField) {
		super(new Button(), gridField);
		this.ctx = ctx;
		this.windowNo = windowNo;
		getComponent().addEventListener(Events.ON_CLICK, this);
		getComponent().setImage(ThemeManager.getThemeResource("images/PAttribute16.png"));
		getComponent().setTooltiptext(Msg.getMsg(Env.getCtx(), "PAttribute"));
		setReadWrite(false);
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.event.EventListener#onEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(Events.ON_CLICK)) {
			cmd_InfoPAttribute();
		}
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setReadWrite(boolean)
	 */
	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#isReadWrite()
	 */
	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setValue(java.lang.Object)
	 */
	@Override
	public void setValue(Object value) {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getValue()
	 */
	@Override
	public Object getValue() {
		return null;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getDisplay()
	 */
	@Override
	public String getDisplay() {
		return null;
	}

	@Override
	public Button getComponent() {
		return (Button) super.getComponent();
	}
	
	@Override
	public String getWhereClause() {
		return m_pAttributeWhere;
	}

	public void clearWhereClause() {
		m_pAttributeWhere = null;
	}

	/**
	 * 	Query per Product Attribute.
	 *  <code>
	 * 	Available synonyms:
	 *		M_Product p
	 *		M_ProductPrice pr
	 *		M_AttributeSet pa
	 *	</code>
	 */
	private void cmd_InfoPAttribute()
	{
		int attributeSetId = Env.getContextAsInt(ctx, windowNo, Env.TAB_INFO, "M_AttributeSet_ID");
		final InfoPAttributePanel ia = new InfoPAttributePanel(attributeSetId);
		ia.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				m_pAttributeWhere = ia.getWhereClause();
				if (m_pAttributeWhere != null) {
					m_pAttributeWhere = m_pAttributeWhere.trim();
					if (m_pAttributeWhere.startsWith("AND ")) {
						m_pAttributeWhere = m_pAttributeWhere.substring(4);
					}
				}
			}
		});		
	}	//	cmdInfoAttribute	

	@Override
	public void dynamicDisplay() {
		// int attributeSetId = Env.getContextAsInt(ctx, windowNo, Env.TAB_INFO, "M_AttributeSet_ID");
		// setReadWrite(attributeSetId > 0);
	}
}
