/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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
package org.adempiere.webui.apps.form;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.WAppsAction;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.StatusBarPanel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.apps.form.CreateFromForm;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.TrxRunnable;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;

/**
 * 
 * @author Elaine
 *
 */
@org.idempiere.ui.zk.annotation.Form
public class WCreateFromForm extends ADForm implements EventListener<Event>, WTableModelListener, DialogEvents
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3703236565441597403L;
	private CreateFromForm form;
	
	private Panel parameterPanel = new Panel();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private StatusBarPanel statusBar = new StatusBarPanel();
	private WListbox dataTable = ListboxFactory.newDataTable();

	private boolean isCancel;
	
	public static final String SELECT_ALL = "SelectAll";

	/**
	 * 
	 * @param createFrom
	 */
	public WCreateFromForm(CreateFromForm createFrom)
	{
		super();
		this.form = createFrom;
		
		setSizable(true);
		setMaximizable(true);
		setBorder("normal");		
		setSclass("create-from-form");
	}
	
	@Override
	protected void initForm() 
	{		
		try
		{
			zkInit();
			confirmPanel.addActionListener(this);
			
			statusBar.setStatusDB("");
			tableChanged(null);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}		
    }
	
	protected void zkInit() throws Exception
	{
		Borderlayout contentPane = new Borderlayout();
		appendChild(contentPane);
		
		North north = new North();
		contentPane.appendChild(north);
		north.appendChild(parameterPanel);
		north.setAutoscroll(true);
		north.setSplittable(true);
		north.setCollapsible(true);
		LayoutUtils.addSlideSclass(north);
		
		Center center = new Center();
        contentPane.appendChild(center);
		center.appendChild(dataTable);
		
		WAppsAction selectAllAction = new WAppsAction (SELECT_ALL, null, null);
		Button selectAllButton = selectAllAction.getButton();
		confirmPanel.addComponentsLeft(selectAllButton);
		selectAllButton.addActionListener(this);
		
		South south = new South();
		contentPane.appendChild(south);
		Panel southPanel = new Panel();
		south.appendChild(southPanel);
		southPanel.appendChild(new Separator());
		southPanel.appendChild(confirmPanel);

		southPanel.appendChild(new Separator());
		southPanel.appendChild(statusBar);
		
		if (!ThemeManager.isUseCSSForWindowSize())
		{
			ZKUpdateUtil.setWindowWidthX(this, 750);
			ZKUpdateUtil.setWindowHeightX(this, 550);
		}
		else
		{
			addCallback(AFTER_PAGE_ATTACHED, t -> {
				ZKUpdateUtil.setCSSHeight(this);
				ZKUpdateUtil.setCSSWidth(this);
			});
		}
		
		ZKUpdateUtil.setWidth(contentPane, "100%");
		ZKUpdateUtil.setHeight(contentPane, "100%");		
	}

	@Override
	public void onEvent(Event e) throws Exception
	{
		//  OK - Save
		if (e.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			isCancel = false;
			try
			{
				Trx.run(new TrxRunnable()
				{
					public void run(String trxName)
					{
						save(trxName);
					}
				});
				dispose();
			}
			catch (Exception ex)
			{
				Dialog.error(getWindowNo(), "Error", ex.getLocalizedMessage());
			}
		}
		//  Cancel
		else if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
		{
			isCancel = true;
			dispose();
		}
		// Select All
		// Trifon
		else if (e.getTarget().getId().equals(SELECT_ALL)) {
			ListModelTable model = dataTable.getModel();
			int rows = model.getSize();
			for (int i = 0; i < rows; i++)
			{
				model.setValueAt(Boolean.TRUE, i, 0);
			}
			//refresh
			dataTable.setModel(model);
			info();
		}
		else
		{
			super.onEvent(e);
		}
	}

	@Override
	public void tableChanged (WTableModelEvent e)
	{
		int type = -1;
		if (e != null)
		{
			type = e.getType();
			if (type != WTableModelEvent.CONTENTS_CHANGED)
				return;
		}
		info();
	}
	
	/**
	 * 
	 * @param trxName
	 * @return true if save success
	 */
	public boolean save(String trxName)
	{
		ListModelTable model = dataTable.getModel();
		int rows = model.getSize();
		if (rows == 0)
			return false;
		
		return form.save(dataTable, trxName, getGridTab());
	}

	/**
	 * update status bar
	 */
	public void info()
	{
		ListModelTable model = dataTable.getModel();
		int rows = model.getRowCount();
		int count = 0;
		for (int i = 0; i < rows; i++)
		{
			if (((Boolean) model.getValueAt(i, 0)).booleanValue())
				count++;
		}
		setStatusLine(count, null);
		
		form.info(dataTable, statusBar);
	}
	
	/**
	 * set status bar text
	 * @param selectedRowCount
	 * @param text
	 */
	public void setStatusLine(int selectedRowCount, String text) 
	{
		StringBuilder sb = new StringBuilder(String.valueOf(selectedRowCount));
		if (text != null && text.trim().length() > 0) {
			sb.append(" - ").append(text);
		}
		statusBar.setStatusLine(sb.toString());
		//
		confirmPanel.getOKButton().setEnabled(selectedRowCount > 0);
	}
	
	/**
	 * 
	 * @return {@link WListbox}
	 */
	public WListbox getWListbox()
	{
		return dataTable;
	}
	
	/**
	 * 
	 * @return {@link Panel}
	 */
	public Panel getParameterPanel()
	{
		return parameterPanel;
	}
	
	/**
	 * 
	 * @return {@link ConfirmPanel}
	 */
	public ConfirmPanel getConfirmPanel()
	{
		return confirmPanel;
	}
	
	/**
	 * 
	 * @return true if cancel by user
	 */
	public boolean isCancel() 
	{
		return isCancel;
	}
	
	/**
	 * post execute query event
	 */
	public void postQueryEvent() 
    {
		Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
    	Events.echoEvent("onExecuteQuery", this, null);
    }
    
    /**
     * Dont call this directly, use internally to handle execute query event 
     */
    public void onExecuteQuery()
    {
    	try
    	{
    		form.executeQuery();
    	}
    	finally
    	{
    		Clients.clearBusy();
    	}
    }
    
    @Override
	public Mode getWindowMode() {
		return Mode.HIGHLIGHTED;
	}

	@Override
	public boolean setVisible(boolean visible) {
		 boolean ok = super.setVisible(visible);
		 if (visible && getProcessInfo() != null)
			 form.initForm();
		 return ok;
	}	
}
