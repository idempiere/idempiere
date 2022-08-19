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
package org.adempiere.webui.apps.form;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.WAppsAction;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.panel.StatusBarPanel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.grid.CreateFrom;
import org.compiere.util.Trx;
import org.compiere.util.TrxRunnable;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;

/**
 * 
 * @author hengsin
 *
 */
public class WCreateFromWindow extends Window implements EventListener<Event>, WTableModelListener, DialogEvents
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6750121735083748182L;

	private CreateFrom createFrom;
	private int windowNo;
	
	private Panel parameterPanel = new Panel();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private StatusBarPanel statusBar = new StatusBarPanel();
	private WListbox dataTable = ListboxFactory.newDataTable();

	private boolean isCancel;
	
	public static final String SELECT_DESELECT_ALL = "SelectAll";
	private boolean checkAllSelected = true;

	/**
	 * 
	 * @param createFrom
	 * @param windowNo
	 */
	public WCreateFromWindow(CreateFrom createFrom, int windowNo)
	{
		super();
		
		this.createFrom = createFrom;
		this.windowNo = windowNo;
		
		try
		{
			zkInit();
			confirmPanel.addActionListener(this);
			
			statusBar.setStatusDB("");
			tableChanged(null);
			createFrom.setInitOK(true);
		}
		catch(Exception e)
		{
			createFrom.setInitOK(false);
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
		ZKUpdateUtil.setVflex(parameterPanel, "1");
		ZKUpdateUtil.setHflex(parameterPanel, "1");
		
		Center center = new Center();
        contentPane.appendChild(center);
		center.appendChild(dataTable);

		WAppsAction selectAllAction = new WAppsAction (SELECT_DESELECT_ALL, null, null);
		Button selectAllButton = selectAllAction.getButton();
		selectAllButton.setAttribute(SELECT_DESELECT_ALL, Boolean.FALSE);
		confirmPanel.addComponentsLeft(selectAllButton);

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
		setSclass("create-from-window");
		setSizable(true);
		setBorder("normal");
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
				Dialog.error(windowNo, "Error", ex.getLocalizedMessage());
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
		else if (e.getTarget().getId().equals(SELECT_DESELECT_ALL)) {
			ListModelTable model = dataTable.getModel();
			int rows = model.getSize();
			Button selectAllBtn = confirmPanel.getButton(SELECT_DESELECT_ALL);
			Boolean selectAll = (Boolean) selectAllBtn.getAttribute(SELECT_DESELECT_ALL);
			if (selectAll == null)
				selectAll = Boolean.FALSE;
			selectAll = !selectAll;
			selectAllBtn.setAttribute(SELECT_DESELECT_ALL, selectAll);
			checkAllSelected = false;
			for (int i = 0; i < rows; i++) {
				model.setValueAt(selectAll, i, 0);
			}
			checkAllSelected = true;
			//refresh
			dataTable.setModel(model);
			info();
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

			if (checkAllSelected && e.getColumn() == 0) {
				ListModelTable model = dataTable.getModel();
				boolean rowUnSelected = false;
				for (int i = 0; i < model.getRowCount(); i++) {
					if ( ! (Boolean) model.getValueAt(i, 0) ) {
						rowUnSelected = true;
						break;
					}
				}
				Button selectAllBtn = confirmPanel.getButton(SELECT_DESELECT_ALL);
				selectAllBtn.setAttribute(SELECT_DESELECT_ALL, ! rowUnSelected);
			}
		}
		info();
	}
	
	/**
	 * 
	 * @param trxName
	 * @return true if save successfully
	 */
	public boolean save(String trxName)
	{
		ListModelTable model = dataTable.getModel();
		int rows = model.getSize();
		if (rows == 0)
			return false;
		
		return createFrom.save(dataTable, trxName);
	}

	/**
	 * update status
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
		
		createFrom.info(dataTable, statusBar);
	}
	
	/**
	 * 
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
	 * @return {@link StatusBarPanel}
	 */
	public StatusBarPanel getStatusBar()
	{
		return statusBar;
	}

	/**
	 * 
	 * @param statusBar
	 */
	public void setStatusBar(StatusBarPanel statusBar)
	{
		this.statusBar = statusBar;
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
	 * @return true if dialog cancel by user
	 */
	public boolean isCancel() 
	{
		return isCancel;
	}	
}