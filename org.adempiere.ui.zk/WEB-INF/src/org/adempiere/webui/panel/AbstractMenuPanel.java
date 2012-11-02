/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

package org.adempiere.webui.panel;

import static org.compiere.model.SystemIDs.TREE_MENUPRIMARY;

import java.util.Collection;
import java.util.Enumeration;
import java.util.Properties;

import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.GridTab;
import org.compiere.model.MMenu;
import org.compiere.model.MQuery;
import org.compiere.model.MTree;
import org.compiere.model.MTreeNode;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.EventQueues;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treecell;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treecol;
import org.zkoss.zul.Treecols;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;

/**
 * Menu Panel Base
 * @author Elaine
 * @date July 31, 2012
 */
public abstract class AbstractMenuPanel extends Panel implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6160708371157917922L;
	
	public static final String MENU_ITEM_SELECTED_QUEUE = "MENU_ITEM_SELECTED_QUEUE";
	
	private Properties ctx;
    private Tree menuTree;
    
    public AbstractMenuPanel(Component parent)
    {
    	if (parent != null)
    		this.setParent(parent);
        init();
        
    	EventQueues.lookup(MENU_ITEM_SELECTED_QUEUE, EventQueues.APPLICATION, true).subscribe(new EventListener<Event>() {
			public void onEvent(Event event) throws Exception {
				if (event.getName() == Events.ON_SELECT)
				{
					Treeitem selectedItem = (Treeitem) event.getData();
				    	
					if (selectedItem != null)
					{
						Object value = selectedItem.getValue();
						if (value != null)
						{
							if (menuTree.getSelectedItem() != null && menuTree.getSelectedItem().getValue() != null && menuTree.getSelectedItem().getValue().equals(value))
								return;
							
							Collection<Treeitem> items = menuTree.getItems();
							for (Treeitem item : items)
							{
								if (item != null && item.getValue() != null && item.getValue().equals(value))
								{
									TreeSearchPanel.select(item);
									return;
								}
							}
						}
						else
						{
							String label = selectedItem.getLabel();
							if (menuTree.getSelectedItem() != null && menuTree.getSelectedItem().getLabel() != null && menuTree.getSelectedItem().getLabel().equals(label))
								return;
							
							Collection<Treeitem> items = menuTree.getItems();
							for (Treeitem item : items)
							{
								if (item != null && item.getLabel() != null && item.getLabel().equals(label))
								{
									TreeSearchPanel.select(item);								
									return;
								}
							}
						}
					}
				}
			}
		});
    }
    
    protected void init() {
		ctx = Env.getCtx();
        int adRoleId = Env.getAD_Role_ID(ctx);
        int adTreeId = getTreeId(ctx, adRoleId);
        MTree mTree = new MTree(ctx, adTreeId, false, true, null);        
        MTreeNode rootNode = mTree.getRoot();
        initComponents();
        initMenu(rootNode);
    }
    
    protected void initComponents()
    {
    	this.setSclass("menu-panel");
    	this.setVflex("1");
    	
        menuTree = new Tree();
        menuTree.setMultiple(false);
        menuTree.setId("mnuMain");
        menuTree.setVflex("1");
        menuTree.setSizedByContent(false);
        menuTree.setPageSize(-1); // Due to bug in the new paging functionality        
    }
    
    private void initMenu(MTreeNode rootNode)
    {
        Treecols treeCols = new Treecols();
        Treecol treeCol = new Treecol();
        
        Treechildren rootTreeChildren = new Treechildren();        
        
        treeCols.appendChild(treeCol);
        menuTree.appendChild(treeCols);
        menuTree.appendChild(rootTreeChildren);
        
        generateMenu(rootTreeChildren, rootNode);
    }
    
    private int getTreeId(Properties ctx, int adRoleId)
    {
        int AD_Tree_ID = DB.getSQLValue(null,
                "SELECT COALESCE(r.AD_Tree_Menu_ID, ci.AD_Tree_Menu_ID)" 
                + "FROM AD_ClientInfo ci" 
                + " INNER JOIN AD_Role r ON (ci.AD_Client_ID=r.AD_Client_ID) "
                + "WHERE AD_Role_ID=?", adRoleId);
        if (AD_Tree_ID <= 0)
            AD_Tree_ID = TREE_MENUPRIMARY;    //  Menu
        return AD_Tree_ID;
    }
    
    private void generateMenu(Treechildren treeChildren, MTreeNode mNode)
    {
        Enumeration<?> nodeEnum = mNode.children();
      
        while(nodeEnum.hasMoreElements())
        {
            MTreeNode mChildNode = (MTreeNode)nodeEnum.nextElement();
            Treeitem treeitem = new Treeitem();
            treeChildren.appendChild(treeitem);
            treeitem.setTooltiptext(mChildNode.getDescription());            
            
            if(mChildNode.getChildCount() != 0)
            {
                treeitem.setOpen(false);
                treeitem.setLabel(mChildNode.getName());
                Treecell cell = (Treecell)treeitem.getTreerow().getFirstChild();
                cell.setSclass("menu-treecell-cnt");
                Treechildren treeItemChildren = new Treechildren();
                treeitem.appendChild(treeItemChildren);
                generateMenu(treeItemChildren, mChildNode);
                if (treeItemChildren.getChildren().size() == 0)
                {
                	treeItemChildren.detach();
                }
                
                treeitem.getTreerow().addEventListener(Events.ON_CLICK, this);
            }
            else
            {
                treeitem.setValue(String.valueOf(mChildNode.getNode_ID()));
                Treerow treeRow = new Treerow();
                treeitem.appendChild(treeRow);
                Treecell treeCell = new Treecell();
                treeCell.setSclass("menu-treecell-cnt");
                treeRow.appendChild(treeCell);
                A link = new A();
                treeCell.appendChild(link);
                
                if (mChildNode.isReport())
                {
                	link.setImage("/images/mReport.png");
                	treeitem.setAttribute("menu.type", "report");
                }
                else if (mChildNode.isProcess() || mChildNode.isTask())
                {
                	link.setImage("/images/mProcess.png");
                	treeitem.setAttribute("menu.type", "process");
                }
                else if (mChildNode.isWorkFlow())
                {
                	link.setImage("/images/mWorkFlow.png");
                	treeitem.setAttribute("menu.type", "workflow");
                }
                else if (mChildNode.isForm())
                {
                	link.setImage("/images/mWindow.png");
                	treeitem.setAttribute("menu.type", "form");
                }
                else // Window
                {
                	link.setImage("/images/mWindow.png");
                	treeitem.setAttribute("menu.type", "window");

                	Toolbarbutton newBtn = new Toolbarbutton(null, "/images/New10.png");
                	newBtn.setStyle("padding-left:3px; margin-bottom:5px");
                	treeCell.appendChild(newBtn);
                	newBtn.addEventListener(Events.ON_CLICK, this);
                }
                link.setLabel(mChildNode.getName());
                
                link.addEventListener(Events.ON_CLICK, this);
                link.setSclass("menu-href");
                
                treeitem.getTreerow().setDraggable("favourite"); // Elaine 2008/07/24
            }
        }
    }
    
    public void onEvent(Event event)
    {
        Component comp = event.getTarget();
        String eventName = event.getName();
        if (eventName.equals(Events.ON_CLICK))
        {
        	doOnClick(comp);
        }
    }
    
    private void doOnClick(Component comp) {
    	boolean newRecord = false;
		if (comp instanceof A) {
			comp = comp.getParent().getParent();
		}
		if (comp instanceof Toolbarbutton) {
			comp = comp.getParent().getParent();
			newRecord = true;
		}
		if (comp instanceof Treerow) 
		{
			Treeitem selectedItem = (Treeitem) comp.getParent();
		    if(selectedItem.getValue() != null)
		    {
		    	if (newRecord)
		    	{
		    		onNewRecord(selectedItem);
		    	}
		    	else
		    	{
		    		fireMenuSelectedEvent(selectedItem);
		    	}
		    }
		    else
		    	selectedItem.setOpen(!selectedItem.isOpen());
		    selectedItem.setSelected(true);
	        EventQueues.lookup(MENU_ITEM_SELECTED_QUEUE, EventQueues.APPLICATION, true).publish(new Event(Events.ON_SELECT, null, selectedItem));
		}
	}
    
    private void onNewRecord(Treeitem selectedItem) {
    	try
        {
			int menuId = Integer.parseInt((String)selectedItem.getValue());
			MMenu menu = new MMenu(Env.getCtx(), menuId, null);
			
    		MQuery query = new MQuery("");
    		query.addRestriction("1=2");
			query.setRecordCount(0);

			if (getParent() instanceof Popup) {
				((Popup)getParent()).close();
			}
			
			ADWindow frame = SessionManager.getAppDesktop().openWindow(menu.getAD_Window_ID(), query);
			if(frame == null)
				return;
    					
			GridTab tab = frame.getADWindowContent().getActiveGridTab();
			tab.dataNew(false);
        }
        catch (Exception e)
        {
            throw new ApplicationException(e.getMessage(), e);
        }
		
	}

	protected void fireMenuSelectedEvent(Treeitem selectedItem) {
    	int nodeId = Integer.parseInt((String)selectedItem.getValue());
       
    	try
        {
    		if (getParent() instanceof Popup) {
				((Popup)getParent()).close();
			}
    		SessionManager.getAppDesktop().onMenuSelected(nodeId);
        }
        catch (Exception e)
        {
            throw new ApplicationException(e.getMessage(), e);
        }		
	}

	public Tree getMenuTree() 
	{
		return menuTree;
	}
	
	public Properties getCtx()
	{
		return ctx;
	}
}
