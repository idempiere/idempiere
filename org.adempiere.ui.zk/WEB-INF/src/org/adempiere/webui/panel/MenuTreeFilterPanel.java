package org.adempiere.webui.panel;

import org.adempiere.webui.util.TreeItemAction;
import org.adempiere.webui.util.TreeUtils;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.EventQueues;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Vbox;

public class MenuTreeFilterPanel extends Popup implements EventListener<Event>, IdSpace {

	private static final long serialVersionUID = 5884898489357885711L;
	
	public static final String MENU_TREE_FILTER_CHECKED_QUEUE = "MENU_TREE_FILTER_CHECKED_QUEUE";
	
	@SuppressWarnings("unused")
	private Tree tree;
	@SuppressWarnings("unused")
	private TreeSearchPanel searchPanel;

	public MenuTreeFilterPanel(Tree tree, TreeSearchPanel panel) {
		super();
		this.tree = tree;
		this.searchPanel = panel;

		Vbox box = new Vbox();

		Checkbox report = new Checkbox();
		report.setImage("/images/mReport.png");
		report.setChecked(true);
		report.setId("report");
		report.addEventListener(Events.ON_CHECK, this);
		box.appendChild(report);

		Checkbox process = new Checkbox();
		process.setImage("/images/mProcess.png");
		process.setChecked(true);
		process.setId("process");
		process.addEventListener(Events.ON_CHECK, this);
		box.appendChild(process);

		Checkbox workflow = new Checkbox();
		workflow.setImage("/images/mWorkFlow.png");
		workflow.setChecked(true);
		workflow.setId("workflow");
		workflow.addEventListener(Events.ON_CHECK, this);
		box.appendChild(workflow);

		Checkbox window = new Checkbox();
		window.setImage("/images/mWindow.png");
		window.setChecked(true);
		window.setId("window");
		window.addEventListener(Events.ON_CHECK, this);
		box.appendChild(window);

		Checkbox single = new Checkbox();
		single.setLabel(Msg.getMsg(Env.getCtx(), "FlatView"));
		single.setId("flatView");
		single.setChecked(false);
		single.addEventListener(Events.ON_CHECK, this);
		box.appendChild(single);

		appendChild(box);
	}

	public void onEvent(Event event) throws Exception {
		final Checkbox chk = (Checkbox) event.getTarget();
/*		if ("flatView".equals(chk.getId()))
			toggleFlatView(tree, chk);
		else
			toggle(tree, chk);
		if (searchPanel != null)
			searchPanel.refreshSearchList();
		tree.invalidate();
*/		
		EventQueues.lookup(MENU_TREE_FILTER_CHECKED_QUEUE, EventQueues.APPLICATION, true).publish(new Event(Events.ON_CHECK, null, chk));
	}

	public static void toggleFlatView(Tree tree, final Checkbox chk) {
		TreeUtils.traverse(tree, new TreeItemAction() {
			public void run(Treeitem treeItem) {
				if (treeItem.getAttribute("menu.type") == null)
				{
					if (chk.isChecked())
					{
						if (treeItem.getLevel() > 0)
						{
							treeItem.setVisible(false);
						}
					}
					else
					{
						treeItem.setVisible(true);
					}
				}
				else
				{
					if (chk.isChecked())
					{
						if (treeItem.getParentItem() != null && !treeItem.getParentItem().isVisible())
						{
							StringBuilder label = new StringBuilder(treeItem.getLabel());
							treeItem.setAttribute("flatView.label", treeItem.getLabel());
							Treeitem parent = treeItem.getParentItem();
							treeItem.setAttribute("flatView.parent", parent);
							while(parent != null)
							{
								if (parent.isVisible())
								{
									treeItem.detach();
									parent.getTreechildren().appendChild(treeItem);
									break;
								}
								//not working with search
								/*
								String t = parent.getLabel();
								label.insert(0, " > ");
								label.insert(0, t);
								*/
								parent = parent.getParentItem();
							}
							treeItem.setLabel(label.toString());
						}
						else
						{
							Treeitem parent = treeItem.getParentItem();
							if (parent != null)
								parent.getTreechildren().appendChild(treeItem);
						}
					}
					else
					{
						if (treeItem.getAttribute("flatView.parent") != null)
						{
							Treeitem parent = (Treeitem) treeItem.getAttribute("flatView.parent");
							String label = (String) treeItem.getAttribute("flatView.label");
							treeItem.setLabel(label);
							treeItem.detach();
							parent.getTreechildren().appendChild(treeItem);
							treeItem.removeAttribute("flatView.parent");
							treeItem.removeAttribute("flatView.label");
						}
					}
				}
			}
		});
	}

	public static void toggle(Tree tree, final Checkbox chk) {
		TreeUtils.traverse(tree, new TreeItemAction() {
			public void run(Treeitem treeItem) {
				if (treeItem.getAttribute("menu.type") != null)
				{
					String menuType = (String) treeItem.getAttribute("menu.type");
					if (menuType.equals("form"))
						menuType = "window"; // treat forms as windows on filtering the menu
					if (chk.isChecked())
					{
						if (chk.getId().equals(menuType))
						{
							boolean open = false;
							Treeitem parent = treeItem.getParentItem();
							if (parent != null)
								open = parent.isOpen();
							treeItem.setVisible(true);
							if (parent != null)
								parent.setOpen(open);
						}
					}
					else
					{
						if (chk.getId().equals(menuType))
						{
							boolean open = false;
							Treeitem parent = treeItem.getParentItem();
							if (parent != null)
								open = parent.isOpen();
							treeItem.setVisible(false);
							if (parent != null)
								parent.setOpen(open);
						}
					}
				}
			}
		});
	}
}
