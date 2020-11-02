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
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;

import org.adempiere.util.Callback;
import org.adempiere.webui.component.ADTabListModel;
import org.adempiere.webui.component.ADTabListModel.ADTabLabel;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MTab;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Evaluator;
import org.compiere.util.Msg;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Center;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Row;
import org.zkoss.zul.RowRenderer;
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
	public static final String AD_TABBOX_ON_EDIT_DETAIL_ATTRIBUTE = "ADTabbox.onEditDetail";

	private static final String ON_POST_TAB_SELECTION_CHANGED_EVENT = "onPostTabSelectionChanged";
	
	private static final String ON_TAB_SELECTION_CHANGED_ECHO_EVENT = "onTabSelectionChangedEcho";

	public static final String ON_SELECTION_CHANGED_EVENT = "onSelectionChanged";
	

    private List<ADTabListModel.ADTabLabel> tabLabelList = new ArrayList<ADTabListModel.ADTabLabel>();
    
    private List<IADTabpanel> tabPanelList = new ArrayList<IADTabpanel>();

    private Vlayout layout;

	private EventListener<Event> selectionListener;

	private IADTabpanel headerTab;
	
	private int selectedIndex = 0;

    public CompositeADTabbox(){    	    	
    }

    protected DetailPane createDetailPane() {
    	DetailPane detailPane = new DetailPane();
    	detailPane.setEventListener(new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				if (DetailPane.ON_EDIT_EVENT.equals(event.getName())) {
					if (headerTab.getGridTab().isNew() && ! headerTab.needSave(true, false)) return;
					
					final int row = getSelectedDetailADTabpanel() != null 
							? getSelectedDetailADTabpanel().getGridTab().getCurrentRow()
							: 0;
					final boolean formView = event.getData() != null ? (Boolean)event.getData() : true;
					if (getSelectedDetailADTabpanel() != null && 
						((getSelectedDetailADTabpanel() == getDirtyADTabpanel()) ||
						(getDirtyADTabpanel() == null && getSelectedDetailADTabpanel().getGridTab().isNew()))) {
						onEditDetail(row, formView);
					} else {												
						adWindowPanel.saveAndNavigate(new Callback<Boolean>() {
							@Override
							public void onCallback(Boolean result) {
								if (result)
									onEditDetail(row, formView);
							}
						});					
					}
				}
				else if (DetailPane.ON_NEW_EVENT.equals(event.getName())) {
					if (headerTab.getGridTab().isNew()) return;
					
					final int row = getSelectedDetailADTabpanel() != null 
							? getSelectedDetailADTabpanel().getGridTab().getCurrentRow()
							: 0;
					adWindowPanel.saveAndNavigate(new Callback<Boolean>() {
						@Override
						public void onCallback(Boolean result) {							
							if (result) {
								if (getSelectedDetailADTabpanel().getGridTab().isSingleRow()) {
									onEditDetail(row, true);
									if (!adWindowPanel.getActiveGridTab().isNew())
										adWindowPanel.onNew();
								} else {
									if (!getSelectedDetailADTabpanel().getGridTab().isNew()) {
										getSelectedDetailADTabpanel().getGridTab().dataNew(false);										
										if (!((ADTabpanel)headerTab).isDetailVisible()) {
											String uuid = headerTab.getDetailPane().getParent().getUuid();
											String vid = getSelectedDetailADTabpanel().getGridView().getUuid();
											String script = "setTimeout(function(){zk('#"+uuid+"').$().setOpen(true);setTimeout(function(){var v=zk('#" + vid
													+ "').$();var e=new zk.Event(v,'onEditCurrentRow',null,{toServer:true});zAu.send(e);},200);},200)";
											Clients.response(new AuScript(script));
										} else {
											getSelectedDetailADTabpanel().getGridView().onEditCurrentRow();
										}
									}
								}
							}
						}
					});
				}
				else if (DetailPane.ON_SAVE_EVENT.equals(event.getName())) {
					if (headerTab.getGridTab().isNew()) return;
					
					final IADTabpanel tabPanel = getSelectedDetailADTabpanel();
					if (!tabPanel.getGridTab().dataSave(true)) {
						showLastError();
					} else {
						tabPanel.getGridTab().dataRefreshAll(true, true);
						tabPanel.getGridTab().refreshParentTabs();
					}
				}
				else if (DetailPane.ON_DELETE_EVENT.equals(event.getName())) {
					onDelete();
				}
				else if (DetailPane.ON_QUICK_FORM_EVENT.equals(event.getName()))
				{
					if (headerTab.getGridTab().isNew() && !headerTab.needSave(true, false))
						return;

					final int row = getSelectedDetailADTabpanel() != null ? getSelectedDetailADTabpanel().getGridTab().getCurrentRow() : 0;
					final boolean formView = event.getData() != null ? (Boolean) event.getData() : true;

					adWindowPanel.saveAndNavigate(new Callback <Boolean>() {
						@Override
						public void onCallback(Boolean result)
						{
							if (result)
							{
								onEditDetail(row, formView);
								adWindowPanel.onQuickForm();
							}
						}
					});
				}
			}

			private void onDelete() {
				if (headerTab.getGridTab().isNew()) return;
				
				final IADTabpanel tabPanel = getSelectedDetailADTabpanel();
				if (tabPanel != null && tabPanel.getGridTab().getSelection().length > 0) {
					onDeleteSelected(tabPanel);
				}
				else if (tabPanel != null && tabPanel.getGridTab().getRowCount() > 0
					&& tabPanel.getGridTab().getCurrentRow() >= 0) {
					FDialog.ask(tabPanel.getGridTab().getWindowNo(), null, "DeleteRecord?", new Callback<Boolean>() {

						@Override
						public void onCallback(Boolean result) {
							if (!result) return;
							if (!tabPanel.getGridTab().dataDelete()) {
								showLastError();
							} else {
								adWindowPanel.onRefresh(true);
							}
						}
					});
				}
			}

			private void onDeleteSelected(final IADTabpanel tabPanel) {
				if (tabPanel == null || tabPanel.getGridTab() == null) return;
				
				final int[] indices = tabPanel.getGridTab().getSelection();
				if(indices.length > 0) {
					StringBuilder sb = new StringBuilder();
					sb.append(Env.getContext(Env.getCtx(), tabPanel.getGridTab().getWindowNo(), "_WinInfo_WindowName", false)).append(" - ")
						.append(indices.length).append(" ").append(Msg.getMsg(Env.getCtx(), "Selected"));
					FDialog.ask(sb.toString(), tabPanel.getGridTab().getWindowNo(), null,"DeleteSelection", new Callback<Boolean>() {
						@Override
						public void onCallback(Boolean result) {
							if(result){
								tabPanel.getGridTab().clearSelection();						
								Arrays.sort(indices);
								int offset = 0;
								int count = 0;
								for (int i = 0; i < indices.length; i++)
								{
									tabPanel.getGridTab().navigate(indices[i]-offset);
									if (tabPanel.getGridTab().dataDelete())
									{
										offset++;
										count++;
									}
								}
								
								adWindowPanel.onRefresh(true);
								adWindowPanel.getStatusBar().setStatusLine(Msg.getMsg(Env.getCtx(), "Deleted")+": "+count, false);
							}
						}
					});
				}
			}			
		});
    	
    	return detailPane;
    }
    
    protected void onEditDetail(int row, boolean formView) {
    	
		int oldIndex = selectedIndex;
		IADTabpanel selectedPanel = getSelectedDetailADTabpanel();
		if (selectedPanel == null) return;
		int newIndex = selectedPanel.getTabNo();
		selectedPanel.query();
		
		Executions.getCurrent().setAttribute(AD_TABBOX_ON_EDIT_DETAIL_ATTRIBUTE, selectedPanel);
		Event selectionChanged = new Event(ON_SELECTION_CHANGED_EVENT, layout, new Object[]{oldIndex, newIndex});
		try {
			selectionListener.onEvent(selectionChanged);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		headerTab.setDetailPaneMode(false);
		if (formView && headerTab.isGridView()) {
			headerTab.switchRowPresentation();
		}
		
		if (!headerTab.getGridTab().isSortTab())
			headerTab.getGridTab().setCurrentRow(row, true);
		
		if (headerTab.isGridView()) {
			if (headerTab.getGridTab().isNew() || headerTab.needSave(true, false)) {
				headerTab.getGridView().onEditCurrentRow();
			}
		} else {
			((HtmlBasedComponent)headerTab).focus();
		}
	}
    
    protected Component doCreatePart(Component parent)
    {
    	layout = new Vlayout();
    	ZKUpdateUtil.setHeight(layout, "100%");
    	ZKUpdateUtil.setWidth(layout, "100%");
    	layout.setStyle("position: relative");
    	if (parent != null) {
    		layout.setParent(parent);
    	} else {
    		layout.setPage(page);
    	}
    	
    	layout.addEventListener(ON_POST_TAB_SELECTION_CHANGED_EVENT, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				onPostTabSelectionChanged((Boolean)event.getData());
			}
		});
    	
    	layout.addEventListener(ON_TAB_SELECTION_CHANGED_ECHO_EVENT, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				onTabSelectionChangedEcho((Boolean)event.getData());
			}
		});
    	    	
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
        
        tabPanel.setTabNo(tabPanelList.size()-1);
        
        tabPanel.addEventListener(ADTabpanel.ON_ACTIVATE_EVENT, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Boolean b = (Boolean) event.getData();
				if (b != null && !b.booleanValue())
					return;
				
				IADTabpanel tabPanel = (IADTabpanel) event.getTarget();
				if (tabPanel != headerTab && headerTab.getDetailPane() != null) {
					if (b != null && b.booleanValue()) {
						onActivateDetail(tabPanel);
					}
				}
			}
		});
        
        tabPanel.addEventListener(DetailPane.ON_ACTIVATE_DETAIL_EVENT, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				final IADTabpanel tabPanel = (IADTabpanel) event.getTarget();
				int oldIndex = (Integer) event.getData();
				if (oldIndex != headerTab.getDetailPane().getSelectedIndex()) {					
					IADTabpanel prevTabPanel = headerTab.getDetailPane().getADTabpanel(oldIndex);
					if (prevTabPanel != null && prevTabPanel.needSave(true, true)) {
						final int newIndex = headerTab.getDetailPane().getSelectedIndex();
						headerTab.getDetailPane().setSelectedIndex(oldIndex);
						adWindowPanel.saveAndNavigate(new Callback<Boolean>() {							
							@Override
							public void onCallback(Boolean result) {
								if (result) {
									headerTab.getDetailPane().setSelectedIndex(newIndex);
									tabPanel.activate(true);
								}
							}
						});
					} else {
						headerTab.getDetailPane().setSelectedIndex(headerTab.getDetailPane().getSelectedIndex());
						tabPanel.activate(true);
					}
				} else {
					tabPanel.activate(true);
				}
			}        	
        });
        
        tabPanel.addEventListener(ADTabpanel.ON_SWITCH_VIEW_EVENT, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				IADTabpanel tabPanel = (IADTabpanel) event.getTarget();
				if (tabPanel == headerTab) {
					IADTabpanel detailPanel = getSelectedDetailADTabpanel();
					if (detailPanel != null) {
						detailPanel.setDetailPaneMode(true);
					}
					if (headerTab.getDetailPane() != null)
						headerTab.getDetailPane().setVflex("true");
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
					headerTab.getDetailPane().onEdit(true);
				}
				
			}
		});
        
        if (tabPanel.getGridView() != null) {
	        tabPanel.getGridView().addEventListener(DetailPane.ON_EDIT_EVENT, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					GridView gridView = (GridView) event.getTarget();
					if (!gridView.isDetailPaneMode()) {
						adWindowPanel.onToggle();
					}
				}				
			});
        }
        
    	if (layout.getChildren().isEmpty()) {
    		layout.appendChild(tabPanel);
    		headerTab = tabPanel;    		
    	} else if (tabLabel.tabLevel == 1) {
    		if (headerTab.getDetailPane() == null) {
    			headerTab.setDetailPane(createDetailPane());
    		} else
    			tabPanel.setVisible(false);
    		ZKUpdateUtil.setHflex(headerTab.getDetailPane(), "1");
    		headerTab.getDetailPane().addADTabpanel(tabPanel, tabLabel);
    		tabPanel.setDetailPaneMode(true);
    		headerTab.getDetailPane().setVflex("true");
    	} else if (tabLabel.tabLevel > 1){
    		headerTab.getDetailPane().addADTabpanel(tabPanel, tabLabel, false);
    		tabPanel.setDetailPaneMode(true);
    		headerTab.getDetailPane().setVflex("true");
    	}
    	HtmlBasedComponent htmlComponent = (HtmlBasedComponent) tabPanel;
    	ZKUpdateUtil.setVflex(htmlComponent, "1"); 
    	ZKUpdateUtil.setWidth(htmlComponent, "100%");
        
        tabPanel.getGridTab().addDataStatusListener(new SyncDataStatusListener(tabPanel));        
	}

	@Override
	public boolean updateSelectedIndex(int oldIndex, int newIndex) {
		boolean b = super.updateSelectedIndex(oldIndex, newIndex);
		if (b) {
			BreadCrumb breadcrumb = getBreadCrumb();
			if (breadcrumb.isEmpty()) {
				updateBreadCrumb();
			}
		}
		return b;
	}

	private void activateDetailIfVisible() {
    	if (headerTab instanceof ADTabpanel) {
	    	((ADTabpanel)headerTab).activateDetailIfVisible();
    	}
	}

    @Override
	protected void updateTabState() {
    	if (isDetailPaneLoaded())
    	{
    		boolean hasChanges = false;
    		for(int i = 0; i < headerTab.getDetailPane().getTabcount(); i++)
    		{
    			IADTabpanel adtab = headerTab.getDetailPane().getADTabpanel(i);
    			if (adtab.getDisplayLogic() != null && adtab.getDisplayLogic().trim().length() > 0) {
    				boolean visible = Evaluator.evaluateLogic(headerTab, adtab.getDisplayLogic()); 
    				if (headerTab.getDetailPane().isTabVisible(i) != visible) {    					
    					headerTab.getDetailPane().setTabVisibility(i, visible);
    					hasChanges = true;
    				}
    			}
    		}
    		int selected = headerTab.getDetailPane().getSelectedIndex();
    		if (headerTab.getDetailPane().getADTabpanel(selected) == null || !headerTab.getDetailPane().isTabVisible(selected)) {
    			for(int i = 0; i < headerTab.getDetailPane().getTabcount(); i++) {
    				if (selected == i) continue;
    				if (headerTab.getDetailPane().isTabVisible(i)) {
    					headerTab.getDetailPane().setSelectedIndex(i);
    					if (headerTab instanceof ADTabpanel) {
    						((ADTabpanel) headerTab).activateDetailIfVisible();
    					}
    					break;
    				}
    			}
    			hasChanges = true;
    		}
    		if (hasChanges) {
    			headerTab.getDetailPane().getParent().invalidate();
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
		
		//set state
		headerTab.setDetailPaneMode(false);
		getBreadCrumb().getFirstChild().setVisible(false);
		
		Events.sendEvent(new Event(ON_POST_TAB_SELECTION_CHANGED_EVENT, layout, oldIndex > newIndex));
	}

	private void onPostTabSelectionChanged(Boolean back) {
		if (headerTab instanceof ADTabpanel && !headerTab.getGridTab().isSortTab()) {			 			
			List<Object[]> list = new ArrayList<Object[]>();
			int tabIndex = -1;
			int currentLevel = headerTab.getTabLevel();
			for (int i = selectedIndex + 1; i< tabPanelList.size(); i++) {
				IADTabpanel tabPanel = tabPanelList.get(i);				
				int tabLevel = tabPanel.getTabLevel();
				ADTabListModel.ADTabLabel tabLabel = tabLabelList.get(i);
				if ((tabLevel - currentLevel) == 1) {
					tabIndex++;
					Object[] value = new Object[]{tabIndex, tabPanel, tabLabel, Boolean.TRUE};
					list.add(value);
				} else if (tabLevel > currentLevel ){
					tabIndex++;
					Object[] value = new Object[]{tabIndex, tabPanel, tabLabel, Boolean.FALSE};
					list.add(value);
		    	} else {
		    		break;
		    	}
			}
			
			if (!list.isEmpty()) {
				DetailPane detailPane = headerTab.getDetailPane();
				if (detailPane == null) {
					detailPane = createDetailPane();					
				}
				detailPane.setAttribute("detailpane.tablist", list);
				
				ZKUpdateUtil.setVflex(detailPane, "true");
				if (headerTab.getDetailPane() == null) {
					headerTab.setDetailPane(detailPane);
				} 
			}						
		}	
		Events.echoEvent(new Event(ON_TAB_SELECTION_CHANGED_ECHO_EVENT, layout, back));
	}
	
	private void onTabSelectionChangedEcho(Boolean back) {
		if (headerTab instanceof ADTabpanel) {
			DetailPane detailPane = headerTab.getDetailPane();
			
			if (detailPane != null) {
				@SuppressWarnings("unchecked")
				List<Object[]> list = (List<Object[]>) detailPane.removeAttribute("detailpane.tablist");
				if (list != null && !list.isEmpty()) {
					int currentLevel = headerTab.getTabLevel();
					for (Object[] value : list) {
						int tabIndex = (Integer) value[0];
						IADTabpanel tabPanel = (IADTabpanel) value[1];
						ADTabLabel tabLabel = (ADTabLabel) value[2] ;
						Boolean enable = (Boolean) value[3];
						
						int tabLevel = tabPanel.getTabLevel();
						if ((tabLevel - currentLevel) == 1 || (tabLevel == 0 && currentLevel == 0)) {
							if (tabPanel.isActivated() && !tabPanel.isGridView()) {
				    			tabPanel.switchRowPresentation();
				    		}
							if (tabPanel.getParent() != null) tabPanel.detach();
						}
						tabPanel.setDetailPaneMode(true);
						detailPane.setADTabpanel(tabIndex, tabPanel, tabLabel, enable.booleanValue());
					}
					if (back == null || !back.booleanValue()) {
						detailPane.setSelectedIndex(0);
						activateDetailIfVisible();
					} else {
						if (((ADTabpanel) headerTab).isDetailVisible() && detailPane.getSelectedADTabpanel() != null) {
							IADTabpanel selectDetailPanel = detailPane.getSelectedADTabpanel();
							if (!selectDetailPanel.isVisible()) {							
								selectDetailPanel.setVisible(true);
							}
							if (!selectDetailPanel.isGridView()) {
								selectDetailPanel.switchRowPresentation();	
							}
							if (selectDetailPanel instanceof ADTabpanel)
							{
								((ADTabpanel)selectDetailPanel).activated = true;
								String msg = ((ADTabpanel)selectDetailPanel).getGridTab().getRowCount() + " " + Msg.getMsg(Env.getCtx(), "Records");
								setDetailPaneStatusMessage(msg, false);
							}

							if (selectDetailPanel.getGridTab().isTreeTab()) {
								if (selectDetailPanel.getGridTab().getTreeDisplayedOn().equals(MTab.TREEDISPLAYEDON_MasterTab))
									selectDetailPanel.getTreePanel().getParent().setVisible(false);
								else
									selectDetailPanel.getTreePanel().getParent().setVisible(true);
							}
						}
					}
				}				
			}
		}
		updateBreadCrumb();
        getBreadCrumb().getFirstChild().setVisible(true);
        
        updateTabState();
        
        ADWindow adwindow = ADWindow.findADWindow(layout);
        if (adwindow != null) {
        	adwindow.getADWindowContent().getToolbar().enableTabNavigation(getBreadCrumb().hasParentLink(), 
        			headerTab.getDetailPane() != null && headerTab.getDetailPane().getTabcount() > 0);
        }
        
        //indicator and row highlight lost after navigate back from child to parent
        if (back != null && back.booleanValue()) {
        	if (headerTab.isGridView()) {
        		RowRenderer<Object[]> renderer = headerTab.getGridView().getListbox().getRowRenderer();
        		GridTabRowRenderer gtr = (GridTabRowRenderer)renderer;
        		Row row = gtr.getCurrentRow();
        		if (row != null)	
        			gtr.setCurrentRow(row);
        	}
        }
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
		if (headerTab.getTabLevel() == 0)
		{
			for(int i = 0; i < tabLabelList.size(); i++) {
				if (i == selectedIndex) continue;
				tabLabel = tabLabelList.get(i);
				if (tabLabel.tabLevel == headerTab.getTabLevel()) {
					IADTabpanel adtab = tabPanelList.get(i);
	    			if (adtab.getDisplayLogic() != null && adtab.getDisplayLogic().trim().length() > 0) {
	    				if (!Evaluator.evaluateLogic(headerTab, adtab.getDisplayLogic())) {
	    					continue;
	    				}
	    			}
					links.put(Integer.toString(i), tabLabel.label);
				} 
			}
		}
		else
		{
			for(int i = parentIndex+1; i < tabLabelList.size(); i++) {
				if (i == selectedIndex) continue;
				
				tabLabel = tabLabelList.get(i);
				if (tabLabel.tabLevel == headerTab.getTabLevel()) {
					IADTabpanel adtab = tabPanelList.get(i);
	    			if (adtab.getDisplayLogic() != null && adtab.getDisplayLogic().trim().length() > 0) {
	    				if (!Evaluator.evaluateLogic(headerTab, adtab.getDisplayLogic())) {
	    					continue;
	    				}
	    			}
					links.put(Integer.toString(i), tabLabel.label);
				} else if (tabLabel.tabLevel < headerTab.getTabLevel()) {
					break;
				}
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
			
			if (tabPanel == headerTab && e.getChangedColumn() == -1
				&& isDetailActivated()) {
				ArrayList<String> parentColumnNames = new ArrayList<String>();
	        	GridField[] parentFields = headerTab.getGridTab().getFields();
	        	for (GridField parentField : parentFields) {
	        		parentColumnNames.add(parentField.getColumnName());
	        	}
	        	
	        	IADTabpanel detailTab = getSelectedDetailADTabpanel();
	        	if (detailTab != null) {
		        	//check data action
	        		String uuid = (String) execution.getAttribute(CompositeADTabbox.class.getName()+".dataAction");
	        		if (uuid != null && uuid.equals(detailTab.getUuid()) && detailTab.getGridTab().isCurrent()) {
	        			//refresh current row
	        			detailTab.getGridTab().dataRefresh(false);
	        			//keep focus
	        			Clients.scrollIntoView(detailTab);
	        			
	        			return;	        				
	        		}
		        	
	        		GridTab tab = detailTab.getGridTab();
	        		GridField[] fields = tab.getFields();
	        		for (GridField field : fields)
	        		{
	        			if (!parentColumnNames.contains(field.getColumnName()))
	        				Env.setContext(Env.getCtx(), field.getWindowNo(), field.getColumnName(), "");
	        		}
	        		detailTab.activate(true);
	        		detailTab.setDetailPaneMode(true);	        		    
	        	}
	        	headerTab.getDetailPane().setVflex("true");
			}
		}
		
	}

	@Override
	public void onDetailRecord() {
		if (headerTab.getDetailPane() != null && getSelectedDetailADTabpanel() != null) {
			try {
				if (!getSelectedDetailADTabpanel().isActivated()) {
					onActivateDetail(getSelectedDetailADTabpanel());
				}
				headerTab.getDetailPane().onEdit(getSelectedDetailADTabpanel().getGridTab().isSingleRow());
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	}

	public boolean isDetailActivated() {
		if (headerTab instanceof ADTabpanel) {
			ADTabpanel atp = (ADTabpanel) headerTab;
			return atp.hasDetailTabs() && getSelectedDetailADTabpanel() != null && 
					getSelectedDetailADTabpanel().isActivated();
		}
		return false;
	}

	@Override
	public boolean isSortTab() {
		return headerTab != null ? headerTab.getGridTab().isSortTab() : false;
	}

	@Override
	public IADTabpanel getSelectedDetailADTabpanel() {
		if (headerTab instanceof ADTabpanel && ((ADTabpanel)headerTab).hasDetailTabs()) {
			return headerTab.getDetailPane().getSelectedADTabpanel();
		}
		return null;
	}
	
	@Override
	public boolean needSave(boolean rowChange, boolean onlyRealChange) {
		boolean b = headerTab.needSave(rowChange, onlyRealChange);
		if (b)
			return b;
		
		IADTabpanel detailPanel = getSelectedDetailADTabpanel();
		if (detailPanel != null) {
			b = detailPanel.needSave(rowChange, onlyRealChange);
		}
		
		return b;
	}

	@Override
	public void dataIgnore() {		
		IADTabpanel detailPanel = getSelectedDetailADTabpanel();
		if (detailPanel != null) {
			if (detailPanel instanceof ADSortTab) {
				detailPanel.refresh();
				if (((ADSortTab) detailPanel).isChanged()) {
					((ADSortTab) detailPanel).setIsChanged(false);
				}
			} else {
				detailPanel.getGridTab().dataIgnore();
			}
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
		if (detail != null && detail.needSave(true, true)) {
			Execution execution = Executions.getCurrent();
			if (execution != null) {
				execution.setAttribute(getClass().getName()+".dataAction", detail.getUuid());
			}
			return detail.dataSave(onSaveEvent);
		}
		return headerTab.dataSave(onSaveEvent);
	}

	@Override
	public void setDetailPaneStatusMessage(String status, boolean error) {
		headerTab.getDetailPane().setStatusMessage(status, error);
	}

	@Override
	public IADTabpanel getDirtyADTabpanel() {
		IADTabpanel detail = getSelectedDetailADTabpanel();
		if (detail != null && detail.needSave(true, true)) {
			return detail;
		} else if (headerTab.needSave(true, true)) {
			return headerTab;
		}
		
		return null;
	}

	private void onActivateDetail(IADTabpanel tabPanel) {
		tabPanel.createUI();			
		if (headerTab.getGridTab().isNew()) {
			tabPanel.resetDetailForNewParentRecord();
		} else {
			//maintain detail row position if possible 
			int currentRow = -1;
			if (!tabPanel.getGridTab().isSortTab()) {
				currentRow = tabPanel.getGridTab().getCurrentRow();
			}
			tabPanel.query(false, 0, 0);			
			if (currentRow >= 0 && currentRow != tabPanel.getGridTab().getCurrentRow() 
				&& currentRow < tabPanel.getGridTab().getRowCount()) {
				tabPanel.getGridTab().setCurrentRow(currentRow, false);
			}			
		}
		if (!tabPanel.isVisible()) {
			tabPanel.setVisible(true);
			if (tabPanel.getDesktop() != null) {
				Executions.schedule(tabPanel.getDesktop(), e -> {
					invalidateTabPanel(tabPanel);
				}, new Event("onPostActivateDetail", tabPanel));
			} else {
				invalidateTabPanel(tabPanel);
			}
		} else {
			invalidateTabPanel(tabPanel);
		}
		boolean wasForm = false;
		if (!tabPanel.isGridView()) {
			tabPanel.switchRowPresentation(); // required to avoid NPE on GridTabRowRenderer.getCurrentRow below
			wasForm = true;
		}
		tabPanel.setDetailPaneMode(true);
		headerTab.getDetailPane().setVflex("true");
		if (tabPanel instanceof ADSortTab) {
			headerTab.getDetailPane().updateToolbar(false, true);
		} else {
			tabPanel.dynamicDisplay(0);
			RowRenderer<Object[]> renderer = tabPanel.getGridView().getListbox().getRowRenderer();
			GridTabRowRenderer gtr = (GridTabRowRenderer)renderer;
			Row row = gtr.getCurrentRow();
			if (row != null)	
				gtr.setCurrentRow(row);
		}
		if (wasForm && tabPanel.getTabLevel() == 0 && headerTab.getTabLevel() != 0) // maintain form on header when zooming to a detail tab
			tabPanel.switchRowPresentation();
	}

	private void invalidateTabPanel(IADTabpanel tabPanel) {
		Center center = findCenter(tabPanel.getGridView());
		if (center != null)
			center.invalidate();
		else
			tabPanel.invalidate();
	}
	
	private Center findCenter(GridView gridView) {
		if (gridView == null)
			return null;
		Component p = gridView.getParent();
		while (p != null) {
			if (p instanceof Center)
				return (Center)p;
			p = p.getParent();
		}
		return null;
	}

	private void showLastError() {
		String msg = CLogger.retrieveErrorString(null);
		if (msg != null)
		{
			headerTab.getDetailPane().setStatusMessage(Msg.getMsg(Env.getCtx(), msg), true);
		}
		//other error will be catch in the dataStatusChanged event
	}

	@Override
	public void updateDetailPaneToolbar(boolean changed, boolean readOnly) {
		if (headerTab.getGridTab().isNew() || headerTab.getGridTab().getRowCount() == 0)
			headerTab.getDetailPane().disableToolbar();		
		else
			headerTab.getDetailPane().updateToolbar(changed, readOnly);
	}

	@Override
	public boolean isDetailPaneLoaded() {
		if (headerTab.getDetailPane() == null || headerTab.getDetailPane().getTabcount() == 0)
			return false;
		for(int i = 0; i < headerTab.getDetailPane().getTabcount(); i++) {
			if (headerTab.getDetailPane().getADTabpanel(i) == null)
				return false;
		}
		return true;
	}
	
	@Override
	public void setDetailPaneSelectedTab(int adTabNo, int currentRow) {
		if (headerTab instanceof ADTabpanel && ((ADTabpanel) headerTab).hasDetailTabs()) {
			for(int i = 0; i < headerTab.getDetailPane().getTabcount(); i++) {
				IADTabpanel adtab = headerTab.getDetailPane().getADTabpanel(i);
				if (adtab == null) continue;
				int tabNo = adtab.getTabNo();
				if (tabNo == adTabNo) {
					if (!headerTab.getDetailPane().isTabVisible(i) || !headerTab.getDetailPane().isTabEnabled(i)) {
						return;
					}
					if (i != headerTab.getDetailPane().getSelectedIndex()) {						
						headerTab.getDetailPane().setSelectedIndex(i);
						headerTab.getDetailPane().fireActivateDetailEvent();
					}
					if (adtab.getGridTab().getCurrentRow() != currentRow)
						adtab.getGridTab().setCurrentRow(currentRow, true);
					break;
				}
			}
		}		
	}	
}
