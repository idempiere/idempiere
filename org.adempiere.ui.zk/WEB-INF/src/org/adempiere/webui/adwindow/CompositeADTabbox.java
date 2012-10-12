/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.adwindow;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;

import org.adempiere.util.Callback;
import org.adempiere.webui.component.ADTabListModel;
import org.adempiere.webui.component.ADTabListModel.ADTabLabel;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Evaluator;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Vlayout;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @author <a href="mailto:hengsin@gmail.com">Low Heng Sin</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class CompositeADTabbox extends AbstractADTabbox
{
	private static final String ON_SWITCH_VIEW_EVENT = "onSwitchView";

	private static final String ON_ACTIVATE_EVENT = "onActivate";

	public static final String ON_SELECTION_CHANGED_EVENT = "onSelectionChanged";
	
	public static final String ADTAB_INDEX_ATTRIBUTE = "adtab.index";

	/** Logger                  */
    @SuppressWarnings("unused")
	private static CLogger  log = CLogger.getCLogger (CompositeADTabbox.class);

    private List<ADTabListModel.ADTabLabel> tabLabelList = new ArrayList<ADTabListModel.ADTabLabel>();
    
    private List<IADTabpanel> tabPanelList = new ArrayList<IADTabpanel>();

    private Vlayout layout;

	protected DetailPane detailPane;

	private EventListener<Event> selectionListener;

	private IADTabpanel headerTab;
	
	private int selectedIndex = 0;

    public CompositeADTabbox()
    {
    	detailPane = new DetailPane();
    	detailPane.setEventListener(new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				if (DetailPane.ON_EDIT_EVENT.equals(event.getName())) {
					final int row = detailPane.getSelectedADTabpanel() != null 
							? detailPane.getSelectedADTabpanel().getGridTab().getCurrentRow()
							: 0;
					adWindowPanel.saveAndNavigate(new Callback<Boolean>() {
						@Override
						public void onCallback(Boolean result) {
							if (result)
								onEditDetail(row);
						}
					});					
				}
				else if (DetailPane.ON_NEW_EVENT.equals(event.getName())) {
					final int row = detailPane.getSelectedADTabpanel() != null 
							? detailPane.getSelectedADTabpanel().getGridTab().getCurrentRow()
							: 0;
					adWindowPanel.saveAndNavigate(new Callback<Boolean>() {
						@Override
						public void onCallback(Boolean result) {							
							if (result) {
								onEditDetail(row);
								adWindowPanel.onNew();
							}
						}
					});
				}
				else if (DetailPane.ON_DELETE_EVENT.equals(event.getName())) {
					final IADTabpanel tabPanel = detailPane.getSelectedADTabpanel();
					if (tabPanel != null && tabPanel.getGridTab().getRowCount() > 0
						&& tabPanel.getGridTab().getCurrentRow() >= 0) {
						FDialog.ask(tabPanel.getGridTab().getWindowNo(), null, "DeleteRecord?", new Callback<Boolean>() {

							@Override
							public void onCallback(Boolean result) {
								if (!result) return;
								if (!tabPanel.getGridTab().dataDelete()) {
									showLastError();
								} else {
									adWindowPanel.onRefresh(false);
								}
							}
						});
					}
				}
			}			
		});
    }

    protected void onEditDetail(int row) {
		int oldIndex = selectedIndex;
		IADTabpanel selectedPanel = detailPane.getSelectedADTabpanel();
		int newIndex = (Integer)selectedPanel.getAttribute(ADTAB_INDEX_ATTRIBUTE);
		
		Event selectionChanged = new Event(ON_SELECTION_CHANGED_EVENT, layout, new Object[]{oldIndex, newIndex});
		try {
			selectionListener.onEvent(selectionChanged);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		headerTab.setDetailPaneMode(false, true);
		if (headerTab.isGridView()) {
			headerTab.switchRowPresentation();
		}
		headerTab.getGridTab().setCurrentRow(row, true);
	}
    
    protected Component doCreatePart(Component parent)
    {
    	layout = new Vlayout();
    	layout.setHeight("100%");
    	layout.setWidth("100%");
    	layout.setStyle("position: relative");
    	if (parent != null) {
    		layout.setParent(parent);
    	} else {
    		layout.setPage(page);
    	}
    	    	
    	BreadCrumb breadCrumb = getBreadCrumb();
    	breadCrumb.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				int oldIndex = selectedIndex;
				if (event.getTarget() instanceof BreadCrumbLink) {
					BreadCrumbLink link = (BreadCrumbLink) event.getTarget();
					int newIndex = Integer.parseInt(link.getPathId());
					
					Event selectionChanged = new Event(ON_SELECTION_CHANGED_EVENT, layout, new Object[]{oldIndex, newIndex});
					selectionListener.onEvent(selectionChanged);						
				} else if (event.getTarget() instanceof Menuitem) {
					Menuitem item = (Menuitem) event.getTarget();
					int newIndex = Integer.parseInt(item.getValue());
					
					Event selectionChanged = new Event(ON_SELECTION_CHANGED_EVENT, layout, new Object[]{oldIndex, newIndex});
					selectionListener.onEvent(selectionChanged);
				}
			}
		});
    	
    	return layout;
    }

    @Override
	protected void doAddTab(GridTab gTab, IADTabpanel tabPanel) {
    	ADTabListModel.ADTabLabel tabLabel = new ADTabListModel.ADTabLabel(gTab.getName(), gTab.getTabLevel(),gTab.getDescription(),
        		gTab.getWindowNo(),gTab.getAD_Tab_ID());
        tabLabelList.add(tabLabel);
        tabPanelList.add(tabPanel);
        
        tabPanel.setAttribute(ADTAB_INDEX_ATTRIBUTE, tabPanelList.size()-1);
        
        tabPanel.addEventListener(ON_ACTIVATE_EVENT, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Boolean b = (Boolean) event.getData();
				if (b != null && !b.booleanValue())
					return;
				
				IADTabpanel tabPanel = (IADTabpanel) event.getTarget();
				if (tabPanel == headerTab) {
					if (b != null && b.booleanValue()) {
						activateDetailADTabpanel();
					}				
					if (selectedIndex > 0 && tabPanel.isGridView()) {
						tabPanel.switchRowPresentation();
					}
				} else {
					onActivateDetail(tabPanel);
				}
			}
		});
        
        tabPanel.addEventListener(DetailPane.ON_ACTIVATE_DETAIL_EVENT, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				final IADTabpanel tabPanel = (IADTabpanel) event.getTarget();
				int oldIndex = (Integer) event.getData();
				if (oldIndex != detailPane.getSelectedIndex()) {					
					IADTabpanel prevTabPanel = detailPane.getADTabpanel(oldIndex);
					if (prevTabPanel != null && prevTabPanel.getGridTab().needSave(true, true)) {
						final int newIndex = detailPane.getSelectedIndex();
						detailPane.setSelectedIndex(oldIndex);
						adWindowPanel.saveAndNavigate(new Callback<Boolean>() {							
							@Override
							public void onCallback(Boolean result) {
								if (result) {
									detailPane.setSelectedIndex(newIndex);
									onActivateDetail(tabPanel);
								}
							}
						});
					} else {
						onActivateDetail(tabPanel);
					}
				} else {
					onActivateDetail(tabPanel);
				}
			}        	
        });
        
        tabPanel.addEventListener(ON_SWITCH_VIEW_EVENT, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				IADTabpanel tabPanel = (IADTabpanel) event.getTarget();
				if (tabPanel == headerTab) {
					IADTabpanel detailPanel = getSelectedDetailADTabpanel();
					if (detailPanel != null) {
						detailPanel.setDetailPaneMode(true, isUseVflexForDetailPane());
					}
					detailPane.setVflex(Boolean.toString(isUseVflexForDetailPane()));
					layout.invalidate();
				}
			}
		});
        
        tabPanel.addEventListener(ADTabpanel.ON_TOGGLE_EVENT, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				IADTabpanel tabPanel = (IADTabpanel) event.getTarget();
				if (tabPanel == headerTab) {
					adWindowPanel.onToggle();
				} else {
					detailPane.onEdit();
				}
				
			}
		});
        
    	if (layout.getChildren().isEmpty()) {
    		layout.appendChild(tabPanel);
    		headerTab = tabPanel;
    		updateBreadCrumb();
    	} else if (tabLabel.tabLevel <= 1) {
    		boolean activate = false;
    		if (detailPane.getParent() == null) {
    			ADTabpanel adtabpanel = (ADTabpanel) headerTab;
    			adtabpanel.addDetails(detailPane);
    			activate = true;
    		} else
    			tabPanel.setVisible(false);
    		detailPane.setHflex("1");
    		detailPane.setStyle("min-height: 200px; overflow-y: visible;");
    		detailPane.addADTabpanel(tabPanel, tabLabel);
    		tabPanel.setDetailPaneMode(true, isUseVflexForDetailPane());
    		detailPane.setVflex(Boolean.toString(isUseVflexForDetailPane()));
    		if (activate)
    			activateDetailADTabpanel();
    	} else {
    		detailPane.addADTabpanel(tabPanel, tabLabel, false);
    		tabPanel.setDetailPaneMode(true, isUseVflexForDetailPane());
    		detailPane.setVflex(Boolean.toString(isUseVflexForDetailPane()));
    	}
    	HtmlBasedComponent htmlComponent = (HtmlBasedComponent) tabPanel;
        htmlComponent.setVflex("1"); 
        htmlComponent.setWidth("100%");
        
        tabPanel.getGridTab().addDataStatusListener(new SyncDataStatusListener(tabPanel));
        
        if (detailPane.getTabcount() > 1) {
        	int selectedIndex = detailPane.getSelectedIndex();
        	updateTabState();
        	if (detailPane.getSelectedIndex() != selectedIndex) {
        		activateDetailADTabpanel();
        	}
        }
	}

	private void activateDetailADTabpanel() {
    	if (detailPane != null && detailPane.getParent() != null) {
	    	IADTabpanel tabPanel = detailPane.getSelectedADTabpanel();	    	
	    	tabPanel.activate(true);
	    	if (!tabPanel.isGridView()) {
	    		tabPanel.switchRowPresentation();	
	    	}	    		    	
    	}
	}

    @Override
	protected void updateTabState() {
    	if (detailPane != null && detailPane.getTabcount() > 0)
    	{
    		for(int i = 0; i < detailPane.getTabcount(); i++)
    		{
    			IADTabpanel adtab = detailPane.getADTabpanel(i);
    			if (adtab.getDisplayLogic() != null && adtab.getDisplayLogic().trim().length() > 0) {
    				if (!Evaluator.evaluateLogic(headerTab, adtab.getDisplayLogic())) {
    					detailPane.setTabVisibility(i, false);
    				} else {
    					detailPane.setTabVisibility(i, true);
    				}
    			}
    		}
    		int selected = detailPane.getSelectedIndex();
    		if (detailPane.getADTabpanel(selected) == null || !detailPane.isTabVisible(selected)) {
    			for(int i = 0; i < detailPane.getTabcount(); i++) {
    				if (selected == i) continue;
    				if (detailPane.isTabVisible(i)) {
    					detailPane.setSelectedIndex(i);
    					break;
    				}
    			}
    		}
    	}
	}

    /**
     * Return the selected Tab Panel
     */
    public IADTabpanel getSelectedTabpanel()
    {
        return tabPanelList.isEmpty() ? null : tabPanelList.get(selectedIndex);
    }

    public int getSelectedIndex() {
    	return selectedIndex;
    }

	public void setSelectionEventListener(EventListener<Event> listener) {
		selectionListener = listener; 
	}

	@Override
	protected void doTabSelectionChanged(int oldIndex, int newIndex) {
		selectedIndex = newIndex;
		IADTabpanel oldTabpanel = oldIndex >= 0 ? tabPanelList.get(oldIndex) : null;
        IADTabpanel newTabpanel = tabPanelList.get(newIndex);
        if (oldTabpanel != null) {
        	oldTabpanel.setVisible(false);
        }
        newTabpanel.createUI();
        newTabpanel.setVisible(true);

        headerTab = newTabpanel;
        layout.getChildren().clear();
		layout.appendChild(headerTab);
		
		detailPane.detach();
		detailPane.reset();
		
		int currentLevel = headerTab.getTabLevel();
		for (int i = selectedIndex + 1; i< tabPanelList.size(); i++) {
			IADTabpanel tabPanel = tabPanelList.get(i);
			int tabLevel = tabPanel.getTabLevel();
			ADTabListModel.ADTabLabel tabLabel = tabLabelList.get(i);
			if ((tabLevel - currentLevel) == 1 || (tabLevel == 0 && currentLevel == 0)) {
				if (tabPanel.isActive() && !tabPanel.isGridView()) {
	    			tabPanel.switchRowPresentation();
	    		}
				if (tabPanel.getParent() != null) tabPanel.detach();
				detailPane.addADTabpanel(tabPanel, tabLabel);
				tabPanel.setDetailPaneMode(true, isUseVflexForDetailPane());
			} else if (tabLevel > currentLevel ){
	    		detailPane.addADTabpanel(tabPanel, tabLabel, false);
	    		tabPanel.setDetailPaneMode(true, isUseVflexForDetailPane());
	    	}
		}
		
		if (detailPane.getTabcount() > 0 && !headerTab.getGridTab().isSortTab()) {
			ADTabpanel adtabpanel = (ADTabpanel) headerTab;
			adtabpanel.addDetails(detailPane);
			detailPane.setVflex(Boolean.toString(isUseVflexForDetailPane()));
			detailPane.setSelectedIndex(0);
		}
		
        updateBreadCrumb();
	}

	private void updateBreadCrumb() {
		BreadCrumb breadCrumb = getBreadCrumb();
		breadCrumb.reset();
		
		if (selectedIndex > 0) {
			List<ADTabLabel> parents = new ArrayList<ADTabListModel.ADTabLabel>();
			List<Integer> parentIndex = new ArrayList<Integer>();
			int currentLevel = headerTab.getTabLevel();
			for(int i = selectedIndex - 1; i >= 0; i--) {
				ADTabLabel tabLabel = tabLabelList.get(i);
				if (tabLabel.tabLevel == currentLevel-1) {
					parents.add(tabLabel);
					parentIndex.add(i);
					currentLevel = tabLabel.tabLevel;
				}				
			}
			Collections.reverse(parents);
			Collections.reverse(parentIndex);
			for(ADTabLabel tabLabel : parents) {
				int index = parentIndex.remove(0);
				breadCrumb.addPath(tabLabel.label, Integer.toString(index), true);
			}
		}
		ADTabLabel tabLabel = tabLabelList.get(selectedIndex);
		breadCrumb.addPath(tabLabel.label, Integer.toString(selectedIndex), false);				
		breadCrumb.setVisible(true);			
		
		LinkedHashMap<String, String> links = new LinkedHashMap<String, String>();
		int parentIndex = 0;
		if (headerTab.getTabLevel() > 1) {
			for(int i = selectedIndex - 1; i > 0; i--) {
				tabLabel = tabLabelList.get(i);
				if (tabLabel.tabLevel == (headerTab.getTabLevel()-1)) {
					parentIndex = i;
					break;
				}
			}
		}
		for(int i = parentIndex+1; i < tabLabelList.size(); i++) {
			if (i == selectedIndex) continue;
			
			tabLabel = tabLabelList.get(i);
			if (tabLabel.tabLevel == headerTab.getTabLevel()) {
				links.put(Integer.toString(i), tabLabel.label);
			} else if (tabLabel.tabLevel < headerTab.getTabLevel()) {
				break;
			}
		}
		
		if (!links.isEmpty()) {
			breadCrumb.addLinks(links);
		}		
	}

	private BreadCrumb getBreadCrumb() {
		ADWindowContent window = (ADWindowContent) adWindowPanel;
		BreadCrumb breadCrumb = window.getBreadCrumb();
		return breadCrumb;
	}

	public Component getComponent() {
		return layout;
	}

	@Override
	public IADTabpanel findADTabpanel(GridTab gTab) {
		for (IADTabpanel tabpanel : tabPanelList) {
			if (tabpanel.getGridTab() == gTab) {
				return tabpanel;
			}
		}
		return null;
	}

	class SyncDataStatusListener implements DataStatusListener {

		private IADTabpanel tabPanel;

		SyncDataStatusListener(IADTabpanel tabpanel) {
			this.tabPanel = tabpanel;
		}
		
		@Override
		public void dataStatusChanged(DataStatusEvent e) {
			Execution execution = Executions.getCurrent();
			if (execution == null) return;
			
			if (tabPanel == headerTab && detailPane.getPage() != null && e.getChangedColumn() == -1) {
				ArrayList<String> parentColumnNames = new ArrayList<String>();
	        	GridField[] parentFields = headerTab.getGridTab().getFields();
	        	for (GridField parentField : parentFields) {
	        		parentColumnNames.add(parentField.getColumnName());
	        	}
	        	
	        	IADTabpanel detailTab = detailPane.getSelectedADTabpanel();
	        	
	        	//check data action
        		String uuid = (String) execution.getAttribute(CompositeADTabbox.class.getName()+".dataAction");
        		if (uuid != null && uuid.equals(detailTab.getUuid())) {
        			//refresh current row
        			detailTab.getGridTab().dataRefresh(false);
        			//keep focus
        			onDetailRecord();
        			
        			return;	        				
        		}
	        	
        		GridTab tab = detailTab.getGridTab();
        		GridField[] fields = tab.getFields();
        		for (GridField field : fields)
        		{
        			if (!parentColumnNames.contains(field.getColumnName()))
        				Env.setContext(Env.getCtx(), field.getWindowNo(), field.getColumnName(), "");
        		}
        		detailTab.query(false, 0, 0);
        		detailTab.activate(true);
        		detailTab.setDetailPaneMode(true, isUseVflexForDetailPane());
        		detailPane.setVflex(Boolean.toString(isUseVflexForDetailPane()));        		        		
			}
		}
		
	}

	@Override
	public void onDetailRecord() {
		if (detailPane != null && detailPane.getSelectedADTabpanel() != null) {
			try {
				detailPane.onEdit();
			} catch (Exception e) {}
		}
	}

	@Override
	public boolean isSortTab() {
		return headerTab != null ? headerTab.getGridTab().isSortTab() : false;
	}

	@Override
	public IADTabpanel getSelectedDetailADTabpanel() {
		if (detailPane != null && detailPane.getParent() != null) {
			return detailPane.getSelectedADTabpanel();
		}
		return null;
	}
	
	@Override
	public boolean needSave(boolean rowChange, boolean onlyRealChange) {
		boolean b = headerTab.getGridTab().needSave(rowChange, onlyRealChange);
		if (b)
			return b;
		
		IADTabpanel detailPanel = getSelectedDetailADTabpanel();
		if (detailPanel != null) {
			b = detailPanel.getGridTab().needSave(rowChange, onlyRealChange);
		}
		
		return b;
	}

	@Override
	public void dataIgnore() {		
		IADTabpanel detailPanel = getSelectedDetailADTabpanel();
		if (detailPanel != null) {
			detailPanel.getGridTab().dataIgnore();
		}
		headerTab.getGridTab().dataIgnore();
	}

	@Override
	public GridTab getSelectedGridTab() {
		IADTabpanel tabpanel = getSelectedTabpanel();
		return tabpanel == null ? null : tabpanel.getGridTab();
	}

	@Override
	public boolean dataSave(boolean onSaveEvent) {
		IADTabpanel detail = getSelectedDetailADTabpanel();
		if (detail != null && detail.getGridTab().needSave(true, true)) {
			Execution execution = Executions.getCurrent();
			if (execution != null) {
				execution.setAttribute(getClass().getName()+".dataAction", detail.getUuid());
			}
			return detail.getGridTab().dataSave(onSaveEvent);
		}
		return headerTab.getGridTab().dataSave(onSaveEvent);
	}

	@Override
	public void setDetailPaneStatusMessage(String status, boolean error) {
		detailPane.setStatusMessage(status, error);
	}

	@Override
	public IADTabpanel getDirtyADTabpanel() {
		IADTabpanel detail = getSelectedDetailADTabpanel();
		if (detail != null && detail.getGridTab().needSave(true, true)) {
			return detail;
		} else if (detail != null && detail instanceof ADSortTab && ((ADSortTab)detail).isChanged()) {
			return detail;
		} else if (headerTab.getGridTab().needSave(true, true)) {
			return headerTab;
		} else if (headerTab instanceof ADSortTab && ((ADSortTab)headerTab).isChanged()) {
			return headerTab;
		}
		
		return null;
	}

	private void onActivateDetail(IADTabpanel tabPanel) {
		tabPanel.createUI();					
		tabPanel.query(false, 0, 0);
		if (!tabPanel.isVisible())
			tabPanel.setVisible(true);
		if (!tabPanel.isGridView()) {
			tabPanel.switchRowPresentation();	
		}
		tabPanel.setDetailPaneMode(true, isUseVflexForDetailPane());
		detailPane.setVflex(Boolean.toString(isUseVflexForDetailPane()));
		if (tabPanel instanceof ADSortTab) {
			detailPane.invalidate();
			detailPane.updateToolbar(false, true);
			onDetailRecord();
		}
	}
	
	private void showLastError() {
		String msg = CLogger.retrieveErrorString(null);
		if (msg != null)
		{
			detailPane.setStatusMessage(Msg.getMsg(Env.getCtx(), msg), true);
		}
		//other error will be catch in the dataStatusChanged event
	}

	private boolean isUseVflexForDetailPane() {
		return headerTab.isGridView() || ADTabpanel.isUseSplitViewForForm();
	}
	
	@Override
	public void updateDetailPaneToolbar(boolean changed, boolean readOnly) {
		detailPane.updateToolbar(changed, readOnly);
	}

	@Override
	public void setDetailpaneSelection(int tabIndex, int currentRow) {
		if (detailPane.getTabcount() > 0) {
			for(int i = 0; i < detailPane.getTabcount(); i++) {
				IADTabpanel adtab = detailPane.getADTabpanel(i);
				int index = (Integer) adtab.getAttribute(ADTAB_INDEX_ATTRIBUTE);
				if (index == tabIndex) {
					if (!detailPane.isTabVisible(i)) {
						return;
					}
					if (i != detailPane.getSelectedIndex()) {						
						detailPane.setSelectedIndex(i);
						detailPane.fireActivateDetailEvent();
					}
					if (adtab.getGridTab().getCurrentRow() != currentRow)
						adtab.getGridTab().setCurrentRow(currentRow, true);
					break;
				}
			}
		}		
	}	
}
