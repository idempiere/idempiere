/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin.  All Rights Reserved.                     *
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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.component.Combinationbox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.WAccountDialog;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.MAccountLookup;
import org.compiere.model.MRole;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;

/**
 *
 * @author Low Heng Sin
 *
 */
public class WAccountEditor extends WEditor implements ContextMenuListener
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK, Events.ON_CHANGE, Events.ON_OK};

	private MAccountLookup		m_mAccount;

	private Object m_value;

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WAccountEditor.class);

	/**
	 * 
	 * @param gridField
	 */
	public WAccountEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WAccountEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
	{
		super(new Combinationbox(), gridField, tableEditor, editorConfiguration);
		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-Account");
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/Account16.png"));

		m_mAccount = new MAccountLookup (gridField.getVO().ctx, gridField.getWindowNo());
		
		popupMenu = new WEditorPopupMenu(false, false, true);
		popupMenu.addMenuListener(this);
		addChangeLogMenu(popupMenu);
		if (gridField != null)
			getComponent().getTextbox().setPlaceholder(gridField.getPlaceholder());
	}

	@Override
	public Combinationbox getComponent() {
		return (Combinationbox) component;
	}

	@Override
	public void setValue(Object value)
	{
		m_value = value;
		getComponent().setText(m_mAccount.getDisplay(value));	//	loads value
		getComponent().setToolTipText(m_mAccount.getDescription());
	}

	@Override
	public Object getValue()
	{
		if (m_mAccount.C_ValidCombination_ID == 0)
			return null;
		return Integer.valueOf(m_mAccount.C_ValidCombination_ID);
	}

	@Override
	public String getDisplay()
	{
		return getComponent().getText();
	}
	
	/**
	 *	Button - Start Dialog
	 */
	public void cmd_button()
	{
		int C_AcctSchema_ID;
		if (gridField.getGridTab() != null)
			C_AcctSchema_ID = Env.getContextAsInt(Env.getCtx(), gridField.getWindowNo(), gridField.getGridTab().getTabNo(), "C_AcctSchema_ID");
		else
			C_AcctSchema_ID = Env.getContextAsInt(Env.getCtx(), gridField.getWindowNo(), "C_AcctSchema_ID");
		// Try to get C_AcctSchema_ID from global context - teo_sarca BF [ 1830531 ]
		if (C_AcctSchema_ID <= 0)
		{
			C_AcctSchema_ID = Env.getContextAsInt(Env.getCtx(), "$C_AcctSchema_ID");
		}
		new WAccountDialog (gridField.getHeader(), m_mAccount, C_AcctSchema_ID, new Callback<Integer>() {
			
			@Override
			public void onCallback(Integer result) {
				Integer newValue = result;
				
				boolean changed = true;
				if (newValue == null) 
				{
					if (m_value == null) 
						changed = false;
					if (m_mAccount.getDisplay(m_value).equals(getComponent().getText()))
						changed = false;
				}

				if (changed)
				{
					Object oldValue = m_value;
	
					//	set & redisplay
					setValue(newValue);
					ValueChangeEvent changeEvent = new ValueChangeEvent(WAccountEditor.this, getColumnName(), oldValue, newValue);
					fireValueChange(changeEvent);
				}
				
				//safety check: if focus is going no where, focus back to self
				String uid = getComponent().getTextbox().getUuid();
				String script = "setTimeout(function(){try{var e = zk.Widget.$('#" + uid +
						"').$n(); if (jq(':focus').size() == 0) e.focus();} catch(error){}}, 100);";
				Clients.response(new AuScript(script));
			}
		});
		//				
	}	//	cmd_button

	/**
	 *	Text - try to find Alias or start Dialog
	 */
	public void cmd_text()
	{
		String text = getComponent().getText();
		log.info("Text=" + text);
		if (text == null || text.length() == 0 || text.equals("%"))
		{
			cmd_button();
			return;
		}
		if (!text.endsWith("%"))
			text += "%";
		//
		String sql = "SELECT C_ValidCombination_ID FROM C_ValidCombination "
			+ "WHERE C_AcctSchema_ID=?"
			+ " AND (UPPER(Alias) LIKE ? OR UPPER(Combination) LIKE ?)";
		sql = MRole.getDefault().addAccessSQL(sql,
			"C_ValidCombination", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		int C_AcctSchema_ID = Env.getContextAsInt(Env.getCtx(), gridField.getWindowNo(), "C_AcctSchema_ID");
		//
		int C_ValidCombination_ID = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, C_AcctSchema_ID);
			boolean useSimilarTo = "Y".equals(Env.getContext(Env.getCtx(), "P|IsUseSimilarTo"));
			if (useSimilarTo && text.contains("*"))
				text = text.replaceAll("\\*", "\\\\*");
			pstmt.setString(2, text.toUpperCase());
			pstmt.setString(3, text.toUpperCase());
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				C_ValidCombination_ID = rs.getInt(1);
				if (rs.next())		//	only one
					C_ValidCombination_ID = 0;
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		//	We have a Value
		if (C_ValidCombination_ID > 0)
		{
			Integer newValue = Integer.valueOf(C_ValidCombination_ID);
			Object oldValue = m_value;
			m_value = newValue;
			ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
			fireValueChange(changeEvent);
		}
		else
			cmd_button();
	}	//	actionPerformed

	public void onEvent(Event event)
	{
		if (Events.ON_CHANGE.equals(event.getName()) || Events.ON_OK.equals(event.getName()))
		{
			cmd_text();
		}
		else if (Events.ON_CLICK.equals(event.getName()))
		{
			cmd_button();
		}
	}

	public String[] getEvents()
    {
        return LISTENER_EVENTS;
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
	public void onMenu(ContextMenuEvent evt) {
		if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		}
	}

	@Override
	public boolean isNullOrEmpty() {
		Object value = getValue();
		if (value != null && ((Integer) value).intValue() == 0)
			value = null;
		
		return value == null;
	}

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}

}
