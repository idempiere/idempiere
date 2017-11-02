/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation
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
package org.adempiere.webui.dashboard;

import java.util.ArrayList;
import java.util.List;

import org.adempiere.util.Callback;
import org.adempiere.webui.adwindow.ADTabpanel;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.desktop.FavouriteController;
import org.adempiere.webui.exception.ApplicationException;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ITheme;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MMenu;
import org.compiere.model.MQuery;
import org.compiere.model.MTreeNode;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Image;
import org.zkoss.zul.Label;
import org.zkoss.zul.Layout;
import org.zkoss.zul.Panel;
import org.zkoss.zul.Panelchildren;
import org.zkoss.zul.Toolbar;
import org.zkoss.zul.Toolbarbutton;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;
import org.zkoss.zul.Vlayout;

/**
 * Dashboard item: User favourites
 * @author Elaine
 * @date November 20, 2008
 */
public class DPFavourites extends DashboardPanel implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8398216266900311289L;

	private static final String NODE_ID_ATTR = "Node_ID";


	public static final String FAVOURITE_DROPPABLE = "favourite";

	public static final String DELETE_FAV_DROPPABLE = "deleteFav";

	private Layout bxFav;
	
	private Label lblMsg;
	
	private List<A> links = new ArrayList<>();

	private boolean inCallingController;
	
	public DPFavourites()
	{
		super();
		
		Panel panel = new Panel();
		this.appendChild(panel);
		
		Panelchildren favContent = new Panelchildren();
		panel.appendChild(favContent);
		bxFav = new Vlayout();
		this.setSclass("favourites-box");
		favContent.appendChild(bxFav);
		createFavouritesPanel();
		
		Toolbar favToolbar = new Toolbar();
		this.appendChild(favToolbar);
		
		// Elaine 2008/07/24
		if (ThemeManager.isUseFontIconForImage())
		{
			Label deleteLabel = new Label();
			favToolbar.appendChild(deleteLabel);
			deleteLabel.setSclass("z-icon-Trash trash-font-icon");
			deleteLabel.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Delete")));
			deleteLabel.setDroppable(DELETE_FAV_DROPPABLE);		
			deleteLabel.addEventListener(Events.ON_DROP, this);
		}
		else
		{
			Image img = new Image(ThemeManager.getThemeResource("images/Delete24.png"));
			favToolbar.appendChild(img);
			img.setStyle("text-align: right; width:24px; height:24px;");
			img.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Delete")));
			img.setDroppable(DELETE_FAV_DROPPABLE);		
			img.addEventListener(Events.ON_DROP, this);		
		}
		//
        
        favContent.setDroppable(FAVOURITE_DROPPABLE); 
        favContent.addEventListener(Events.ON_DROP, this);
	}
	
	private void createFavouritesPanel()
	{
		FavouriteController controller = FavouriteController.getInstance(Executions.getCurrent().getSession());
		List<MTreeNode> favorites = controller.getFavourites();
		for (MTreeNode nd : favorites)
		{
			addNode(nd);
		}
				
		lblMsg = new Label(Msg.getMsg(Env.getCtx(), "DropMenuItemHere")); 
		if(bxFav.getChildren().isEmpty()) bxFav.appendChild(lblMsg);
		
		controller.addInsertedCallback(t -> onInsertedCallback(t));
		controller.addDeletedCallback(t -> onDeletedCallback(t));
	}

	private void addNode(MTreeNode nd) {
		addNode(nd.getNode_ID(), nd.toString().trim(), nd.getDescription(), getIconFile(nd), (nd.isWindow() && !nd.isForm()));
	}

	private void onDeletedCallback(Integer nodeId) {
		if (inCallingController) return;
		for (A link : links) {
			String id = (String) link.getAttribute(NODE_ID_ATTR);
			if (id.equals(nodeId.toString())) {
				removeLinkFromUI(link);
				break;
			}
		}
	}

	private void onInsertedCallback(MTreeNode node) {
		if (inCallingController) return;
		for (A link : links) {
			String id = (String) link.getAttribute(NODE_ID_ATTR);
			if (id.equals(String.valueOf(node.getNode_ID()))) {
				return;
			}
		}
		addNode(node);
	}

	protected void addNode(int nodeId, String label, String description, String imageSrc, boolean addNewBtn) {
		Hlayout hbox = new Hlayout();
		hbox.setSclass("favourites-item");
		hbox.setSpacing("0px");
		hbox.setValign("middle");
		bxFav.appendChild(hbox);
		
		A btnFavItem = new A();
		btnFavItem.setAttribute(NODE_ID_ATTR, String.valueOf(nodeId));
		hbox.appendChild(btnFavItem);
		btnFavItem.setLabel(label);
		btnFavItem.setTooltiptext(description);
		if (ThemeManager.isUseFontIconForImage())
			btnFavItem.setIconSclass(imageSrc);
		else if (imageSrc.startsWith(ITheme.THEME_PATH_PREFIX))
			btnFavItem.setImage(imageSrc);
		else			
			btnFavItem.setImage(ThemeManager.getThemeResource(imageSrc));
		btnFavItem.setDraggable(DELETE_FAV_DROPPABLE);
		btnFavItem.addEventListener(Events.ON_CLICK, this);
		btnFavItem.addEventListener(Events.ON_DROP, this);
		btnFavItem.setSclass("menu-href");
									
		if (addNewBtn)
		{
			Toolbarbutton newBtn = new Toolbarbutton(null, ThemeManager.getThemeResource("images/New16.png"));
			if (ThemeManager.isUseFontIconForImage())
			{
				newBtn.setImage(null);
				newBtn.setIconSclass("z-icon-New");
			}
			newBtn.setAttribute(NODE_ID_ATTR, String.valueOf(nodeId));
			hbox.appendChild(newBtn);
			newBtn.addEventListener(Events.ON_CLICK, this);
			newBtn.setSclass("fav-new-btn");
			newBtn.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "New")));
		}
		links.add(btnFavItem);
	}
	
    public void onEvent(Event event)
    {
        Component comp = event.getTarget();
        String eventName = event.getName();
        
        if(eventName.equals(Events.ON_CLICK))
        {
            doOnClick(comp);
        }
        // Elaine 2008/07/24
        else if(eventName.equals(Events.ON_DROP))
        {
        	DropEvent de = (DropEvent) event;
    		Component dragged = de.getDragged();
        	
        	if(comp instanceof Panelchildren)
        	{
        		if(dragged instanceof Treerow)
        		{
        			Treerow treerow = (Treerow) dragged;
        			Treeitem treeitem = (Treeitem) treerow.getParent();
        			
        			addItem(treeitem);
        		}
        	}
        	else if(comp instanceof Image || comp instanceof Label)
        	{
        		if(dragged instanceof A)
        		{
        			A btn = (A) dragged;
        			removeLink(btn);
        		}
        	}
        }
        //
	}

	private void doOnClick(Component comp) {
		if(comp instanceof A)
		{
			A btn = (A) comp;
			
			int menuId = 0;
			try
			{
				menuId = Integer.valueOf((String)btn.getAttribute(NODE_ID_ATTR));            		
			}
			catch (Exception e) {
				
			}
			
			if(menuId > 0) SessionManager.getAppDesktop().onMenuSelected(menuId);
		}
		else if (comp instanceof Toolbarbutton) {
			Toolbarbutton btn = (Toolbarbutton) comp;
			
			int menuId = 0;
			try
			{
				menuId = Integer.valueOf((String)btn.getAttribute(NODE_ID_ATTR));            		
			}
			catch (Exception e) {
				
			}
			
			if(menuId > 0)
			{
				try
	            {
					MMenu menu = new MMenu(Env.getCtx(), menuId, null);
					
		    		MQuery query = new MQuery("");
	        		query.addRestriction("1=2");
					query.setRecordCount(0);

					SessionManager.getAppDesktop().openWindow(menu.getAD_Window_ID(), query, new Callback<ADWindow>() {
						
						@Override
						public void onCallback(ADWindow result) {
							if(result == null)
			    				return;
			        		
							result.getADWindowContent().onNew();
							ADTabpanel adtabpanel = (ADTabpanel) result.getADWindowContent().getADTab().getSelectedTabpanel();
							adtabpanel.focusToFirstEditor(false);
						}
					});					
	            }
	            catch (Exception e)
	            {
	                throw new ApplicationException(e.getMessage(), e);
	            }
			}
		}
	}

	private void removeLink(A btn) {
		String value = (String) btn.getAttribute(NODE_ID_ATTR);
		
		if(value != null)
		{
			int Node_ID = Integer.valueOf(value.toString());
			FavouriteController controller = FavouriteController.getInstance(Executions.getCurrent().getSession());
			inCallingController = true;
			if(controller.removeNode(Node_ID))
			{
				removeLinkFromUI(btn);
			}
			inCallingController = false;
		}
	}

	private void removeLinkFromUI(A btn) {
		if (btn.getParent() instanceof Hlayout)
			bxFav.removeChild(btn.getParent());
		
		if(bxFav.getChildren().isEmpty())
			bxFav.appendChild(lblMsg);
		
		bxFav.invalidate();
		links.remove(btn);
	}

    /**
     * Add menu treeitem into the user favorite panel
     * @param treeitem
     */
	public void addItem(Treeitem treeitem) {
		Object value = treeitem.getValue();
		if(value != null)
		{
			int Node_ID = Integer.valueOf(value.toString());
			FavouriteController controller = FavouriteController.getInstance(Executions.getCurrent().getSession());
			inCallingController = true;
			if(controller.addNode(Node_ID))
			{				
				String menuType = (String) treeitem.getAttribute("menu.type");
				boolean isWindow = menuType != null && menuType.equals("window");
				
				String label = null;
				String image = null;
				if (treeitem.getLabel() != null && treeitem.getLabel().trim().length() > 0)
				{
					label = treeitem.getLabel().trim();
					image = treeitem.getImage();
				}
				else
				{
					A link = (A) treeitem.getTreerow().getFirstChild().getFirstChild();
					label = link.getLabel();
					if (ThemeManager.isUseFontIconForImage() && link.getIconSclass() != null)
						image = link.getIconSclass();
					else
						image = link.getImage();
				}
				
				addNode(Node_ID, label, treeitem.getTooltiptext(), image, isWindow);								
			} else {
				FDialog.error(0, this, "BookmarkExist", null);					
			}
			inCallingController = false;
		}
	}
	
	private String getIconFile(MTreeNode mt) {
		if (ThemeManager.isUseFontIconForImage()) {
			return getIconSclass(mt);
		}
		if (mt.isWindow())
			return "images/mWindow.png";
		if (mt.isReport())
			return "images/mReport.png";
		if (mt.isProcess() || mt.isTask())
			return "images/mProcess.png";
		if (mt.isWorkFlow())
			return "images/mWorkFlow.png";
		if (mt.isForm())
			return "images/mForm.png";
		if (mt.isInfo())
			return "images/mInfo.png";
		return "images/mWindow.png";
	}

	private String getIconSclass(MTreeNode mt) {
		if (mt.isWindow())
			return "z-icon-Window";
		if (mt.isReport())
			return "z-icon-Report";
		if (mt.isProcess() || mt.isTask())
			return "z-icon-Task";
		if (mt.isWorkFlow())
			return "z-icon-WorkFlow";
		if (mt.isForm())
			return "z-icon-Form";
		if (mt.isInfo())
			return "z-icon-Info";
		return "z-icon-Window";
	}
}
